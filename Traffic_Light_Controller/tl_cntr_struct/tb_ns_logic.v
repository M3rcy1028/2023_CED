`timescale 1ns/100ps

//testbench for ns_logic
module tb_ns_logic;
	reg tb_Ta, tb_Tb, tb_q1, tb_q0;
	wire tb_d1, tb_d0;
	
	//instance
	ns_logic dut(.d1(tb_d1), .d0(tb_d0), .Ta(tb_Ta), .Tb(tb_Tb), .q1(tb_q1), .q0(tb_q0));
	
	initial
	begin
		#0 tb_q1 = 1'b0; tb_q0 = 1'b0; tb_Ta = 1'b1; tb_Tb = 1'b0; //S0
		#5 tb_Tb = 1'b1;
		#5 tb_q0 = 1'b1; 									 					  //S1
		#5 tb_q1 = 1'b1; tb_q0 = 1'b0; tb_Ta = 1'b0;					  //S2
		#5 tb_q1 = 1'b1; tb_q0 = 1'b0; tb_Tb = 1'b0; 
		#5 tb_q0 = 1'b1; tb_Ta = 1'b1; tb_Tb = 1'b1; 				  //S3
		#10 $stop;
	end
endmodule
