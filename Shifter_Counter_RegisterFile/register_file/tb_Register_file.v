`timescale 1ns/100ps

//testbench for register_file
module tb_Register_file;
	reg tb_clk, tb_reset_n, tb_we;		//clock, active-low reset, write enable
	reg [2:0] tb_wAddr, tb_rAddr;	//Write address, read address
	reg [31:0] tb_wData;			//write data
	wire [31:0] tb_rData;			//read data
	
	Register_file dut(.rData(tb_rData), .clk(tb_clk), .reset_n(tb_reset_n), .wAddr(tb_wAddr), .wData(tb_wData), .we(tb_we), .rAddr(tb_rAddr));
	
	always # (10/2) tb_clk = ~tb_clk;
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_we = 0; tb_wAddr = 0; tb_rAddr = 0; tb_wData = 0;
		#7 tb_reset_n = 1; tb_we = 1; tb_wData = 32'h1111_1111;
		#10 tb_wAddr = 3'b001; tb_wData = 32'hff00_ff00;
		#10 tb_wAddr = 3'b010;
		#10 tb_wAddr = 3'b011; tb_wData = 32'h00ff_00ff;
		#10 tb_we = 0;
		#10 tb_rAddr = 3'b001;
		#10 tb_rAddr = 3'b010;
		#10 tb_rAddr = 3'b011;
		#20 $stop;
	end
endmodule
