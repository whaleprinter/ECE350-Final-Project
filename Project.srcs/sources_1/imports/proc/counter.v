//5 tffes from slide 87
module counter(clk, out, clr);
    
    input clk;
    wire enable;
    assign enable = 1'b1;
    output [5:0] out;
    wire [5:0] notout;
    input clr;


    ///tffe(clk, T, Q, notQ)
    wire en1;
    assign en1 = out[0] & enable;
    wire en2;
    assign en2 = out[1] & en1;
    wire en3;
    assign en3 = out[2] & en2;
    wire en4;
    assign en4 = out[3] & en3;
    wire en5;
    assign en5 = out[4] & en4;

    tffe tffe0(clk, enable, out[0], notout[0],clr);
    tffe tffe1(clk, en1, out[1], notout[1],clr);
    tffe tffe2(clk, en2, out[2], notout[2],clr);
    tffe tffe3(clk, en3, out[3], notout[3],clr);
    tffe tffe4(clk, en4, out[4], notout[4], clr);
    tffe tffe5(clk, en5, out[5], notout[5], clr);
    
endmodule