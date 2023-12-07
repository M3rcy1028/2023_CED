//4-bit Carry Look-ahead Block
module clb(c1, c2, c3, co, a, b, ci);
	input [3:0] a, b;			//input 4-bit data a, b
	input ci;					//input 1-bit Carry-in
	output c1, c2, c3, co;	//output 
	
	wire [3:0] G, P;	//4-bit wire for Generate and Propagate 
	wire w0_c1;								//wire for c1
	wire w0_c2, w1_c2;					//wires for c2
	wire w0_c3, w1_c3, w2_c3;			//wires for c3
	wire w0_co, w1_co, w2_co, w3_co;	//wires for co
	
	//Generate Signal Gi
	_and2 U0_and2(.y(G[0]), .a(a[0]), .b(b[0]));	//G[0] = a[0] & b[0]
	_and2 U1_and2(.y(G[1]), .a(a[1]), .b(b[1]));	//G[1] = a[1] & b[1]
	_and2 U2_and2(.y(G[2]), .a(a[2]), .b(b[2]));	//G[2] = a[2] & b[2]
	_and2 U3_and2(.y(G[3]), .a(a[3]), .b(b[3]));	//G[3] = a[3] & b[3]
	
	//Propagate Signal Pi
	_or2 U4_or2(.y(P[0]), .a(a[0]), .b(b[0]));	//P[0] = a[0] | b[0]
	_or2 U5_or2(.y(P[1]), .a(a[1]), .b(b[1]));	//P[1] = a[1] | b[1]
	_or2 U6_or2(.y(P[2]), .a(a[2]), .b(b[2]));	//P[2] = a[2] | b[2]
	_or2 U7_or2(.y(P[3]), .a(a[3]), .b(b[3]));	//P[3] = a[3] | b[3]
	
	// c1 = G[0] | (P[0] & ci);
	_and2 U8_and2(.y(w0_c1), .a(P[0]), .b(ci));				//w0_c1 = P[0] & ci
	_or2	U9_or2(.y(c1), .a(G[0]), .b(w0_c1));				//c1 = G[0] | w0_c1
	
	// c2 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & ci);
	_and2 U10_and2(.y(w0_c2), .a(P[1]), .b(G[0]));			//w0_c2 = P[1] & G[0]
	_and3 U11_and3(.y(w1_c2), .a(P[1]), .b(P[0]),.c(ci));	//w1_c2 = P[1] & P[0] & ci
	_or3 	U12_or3(.y(c2), .a(G[1]), .b(w0_c2), .c(w1_c2));//c2 = G[1] | w0_c2 | w1_c2

	// c3 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & ci);
	_and2 U13_and2(.y(w0_c3), .a(P[2]), .b(G[1]));								//w0_c3 = P[2] ^ G[1]
	_and3 U14_and3(.y(w1_c3), .a(P[2]), .b(P[1]), .c(G[0]));					//w1_c3 = P[2] ^ P[1] ^ G[0]
	_and4 U15_and4(.y(w2_c3), .a(P[2]), .b(P[1]), .c(P[0]), .d(ci));	//w2_c3 = P[2] ^ P[1] ^ P[0] ^ G[0]
	_or4 	U16_or4(.y(c3), .a(G[2]), .b(w0_c3), .c(w1_c3), .d(w2_c3));		//c3 = G[2] | w0_c3 | w1_c3 | w2_c3
	
	// co = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & ci)
	_and2 U17_and2(.y(w0_co), .a(P[3]), .b(G[2]));											//w0_co = P[3] & G[2]
	_and3 U18_and3(.y(w1_co), .a(P[3]), .b(P[2]), .c(G[1]));								//w1_co = P[3] & P[2] & G[1]
	_and4 U19_and4(.y(w2_co), .a(P[3]), .b(P[2]), .c(P[1]), .d(G[0]));				//w2_co = P[3] & P[2] & P[1] & G[0]
	_and5 U20_and5(.y(w3_co), .a(P[3]), .b(P[2]), .c(P[1]), .d(P[0]),.e(ci));		//w3_co = P[3] & P[2] & P[1] & G[0] & ci
	_or5	U21_or4(.y(co), .a(G[3]), .b(w0_co), .c(w1_co), .d(w2_co), .e(w3_co));	//co = G[3] | w0_co | w1_co | w2_co | w3_co
	
endmodule
