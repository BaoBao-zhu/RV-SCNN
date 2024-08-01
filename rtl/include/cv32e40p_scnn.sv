import cv32e40p_pkg::*;
//(*DONT_TOUCH = "TRUE"*) 
module cv32e40p_scnn
(
	input logic						 clk,
	input logic						 rst_n,
	input logic						 enable_i,        

	input logic [MAC_OP_WIDTH-1:0]   operator_i, //operator
	input logic [31:0]				 operand1_i,      
	input logic [31:0]				 operand2_i,
	input logic				         ex_ready_i, //from ex-stage

	input logic [31:0]				 scnn_data_cnt_i, //count of the data_in
	input logic [31:0]				 mem_rdata,     //read
	output logic [31:0]				 mem_wdata,     //write
	output logic					 scnn_ready_o,       //ready for scnn
	output logic [1:0]				 scnn_flag,     //control data

	//test_scnn_gemm
	output logic 					 gemm_wb_active_o,
	output logic					 gemm_wb_finish_o,
	output logic 					 gemm4x4_active_o,
	output logic [15:0]              K_cs,
	output logic [15:0] 			 K_num,          //store the K dimension of matrix
	output logic [15:0]              M,
	output logic [15:0]              N,
	//test_scnn_gemm

	//test_scnn_mp
	output logic 					 mp_ri_active_o, //maxpooling read in
	output logic					 mp_wb_active_o, //maxpooling write back
	//test_scnn_mp

	//test_data_type
	input logic                      data_load_type_i,
	output logic                     im2col_active_o,
	output logic                     data_type_o,
	//test_data_type

	output logic [31:0]              result_o
);

//gemm4x4 condition
enum logic [3:0] {
	IDLE_GEMM,
	GET_DATA,    //get matrix
	CAL,         //product 16 partial result and add
	CNN_CAL,     //if cnn, add 8 partial sum to the output
    SNN_CAL_01,  //use for snn to cal the sum of T8
	SNN_CAL_02,  //use for snn to cal the sum of T8
	SNN_CAL_03,  //use for snn to cal the sum of T8
	SNN_CAL_04,  //use for snn to cal the sum of T8
	SNN_CAL_05,  //use for snn to cal the sum of T8
	SNN_CAL_06,  //use for snn to cal the sum of T8
	SNN_CAL_07,  //use for snn to cal the sum of T8
	FINISH_GEMM  //use for snn to cal the sum of T8
} gemm4x4_cs,gemm4x4_ns;

//gemm write back condition
enum logic {
	IDLE_GEMM_WB,
	GEMM_WDATA
} gemm_wb_cs,gemm_wb_ns;

//Maxpooling read in condition
enum logic {
	IDLE_MP_RI,
	MP_RDATA
} mp_ri_cs,mp_ri_ns;

//Maxpooling write back condition
enum logic {
	IDLE_MP_WB,
	MP_WDATA
} mp_wb_cs,mp_wb_ns;

//use to control the GEMM calculate
logic gemm4x4_ready;
logic gemm4x4_active;

//use to control write back GEMM
logic gemm_wb_flag;
logic gemm_wb_ready;

//use to control read Maxpooling
logic mp_ri_active;
logic mp_ri_ready;

//use to control write back Maxpooling
logic mp_wb_ready;
logic mp_wb_flag;
logic mp_wb_active;

///////////////////////////////////////////////////////////////
//control data in 
logic gemm_data_flag;
logic mp_data_flag;

//flag: use to control the scnn-gemm data in and out
assign gemm_wb_flag = (operator_i == WB_GEMM_OP) && enable_i;
assign gemm_data_flag = (operator_i == GEMM4x4_OP) && enable_i;
assign gemm_wb_finish_o = gemm_wb_cs ^ gemm_wb_active_o;

//flag: use to control the scnn-maxpool data in and out
assign mp_data_flag = (operator_i == MP_RI_OP) && enable_i;
assign mp_wb_flag = (operator_i == MP_WB_OP) && enable_i;

