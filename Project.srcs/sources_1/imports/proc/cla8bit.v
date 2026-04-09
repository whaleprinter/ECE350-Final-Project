module cla8bit(A, B, c0, sum, P0, G0); //sum, carryout);
    input [7:0] A, B;
    input c0;
    output P0, G0;
    output [7:0] sum; ///carryout;
    //output [7:0] sum;

    wire [7:0] p, g, c;
    wire P0_1, w0, w1, w2, w3, w4, w5, w6, P1, P2, P3, P4, P5, P6;
    
    //or or1[7:0](p0, A, B); - why does this not work 
    or or0(p[0], A[0], B[0]);
    or or1(p[1], A[1], B[1]);
    or or2(p[2], A[2], B[2]);
    or or3(p[3], A[3], B[3]);
    or or4(p[4], A[4], B[4]);
    or or5(p[5], A[5], B[5]);
    or or6(p[6], A[6], B[6]);
    or or7(p[7], A[7], B[7]);
    //xor xor2[7:0](sum, P0, c0); 
    //and bothOnes[7:0](g0, A, B);
    and and0(g[0], A[0], B[0]);
    and and1(g[1], A[1], B[1]);
    and and2(g[2], A[2], B[2]);
    and and3(g[3], A[3], B[3]);
    and and4(g[4], A[4], B[4]);
    and and5(g[5], A[5], B[5]);
    and and6(g[6], A[6], B[6]);
    and and7(g[7], A[7], B[7]);

    wire p0c0, c1;
    and andp0c0(p0c0, p[0], c0);
    or orc1(c1, g[0], p0c0);

    wire c10, c11, c2;
    and andc10(c10, p[1], p[0], c0);
    and andc11(c11, p[1], g[0]);
    or orc2(c2, g[1], c11, c10);

    wire c20, c21, c22, c3;
    and andc20(c20, p[2], p[1], p[0], c0);
    and andc21(c21, p[2], p[1], g[0]);
    and andc22(c22, p[2], g[1]);
    or  orc3(c3, g[2], c22, c21, c20);

    wire c30, c31, c32, c33, c4;
    and andc30(c30, p[3], p[2], p[1], p[0], c0);
    and andc31(c31, p[3], p[2], p[1], g[0]);
    and andc32(c32, p[3], p[2], g[1]);
    and andc33(c33, p[3], g[2]);
    or  orc4(c4, g[3], c33, c32, c31, c30);

    wire c40, c41, c42, c43, c44, c5;
    and andc40(c40, p[4], p[3], p[2], p[1], p[0], c0);
    and andc41(c41, p[4], p[3], p[2], p[1], g[0]);
    and andc42(c42, p[4], p[3], p[2], g[1]);
    and andc43(c43, p[4], p[3], g[2]);
    and andc44(c44, p[4], g[3]);
    or  orc5(c5, g[4], c44, c43, c42, c41, c40);

    wire c50, c51, c52, c53, c54, c55, c6;
    and andc50(c50, p[5], p[4], p[3], p[2], p[1], p[0], c0);
    and andc51(c51, p[5], p[4], p[3], p[2], p[1], g[0]);
    and andc52(c52, p[5], p[4], p[3], p[2], g[1]);
    and andc53(c53, p[5], p[4], p[3], g[2]);
    and andc54(c54, p[5], p[4], g[3]);
    and andc55(c55, p[5], g[4]);
    or  orc6(c6, g[5], c55, c54, c53, c52, c51, c50);

    wire c60, c61, c62, c63, c64, c65, c66, c7;
    and andc60(c60, p[6], p[5], p[4], p[3], p[2], p[1], p[0], c0);
    and andc61(c61, p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and andc62(c62, p[6], p[5], p[4], p[3], p[2], g[1]);
    and andc63(c63, p[6], p[5], p[4], p[3], g[2]);
    and andc64(c64, p[6], p[5], p[4], g[3]);
    and andc65(c65, p[6], p[5], g[4]);
    and andc66(c66, p[6], g[5]);
    or  orc7(c7, g[6], c66, c65, c64, c63, c62, c61, c60);

    xor xor8(sum[0], A[0], B[0], c0);
    xor xor9(sum[1], A[1], B[1], c1);
    xor xor10(sum[2],A[2], B[2], c2);
    xor xor11(sum[3], A[3], B[3], c3);
    xor xor12(sum[4], A[4], B[4], c4);
    xor xor13(sum[5], A[5], B[5], c5);
    xor xor14(sum[6], A[6], B[6], c6);
    xor xor15(sum[7],A[7], B[7], c7);

    //P logic from slide 13 
    and andP(P0, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
    
    and andP0(P0_1, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
    and andP1(P1, p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
    and andP2(P2, p[2], p[3], p[4], p[5], p[6],  p[7]);
    and andP3(P3, p[3], p[4], p[5], p[6], p[7]);
    and andP4(P4, p[4], p[5], p[6], p[7]);
    and andP5(P5, p[5], p[6], p[7]);
    and andP6(P6, p[6], p[7]);

    and andg0(w0, g[0], P0_1);
    and andg1(w1, g[1], P1);
    and andg2(w2, g[2], P2);
    and andg3(w3, g[3], P3);
    and andg4(w4, g[4], P4);
    and andg5(w5, g[5], P5);
    and andg6(w6, g[6], P6);
    
    or orgate(G0, g[7], w6, w5, w4, w3, w2, w1, w0);

endmodule
