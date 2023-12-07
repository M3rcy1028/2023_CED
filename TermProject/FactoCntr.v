//factorial offset and operand controller
module FactoCntr(next_mul_opstart, next_mul_opclear, next_operand, next_opstart, next_opdone, next_opclear, next_intrEN, next_result_h, next_result_l, next_state,
						operand, opstart, opclear, opdone, intrEN, result, s_din, s_addr, state, s_wr, s_sel, mul_opdone, mul_opstart, mul_opclear);
	input [63:0] operand, opstart, opclear, opdone, intrEN, s_din;	//offsets and input
	input [127:0] result;	//multiply result
	input [4:0] s_addr;		//offset address
	input [2:0] state;		//current state
	input s_wr, s_sel, mul_opdone;	//write and select signal, multiplier done signal
	input mul_opstart, mul_opclear;	//multiplier start, clear signal
	
	output reg [63:0] next_operand, next_opstart, next_opdone, next_opclear, next_intrEN, next_result_h, next_result_l;	//next offset outputs
	output reg [2:0] next_state;	//next state
	output reg next_mul_opstart, next_mul_opclear;	//next muliplier start/clear signal
	
	//state encoding
	parameter INIT	= 3'b000;		//initial state
	//parameter START = 3'b001;		//not used
	parameter EXEC	= 3'b010;		//calculating factorial state
	parameter DONE	= 3'b011;		//factorial calcultaion done state
	parameter CLEAR	= 3'b100;	//clear all register state
	parameter mul_clear = 3'b101;	//clear all multiplier register state
	
	//state transition
	always @ (*) begin
		///
		//state transition
		case (state)
		(mul_clear): begin	//clear multiplier register
			next_mul_opclear = 0;	//multiplier clear off
			next_opstart = 1;			//multiplier start on
			if (result != 128'b0) begin	//if result is not zero, then assign result_h and result_l
				next_result_h = result[127:64];
				next_result_l = result[63:0];
			end
			next_state <= EXEC;	//next state is EXEC
		end
		(INIT): begin	//Initial state
			//if (opclear[0] == 1) next_state <= CLEAR;	//clear on
			if (opstart == 64'dx)
				next_state <= CLEAR;
			else if (opstart[0] == 1) begin
				if (operand == 64'd0 || operand == 64'd1) begin
					next_opdone[1:0] = 2'b11;	//execution check
					next_state <= DONE;
				end
				else begin
					next_opdone[1] = 1;	//execution check
					next_state <= EXEC;	//calculation start
				end
			end
			else
				next_state <= INIT;
		end
		(CLEAR): begin	//clear all register state;
			next_opclear = opclear;
			next_intrEN = intrEN;
			next_operand = operand;
			next_opdone = 64'b0;
			next_opstart = 64'b0;
			next_result_h = 64'b0;
			next_result_l = 64'd1;	//result_l default value is 1
			next_mul_opclear = 1;	//booth multiplier clear
			next_mul_opstart = 1;
			if (opstart[0] == 1) next_state <= CLEAR;
			else next_state <= INIT;
		end
		(EXEC): begin	//Factorial execution state
			next_opdone[1] = 1;
			next_mul_opclear = 0;	//multiplier clear off
			if (mul_opdone == 1) begin	//multiplier calculation is done
				next_mul_opclear = 1;		//multiplier clear
				next_operand = operand - 1;//decrease operand value
				next_state <= mul_clear;	//move to mul_clear state
			end
			else begin	//multiplier calculation is not done
				if (operand == 64'd0) begin	//0!
					next_opdone[0] = 1;	//factorial calculation is done
					next_state <= DONE;	//move to done state
				end
				else if (operand == 64'd1) begin	// 1!
					next_opdone[0] = 1;	//factorial calculation is done
					next_state <= DONE;	//move to done state
				end
				else next_state <= EXEC;	//factorial calculation is not done
			end
		end
		(DONE): begin	////factorial calculation done state
			if (opclear[0] == 1)
				next_state <= CLEAR;	//hold value
			else
				next_state <= DONE;	//clear on
		end
		endcase
		
		////
		if (s_sel == 0 && next_intrEN == 64'dx) begin	//chip disable
			next_state <= CLEAR;
		end
		if (s_sel == 0 && next_intrEN != 64'dx)
			next_state <= state;
		else if (s_sel == 1 && s_wr == 1) begin
			//opstart
			if (s_addr == 5'd0) next_opstart = s_din;	//write opstart offset
			//opclear
			else if (s_addr == 5'd1) next_opclear = s_din;	//write opclear offset
			//intrEN	
			else if (s_addr == 5'd3) next_intrEN = s_din;	//write intrEN offset
			//operand
			else if (s_addr == 5'd4) next_operand = s_din;	//write operand offset
		end
	end
endmodule
