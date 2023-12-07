//inverter
module _inv(y, a);
	input a;					//input
	output y;	
	
	assign y = ~a;			//output
endmodule

//2-input AND
module _and2(y, a, b);
	input a, b;				//input
	output y;
	
	assign y = a & b;		//output
endmodule

//2-input NAND
module _nand2(y, a, b);
	input a, b;				//input
	output y;	
	
	assign y = ~(a & b);	//output
endmodule

//2-input OR
module _or2(y, a, b);
	input a, b;				//input
	output y;
	
	assign y = a | b;		//output
endmodule

//2-input XOR
module _xor2(y, a, b);
	input a, b;				//input
	output y;
	
	wire iv_a, iv_b;	//store inverted a and inverted b
	wire w0, w1;			
	
	_inv iv0(.y(iv_b), .a(b));				//iv_b = ~b
	_inv iv1(.y(iv_a), .a(a));				//iv_a = ~a
	_and2 and20(.y(w0), .a(a), .b(iv_b)); //w0 = a | ~b
	_and2 and21(.y(w1), .a(iv_a), .b(b));	//w1 = ~a | b
	_or2 or20(.y(y), .a(w0), .b(w1)); 		//y = w0 | w1
endmodule
