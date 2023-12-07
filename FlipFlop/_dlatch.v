//D-latch module
module _dlatch(q, q_bar, clk, d);
	input clk, d;		//clock, input d
	output q, q_bar;	//output q and ~q
	reg q; 
	 
	always @(clk or d) //whenever clk or d changed
	begin
		 if(clk == 1) //if clk == 1
			q <= d;	//assign
	end
	assign q_bar = ~q;
endmodule
