`timescale 1ns/100ps

//testbench for _register8_r
module tb_register8_r;
	reg tb_clk, tb_reset_n;
	reg [7:0] tb_d;
	wire [7:0] tb_q;
	
	_register8_r dut (.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/5) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_d = 0; tb_reset_n = 0;
		#3 tb_clk = 1; tb_reset_n = 1; tb_d = 8'b0000_0000;
		#10 tb_d = 8'b0010_1100;
		#10 tb_d = 8'b0101_1010;
		#10 tb_d = 8'b1000_1111;
		#10 tb_d = 8'b1011_0111;
		#10 tb_d = 8'b1100_1110;
		#10 $stop;
	end
endmodule
