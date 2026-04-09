`timescale 1ns/1ps

module hardware_master(
    input wire clk,
    input wire reset_n,
    input wire signed [31:0] delta_X,
    input wire signed [31:0] delta_Y,
    output wire busy_out,
    output wire done_out,
    output wire [3:0] motor_outX,
    output wire [3:0] motor_outY
    );

    

    reg [7:0] default_feedrate = 255;
    reg [31:0] steps_X, steps_Y;
    reg [7:0] feedrate_X, feedrate_Y;
    reg [1:0] dir_X, dir_Y;
    wire busy_X, busy_Y, done_X, done_Y;
    reg busy, done;

    assign busy_out = busy;
    assign done_out = done;
    wire done_X_raw, done_Y_raw;

    reg [31:0] max_delta;
    
    assign done_X = (steps_X == 0) ? 1 : done_X_raw;
    assign done_Y = (steps_Y == 0) ? 1 : done_Y_raw;

    always @(*) begin 
        // Calculate which axis has the biggest delta
        max_delta = (delta_X > delta_Y) ? delta_X : delta_Y;
        
        // Set the direction of the steppers depending on the sign of the input deltas. If direction = 0, send stepper 2'b00 (off)
        dir_X = (delta_X != 0) ? ((delta_X < 0) ? 2'b10 : 2'b01) : 2'b00;
        dir_Y = (delta_Y != 0) ? ((delta_Y < 0) ? 2'b10 : 2'b01) : 2'b00;



        // Calculate absolute value of the steps
        steps_X = (delta_X < 0 ) ? -delta_X : delta_X;
        steps_Y = (delta_Y < 0 ) ? -delta_Y : delta_Y;
        
        // // Set the feedrate of the steppers based off the longer axis having the higher feedrate
        // if (steps_X >= steps_Y) begin
            
        //     feedrate_X = default_feedrate;
        //     feedrate_Y = (steps_Y != 0) ? (default_feedrate * steps_Y / steps_X) : 0;
        // end else begin
        //     feedrate_Y = default_feedrate;
        //     feedrate_X = (steps_X != 0) ? (default_feedrate * steps_X / steps_Y) : 0;
        // end


        
        busy = busy_X || busy_Y;
        
        done = done_X && done_Y;
    end


    wire [3:0] motor_out_correct_X, motor_out_correct_Y;

    assign motor_outX = (dir_X == 2'b00) ? 4'b0000 : motor_out_correct_X;
    assign motor_outY = (dir_Y == 2'b00) ? 4'b0000 : motor_out_correct_Y;


    stepper_driver driver_X(
        .clk(clk),
        .busy_out(busy_X),
        .done_out(done_X_raw),
        .reset_n(reset_n),
        .direction(dir_X),
        .steps(steps_X),
        .feedrate(8'd255),
        .motor_out(motor_out_correct_X)
    );

    stepper_driver driver_Y(
        .clk(clk),
        .busy_out(busy_Y),
        .done_out(done_Y_raw),
        .reset_n(reset_n),
        .direction(dir_Y),
        .steps(steps_Y),
        .feedrate(8'd255),
        .motor_out(motor_out_correct_Y)
    );

endmodule