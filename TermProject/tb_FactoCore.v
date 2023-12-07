`timescale 1ns/100ps

//testbench for Factorial Core
module tb_FactoCore;
	reg clk, reset_n, s_sel, s_wr;
	reg [15:0] s_addr;
	reg [63:0] s_din;
	
	wire [63:0] s_dout;	//output
	wire interrupt;
	
	//instance
	FactoCore dut (s_dout, interrupt, clk, reset_n, s_sel, s_wr, s_addr, s_din);
	
	parameter T = 10;
	
	always # (T/2) clk = ~clk;	//period : 10
	
	initial
	begin
		#0 clk = 1; reset_n = 0; s_sel = 1; s_wr = 0; s_addr = 16'b0; s_din = 64'b0;
		#7	reset_n = 1; 
		//20!
		#(T) s_wr = 1; s_din = 64'd19; s_addr = 16'h7021;	//chip select, write enable, operand write
		#(T) s_din = 64'd0; s_addr = 16'h7018;					//interrupt off
		#(T) s_addr = 16'h7000; s_din = 64'd1;					//opstart 
		#(T) s_wr = 0; s_addr = 16'h7010;
		#(800*T)
		#(T) s_addr = 16'h7028;						//read result_h
		#(T) s_addr = 16'h7030;										//read result_l
		#(T) s_wr = 1; s_addr = 16'h7008; s_din = 64'd1;	//opclear
		#(T) s_din = 64'd0;
		//0!
		#(T) s_din = 64'd0; s_addr = 16'h7027;					//operand write
		#(T) s_din = 64'd1; s_addr = 16'h7019;					//interrupt on
		#(T) s_addr = 16'h7006; s_din = 64'd1;					//opstart
		#(T) s_wr = 0; s_addr = 16'h7030;						//read result_l
		#(T) s_wr = 1; s_addr = 16'h7008; s_din = 64'd1;	//opclear
		#(T) s_din = 64'd0;
		//1!
		#(T) s_din = 64'd1; s_addr = 16'h7025;					//operand write
		#(T) s_din = 64'd1; s_addr = 16'h7019;					//interrupt on
		#(T) s_addr = 16'h7005; s_din = 64'd1;					//opstart
		#(T) s_wr = 0; s_addr = 16'h7030;						//read result_l
		#(T) $stop;
	end
endmodule
