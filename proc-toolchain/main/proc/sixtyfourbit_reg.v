module sixtyfourbit_reg(clk, input_enable, output_enable, in, out, clr);

    input clk, input_enable, output_enable;
    input [63:0] in; 
    output [63:0] out;      
    input clr;

    wire [63:0] q;

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin 
            dffe_ref dff1(q[i], in[i], clk, input_enable, clr); 
            assign out[i] =  q[i];
        end
    endgenerate

endmodule


