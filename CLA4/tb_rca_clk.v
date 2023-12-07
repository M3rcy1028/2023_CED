`timescale 1ns/100ps

//testbench for rca_clk
module tb_rca_clk;

	reg clk_rca;						//Clock
	reg [31:0] tb_a_rca, tb_b_rca; 	//Input 32-bit data tb_a, tb_b
	reg tb_ci_rca;					//Input 1 bit carry-in
	
	wire [31:0] tb_s_rca;	//Output 32-bit Sum of RCA
	wire tb_co_rca;			//Output 1 bit Carry-out of RCA
	
	parameter STEP_rca = 10;		
	
	//Instantiate the rca_clk module
	rca_clk U0_rca_clk(.s(tb_s_rca), .co(tb_co_rca), .clk(clk_rca), .a(tb_a_rca), .b(tb_b_rca), .ci(tb_ci_rca));
	always #(STEP_rca/2) clk_rca = ~clk_rca; //setting period of clock
	initial
	begin
		//Initialization
		clk_rca = 1'b1;
		tb_a_rca = 32'h0;
		tb_b_rca = 32'h0;
		tb_ci_rca = 1'b0;
		
		#(STEP_rca); tb_a_rca = 32'hFFFF_FFFF; tb_b_rca = 32'h0; tb_ci_rca = 1'b1;
		#(STEP_rca); tb_a_rca = 32'h0000_FFFF; tb_b_rca = 32'hFFFF_0000; tb_ci_rca = 1'b0;
		#(STEP_rca); tb_a_rca = 32'h135f_a562; tb_b_rca = 32'h3561_4642; tb_ci_rca = 1'b0;
		#(STEP_rca*2); $stop;
	end
endmodule
