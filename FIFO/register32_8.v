//32-bit register
module register32_8(d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7, clk, reset_n, en, d_in);
	input clk, reset_n;	//clock, reset
	input [7:0]en;			//enable
	input [31:0]d_in;		//input data
	output [31:0]d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7;	//outputs
	
	//instance of register32_r_en
	register32_r_en U0_register32_r_en (.q(d_out0), .clk(clk), .reset_n(reset_n), .en(en[0]), .d(d_in));
	register32_r_en U1_register32_r_en (.q(d_out1), .clk(clk), .reset_n(reset_n), .en(en[1]), .d(d_in));
	register32_r_en U2_register32_r_en (.q(d_out2), .clk(clk), .reset_n(reset_n), .en(en[2]), .d(d_in));
	register32_r_en U3_register32_r_en (.q(d_out3), .clk(clk), .reset_n(reset_n), .en(en[3]), .d(d_in));
	register32_r_en U4_register32_r_en (.q(d_out4), .clk(clk), .reset_n(reset_n), .en(en[4]), .d(d_in));
	register32_r_en U5_register32_r_en (.q(d_out5), .clk(clk), .reset_n(reset_n), .en(en[5]), .d(d_in));
	register32_r_en U6_register32_r_en (.q(d_out6), .clk(clk), .reset_n(reset_n), .en(en[6]), .d(d_in));
	register32_r_en U7_register32_r_en (.q(d_out7), .clk(clk), .reset_n(reset_n), .en(en[7]), .d(d_in));
endmodule
