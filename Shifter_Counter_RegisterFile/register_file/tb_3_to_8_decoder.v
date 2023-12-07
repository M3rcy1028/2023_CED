`timescale 1ns/100ps

//testbench for _3_to_8_decoder
module tb_3_to_8_decoder;
	reg [2:0] tb_d;	
	wire [7:0] tb_q;
	
	_3_to_8_decoder dut(.q(tb_q), .d(tb_d));
	
	initial
	begin
		#0 tb_d = 0;
		#3 tb_d = 3'b000;
		#10 tb_d = 3'b001;
		#10 tb_d = 3'b010;
		#10 tb_d = 3'b011;
		#10 tb_d = 3'b100;
		#10 tb_d = 3'b101;
		#10 tb_d = 3'b110;
		#10 tb_d = 3'b111;
		#10 $stop;
	end
endmodule
