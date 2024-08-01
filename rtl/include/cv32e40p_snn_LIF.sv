//multiply
//Use the and logic of bit indata with filter


module cv32e40p_snn_LIF(
    input logic enable_i,
    input logic [1:0] shift_i,
    input logic signed  [15:0] M_Cache_i [7:0][15:0],
    output logic signed  [15:0] M_Cache_o [7:0][15:0]
);

    genvar i,j;
   
    generate
    for(i=0; i<16; i=i+1)begin:shift1
        for(j=0; j<7; j=j+1)begin:shift2
            always_comb begin
                M_Cache_o[j][i] = 32'b0;
                if(enable_i) begin
                    case(shift_i)
                        2'b00: M_Cache_o[j][i] = M_Cache_i[j][i];
                        2'b01: M_Cache_o[j][i] = (M_Cache_i[j][i]>>>1);
                        2'b10: M_Cache_o[j][i] = (M_Cache_i[j][i]>>>2);
                        2'b11: M_Cache_o[j][i] = (M_Cache_i[j][i]>>>3);
                        default:M_Cache_o[j][i] = M_Cache_i[j][i];
                    endcase
                end
            end
        end
    end
    endgenerate
    

endmodule