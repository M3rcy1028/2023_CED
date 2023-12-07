//32-bit ALU
module alu32(result, c, n, z, v, a, b, op);
	input [31:0] a, b;	//32-bit data a, b
	input [2:0] op;		//operation code
	output [31:0] result;//32-bit ALU result
	output c, n, z, v;	//condition code
	
	wire [31:0] w_add_b;
	wire [31:0] w_not_a,w_not_b, w_and, w_or, w_xor, w_xnor, w_add;	//store results
	wire co_prev, co_add;	//carry
	
	_inv_32bits U0_inv_32bits (.y(w_not_a), .a(a)); //inverse of a
	_inv_32bits U1_inv_32bits (.y(w_not_b), .a(b));	//inverse of b
	_and2_32bits U2_and2_32bits (.y(w_and), .a(a), .b(b));	//a & b
	_or2_32bits U3_or2_32bits (.y(w_or), .a(a), .b(b));		//a | b
	_xor2_32bits U4_xor2_32bits (.y(w_xor), .a(a), .b(b));	//a ^ b
	_xnor2_32bits U5_xnor2_32bits (.y(w_xnor), .a(a), .b(b));//~(a ^ b)
	mx2_32bits U6_mux_b (.y(w_add_b), .d0(b), .d1(w_not_b), .s(op[0])); //32-bit 2-to-1 MUX
	cla32_ov U7_adder (.s(w_add), .co_prev(co_prev), .co(co_add), .a(a), .b(w_add_b), .ci(op[0]));	//add a and b
	//32-bit 8-to-1 MUX
	mx8_32bits U7_mx8_32bits (.y(result), .a(w_not_a), .b(w_not_b), .c(w_and), .d(w_or), .e(w_xor), .f(w_xnor), .g(w_add), .h(w_add), .s2(op[2]), .s1(op[1]), .s0(op[0])); 
	cal_flags32 U8_cal_flags32 (.c(c), .n(n), .z(z), .v(v), .op(op), .result(result), .co_add(co_add), .co_prev_add(co_prev));	//Get condition code
endmodule
