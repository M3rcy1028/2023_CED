//Decide Next State
module ns_logic(d2, d1, d0, Ta, Tal, Tb, Tbl, q2, q1, q0);
	input Ta, Tal, Tb, Tbl;	//traffic lights with/without left
	input q2, q1, q0;			//Current State
	output d2, d1, d0;		//Next State
	
	wire inv_q2, inv_q1, inv_q0;
	wire inv_Ta, inv_Tal, inv_Tb, inv_Tbl;
	wire d2_w0, d2_w1, d2_w2;
	wire d0_w0, d0_w1, d0_w2, d0_w3;
	
	//inverter
	_inv U0_inv (.y(inv_q2), .a(q2));	//~q2
	_inv U1_inv (.y(inv_q1), .a(q1));	//~q1
	_inv U2_inv (.y(inv_q0), .a(q0));	//~q0
	_inv U3_inv (.y(inv_Ta), .a(Ta));	//~Ta
	_inv U4_inv (.y(inv_Tal), .a(Tal)); //~Tal
	_inv U5_inv (.y(inv_Tb), .a(Tb));	//~Tb
	_inv U6_inv (.y(inv_Tbl), .a(Tbl));	//~Tbl
	
	
	//Get d2
	_and2	U7_and2 (.y(d2_w0), .a(q2), .b(inv_q0));				//d2_w0 = q2 & ~q0
	_and3 U8_and3 (.y(d2_w1), .a(inv_q2), .b(q1), .c(q0));	//d2_w1 = ~q2 & q1 & q0
	_and3 U9_and3 (.y(d2_w2), .a(q2), .b(q1), .c(q0));			//d2_w0 = q2 & q1 & q0
	_or3	U10_or3 (.y(d2), .a(d2_w0), .b(d2_w1), .c(d2_w2));	//d2 = d2_w0 | d2_w1 | d2_w2
		
	//Get d1
	_xor2	U11_xor2(.y(d1), .a(q1), .b(q0));	//d1 = q1 ^ a0
	
	//d0
	_and4	U12_and4 (.y(d0_w0), .a(inv_q2), .b(inv_q1), .c(inv_q0), .d(inv_Ta));//d0_w0 = ~q2 & ~q1 & ~q0 & ~Ta
	_and4	U13_and4 (.y(d0_w1), .a(inv_q2), .b(q1), .c(inv_q0), .d(inv_Tal));	//d0_w1 = ~q2 & q1 & ~q0 & ~Tal
	_and4	U14_and4 (.y(d0_w2), .a(q2), .b(inv_q1), .c(inv_q0), .d(inv_Tb));		//d0_w2 = ~q & ~q1 & ~q0 & ~Tb
	_and4	U15_and4 (.y(d0_w3), .a(q2), .b(q1), .c(inv_q0), .d(inv_Tbl));			//d0_w3 = q2 & q1 & ~q0 & ~Tbl
	_or4	U16_or4	(.y(d0), .a(d0_w0), .b(d0_w1), .c(d0_w2), .d(d0_w3));			//d0 = d0_w0 | d0_w1 | d0_w2 | d0_w3
	
endmodule
