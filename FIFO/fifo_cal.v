//calculate address module
module fifo_cal(we, re, next_head, next_tail, next_data_count, state, head, tail, data_count);
	input [2:0] state, head, tail;		//current state, head pointer, tail pointer
	input [3:0] data_count;					//the number of data in FIFO
	output we, re;								//write/read enable
	output [2:0] next_head, next_tail;	//next head/tail pointer
	output [3:0] next_data_count;			//the next number of data in FIFO
	
	//state binary encoding
	parameter INIT = 3'b000;
	parameter WRITE = 3'b001;
	parameter WR_ERR = 3'b010;
	parameter NO_OP = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	
	reg we, re;
	reg [2:0] next_head, next_tail;
	reg [3:0] next_data_count;
	
	always @ (state, head, tail, data_count)
	begin
		case(state)
		(INIT):	//initialization
		begin
			we <= 1'b0;
			re <= 1'b0;
			next_head <= head;
			next_tail <= 3'b000; 
			next_data_count <= 4'b0000;
		end
		(WRITE):
		begin
			we <= 1'b1;	//write enable
			re <= 1'b0;
			next_head <= head;
			next_tail <= tail + 3'b001; 					//tail + 1
			next_data_count <= data_count + 4'b0001; 	//data_count + 1
		end
		(WR_ERR):
		begin
			we <= 1'b0;
			re <= 1'b0;
			next_head <= head;
			next_tail <= tail;
			next_data_count <= data_count;
		end
		(READ):
		begin
			we <= 1'b0;
			re <= 1'b1;	//read enable
			next_head <= head + 3'b001;					//head + 1
			next_tail <= tail;
			next_data_count <= data_count + 4'b1111;	//data_count - 1
		end
		(RD_ERR):
		begin
			we <= 1'b0;
			re <= 1'b0;
			next_head <= head;
			next_tail <= tail;
			next_data_count <= data_count;
		end
		(NO_OP): 
		begin
			we <= 1'b0;
			re <= 1'b0;
			next_head <= head;
			next_tail <= tail;
			next_data_count <= data_count;
		end
		default:
		begin
			we <= 1'bx;
			re <= 1'bx;
			next_head <= 3'bx;
			next_tail <= 3'bx;
			next_data_count <= 4'bx;
		end
		endcase
	end
	
endmodule
