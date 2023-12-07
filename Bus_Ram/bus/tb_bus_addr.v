`timescale 1ns/100ps

//testbench for address decoder of bus
module tb_bus_addr;
	reg [7:0] tb_addr; 		//address
	wire tb_s0_sel, tb_s1_sel; //slave selection
	
	//instance
	bus_addr dut (.s0_sel(tb_s0_sel), .s1_sel(tb_s1_sel), .addr(tb_addr));
	
	initial
	begin
		#0 tb_addr = 8'h00;	//s0
		#10 tb_addr = 8'h0F;	//s0
		#10 tb_addr = 8'h20;	//s1
		#10 tb_addr = 8'h2F;	//s1
		#10 tb_addr = 8'h40;	//non
		#10 tb_addr = 8'h50;	//non
		#10 $stop;
	end
endmodule
