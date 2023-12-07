//4-bit Resettable D flip-flop
module _dff4_r(q, clk, reset_n, d);
	input clk, reset_n; 	//clk, active-low reset
	input [3:0] d; 		//input d
	output [3:0] q; 		//output q
	
	reg [3:0] q;
	
	always @(posedge clk or negedge reset_n)
	begin
		if (reset_n == 0) q <= 4'b0000; //reset_n = 0, q = 0
		else q <= d;
	end
endmodule 