//16-bit Carry Look-ahead Adder
module cla16(s, co, a, b, ci);
	input [15:0] a, b;
	input ci;
	output [15:0] s;
	output co;
	
	wire c1;
	
	//instances of cla8
	cla8 U0_cla8 (.s(s[7:0]), .co(c1), .a(a[7:0]), .b(b[7:0]), .ci(ci));
	cla8 U1_cla8 (.s(s[15:8]), .co(co), .a(a[15:8]), .b(b[15:8]), .ci(c1));
endmodule 
	