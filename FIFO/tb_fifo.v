`timescale 1ns/100ps

//testbench for fifo module
module tb_fifo;
	reg CLK_RESETn;			//division line for clock and reset
	reg tb_clk, tb_reset; 	//clock, active-low reset
	
	reg FIFO_INPUT;			//division line for FIFO input
	reg tb_wr_en, tb_rd_en; //write/read enable
	reg [31:0] tb_d_in; 		//input d_in
	
	reg FIFO_OUTPUT;			//division line for FIFO output
	wire [31:0] tb_d_out; 	//output d_out
	wire [3:0] tb_data_count; //the number of data in FIFO
	wire tb_full, tb_empty, tb_wr_ack, tb_wr_err, tb_rd_ack, tb_rd_err; //full/empty status flag and 4 handshake signal
	
	//top module instance
	fifo dut(.d_out(tb_d_out), .full(tb_full), .empty(tb_empty), .wr_ack(tb_wr_ack), .wr_err(tb_wr_err), .rd_ack(tb_rd_ack), .rd_err(tb_rd_err), .data_count(tb_data_count),
	.clk(tb_clk), .reset_n(tb_reset), .rd_en(tb_rd_en), .wr_en(tb_wr_en), .d_in(tb_d_in));
		
	always
	begin
		#(10) tb_clk = ~tb_clk;//clock period = 10ns
	end
	
	initial 
	begin
		#0 CLK_RESETn = 1'b1; tb_clk = 1'b0; tb_reset = 1'b0; FIFO_INPUT = 1'b1; tb_rd_en = 1'b0; tb_wr_en = 1'b0; 
		FIFO_OUTPUT = 1'b1; tb_d_in = 32'h0000_0000;
		#2 tb_reset = 1'b1;
		#20 tb_rd_en = 1'b1;
		#20 tb_rd_en = 1'b0; tb_wr_en = 1'b1; tb_d_in = 32'h0000_0011;
		#20 tb_d_in = 32'h0000_0022;
		#20 tb_d_in = 32'h0000_0033;
		#20 tb_d_in = 32'h0000_0044;
		#20 tb_d_in = 32'h0000_0055;
		#20 tb_d_in = 32'h0000_0066;
		#20 tb_d_in = 32'h0000_0077;
		#20 tb_d_in = 32'h0000_0088;
		#20 tb_d_in = 32'h0000_0099;
		#20 tb_d_in = 32'h0000_00aa;
		#20 tb_d_in = 32'h0000_00bb;
		#20 tb_wr_en = 1'b0;
		#20 tb_rd_en = 1'b1;
		#40 tb_rd_en = 1'b0; tb_wr_en = 1'b1;
		#20 tb_d_in = 32'h0000_00cc;
		#20 tb_rd_en = 1'b1; tb_wr_en = 1'b0;
		#60 tb_rd_en = 1'b0;
		#20 tb_rd_en = 1'b1;
		#100 $stop;
	end
endmodule 
