//32-bit Ripple Carry Adder
module rca32 (s, co, a, b, ci);
	input [31:0] a, b;	//input 32-bit data a, b
	input ci;				//input 1 bit Carry-in
	output [31:0] s;		//output 32-bit Sum
	output co;				//output 1 bit Carry-out
	wire [7:0] c;			//8-bit Internal carry
	
	rca4 U0_rca4 (.s(s[3:0]), .co(c[0]), .a(a[3:0]), .b(b[3:0]), .ci(ci));				//Sum[3:0]
	rca4 U1_rca4 (.s(s[7:4]), .co(c[1]), .a(a[7:4]), .b(b[7:4]), .ci(c[0]));			//Sum[7:4]
	rca4 U2_rca4 (.s(s[11:8]), .co(c[2]), .a(a[11:8]), .b(b[11:8]), .ci(c[1]));		//Sum[11:8]
	rca4 U3_rca4 (.s(s[15:12]), .co(c[3]), .a(a[15:12]), .b(b[15:12]), .ci(c[2]));	//Sum[15:12]
	rca4 U4_rca4 (.s(s[19:16]), .co(c[4]), .a(a[19:16]), .b(b[19:16]), .ci(c[3]));	//Sum[19:16]
	rca4 U5_rca4 (.s(s[23:20]), .co(c[5]), .a(a[23:20]), .b(b[23:20]), .ci(c[4]));	//Sum[23:20]
	rca4 U6_rca4 (.s(s[27:24]), .co(c[6]), .a(a[27:24]), .b(b[27:24]), .ci(c[5]));	//Sum[27:24]
	rca4 U7_rca4 (.s(s[31:28]), .co(c[7]), .a(a[31:28]), .b(b[31:28]), .ci(c[6]));	//Sum[31:28]
	
	assign co = c[7]; //assign carry out
endmodule
