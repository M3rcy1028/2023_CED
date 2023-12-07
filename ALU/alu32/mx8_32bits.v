//32-bits 8-to-1 MUX
module mx8_32bits(y, a, b, c, d, e, f, g, h, s2, s1, s0);
	input [31:0] a, b, c, d, e, f, g, h;	//32-bit data input
	input s2, s1, s0;								//selection
	output [31:0] y;								//output
	
	wire [31:0] w0, w1, w2, w3, w4, w5;
	
	//mx2_32bits instance
	//s0 select
	mx2_32bits U0_mx2_32bits(.y(w0), .d0(a), .d1(b), .s(s0));
	mx2_32bits U1_mx2_32bits(.y(w1), .d0(c), .d1(d), .s(s0));
	mx2_32bits U2_mx2_32bits(.y(w2), .d0(e), .d1(f), .s(s0));
	mx2_32bits U3_mx2_32bits(.y(w3), .d0(g), .d1(h), .s(s0));
	//s1 select
	mx2_32bits U4_mx2_32bits(.y(w4), .d0(w0), .d1(w1), .s(s1));
	mx2_32bits U5_mx2_32bits(.y(w5), .d0(w2), .d1(w3), .s(s1));
	//s2 select
	mx2_32bits U6_mx2_32bits(.y(y), .d0(w4), .d1(w5), .s(s2));
endmodule
