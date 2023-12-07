//testbench for _dff_r_sync_async
`timescale 1ns/100ps

module tb_dff_r_sync_async();
	reg tb_clk, tb_set_n, tb_reset_n, tb_d;
	wire tb_q_sync, tb_q_async;
	
	//instance
   _dff_r_sync_async dut(.q_sync(tb_q_sync), .q_async(tb_q_async), .clk(tb_clk), .set_n(tb_set_n), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/2) tb_clk = ~tb_clk; //clock period : 15ns
	
	initial
	begin
		#0  tb_clk = 0; tb_set_n = 0; tb_reset_n = 0; tb_d = 0;
		#3  tb_d = 1; 
		#10 tb_d = 0;
		#10 tb_d = 1; 
		#10 tb_d = 0;
		#10 tb_d = 1; tb_reset_n = 1;
		#10 tb_d = 0;
		#10 tb_d = 1; 
		#10 tb_d = 0; 
		#10 tb_d = 1;
		#10 tb_d = 0; tb_set_n = 1;
		#10 tb_d = 1;
		#10 tb_d = 0;
		#10 tb_d = 1;
		#10 tb_d = 0;
		#10 tb_d = 1;
		#10 tb_d = 0; tb_reset_n = 0;
		#10 tb_d = 1;
		#10 tb_d = 0;
		#10 tb_d = 1; 
		#10 tb_d = 0; tb_set_n = 0;
		#10 tb_d = 1;
		#10 tb_d = 0;
		#10 tb_d = 1;
		#10 $stop;
	end
	
	
endmodule
