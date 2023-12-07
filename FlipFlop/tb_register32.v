//testbench for register32.v
`timescale 1ns/100ps

module tb_register32();
	reg tb_clk;			//clock
	reg [31:0] tb_d;	//input data d
	wire [31:0] tb_q; //output
	
	//instance
	_register32 dut(.q(tb_q), .clk(tb_clk), .d(tb_d));
	
	always #(15/2) tb_clk = ~tb_clk; //clock period = 15ns
	
	initial
	begin
		#0  tb_d = 32'hABCDEF32; tb_clk = 0; 
		#5  tb_d = 32'hF12345A18;
		#7	 tb_d = 32'h12345678; tb_clk = 1; 
		#5  tb_d = 32'h18EE0001; tb_clk = 0; 
		#15 tb_d = 32'h9487D3C1;
		#5  tb_d = 32'hA1B2C3D4;
		#7  tb_d = 32'h006E442F; tb_clk = 1; 
		#10 tb_d = 32'h1654FDD3;
		#7  tb_d = 32'h1957AFCE;
		#8 $stop;
	end
	
endmodule
