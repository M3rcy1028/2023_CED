//Resettable enabled D Flip-flop
module _dff_r_en(q, clk, reset_n, en, d);
	input clk, reset_n, en, d;	//clock, reset, enable, data
	output reg q;					//output
	
	//priority : reset >> enable
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n == 0) q <= 1'b0;
		else if(en) q <= d; 
		else q <= q;
	end
endmodule
