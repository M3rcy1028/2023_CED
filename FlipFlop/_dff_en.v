//Enabled D Flip-Flip module
module _dff_en(q, clk, en, d);
	input clk, en, d;	//clock, enable, data d
	output q; //output
	
	wire w_d, q_bar;
	
	// if en=0, w_d = q, else en=1, w_d = d
	mx2 U0_mx2(.y(w_d), .d0(q), .d1(d), .s(en));
	_dff U1_dff(.q(q), .q_bar(q_bar), .clk(clk), .d(w_d));

endmodule
