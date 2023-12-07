//module for bus
module bus(s0_sel, s1_sel, s_wr, m0_grant, m1_grant, s_address, m_din, s_din, clk, reset_n, m0_req, m1_req, m0_wr, m1_wr, m0_address, m1_address, m0_dout, m1_dout, s0_dout, s1_dout);
	input clk, reset_n;	//clock, active-low reset
	input m0_req, m1_req, m0_wr, m1_wr;		//master request, wirte/read signal
	input [7:0] m0_address, m1_address;	//master address
	input [31:0] m0_dout, m1_dout, s0_dout, s1_dout;	//master Data out, slave Data output
	
	output s0_sel, s1_sel, s_wr, m0_grant, m1_grant;	//slave selections, write/read signals, master grant signals
	output [7:0] s_address;										//slave address
	output [31:0] m_din, s_din;								//master/slave Data input
	
	reg [1:0] signal;	//master din select signal
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 1'b0) signal <= 2'b00;
		else signal <= {s0_sel, s1_sel};
	end
	
	//Arbiter
	bus_arbit Arbiter (.m0_grant(m0_grant), .m1_grant(m1_grant), .clk(clk), .reset_n(reset_n), .m0_req(m0_req), .m1_req(m1_req));
	//select slave write enable
	mux2 slave_wr (.y(s_wr), .d0(m0_wr), .d1(m1_wr), .s(m1_grant));
	//select slave address
	mux2_8bits slave_addr (.y(s_address), .d0(m0_address), .d1(m1_address), .s(m1_grant));
	//select slave Data in
	mux2_32bits slave_din (.y(s_din), .d0(m0_dout), .d1(m1_dout), .s(m1_grant));
	//bus address decoder
	bus_addr Address_Decoder (.s0_sel(s0_sel), .s1_sel(s1_sel), .addr(s_address));
	//select master Data in
	mux3_32bits master_din (.y(m_din), .d0(s0_dout), .d1(s1_dout), .d2(32'h0), .s(signal));
	
endmodule
