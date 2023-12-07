//testbench for D-latch
`timescale 1ns/100ps

module tb_dlatch();
	reg tb_clk, tb_d;		//input
	wire tb_q, tb_q_bar;	//output
	
	//instance
	_dlatch dut(.q(tb_q), .q_bar(tb_q_bar), .clk(tb_clk), .d(tb_d));
	
	always #(15/2) tb_clk = ~tb_clk;	//clock period = 15ns
	
	initial 
	begin
		#0 tb_clk = 0; tb_d = 0;
		#5 tb_d = 0;
		#10 tb_d = 1;
		#15 tb_d = 0;
		#8 tb_d = 1;
		#3 tb_d = 0;
		#17 tb_d = 1;
		#6 $stop;
	end
	
endmodule
