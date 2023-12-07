`timescale 1ns/100ps

//testbench for ram module
module tb_ram;
	reg tb_clk, tb_cen, tb_wen;	//clock, chip enable, write enable
	reg [4:0] tb_addr;				//address
	reg [31:0] tb_din;				//Data in
	wire [31:0] tb_dout;				//Data out
	
	//instance
	ram dut (.dout(tb_dout), .clk(tb_clk), .cen(tb_cen), .wen(tb_wen), .addr(tb_addr), .din(tb_din));
	
	always #(20/2) tb_clk = ~tb_clk;	//clock
	
	initial begin
	#0 tb_clk = 0; tb_cen = 0; tb_wen = 0; tb_addr = 0; tb_din = 0;
	#5 tb_cen = 1; tb_wen = 1; tb_addr = 5'b00001; tb_din = 32'h1234_ABCD;
	#20 tb_addr =  5'b00100; tb_din = 32'h1357_2468;
	#20 tb_addr =  5'b10000; tb_din = 32'hF0F0_F0F0;
	#20 tb_wen = 0;	//write disable
	#20 tb_addr = 5'b00001;	//tb_dout = 32'h1234_ABCD
	#20 tb_addr = 5'b00100; //tb_dout = 32'h1357_2468
	#20 tb_addr = 5'b10000; //tb_dout = 32'hF0F0_F0F0
	#20 tb_addr = 5'b00011;	//tb_dout = 0
	#20 tb_cen = 0; //chip disable
	#20 tb_wen = 1; tb_addr = 5'b00011; tb_din = 32'h1111_FFFF;	//can't write
	#20 tb_cen = 1; tb_wen = 0; tb_addr = 5'b00011;	//dout = 0
	#40 $stop;
	end
endmodule 