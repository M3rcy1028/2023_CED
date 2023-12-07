//inverter
module _inv(y, a);
	input a;					//input
	output y;	
	
	assign y = ~a;			//output
endmodule

//2-to-1 AND
module _and2(y, a, b);
	input a, b;				//input
	output y;
	
	assign y = a & b;		//output
endmodule

//2-to-1 NAND
module _nand2(y, a, b);
	input a, b;				//input
	output y;	
	
	assign y = ~(a & b);	//output
endmodule

//2-to-1 OR
module _or2(y, a, b);
	input a, b;				//input
	output y;
	
	assign y = a | b;		//output
endmodule

//2-to-1 XOR
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

//3-to-1 AND
module _and3(y, a, b, c);
	input a, b, c;	//input
	output y;
	
	assign y = a & b & c;	//output
endmodule

//4-to-1 AND
module _and4(y, a, b, c, d);
	input a, b, c, d;	//intput
	output y;
	
	assign y = a & b & c & d;	//output
endmodule

//5-to-1 AND
module _and5(y, a, b, c, d, e);
	input a, b, c, d, e;	//input
	output y;
	
	assign y = a & b & c & d & e;	//output
endmodule

//3-to-1 OR
module _or3(y, a, b, c);
	input a, b, c;	//input
	output y;
	
	assign y = a | b | c;	//output
endmodule

//4-to-1 OR
module _or4(y, a, b, c, d);
	input a, b, c, d;	//input
	output y;
	
	assign y = a | b | c | d;	//output
endmodule

//5-to-1 OR
module _or5(y, a, b, c, d, e);
	input a, b, c, d, e;	//input
	output y;
	
	assign y = a | b | c | d | e;	//output
endmodule

//4 bits inverter
module _inv_4bits(y, a);
	input [3:0] a;
	output [3:0] y;
	assign y = ~ a;
endmodule

//4 bits 2-to-1 AND
module _and2_4bits(y, a, b);
	input [3:0] a, b;
	output [3:0] y;
	assign y = a & b;
endmodule

//4 bits 2-to-1 OR
module _or2_4bits(y, a, b);
	input [3:0] a, b;
	output [3:0] y;
	assign y = a | b;
endmodule

//4 bits 2-to-1 XOR
module _xor2_4bits(y, a, b);
	input [3:0] a, b;
	output [3:0] y;
	
	_xor2 U0_xor2 (.y(y[0]), .a(a[0]), .b(b[0]));
	_xor2 U1_xor2 (.y(y[1]), .a(a[1]), .b(b[1]));
	_xor2 U2_xor2 (.y(y[2]), .a(a[2]), .b(b[2]));
	_xor2 U3_xor2 (.y(y[3]), .a(a[3]), .b(b[3]));
endmodule

//4 bits 2-to-1 XNOR

module _xnor2_4bits(y, a, b);
	input [3:0] a, b;
	output [3:0] y;
	
	wire [3:0] w0;
	_xor2_4bits U0_xor2_4bits (.y(w0), .a(a), .b(b));
	_inv_4bits U1_inv_4bits (.y(y), .a(w0));
endmodule

