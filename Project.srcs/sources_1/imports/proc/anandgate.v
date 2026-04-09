module anandgate(out,data_operandA, data_operandB);
    input [31:0]data_operandA, data_operandB;
    output [31:0]out;

    and and1(out[0], data_operandA[0], data_operandB[0]);
    and and2(out[1], data_operandA[1], data_operandB[1]);
    and and3(out[2], data_operandA[2], data_operandB[2]);
    and and4(out[3], data_operandA[3], data_operandB[3]);
    and and5(out[4], data_operandA[4], data_operandB[4]);
    and and6(out[5], data_operandA[5], data_operandB[5]);
    and and7(out[6], data_operandA[6], data_operandB[6]);
    and and8(out[7], data_operandA[7], data_operandB[7]);
    and and9(out[8], data_operandA[8], data_operandB[8]);
    and and10(out[9], data_operandA[9], data_operandB[9]);

    and and11(out[10], data_operandA[10], data_operandB[10]);
    and and12(out[11], data_operandA[11], data_operandB[11]);
    and and13(out[12], data_operandA[12], data_operandB[12]);
    and and14(out[13], data_operandA[13], data_operandB[13]);
    and and15(out[14], data_operandA[14], data_operandB[14]);
    and and16(out[15], data_operandA[15], data_operandB[15]);
    and and17(out[16], data_operandA[16], data_operandB[16]);
    and and18(out[17], data_operandA[17], data_operandB[17]);
    and and19(out[18], data_operandA[18], data_operandB[18]);
    and and20(out[19], data_operandA[19], data_operandB[19]);

    and and21(out[20], data_operandA[20], data_operandB[20]);
    and and22(out[21], data_operandA[21], data_operandB[21]);
    and and23(out[22], data_operandA[22], data_operandB[22]);
    and and24(out[23], data_operandA[23], data_operandB[23]);
    and and25(out[24], data_operandA[24], data_operandB[24]);
    and and26(out[25], data_operandA[25], data_operandB[25]);
    and and27(out[26], data_operandA[26], data_operandB[26]);
    and and28(out[27], data_operandA[27], data_operandB[27]);
    and and29(out[28], data_operandA[28], data_operandB[28]);
    and and30(out[29], data_operandA[29], data_operandB[29]);

    and and31(out[30], data_operandA[30], data_operandB[30]);
    and and32(out[31], data_operandA[31], data_operandB[31]);

endmodule