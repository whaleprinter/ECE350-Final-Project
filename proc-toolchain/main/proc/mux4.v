`timescale 1ns/100ps
module mux4(out, select, in0, in1, in2, in3);
    input [1:0] select;
    input [31:0] in0, in1, in2, in3;
    output [31:0] out;
    wire [31:0] w1, w2;
    
    mux2 firstlevel(w1, select[0], in0, in1);
    mux2 secondlevel(w2, select[0], in2, in3);
    mux2 finallevel(out, select[1], w1, w2);
endmodule