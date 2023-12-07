//1-bit 4-to-1 multiplexer
module mx4 (y, s, d3, d2, d1, d0);
	input d3, d2, d1, d0; //selection signal, inputs
	input [1:0] s;			 //2-bit input s
	output y;				 //result
	
	wire w0, w1;
	
	//instance of mx2
	mx2 U0_mx2(.y(w0), .d0(d0), .d1(d1), .s(s[0]));
	mx2 U1_mx2(.y(w1), .d0(d2), .d1(d3), .s(s[0]));
	mx2 U2_mx2(.y(y), .d0(w0), .d1(w1), .s(s[1]));
endmodule
