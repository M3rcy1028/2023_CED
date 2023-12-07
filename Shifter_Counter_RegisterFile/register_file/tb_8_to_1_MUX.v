`timescale 1ns/100ps

//testbench for 8-to-1 MUX
module tb_8_to_1_MUX;
	reg [31:0] tb_a, tb_b, tb_c, tb_d, tb_e, tb_f, tb_g, tb_h; //inputs
	reg [2:0] tb_sel;							 //selection
	wire [31:0] tb_d_out;				 //output
	
	_8_to_1_MUX dut (.d_out(tb_d_out), .a(tb_a), .b(tb_b), .c(tb_c), .d(tb_d), .e(tb_e), .f(tb_f), .g(tb_g), .h(tb_h), .sel(tb_sel));
	
	initial
	begin
		#0 tb_a = 32'h0000_0000; tb_b = 32'h1111_1111; tb_c = 32'h2222_2222; tb_d = 32'h3333_3333;
		tb_e = 32'h4444_4444; tb_f = 32'h5555_5555; tb_g = 32'h6666_6666; tb_h = 32'h7777_7777;
		#10 tb_sel = 3'b000;
		#10 tb_sel = 3'b001;
		#10 tb_sel = 3'b010;
		#10 tb_sel = 3'b011;
		#10 tb_sel = 3'b100;
		#10 tb_sel = 3'b101;
		#10 tb_sel = 3'b110;
		#10 tb_sel = 3'b111;
		#10 $stop;
	end
endmodule
