//3-bit Resettable D flip-flop
module _dff3_r(q, clk, reset_n, d);
	input clk, reset_n; 	//clk, active-low reset
	input [2:0] d; 		//input d
	output [2:0] q; 		//output q
	
	reg [2:0] q;
	
	always @(posedge clk or negedge reset_n) 
	begin
		if (reset_n == 0) q <= 3'b000; //reset_n = 0, q = 0
		else q <= d;
	end
endmodule 