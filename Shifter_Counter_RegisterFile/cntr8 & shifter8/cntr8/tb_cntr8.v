`timescale 1ns/100ps

//testbench for cntr8 module
module tb_cntr8;
	reg tb_clk, tb_reset, tb_inc, tb_load;	//clock, reset, increament, load
	reg [7:0] tb_d_in;							//data-in
	wire [7:0] tb_d_out;							//data-out
	wire [2:0] tb_o_state;						//output state
	
	//instance of cntr8
	cntr8 U0_cntr8(.d_out(tb_d_out), .o_state(tb_o_state), .clk(tb_clk), .reset_n(tb_reset), .inc(tb_inc), .load(tb_load), .d_in(tb_d_in));
	
	always #(10/2) tb_clk = ~tb_clk;	//clock period : 10ns
	
	initial
	begin
		#0 tb_clk = 0; tb_reset = 0; tb_inc = 0; tb_load = 0; tb_d_in = 0;
		#22 tb_reset = 1; tb_inc = 0; tb_inc = 1;
		#50 tb_inc = 0;
		#50 tb_load = 1; tb_d_in= 8'b00000001;
		#20 tb_load = 0; tb_inc = 1;
		#40 tb_reset = 0; tb_inc = 0;
		#10 tb_reset = 1;
		#40 $stop;
	end
endmodule 