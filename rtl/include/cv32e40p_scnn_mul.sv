//multiply
//Use the and logic of bit indata with filter_i


module cv32e40p_scnn_mul(
    input logic signed  [7:0] filter_i [3:0],          //contain the 8bit data of input image
    input logic         [7:0] input_i  [3:0],          //contain the 8bit weight
    input logic signed  [15:0] M_Cache_i [7:0][15:0], 
    output logic signed [15:0] M_Cache_o [7:0][15:0]
);
    //SNN_MUL
    generate
    genvar i;
    for(i=0; i<8; i=i+1)begin: mul
    
        assign M_Cache_o[i][0] =  M_Cache_i[i][0] + (input_i[0][i] ? {{8{filter_i[0][7]}},filter_i[0]} : 16'b0);
        assign M_Cache_o[i][1] =  M_Cache_i[i][1] + (input_i[1][i] ? {{8{filter_i[0][7]}},filter_i[0]} : 16'b0);
        assign M_Cache_o[i][2] =  M_Cache_i[i][2] + (input_i[2][i] ? {{8{filter_i[0][7]}},filter_i[0]} : 16'b0);
        assign M_Cache_o[i][3] =  M_Cache_i[i][3] + (input_i[3][i] ? {{8{filter_i[0][7]}},filter_i[0]} : 16'b0);

        assign M_Cache_o[i][4] =  M_Cache_i[i][4] + (input_i[0][i] ? {{8{filter_i[1][7]}},filter_i[1]} : 16'b0);
        assign M_Cache_o[i][5] =  M_Cache_i[i][5] + (input_i[1][i] ? {{8{filter_i[1][7]}},filter_i[1]} : 16'b0);
        assign M_Cache_o[i][6] =  M_Cache_i[i][6] + (input_i[2][i] ? {{8{filter_i[1][7]}},filter_i[1]} : 16'b0);
        assign M_Cache_o[i][7] =  M_Cache_i[i][7] + (input_i[3][i] ? {{8{filter_i[1][7]}},filter_i[1]} : 16'b0);

        assign M_Cache_o[i][8] =  M_Cache_i[i][8] + (input_i[0][i] ? {{8{filter_i[2][7]}},filter_i[2]} : 16'b0);
        assign M_Cache_o[i][9] =  M_Cache_i[i][9] + (input_i[1][i] ? {{8{filter_i[2][7]}},filter_i[2]} : 16'b0);
        assign M_Cache_o[i][10] =  M_Cache_i[i][10] + (input_i[2][i] ? {{8{filter_i[2][7]}},filter_i[2]} : 16'b0);
        assign M_Cache_o[i][11] =  M_Cache_i[i][11] + (input_i[3][i] ? {{8{filter_i[2][7]}},filter_i[2]} : 16'b0);

        assign M_Cache_o[i][12] =  M_Cache_i[i][12] + (input_i[0][i] ? {{8{filter_i[3][7]}},filter_i[3]} : 16'b0);
        assign M_Cache_o[i][13] =  M_Cache_i[i][13] + (input_i[1][i] ? {{8{filter_i[3][7]}},filter_i[3]} : 16'b0);
        assign M_Cache_o[i][14] =  M_Cache_i[i][14] + (input_i[2][i] ? {{8{filter_i[3][7]}},filter_i[3]} : 16'b0);
        assign M_Cache_o[i][15] =  M_Cache_i[i][15] + (input_i[3][i] ? {{8{filter_i[3][7]}},filter_i[3]} : 16'b0);

    end
    endgenerate

endmodule