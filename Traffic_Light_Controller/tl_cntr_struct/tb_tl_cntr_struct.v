`timescale 1ns/100ps
//testbench for tl_cntr
module tb_tl_cntr_struct;
	reg tb_clk, tb_reset_n;	//clock, active-low reset
	reg tb_Ta, tb_Tb;			//input
	wire [1:0] tb_La, tb_Lb;//ouput
	
	//instance
	tl_cntr_struct dut(.La(tb_La), .Lb(tb_Lb), .clk(tb_clk), .reset_n(tb_reset_n), .Ta(tb_Ta), .Tb(tb_Tb));
		
	always #(20/4) tb_clk = ~tb_clk;
	
	initial begin
	#0 tb_clk = 0; tb_reset_n = 1; tb_Ta = 0; tb_Tb = 0;
	#7 tb_Ta = 1; tb_reset_n = 0;
	#10 tb_Ta = 0;
	#10 tb_Tb = 1;
	#10 tb_Tb = 0;
	#25 $stop;
	end
endmodule 
