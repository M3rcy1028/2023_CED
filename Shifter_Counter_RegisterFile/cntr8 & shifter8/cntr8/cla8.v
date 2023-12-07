//8-bit Carry Look-ahead Adder
module cla8(s, co, a, b, ci);
	input [7:0] a,b; 
	input ci;
	output [7:0] s;
	output co; 
	
	wire c1;
	
	//instance
	cla4 U0_cla4(.s(s[3:0]), .co(c1), .a(a[3:0]),.b(b[3:0]), .ci(ci));
	cla4 U1_cla4(.s(s[7:4]), .co(co), .a(a[7:4]),.b(b[7:4]), .ci(c1));
endmodule
