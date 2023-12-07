//Full Adder
module fa(s, co, a, b, ci);
	input a, b, ci;	//input data a and b, carry in
	output s, co;		//sum, carry out
	wire c1, c2, sm;	//half adder carry c1 and c2, half adder sum
	
	ha U0_ha(.s(sm), .co(c1), .a(b), .b(ci));	//sm = a^b, c1 = a&b
	ha U1_ha(.s(s), .co(c2), .a(a), .b(sm));	//s = a^sm, c2 = a&sm
	_or2 U2_or2(.y(co), .a(c2), .b(c1));		//co = c1|c2
endmodule
