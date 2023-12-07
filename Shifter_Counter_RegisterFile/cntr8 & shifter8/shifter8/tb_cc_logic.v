`timescale 1ns/100ps

//testbench for cc_logic
module tb_cc_logic;
	reg [2:0] tb_op;			//operation code
	reg [1:0] tb_shamt;		//shift amount
	reg [7:0] tb_d_in;			//data in
	reg [7:0] tb_d_out;		//data out
	wire [7:0] tb_d_next;//next state of data
	
	//instance
	cc_logic dut(.d_next(tb_d_next), .op(tb_op), .shamt(tb_shamt), .d_in(tb_d_in), .d_out(tb_d_out));
	
	initial
	begin
		#0 tb_op = 0; tb_shamt = 0; tb_d_in = 0; tb_d_out = 0;
		#20 tb_op = 3'b001; tb_shamt = 2'b01; tb_d_in = 8'b0101_1100; 
		#20 tb_d_out = 8'b0100_1101; tb_op = 3'b010; tb_shamt = 2'b10;
		#20 tb_d_out = 8'b1000_1100;
		#20 tb_d_out = 8'b1100_1101; tb_op = 3'b011; tb_shamt = 2'b01;
		#20 tb_d_out = 8'b0101_0011;
		#20 tb_d_out = 8'b1100_1101; tb_op = 3'b100; tb_shamt = 2'b11;
		#20 tb_d_out = 8'b0001_1001; tb_d_in = 8'b1101_1100;
		#10 tb_op = 3'b001; tb_shamt = 2'b10;
		#20 tb_op = 4'b100; 
		#20 $stop;
	end
endmodule
