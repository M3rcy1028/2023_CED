`timescale 1ns/100ps

//testbench for dff32_r
module tb_dff32_r;
	reg tb_clk, tb_reset; 	//clock, active-low reset
	reg [31:0] tb_d; 		//input d
	wire [31:0] tb_q; 		//output q
	
	_dff32_r dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset), .d(tb_d));
	
	always #(10) tb_clk = ~tb_clk;//clock period = 10ns
	initial
	begin
		#0 tb_clk = 1'b0; tb_reset = 1'b0; tb_d = 32'h0000_0000;
		#3 tb_reset = 1'b1;
		#20 tb_d = 32'h0000_0000;
		#20 tb_d = 32'hFFFF_FFFF;
		#20 tb_d = 32'h1234_5678;
		#20 tb_d = 32'habcd_ef00;
		#20 tb_d = 32'h3579_1848;
		#20 tb_d = 32'ha7b1_f4d2;
		#20 tb_d = 32'h0e11_0230;
		#40 $stop;
	end
endmodule
