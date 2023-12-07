`timescale 1ns/100ps

module tb_cla32;
	reg [31:0] tb_a, tb_b;	//4-bit input data tb_a adn tb_b
	reg tb_ci;					//1-bit carry-in tb_ci
	wire [31:0] tb_s;			//4-bit output sum tb_s
	wire tb_co;					//1-bit carry-out tb_co
	
cla32 scenario0(tb_s, tb_co, tb_a, tb_b, tb_ci);

initial
begin
	//Initialization
	#0 	tb_a = 32'h0000_0000; tb_b = 32'h0000_0000; tb_ci = 1'b0;
		
	#10	tb_a = 32'hFFFF_FFFF; tb_b = 32'h0000_0000; tb_ci = 1'b1;	//tb_s=00000000, tb_co=1
	#10	tb_a = 32'h0000_FFFF; tb_b = 32'hFFFF_0000; tb_ci = 1'b1;	//tb_s=ffffffff, tb_co=0
	#10	tb_a = 32'h135f_a562; tb_b = 32'h3561_4642; tb_ci = 1'b0;	//tb_s=00000000, tb_co=0
	#10	tb_a = 32'h2561_abb1; tb_b = 32'h1234_5678; tb_ci = 1'b0;	//tb_s=00000000, tb_co=0
	#10	$finish;
end
	
endmodule
