//32-bit Carry Look-ahead Adder
module cla32(s, co, a, b, ci);
	input [31:0] a, b;	//input 32-bit data a, b
	input ci;				//input 1 bit Carry-in
	output [31:0] s;		//output 32-bit Sum
	output co;				//output 1 bit Carry-out
	wire c1, c2, c3, c4, c5, c6, c7, c8;			//8 Internal carry
	
	cla4 U0_cla4 (.s(s[3:0]), .co(c1), .a(b[3:0]), .b(a[3:0]), .ci(ci));			//Sum[3:0]
	cla4 U1_cla4 (.s(s[7:4]), .co(c2), .a(b[7:4]), .b(a[7:4]), .ci(c1));			//Sum[7:4]
	cla4 U2_cla4 (.s(s[11:8]), .co(c3), .a(b[11:8]), .b(a[11:8]), .ci(c2));		//Sum[11:8]
	cla4 U3_cla4 (.s(s[15:12]), .co(c4), .a(b[15:12]), .b(a[15:12]), .ci(c3));	//Sum[15:12]
	cla4 U4_cla4 (.s(s[19:16]), .co(c5), .a(b[19:16]), .b(a[19:16]), .ci(c4));	//Sum[19:16]
	cla4 U5_cla4 (.s(s[23:20]), .co(c6), .a(b[23:20]), .b(a[23:20]), .ci(c5));	//Sum[23:20]
	cla4 U6_cla4 (.s(s[27:24]), .co(c7), .a(b[27:24]), .b(a[27:24]), .ci(c6));	//Sum[27:24]
	cla4 U7_cla4 (.s(s[31:28]), .co(c8), .a(b[31:28]), .b(a[31:28]), .ci(c7));	//Sum[31:28]
	
	assign co = c8; 
endmodule
	
