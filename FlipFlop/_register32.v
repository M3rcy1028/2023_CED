//32-bit register with 32 Flip-Flops
module _register32(q, clk, d);
	input clk; //clock
	input [31:0] d; //input data
	output [31:0] q; //output
	
	//instance
	_register8 U0_r8(.q(q[7:0]), .clk(clk), .d(d[7:0]));
	_register8 U1_r8(.q(q[15:8]), .clk(clk), .d(d[15:8]));
	_register8 U2_r8(.q(q[23:16]), .clk(clk), .d(d[23:16]));
	_register8 U3_r8(.q(q[31:24]), .clk(clk), .d(d[31:24]));
endmodule
