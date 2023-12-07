`timescale 1ns/100ps

//testbench for fifo_ns module
module tb_fifo_ns;
	reg tb_wr_en, tb_rd_en;		//write/read enable
	reg [2:0] tb_state;			//current state
	reg [3:0] tb_data_count;	//the number of data in FIFO
	wire [2:0] tb_next_state;	//next state
	reg [10*8-1:0] STATE;		//state display in string
	reg [10*8-1:0] NEXT_STATE;		//state display in string

	//instance
	fifo_ns dut(.next_state(tb_next_state), .wr_en(tb_wr_en), .rd_en(tb_rd_en), .state(tb_state), .data_count(tb_data_count));
	
	//display state
	always
	#20
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
		case(tb_next_state)
			3'b000: NEXT_STATE = "INIT";	//default state
			3'b001: NEXT_STATE = "WRITE";	//default state
			3'b010: NEXT_STATE = "WR_ERR";	//default state
			3'b011: NEXT_STATE = "NO_OP";	//default state
			3'b100: NEXT_STATE = "READ";	//default state
			3'b101: NEXT_STATE = "RD_ERR";	//default state
			default: NEXT_STATE = "ERROR";	//default state
		endcase
	end
	
	initial
	begin
		#0  tb_wr_en = 1'b0; tb_rd_en = 1'b0; tb_state = 3'b0; tb_data_count = 4'b0;		//current state = INIT, next_state = NO_OP
		#20 tb_rd_en = 1'b1;																					//current state = INIT, next_state = RD_ERR
		#20 tb_state = 3'b101; tb_wr_en = 1'b1; tb_rd_en = 1'b0;									//current state = RD_ERR, next_state = WRITE
		#20 tb_rd_en = 1'b0; tb_wr_en =1'b1; 															//current state = RD_ERR,next_state = WRITE
		#20 tb_state = 3'b001;																				//current state = WRITE, next_state = WRITE
		#20 tb_data_count = 4'b1000; 																		//current state = WRITE, next_state = WR_ERR
		#20 tb_state = 3'b010; tb_wr_en = 1'b1;														//current state = WR_ERR, next_state = WR_ERR
		#20 tb_wr_en = 1'b0;	tb_rd_en = 1'b1;															//current state = WR_ERR, next_state = READ
		#20 tb_rd_en = 1'b0;																					//current state = WR_ERR, next_state = NO_OP
		#20 tb_data_count = 4'b0010; tb_rd_en = 1'b1; tb_wr_en = 1'b0;							//current state = WR_ERR, next_state = READ
		#20 tb_state = 3'b100; tb_rd_en = 1'b0;														//current state = READ, next_state = NO_OP
		#20 tb_rd_en = 1'b1;																					//current state = READ, next_state = READ
		#20 tb_state = 3'b011;																				//current state = NO_OP, next_state = READ
		#20 tb_state = 3'b011; tb_rd_en = 1'b0; tb_wr_en = 1'b1;									//current state = NO_OP, next_state = WRITE
		#40 $stop;
	end
endmodule
