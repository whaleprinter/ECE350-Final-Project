module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB; //(RD), RS1, RS2
	input [31:0] data_writeReg; //RDVAL 

	output [31:0] data_readRegA, data_readRegB; //RS1VAL, RS2VAL

	wire [31:0] decoderbig;
	assign decoderbig = 32'b1 << ctrl_writeReg;

	wire input_enable1, input_enable2, input_enable3, input_enable4, input_enable5, input_enable6, input_enable7, input_enable8, input_enable9, input_enable10, input_enable11, input_enable12, input_enable13, input_enable14, input_enable15, input_enable16, input_enable17, input_enable18, input_enable19, input_enable20, input_enable21, input_enable22, input_enable23, input_enable24, input_enable25, input_enable26, input_enable27, input_enable28, input_enable29, input_enable30, input_enable31, input_enable32;
	//and and1 (input_enable1,  ctrl_writeEnable, decoderbig[0]);
	and and2 (input_enable2,  ctrl_writeEnable, decoderbig[1]);
	and and3 (input_enable3,  ctrl_writeEnable, decoderbig[2]);
	and and4 (input_enable4,  ctrl_writeEnable, decoderbig[3]);
	and and5 (input_enable5,  ctrl_writeEnable, decoderbig[4]);
	and and6 (input_enable6,  ctrl_writeEnable, decoderbig[5]);
	and and7 (input_enable7,  ctrl_writeEnable, decoderbig[6]);
	and and8 (input_enable8,  ctrl_writeEnable, decoderbig[7]);
	and and9  (input_enable9,  ctrl_writeEnable, decoderbig[8]);
	and and10 (input_enable10, ctrl_writeEnable, decoderbig[9]);
	and and11 (input_enable11, ctrl_writeEnable, decoderbig[10]);
	and and12 (input_enable12, ctrl_writeEnable, decoderbig[11]);
	and and13 (input_enable13, ctrl_writeEnable, decoderbig[12]);
	and and14 (input_enable14, ctrl_writeEnable, decoderbig[13]);
	and and15 (input_enable15, ctrl_writeEnable, decoderbig[14]);
	and and16 (input_enable16, ctrl_writeEnable, decoderbig[15]);
	and and17 (input_enable17, ctrl_writeEnable, decoderbig[16]);
	and and18 (input_enable18, ctrl_writeEnable, decoderbig[17]);
	and and19 (input_enable19, ctrl_writeEnable, decoderbig[18]);
	and and20 (input_enable20, ctrl_writeEnable, decoderbig[19]);
	and and21 (input_enable21, ctrl_writeEnable, decoderbig[20]);
	and and22 (input_enable22, ctrl_writeEnable, decoderbig[21]);
	and and23 (input_enable23, ctrl_writeEnable, decoderbig[22]);
	and and24 (input_enable24, ctrl_writeEnable, decoderbig[23]);
	and and25 (input_enable25, ctrl_writeEnable, decoderbig[24]);
	and and26 (input_enable26, ctrl_writeEnable, decoderbig[25]);
	and and27 (input_enable27, ctrl_writeEnable, decoderbig[26]);
	and and28 (input_enable28, ctrl_writeEnable, decoderbig[27]);
	and and29 (input_enable29, ctrl_writeEnable, decoderbig[28]);
	and and30 (input_enable30, ctrl_writeEnable, decoderbig[29]);
	and and31 (input_enable31, ctrl_writeEnable, decoderbig[30]);
	and and32 (input_enable32, ctrl_writeEnable, decoderbig[31]);

	wire clr; 
	assign clr = ctrl_reset;
	wire [31:0] output1, output2, output3, output4, output5, output6, output7, output8, output9, output10, output11, output12, output13, output14, output15, output16, output17, output18, output19, output20, output21, output22, output23, output24, output25, output26, output27, output28, output29, output30, output31, output32;
	//one_reg first       (clock, input_enable1,  1'b1, data_writeReg[31:0], output1);
	one_reg second      (clock, input_enable2,  1'b1, data_writeReg[31:0], output2, clr);
	one_reg third       (clock, input_enable3,  1'b1, data_writeReg[31:0], output3, clr);
	one_reg fourth      (clock, input_enable4,  1'b1, data_writeReg[31:0], output4, clr);
	one_reg fifth       (clock, input_enable5,  1'b1, data_writeReg[31:0], output5, clr);
	one_reg sixth       (clock, input_enable6,  1'b1, data_writeReg[31:0], output6, clr);
	one_reg seventh     (clock, input_enable7,  1'b1, data_writeReg[31:0], output7, clr);
	one_reg eighth      (clock, input_enable8,  1'b1, data_writeReg[31:0], output8, clr);
	one_reg ninth       (clock, input_enable9,  1'b1, data_writeReg[31:0], output9, clr);
	one_reg tenth       (clock, input_enable10, 1'b1, data_writeReg[31:0], output10, clr);
	one_reg eleventh    (clock, input_enable11, 1'b1, data_writeReg[31:0], output11, clr);
	one_reg twelfth     (clock, input_enable12, 1'b1, data_writeReg[31:0], output12, clr);
	one_reg thirteenth  (clock, input_enable13, 1'b1, data_writeReg[31:0], output13, clr);
	one_reg fourteenth  (clock, input_enable14, 1'b1, data_writeReg[31:0], output14, clr);
	one_reg fifteenth   (clock, input_enable15, 1'b1, data_writeReg[31:0], output15, clr);
	one_reg sixteenth   (clock, input_enable16, 1'b1, data_writeReg[31:0], output16, clr);
	one_reg seventeenth (clock, input_enable17, 1'b1, data_writeReg[31:0], output17, clr);
	one_reg eighteenth  (clock, input_enable18, 1'b1, data_writeReg[31:0], output18, clr);
	one_reg nineteenth  (clock, input_enable19, 1'b1, data_writeReg[31:0], output19, clr);
	one_reg twentieth   (clock, input_enable20, 1'b1, data_writeReg[31:0], output20, clr);
	one_reg twentyfirst (clock, input_enable21, 1'b1, data_writeReg[31:0], output21, clr);
	one_reg twentysecond(clock, input_enable22, 1'b1, data_writeReg[31:0], output22, clr);
	one_reg twentythird (clock, input_enable23, 1'b1, data_writeReg[31:0], output23, clr);
	one_reg twentyfourth(clock, input_enable24, 1'b1, data_writeReg[31:0], output24, clr);
	one_reg twentyfifth (clock, input_enable25, 1'b1, data_writeReg[31:0], output25, clr);
	one_reg twentysixth (clock, input_enable26, 1'b1, data_writeReg[31:0], output26, clr);
	one_reg twentyseventh(clock, input_enable27,1'b1, data_writeReg[31:0], output27, clr);
	one_reg twentyeighth(clock, input_enable28, 1'b1, data_writeReg[31:0], output28, clr);
	one_reg twentyninth (clock, input_enable29, 1'b1, data_writeReg[31:0], output29, clr);
	one_reg thirtieth   (clock, input_enable30, 1'b1, data_writeReg[31:0], output30, clr);
	one_reg thirtyfirst (clock, input_enable31, 1'b1, data_writeReg[31:0], output31, clr);
	one_reg thirtysecond(clock, input_enable32, 1'b1, data_writeReg[31:0], output32, clr);

	wire [31:0] rs1;
	assign rs1 = 32'b1 << ctrl_readRegA;
	assign data_readRegA = rs1[0]  ? 32'b0  : 32'bz;
	assign data_readRegA = rs1[1]  ? output2  : 32'bz;
	assign data_readRegA = rs1[2]  ? output3  : 32'bz;
	assign data_readRegA = rs1[3]  ? output4  : 32'bz;
	assign data_readRegA = rs1[4]  ? output5  : 32'bz;
	assign data_readRegA = rs1[5]  ? output6  : 32'bz;
	assign data_readRegA = rs1[6]  ? output7  : 32'bz;
	assign data_readRegA = rs1[7]  ? output8  : 32'bz;
	assign data_readRegA = rs1[8]  ? output9  : 32'bz;
	assign data_readRegA = rs1[9]  ? output10 : 32'bz;
	assign data_readRegA = rs1[10] ? output11 : 32'bz;
	assign data_readRegA = rs1[11] ? output12 : 32'bz;
	assign data_readRegA = rs1[12] ? output13 : 32'bz;
	assign data_readRegA = rs1[13] ? output14 : 32'bz;
	assign data_readRegA = rs1[14] ? output15 : 32'bz;
	assign data_readRegA = rs1[15] ? output16 : 32'bz;
	assign data_readRegA = rs1[16] ? output17 : 32'bz;
	assign data_readRegA = rs1[17] ? output18 : 32'bz;
	assign data_readRegA = rs1[18] ? output19 : 32'bz;
	assign data_readRegA = rs1[19] ? output20 : 32'bz;
	assign data_readRegA = rs1[20] ? output21 : 32'bz;
	assign data_readRegA = rs1[21] ? output22 : 32'bz;
	assign data_readRegA = rs1[22] ? output23 : 32'bz;
	assign data_readRegA = rs1[23] ? output24 : 32'bz;
	assign data_readRegA = rs1[24] ? output25 : 32'bz;
	assign data_readRegA = rs1[25] ? output26 : 32'bz;
	assign data_readRegA = rs1[26] ? output27 : 32'bz;
	assign data_readRegA = rs1[27] ? output28 : 32'bz;
	assign data_readRegA = rs1[28] ? output29 : 32'bz;
	assign data_readRegA = rs1[29] ? output30 : 32'bz;
	assign data_readRegA = rs1[30] ? output31 : 32'bz;
	assign data_readRegA = rs1[31] ? output32 : 32'bz;

	wire [31:0] rs2;
	assign rs2 = 32'b1 << ctrl_readRegB;
	assign data_readRegB = rs2[0]  ? 32'b0 : 32'bz;
	assign data_readRegB = rs2[1]  ? output2  : 32'bz;
	assign data_readRegB = rs2[2]  ? output3  : 32'bz;
	assign data_readRegB = rs2[3]  ? output4  : 32'bz;
	assign data_readRegB = rs2[4]  ? output5  : 32'bz;
	assign data_readRegB = rs2[5]  ? output6  : 32'bz;
	assign data_readRegB = rs2[6]  ? output7  : 32'bz;
	assign data_readRegB = rs2[7]  ? output8  : 32'bz;
	assign data_readRegB = rs2[8]  ? output9  : 32'bz;
	assign data_readRegB = rs2[9]  ? output10 : 32'bz;
	assign data_readRegB = rs2[10] ? output11 : 32'bz;
	assign data_readRegB = rs2[11] ? output12 : 32'bz;
	assign data_readRegB = rs2[12] ? output13 : 32'bz;
	assign data_readRegB = rs2[13] ? output14 : 32'bz;
	assign data_readRegB = rs2[14] ? output15 : 32'bz;
	assign data_readRegB = rs2[15] ? output16 : 32'bz;
	assign data_readRegB = rs2[16] ? output17 : 32'bz;
	assign data_readRegB = rs2[17] ? output18 : 32'bz;
	assign data_readRegB = rs2[18] ? output19 : 32'bz;
	assign data_readRegB = rs2[19] ? output20 : 32'bz;
	assign data_readRegB = rs2[20] ? output21 : 32'bz;
	assign data_readRegB = rs2[21] ? output22 : 32'bz;
	assign data_readRegB = rs2[22] ? output23 : 32'bz;
	assign data_readRegB = rs2[23] ? output24 : 32'bz;
	assign data_readRegB = rs2[24] ? output25 : 32'bz;
	assign data_readRegB = rs2[25] ? output26 : 32'bz;
	assign data_readRegB = rs2[26] ? output27 : 32'bz;
	assign data_readRegB = rs2[27] ? output28 : 32'bz;
	assign data_readRegB = rs2[28] ? output29 : 32'bz;
	assign data_readRegB = rs2[29] ? output30 : 32'bz;
	assign data_readRegB = rs2[30] ? output31 : 32'bz;
	assign data_readRegB = rs2[31] ? output32 : 32'bz;
endmodule