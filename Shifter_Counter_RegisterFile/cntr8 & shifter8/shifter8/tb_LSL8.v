`timescale 1ns/100ps

//testbench for LSL8
module tb_LSL8;
	reg [1:0] tb_shamt; 	//shift amount
	reg [7:0] tb_d_in; 	//data in
	wire [7:0] tb_d_out; //data out
	
	//instance
	LSL8 dut (.d_out(tb_d_out), .d_in(tb_d_in), .shamt(tb_shamt));
	
	initial
	begin
		#0 tb_shamt = 0; tb_d_in = 0;
		#10 tb_d_in = 8'b1100_0101; 
		#10 tb_shamt = 2'b01;
		#10 tb_shamt = 2'b10;
		#10 tb_shamt = 2'b11;
		#10 tb_d_in = 8'b1110_1011; 
		#10 tb_shamt = 2'b01;
		#10 tb_shamt = 2'b10;
		#10 tb_shamt = 2'b11;
		#10 $stop;
	end
endmodule
