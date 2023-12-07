//top module
module fifo(d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count, clk, reset_n, rd_en, wr_en, d_in);
	input clk, reset_n, rd_en, wr_en;	//clock, active-low reset, read/write enable
	input [31:0] d_in;						//32-bit data in
	output [31:0] d_out;						//32-bit data out
	output full, empty, wr_ack, wr_err, rd_ack, rd_err;	//full/empty status flag and 4 handshake signal
	output [3:0] data_count;				//the number of data in FIFO
	
	wire [2:0] state, next_state;		//current state & next state
	wire [2:0] head, tail;				//current head & tail pointer
	wire [2:0] next_head, next_tail;	//next head & tail pointer
	wire [3:0] next_data_count;		//the next number of data in FIFO
	wire we, re;							//write & read enable
	wire [31:0] w0, w1;					//wire for 32-bit MUX
	
	//FIFO next state logic instance
	fifo_ns U0_fifo_ns (.next_state(next_state), .wr_en(wr_en), .rd_en(rd_en), .state(state), .data_count(data_count));
	
	//FIFO calculation logic instance
	fifo_cal U1_fifo_cal(.we(we), .re(re), .next_head(next_head), .next_tail(next_tail), .next_data_count(next_data_count), .state(next_state), .head(head), .tail(tail), .data_count(data_count));
	
	//FIFO output logic instance
	fifo_out U2_fifo_out(.full(full), .empty(empty), .wr_ack(wr_ack), .wr_err(wr_err), .rd_ack(rd_ack), .rd_err(rd_err), .state(state), .data_count(data_count));
	
	//Flip-Flops for state, head, tail, data_count depending on clock and reset
	_dff3_r U3_dff3_r(.q(state), .clk(clk), .reset_n(reset_n), .d(next_state));
	_dff3_r U5_dff3_r(.q(head), .clk(clk), .reset_n(reset_n), .d(next_head));
	_dff3_r U6_dff3_r(.q(tail), .clk(clk), .reset_n(reset_n), .d(next_tail));
	_dff4_r U4_dff4_r(.q(data_count), .clk(clk), .reset_n(reset_n), .d(next_data_count));

	//Register file instance
	Register_file U7_Register_file(.rData(w0), .clk(clk), .reset_n(reset_n), .wAddr(tail), .wData(d_in), .we(we), .rAddr(head));
	
	//32-bit Multipluxer instance using read enable
	mx2_32bits U8_mx2_32bits(.y(w1), .s(re), .d0(32'b0), .d1(w0));
	
	//32-bit Resettable D Flip-Flop instance for output d_out depending on clock and reset
	_dff32_r U9_dff32_r(.q(d_out), .clk(clk), .reset_n(reset_n), .d(w1));
endmodule
