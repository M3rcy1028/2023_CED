`timescale 1ns/100ps

module tb_ha;
	reg tb_a, tb_b;	//1-bit input data tb_a and tb_b
	wire tb_s, tb_co;	//1-bit output sum tb_s, carry-out tb_co
	
ha dut_ha(tb_s, tb_co, tb_a, tb_b);

initial
begin
	//Exhaustive verification
	#0		tb_a = 0; tb_b = 0;	//tb_s = 0, tb_co = 0
	#10	tb_a = 0; tb_b = 1;	//tb_s = 1, tb_co = 0
	#10	tb_a = 1; tb_b = 0;	//tb_s = 1, tb_co = 0
	#10	tb_a = 1; tb_b = 1;	//tb_s = 0, tb_co = 1
	#10	$finish;
end
	
endmodule
