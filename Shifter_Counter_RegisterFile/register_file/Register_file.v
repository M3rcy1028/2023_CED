//Top module
module Register_file(rData, clk, reset_n, wAddr, wData, we, rAddr);
	input clk, reset_n, we;		//clock, active-low reset, write enable
	input [2:0] wAddr, rAddr;	//Write address, read address
	input [31:0] wData;			//write data
	output [31:0] rData;			//read data
	
	wire [7:0] to_reg;			//write
	wire [31:0] from_reg[7:0]; //8bits wire from_reg. from_reg is register output
	
	
	//Wirte_operation input(wAddr, we) -> output(to_reg)
	write_operation U0_write_logic(.to_reg(to_reg[7:0]), .Addr(wAddr[2:0]), .we(we));
	
	//read_operation input(rAddr, from_reg[7:0]) -> output(rData)
	read_operation U1_read_logic(.Data(rData[31:0]), .Addr(rAddr[2:0]), .from_reg0(from_reg[0]), .from_reg1(from_reg[1]), .from_reg2(from_reg[2]),
	.from_reg3(from_reg[3]), .from_reg4(from_reg[4]), .from_reg5(from_reg[5]), .from_reg6(from_reg[6]), .from_reg7(from_reg[7]));
	
	//register32_8 input (clk, reset_n, to_reg, wData) -> output(from_reg[7:0])
	register32_8 U2_register32_8(.d_out0(from_reg[0]), .d_out1(from_reg[1]), .d_out2(from_reg[2]), .d_out3(from_reg[3]), .d_out4(from_reg[4]),
	.d_out5(from_reg[5]), .d_out6(from_reg[6]), .d_out7(from_reg[7]), .clk(clk), .reset_n(reset_n), .en(to_reg[7:0]), .d_in(wData[31:0]));

endmodule
