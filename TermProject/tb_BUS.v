`timescale 1ns/100ps

//testbench for bus module
module tb_BUS;
	reg clk, reset_n, m_req;
	wire m_grant;
	reg m_wr;
	wire s_wr;
	reg [15:0] m_addr;
	wire [15:0] s_addr;
	wire s0_sel, s1_sel;
	reg [63:0] m_dout, s0_dout, s1_dout;
	wire [63:0] s_din, m_din;
	
	//instance
	BUS dut (m_grant, m_din, reset_n, clk, s0_sel, s1_sel, s_addr, 
	s_din, s_wr, m_req, m_wr, m_addr, m_dout, s0_dout, s1_dout);
	
	always # (10 / 2) clk = ~clk;	//period : 10ns
	
	initial
	begin
		#0 clk = 1; reset_n = 0; m_req = 0; m_wr = 0; m_addr = 16'b0; 
		m_dout = 64'b0; s0_dout = 64'b0; s1_dout = 64'b0;
		#3 reset_n = 1; 
		//m_req = 0
		#20 m_req = 1;
		//slave 0 select
		#10 m_addr = 16'h00DF; s0_dout = 64'd126; m_dout = 64'd7;
		#10 m_wr = 1;
		#10 s0_dout = 64'd1; m_dout = 64'd10;
		#10 m_wr = 0;
		#10 
		//slave 1 select
		#10 m_addr = 16'h7000; s1_dout = 64'd987; m_dout = 64'd9;
		#10 
		#10 m_addr = 16'h71FF; 
		#20 s1_dout = 64'd257; m_dout = 64'd85;
		#10 m_wr = 1;
		//slave non-select
		#10 m_addr = 16'hFFFF; m_dout = 64'd3;
		#30 $stop;
	end
endmodule