//scnn_flag_control
assign scnn_flag = {gemm_data_flag|mp_data_flag,gemm_wb_flag|mp_wb_flag}; //data control
assign scnn_ready_o = gemm4x4_ready & gemm_wb_ready & mp_ri_ready; //ready //no need the mp_wb_ready(1 cycle)
/////////////////////////////////////////////////////////////////////////////////////////////
//load data type
logic data_type;
assign data_type_o = data_type;
//snn input T
logic [3:0] snn_T; //will be used later
//snn_bias, for a 4x4 tile need 4 bias 
logic signed [15:0] bias [3:0];
logic data_load_type_i_d; //control the input data(2 or 4)

//im2col control
logic im2col_get_data; //get data from memory
logic im2col_active; // high is use //im2col is a 9 gemm
assign im2col_active_o = im2col_active;//connect
always_ff @( posedge clk,negedge rst_n)
begin
	if (~rst_n)begin
		data_type <= 1'b0;
	end
	else begin
		if(operator_i == INT_TYPE && enable_i) begin
			data_type <= operand1_i[0]; //0 is cnn,1 is snn
			im2col_active <= operand1_i[4]; // 1 is use im2col 

			case(operand1_i[3:1])
				1:bias[0] <= operand2_i[15:0];
				2:bias[1] <= operand2_i[15:0];
				3:bias[2] <= operand2_i[15:0];
				4:bias[3] <= operand2_i[15:0];
				default: ;
			endcase
		end
		else begin
		end
		data_load_type_i_d <= data_load_type_i;
	end
end

/////////////////////////////////////////////////////////////////////////////////////////////
//gemm4x4 load MNK and load Vth and shiftnum(use for snn)
logic signed [15:0] Vth;
logic [1:0] shiftnum;
always_ff @( posedge clk,negedge rst_n)
begin
	if (~rst_n)begin
		K_num <= '0;
		M <= '0;
		N <= '0;
		shiftnum <= '0;
	end
	else begin
		if(operator_i == GEMM_L_OP && enable_i) begin
			Vth <= operand1_i[31:18];
			shiftnum <= operand1_i[17:16];
			K_num <= operand1_i[15:0];
			M <= operand2_i[31:16];
			N <= operand2_i[15:0];
		end
	end
end
/////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////
//gemm4x4
logic gemm4x4_get_data;
//data in buffer
logic signed [7:0] A [3:0]; //filter
logic        [7:0] B [3:0]; //input      //noneed the signed, cause was used by bit
//mid data buffer of bit result
logic signed [15:0] M_Cache[7:0][15:0];  //use as register to store the mid result
//final CNN output
logic signed [31:0] M_cnn_Cache [15:0];  //use as register to store the CNN output 
//final SNN output
logic        [7:0]  M_snn_Cache [15:0];  //use as register to store the SNN output


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//wire output of M_Cache
logic signed [15:0] M_Cache_r [7:0][15:0];
cv32e40p_scnn_mul scnn_mul(
	.filter_i(A),
	.input_i (B),
	.M_Cache_i(M_Cache),
	.M_Cache_o(M_Cache_r)
);
//wire output of cnn_Cache
logic cnn_add_enable;
logic signed [31:0] M_cnn_Cache_r [15:0];
cv32e40p_cnn_add cnn_add(
	.mode_i(cnn_add_enable),
	.M_Cache_i(M_Cache),
	.M_cnn_Cache_o(M_cnn_Cache_r)
);

//wire output of snn_LIF
logic snn_LIF_enable;
logic signed [15:0] M_snn_LIF_r [7:0][15:0];
cv32e40p_snn_LIF snn_LIF(
	.enable_i(snn_LIF_enable),
	.shift_i(shiftnum),
	.M_Cache_i(M_Cache),
	.M_Cache_o(M_snn_LIF_r)
);
////////////////////////////////////////////////////////////////////////////////////////////////////////////

