//multiply
//Use the and logic of bit indata with filter


module cv32e40p_cnn_add(
    input mode_i,
    input logic signed  [15:0] M_Cache_i [7:0][15:0],
    output logic signed [31:0] M_cnn_Cache_o [15:0]
);
    //CNN_ADD
    logic signed [22:0] add0 [15:0];
    logic signed [22:0] add1 [15:0];
    logic signed [22:0] add2 [15:0];
    logic signed [22:0] add3 [15:0];
    logic signed [22:0] add4 [15:0];
    logic signed [22:0] add5 [15:0];
    logic signed [22:0] add6 [15:0];
    logic signed [22:0] add7 [15:0];

    logic signed [25:0] sum [15:0];

    generate
    genvar i;
    for(i=0; i<16; i=i+1)begin: cnnadd
    
        assign add0[i] = {{7{M_Cache_i[0][i][15]}}, M_Cache_i[0][i]};
        assign add1[i] = {{6{M_Cache_i[1][i][15]}}, M_Cache_i[1][i], 1'b0};
        assign add2[i] = {{5{M_Cache_i[2][i][15]}}, M_Cache_i[2][i], 2'b0};
        assign add3[i] = {{4{M_Cache_i[3][i][15]}}, M_Cache_i[3][i], 3'b0};
        assign add4[i] = {{3{M_Cache_i[4][i][15]}}, M_Cache_i[4][i], 4'b0};
        assign add5[i] = {{2{M_Cache_i[5][i][15]}}, M_Cache_i[5][i], 5'b0};
        assign add6[i] = {{1{M_Cache_i[6][i][15]}}, M_Cache_i[6][i], 6'b0};
        assign add7[i] = {M_Cache_i[7][i], 7'b0};

        assign sum[i] = add0[i] + add1[i] + add2[i] + add3[i] + add4[i] + add5[i] + add6[i] - add7[i];

        assign M_cnn_Cache_o[i] = mode_i ? {{6{sum[i][25]}}, sum[i]} : '0;

    end
    endgenerate

endmodule