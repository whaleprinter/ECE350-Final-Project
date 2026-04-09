`timescale 1ns/1ps

module ps2_rx (
    input wire clk, reset,
    input wire ps2d,        // PS/2 data
    input wire ps2c,        // PS/2 clock
    input wire rx_en,       // receiver enable
    output reg rx_done_tick,
    output wire [7:0] dout
);

//
// State machine
//
localparam [1:0]
    idle = 2'b00,
    dps  = 2'b01,
    load = 2'b10;

reg [1:0] state_reg, state_next;
reg [10:0] b_reg, b_next;
reg [3:0] n_reg, n_next;


reg [4:0] filter_reg;
wire [4:0] filter_next;

reg f_ps2c_reg;
wire f_ps2c_next;

assign filter_next = {ps2c, filter_reg[4:1]};

// majority detection for stable high/low
assign f_ps2c_next =
      (filter_reg == 5'b11111) ? 1'b1 :
      (filter_reg == 5'b00000) ? 1'b0 :
                                 f_ps2c_reg;

// Falling edge detect
wire fall_edge = f_ps2c_reg & ~f_ps2c_next;

//
// Register logic
//
always @(posedge clk, posedge reset)
begin
    if (reset) begin
        filter_reg  <= 0;
        f_ps2c_reg  <= 0;
        state_reg   <= idle;
        n_reg       <= 0;
        b_reg       <= 0;
    end else begin
        filter_reg  <= filter_next;
        f_ps2c_reg  <= f_ps2c_next;
        state_reg   <= state_next;
        n_reg       <= n_next;
        b_reg       <= b_next;
    end
end


//
// FSM — unchanged
//
always @* begin
    state_next   = state_reg;
    rx_done_tick = 1'b0;
    n_next       = n_reg;
    b_next       = b_reg;

    case (state_reg)
        idle: begin
            if (fall_edge & rx_en) begin
                b_next     = {ps2d, b_reg[10:1]};
                n_next     = 4'b1001;
                state_next = dps;
            end
        end

        dps: begin
            if (fall_edge) begin
                b_next = {ps2d, b_reg[10:1]};
                if (n_reg == 0)
                    state_next = load;
                else
                    n_next = n_reg - 1;
            end
        end

        load: begin
            rx_done_tick = 1'b1;
            state_next   = idle;
        end
    endcase
end

assign dout = b_reg[8:1];

endmodule

