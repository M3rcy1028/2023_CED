`timescale 1ns/100ps

//testbench for _register3_r
module tb_register3_r;
	reg tb_clk, tb_reset_n;
	reg [2:0] tb_d;
	wire [2:0] tb_q;
	
	_register3_r dut (.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/5) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_d = 0; tb_reset_n = 0;
		#3 tb_clk = 1; tb_reset_n = 1; tb_d = 3'b000;
		#10 tb_d = 3'b001;
		#10 tb_d = 3'b010;
		#10 tb_d = 3'b100;
		#10 tb_d = 3'b101;
		#10 tb_d = 3'b110;
		#10 $stop;
	end
endmodule
