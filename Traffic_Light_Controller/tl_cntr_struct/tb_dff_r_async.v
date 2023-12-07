`timescale 1ns/100ps

//testbench for tb_dff_r_async
module tb_dff_r_async;
	reg tb_clk, tb_reset_n, tb_d;	//clock, active-low reset, data d
	wire tb_q;
	
	_dff_r_async dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 1; tb_d = 0;
		#3 tb_reset_n = 0; tb_d = 1;
		#10 tb_d = 0;
		#10 tb_d = 1; 
		#10 tb_d = 0; tb_reset_n = 1;
		#10 tb_d = 1;
		#10 $stop;
	end
endmodule
