`timescale 1ns/100ps

module tb_mux3_32bits;
	reg [31:0] tb_d0, tb_d1, tb_d2; 	//input d0, d1, d2 
	reg [1:0] tb_s; 			 	//selection
	wire [31:0] tb_y; 			//output y
	
	//instance
	mux3_32bits dut (.y(tb_y), .d0(tb_d0), .d1(tb_d1), .d2(tb_d2), .s(tb_s));
	
	initial
	begin
		#0 tb_d0 = 32'h0; tb_d1 = 32'h0; tb_d2 = 32'h0; tb_s = 2'b00;
		#10 tb_d0 = 32'h1111_1111;
		#10 tb_d1 = 32'h2222_2222;
		#10 tb_d2 = 32'h3333_3333;
		#10
		#10 tb_s = 2'b01;
		#20 tb_s = 2'b10;
		#20 $stop;
	end
endmodule
