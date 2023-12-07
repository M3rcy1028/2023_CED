//Decide Next State
module ns_logic(d1, d0, Ta, Tb, q1, q0);
	input Ta, Tb, q1, q0;
	output d1, d0;
	
	wire w0, w1;
	wire inv_q1, inv_q0, inv_Ta, inv_Tb;
	
	//instance of inverter
	_inv U0_inv(.y(inv_q0), .a(q0)); // ~q0
	_inv U1_inv(.y(inv_q1), .a(q1)); // ~q1
	_inv U2_inv(.y(inv_Ta), .a(Ta)); // ~ta
	_inv U3_inv(.y(inv_Tb), .a(Tb)); // ~tb
	
	//instance
	_and3 U4_and3(.y(w0), .a(inv_q1), .b(inv_q0), .c(inv_Ta));	//w0 = ~q1 & ~q0 & ~ta
	_and3 U5_and3(.y(w1), .a(q1), .b(inv_q0), .c(inv_Tb));		//w1 = q1 & ~q0 & ~tb
	_or2 U6_or2(.y(d0), .a(w0), .b(w1));								//d0 = w0 | w1
	_xor2 U7_xor2(.y(d1), .a(q1), .b(q0));								//d1 = q1 ^ q0
endmodule 
