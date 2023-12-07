//bus module
module BUS (m_grant, m_din, reset_n, clk, s0_sel, s1_sel, s_addr, s_din, s_wr, m_req, m_wr, m_addr, m_dout, s0_dout, s1_dout);
	input clk, reset_n, m_req, m_wr;			//clock, active-low reset, master request, master write/read
	input [15:0] m_addr;							//master address
	input [63:0] m_dout, s0_dout, s1_dout;	//master data out, s0/s1 data out
	
	output m_grant, s_wr;		//master grant, write signal
	output reg s0_sel, s1_sel;	//master grant signal, slave write/read, s0/s1 select signal
	output [15:0] s_addr;		//slave address
	output [63:0] s_din;			//slave input
	output [63:0] m_din;		 	//slave/master data in
	
	//assign slave inputs
	assign s_wr = m_wr;
	assign s_din = m_dout;
	assign s_addr = m_addr;
	assign m_grant = m_req;
	//s0_sel = 1, m_din = s0_dout / s1_sel = 1, m_din = s1_dout / else m_din = 0
	assign m_din = (s0_sel == 1) ? s0_dout : ((s1_sel == 1) ? s1_dout : 64'b0);

	always @ (*)
	begin
		if (reset_n == 0) {s0_sel, s1_sel} = 2'b00;
		else if (m_req == 1'b0)	{s0_sel, s1_sel} = 2'b00; //master request is 0
		else begin
			if ((m_addr[15:8] >= 8'h00) && (m_addr[15:8] < 8'h08)) {s0_sel, s1_sel} = 2'b10;	//slave 0
			else if ((m_addr[15:8] >= 8'h70) && (m_addr[15:8] < 8'h72))	{s0_sel, s1_sel} = 2'b01;//slave 1
			else {s0_sel, s1_sel} = 2'b00;	//non select
		end
	end	//always
endmodule
