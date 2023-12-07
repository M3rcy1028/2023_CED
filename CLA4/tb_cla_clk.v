`timescale 1ns/100ps

//testbench for cla_clk
module tb_cla_clk;

	reg clk;						//Clock
	reg [31:0] tb_a, tb_b; 	//Input 32-bit data tb_a, tb_b
	reg tb_ci;					//Input 1 bit carry-in
	
	wire [31:0] tb_s_cla;	//Output 32-bit Sum of CLA
	wire tb_co_cla;			//Output 1 bit Carry-out of CLA
	
	parameter STEP = 10;		
	
	//Instantiate the cla_clk module
	cla_clk U0_cla_clk(.s(tb_s_cla), .co(tb_co_cla), .clk(clk), .a(tb_a), .b(tb_b), .ci(tb_ci));
	always #(STEP/2) clk = ~clk; //setting period of clock
	initial
	begin
		//Initialization
		#0			clk = 1'b1; tb_a = 32'h0; tb_b = 32'h0; tb_ci = 1'b0;
		#(STEP); tb_a = 32'hFFFF_FFFF; tb_b = 32'h0000_0000; tb_ci = 1'b1;				//tb_s=00000000 ,tb_co=1
		#(STEP); tb_a = 32'h0000_FFFF; tb_b = 32'hFFFF_0000; tb_ci = 1'b0;	//tb_s=ffffffff ,tb_co=0
		#(STEP); tb_a = 32'h135f_a562; tb_b = 32'h3561_4642; tb_ci = 1'b0;	//tb_s=48c0eba4 ,tb_co=0
		#(STEP*2); $stop;
	end
endmodule
