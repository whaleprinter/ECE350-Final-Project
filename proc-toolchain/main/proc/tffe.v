// 85
module tffe(clk, T, Q, notQ, clr);
    input clk;
    input T;
    output Q, notQ;
    input clr;

    wire notT;
    assign notT = !T;

    wire and1;
    assign and1 = notQ & T;

    wire and2;
    assign and2 = notT & Q;

    wire or1;
    assign or1 = and1 | and2;

    dffe_ref dffe(Q,or1, clk, 1'b1, clr);

    assign notQ = !Q;


endmodule