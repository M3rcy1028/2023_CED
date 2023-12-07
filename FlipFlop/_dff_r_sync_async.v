//Async/Sync Set/Resettable D Flip-Flop
module _dff_r_sync_async(q_sync, q_async, clk, set_n, reset_n, d);
	input clk, set_n, reset_n, d; //clock, active-low set/reset, data d
	output q_sync, q_async; //output sync q/asunc q
	
	//instance
	_dff_r_sync U0_dff_r_sync(.q(q_sync), .clk(clk), .set_n(set_n), .reset_n(reset_n), .d(d));
	_dff_r_async U1_dff_r_async(.q(q_async), .clk(clk), .set_n(set_n), .reset_n(reset_n), .d(d));
endmodule
