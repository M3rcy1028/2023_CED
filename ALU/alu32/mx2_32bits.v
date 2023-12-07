//32-bit 2-to-1 MUX
module mx2_32bits(y, d0, d1, s);
	input [31:0] d0, d1;	//input
	input s;					//selection
	output [31:0] y;		//output
	
	//if s==0, select d0. Otherwise, select d1.
	assign y=(s==0)?d0:d1;
endmodule
