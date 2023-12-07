//32-bit Carry Look-ahead Adder
module cla32_ov(s, co_prev, co, a, b, ci);
	input [31:0] a, b;	//32-bit data a, b
	input ci;				//carry-in
	output [31:0] s;		//32-bit sum
	output co_prev;		//carry-out before co
	output co;				//carry-out
	
	wire c1, c2, c3, c4, c5, c6, c7;	//internal carry
	
	//cla4 instance
	cla4 U0_cla4 (.s(s[3:0]), .co(c1), .a(a[3:0]), .b(b[3:0]), .ci(ci));
	cla4 U1_cla4 (.s(s[7:4]), .co(c2), .a(a[7:4]), .b(b[7:4]), .ci(c1));
	cla4 U2_cla4 (.s(s[11:8]), .co(c3), .a(a[11:8]), .b(b[11:8]), .ci(c2));
	cla4 U3_cla4 (.s(s[15:12]), .co(c4), .a(a[15:12]), .b(b[15:12]), .ci(c3));
	cla4 U4_cla4 (.s(s[19:16]), .co(c5), .a(a[19:16]), .b(b[19:16]), .ci(c4));
	cla4 U5_cla4 (.s(s[23:20]), .co(c6), .a(a[23:20]), .b(b[23:20]), .ci(c5));
	cla4 U6_cla4 (.s(s[27:24]), .co(c7), .a(a[27:24]), .b(b[27:24]), .ci(c6));
	//cla4_ov instance
	cla4_ov U7_cla4_ov (.s(s[31:28]), .c3(co_prev), .co(co), .a(a[31:28]), .b(b[31:28]), .ci(c7));
endmodule
