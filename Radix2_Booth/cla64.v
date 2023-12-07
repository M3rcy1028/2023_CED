//64-bit Carry Look-ahead Adder
module cla64(s, co, a, b, ci);
	input [63:0] a,b; 
	input ci;
	output [63:0] s;
	output co;
	
	wire c1;
	
	//instances of cla32
	cla32 U0_cla32 (.s(s[31:0]), .co(c1), .a(a[31:0]), .b(b[31:0]), .ci(ci));
	cla32 U1_cla32 (.s(s[63:32]), .co(co), .a(a[63:32]), .b(b[63:32]), .ci(c1));
endmodule
