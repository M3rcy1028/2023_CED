//multiplier next state logic module
module multiplier_ns(state, clk, reset_n, cnt, op_start, op_clear, op_done);
	input clk, reset_n, op_start, op_clear, op_done;	//clock, active-low reset, start/clear/done operation
	output [6:0] cnt;		//64-cycle counter
	output [1:0] state;	//current state
	
	//state encoding
	parameter INIT = 2'b00;
	parameter EXEC = 2'b01;
	parameter DONE = 2'b10;

	wire [7:0] result_cnt;			//result_cnt = cnt - 1
	reg [6:0] cnt, next_cnt;		//current cnt, next cnt
	reg [1:0] state, next_state;	//current state, next state
	
	//cnt--
	cla8 counter(.s(result_cnt), .co(), .a({1'b0, next_cnt}), .b(8'b11111110), .ci(1'b0));
	
	//Counting the number of booth operations
	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 1'b0)	//initialization
		begin
			cnt = 7'b1000000;
			state <= INIT;
		end
		else if (op_start == 1'b0)	//not start yet
		begin
			cnt = 7'b1000000;
			state <= INIT;
		end
		else if (op_clear == 1'b1)	//reset state and counter
		begin
			cnt = 7'b0000000;	//reset counter
			state <= INIT;		//INIT state while op_clear = 1
		end
		else
		begin
			cnt = result_cnt[6:0];	//store next counter
			state <= next_state;		//store next state
		end
	end
	
	//state transition
	always @ (state, next_state, cnt, op_start, op_clear, op_done)
	begin
		case (state)
		(INIT):	//Initial state
		begin
			if((op_start == 1'b1) && (op_done == 1'b0) && (op_clear == 1'b0)) 
			begin
				next_state <= EXEC;	//execute calculation
				next_cnt <= 7'b1000000;
			end
		end
		(EXEC):	//executing(calulating) state
		begin
			if(cnt == 7'b0000000) //calculation is done
			begin
				next_state <= DONE;	//DONE state
				next_cnt <= cnt; 		//next_cnt = 0
			end
			else 	//execution is not done
			begin
				next_state <= EXEC;
				next_cnt <= cnt; 		//next_cnt = cnt - 1
			end
		end
		(DONE):	//execution done state
		begin
			next_state <= DONE;
			next_cnt <= 7'b0000000;
		end
		default: //error state
		begin
			next_state = 2'bx;
			next_cnt = 7'bx;
		end
		endcase
	end
endmodule
