`timescale 1ns/100ps

//testbench for Top module
module tb_Top;
	reg clk, reset_n, m_req, m_wr;	//clock, active-low reset, master request, master write/read
	reg [15:0] m_addr;					//master address
	reg [63:0] m_dout;					//master data output
	
	wire m_grant, interrupt;	//master grant, interrupt signal
	wire [63:0] m_din;			//master data input
	
	//instance
	Top dut (m_grant, m_din, interrupt, clk, reset_n, m_req, m_wr, m_addr, m_dout);
	
	parameter T = 100;	//time step = 100ns
	
	always # (T / 10) clk = ~clk;	//period 20
	
	initial
	begin
		#0 clk = 0; reset_n = 0; m_req = 0; m_wr = 0; m_addr = 16'b0; m_dout = 64'b0;
		#7 reset_n = 1;
		//slave 0 (memory)
		//write
		#(T) m_req = 1; m_wr = 1; m_addr = 16'h0000; m_dout = 64'h1111_1111_1111_1111;
		#(T) m_addr = 16'h006F; m_dout = 64'h3333_3333_3333_3333;
		#(T) m_addr = 16'h07FF; m_dout = 64'h1234_1234_1234_1234;
		#(T) m_addr = 16'hFFFF; m_dout = 64'h0000_1111_2222_3333;	//non-select
		//read
		#(T) m_wr = 0; m_addr = 16'h0000; m_dout = 16'd0;
		#(T) m_addr = 16'h006F;
		#(T) m_addr = 16'h07FF;
		#(T) m_addr = 16'hFFFF;	//0
		//slave 1 (factorial core)
		#(T) m_wr = 0; m_addr = 16'h7030;	//read result_l
		#(T) m_addr = 16'h7028;	//read result_h
		#(T) m_wr = 1; m_addr = 16'h7020; m_dout = 64'd20;	//19!
		#(T) m_addr = 16'h7018; m_dout = 64'd1;	//interrupt on
		#(T) m_addr = 16'h7000; m_dout = 64'd1;	//opstart1
		#(T) m_wr = 0; m_addr = 16'h7010; //read opdone
		#(150*T)
		#(T) m_wr = 0; m_addr = 16'h7030;	//read result_l
		#(T) m_addr = 16'h7028;	//read result_h
		//
		#(T) m_wr = 1; m_addr = 16'h7008; m_dout = 64'd1;	//opclear
		#(T) m_dout = 64'd0; m_addr = 16'h7008;				//clear off
		#(T) m_wr = 1; m_addr = 16'h7020; m_dout = 64'd8;	//8!
		#(T) m_addr = 16'h7018; m_dout = 64'd0;	//interrupt off
		#(T) m_addr = 16'h7000; m_dout = 64'd1;	//opstart
		#10 m_wr = 0; m_addr = 16'h7010; //read opdone
		#(50*T)
		#(T) m_addr = 16'h7030;	//read result_l
		#(T) m_addr = 16'h7028;	//read result_h
		//no master request
		#(T) m_req = 0;
		#100 $stop;
	end
endmodule
