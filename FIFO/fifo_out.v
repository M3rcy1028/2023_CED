//output logic module
module fifo_out(full, empty, wr_ack, wr_err, rd_ack, rd_err, state, data_count);
	input [2:0] state;		//current state
	input [3:0] data_count;	//the number of data in FIFO
	output full, empty, wr_ack, wr_err, rd_ack, rd_err; //full/empty status flag and 4 handshake signal
	
	//state binary encoding
	parameter INIT = 3'b000;
	parameter WRITE = 3'b001;
	parameter WR_ERR = 3'b010;
	parameter NO_OP = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	
	reg full, empty, wr_ack, wr_err, rd_ack, rd_err;
	
	always @ (state, data_count)
	begin
		case(state)
			(INIT):
			begin
				wr_ack <= 1'b0;
				rd_ack <= 1'b0;
				wr_err <= 1'b0;
				rd_err <= 1'b0;
				full <= 1'b0;
				empty <= 1'b1;		//initial data count is 0
			end
			(WRITE):
			begin
				wr_ack <= 1'b1;	//write enable
				rd_ack <= 1'b0;
				wr_err <= 1'b0;
				rd_err <= 1'b0;
				if (data_count == 4'b1000)	//is full
				begin
					full <= 1'b1;
					empty <= 1'b0;
				end
				else if (data_count == 4'b1000)	//is empty
				begin
					full <= 1'b0;
					empty <= 1'b1;
				end
				else	//not full and not empty
				begin
					full <= 1'b0;
					empty <= 1'b0;
				end
			end
			(WR_ERR):
			begin
				wr_ack <= 1'b0;
				rd_ack <= 1'b0;
				wr_err <= 1'b1;	//write error
				rd_err <= 1'b0;
				if (data_count == 4'b1000)	//is full
				begin
					full <= 1'b1;
					empty <= 1'b0;
				end
				else	//not full and not empty
				begin
					full <= 1'b0;
					empty <= 1'b0;
				end
			end
			(READ):
			begin
				wr_ack <= 1'b0;
				rd_ack <= 1'b1;	//read enable
				wr_err <= 1'b0;
				rd_err <= 1'b0;
				if (data_count == 4'b1000)	//is full
				begin
					full <= 1'b1;
					empty <= 1'b0;
				end
				else if (data_count == 4'b1000)	//is empty
				begin
					full <= 1'b0;
					empty <= 1'b1;
				end
				else	//not full and not empty
				begin
					full <= 1'b0;
					empty <= 1'b0;
				end
			end
			(RD_ERR):
			begin
				wr_ack <= 1'b0;
				rd_ack <= 1'b0;
				wr_err <= 1'b0;
				rd_err <= 1'b1;	//read error
				if (data_count == 4'b1000)	//is full
				begin
					full <= 1'b1;
					empty <= 1'b0;
				end
				else	//not full and not empty
				begin
					full <= 1'b0;
					empty <= 1'b0;
				end
			end
			(NO_OP):
			begin
				wr_ack <= 1'b0;
				rd_ack <= 1'b0;
				wr_err <= 1'b0;
				rd_err <= 1'b0;
				if (data_count == 4'b1000)	//is full
				begin
					full <= 1'b1;
					empty <= 1'b0;
				end
				else if (data_count == 4'b1000)	//is empty
				begin
					full <= 1'b0;
					empty <= 1'b1;
				end
				else	//not full and not empty
				begin
					full <= 1'b0;
					empty <= 1'b0;
				end
			end
			default:
			begin
				wr_ack <= 1'bx;
				rd_ack <= 1'bx;
				wr_err <= 1'bx;
				rd_err <= 1'bx;
				full <= 1'bx;
				empty <= 1'bx;
			end
		endcase
	end
endmodule
