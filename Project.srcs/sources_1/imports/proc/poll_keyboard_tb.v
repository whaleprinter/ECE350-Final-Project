`timescale 1ns/1ps

module poll_keyboard_tb;

    reg clock, reset;

    // Instruction and data memory (simple behavioral)
    reg [31:0] imem [0:255];
    reg [31:0] dmem [0:255];

    // Processor I/O
    wire [31:0] address_imem;
    wire [31:0] q_imem;

    wire [31:0] address_dmem, data;
    wire wren;
    wire [31:0] q_dmem;

    wire        ctrl_writeEnable;
    wire [4:0]  ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;

    // FAKE keyboard driver
    reg        kb_ready;
    reg [31:0] kb_data;

    //-----------------------------------------
    // Instantiate the processor
    //-----------------------------------------
    processor DUT(
        .clock(clock),
        .reset(reset),

        .address_imem(address_imem),
        .q_imem(q_imem),

        .address_dmem(address_dmem),
        .data(data),
        .wren(wren),
        .q_dmem(q_dmem),

        .ctrl_writeEnable(ctrl_writeEnable),
        .ctrl_writeReg(ctrl_writeReg),
        .ctrl_readRegA(ctrl_readRegA),
        .ctrl_readRegB(ctrl_readRegB),
        .data_writeReg(data_writeReg),
        .data_readRegA(data_readRegA),
        .data_readRegB(data_readRegB)
    );

    //-----------------------------------------
    // Override internal keyboard wires
    //
    // Your processor contains:
    //      keyboard_input keyb(datareadysignal, dataoutput);
    //
    // So we override:
    //      DUT.datareadysignal
    //      DUT.dataoutput
    //-----------------------------------------

    assign DUT.datareadysignal = kb_ready;
    assign DUT.dataoutput      = kb_data;

    //-----------------------------------------
    // IMEM / DMEM behavior
    //-----------------------------------------

    assign q_imem = imem[address_imem];
    assign q_dmem = dmem[address_dmem];

    always @(posedge clock) begin
        if (wren) begin
            dmem[address_dmem] <= data;
            $display("DMEM WRITE: addr=%d data=%d", address_dmem, data);
        end
    end

    //-----------------------------------------
    // Fake regfile behavior
    //-----------------------------------------

    reg [31:0] regfile [0:31];

    assign data_readRegA = regfile[ctrl_readRegA];
    assign data_readRegB = regfile[ctrl_readRegB];

    always @(posedge clock) begin
        if (ctrl_writeEnable) begin
            regfile[ctrl_writeReg] <= data_writeReg;
            $display("REG WRITE: r%d = %d", ctrl_writeReg, data_writeReg);
        end
    end

    //-----------------------------------------
    // Clock
    //-----------------------------------------
    always #5 clock = ~clock;

    //-----------------------------------------
    // Test sequence
    //-----------------------------------------
    initial begin
        $dumpfile("poll_tb.vcd");
        $dumpvars(0, poll_keyboard_tb);

        clock = 0;
        reset = 1;
        kb_ready = 0;
        kb_data  = 32'd0;

        #20 reset = 0;

        // program:
        // poll
        // sw r9, 0(r0)
        // nop

        imem[0] = 32'b11000_00000_00000_00000000000000000;       // POLL
        imem[1] = {5'b00111, 5'd0, 5'd9, 17'd0};                 // sw r9, 0(r0)
        imem[2] = 32'b0;

        // after some cycles, keyboard produces data
        #30 kb_data = 32'd12345;
        kb_ready = 1;
        #20 kb_ready = 0;

        #200;

        $display("FINAL DMEM[0] = %d", dmem[0]);
        $finish;
    end

endmodule
