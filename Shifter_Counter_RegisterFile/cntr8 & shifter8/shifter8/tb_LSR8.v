`timescale 1ns/100ps

//testbench for LSR8
module tb_LSR8;
	reg [1:0] tb_shamt; 	//shift amount
	reg [7:0] tb_d_in; 	//data in
	wire [7:0] tb_d_out; //data out
	
	//instance
	LSR8 dut (.d_out(tb_d_out), .d_in(tb_d_in), .shamt(tb_shamt));
	
	initial
	begin
		#0 tb_shamt = 0; tb_d_in = 0;
		#10 tb_d_in = 8'b0011_1101; 
		#10 tb_shamt = 2'b01;
		#10 tb_shamt = 2'b10;
		#10 tb_shamt = 2'b11;
		#10 tb_d_in = 8'b1001_1100; 
		#10 tb_shamt = 2'b01;
		#10 tb_shamt = 2'b10;
		#10 tb_shamt = 2'b11;
		#10 $stop;
	end
endmodule
