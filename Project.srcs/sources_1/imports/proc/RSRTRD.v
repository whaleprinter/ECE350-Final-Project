module RSRTRD(clk, input_enable, output_enable, in, out, clr);

    input clk, input_enable, output_enable;
    input [14:0] in; 
    output [14:0] out;      
    input clr;

    wire [14:0] q;

    genvar i;
    generate
        for (i = 0; i < 15; i = i + 1) begin 
            dffe_ref dff1(q[i], in[i], clk, input_enable, clr); 
            assign out[i] =  q[i];
        end
    endgenerate

endmodule


