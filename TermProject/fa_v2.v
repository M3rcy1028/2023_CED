//Full Adder without carry out
module fa_v2(s, a, b, ci); 
	input a,b,ci; 		//input data a, b, carry-in
	output s;			//output Sum = a^b^ci
	
	wire w0;				//temporarily store result of a^b
	
	_xor2 U0_xor2(.y(w0), .a(a), .b(b));	//w0 = a^b
	_xor2 U1_xor2(.y(s), .a(w0), .b(ci));	//s = w0^ci
endmodule
