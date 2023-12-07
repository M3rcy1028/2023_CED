`timescale 1ns/100ps

//testbench for o_logic
module tb_o_logic;
	reg tb_q2, tb_q1, tb_q0;	//Current State
	wire tb_La1, tb_La0, tb_Lb1, tb_Lb0;
	
	o_logic dut(.La1(tb_La1), .La0(tb_La0), .Lb1(tb_Lb1), .Lb0(tb_Lb0), .q2(tb_q2), .q1(tb_q1), .q0(tb_q0));
	
	initial
	begin
		#0 tb_q2 = 0; tb_q1 = 0; tb_q0 = 0;
		#3 tb_q2 = 0; tb_q1 = 0; tb_q0 = 1;
		#10 tb_q2 = 0; tb_q1 = 1; tb_q0 = 0;
		#10 tb_q2 = 0; tb_q1 = 1; tb_q0 = 1;
		#10 tb_q2 = 1; tb_q1 = 0; tb_q0 = 0;
		#10 tb_q2 = 1; tb_q1 = 0; tb_q0 = 1;
		#10 tb_q2 = 1; tb_q1 = 1; tb_q0 = 0;
		#10 tb_q2 = 1; tb_q1 = 1; tb_q0 = 1;
		#15 $stop;
	end
endmodule
