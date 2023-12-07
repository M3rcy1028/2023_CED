`timescale 1ns/100ps

//testbench for fifo_cal
module tb_fifo_cal;
	reg [10*8-1:0] STATE;		//state display in string
	reg [2:0] tb_state, tb_head, tb_tail;		//current state, head pointer, tail pointer
	reg [3:0] tb_data_count;				//the number of data in FIFO
	wire tb_we, tb_re;							//write/read enable
	wire [2:0] tb_next_head, tb_next_tail;	//next head/tail pointer
	wire [3:0] tb_next_data_count;		//the next number of data in FIFO
	
	fifo_cal dut(.we(tb_we), .re(tb_re), .next_head(tb_next_head), .next_tail(tb_next_tail), .next_data_count(tb_next_data_count), 
	.state(tb_state), .head(tb_head), .tail(tb_tail), .data_count(tb_data_count));
	
	//display state
	always
	#2
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
		#0  tb_state=3'b000; tb_head=3'b000; tb_tail=3'b000; tb_data_count=4'b0000; //INIT
		#20 tb_state=3'b001; //WRITE
		#20 tb_head=3'b001; tb_tail=3'b011; tb_data_count=4'b0111;
		#20 tb_state=3'b010; tb_tail=3'b100; tb_data_count=4'b1000;	//WR_ERR
		#20 tb_state = 3'b011;	//NO_OP
		#20 tb_state = 3'b100;	//READ
		#20 tb_state = 3'b101;	//RD_ERR
		#40 $stop;
	end
endmodule
