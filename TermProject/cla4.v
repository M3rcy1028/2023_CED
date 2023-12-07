//4-bit Carry Look-ahead Adder
module cla4(s, co, a, b, ci);
	input [3:0] a, b;	//input 4-bit data a, b
	input ci;			//input 1 bit Carry-in
	output [3:0] s;	//output 4-bit Sum
	output co;			//output 1 bit Carry-out
	
	wire [2:0] c;		//3-bit Carry wire
	
	//Full adder
	fa_v2 U0_fa (.s(s[0]), .a(a[0]), .b(b[0]), .ci(ci));		//s[0] = a[0] ^ b[0] ^ ci
	fa_v2 U1_fa (.s(s[1]), .a(a[1]), .b(b[1]), .ci(c[0]));	//s[1] = a[1] ^ b[1] ^ c[0]
	fa_v2 U2_fa (.s(s[2]), .a(a[2]), .b(b[2]), .ci(c[1]));	//s[2] = a[2] ^ b[2] ^ c[1]
	fa_v2 U3_fa (.s(s[3]), .a(a[3]), .b(b[3]), .ci(c[2]));	//s[3] = a[3] ^ b[3] ^ c[2]
	
	//Carry Generation
	clb4 U4_clb4 (.c1(c[0]), .c2(c[1]), .c3(c[2]), .co(co), .a(a), .b(b), .ci(ci));
	
endmodule
