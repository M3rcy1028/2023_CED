`timescale 1ns/100ps

//testbench for shifter8 module
module tb_shifter8; 
	reg tb_clk, tb_reset_n; //clock, active-low reset
	reg [2:0] tb_op; // 3-bit operation code
	reg [1:0] tb_shamt; // 2-bit shift amount
	reg [7:0] tb_d_in; //8-bit tb_d_in
	
	wire [7:0] tb_d_out; //8-bit tb_d_out;
		
	// Instance shifter8
	shifter8 U0_shifter8(.d_out(tb_d_out), .clk(tb_clk), .reset_n(tb_reset_n), .op(tb_op), .shamt(tb_shamt), .d_in(tb_d_in));
	
	always #(10/2) tb_clk = ~tb_clk; //clock period : 10ns
	
	initial
		begin
		#0 tb_clk = 0; tb_op = 0; tb_shamt = 0; tb_d_in = 0; tb_reset_n = 0;
		#3 tb_reset_n = 1; tb_op=3'b001; tb_d_in=8'b10111000;	//LOAD
		#10 tb_op=3'b010;													//LSL
		#20 tb_shamt=2'b01;	//shift amount = 1;
		#25 tb_op=3'b011;		//LSR, shamt = 1;
		#10 tb_op=3'b010; tb_shamt=2'b11; tb_d_in=8'b10110111;//LSL, shamt = 3
		#10 tb_op=3'b011; tb_d_in=8'b10010111;						//LSR, shamt = 3
		#25 tb_op=3'b100; tb_shamt=2'b10;							//ASR, shamt = 2
		#25 tb_shamt=2'b11;												//ASR, shamt = 3
		#25 tb_reset_n=0;
		#10 $stop;
		end
endmodule 
