`timescale 1ns/100ps

//testbench for multiplier_ns
module tb_multiplier_ns;
	reg tb_clk, tb_reset_n;	//clock, reset
	reg tb_op_start, tb_op_clear, tb_op_done;	//operations
	
	wire [6:0] tb_cnt;	//64 cycle counter
	wire [1:0] tb_state;	//current state
	
	//instance
	multiplier_ns dut (.state(tb_state), .clk(tb_clk), .reset_n(tb_reset_n), .cnt(tb_cnt), .op_start(tb_op_start),
	.op_clear(tb_op_clear), .op_done(tb_op_done));
	
	always #(10/2) tb_clk = ~tb_clk;	//clock
	
	initial 
	begin
	#0 tb_clk = 0; tb_reset_n = 0; tb_op_start = 0; tb_op_clear = 0; tb_op_done = 0;
	#7 tb_reset_n = 1; tb_op_start = 1;
	#800 tb_op_clear = 1;
	#100 tb_op_clear = 0; tb_reset_n = 0;
	#100 $stop;
	end
endmodule 