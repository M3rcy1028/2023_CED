//write operation
module write_operation (to_reg, Addr, we);
	input we;					//write enable
	input [2:0] Addr;			//address
	output [7:0] to_reg;		//written data
	
	wire [7:0] w_a;
	
	//instance of 3 to 8 decoder
	_3_to_8_decoder U0_3_to_8_decoder(.q(w_a[7:0]), .d(Addr[2:0]));
	//instance of AND gates
	_and2 U1_and2(.y(to_reg[0]), .a(we), .b(w_a[0]));
	_and2 U2_and2(.y(to_reg[1]), .a(we), .b(w_a[1]));
	_and2 U3_and2(.y(to_reg[2]), .a(we), .b(w_a[2]));
	_and2 U4_and2(.y(to_reg[3]), .a(we), .b(w_a[3]));
	_and2 U5_and2(.y(to_reg[4]), .a(we), .b(w_a[4]));
	_and2 U6_and2(.y(to_reg[5]), .a(we), .b(w_a[5]));
	_and2 U7_and2(.y(to_reg[6]), .a(we), .b(w_a[6]));
	_and2 U8_and2(.y(to_reg[7]), .a(we), .b(w_a[7]));
	
endmodule
