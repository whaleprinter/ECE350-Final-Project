`timescale 1ns/1ps
module ServoController(
    input        clk,          
    input [31:0] servo_setting, 
    output       servoSignal   
);
    
    wire [9:0] duty_cycle;


    wire [9:0] pen_up   = 10'd51;
    wire [9:0] pen_down = 10'd61;

    assign duty_cycle = (servo_setting == 32'd1) ? pen_down : pen_up;

    PWMSerializer #(
        .PERIOD_WIDTH_NS(20_000_000),
        .SYS_FREQ_MHZ(40)
    ) pwm_gen (
        .clk(clk),
        .reset(1'b0),
        .duty_cycle(duty_cycle),
        .signal(servoSignal)
    );

endmodule
