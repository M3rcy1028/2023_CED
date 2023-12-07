//32-bit register
module register32_r_en(q, clk, reset_n, en, d);
	input clk, reset_n, en;	//clock, reset, enable
	input [31:0] d;			//data
	output reg [31:0] q;		//output
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n == 0) q <= 32'b0;
		else if(en) q <= d; 
		else q <= q;
	end
endmodule
