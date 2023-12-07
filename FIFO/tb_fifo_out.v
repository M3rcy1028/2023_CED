`timescale 1ns/100ps

//testbench for fifo_out module
module tb_fifo_out;
	reg [10*8-1:0] STATE;		//state display in string
	reg [2:0] tb_state;		//current state
	reg [3:0] tb_data_count;	//the number of data in FIFO
	wire tb_full, tb_empty, tb_wr_ack, tb_wr_err, tb_rd_ack, tb_rd_err; //full/empty status flag and 4 handshake signal
	
	fifo_out dut(.full(tb_full), .empty(tb_empty), .wr_ack(tb_wr_ack), .wr_err(tb_wr_err), .rd_ack(tb_rd_ack), .rd_err(tb_rd_err), 
	.state(tb_state), .data_count(tb_data_count));
	
	//display state
	always
	#5
	begin
		case(tb_state)
			3'b000: STATE = "INIT";	//default state
			3'b001: STATE = "WRITE";	//default state
			3'b010: STATE = "WR_ERR";	//default state
			3'b011: STATE = "NO_OP";	//default state
			3'b100: STATE = "READ";	//default state
			3'b101: STATE = "RD_ERR";	//default state
			default: STATE = "ERROR";	//default state
		endcase
	end
	
	initial
	begin
		#0 tb_state = 3'b000; tb_data_count = 4'b0000;//INIT, empty = 1
		#20 tb_state = 3'b001;			//WRITE, wr_ack = 1, wr_err = 0, rd_ack = 0, rd_err = 0, empty = 1, full = 0
		#20 tb_data_count = 4'b0110;	//WRITE, wr_ack = 1, wr_err = 0, rd_ack = 0, rd_err = 0, empty = 0, full = 0
		#20 tb_data_count = 4'b1000;	//WRITE, wr_ack = 0, wr_err = 1, rd_ack = 0, rd_err = 0, empty = 0, full = 1
		#20 tb_state = 3'b010;			//WR_ERR, wr_ack = 0, wr_err = 1, rd_ack = 0, rd_err = 0, empty = 0, full = 1
		#20 tb_state = 3'b011;			//NO_OP, wr_ack = 0, wr_err = 0, rd_ack = 0, rd_err = 0, empty = 0, full = 0
		#20 tb_data_count = 4'b1000;	//NO_OP, wr_ack = 0, wr_err = 0, rd_ack = 0, rd_err = 0, empty = 0, full = 1
		#20 tb_data_count = 4'b0000;	//NO_OP, wr_ack = 0, wr_err = 0, rd_ack = 0, rd_err = 0, empty = 1, full = 0
		#20 tb_state = 3'b100;			//READ, wr_ack = 0, wr_err = 0, rd_ack = 0, rd_err = 1, empty = 1, full = 0
		#20 tb_data_count = 4'b1000;	//READ, wr_ack = 0, wr_err = 0, rd_ack = 1, rd_err = 0, empty = 0, full = 1
		#20 tb_data_count = 4'b0011;	//READ, wr_ack = 0, wr_err = 0, rd_ack = 1, rd_err = 0, empty = 0, full = 0
		#20 tb_state = 3'b101;			//RD_ERR, wr_ack = 0, wr_err = 0, rd_ack = 0, rd_err = 1, empty = 0, full = 0
		#40 $stop;
	end
endmodule
