`timescale 1ns/100ps

//testbench for register32_8
module tb_register32_8;
	reg tb_clk, tb_reset_n;	//clock, reset
	reg [7:0]tb_en;			//enable
	reg [31:0]tb_d_in;		//input data
	wire [31:0]tb_d_out0, tb_d_out1, tb_d_out2, tb_d_out3, tb_d_out4, tb_d_out5, tb_d_out6, tb_d_out7;	//outputs
	
	register32_8 dut(.d_out0(tb_d_out0), .d_out1(tb_d_out1), .d_out2(tb_d_out2), .d_out3(tb_d_out3), .d_out4(tb_d_out4), .d_out5(tb_d_out5)
	, .d_out6(tb_d_out6), .d_out7(tb_d_out7), .clk(tb_clk), .reset_n(tb_reset_n), .en(tb_en), .d_in(tb_d_in));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_en = 8'b0; tb_d_in = 32'b0;
		#3 tb_reset_n=1;
		#10 tb_en[0]=1;
		#10 tb_d_in=32'b11111111001111110000000000000000;
		#10 tb_en[0]=0; tb_en[1]=1;
		#10 tb_en[1]=0; tb_en[2]=1; tb_d_in = 32'b10101010001010100000110000001110;
		#10 tb_en[7] = 1;
		#10 tb_en[5] = 1;
		#10 $stop;
	end
	
endmodule
