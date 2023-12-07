//8-bit resgister with reset
module _register8_r (q, clk, reset_n, d);
	input clk, reset_n;	//clock, active-low reset
	input [7:0] d;			//input data
	output [7:0] q;		//output data
	
	//dff_r instances - combinational circuits
	_dff_r U0_dff(.q(q[0]), .clk(clk), .reset_n(reset_n), .d(d[0]));	//q[0]
	_dff_r U1_dff(.q(q[1]), .clk(clk), .reset_n(reset_n), .d(d[1]));	//q[1]
	_dff_r U2_dff(.q(q[2]), .clk(clk), .reset_n(reset_n), .d(d[2]));	//q[2]
	_dff_r U3_dff(.q(q[3]), .clk(clk), .reset_n(reset_n), .d(d[3]));	//q[3]
	_dff_r U4_dff(.q(q[4]), .clk(clk), .reset_n(reset_n), .d(d[4]));	//q[4]
	_dff_r U5_dff(.q(q[5]), .clk(clk), .reset_n(reset_n), .d(d[5]));	//q[5]
	_dff_r U6_dff(.q(q[6]), .clk(clk), .reset_n(reset_n), .d(d[6]));	//q[6]
	_dff_r U7_dff(.q(q[7]), .clk(clk), .reset_n(reset_n), .d(d[7]));	//q[7]
endmodule
