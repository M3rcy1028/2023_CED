//1-bit 2-to-1 multiplexer
module mx2 (y, s, d1, d0);
	input s, d1, d0; //selection signal, inputs
	output y;		  //result
	
	wire sb, w0, w1;
	
	_inv	U0_inv (.y(sb), .a(s)); 				//sb = ~s
	_nand2	U1_nand2 (.y(w0), .a(d0), .b(sb));	//s = 0, then select d0
	_nand2 U2_nand2 (.y(w1), .a(d1), .b(s));	//s = 1, then select d1
	_nand2 U3_nand2 (.y(y), .a(w0), .b(w1));	//y = ~(d0 & d1)
endmodule
