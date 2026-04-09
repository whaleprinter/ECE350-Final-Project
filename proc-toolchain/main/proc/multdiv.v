module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    // keep a DFFE for mult and div spearately that keeps the operation for 17 or 33 cycles as needed. clear it using the coutner 
    output [31:0] data_result;
    output data_exception, data_resultRDY;
    wire reg_clr;
    wire [5:0] counter_out;
    wire [4:0] ctrl_ALUopcode;

    //if ocunter is zero = or all the bits together 
    counter counter1(clock, counter_out, reg_clr);
    wire c0;
    assign c0 = counter_out[5] | counter_out[4] | counter_out[3]|counter_out[2]|counter_out[1]|counter_out[0];

    wire c16;
    assign c16 = !counter_out[5] & counter_out[4] & !counter_out[3] & !counter_out[2] & !counter_out[1] & !counter_out[0]; 
    wire c33, data_resultRDY1;
    assign data_resultRDY1 = c17; // 32 counter 
   
    wire [65:0] prodreg;
    assign prodreg = c0 ? {manual, manual, manual, alu_out, regOut[32:2]} : {33'b0, data_operandA, 1'b0};
    
    wire c17;
    assign c17 = counter_out[4] & !counter_out[3] & !counter_out[2] & !counter_out[1] & counter_out[0];
    assign reg_clr = (ctrl_MULT | ctrl_DIV); 
    wire [65:0] regOut;
    sixtysixbit_reg regs(clock, 1'b1, 1'b1, prodreg, regOut, reg_clr);

    wire c32_2;
    wire [31:0] data_result1;
    assign data_result1 = regOut[32:1];
    
    wire allzero = !(|regOut[65:32]); // will be zero if not all zero and 1 if all zero
    wire allones =  &regOut[65:32]; // will be zero if not all one and one if all one
    wire allzeroorone = (allzero | allones); 
    wire data_exception1;
    assign data_exception1 = !allzeroorone;
    
    wire data_exception_div;
    assign data_exception_div = |data_operandB ? 1'b0 : 1'b1; 
   
    wire [32:0] M, twoM;
    assign M = {data_operandB[31], data_operandB};
    assign twoM = M << 1;
    
    wire Mnum;
    assign Mnum = regOut[1] ^ regOut[0];
    wire [32:0] Mmag;
    assign Mmag = Mnum ? M : twoM;
    assign ctrl_ALUopcode = regOut[2] ? 5'b00001 : 5'b00000;
    wire manual;
    wire [31:0] alu_out, alu_out1;
    wire isNotEqual, isLessThan, overflow1;
    alu alu2(regOut[64:33], Mmag[31:0], ctrl_ALUopcode , 5'b0, alu_out1, isNotEqual, isLessThan, overflow1, c32_2);
    wire allsame;
    assign allsame = !((!(regOut[2] | regOut[1] | regOut[0])) | (regOut[2] & regOut[1] & regOut[0]));
    assign alu_out = allsame ? alu_out1: regOut[64:33];
    wire MMSB;
    assign MMSB = ctrl_ALUopcode[0] ? !Mmag[32] : Mmag[31];
    assign manual = allsame ? (c32_2 ^ regOut[65] ^ MMSB) : regOut[65];
// --------------------------------------------------------------------
    wire check_one;
    // initialise prodreg
    wire [63:0] prodreg_div;
    wire [31:0] tophalf_div;
    wire [31:0] bottomhalf_div;
    wire [63:0] regOut_div;
    wire [31:0] negB, realB, realA;
    assign prodreg_div = c0 ? {tophalf_div, bottomhalf_div} : {32'b0, realA};

    //left shift the entire prodreg
    wire [63:0] leftshift;
    assign leftshift = regOut_div << 1; // is this correct? 
    // -V
    wire c331_1;
    alu alu3(32'b0, realB, 5'b1 , 5'b0, negB, isNotEqual, isLessThan, overflow1, c331_1);
    // trial subtraction
    wire [31:0] remainder;
    alu alu4(leftshift[63:32], negB, 5'b0,  5'b0, remainder, isNotEqual, isLessThan, overflow1, c331_1);
    //check if msb is 1 ; failed = 0, passed = 1
    assign check_one = remainder[31] ? 1'b1 : 1'b0;
    //wire [31:0] restore;
    //alu alu5(remainder, realB, 5'b0, 5'b0, restore, isNotEqual, isLessThan, overflow1, c331_1);
    assign tophalf_div = check_one ? leftshift[63:32] : remainder;
    assign bottomhalf_div = {leftshift[31:1], !check_one};
    sixtyfourbit_reg reg_div(clock, 1'b1, 1'b1, prodreg_div, regOut_div, reg_clr);
    wire [5:0] counter_out2;
    counter counter2(clock, counter_out2, reg_clr);
    // THIS IS ACTUALY 32 
    assign c33 = counter_out2[5] & !counter_out2[4] & !counter_out2[3] & !counter_out2[2] & !counter_out2[1] & !counter_out2[0]; 
    wire data_resultRDY_div;
    assign data_resultRDY_div = c33;

    // change A or B to pos
    wire [31:0] Apos, Bpos;
    alu alu6(32'b0, data_operandA, 5'b1, 5'b0, Apos, isNotEqual, isLessThan, overflow1, c331_1);
    alu alu7(32'b0, data_operandB, 5'b1, 5'b0, Bpos, isNotEqual, isLessThan, overflow1, c331_1);

    assign realA = data_operandA[31] ? Apos : data_operandA;
    assign realB = data_operandB[31] ? Bpos : data_operandB;

    // if msb of A xor B = 1 -> flip result 
    wire flipornot;
    assign flipornot = data_operandA[31] ^ data_operandB[31];
    wire [31:0] negatedres;
    alu alu8(32'b0, prodreg_div[31:0], 5'b1, 5'b0, negatedres, isNotEqual, isLessThan, overflow1, c331_1);
    wire [31:0] div_ans;
    assign div_ans = flipornot ? negatedres : prodreg_div[31:0];
    wire [31:0]data_result_div;
    assign data_result_div = data_exception ? 32'b0 : div_ans;

    // 1 dffe to choose mult or div. din = ctrl Mult enable = ctrl mult clr = ctrl div; use the q output as the select bit for result and exception;
    wire state;
    dffe_ref state1(state, ctrl_MULT, clock, ctrl_MULT, ctrl_DIV);
    assign data_result = state ? data_result1 : data_result_div;
    assign data_resultRDY = state ? data_resultRDY1 : data_resultRDY_div;
    assign data_exception = state ? data_exception1 : data_exception_div;

endmodule
