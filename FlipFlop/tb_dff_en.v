//testbench for enable D Flip-Flip
`timescale 1ns/100ps

module tb_dff_en();
	reg	tb_clk, tb_en, tb_d;	//input
	wire	tb_q;	//output
		
	//instance
	_dff_en dut(.q(tb_q), .clk(tb_clk), .en(tb_en), .d(tb_d));
	
	always #(15/2) tb_clk = ~tb_clk; //clock period = 15ns
	
	initial 
	begin
		#0 tb_clk = 0; tb_en=1; tb_d=0;
		#5 tb_d = 1;
		#12 tb_d = 0;
		#12 tb_d = 1;
		#12 tb_d = 0;
		#12 tb_d = 1;
		#12 tb_d = 0; tb_en = 0;
		#12 tb_d = 1;
		#12 tb_d = 0;
		#12 tb_d = 1;
		#12 tb_d = 0;
		#12 tb_d = 1;
		#12 tb_d = 0;
		#12 $stop;
	end
		
endmodule
