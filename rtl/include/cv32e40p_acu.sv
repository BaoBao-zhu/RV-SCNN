//multiply
//Use the and logic of bit indata with filter_i


module cv32e40p_acu(
    input clk,
    //addr_used
    output logic [31:0] data_addr_scnn,
    input logic data_req_ex_i,
    input logic [31:0] data_addr_o_test,
    output logic [31:0] data_addr_o,
    //test_mac
    ////////////////////////////////////////////////////////////////////
    input logic [31:0]	 mem_wdata,
    input logic [31:0]	 data_addr_scnnA_start,
    input logic [31:0]	 data_addr_scnnB_start,
    input  logic [1:0]   scnn_flag,
    output logic [31:0]	 scnn_cnt,
    //test_gemm_load M N K
    input logic [15:0]	 gemm_K,
    input logic [15:0]	 gemm_M,
    input logic [15:0]	 gemm_N,
    //test_gemm4x4
    input logic		     gemm4x4_active_i,
    //test_gemm_wb
    input logic		     gemm_wb_active_i,
    //test_mp_ri
    input logic          mp_ri_active_i,
    //test_mp_wb         
    input logic          mp_wb_active_i,
    //test_datatype
    input logic          im2col_active_i,
    input logic          data_type_i
    //////////////////////////////////////////////////////////////////////////////////////////
);

    logic [31:0]  data_addr_scnn_A;
    logic [31:0]  data_addr_scnn_B;
    logic data_scnn_state;
    assign data_scnn_state = gemm_wb_active_i|gemm4x4_active_i|mp_ri_active_i|mp_wb_active_i;
    assign data_addr_o = data_scnn_state? data_addr_scnn: data_addr_o_test;


    always_ff @(posedge clk) begin

        if (scnn_flag==2'b01)begin // write back 
            data_addr_scnn <= data_addr_scnnA_start; // use A signal to write back
            scnn_cnt <= '0;
        end
        else if(scnn_flag==2'b10)begin //gemm data in 
            data_addr_scnn <= (data_addr_scnnB_start);  //input data first(conv first)
            data_addr_scnn_A <= (data_addr_scnnA_start);
            data_addr_scnn_B <= (data_addr_scnnB_start);//load B start
            scnn_cnt <= '0;
        end 
        else if(gemm4x4_active_i) begin
            if(data_req_ex_i & (~im2col_active_i))begin
                case (scnn_cnt)
                    0:begin
                        data_addr_scnn <= data_addr_scnn_A;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    1:begin
                        data_addr_scnn   <= data_addr_scnn_B + gemm_N;
                        data_addr_scnn_A <= data_addr_scnn_A + gemm_M;
                        data_addr_scnn_B <= data_addr_scnn_B + gemm_N;
                        scnn_cnt <= '0;
                    end
                    default:begin
                        scnn_cnt <= '0;
                        data_addr_scnn <= '0;
                    end 
                endcase
            end
            else if((data_req_ex_i & (im2col_active_i))) begin
                case (scnn_cnt)
                    0:begin
                        if(data_addr_scnn[1]) begin
                            data_addr_scnn <= data_addr_scnn_B + 2;
                            scnn_cnt <= scnn_cnt + 1;
                        end
                        else begin
                            data_addr_scnn <= data_addr_scnn + gemm_M;
                            scnn_cnt <= scnn_cnt + 2;
                        end
                    end
                    1,3,5:begin
                        data_addr_scnn <= data_addr_scnn + gemm_M - 2;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    2,4,6: begin
                        if(data_addr_scnn[1]) begin
                            data_addr_scnn <= data_addr_scnn + 2;
                            scnn_cnt <= scnn_cnt + 1;
                        end
                        else begin
                            data_addr_scnn <= data_addr_scnn + gemm_M;
                            scnn_cnt <= scnn_cnt + 2;
                            if(scnn_cnt==6)  begin
                                data_addr_scnn <= data_addr_scnn_A;
                            end
                        end
                    end
                    7: begin //begin to load filter
                        data_addr_scnn <= data_addr_scnn_A;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    8,9,10,11,12,13,14,15:begin
                        data_addr_scnn <= data_addr_scnn + 4;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    //filter is all in
                    16:begin
                        data_addr_scnn <= data_addr_scnn_B + gemm_M*gemm_M;
                        data_addr_scnn_A <= data_addr_scnn_A + 36;
                        data_addr_scnn_B <= data_addr_scnn_B + gemm_M*gemm_M;
                        scnn_cnt <= '0;
                    end
                    default:begin
                        scnn_cnt <= '0;
                        data_addr_scnn <= '0;
                    end 
                endcase
            end
        end
        else if(gemm_wb_active_i)begin
            if(data_req_ex_i)begin
                if(data_type_i == 1'b0) begin
                    case (scnn_cnt)
                        0,1,2,4,5,6,8,9,10,12,13,14:begin
                            data_addr_scnn <= data_addr_scnn + 4;
                            scnn_cnt <= scnn_cnt + 1;
                        end
                        3,7,11:begin
                            data_addr_scnn <= data_addr_scnn + 4*gemm_N - 12;
                            scnn_cnt <= scnn_cnt + 1;
                        end
                        default:begin
                        scnn_cnt <= '1;
                        data_addr_scnn <= '0;
                        end 
                    endcase
                end
                else begin
                    case (scnn_cnt)
                        0,1,2:begin
                            data_addr_scnn <= data_addr_scnn + gemm_N;
                            scnn_cnt <= scnn_cnt + 1;
                        end
                        default:begin
                        scnn_cnt <= '1;
                        data_addr_scnn <= '0;
                        end 
                    endcase
                end
            end
        end
        else if(mp_ri_active_i)begin
            if(data_req_ex_i)begin
                case (scnn_cnt)
                    0:begin
                        data_addr_scnn <= data_addr_scnn + gemm_M;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    1:begin
                        data_addr_scnn <= data_addr_scnn + gemm_N;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    2:begin
                        data_addr_scnn <= data_addr_scnn + gemm_K;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    3:begin
                        // data_addr_scnn <= data_addr_scnn + 4;
                        scnn_cnt <= scnn_cnt + 1;
                    end
                    default:begin
                    scnn_cnt <= '1;
                    data_addr_scnn <= '0;
                    end 
                endcase
            end
        end
        else begin
            scnn_cnt <= '0;
            data_addr_scnn <= '0;
        end
    end

endmodule