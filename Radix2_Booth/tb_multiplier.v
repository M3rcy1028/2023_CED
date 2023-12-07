`timescale 1ns/100ps

//testbench for multiplier
module tb_multiplier;
	reg tb_clk, tb_reset_n, tb_op_start, tb_op_clear; //clock, reset, start/clear opseration
	reg[63:0] tb_multiplier, tb_multiplicand; //two inputs
	wire [127:0] tb_result; //128-bit result
	
	//instance
	multiplier dut (.op_done(tb_op_done), .result(tb_result), .clk(tb_clk), .reset_n(tb_reset_n), .multiplier(tb_multiplier), 
	.multiplicand(tb_multiplicand), .op_start(tb_op_start), .op_clear(tb_op_clear));
	
	always #(10/2) tb_clk = ~tb_clk;	//clock
	
	initial 
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_op_start = 0; tb_op_clear = 0; tb_multiplier = 64'b0; tb_multiplicand = 64'b0;
		#13 tb_reset_n = 1; 
		#10 tb_op_start = 1; tb_multiplier = 64'h0000_0000_0000_0064; tb_multiplicand = 64'hFFFF_FFFF_FFFF_FFF9;	//100 * -7 = -700
		#800 tb_op_clear = 1;
		#100 tb_op_clear = 0; tb_multiplier = 64'h0000_0000_0000_0006; tb_multiplicand = 64'h0000_0000_0000_0003;	//6 * 3 = 18
		#800 tb_op_clear = 1;
		#100 tb_op_clear = 0; tb_multiplier = 64'h0000_0000_0000_0002; tb_multiplicand = 64'h0000_0000_0000_0004;
		#200 tb_op_clear = 1;
		#100 tb_reset_n = 0;
		#100 $stop;
	end
endmodule 