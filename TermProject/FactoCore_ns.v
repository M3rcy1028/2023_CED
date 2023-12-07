//
module FactoCore_ns(interrupt, state, opstart, opclear, opdone, intrEN, operand, clk, reset_n, s_addr, s_din, s_wr, s_sel);
	input clk, reset_n, s_wr, s_sel;
	input [15:0] s_addr;
	input [63:0] s_din;
	input [63:0] opstart, opclear, opdone, intrEN;
	output reg [63:0] operand;
	output reg interrupt;
	output [1:0] state; 
	

	

endmodule
