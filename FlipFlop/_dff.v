//D Flip-Flop module
module _dff(q, q_bar, clk, d);
	input clk,  d;		//clock, input d
	output q, q_bar;	//output
	wire clk_bar, w_q, w_q_bar;
	
	//instance
	_inv		U0_inv0(.y(clk_bar), .a(clk));	//get inverse of clk
	_dlatch	U1_dlatch(.q(w_q), .q_bar(w_q_bar), .clk(clk_bar), .d(d));
	_dlatch	U2_dlatch(.q(q), .q_bar(q_bar), .clk(clk), .d(w_q));
endmodule
