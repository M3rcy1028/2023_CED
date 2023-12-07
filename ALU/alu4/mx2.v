//2-to-1 MUX
module mx2(y, d0, d1, s);
	input d0, d1;	//input data d0, d1
	input s;			//selection
	output y;		//output
	
	wire sb, w0, w1;	//Inner wire
	
	_inv U0_inv(.y(sb), .a(s));					//sb = ~s
	_nand2 U1_nand2(.y(w0), .a(d0), .b(sb));	//w0 = ~(d0 & sb)
	_nand2 U2_nand2(.y(w1), .a(d1), .b(s));	//w1 = ~(d1 & s)
	_nand2 U3_nand2(.y(y), .a(w0), .b(w1));	//y = ~(w0 & w1)
endmodule
