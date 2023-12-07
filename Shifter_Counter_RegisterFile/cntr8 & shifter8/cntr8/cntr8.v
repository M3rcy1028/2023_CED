//8-bit counter
module cntr8 (d_out, o_state, clk, reset_n, inc, load, d_in, d_out, o_state);
	input clk, reset_n, inc, load;
	input [7:0] d_in;
	output [7:0] d_out;
	output [2:0] o_state;
	
	wire [2:0] next_state;
	wire [2:0] state;
	
	assign o_state = state;
	
	_register3_r U0_register3_r (.q(state), .clk(clk), .reset_n(reset_n), .d(next_state));	//instance of 3-bit register
	ns_logic U1_ns_logic (.next_state(next_state), .load(load), .inc(inc), .state(state));	//instance of ns_logic
	os_logic U2_os_logic (.d_out(d_out), .state(state), .d_in(d_in));	//instance of o_logic
	
endmodule
