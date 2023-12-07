//top module
module Top(m_grant, m_din, interrupt, clk, reset_n, m_req, m_wr, m_addr, m_dout);
	input clk, reset_n, m_req, m_wr;	//clock, active-low reset, master request, master write/read
	input [15:0] m_addr;	//master address
	input [63:0] m_dout;	//master data output
	
	output m_grant, interrupt;	//master grant, interrupt signal
	output [63:0] m_din;			//master data input
	
	wire  s0_sel, s1_sel, s_wr;		//s0/s1 select signal
	wire [15:0] s_addr;					//slave address
	wire [63:0] s0_dout, s1_dout;		//slave outputs
	wire [63:0] w_s_din;					//slave input
	
	//bus module
	BUS bus (.m_grant(m_grant), .m_din(m_din), .reset_n(reset_n), .clk(clk), .s0_sel(s0_sel), .s1_sel(s1_sel), .s_addr(s_addr), .s_din(w_s_din), 
	.s_wr(s_wr), .m_req(m_req), .m_wr(m_wr), .m_addr(m_addr), .m_dout(m_dout), .s0_dout(s0_dout), .s1_dout(s1_dout));
	
	//slave0 (memory)
	ram slave0 (.s_dout(s0_dout), .clk(clk), .cen(s0_sel), .wen(s_wr), .s_addr(s_addr[10:3]), .s_din(w_s_din));
	
	//slave1 (Factorial Core)
	FactoCore slave1 (.s_dout(s1_dout), .interrupt(interrupt), .clk(clk), .reset_n(reset_n), 
	.s_sel(s1_sel), .s_wr(s_wr), .s_addr(s_addr), .s_din(w_s_din));
endmodule
