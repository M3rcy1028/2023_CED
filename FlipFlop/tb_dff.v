//testbench for D Flip-Flop
`timescale 1ns/100ps

module tb_dff();
	reg tb_clk, tb_d;		//input
	wire tb_q, tb_q_bar;	//output
	
	//instance
	_dff dut(.q(tb_q), .q_bar(tb_q_bar), .clk(tb_clk), .d(tb_d));
	
	always #(15/2) tb_clk = ~tb_clk;
	
	initial 
	begin
		#0 tb_clk = 0; tb_d = 0; 
		#5 tb_d = 1;
		#10 tb_d = 0;
		#17 tb_d = 1;
		#5 tb_d = 0;
		#20 tb_d = 1;
		#9 tb_d = 0;
		#5 $stop;
	end
	
endmodule
