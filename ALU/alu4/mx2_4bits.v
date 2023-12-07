//4-bit 2-to-1 MUX
module mx2_4bits(y, d0, d1, s);
	input [3:0] d0, d1;	//4-bit data d0, d1
	input s;					//selection
	output [3:0] y;		//4-bit output y
	
	//mx2 instance
	mx2 U0_mx2(.y(y[0]), .d0(d0[0]), .d1(d1[0]), .s(s));	//y[0]
	mx2 U1_mx2(.y(y[1]), .d0(d0[1]), .d1(d1[1]), .s(s));	//y[1]
	mx2 U2_mx2(.y(y[2]), .d0(d0[2]), .d1(d1[2]), .s(s));	//y[2]
	mx2 U3_mx2(.y(y[3]), .d0(d0[3]), .d1(d1[3]), .s(s));	//y[3]
endmodule
