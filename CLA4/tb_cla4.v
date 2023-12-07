`timescale 1ns/100ps

//testbench for 4-bit CLA
module tb_cla4;

	reg [3:0] tb_a, tb_b;	//Input 32-bit data tb_a, tb_b
	reg tb_ci;					//Input 1 bit carry-in
	
	wire [3:0] tb_s;			//Output 32-bit Sum
	wire tb_co;					//Output 1 bit carry-out
	wire [4:0] tb_result;	
	
	//Group tb_co, tb_s and assign them to tb_result
	assign tb_result = {tb_co, tb_s};
	
	//Instantiation cla4
	cla4 U0_cla4(.a(tb_a), .b(tb_b), .ci(tb_ci), .s(tb_s), .co(tb_co));
	
	initial
	begin
		#0;	tb_a = 0; tb_b = 0; tb_ci = 0;					//Initialization
		#10;	tb_a = 4'b0011; tb_b = 4'b0101; tb_ci = 0;	//tb_s = 1000, tb_co = 0
		#10;	tb_a = 4'b0111; tb_b = 4'b1001; tb_ci = 0;	//tb_s = 0000, tb_co = 1
		#10;	tb_a = 4'b0101; tb_b = 4'b0101; tb_ci = 1;	//tb_s = 1011, tb_co = 0
		#10;	tb_a = 4'b0100; tb_b = 4'b0111; tb_ci = 1;	//tb_s = 1100, tb_co = 0
		#10;	tb_a = 4'b1111; tb_b = 4'b1111; tb_ci = 0;	//tb_s = 1110, tb_co = 1
		#10;	tb_a = 4'b1111; tb_b = 4'b1111; tb_ci = 1;	//tb_s = 1111, tb_co = 1
		#10;	$stop;
	end
	
endmodule
