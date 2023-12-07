//multiplier output logic module
module multiplier_os(op_done, result, op_clear, clk, reset_n, cnt, multiplier, multiplicand, state);
	input clk, reset_n, op_clear;	//clock, active-low reset, clear operation
	input [1:0] state;	//current state
	input [6:0] cnt;		//counter
	input [63:0] multiplier, multiplicand;
	
	output op_done;		//done operation
	output [127:0] result;	//result of multiplication
	
	//state encoding
	parameter INIT = 2'b00;
	parameter EXEC = 2'b01;
	parameter DONE = 2'b10;
	
	
	wire [63:0] w_sub, w_add;					//wire for subtraction and addition
	reg [63:0] result_add, result_sub;		//result reg for subtraction and addition
	reg [127:0] result, w_temp, w_result;	//current result, temporary stored result for operation, next result
	reg op_done, before_bit;
	
	//create +A and -A
	cla64 addition(.s(w_add), .co(), .a(w_result[127:64]), .b(multiplicand[63:0]), .ci(1'b0));		 	//result[127:63] + A = w_add
	cla64 subtraction(.s(w_sub), .co(), .a(w_result[127:64]), .b(~(multiplicand[63:0])), .ci(1'b1));   //result[127:63] - A = w_sub
	
	//every cycle
	always @ (posedge clk or negedge reset_n)
	begin
		if(reset_n == 0)		//reset
		begin
			result_add = 64'b0;
			result_sub = 64'b0;
		end
		else if (op_clear == 1)	//clear registers
		begin
			result_add = 64'b0;
			result_sub = 64'b0;
		end
		else
		begin	//not clear and reset
			result_add = w_add;
			result_sub = w_sub;
		end
	end
	
	//every cycle
	always @(posedge clk or negedge reset_n)
	begin
		if(reset_n == 1'b0) result = 128'b0; //initialization
		else if (op_clear == 1'b1) result = 128'b0;	//clear result
		else result <= w_result;	//assign next result to output result
	end
	
	//state transition
	always @ (cnt, state, before_bit, op_clear, result_add, result_sub, multiplier, multiplicand, result, w_temp, w_result)
	begin
	if (op_clear == 1)	//clear all registers
	begin
		w_result = 128'b0;
		w_temp = 128'b0;
		before_bit = 1'b0;
		op_done = 1'b0;
	end
	else	//op_clear = 0
	begin
		case (state)
		(INIT):	//initial state
		begin
			w_result = {64'b0, multiplier};
			w_temp = 128'b0;
			op_done = 1'b0;
			before_bit = 1'b0;
		end
		(EXEC):	//execution (calculation) state
		begin
			if (cnt == 7'b1000000)	//calculation set
			begin
				w_result = result;	//store result
				w_temp = 128'b0;		//reset temp value
				op_done = 1'b1;		//set op_done = 1
				before_bit = 1'b0;	//reset before_bit
			end
			else 
			begin
				//01 : Add and shift
				if (result[0] == 1'b0 && before_bit == 1'b1)
				begin
					w_temp = {result_add, result[63:0]};		//w_temp = result + A
					before_bit = result[0];							//store before_bit
					//arithmetic shift right
					w_result = {w_temp[127], w_temp[127:1]};	//reserve sign bit
				end
				//10 : subtract and shifts
				else if (result[0] == 1'b1 && before_bit == 1'b0)
				begin
					w_temp = {result_sub, result[63:0]};		//w_temp = result - A
					before_bit = result[0];							//store before_bit
					//arithmetic shift right
					w_result = {w_temp[127], w_temp[127:1]};	//reserve sign bit
				end
				//00 or 11 : shift only
				else if ((result[0] == 1'b0 && before_bit == 1'b0) || (result[0] == 1'b1 && before_bit == 1'b1))
				begin
					w_temp = result;									//w_temp = result
					before_bit = result[0];							//store before_bit
					//arithmetic shift
					w_result = {result[127], result[127:1]};	//reserve sign bit
				end
			end
		end
		(DONE):	//execution done state
		begin
			op_done = 1;			//set done operation 
			before_bit = 0;		//reset bit
			w_temp = 128'b0;		//reset temporary value
			w_result = result;	//next result = current result
		end
		default:	//error state
		begin
			op_done = 1'bx;
			before_bit = 1'bx;
			w_result = 128'bx;
			w_temp = 128'bx;
		end
		endcase
	end
	end
endmodule

