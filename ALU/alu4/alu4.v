//4-bit ALU
module alu4(result, c, n, z, v, a, b, op);
	input [3:0] a, b;		//4-bit data a, b
	input [2:0] op;		//operation code
	output [3:0] result;	//ALU result
	output c, n, z, v;	//condition
	
	wire [3:0] w_add_b;
	wire [3:0] w_not_a,w_not_b, w_and, w_or, w_xor, w_xnor, w_add;
	wire c3_add, co_add;
	
	_inv_4bits U0_inv_4bits (.y(w_not_a), .a(a));	//inverse of a
	_inv_4bits U1_inv_4bits (.y(w_not_b), .a(b));	//inverse of b
	_and2_4bits U2_and2_4bits (.y(w_and), .a(a), .b(b));		//a & b
	_or2_4bits U3_or2_4bits (.y(w_or), .a(a), .b(b));			//a | b
	_xor2_4bits U4_xor2_4bits (.y(w_xor), .a(a), .b(b));		//a ^ b
	_xnor2_4bits U5_xnor2_4bits (.y(w_xnor), .a(a), .b(b));	//~(a | b)
	mx2_4bits U6_mux_b (.y(w_add_b), .d0(b), .d1(w_not_b), .s(op[0])); //4-bit 2-to-1 MUX
	cla4_ov U7_adder (.s(w_add), .c3(c3_add), .co(co_add), .a(a), .b(w_add_b), .ci(op[0]));
	//4-bit 8-to-1 MUX
	mx8_4bits U7_mx8_4bits (.y(result), .a(w_not_a), .b(w_not_b), .c(w_and), .d(w_or), .e(w_xor), .f(w_xnor), .g(w_add), .h(w_add), .s2(op[2]), .s1(op[1]), .s0(op[0]));
	//calculate flag
	cal_flags4 U8_cal_flags4 (.c(c), .n(n), .z(z), .v(v), .op(op), .result(result), .co_add(co_add), .c3_add(c3_add));
endmodule
