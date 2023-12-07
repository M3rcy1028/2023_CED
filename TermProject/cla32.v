//32-bit Carry Look-ahead Adder
module cla32(s, co, a, b, ci);
	input [31:0] a, b;
	input ci;
	output [31:0] s;
	output co;
	
	wire [2:0] c;
	
	//instances of cla8
	cla8 U0_cla8 (.s(s[7:0]), .co(c[0]), .a(a[7:0]), .b(b[7:0]), .ci(ci));
	cla8 U1_cla8 (.s(s[15:8]), .co(c[1]), .a(a[15:8]), .b(b[15:8]), .ci(c[0]));
	cla8 U2_cla8 (.s(s[23:16]), .co(c[2]), .a(a[23:16]), .b(b[23:16]), .ci(c[1]));
	cla8 U3_cla8 (.s(s[31:24]), .co(co), .a(a[31:24]), .b(b[31:24]), .ci(c[2]));
endmodule 
	