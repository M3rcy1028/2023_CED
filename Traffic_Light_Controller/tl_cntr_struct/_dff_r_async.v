//D flip-flop with active-low asynchronous reset and set
module _dff_r_async(q, clk, reset_n, d); 
	input clk, reset_n, d;	//clock, active-low reset, data d
	output q;	//output
	reg q;
	
	//behavioral implementation
	always @(posedge clk or negedge reset_n) 
	begin
		if (reset_n == 0) q <= d; // reset = 0, then q = 0
		else q <= 1'b0; // reset = 1, then q = d
	end
endmodule 
