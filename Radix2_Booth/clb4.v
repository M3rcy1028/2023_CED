//4-bit Carry Look-ahead Block
module clb4 (c1, c2, c3, co, a, b, ci);
	input [3:0] a,b;
	input ci;
	
	output c1, c2, c3, co;
	
	wire [3:0] g,p;
	wire w0_c1;
	wire w0_c2, w1_c2;
	wire w0_c3, w1_c3, w2_c3;
	wire w0_co, w1_co, w2_co, w3_co;
	
	//Generate
	_and2 G0_and2(g[0], a[0], b[0]); // G0 = a0 & b0
	_and2 G1_and2(g[1], a[1], b[1]); // G1 = a1 & b1
	_and2 G2_and2(g[2], a[2], b[2]); // G2 = a2 & b2
	_and2 G3_and2(g[3], a[3], b[3]); // G3 = a3 & b3

	// Propagate
	_or2 P0_or2(p[0], a[0], b[0]); // P0 = a0 | b0
	_or2 P1_or2(p[1], a[1], b[1]); // P1 = a1 | b1
	_or2 P2_or2(p[2], a[2], b[2]); // P2 = a2 | b2
	_or2 P3_or2(p[3], a[3], b[3]); // P3 = a3 | b3

	// c1 = g0 + (p0 & ci)
	_and2 U0_and2(.y(w0_c1), .a(p[0]), .b(ci));
	_or2 U1_or2(.y(c1), .a(g[0]), .b(w0_c1));

	// c2 = g1 + (p1 & c1) = g1 + (p1 & (g0 + (p0 & ci))) = g1 + (p1 & g0) + (p0 & p1 & ci)
	_and3 U2_and3(.y(w0_c2), .a(p[1]), .b(p[0]), .c(ci));
	_and2 U3_and2(.y(w1_c2), .a(p[1]), .b(g[0]));
	_or3 U4_or3(.y(c2), .a(w0_c2), .b(w1_c2), .c(g[1]));

	// c3 = g2 + (p2 & c2)
	_and3 U5_and3(.y(w0_c3), .a(p[2]), .b(p[1]), .c(g[0]));
	_and4 U6_and4(.y(w1_c3), .a(p[2]), .b(p[1]), .c(p[0]), .d(ci));
	_and2 U7_and2(.y(w2_c3), .a(p[2]), .b(g[1]));
	_or4 U8_or4(.y(c3), .a(w0_c3), .b(w1_c3), .c(w2_c3), .d(g[2]));

	// co = g0 + (p3 & g2) + (p3 & p2 & g1) + (p3 & p2 & p1 & g0) + (p3 & p2 & p1 & p0 & ci)
	_and2 U9_and2(.y(w0_co), .a(p[3]), .b(g[2])); // p3 & g2
	_and3 U10_and3(.y(w1_co), .a(p[3]), .b(p[2]), .c(g[1])); // p3 & p2 & g1
	_and4 U11_and4(.y(w2_co), .a(p[3]), .b(p[2]), .c(p[1]), .d(g[0])); // p3 & p2 & p1 & g0
	_and5 U12_and5(.y(w3_co), .a(p[3]), .b(p[2]), .c(p[1]), .d(p[0]), .e(ci)); // p3 & p2 & p1 & p0 & ci
	_or5 U13_or5(.y(co), .a(g[3]), .b(w0_co), .c(w1_co), .d(w2_co), .e(w3_co));
 
endmodule
