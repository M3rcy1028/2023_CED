//Half Adder
module ha(s, co, a, b);
	input a, b;		//input data a and b
	output s, co;	//sum, carry out
	
	_and2 CO(co, a, b);	//CO = a&b
	_xor2	S(s, a, b);		//S = a^b
endmodule
