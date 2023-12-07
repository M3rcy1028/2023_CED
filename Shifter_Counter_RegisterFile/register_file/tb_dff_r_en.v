`timescale 1ns/100ps

//testbench for _dff_r_en
module tb_dff_r_en;
	reg tb_clk, tb_reset_n, tb_en, tb_d;	//clock, reset, enable, data
	wire tb_q;					//output
	
	_dff_r_en dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .en(tb_en), .d(tb_d));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_d = 0; tb_reset_n = 0; tb_en = 1;
		#3 tb_reset_n = 1; tb_d = 1'b1;
		#10 tb_d = 1'b0;
		#10 tb_d = 1'b1;
		#10 tb_d = 1'b1; tb_en = 0;
		#10 tb_d = 1'b0;
		#10 tb_d = 1'b1;
		#10 tb_d = 1'b0;	
		#10 $stop;
	end
endmodule
