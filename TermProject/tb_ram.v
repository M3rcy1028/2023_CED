`timescale 1ns/100ps

module tb_ram;
	reg clk, cen, wen;		//clock, chip enable, write enable
	reg [7:0] s_addr;		//address
	reg [63:0] s_din;		//data in
	wire [63:0] s_dout;	//data out
	
	always # (10) clk = ~clk;
	
	ram dut (s_dout, clk, cen, wen, s_addr, s_din);
	
	initial
	begin
		#0 clk = 1; cen = 0; wen = 0; s_addr = 8'b0; s_din = 64'b0;
		#15 cen = 1; wen = 1; s_addr = 8'h00; s_din = 64'h1111_1111_1111_1111;
		#20 s_addr = 8'h04; s_din = 64'h2222_2222_2222_2222;
		#20 s_addr = 8'h08; s_din = 64'h3333_3333_3333_3333;
		#20 cen = 0;
		#20 s_addr = 8'h8F; s_din = 64'hFFFF_FFFF_FFFF_FFFF;
		#20 cen = 1; wen = 0;
		#20 s_addr = 8'h00;
		#20 s_addr = 8'h04;
		#20 s_addr = 8'h08;
		#20 s_addr = 8'h12;
		#20 s_addr = 8'h8F;
		#40 $stop;
	end
endmodule 
