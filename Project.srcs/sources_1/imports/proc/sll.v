module sll(out, A, ctrl_shiftamt);
    input [31:0] A;
    input [4:0] ctrl_shiftamt;
    output [31:0] out;
    wire [31:0] w0, w1, w2, w3;

    wire [15:0] sixteen;
    assign sixteen = 16'b0;

    wire [7:0] eight;
    assign eight = 8'b0;

    wire [3:0] four;
    assign four = 4'b0;

    wire [1:0] two;
    assign two = 2'b0;

    wire one;
    assign one = 1'b0;

    mux2 shamt0(w0, ctrl_shiftamt[4], A, {A[15:0], sixteen});
    mux2 shamt1(w1, ctrl_shiftamt[3], w0, {w0[23:0], eight});
    mux2 shamt2(w2, ctrl_shiftamt[2], w1, {w1[27:0], four});
    mux2 shamt3(w3, ctrl_shiftamt[1], w2, {w2[29:0], two});
    mux2 shamt4(out, ctrl_shiftamt[0], w3, {w3[30:0], one});
endmodule
