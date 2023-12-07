`timescale 1ns/100ps

module tb_fa;
	reg tb_a, tb_b, tb_ci;	//1-bit input data tb_a, tb_b and carry-in tb_ci
	wire tb_s, tb_co;			//1-bit output sum tb_s, tb_co
	
fa dut_fa(tb_s, tb_co, tb_a, tb_b, tb_ci);

initial
begin
	//Exhaustive verification
	#0		tb_a = 0; tb_b = 0; tb_ci = 0;	//tb_s = 0, tb_co = 0
	#10	tb_a = 0; tb_b = 1; tb_ci = 0;	//tb_s = 1, tb_co = 0
	#10	tb_a = 1; tb_b = 0; tb_ci = 0;	//tb_s = 1, tb_co = 0
	#10	tb_a = 1; tb_b = 1; tb_ci = 0;	//tb_s = 0, tb_co = 1
	#0		tb_a = 0; tb_b = 0; tb_ci = 1;	//tb_s = 1, tb_co = 0
	#10	tb_a = 0; tb_b = 1; tb_ci = 1;	//tb_s = 0, tb_co = 1
	#10	tb_a = 1; tb_b = 0; tb_ci = 1;	//tb_s = 0, tb_co = 1
	#10	tb_a = 1; tb_b = 1; tb_ci = 1;	//tb_s = 1, tb_co = 1
	#10	$finish;
end
	
endmodule
