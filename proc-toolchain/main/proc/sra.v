module sra(out, A, ctrl_shiftamt);
    input [31:0] A;
    input [4:0] ctrl_shiftamt;
    output [31:0] out;
    wire [31:0] w0, w1, w2, w3;
    wire[15:0] sixteen;
    assign sixteen = A[31] ? 16'b1111111111111111: 16'b0; 
    wire[7:0] eight;
    assign eight = A[31] ? 8'b11111111: 8'b0;// A[31] ? 4'd16 : 4'd0;
    wire [3:0] four;
    assign four = A[31] ? 4'b1111: 4'b0;//A[31] ? 3'd4: 3'd0;
    wire [1:0]two;
    assign two = A[31] ? 2'b11: 2'b0;  //A[31] ? 2'd2: 2'd0;
    wire one;
    assign one = A[31] ? 1'b1: 1'b0;

    mux2 shamt0(w0, ctrl_shiftamt[4], A, {sixteen, A[31:16]}); 
    mux2 shamt1(w1, ctrl_shiftamt[3], w0, {eight,w0[31:8]});
    mux2 shamt2(w2, ctrl_shiftamt[2], w1, {four, w1[31:4]}); 
    mux2 shamt3(w3, ctrl_shiftamt[1], w2, {two, w2[31:2]}); 
    mux2 shamt4(out, ctrl_shiftamt[0], w3, {one, w3[31:1]}); 
endmodule 