/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem = IRIN

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB,                  // I: Data from port B of RegFile
	
    motor_outX,
    motor_outY,
    servo_out,
    PS2_CLK,
    PS2_DATA,
    LED
    );

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem; 
	input [31:0] q_imem; 

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

    // Steppers
    output [3:0] motor_outX, motor_outY;

    // Servo
    output servo_out;

    // PS2
    input PS2_CLK;
    input PS2_DATA;
    output LED;

// CUSTOM INSTRUCTIONS:
// POLL KEYBOARD: 11000
// PEN: 11001
// MOVE: 11010

// PC STAGE
    wire [31:0] PcIn, PcOut, PcInAdd;
    wire garbage;
    wire [31:0] signextendimm;
    wire [4:0] fivebitgarbage;
    wire [31:0] thirtytwobitgarbage;
    alu aluPc(PcOut, 32'b1, 5'b0, fivebitgarbage, PcInAdd, garbage, garbage, garbage, garbage);
    wire [31:0] Pc1N, DX_PcP1;
    alu aluPCONEN(DX_PcP1, signextendimm, 5'b0, fivebitgarbage, Pc1N, garbage, garbage, garbage, garbage);
    wire finalraw;
    //Jump logic here
    //if DX is jt then set PC t
    wire [31:0] PcInJ, PcInJr, PcInB;
    wire isEqual = (DX_A == DX_B);
    wire beq = (DX_opcode == 5'b00010) && (isEqual);
    assign PcInJ = (DX_opcode == 5'b00001) |(DX_opcode == 5'b00011) | (DX_opcode == 5'b10110 & PCfinalALUB!=32'b0)? {5'b0, DX_IR[26:0]} : PcInAdd;
    assign PcInJr = (DX_opcode == 5'b00100)  ? PCfinalALUB : PcInJ; 
    // bne and blt logic
    assign PcInB = (((DX_opcode == 5'b00010) & (isEqual)) | ((DX_opcode == 5'b00110) & (!isLessThan) & isNotEqual) )? Pc1N : PcInJr;
    wire flushsignal;
    assign flushsignal = ((DX_opcode == 5'b00010) & (isNotEqual)) | ((DX_opcode == 5'b00110) & (!isLessThan) & isNotEqual)| (DX_opcode == 5'b00001) | (DX_opcode == 5'b00011) | (DX_opcode == 5'b00100) | (DX_opcode == 5'b10110);
    wire [31:0] PCaluB1 = ((DX_rt==MW_rd)& (DX_rt!=5'b0) & ctrl_writeEnable & (DX_opcode!=5'b00111)) ? data_writeReg : DX_B; 
    wire [31:0] PCfinalALUB = ((DX_rt == XM_rd) & (DX_rt!=5'b0) & XM_ctrlen & (DX_opcode!=5'b00111)) ? XM_O : PCaluB1; 
    assign PcIn = (DX_opcode == 5'b10110) & (PCfinalALUB != 32'b0) ? {5'b0, DX_IR[26:0]} : PcInB;
    wire reg_writeenable;
    PC pcreg(!clock, (reg_writeenable & !finalraw) , 1'b1, PcIn, PcOut, reset);

// INSTRUCTION MEMORY STAGE
    assign address_imem = PcOut;
    
// PC LATCH
    wire [63:0] regOutPCIR, regInPCIR1, regInPCIR;
    assign regInPCIR1 = {PcInAdd, q_imem};
    assign regInPCIR = flushsignal ? 64'b0 : regInPCIR1;
    sixtyfourbit_reg regPCIR(!clock, (reg_writeenable & !finalraw), 1'b1, regInPCIR, regOutPCIR, reset);

// FD STAGE
    wire [4:0] FD_rs, FD_rt, FD_rd, FD_opcode;
    wire [31:0] FD_PcP1, FD_IR;
    assign FD_PcP1 = regOutPCIR[63:32];
    assign FD_IR = regOutPCIR[31:0];
    assign FD_opcode = FD_IR[31:27];
    assign FD_rd = FD_IR[26:22];
    assign FD_rs = FD_IR[21:17];
    assign FD_rt = FD_IR[16:12];
    wire [16:0] FD_N;
    assign FD_N = FD_IR[16:0];

    // CONTROL STUFF FROM FDSTAGE TO REGFILE // 
    //RD is 9 for the keyboa9rd polling input thing 
    wire [4:0] FD_ctrlrs =  FD_rs;
    wire [4:0] FD_ctrlrt1 =(FD_opcode == 5'b00111) | (FD_opcode == 5'b00010) | (FD_opcode==5'b00100) | (FD_opcode ==5'b00110) ? FD_rd : FD_rt;
    // IF JAL THEN SET RT = 31
    wire [4:0] FD_ctrlrt2 = (FD_opcode == 5'b00011) ? 5'b11111 : FD_ctrlrt1;
    // if bex then set rt to 30
    wire [4:0] FD_ctrlrt = (FD_opcode == 5'b10110) ? 5'b11110 : FD_ctrlrt2;
    // if setx then set rd = 30 
    wire [4:0] FD_ctrlrd1 =(FD_opcode == 5'b00011) ? 5'b11111 : FD_rd;
    wire [4:0] FD_ctrlrd2 = (FD_opcode == 5'b10101) ? 5'b11110 : FD_ctrlrd1;
    wire [4:0] FD_ctrlrd = (FD_opcode == 5'b11000) ? 5'd9 : FD_ctrlrd2;

    // check for data hazards: then need to stall in the pipleine so that the dependent operations cant reach dx until data available.
    wire rawcheckrs1 =  (FD_ctrlrs == DX_rsrtrdout[4:0]) & FD_ctrlrs!=5'b0;  
    wire rawcheckrs2 =  (FD_ctrlrt == DX_rsrtrdout[4:0]) & FD_ctrlrt!=5'b0; 
    assign finalraw  =  (DX_opcode == 5'b01000) && (rawcheckrs1 || (rawcheckrs2 && (FD_opcode != 5'b00111)));

// REGFILE STAGE
    wire [31:0] FD_A, FD_B;
    assign ctrl_readRegA = FD_ctrlrs;
    assign ctrl_readRegB = FD_ctrlrt;
    assign FD_A = data_readRegA;
    assign FD_B = data_readRegB;

// LATCH BETWEEN REGFILE AND ALU - DX STAGE
    wire [127:0] regOutPCABIR, regInPCABIR1, regInPCABIR, regInPCABIR2;
    assign regInPCABIR1 = {FD_PcP1, FD_A, FD_B, FD_IR};
    assign regInPCABIR = (flushsignal | finalraw) ? 128'b0 : regInPCABIR1;
    onetwentyeightbit_reg regPCABIR(!clock, reg_writeenable, 1'b1, regInPCABIR, regOutPCABIR, reset);
    //changed for flushing here and stalling if there is a RAW
    wire [14:0] DX_rsrtrdin = (flushsignal | finalraw) ? 15'b0 : {FD_ctrlrs, FD_ctrlrt, FD_ctrlrd};
    wire [14:0] DX_rsrtrdout;
    RSRTRD DXRSRTRD(!clock, reg_writeenable, 1'b1, DX_rsrtrdin, DX_rsrtrdout, reset);

    wire [31:0] DX_A, DX_B, DX_IR;
    assign DX_PcP1 = regOutPCABIR[127:96]; // set r31 equal to this for jal
    assign DX_A = regOutPCABIR[95:64];
    assign DX_B = regOutPCABIR[63:32];
    assign DX_IR = regOutPCABIR[31:0];
    wire [4:0] DX_opcode;
    assign DX_opcode = DX_IR[31:27];
    wire [16:0] DX_N;
    assign DX_N = DX_IR[16:0];
    assign signextendimm = {{15{DX_N[16]}}, DX_N};
    wire [31:0] finalB;
    //poll keyboard instruction:
    wire        datareadysignal;
    
    // keyboard_input keyb(.ready(datareadysignal), .data(DX_keyboardout)); // MAKE SURE TO ADD STALL LOGIC FROM DATA READY LATER

    wire [7:0] kb_sampler_raw_out;
    // ps2_keyboard_sampler kb(.clk(clock), .reset(reset), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .char_out(kb_sampler_raw_out), .data_ready(datareadysignal));
    ps2_keyboard_sampler kb(.clk(clock), .reset(!(DX_opcode == 5'b11000)), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .char_out(kb_sampler_raw_out), .data_ready(datareadysignal)); // FOR TESTING ONLY

    wire [31:0] DX_keyboardout = {24'd0, kb_sampler_raw_out};


    // pen down instruction
    wire DX_pen_instruction = DX_opcode == 5'b11001;
    wire [31:0] desired_pen_state = {5'd0, DX_IR[26:0]};
    pen_driver pen(.pen_state(DX_pen_instruction ? desired_pen_state : 32'd0), .clk(clock), .servo_out(servo_out), .enable(DX_pen_instruction), .reset(reset));

    //addi, lw, sw
    assign finalB = (DX_opcode == 5'b00101) | (DX_opcode == 5'b00111) | (DX_opcode == 5'b01000) | (DX_opcode == 5'b00100) ? signextendimm : DX_B;
    wire [4:0] DX_ALUopcode1, DX_ALUopcode;
    assign DX_ALUopcode1 = (DX_opcode == 5'b00101) | (DX_opcode == 5'b00111) | (DX_opcode == 5'b01000) | (DX_opcode == 5'b00100) ? 5'b0 : DX_IR[6:2];
    assign DX_ALUopcode = ((DX_opcode == 5'b00110) | (DX_opcode == 5'b00010)) ? 5'b1 : DX_ALUopcode1;
    wire [4:0] DX_rd;
    assign DX_rd = DX_rsrtrdout[4:0];
    
    // forwarding logic:
    wire [31:0] finalALUA, finalALUB, aluA1, aluB1; 
    wire [4:0] DX_rs = DX_rsrtrdout[14:10];
    wire [4:0] DX_rt = DX_rsrtrdout[9:5];
    wire [4:0] MW_rd = MW_rsrtrdout[4:0];
    wire [4:0] XM_rd = XM_rsrtrdout[4:0];
    
    wire XM_ctrlen = (XM_opcode == 5'b0) | (XM_opcode == 5'b00101) | (XM_opcode == 5'b00011) | (XM_opcode == 5'b01000)| (XM_opcode == 5'b10101) | (XM_opcode==5'b11000);
    wire DX_jal = (DX_opcode == 5'b00011) ? DX_IR[26:0] : XM_O;
   
    assign aluA1 = ((DX_rs == MW_rd) & (DX_rs!=5'b0) & ctrl_writeEnable) ? data_writeReg: DX_A; 
    assign finalALUA =  (((DX_rs == XM_rd) & (DX_rs!=5'b0)) & XM_ctrlen) ? XM_O : aluA1;
    assign aluB1 = ((DX_rt==MW_rd)& (DX_rt!=5'b0) & ctrl_writeEnable & (DX_opcode!=5'b00111)) ? data_writeReg : finalB; 
    assign finalALUB = ((DX_rt == XM_rd) & (DX_rt!=5'b0) & XM_ctrlen & (DX_opcode!=5'b00111)) ? XM_O : aluB1; 

    wire DX_overflow;
    wire [31:0] DX_aluOut, DX_aluOut1; 
    wire [4:0] DX_shmt;
    assign DX_shmt = DX_IR[11:7];
    wire isNotEqual,isLessThan;
    alu mainalu(finalALUA, finalALUB, DX_ALUopcode, DX_shmt, DX_aluOut1, isNotEqual, isLessThan, DX_overflow, garbage);

    // multdiv implenentation here:
    wire ctrl_MULT, ctrl_DIV, DX_multoverflow, data_resultRDY, qmult, qdiv;
    wire [31:0] DX_multout, multout;
    dffe_ref statemult(qmult,((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110)), clock, 1'b1, reset);
    assign ctrl_MULT = (DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110) & !qmult;
    dffe_ref statediv(qdiv,((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00111)), clock, 1'b1, reset);
    assign ctrl_DIV = (DX_opcode == 5'b0) & (DX_ALUopcode==5'b00111) & !qdiv;
 
    wire hw_master_done; // MAY NEED AN ENABLE SIGNAL FOR THE HW MASTER
    wire [31:0] DX_delta_X, DX_delta_Y;

    wire DX_move_insn = (DX_opcode == 5'b00000) && (DX_ALUopcode == 5'b11111);
    wire [3:0] motor_outX_temp, motor_outY_temp;
    
    assign LED = DX_move_insn ? 1'b1 : 1'b0;
    
    hardware_master steppers(.clk(clock), .reset_n(DX_move_insn), .done_out(hw_master_done), .delta_X(DX_move_insn ? DX_A : 32'd0), .delta_Y(DX_move_insn ? DX_B : 32'd0), .motor_outX(motor_outX_temp), .motor_outY(motor_outY_temp));



    assign motor_outX = DX_move_insn ? motor_outX_temp : 4'b0000;
    assign motor_outY = DX_move_insn ? motor_outY_temp : 4'b0000;


    // Stall for multdiv and HARDWARE MASTER here
    // multdiv multdivmodule(finalALUA, finalALUB, ctrl_MULT, ctrl_DIV, clock, DX_multout, DX_multoverflow, data_resultRDY);
    wire reg_writeenable1;
    assign reg_writeenable1 = ((((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110)) | ((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00111))) & data_resultRDY) || ((DX_move_insn) && hw_master_done) || ((DX_opcode == 5'b11000) && datareadysignal) ? 1'b1 : 1'b0; // STALL UNTIL HARDWARE MASTER IS DONE
    assign reg_writeenable = (((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110)) | ((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00111))) || (DX_move_insn) || (DX_opcode == 5'b11000) ? reg_writeenable1 : 1'b1;
    
    
    //overflow logic written 
    wire [31:0] addoverflow, addioverflow, suboverflow, setxout, multoutoverflow, divoutoverflow;
    assign addoverflow = DX_overflow & (DX_ALUopcode == 5'b0) & (DX_opcode == 5'b0) ? 32'd1 : DX_aluOut1;
    assign addioverflow = DX_overflow & (DX_opcode == 5'b00101) ? 32'd2 : addoverflow;
    assign suboverflow = DX_overflow & (DX_ALUopcode == 5'b01) & (DX_opcode == 5'b0) ? 32'd3 : addioverflow;
    assign setxout = (DX_opcode == 5'b10101) ? {5'b0, DX_IR[26:0]} : suboverflow;
    assign multout = (DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110 | DX_ALUopcode==5'b00111) & !DX_multoverflow ? DX_multout : setxout;
    assign multoutoverflow = (DX_opcode == 5'b0) & DX_ALUopcode==5'b00110 & DX_multoverflow ? 32'd4 : multout;
    assign divoutoverflow = (DX_opcode == 5'b0) & (DX_ALUopcode==5'b00111 & DX_multoverflow) ? 32'd5 : multoutoverflow;
    assign DX_aluOut = (DX_opcode == 5'b11000) ? DX_keyboardout : divoutoverflow;
    // assign DX_aluOut = divoutoverflow; //(DX_opcode == 5'b11000) ? DX_keyboardout : DX_aluOut1; 
    wire [4:0] overflowornotrd = (DX_overflow | (DX_multoverflow & data_resultRDY & ((DX_opcode == 5'b0) & (DX_ALUopcode==5'b00110 | DX_ALUopcode==5'b00111)) )) ? 5'b11110 : DX_rd;
    wire [14:0] XM_rsrtrdin = {DX_rsrtrdout[14:5], overflowornotrd};

// X/M STAGE LATCH 
    wire [127:0] regInOBIR, regOutOBIR;
    // need logic for DX_B bypassing when rt is not going into the ALU 
    wire [4:0] MW_rt = MW_rsrtrdout[9:5];
    wire [31:0] regInOBIRB1 = ((DX_rt==MW_rd)& (DX_rt!=5'b0) & ctrl_writeEnable) ? data_writeReg : DX_B; 
    wire [31:0] regInOBIRB = ((DX_rt == XM_rt) & (DX_rt!=5'b0) & XM_ctrlen) ? XM_O : regInOBIRB1; 

    assign regInOBIR = {DX_PcP1, DX_aluOut, regInOBIRB, DX_IR};
    onetwentyeightbit_reg regOBIR(!clock, reg_writeenable, 1'b1, regInOBIR, regOutOBIR, reset); 
    wire [14:0] XM_rsrtrdout;
    RSRTRD XMRSRTRD(!clock, reg_writeenable, 1'b1, XM_rsrtrdin, XM_rsrtrdout, reset);
    wire [31:0] XM_O, XM_B, XM_IR, XM_PcP1;
    assign XM_PcP1 = regOutOBIR[127:96];
    assign XM_O = regOutOBIR[95:64]; 
    assign XM_B = regOutOBIR[63:32];
    assign XM_IR = regOutOBIR[31:0];
    wire [4:0] XM_opcode;
    assign XM_opcode = XM_IR[31:27];
    assign address_dmem = XM_O; 
    assign wren = (XM_opcode == 5'b00111);
    wire [4:0] XM_rt = XM_rsrtrdout[9:5];
    assign data = ((XM_rt == MW_rd) & (XM_rt != 5'b0) & ctrl_writeEnable)  ? data_writeReg : XM_B; 
    
//MW STAGE LATCH 
    wire [127:0] regInODIR, regOutODIR;
    assign regInODIR = {XM_PcP1, XM_O, q_dmem, XM_IR};
    onetwentyeightbit_reg regMWIR(!clock, reg_writeenable, 1'b1, regInODIR, regOutODIR, reset); 
    wire [14:0] MW_rsrtrdout;
    RSRTRD MWRSRTRD(!clock, reg_writeenable, 1'b1, XM_rsrtrdout, MW_rsrtrdout, reset);
    wire [31:0] MW_PcP1, MW_O, MW_B, MW_IR;
    assign MW_PcP1 = regOutODIR[127:96];
    assign MW_O = regOutODIR[95:64];
    assign MW_B = regOutODIR[63:32];
    assign MW_IR = regOutODIR[31:0];
    wire [4:0] MW_opcode; 
    assign MW_opcode = MW_IR[31:27];
    wire islw;
    assign islw = (!MW_opcode[0] & !MW_opcode[1] & !MW_opcode[2] & MW_opcode[3] & !MW_opcode[4]);
    wire [31:0] data_writeReg1;
    assign data_writeReg1 = islw ? MW_B : MW_O;
    // jal bypass here: 
    assign data_writeReg = (MW_opcode == 5'b00011) ? MW_PcP1 : data_writeReg1;
    // add addi lw jal
    assign ctrl_writeEnable = (MW_opcode == 5'b0) | (MW_opcode == 5'b00101) | (MW_opcode == 5'b01000) | (MW_opcode == 5'b00011) | (MW_opcode == 5'b10101) | (MW_opcode == 5'b11000);
    assign ctrl_writeReg = (MW_opcode != 5'b00011) ? MW_rsrtrdout[4:0] : 5'b11111;

endmodule