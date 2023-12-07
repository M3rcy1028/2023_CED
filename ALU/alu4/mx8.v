//1 bit 8-to-1 MUX
module mx8(y, a, b, c, d, e, f, g, h, s2, s1, s0);
	input a, b, c, d, e, f, g, h;	//input data
	input s2, s1, s0;					//selection
	output y;							//output
	
	wire w0, w1, w2, w3, w4, w5;	//Inner wires
	
	//mx2 instance
	//s0 select
	mx2 U0_mx2(.y(w0), .d0(a), .d1(b), .s(s0));
	mx2 U1_mx2(.y(w1), .d0(c), .d1(d), .s(s0));
	mx2 U2_mx2(.y(w2), .d0(e), .d1(f), .s(s0));
	mx2 U3_mx2(.y(w3), .d0(g), .d1(h), .s(s0));
	//s1 select
	mx2 U4_mx2(.y(w4), .d0(w0), .d1(w1), .s(s1));
	mx2 U5_mx2(.y(w5), .d0(w2), .d1(w3), .s(s1));
	//s2 select
	mx2 U6_mx2(.y(y), .d0(w4), .d1(w5), .s(s2));
endmodule
