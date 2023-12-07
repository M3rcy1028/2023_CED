`timescale 1ns/100ps

//testbench for ns_logic
module tb_ns_logic;
	reg tb_Ta, tb_Tal, tb_Tb, tb_Tbl;	//traffic lights with/without left
	reg tb_q2, tb_q1, tb_q0;			//Current State
	wire tb_d2, tb_d1, tb_d0;		//Next State
	
	ns_logic dut(.d2(tb_d2), .d1(tb_d1), .d0(tb_d0), .Ta(tb_Ta), .Tal(tb_Tal), .Tb(tb_Tb), .Tbl(tb_Tbl), .q2(tb_q2), .q1(tb_q1), .q0(tb_q0));
	
	initial
	begin
		#0 tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0; tb_q2 = 0; tb_q1 = 0; tb_q0 = 0;
		#10 tb_q2 = 0; tb_q1 = 0; tb_q0 = 0; tb_Ta = 1; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0; //S0
		#10 tb_q2 = 0; tb_q1 = 0; tb_q0 = 0; tb_Ta = 1; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0; 
		#10 tb_q2 = 0; tb_q1 = 0; tb_q0 = 0; tb_Ta = 0; tb_Tal = 1; tb_Tb = 0; tb_Tbl = 0; 
		#10 tb_q2 = 0; tb_q1 = 1; tb_q0 = 0; tb_Ta = 0; tb_Tal = 1; tb_Tb = 1; tb_Tbl = 0; //S2
		#10 tb_q2 = 0; tb_q1 = 1; tb_q0 = 0; tb_Ta = 0; tb_Tal = 1; tb_Tb = 0; tb_Tbl = 0; 
		#10 tb_q2 = 0; tb_q1 = 1; tb_q0 = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0; 
		#10 tb_q2 = 1; tb_q1 = 0; tb_q0 = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0; //S4
		#10 tb_q2 = 1; tb_q1 = 0; tb_q0 = 0; tb_Ta = 1; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0; 
		#10 tb_q2 = 1; tb_q1 = 0; tb_q0 = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 1; 
		#10 tb_q2 = 1; tb_q1 = 1; tb_q0 = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 1; //S6
		#10 tb_q2 = 1; tb_q1 = 1; tb_q0 = 0; tb_Ta = 0; tb_Tal = 1; tb_Tb = 1; tb_Tbl = 1; 
		#10 tb_q2 = 1; tb_q1 = 1; tb_q0 = 0; tb_Ta = 1; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0; 
		#15 $stop;
	end
endmodule
