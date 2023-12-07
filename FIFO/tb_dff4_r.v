`timescale 1ns/100ps

//testbench for dff4_r
module tb_dff4_r;
	reg tb_clk, tb_reset; 	//clock, active-low reset
	reg [3:0] tb_d; 		//input d
	wire [3:0] tb_q; 		//output q
	
	_dff4_r dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset), .d(tb_d));
	
	always #(10) tb_clk = ~tb_clk;//clock period = 10ns
	initial
	begin
		#0 tb_clk = 1'b0; tb_reset = 1'b0; tb_d = 4'b0;
		#3 tb_reset = 1'b1;
		#20 tb_d = 3'b0001;
		#20 tb_d = 3'b0010;
		#20 tb_d = 3'b0011;
		#20 tb_d = 3'b0100;
		#20 tb_d = 3'b0101;
		#20 tb_d = 3'b0110;
		#20 tb_d = 3'b0111;
		#20 tb_d = 3'b1000;
		#20 tb_d = 3'b1001;
		#20 tb_d = 3'b1010;
		#20 tb_d = 3'b1011;
		#20 tb_d = 3'b1100;
		#20 tb_d = 3'b1101;
		#20 tb_d = 3'b1110;
		#20 tb_d = 3'b1111;
		#40 $stop;
	end
endmodule
