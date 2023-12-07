//store Current State
module _register2_r_async(q, clk, reset_n, d);
	input clk, reset_n;	//clock, active-low reset
	input [1:0] d;			//Next State
	output [1:0] q;		//Current State
	
	//instance
	_dff_r_async U0_dff_r_async(.q(q[0]), .clk(clk), .reset_n(reset_n), .d(d[0]));
	_dff_r_async U1_dff_r_async(.q(q[1]), .clk(clk), .reset_n(reset_n), .d(d[1]));
endmodule 

