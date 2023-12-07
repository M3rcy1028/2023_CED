`timescale 1ns/100ps

//testbench for dff3_r
module tb_dff3_r;
	reg tb_clk, tb_reset; 	//clock, active-low reset
	reg [2:0] tb_d; 		//input d
	wire [2:0] tb_q; 		//output q
	
	_dff3_r dut(.q(tb_q), .clk(tb_clk), .reset_n(tb_reset), .d(tb_d));
	
	always #(10) tb_clk = ~tb_clk;//clock period = 10ns
	initial
	begin
		#0 tb_clk = 1'b0; tb_reset = 1'b0; tb_d = 3'b0;
		#3 tb_reset = 1'b1;
		#20 tb_d = 3'b001;
		#20 tb_d = 3'b010;
		#20 tb_d = 3'b011;
		#20 tb_d = 3'b100;
		#20 tb_d = 3'b101;
		#20 tb_d = 3'b110;
		#20 tb_d = 3'b111;
		#40 $stop;
	end
endmodule
