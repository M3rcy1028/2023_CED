`timescale 1ns/100ps

//testbench for ns_logic
module tb_register2_r_async;
	reg tb_clk, tb_reset_n;	//clock, active-low reset
	reg [1:0] tb_d;			//Next State
	wire [1:0] tb_q;		//Current State
	
	_register2_r_async dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 1; tb_d = 0;
		#3 tb_reset_n = 0; tb_d = 2'b00;
		#10 tb_d = 2'b01;
		#10 tb_d = 2'b10;
		#10 tb_d = 2'b11;
		#10 tb_reset_n = 1;
		#10 $stop;
	end
endmodule
