`timescale 1ns/100ps

//testbench for cla8
module tb_cla8;
	reg [7:0] tb_a, tb_b;
	reg tb_ci;
	wire [7:0] tb_s;
	wire tb_co;
	
	cla8 dut(.s(tb_s), .co(tb_co), .a(tb_a), .b(tb_b), .ci(tb_ci));
	
	initial
	begin
		#0 tb_ci = 0; tb_a = 0; tb_b = 0;
		#10 tb_ci = 1; tb_a = 8'b0000_0001; 
		#10 tb_b = 8'b1111_1110;
		#10 tb_a = 8'b1101_0010; tb_b = 8'b1110_1111; tb_ci = 0;
		#10 tb_a = 8'b0001_0011; tb_b = 8'b1011_0100; tb_ci = 1;
		#10 $stop;
	end
endmodule
