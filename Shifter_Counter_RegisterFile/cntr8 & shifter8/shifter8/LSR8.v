//8-bit logical shift right module
module LSR8 (d_out, d_in, shamt);
	input [7:0] d_in;		//data in
	input [1:0] shamt;	//shift amount
	output [7:0] d_out;	//data out
	
	//instance
	mx4 U0_mx4(.y(d_out[7]), .d0(d_in[7]), .d1(0), .d2(0), .d3(0), .s(shamt)); 						// d7
	mx4 U1_mx4(.y(d_out[6]), .d0(d_in[6]), .d1(d_in[7]), .d2(0), .d3(0), .s(shamt)); 				// d6
	mx4 U2_mx4(.y(d_out[5]), .d0(d_in[5]), .d1(d_in[6]), .d2(d_in[7]), .d3(0), .s(shamt)); 		// d5
	mx4 U3_mx4(.y(d_out[4]), .d0(d_in[4]), .d1(d_in[5]), .d2(d_in[6]), .d3(d_in[7]), .s(shamt)); // d4
	mx4 U4_mx4(.y(d_out[3]), .d0(d_in[3]), .d1(d_in[4]), .d2(d_in[5]), .d3(d_in[6]), .s(shamt)); // d3
	mx4 U5_mx4(.y(d_out[2]), .d0(d_in[2]), .d1(d_in[3]), .d2(d_in[4]), .d3(d_in[5]), .s(shamt)); // d2
	mx4 U6_mx4(.y(d_out[1]), .d0(d_in[1]), .d1(d_in[2]), .d2(d_in[3]), .d3(d_in[4]), .s(shamt)); // d1
	mx4 U7_mx4(.y(d_out[0]), .d0(d_in[0]), .d1(d_in[1]), .d2(d_in[2]), .d3(d_in[3]), .s(shamt)); // d0
endmodule
