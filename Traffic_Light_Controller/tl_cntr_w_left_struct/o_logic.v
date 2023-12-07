//Decide outputs depending on Current State
module o_logic(La1, La0, Lb1, Lb0, q2, q1, q0);
	input q2, q1, q0;	//Current State
	output La1, La0, Lb1, Lb0;
	
	wire inv_q2, inv_q0;
	wire w0, w1, w2;
	
	//inverter
	_inv U0_inv (.y(inv_q2), .a(q2));
	_inv U1_inv (.y(inv_q0), .a(q0));
	
	//Get La1
	_and2	U2_and2 (.y(w0), .a(q1), .b(inv_q0));	//w0 = q1 & ~ q0
	_or2  U3_or2 (.y(La1), .a(q2), .b(w0));		//La1 = q2 | w0
	
	//Get La0
	_and2 U4_and2 (.y(w1), .a(inv_q2), .b(q0));	//w1 = ~q2 | q0
	_or2	U5_or2 (.y(La0), .a(w1), .b(q2));		//La0 = w1 | q2
	
	//Get Lb1
	_or2	U6_or2 (.y(Lb1), .a(inv_q2), .b(w0));	//Lb1 = ~q2 | q1 & ~q0
	
	//Get Lb0
	_and2 U7_and2 (.y(w2), .a(q2), .b(q0));		//w2 = q2 & q0
	_or2	U8_or2 (.y(Lb0), .a(inv_q2), .b(w2));	//Lb0 = ~q2 | w2
	
endmodule
