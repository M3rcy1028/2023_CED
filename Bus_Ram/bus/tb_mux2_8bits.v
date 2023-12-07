`timescale 1ns/100ps

module tb_mux2_8bits;
	reg [7:0] tb_d0, tb_d1; 	//input d0, d1, d2 
	reg tb_s; 			 	//selection
	wire [7:0] tb_y; 			//output y
	
	//instance
	mux2_8bits dut (.y(tb_y), .d0(tb_d0), .d1(tb_d1), .s(tb_s));
	
	initial
	begin
		#0 tb_d0 = 8'b0; tb_d1 = 8'b0; tb_s = 0;
		#10 tb_d0 = 8'b1111_0000;
		#10 tb_d1 = 8'b0000_1111;
		#10 tb_s = 1;
		#20 $stop;
	end
endmodule
