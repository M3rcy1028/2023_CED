//D flip-flop with active-low synchronous reset and set
module _dff_r_sync(q, clk, set_n, reset_n, d);
	input clk, set_n, reset_n, d; //clock, active-low set_n/reset_n, data d
	output q;	//output
	reg q;
	
	//behavioral implementation
	always @ (posedge clk)
	begin
		if (reset_n == 0) q <= 1'b0; //reset = 0, then q = 0
		else if (set_n == 0) q <= 1'b1; //reset = 1 and set = 0, then q = 1;
		else q <= d; //reset = 1 and set = 1, then q = d
	end
endmodule
