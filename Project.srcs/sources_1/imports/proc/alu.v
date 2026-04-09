module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow, c32);

    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow, c32;

    wire P0, G0, P1, G1, P2, G2, P3, G3;
    wire c8, c16, c24, c80, c160, c161, c240, c241, c242, c320, c321, c322, c323;
    wire w1, w2;
    wire [31:0] adder_result, finalb, negb, and_result, or_result, sll_result, sra_result;

    // this is for the adder 
    mux8 mux1(data_result, ctrl_ALUopcode[2:0], adder_result, adder_result, and_result, or_result, sll_result, sra_result, 32'b0, 32'b0); 
    
    annotb addderoutb(negb, data_operandB);
    mux2 muxBB(finalb, ctrl_ALUopcode[0], data_operandB, negb);
    
    cla8bit first(data_operandA[7:0], finalb[7:0], ctrl_ALUopcode[0], adder_result[7:0], P0, G0);
    cla8bit second(data_operandA[15:8], finalb[15:8], c8, adder_result[15:8], P1, G1);
    cla8bit third(data_operandA[23:16], finalb[23:16], c16, adder_result[23:16], P2, G2);
    cla8bit fourth(data_operandA[31:24], finalb[31:24], c24, adder_result[31:24], P3, G3); 
   
    and andgate1(c80, P0, ctrl_ALUopcode[0]);
    or orgate1(c8, G0, c80);

    and andgate2(c160, P1, P0, ctrl_ALUopcode[0]);
    and andgate3(c161, P1, G0);
    or orgate2(c16, G1, c161, c160);

    and andgate10(c240, P0, P1, P2, ctrl_ALUopcode[0]);
    and andgate4(c241, P1, P2, G0);
    and andgate5(c242, P2, G1);
    or orgate3(c24, G2, c240, c241, c242);

    and andgate6(c320, P3, P2, P1, P0, ctrl_ALUopcode[0]);
    and andgate7(c321, P3, P2, P1, G0);
    and andgate8(c322, P2, P3, G1);
    and andgate9(c323, P3, G2);
    or orgate4(c32, c320, c321, c322, c323); 

    //signals:

    //overflow:
    xnor xnorgate1(w1, data_operandA[31], finalb[31]); // signs of operations match
    xor xorgate1(w2,data_operandA[31],adder_result[31]); //signs of operations differ 
    and andgate11(overflow, w1, w2); // and the two conditions

    // isless than - subtract numbers and if first bit of the number is 1 then the number is neg    
    wire temp, temp2;  
    mux2onebit ILT(temp, ctrl_ALUopcode[0], 1'b0, data_result[31]); 
    not newnot(temp2, temp);
    mux2onebit finalILT(isLessThan, overflow, temp, temp2);

    //isNotEqual -  is not equal - subtract and see if the answer is zero 
    wire INE1, INE2, INE3, INE4, INE5;
    or orINE1(INE1, adder_result[0],  adder_result[1], adder_result[2], adder_result[3], adder_result[4], adder_result[5], adder_result[6], adder_result[7]);
    or orINE2(INE2, adder_result[8],  adder_result[9], adder_result[10], adder_result[11], adder_result[12], adder_result[13], adder_result[14], adder_result[15]);
    or orINE3(INE3, adder_result[16],  adder_result[17], adder_result[18], adder_result[19], adder_result[20], adder_result[21], adder_result[22], adder_result[23]);
    or orINE4(INE4, adder_result[24],  adder_result[25], adder_result[26], adder_result[27], adder_result[28], adder_result[29], adder_result[30], adder_result[31]);
    or orINE5(INE5, INE1, INE2, INE3, INE4);
    mux2onebit INE(isNotEqual, ctrl_ALUopcode[0], 1'b0, INE5);

    /// --------------------- ADDER AND SUB DONE ---------------
    sll shiftleft(sll_result, data_operandA, ctrl_shiftamt);
    sra shiftright(sra_result, data_operandA, ctrl_shiftamt);

    //and and or result 
    anandgate and1_op(and_result, data_operandA, data_operandB);
    anorgate or1_op(or_result, data_operandA, data_operandB);
    
endmodule