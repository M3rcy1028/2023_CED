`timescale 1ns/100ps

//testbench for tb_os_logic
module tb_os_logic;
	reg [2:0] tb_state;
	reg [7:0] tb_d_in;
	wire [7:0] tb_d_out;
	
	os_logic dut(.d_out(tb_d_out), .state(tb_state), .d_in(tb_d_in));
	
	initial
	begin
		#0 tb_state = 0; tb_d_in = 0;
		#10 tb_d_in = 8'b1111_1110; tb_state = 3'b001;
		#10 tb_state = 3'b001;
		#10 tb_state = 3'b010;
		#10 tb_state = 3'b011;
		#10 tb_state = 3'b100;
		#10 $stop;
	end
endmodule
