`timescale 1ns/100ps

// testbench for bus module
module tb_bus; 
	reg clk,reset_n; //clock, active-low reset
	//master0 values
	reg M0_req; 				//request signal
	reg [7:0] M0_address;	//address
	reg M0_wr;					//write or read
	reg [31:0] M0_dout;		//Data out
	wire M0_grant;				//grant signal
	//master1 values
	reg M1_req; 				//request signal
	reg [7:0] M1_address;	//address
	reg M1_wr;					//write or read
	reg [31:0] M1_dout;		//Data out
	wire M1_grant;				//grant signal
	wire [31:0] M_din; 		//Data in
	//slave values
	wire S0_sel, S1_sel; 	//slave selection
	wire [7:0] S_address; 	//address
	wire S_wr; 					//write or read
	wire [31:0] S_din; 		//Data in
	reg [31:0] S0_dout, S1_dout;	//Data out
	
	//instance
	bus dut (.s0_sel(S0_sel), .s1_sel(S1_sel), .s_wr(S_wr), .m0_grant(M0_grant), .m1_grant(M1_grant), 
	.s_address(S_address), .m_din(M_din), .s_din(S_din), .clk(clk), .reset_n(reset_n), 
	.m0_req(M0_req), .m1_req(M1_req), .m0_wr(M0_wr), .m1_wr(M1_wr), .m0_address(M0_address), 
	.m1_address(M1_address), .m0_dout(M0_dout), .m1_dout(M1_dout), .s0_dout(S0_dout), .s1_dout(S1_dout));
	
	always #(10 / 2) clk  =  ~clk;	//clock
	
	initial 
	begin
	#0 clk = 1; reset_n = 0; M0_req = 0; M1_req = 0; M0_address = 0; M1_address = 0; M0_wr = 0; M1_wr = 0;
		M0_dout = 0; M1_dout = 0; S0_dout = 0; S1_dout = 0;
	#8 reset_n = 1;
	#10 M0_req = 1; S0_dout = 32'h0000_0001; S1_dout = 32'h0000_0002;
	#10 M0_wr = 1; 
	#10 M0_address = 8'h01; M0_dout = 32'h0000_0002;
	#10 M0_address = 8'h02; M0_dout = 32'h0000_0004;
	#10 M0_address = 8'h03; M0_dout = 32'h0000_0006;
	#10 M0_address = 8'h20; M0_dout = 32'h0000_0020;
	#10 M0_address = 8'h21; M0_dout = 32'h0000_0022;
	#10 M0_address = 8'h22; M0_dout = 32'h0000_0024;
	#10 M0_address = 8'h23; M0_dout = 32'h0000_0026;
	#10 M0_address = 8'ha0; M0_dout = 32'h0000_00ff;
	#20 $stop;
	end
endmodule 