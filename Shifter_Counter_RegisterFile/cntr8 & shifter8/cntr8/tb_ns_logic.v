`timescale 1ns/100ps

//testbench or ns_logic module
module tb_ns_logic;
	reg tb_load, tb_inc;
	reg [2:0] tb_state;
	wire [2:0] tb_next_state;
	
	ns_logic dut(.next_state(tb_next_state), .load(tb_load), .inc(tb_inc), .state(tb_state));
	
	initial
	begin
	#0 tb_load = 1; tb_inc = 0; tb_state = 3'b000;
	#10 tb_load = 0; tb_inc = 1;
	#10 tb_state = 3'b010; tb_inc = 1;
	#10 tb_inc = 0;
	#10 tb_state = 3'b100; tb_inc = 0;
	#10 tb_load = 1;
	#10 tb_inc = 0;
	#10 tb_inc = 1;
	#10 $stop;
	end
endmodule

