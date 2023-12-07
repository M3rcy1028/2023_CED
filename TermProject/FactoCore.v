//Factorial core module
module FactoCore (s_dout, interrupt, clk, reset_n, s_sel, s_wr, s_addr, s_din);
	input clk, reset_n, s_sel, s_wr;	//clock, active-low reset, slave select/write signal
	input [15:0] s_addr;					//address
	input [63:0] s_din;					//input
	
	output [63:0] s_dout;	//output
	output interrupt;			//interrupt signal
	
	//state encoding
	parameter INIT		= 3'b000;
	//parameter START	= 3'b001;
	parameter EXEC		= 3'b010;
	parameter DONE		= 3'b011;
	parameter CLEAR	= 3'b100;
	parameter mul_clear = 3'b101;	//clear all multiplier register state
	
	//variables for Factorial Core
	reg [63:0] operand, opstart, opclear, opdone, intrEN, result_h, result_l;	//offsets
	wire [63:0] next_operand, next_opstart, next_opclear, next_opdone, next_intrEN, next_result_h, next_result_l;	//next offsets
	reg [2:0] state;			//current state
	wire [2:0] next_state;	//next state
	//variables for Booth multiplier
	reg mul_opstart, mul_opclear;	//multiplier signals
	wire [63:0] next_mul;	//results
	wire mul_opdone, next_mul_opstart, next_mul_opclear;	//multiplier next signals
	wire [127:0] result;		//multiply result
	
	assign interrupt = opdone[0] & intrEN[0];
//	always @ (*) begin
//		if (intrEN[0] == 1 && opdone[0] == 1) interrupt = 1;
//		else interrupt = 0;
//	end
		
	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 0) begin	
			operand <= 64'b0;
			opstart <= 64'b0;
			opclear <= 64'b0;
			opdone <= 64'b0; 
			mul_opstart <= 0; 
			mul_opclear <= 1;
			intrEN <= 64'b0;
			result_h <= 64'b0; 
			result_l <= 64'd1;
			state <= CLEAR;
		end
//		else if (s_sel == 0) begin
//			operand <= next_operand;
//			opstart <= next_opstart;
//			opclear <= next_opclear;
//			opdone <= next_opdone;
//			intrEN <= next_intrEN;
//			result_h <= next_result_h; 
//			result_l <= next_result_l;
//			mul_opstart <= next_mul_opstart;
//			mul_opclear <= next_mul_opclear;
//			state <= next_state;
//		end
		else begin	//reset_n == 1
			operand <= next_operand;
			opstart <= next_opstart;
			opclear <= next_opclear;
			opdone <= next_opdone;
			intrEN <= next_intrEN;
			result_h <= next_result_h; 
			result_l <= next_result_l;
			mul_opstart <= next_mul_opstart;
			mul_opclear <= next_mul_opclear;
			state <= next_state;
		end
	end

	//factorial controller
	FactoCntr FC (next_mul_opstart, next_mul_opclear, next_operand, next_opstart, next_opdone, next_opclear, next_intrEN, next_result_h, next_result_l, next_state,
						operand, opstart, opclear, opdone, intrEN, result, s_din, s_addr[7:3], state, s_wr, s_sel, mul_opdone, mul_opstart, mul_opclear);
	
	//facotorial output logic
	FactoCore_os FO (s_dout, next_mul, clk, reset_n, s_wr, s_sel, opdone, result_h, result_l, s_addr[7:3]);
	
	//Booth multiplier
	multiplier Booth (mul_opdone, result, clk, reset_n, next_mul, operand, mul_opstart, mul_opclear);
	
	
endmodule
