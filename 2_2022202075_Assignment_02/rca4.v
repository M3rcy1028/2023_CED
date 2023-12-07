//4-bit Ripple carray adder
module rca4(s, co, a, b, ci);
	input [3:0] a, b;	//4-bit input data a and b
	input ci;			//carry in
	output [3:0] s;	//4-bit sum of a and b
	output co;			//carry out
	
	wire [2:0] c;		//carry wire
	
	fa U0_fa(.s(s[0]),.co(c[0]),.a(a[0]),.b(b[0]),.ci(ci));		//s[0] = a[0]^b[0]^ci, 		c[0] = a&b|a&ci|b&ci
	fa U1_fa(.s(s[1]),.co(c[1]),.a(a[1]),.b(b[1]),.ci(c[0]));	//s[1] = a[1]^b[1]^c[0], 	c[1] = a&b|a&c[0]|b&c[0]
	fa U2_fa(.s(s[2]),.co(c[2]),.a(a[2]),.b(b[2]),.ci(c[1]));	//s[2] = a[2]^b[2]^c[1],   c[2] = a&b|a&c[1]|b&c[1]
	fa U3_fa(.s(s[3]),.co(co),.a(a[3]),.b(b[3]),.ci(c[2]));		//s[3] = a[3]^b[3]^c[2],   co   = a&b|a&c[2]|b&c[2]
endmodule
