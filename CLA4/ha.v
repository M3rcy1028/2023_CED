//Half Adder
module ha(s, co, a, b);
	input a, b;		//input data a and b
	output s, co;	//sum, carry out
	
	assign s = a ^ b;
	assign co = a & b;
endmodule
