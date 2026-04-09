`timescale 1ns/100ps
module mux8_33(out, select, in0, in1, in2, in3, in4, in5, in6, in7);
    input [2:0] select;
    input [32:0] in0, in1, in2, in3, in4, in5, in6, in7;
    output [32:0] out;
    wire [32:0] w1, w2;

    mux4_33 firstlevel(w1, select[1:0], in0, in1, in2, in3);
    mux4_33 secondlevel(w2, select[1:0], in4, in5, in6, in7);
    mux2_33 finallevel(out, select[2], w1, w2);


endmodule