assign gemm4x4_active_o = gemm4x4_active;//connect
//getdata ready
logic get_data_ready;
//cnt
logic [3:0] A_data_cnt; 
logic [15:0] im2col_K_cs;
//im2col reuse the datapath of gemm
logic signed [7:0] con_data [15:0];
integer i,j;
always_ff @(posedge clk,negedge rst_n) begin
	if (~rst_n)begin
		gemm4x4_cs <= IDLE_GEMM;
		//data_init
		A_data_cnt <= '0; 
		K_cs <= '0;
		im2col_K_cs <= '0;
		cnn_add_enable <= '0;
		snn_LIF_enable <= '0;
		for(i=0;i<16;i=i+1) begin
			for(int j=0;j<8;j=j+1) begin
				M_Cache[j][i] <= bias[i/4];
			end
		end
		M_cnn_Cache <= '{default:0};
		M_snn_Cache <= '{default:0};
	end
	else begin
		case(gemm4x4_cs)
			IDLE_GEMM:begin //IDLE->DATA_A
				if(operator_i == GEMM4x4_OP && enable_i) begin
					//next_state
					gemm4x4_cs <= GET_DATA;
					//data_init
					K_cs <= '0;
					im2col_K_cs <= '0;
					cnn_add_enable <= '0;
					snn_LIF_enable <= '0;
					for(i=0;i<16;i=i+1) begin
						for(int j=0;j<8;j=j+1) begin
							M_Cache[j][i] <= bias[i/4];
						end
					end
					M_cnn_Cache <= '{default:0};
					M_snn_Cache <= '{default:0};

				end
			end
			GET_DATA:begin  //GET DATA_A
				if((K_cs==0) & (~im2col_active)) begin
					gemm4x4_cs <= CAL;
				end
				else if(get_data_ready) begin
					im2col_K_cs <= '0;
					//next_state
					gemm4x4_cs <= CAL;
				end
				else begin
					
				end
			end
			CAL: begin
				M_Cache<=M_Cache_r;

				if(im2col_active) begin
					if(im2col_K_cs==8) begin
						if((K_cs+1)==K_num) begin
							if(~data_type) begin 
								gemm4x4_cs <= CNN_CAL;
								cnn_add_enable <= 1'b1;
							end
							else begin
								gemm4x4_cs <= SNN_CAL_01;
								snn_LIF_enable <= 1'b1;
							end
						end
						else begin
							gemm4x4_cs <= GET_DATA;
							K_cs <= K_cs + 1;
						end
					end
					else begin
						im2col_K_cs <= im2col_K_cs + 1;
					end
				end
				else begin
					if(K_cs==K_num) begin
						if(~data_type) begin
							gemm4x4_cs <= CNN_CAL;
							cnn_add_enable <= 1'b1;
						end
						else begin
							gemm4x4_cs <= SNN_CAL_01;
							snn_LIF_enable <= 1'b1;
						end
					end
					else begin
						gemm4x4_cs <= GET_DATA;
						K_cs <= K_cs + 1;
					end
				end
			end
			CNN_CAL: begin
				gemm4x4_cs <= FINISH_GEMM;

				M_cnn_Cache <= M_cnn_Cache_r;
			end
			SNN_CAL_01: begin
				gemm4x4_cs <= SNN_CAL_02;
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[0][i] > Vth) begin
						M_snn_Cache[i][0] <= 1'b1;
					end
					else begin
						M_Cache[1][i] <= (M_snn_LIF_r[0][i]) + (M_Cache[1][i]);
						M_snn_Cache[i][0] <= 1'b0;
					end
				end
			end
			SNN_CAL_02: begin
				gemm4x4_cs <= SNN_CAL_03;
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[1][i] > Vth) begin
						M_snn_Cache[i][1] <= 1'b1;
					end
					else begin
						M_Cache[2][i] <= (M_snn_LIF_r[1][i]) + (M_Cache[2][i]);
						M_snn_Cache[i][1] <= 1'b0;
					end
				end
			end
			SNN_CAL_03: begin 
				gemm4x4_cs <= SNN_CAL_04;
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[2][i] > Vth) begin
						M_snn_Cache[i][2] <= 1'b1;
					end
					else begin
						M_Cache[3][i] <= (M_snn_LIF_r[2][i]) + (M_Cache[3][i]);
						M_snn_Cache[i][2] <= 1'b0;
					end
				end
			end
			SNN_CAL_04: begin
				gemm4x4_cs <= SNN_CAL_05;
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[3][i] > Vth) begin
						M_snn_Cache[i][3] <= 1'b1;
					end
					else begin
						M_Cache[4][i] <= (M_snn_LIF_r[3][i]) + (M_Cache[4][i]);
						M_snn_Cache[i][3] <= 1'b0;
					end
				end
			end
			SNN_CAL_05: begin
				gemm4x4_cs <= SNN_CAL_06;
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[4][i] > Vth) begin
						M_snn_Cache[i][4] <= 1'b1;
					end
					else begin
						M_Cache[5][i] <= (M_snn_LIF_r[4][i]) + (M_Cache[5][i]);
						M_snn_Cache[i][4] <= 1'b0;
					end
				end
			end        
			SNN_CAL_06: begin
				gemm4x4_cs <= SNN_CAL_07; 
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[5][i] > Vth) begin
						M_snn_Cache[i][5] <= 1'b1;
					end
					else begin
						M_Cache[6][i] <= (M_snn_LIF_r[5][i]) + (M_Cache[6][i]);
						M_snn_Cache[i][5] <= 1'b0;
					end
				end
			end
			SNN_CAL_07: begin
				gemm4x4_cs <= FINISH_GEMM; 
				for(i=0; i<16; i=i+1)begin
					if(M_Cache[6][i] > Vth) begin
						M_snn_Cache[i][6] <= 1'b1;
					end
					else begin
						M_Cache[7][i] <= (M_snn_LIF_r[6][i]) + (M_Cache[7][i]);
						M_snn_Cache[i][6] <= 1'b0;
					end
				end
			end
			FINISH_GEMM: begin
				if(ex_ready_i)
					gemm4x4_cs <= IDLE_GEMM; 

				if(data_type) begin
					for(i=0; i<16; i=i+1)begin
						if(M_Cache[7][i] > Vth) begin
							M_snn_Cache[i][7] <= 1'b1;
						end
						else begin
							M_snn_Cache[i][7] <= 1'b0;
						end
					end
				end
			end
			default:;
		endcase
	end
