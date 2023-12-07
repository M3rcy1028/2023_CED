`timescale 1ns/100ps

module tb_rca4;
	reg [3:0] tb_a, tb_b;	//4-bit input data tb_a adn tb_b
	reg tb_ci;					//1-bit carry-in tb_ci
	wire [3:0] tb_s;			//4-bit output sum tb_s
	wire tb_co;					//1-bit carry-out tb_co
	
rca4 scenario0(tb_s, tb_co, tb_a, tb_b, tb_ci);

initial
begin
	//when ci = 0
	#0		tb_a = 4'b0011; tb_b = 4'b0011; tb_ci = 0;	//tb_s = 0110,tb_co=0
	#10	tb_a = 4'b0001; tb_b = 4'b1110; tb_ci = 0;	//tb_s = 1111,tb_co=0
	#10	tb_a = 4'b1101; tb_b = 4'b1101; tb_ci = 0;	//tb_s = 1010,tb_co=1
	#10	tb_a = 4'b1010; tb_b = 4'b1010; tb_ci = 0;	//tb_s = 0100,tb_co=1
	//when ci = 1
	#10	tb_a = 4'b0011; tb_b = 4'b0011; tb_ci = 1;	//tb_s = 0111,tb_co=0
	#10	tb_a = 4'b0001; tb_b = 4'b1110; tb_ci = 1;	//tb_s = 0000,tb_co=1
	#10	tb_a = 4'b1101; tb_b = 4'b1101; tb_ci = 1;	//tb_s = 1011,tb_co=1
	#10	tb_a = 4'b1010; tb_b = 4'b1010; tb_ci = 1;	//tb_s = 0101,tb_co=1
	#10	$finish;
end
	
endmodule
