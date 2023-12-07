//next state module
module fifo_ns(next_state, wr_en, rd_en, state, data_count);
	input wr_en, rd_en;			//write/read enable
	input [2:0] state;			//current state
	input [3:0] data_count;		//the number of data in FIFO
	output [2:0] next_state;	//next state
	
	//state binary encoding
	parameter INIT = 3'b000;
	parameter WRITE = 3'b001;
	parameter WR_ERR = 3'b010;
	parameter NO_OP = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	
	reg [2:0] next_state;
	
	//combinational logic
	always @ (wr_en, rd_en, state, data_count)
	begin
		case(state)
		(INIT): //current state is INIT
		begin
			if (wr_en == 1'b1 && data_count < 4'b1000) next_state = WRITE;				//is not full
			else if (rd_en == 1'b1 && data_count == 4'b0000) next_state = RD_ERR;	//is empty
			else next_state = NO_OP;
		end
		(WRITE):
		begin
			if (wr_en) //write enable
			begin
				if (data_count < 4'b1000) next_state = WRITE;								//is not full
				else next_state = WR_ERR;															//is full
			end
			else if (rd_en == 1'b1 && data_count > 4'b0000) next_state = READ;		//is not empty
			else next_state = NO_OP;
		end
		(WR_ERR):
		begin
			if (wr_en == 1'b1 && data_count == 4'b1000) next_state = WR_ERR;			//is full
			else if (rd_en == 1'b1 && data_count > 4'b0000) next_state = READ;			//is not empty
			else next_state = NO_OP;
		end
		(NO_OP):
		begin
			if (wr_en)			//write enable
			begin
				if (data_count < 4'b1000) next_state = WRITE;								//is not full
				else next_state = WR_ERR;															//is full
			end
			else if (rd_en)	//read enable
			begin
				if (data_count > 4'b0000) next_state = READ;									//is not empty
				else next_state = RD_ERR;															//is empty
			end
			else next_state = NO_OP;
		end
		(RD_ERR):
		begin
			if (rd_en == 1'b1 && data_count == 4'b0000) next_state = RD_ERR;			//is empty
			else if (wr_en == 1'b1 && data_count < 4'b1000) next_state = WRITE;		//is not full
			else next_state = NO_OP;
		end
		(READ):
		begin
			if (rd_en)			//read enable
			begin
				if (data_count > 4'b0000) next_state = READ;									//is not empty
				else next_state = RD_ERR;															//is empty
			end
			else if (wr_en == 1'b1 && data_count < 4'b1000) next_state = WRITE;		//is not full
			else next_state = NO_OP;
		end
		default: next_state = 3'bx;
		endcase
	end
endmodule