end
    
always_comb begin
	gemm4x4_ready = 1'b1;
	gemm4x4_active = 1'b0;
	gemm4x4_get_data = 1'b0;
	case (gemm4x4_cs)
		IDLE_GEMM: begin
			gemm4x4_ready = 1'b1;
			gemm4x4_active = 1'b0;
			gemm4x4_get_data = 1'b0;
		end

		GET_DATA, CAL: begin
			gemm4x4_ready = 1'b0;
			gemm4x4_active = 1'b1;
			gemm4x4_get_data = 1'b1;
		end

		CNN_CAL, SNN_CAL_01, SNN_CAL_02, SNN_CAL_03, SNN_CAL_04, SNN_CAL_05, SNN_CAL_06, SNN_CAL_07: begin
			gemm4x4_ready = 1'b0;
			gemm4x4_active = 1'b1;
			gemm4x4_get_data = 1'b0;
		end

		FINISH_GEMM: begin
			gemm4x4_ready = 1'b1;
			gemm4x4_active = 1'b0;
			gemm4x4_get_data = 1'b0;
		end
	endcase
end

/////////////////////////////////////////////////////////////////////////////////////////////
//maxpool
logic mp_get_data;//control to get data from mem_rdata
logic signed [7:0] MP_Cache[15:0]; //maxpool read data in
logic signed [7:0] MP_o[3:0]; //store the output of maxpool
logic signed [31:0] MP_cnn_o[3:0]; //store the output of maxpoll of CNN Array
logic signed [7:0] MP_r[3:0]; //wire for mp
logic signed [31:0] MP_cnn_r[3:0]; //store the array maxpool output

