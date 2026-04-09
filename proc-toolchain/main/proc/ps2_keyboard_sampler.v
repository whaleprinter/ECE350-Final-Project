`timescale 1ns/1ps

module ps2_keyboard_sampler(
    input  wire clk,
    input  wire reset,


    input  wire PS2_CLK,
    input  wire PS2_DATA,


    output reg  [7:0] char_out,     
    output reg        data_ready, 
    output reg        enter_pressed 
);

    wire rx_done_tick;
    wire [7:0] scan_code;

    ps2_rx ps2_rx_inst (
        .clk(clk),
        .reset(!reset),
        .ps2d(PS2_DATA),
        .ps2c(PS2_CLK),
        .rx_en(1'b1),
        .rx_done_tick(rx_done_tick),
        .dout(scan_code)
    );

    reg break_flag;

    function [7:0] scan_to_ascii(input [7:0] sc);
        case(sc)
            // 8'h1C: scan_to_ascii = "a";
            // 8'h32: scan_to_ascii = "b";
            // 8'h21: scan_to_ascii = "c";
            // 8'h23: scan_to_ascii = "d";
            // 8'h24: scan_to_ascii = "e";
            // 8'h2B: scan_to_ascii = "f";
            // 8'h34: scan_to_ascii = "g";
            // 8'h33: scan_to_ascii = "h";
            // 8'h43: scan_to_ascii = "i";
            // 8'h3B: scan_to_ascii = "j";
            // 8'h42: scan_to_ascii = "k";
            // 8'h4B: scan_to_ascii = "l";
            // 8'h3A: scan_to_ascii = "m";
            // 8'h31: scan_to_ascii = "n";
            // 8'h44: scan_to_ascii = "o";
            // 8'h4D: scan_to_ascii = "p";
            // 8'h15: scan_to_ascii = "q";
            // 8'h2D: scan_to_ascii = "r";
            // 8'h1B: scan_to_ascii = "s";
            // 8'h2C: scan_to_ascii = "t";
            // 8'h3C: scan_to_ascii = "u";
            // 8'h2A: scan_to_ascii = "v";
            // 8'h1D: scan_to_ascii = "w";
            // 8'h22: scan_to_ascii = "x";
            // 8'h35: scan_to_ascii = "y";
            // 8'h1A: scan_to_ascii = "z";

            8'h1C: scan_to_ascii = 8'd97;   // a
            8'h32: scan_to_ascii = 8'd98;   // b
            8'h21: scan_to_ascii = 8'd99;   // c
            8'h23: scan_to_ascii = 8'd100;  // d
            8'h24: scan_to_ascii = 8'd101;  // e
            8'h2B: scan_to_ascii = 8'd102;  // f
            8'h34: scan_to_ascii = 8'd103;  // g
            8'h33: scan_to_ascii = 8'd104;  // h
            8'h43: scan_to_ascii = 8'd105;  // i
            8'h3B: scan_to_ascii = 8'd106;  // j
            8'h42: scan_to_ascii = 8'd107;  // k
            8'h4B: scan_to_ascii = 8'd108;  // l
            8'h3A: scan_to_ascii = 8'd109;  // m
            8'h31: scan_to_ascii = 8'd110;  // n
            8'h44: scan_to_ascii = 8'd111;  // o
            8'h4D: scan_to_ascii = 8'd112;  // p
            8'h15: scan_to_ascii = 8'd113;  // q
            8'h2D: scan_to_ascii = 8'd114;  // r
            8'h1B: scan_to_ascii = 8'd115;  // s
            8'h2C: scan_to_ascii = 8'd116;  // t
            8'h3C: scan_to_ascii = 8'd117;  // u
            8'h2A: scan_to_ascii = 8'd118;  // v
            8'h1D: scan_to_ascii = 8'd119;  // w
            8'h22: scan_to_ascii = 8'd120;  // x
            8'h35: scan_to_ascii = 8'd121;  // y
            8'h1A: scan_to_ascii = 8'd122;  // z


            // numbers
            // 8'h45: scan_to_ascii = "0";
            // 8'h16: scan_to_ascii = "1";
            // 8'h1E: scan_to_ascii = "2";
            // 8'h26: scan_to_ascii = "3";
            // 8'h25: scan_to_ascii = "4";
            // 8'h2E: scan_to_ascii = "5";
            // 8'h36: scan_to_ascii = "6";
            // 8'h3D: scan_to_ascii = "7";
            // 8'h3E: scan_to_ascii = "8";
            // 8'h46: scan_to_ascii = "9";

            8'h45: scan_to_ascii = 8'd48;   // 0
            8'h16: scan_to_ascii = 8'd49;   // 1
            8'h1E: scan_to_ascii = 8'd50;   // 2
            8'h26: scan_to_ascii = 8'd51;   // 3
            8'h25: scan_to_ascii = 8'd52;   // 4
            8'h2E: scan_to_ascii = 8'd53;   // 5
            8'h36: scan_to_ascii = 8'd54;   // 6
            8'h3D: scan_to_ascii = 8'd55;   // 7
            8'h3E: scan_to_ascii = 8'd56;   // 8
            8'h46: scan_to_ascii = 8'd57;   // 9


            default: scan_to_ascii = 8'h00;
        endcase
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            char_out      <= 8'h00;
            data_ready    <= 0;
            enter_pressed <= 0;
            break_flag    <= 0;
        end else begin
            data_ready <= 0;

            if (rx_done_tick) begin
                if (scan_code == 8'hF0) begin
                    break_flag <= 1;
                    data_ready <= 0;
                end

                else if (break_flag == 1) begin
                    break_flag <= 0;
                    data_ready <= 0;
                end

                else if (scan_code == 8'h5A) begin
                    break_flag    <= 0;
                    enter_pressed <= 1;
                    char_out      <= 8'h0D; 
                    data_ready    <= 1;
                end

                else begin
                    break_flag    <= 0;
                    enter_pressed <= 0;
                    char_out      <= scan_to_ascii(scan_code);
                    data_ready    <= 1;
                end

            end 
        end 
    end 
endmodule
