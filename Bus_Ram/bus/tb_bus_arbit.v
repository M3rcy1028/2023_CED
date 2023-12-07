`timescale 1ns/100ps

//testbench for arbiter of bus
module tb_bus_arbit;
	reg tb_clk, tb_reset_n, tb_m0_req, tb_m1_req;	//clock, active-low reset, master request
	wire tb_m0_grant, tb_m1_grant;	//master grant signal
	
	//instance
	bus_arbit dut (.m0_grant(tb_m0_grant), .m1_grant(tb_m1_grant), .clk(tb_clk), .reset_n(tb_reset_n), 
	.m0_req(tb_m0_req), .m1_req(tb_m1_req));
	
	always # (10 / 2) tb_clk = ~tb_clk;	//clock
	
	initial
	begin
		#0 tb_clk = 0; tb_reset_n = 0; tb_m0_req = 0; tb_m1_req = 0;
		#13 tb_reset_n = 1;	//m0_grant = 1;
		#10 tb_m0_req = 1;
		#20 tb_m0_req = 0;
		#10 tb_m1_req = 1;	//m1_grant = 1;
		#20 tb_m0_req = 1; tb_m1_req = 0;	//m0_grant = 1;
		#10 $stop;
	end
endmodule
