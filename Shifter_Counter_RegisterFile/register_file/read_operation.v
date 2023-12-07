//Read operation
module read_operation (Data, Addr, from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7);
	input [31:0] from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7; //inputs
	input [2:0] Addr;				//address
	output [31:0] Data;			//read data
	
	//instance of 8 to 1 mux
	_8_to_1_MUX U0_8_to_1_MUX(.d_out(Data[31:0]), .a(from_reg0), .b(from_reg1), .c(from_reg2), .d(from_reg3), .e(from_reg4), .f(from_reg5), .g(from_reg6),
	.h(from_reg7), .sel(Addr[2:0]));
	
endmodule
