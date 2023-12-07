//3-bit resettable register with active-low asynchronous reset module
module _register3_r(q, clk, reset_n, d);
	input clk, reset_n; //clock, active-low reset
	input [2:0] d;
	output [2:0] q;
	
	_dff_r_async U0_dff_r_async(.q(q[0]), .clk(clk), .reset_n(reset_n), .d(d[0]));
	_dff_r_async U1_dff_r_async(.q(q[1]), .clk(clk), .reset_n(reset_n), .d(d[1]));
	_dff_r_async U2_dff_r_async(.q(q[2]), .clk(clk), .reset_n(reset_n), .d(d[2]));

endmodule
