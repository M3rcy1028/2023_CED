//Resettable D Flip-Flop with active-low asynchronous reset
module _dff_r_async(q, clk, reset_n, d);
	input clk, reset_n, d;	//clock, active-low reset, data
	output q;	//output
	reg q;
	
	//bevavioral implementation
	always @ (posedge clk or posedge reset_n)
	begin
		if (reset_n == 1) q <= 1'b0;	//reset = 0, then q = 0
		else q <= d;						//reset = 1, q = d
	end
endmodule
