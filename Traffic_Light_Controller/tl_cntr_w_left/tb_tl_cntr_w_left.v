`timescale 1ns/100ps

//testbench for tl_cntr_w_left
module tb_tl_cntr_w_left;
	reg tb_clk, tb_reset_n;							//Clock, active-low reset
	reg tb_Ta, tb_Tal, tb_Tb, tb_Tbl;	//inputs
	wire [1:0] tb_La, tb_Lb;				//outputs
	
	//instance
	tl_cntr_w_left dut(.La(tb_La), .Lb(tb_Lb), .clk(tb_clk), .reset_n(tb_reset_n), .Ta(tb_Ta), .Tal(tb_Tal), .Tb(tb_Tb), .Tbl(tb_Tbl));
	
	always #(20/4) tb_clk = ~tb_clk;	//clock
	
	initial 
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0; //initialization
		#5 tb_reset_n = 1; tb_Ta = 1;
		#10 tb_Ta = 0;
		#10 tb_Tal = 1;
		#10 tb_Tal = 0;
		#10 tb_Tb = 1;
		#10 tb_Tb = 0;
		#10 tb_Tbl = 1;
		#10 tb_Tbl = 0;
		#10 $stop;
	end
endmodule 