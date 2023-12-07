//8-bit register with 8 Flip-Flops
module _register8 (q, clk, d);
	input clk; //clock
	input [7:0] d; //input data
	output [7:0] q; //output data
	
	wire [7:0] w_q_bar;
	
	//instance
	_dff U0_dff (.q(q[0]), .clk(clk), .d(d[0]));
	_dff U1_dff (.q(q[1]), .clk(clk), .d(d[1]));
	_dff U2_dff (.q(q[2]), .clk(clk), .d(d[2]));
	_dff U3_dff (.q(q[3]), .clk(clk), .d(d[3]));
	_dff U4_dff (.q(q[4]), .clk(clk), .d(d[4]));
	_dff U5_dff (.q(q[5]), .clk(clk), .d(d[5]));
	_dff U6_dff (.q(q[6]), .clk(clk), .d(d[6]));
	_dff U7_dff (.q(q[7]), .clk(clk), .d(d[7]));
endmodule