assign mp_ri_active_o = mp_ri_active;//connect
assign mp_wb_active_o = mp_wb_active;//connect
//Maxpooling state
always_ff @( posedge clk,negedge rst_n)
begin
	if (~rst_n)begin
		mp_ri_cs <= IDLE_MP_RI;
	end
	else if(operator_i == MAX_POOL_OP)begin
		mp_ri_cs <= mp_ri_ns;
		MP_o <= MP_r;
		MP_cnn_o <= MP_cnn_r;
	end
	else begin
	end
end

//readin
always_comb begin
	mp_ri_ready = 1'b0;
	mp_ri_ns = mp_ri_cs;
	mp_ri_active = 1'b0;

	case(mp_ri_cs)
		IDLE_MP_RI:begin
			mp_ri_ready = 1'b1;
			mp_ri_active = 1'b0;
			mp_get_data = 1'b0;
			if(operator_i == MP_RI_OP && enable_i) begin
				mp_ri_ns = MP_RDATA;
			end
		end
		MP_RDATA:begin
			mp_ri_ready = 1'b0;
			mp_ri_active = 1'b1;
			mp_get_data = 1'b1;
			if (scnn_data_cnt_i < 4) begin 
				mp_ri_ns = MP_RDATA;
			end
			else begin
				mp_ri_ready = 1'b1;
				mp_ri_active = 1'b0;
				mp_ri_ns = IDLE_MP_RI;
			end
		end
	endcase
end

//maxpool for different model
always_comb begin
	if (operator_i == MAX_POOL_OP && enable_i)begin
		case(operand1_i)
			0:begin //cnn maxpool, 16 x int8 from mp_ri
				if (M_cnn_Cache[0] < MP_Cache[1]) 
					MP_r[0] = MP_Cache[1];
				else
					MP_r[0] = MP_Cache[0];
				if (MP_r[0] < MP_Cache[4])
					MP_r[0] = MP_Cache[4];
				if (MP_r[0] < MP_Cache[5])
					MP_r[0] = MP_Cache[5];
				///////////////////////////////////////////
				if (MP_Cache[2] < MP_Cache[3]) 
					MP_r[1] = MP_Cache[3];
				else
					MP_r[1] = MP_Cache[2];
				if (MP_r[1] < MP_Cache[6])
					MP_r[1] = MP_Cache[6];
				if (MP_r[1] < MP_Cache[7])
					MP_r[1] = MP_Cache[7];
				///////////////////////////////////////////
				if (MP_Cache[8] < MP_Cache[9]) 
					MP_r[2] = MP_Cache[9];
				else
					MP_r[2] = MP_Cache[8];
				if (MP_r[2] < MP_Cache[12])
					MP_r[2] = MP_Cache[12];
				if (MP_r[2] < MP_Cache[13])
					MP_r[2] = MP_Cache[13];
				///////////////////////////////////////////
			    if (MP_Cache[10] < MP_Cache[11]) 
					MP_r[3] = MP_Cache[11];
				else
					MP_r[3] = MP_Cache[10];
				if (MP_r[3] < MP_Cache[14])
					MP_r[3] = MP_Cache[14];
				if (MP_r[3] < MP_Cache[15])
					MP_r[3] = MP_Cache[15];
			end
			1:begin //snn maxpool, 16x int8 from mp_ri
				MP_r[0] = MP_Cache[0] | MP_Cache[1] | MP_Cache[4] | MP_Cache[5];
				MP_r[1] = MP_Cache[2] | MP_Cache[3] | MP_Cache[6] | MP_Cache[7];
				MP_r[2] = MP_Cache[8] | MP_Cache[9] | MP_Cache[12] | MP_Cache[13];
				MP_r[3] = MP_Cache[10] | MP_Cache[11] | MP_Cache[14] | MP_Cache[15];
			end
			2:begin //fuse cnn maxpool
				if (M_cnn_Cache[0] < M_cnn_Cache[1]) 
					MP_cnn_r[0] = M_cnn_Cache[1];
				else
					MP_cnn_r[0] = M_cnn_Cache[0];
				if (MP_cnn_r[0] < M_cnn_Cache[2])
					MP_cnn_r[0] = M_cnn_Cache[2];
				if (MP_cnn_r[0] < M_cnn_Cache[3])
					MP_cnn_r[0] = M_cnn_Cache[3];
				///////////////////////////////////////////
				if (M_cnn_Cache[4] < M_cnn_Cache[5]) 
					MP_cnn_r[1] = M_cnn_Cache[5];
				else
					MP_cnn_r[1] = M_cnn_Cache[4];
				if (MP_cnn_r[1] < M_cnn_Cache[6])
					MP_cnn_r[1] = M_cnn_Cache[6];
				if (MP_cnn_r[1] < M_cnn_Cache[7])
					MP_cnn_r[1] = M_cnn_Cache[7];
				///////////////////////////////////////////
				if (M_cnn_Cache[8] < M_cnn_Cache[9]) 
					MP_cnn_r[2] = M_cnn_Cache[9];
				else
					MP_cnn_r[2] = M_cnn_Cache[8];
				if (MP_cnn_r[2] < M_cnn_Cache[10])
					MP_cnn_r[2] = M_cnn_Cache[10];
				if (MP_cnn_r[2] < M_cnn_Cache[11])
					MP_cnn_r[2] = M_cnn_Cache[11];
				///////////////////////////////////////////
			    if (M_cnn_Cache[12] < M_cnn_Cache[13]) 
					MP_cnn_r[3] = M_cnn_Cache[13];
				else
					MP_cnn_r[3] = M_cnn_Cache[12];
				if (MP_cnn_r[3] < M_cnn_Cache[14])
					MP_cnn_r[3] = M_cnn_Cache[14];
				if (MP_cnn_r[3] < M_cnn_Cache[15])
					MP_cnn_r[3] = M_cnn_Cache[15];

			end
			3:begin //fuse snn maxpool
				MP_r[0] = (M_snn_Cache[3] | M_snn_Cache[2]| M_snn_Cache[1] | M_snn_Cache[0]);
				MP_r[1] = (M_snn_Cache[7] | M_snn_Cache[6]| M_snn_Cache[5] | M_snn_Cache[4]);
				MP_r[2] = (M_snn_Cache[11] | M_snn_Cache[10]| M_snn_Cache[9] | M_snn_Cache[8]);
				MP_r[3] = (M_snn_Cache[15] | M_snn_Cache[14]| M_snn_Cache[13] | M_snn_Cache[12]);
			end
			default:;
		endcase
	end
	else begin

	end
