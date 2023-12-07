//top module
module multiplier(op_done, result, clk, reset_n, multiplier, multiplicand, op_start, op_clear);
	input clk, reset_n, op_start, op_clear;	//clock, active-low reset, start/clear opearation
	input[63:0] multiplier, multiplicand;		//two inputs
	
	output op_done;			//done operations
	output [127:0] result;	//128-bit result
	
	wire [6:0] cnt;			//64-cycle counter
	wire [1:0] state;			//current state
	
	//instances of multiplier_ns and multiplier_os
	multiplier_ns mul_ns (.state(state), .clk(clk), .reset_n(reset_n), 
	.cnt(cnt), .op_start(op_start), .op_clear(op_clear), .op_done(op_done));
	
	multiplier_os mul_os (.op_done(op_done), .result(result), .op_clear(op_clear), .clk(clk), 
	.reset_n(reset_n), .cnt(cnt), .multiplier(multiplier), .multiplicand(multiplicand), .state(state));
endmodule
