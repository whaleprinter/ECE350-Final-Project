module one_reg(clk, input_enable, output_enable, in, out, clr);

    input clk, input_enable, output_enable;
    input [31:0] in;
    output [31:0] out;

    input clr; 
    //and and1(en, clk, input_enable);

    wire q0;
    dffe_ref dff0(q0, in[0], clk, input_enable, clr);
    assign out[0] = output_enable ? q0 : 1'bz;

    wire q1;
    dffe_ref dff1(q1, in[1], clk, input_enable, clr);
    assign out[1] = output_enable ? q1 : 1'bz;

    wire q2;
    dffe_ref dff2(q2, in[2], clk, input_enable, clr);
    assign out[2] = output_enable ? q2 : 1'bz;

    wire q3;
    dffe_ref dff3(q3, in[3], clk, input_enable, clr);
    assign out[3] = output_enable ? q3 : 1'bz;

    wire q4;
    dffe_ref dff4(q4, in[4], clk, input_enable, clr);
    assign out[4] = output_enable ? q4 : 1'bz;

    wire q5;
    dffe_ref dff5(q5, in[5], clk, input_enable, clr);
    assign out[5] = output_enable ? q5 : 1'bz;

    wire q6;
    dffe_ref dff6(q6, in[6], clk, input_enable, clr);
    assign out[6] = output_enable ? q6 : 1'bz;

    wire q7;
    dffe_ref dff7(q7, in[7], clk, input_enable, clr);
    assign out[7] = output_enable ? q7 : 1'bz;

    wire q8;
    dffe_ref dff8(q8, in[8], clk, input_enable, clr);
    assign out[8] = output_enable ? q8 : 1'bz;

    wire q9;
    dffe_ref dff9(q9, in[9], clk, input_enable, clr);
    assign out[9] = output_enable ? q9 : 1'bz;

    wire q10;
    dffe_ref dff10(q10, in[10], clk, input_enable, clr);
    assign out[10] = output_enable ? q10 : 1'bz;

    wire q11;
    dffe_ref dff11(q11, in[11], clk, input_enable, clr);
    assign out[11] = output_enable ? q11 : 1'bz;

    wire q12;
    dffe_ref dff12(q12, in[12], clk, input_enable, clr);
    assign out[12] = output_enable ? q12 : 1'bz;

    wire q13;
    dffe_ref dff13(q13, in[13], clk, input_enable, clr);
    assign out[13] = output_enable ? q13 : 1'bz;

    wire q14;
    dffe_ref dff14(q14, in[14], clk, input_enable, clr);
    assign out[14] = output_enable ? q14 : 1'bz;

    wire q15;
    dffe_ref dff15(q15, in[15], clk, input_enable, clr);
    assign out[15] = output_enable ? q15 : 1'bz;

    wire q16;
    dffe_ref dff16(q16, in[16], clk, input_enable, clr);
    assign out[16] = output_enable ? q16 : 1'bz;

    wire q17;
    dffe_ref dff17(q17, in[17], clk, input_enable, clr);
    assign out[17] = output_enable ? q17 : 1'bz;

    wire q18;
    dffe_ref dff18(q18, in[18], clk, input_enable, clr);
    assign out[18] = output_enable ? q18 : 1'bz;

    wire q19;
    dffe_ref dff19(q19, in[19], clk, input_enable, clr);
    assign out[19] = output_enable ? q19 : 1'bz;

    wire q20;
    dffe_ref dff20(q20, in[20], clk, input_enable, clr);
    assign out[20] = output_enable ? q20 : 1'bz;

    wire q21;
    dffe_ref dff21(q21, in[21], clk, input_enable, clr);
    assign out[21] = output_enable ? q21 : 1'bz;

    wire q22;
    dffe_ref dff22(q22, in[22], clk, input_enable, clr);
    assign out[22] = output_enable ? q22 : 1'bz;

    wire q23;
    dffe_ref dff23(q23, in[23], clk, input_enable, clr);
    assign out[23] = output_enable ? q23 : 1'bz;

    wire q24;
    dffe_ref dff24(q24, in[24], clk, input_enable, clr);
    assign out[24] = output_enable ? q24 : 1'bz;

    wire q25;
    dffe_ref dff25(q25, in[25], clk, input_enable, clr);
    assign out[25] = output_enable ? q25 : 1'bz;

    wire q26;
    dffe_ref dff26(q26, in[26], clk, input_enable, clr);
    assign out[26] = output_enable ? q26 : 1'bz;

    wire q27;
    dffe_ref dff27(q27, in[27], clk, input_enable, clr);
    assign out[27] = output_enable ? q27 : 1'bz;

    wire q28;
    dffe_ref dff28(q28, in[28], clk, input_enable, clr);
    assign out[28] = output_enable ? q28 : 1'bz;

    wire q29;
    dffe_ref dff29(q29, in[29], clk, input_enable, clr);
    assign out[29] = output_enable ? q29 : 1'bz;

    wire q30;
    dffe_ref dff30(q30, in[30], clk, input_enable, clr);
    assign out[30] = output_enable ? q30 : 1'bz;

    wire q31;
    dffe_ref dff31(q31, in[31], clk, input_enable, clr);
    assign out[31] = output_enable ? q31 : 1'bz;

endmodule
