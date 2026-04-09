module pen_driver(
    input  clk,  
    input  [31:0] pen_state,
    output servo_out,
    input enable,
    input reset
);

    wire clk40;
    wire locked;
    wire pen_state_out;
    dffe_ref pen_state_mem(.q(pen_state_out), .d(pen_state), .clk(clk), .en(enable), .clr(reset));

    // // Clock generator 100 → 40 MHz
    // clk_wiz_0 clkgen (
    //     .clk_in1(clk),
    //     .clk_out1(clk40),
    //     .reset(1'b0),
    //     .locked(locked)
    // ); // DON'T FORGET ABOUT THIS PLL!!!!!

    // Servo controller
    ServoController servo(
        .clk(clk), // SHOULD BE clk40
        .servo_setting(pen_state_out),
        .servoSignal(servo_out)
    );

endmodule
