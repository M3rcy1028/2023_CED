//Resettable D Flip-Flop module
module _dff_r(q, clk, reset_n, d);
	input clk, reset_n, d; //clock, active low, data d
	output q; //output
	
	wire w_d, w_q_bar;
		
	//instance
	_and2 U0_and2 (.y(w_d), .a(d), .b(reset_n));
	_dff U1_dff (.q(q), .q_bar(w_q_bar), .clk(clk), .d(w_d));
endmodule
