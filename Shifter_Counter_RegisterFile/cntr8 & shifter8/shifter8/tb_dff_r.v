`timescale 1ns/100ps

//testbench for tb_dff_r
module tb_dff_r;
	reg tb_clk, tb_reset_n, tb_d;
	wire tb_q;
	
	//instance
	_dff_r dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_d = 1'b0; tb_reset_n = 0;
		#3 tb_reset_n = 1; tb_d = 1'b1;
		#10 tb_d = 1'b0;
		#10 tb_d = 1'b1;
		#10 tb_reset_n = 0;
		#10 $stop;
	end
endmodule
