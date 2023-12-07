//Output top 2 carry to detect overflow
module cla4_ov(s, c3, co, a, b, ci);
	input [3:0] a, b;	//4-bit data a, b
	input ci;			//carry-in
	
	output [3:0] s;	//4-bit sum
	output c3, co;		//output c3, co
	
	wire c1, c2;		//Internal carry
	
	//reversion of full adder
	fa_v2 U0_fa (.s(s[0]), .a(a[0]), .b(b[0]), .ci(ci));
	fa_v2 U1_fa (.s(s[1]), .a(a[1]), .b(b[1]), .ci(c1));
	fa_v2 U2_fa (.s(s[2]), .a(a[2]), .b(b[2]), .ci(c2));
	fa_v2 U3_fa (.s(s[3]), .a(a[3]), .b(b[3]), .ci(c3));
	//Get c3 and co
	clb U4_clb4(.c1(c1), .c2(c2), .c3(c3), .co(co), .a(a), .b(b), .ci(ci));
	
endmodule
