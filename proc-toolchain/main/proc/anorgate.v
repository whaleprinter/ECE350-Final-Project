module anorgate(out, data_operandA, data_operandB);
    input [31:0]data_operandA, data_operandB;
    output [31:0]out;

    or and1(out[0], data_operandA[0], data_operandB[0]);
    or and2(out[1], data_operandA[1], data_operandB[1]);
    or and3(out[2], data_operandA[2], data_operandB[2]);
    or and4(out[3], data_operandA[3], data_operandB[3]);
    or and33(out[4], data_operandA[4], data_operandB[4]);
    or and5(out[5], data_operandA[5], data_operandB[5]);
    or and6(out[6], data_operandA[6], data_operandB[6]);
    or and7(out[7], data_operandA[7], data_operandB[7]);
    or and8(out[8], data_operandA[8], data_operandB[8]);
    or and9(out[9], data_operandA[9], data_operandB[9]);

    or and11(out[10], data_operandA[10], data_operandB[10]);
    or and12(out[11], data_operandA[11], data_operandB[11]);
    or and13(out[12], data_operandA[12], data_operandB[12]);
    or and14(out[13], data_operandA[13], data_operandB[13]);
    or and15(out[14], data_operandA[14], data_operandB[14]);
    or and16(out[15], data_operandA[15], data_operandB[15]);
    or and17(out[16], data_operandA[16], data_operandB[16]);
    or and18(out[17], data_operandA[17], data_operandB[17]);
    or and19(out[18], data_operandA[18], data_operandB[18]);
    or and20(out[19], data_operandA[19], data_operandB[19]);

    or and21(out[20], data_operandA[20], data_operandB[20]);
    or and22(out[21], data_operandA[21], data_operandB[21]);
    or and23(out[22], data_operandA[22], data_operandB[22]);
    or and24(out[23], data_operandA[23], data_operandB[23]);
    or and25(out[24], data_operandA[24], data_operandB[24]);
    or and26(out[25], data_operandA[25], data_operandB[25]);
    or and27(out[26], data_operandA[26], data_operandB[26]);
    or and28(out[27], data_operandA[27], data_operandB[27]);
    or and29(out[28], data_operandA[28], data_operandB[28]);
    or and30(out[29], data_operandA[29], data_operandB[29]);

    or and31(out[30], data_operandA[30], data_operandB[30]);
    or and32(out[31], data_operandA[31], data_operandB[31]);

endmodule