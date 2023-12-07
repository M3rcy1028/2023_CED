`timescale 1ns/100ps

//testbench for mx4
module tb_mx4;
	reg tb_d3, tb_d2, tb_d1, tb_d0; //inputs
	reg [1:0] tb_s; //selection signal
	wire tb_y;
	
	mx4 dut(.y(tb_y), .s(tb_s), .d3(tb_d3), .d2(tb_d2), .d1(tb_d1), .d0(tb_d0));
	
	initial
	begin
		#0 tb_d3 = 0; tb_d2 = 0; tb_d1 = 0; tb_d0 = 0; tb_s = 0;
		#10 tb_d3 = 1; tb_d2 = 0; tb_d0 = 1; tb_s = 2'b01;
		#10 tb_d3 = 0; tb_d2 = 1; tb_d1 = 1; tb_d0 = 1; tb_s = 2'b10;
		#10 tb_d0 = 0;  
		#10 tb_d3 = 1; tb_s = 2'b11;
		#10 tb_d2 = 1; tb_d0 = 1; tb_s = 2'b01;
		#10 tb_d3 = 0; tb_d1 = 0;
		#10 tb_d3 = 1; tb_d2 = 0; tb_d0 = 1; tb_s = 2'b11;
		#10 $stop;
	end
endmodule
