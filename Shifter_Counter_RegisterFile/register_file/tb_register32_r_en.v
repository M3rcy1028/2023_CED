`timescale 1ns/100ps

//testbench for register32_r_en
module tb_register32_r_en;
	reg tb_clk, tb_reset_n, tb_en;	//clock, reset, enable
	reg [31:0] tb_d;			//data
	wire [31:0] tb_q;		//output
	
	register32_r_en dut (.q(tb_q), .clk(tb_clk), .reset_n(tb_reset_n), .en(tb_en), .d(tb_d));

	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 1; tb_en = 0; tb_d = 0;
		#3 tb_clk = 0; tb_en = 1; tb_d = 32'h1111_1010;
		#10 tb_d = 32'h1111_1010;
		#10 tb_d = 32'h1100_0011;
		#10 tb_d = 32'h1010_0101;
		#10 tb_d = 32'h1110_0111; tb_en = 0;
		#10 tb_d = 32'h1000_0000;
		#10 tb_d = 32'h0000_0101;
		#10 tb_d = 32'h1011_1111;
		#10  $stop;
	end
endmodule