end

/////////////////////////////////////////////////////////////////////////////////////////////
//write back the matrix WBGEMM and maxpool

always_ff @(posedge clk, negedge rst_n) begin 
	if (~rst_n) begin
		gemm_wb_cs <= IDLE_GEMM_WB;
		mp_wb_cs <= IDLE_MP_WB;
	end
	else begin
		gemm_wb_cs	<= gemm_wb_ns;
		mp_wb_cs <= mp_wb_ns;
	end
end

always_comb begin
	gemm_wb_ready = 1'b1;
	gemm_wb_ns = gemm_wb_cs;
	gemm_wb_active_o = 1'b0;

	mp_wb_ready = 1'b1;
	mp_wb_ns = mp_wb_cs;
	mp_wb_active = 1'b0;

	case(gemm_wb_cs)
		IDLE_GEMM_WB:begin
			gemm_wb_active_o = 1'b0;
			gemm_wb_ready = 1'b1;

			if(operator_i == WB_GEMM_OP && enable_i) begin
				gemm_wb_ns = GEMM_WDATA;
			end
		end

		GEMM_WDATA:begin
			gemm_wb_active_o = 1'b1;
			gemm_wb_ready = 1'b0;
			
			if (scnn_data_cnt_i < 16 && data_type == 1'b0) begin 
				case(scnn_data_cnt_i)
					0:mem_wdata = M_cnn_Cache[0];
					1:mem_wdata = M_cnn_Cache[1];
					2:mem_wdata = M_cnn_Cache[2];
					3:mem_wdata = M_cnn_Cache[3];
					4:mem_wdata = M_cnn_Cache[4];
					5:mem_wdata = M_cnn_Cache[5];
					6:mem_wdata = M_cnn_Cache[6];
					7:mem_wdata = M_cnn_Cache[7];
					8:mem_wdata = M_cnn_Cache[8];
					9:mem_wdata = M_cnn_Cache[9];
					10:mem_wdata = M_cnn_Cache[10];
					11:mem_wdata = M_cnn_Cache[11];
					12:mem_wdata = M_cnn_Cache[12];
					13:mem_wdata = M_cnn_Cache[13];
					14:mem_wdata = M_cnn_Cache[14];
					15:begin
						mem_wdata = M_cnn_Cache[15];
						gemm_wb_ready = 1'b1;
					end	
					default:;
				endcase
				gemm_wb_ns = GEMM_WDATA;
			end
			else if(scnn_data_cnt_i < 4 && data_type == 1'b1) begin
				case(scnn_data_cnt_i)
					0:mem_wdata = {M_snn_Cache[3],M_snn_Cache[2],M_snn_Cache[1],M_snn_Cache[0]};
					1:mem_wdata = {M_snn_Cache[7],M_snn_Cache[6],M_snn_Cache[5],M_snn_Cache[4]};
					2:mem_wdata = {M_snn_Cache[11],M_snn_Cache[10],M_snn_Cache[9],M_snn_Cache[8]};
					3:begin
						mem_wdata = {M_snn_Cache[15],M_snn_Cache[14],M_snn_Cache[13],M_snn_Cache[12]};
						gemm_wb_ready = 1'b1;
					end
				endcase
			end
			else begin
				gemm_wb_ns = IDLE_GEMM_WB;
				gemm_wb_active_o = 1'b0;
				gemm_wb_ready = 1'b1;
			end
		end
	endcase

	case(mp_wb_cs)
		IDLE_MP_WB:begin
			mp_wb_ready = 1'b1;
			mp_wb_active = 1'b0;
			if(operator_i == MP_WB_OP && enable_i) begin
				mp_wb_ns = MP_WDATA;
			end
		end
		MP_WDATA:begin
			mp_wb_ready = 1'b0;
			mp_wb_active = 1'b1;

			case(operand2_i)
				0: mem_wdata = {MP_o[3],MP_o[2],MP_o[1],MP_o[0]};
				1: mem_wdata = MP_cnn_o[0];
				2: mem_wdata = MP_cnn_o[1];
				3: mem_wdata = MP_cnn_o[2];
				4: mem_wdata = MP_cnn_o[3];
				default: mem_wdata = {MP_o[3],MP_o[2],MP_o[1],MP_o[0]};
			endcase			
			mp_wb_ns = IDLE_MP_WB;
		end
	endcase
end

/////////////////////////////////////////////////////////////////////////////////////////////
always_comb begin
	get_data_ready = 1'b0;

	if(gemm4x4_get_data && ~(im2col_active))begin
		case(scnn_data_cnt_i)
			0:begin
				if(K_cs!=0) get_data_ready = 1'b1;
			end
			1:get_data_ready = 1'b0;
			default:;
		endcase
	end
	else if(gemm4x4_get_data && im2col_active)begin //CONV mode
		case(scnn_data_cnt_i)
			9:begin
				get_data_ready = 1'b1;
			end
			default:;
		endcase

	end
end


/////////////////////////////////////data load flag(im2col 4x4, 4mode)
/////////////////////////////////////data load in (gemm)
logic load_test;
always_ff @( posedge clk,negedge rst_n) begin
	if(~rst_n)begin
		A <= '{default:0};
		B <= '{default:0};

		load_test <= 1'b0;
	end
	else begin
		if(operator_i == GEMM4x4_OP && enable_i) begin
			load_test <= operand2_i[1];
		end
		else if(gemm4x4_get_data && ~(im2col_active))begin //GEMM mode
			case(scnn_data_cnt_i)
				0: begin
					if(K_cs!=0) begin
						A[0] <= mem_rdata[7:0];
						A[1] <= mem_rdata[15:8];
						A[2] <= mem_rdata[23:16];
						A[3] <= mem_rdata[31:24];
					end
				end
				1: begin
					B[0] <= mem_rdata[7:0];
					B[1] <= mem_rdata[15:8];
					B[2] <= mem_rdata[23:16];
					B[3] <= mem_rdata[31:24];
				end
				default:;
			endcase
		end
		else if(gemm4x4_get_data && im2col_active)begin //CONV mode
			case(scnn_data_cnt_i)
				1,3,5,7: begin
					load_test <= 1'b1;
					con_data[2*scnn_data_cnt_i-2] <= mem_rdata[23:16];
					con_data[2*scnn_data_cnt_i-1] <= mem_rdata[31:24];
				end
				2,4,6,8: begin 
					if(load_test) begin
						con_data[2*scnn_data_cnt_i-2] <= mem_rdata[7:0];
						con_data[2*scnn_data_cnt_i-1] <= mem_rdata[15:8];
					end
					else begin
						con_data[2*scnn_data_cnt_i-4] <= mem_rdata[7:0];
						con_data[2*scnn_data_cnt_i-3] <= mem_rdata[15:8];
						con_data[2*scnn_data_cnt_i-2] <= mem_rdata[23:16];
						con_data[2*scnn_data_cnt_i-1] <= mem_rdata[31:24];
					end
					load_test <= 1'b0;
				end
				9:begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[0];
					B[1] <= con_data[1];
					B[2] <= con_data[4];
					B[3] <= con_data[5];
				end
				10: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[1];
					B[1] <= con_data[2];
					B[2] <= con_data[5];
					B[3] <= con_data[6];
				end
				11: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[2];
					B[1] <= con_data[3];
					B[2] <= con_data[6];
					B[3] <= con_data[7];
				end
				12: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[4];
					B[1] <= con_data[5];
					B[2] <= con_data[8];
					B[3] <= con_data[9];
				end
				13: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[5];
					B[1] <= con_data[6];
					B[2] <= con_data[9];
					B[3] <= con_data[10];
				end
				14: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[6];
					B[1] <= con_data[7];
					B[2] <= con_data[10];
					B[3] <= con_data[11];
				end
				15: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[8];
					B[1] <= con_data[9];
					B[2] <= con_data[12];
					B[3] <= con_data[13];
				end
				16: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[9];
					B[1] <= con_data[10];
					B[2] <= con_data[13];
					B[3] <= con_data[14];
				end
				0: begin 
					//filter
					A[0] <= mem_rdata[7:0];
					A[1] <= mem_rdata[15:8];
					A[2] <= mem_rdata[23:16];
					A[3] <= mem_rdata[31:24];
					//condata
					B[0] <= con_data[10];
					B[1] <= con_data[11];
					B[2] <= con_data[14];
					B[3] <= con_data[15];
				end
				default:;
			endcase
		end
		else if(mp_get_data)begin
			case(scnn_data_cnt_i)
			1: begin 
				MP_Cache[0] <= mem_rdata[7:0];
				MP_Cache[1] <= mem_rdata[15:8];
				MP_Cache[2] <= mem_rdata[23:16];
				MP_Cache[3] <= mem_rdata[31:24];
			end
			2: begin 
				MP_Cache[4] <= mem_rdata[7:0];
				MP_Cache[5] <= mem_rdata[15:8];
				MP_Cache[6] <= mem_rdata[23:16];
				MP_Cache[7] <= mem_rdata[31:24];
			end
			3: begin 
				MP_Cache[8] <= mem_rdata[7:0];
				MP_Cache[9] <= mem_rdata[15:8];
				MP_Cache[10] <= mem_rdata[23:16];
				MP_Cache[11] <= mem_rdata[31:24];
			end
			4:begin 
				MP_Cache[12] <= mem_rdata[7:0];
				MP_Cache[13] <= mem_rdata[15:8];
				MP_Cache[14] <= mem_rdata[23:16];
				MP_Cache[15] <= mem_rdata[31:24];
			end
			endcase
		end	
		else begin
			
		end
	end
end
endmodule
