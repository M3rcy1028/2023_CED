//3-bit register
module _register3_r(q, clk, reset_n, d);
	input clk, reset_n; //clock, acitve-low reset
	input [2:0] d;		  //input data
	output [2:0] q;	  //output data
	
	//instance
	_dff_r U0_dff_r (.q(q[0]), .clk(clk), .reset_n(reset_n), .d(d[0]));
	_dff_r U1_dff_r (.q(q[1]), .clk(clk), .reset_n(reset_n), .d(d[1]));
	_dff_r U2_dff_r (.q(q[2]), .clk(clk), .reset_n(reset_n), .d(d[2]));
endmodule
