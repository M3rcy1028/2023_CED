//testbench for resettable D Flip-Flop
`timescale 1ns/100ps

module tb_dff_r();
	reg tb_clk, tb_reset_n, tb_d;	//input
	wire tb_q;	//output
	
	//instance
	_dff_r dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always #(15/2) tb_clk = ~tb_clk; //clock period = 15ns

	initial 
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_d = 0;
		#5 tb_d = 1;
		#7 tb_d = 0; tb_reset_n = 1;
		#5 tb_d = 1;
		#7 tb_d = 0;
		#5 tb_d = 1;
		#7 tb_d = 0;
		#5 tb_d = 1; tb_reset_n = 0;
		#7 tb_d = 0;
		#5 tb_d = 1;
		#7 tb_d = 0;
		#5 tb_d = 1;
		#7 tb_d = 0;
		#10 $stop;
	end
endmodule
