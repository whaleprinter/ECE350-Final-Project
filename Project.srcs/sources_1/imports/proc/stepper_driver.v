`timescale 1ns/100ps

module stepper_driver(
    input wire clk,
    input wire reset_n,
    input wire [1:0] direction,
    input wire [31:0] steps,
    input wire [7:0] feedrate,
    output wire busy_out,
    output wire done_out, 
    output reg [3:0] motor_out);
    
    initial begin
        motor_out = 4'b0000;
    end
    

    
    // clk_wiz_0 pll(.clk_out1(clk), .reset(reset_n), .locked(locked), .clk_in1(clk_100mhz));
   

   // AXIS CONTROLLER

    // Clock 
    wire new_clk;
    clock_div clock_Div(.clk(clk), .rst(!reset_n), .new_clk(new_clk), .feedrate(feedrate));
    reg[1:0] state = 2'b00;
    
	// Steps to clicks (signals) conversion
    reg[31:0] clicks; 
    reg[31:0] clicks_taken = 32'd0;
    reg keep_moving;
    reg busy;
    reg done;
    reg movement;

    assign busy_out = busy;
    assign done_out = done;
    // Should the axis move?
    always @(*) begin
        // compute desired total clicks
        clicks = steps * 4;
        keep_moving = (clicks_taken < clicks);
        // Axis should move only if direction valid AND still not finished
        movement = ((direction == 2'b01) || (direction == 2'b10))  && keep_moving;
        
    end
    
    // On every new clock cycle rising edge, do state change stuff
    always @(posedge new_clk or negedge reset_n) begin
        // Reset pressed  
        if (!reset_n) begin 
            clicks_taken <= 0;
            busy <= 0;
            state <= 2'b00;
            done <= 0;
        end else begin 
            
            // Otherwise, check to see if motor is moving/busy 
            // If not busy and need to keep moving, set to busy and continue
            if (!busy && keep_moving) begin 
                busy <= 1;
                state <= 2'b00;
                done <= 0;
            end else if (busy) begin
                // If busy, then move in the correct direction depending on direction field
                if (direction == 2'b01) begin 
                    state <= state + 1;
                    clicks_taken <= clicks_taken + 1;
                end else if (direction == 2'b10) begin
                    state <= state - 1;
                    clicks_taken <= clicks_taken + 1;
                end 
                // If reached end of desired clicks, stop, set busy to 0, done to 1
                if (clicks_taken + 1 >= clicks) begin
                    busy <= 0;
                    done <= 1;
                end
            // Otherwise, state is just 00. Do nothing
            end 
           else begin 
                   state <= 2'b00;
           end
        end 
          
    end

    // Stepper driver FSM. 
    always @(posedge new_clk) begin 
        if (movement) begin 
        case (state) 
            2'b00: motor_out <= 4'b0101;
            2'b01: motor_out <= 4'b1001;
            2'b10: motor_out <= 4'b1010;
            2'b11: motor_out <= 4'b0110;
            default: motor_out <= 4'b0000;
        endcase
        end else begin
            motor_out <= 4'b0000;
        end
    end
    
endmodule