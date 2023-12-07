`timescale 1ns/100ps

module tb_mux2_32bits;
	reg [31:0] tb_d0, tb_d1; 	//input d0, d1, d2 
	reg tb_s; 			 	//selection
	wire [31:0] tb_y; 			//output y
	
	//instance
	mux2_32bits dut (.y(tb_y), .d0(tb_d0), .d1(tb_d1), .s(tb_s));
	
	initial
	begin
		#0 tb_d0 = 32'h0; tb_d1 = 32'h0; tb_s = 0;
		#10 tb_d0 = 32'hFFFF_FFFF;
		#10 tb_d1 = 32'hAAAA_AAAA;
		#10 tb_s = 1;
		#20 $stop;
	end
endmodule
