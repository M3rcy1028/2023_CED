//decide output values depending on current state
module o_logic(La1, La0, Lb1, Lb0, q1, q0);
	input q1, q0;					//Current State
	output La1, La0, Lb1, Lb0;	//Outputs
	
	wire inv_q1;
	
	_inv U0_inv(.y(inv_q1), .a(q1));					//~q1
	_and2 U1_and2(.y(La0), .a(inv_q1), .b(q0));	//La0 = ~q1 & q0
	_and2 U2_and2(.y(Lb0), .a(q1), .b(q0));		//Lb0 = q1 & q0
	
	assign La1 = q1;
	assign Lb1 = inv_q1;
endmodule 