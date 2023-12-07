//Traffic light controller with left
module tl_cntr_w_left_struct(La, Lb, clk, reset_n, Ta, Tal, Tb, Tbl);
	input	clk, reset_n;			//clock, active-low reset
	input  Ta, Tal, Tb, Tbl;	//Traffic Lights with left
	output [1:0] La, Lb;			//outputs
	
	wire [2:0] w_d, w_q;			//3-bit Next State/Current State
	
	//ns_logic instance
	//input : Ta, Tal, Tb, Tbl, q2, q1, q0 => output : d2, d1, d0
	ns_logic U0_ns_logic (.d2(w_d[2]), .d1(w_d[1]), .d0(w_d[0]), .Ta(Ta), .Tal(Tal), .Tb(Tb), .Tbl(Tbl), .q2(w_q[2]), .q1(w_q[1]), .q0(w_q[0]));
	
	//_register3_r instance
	//input : clk, reset_n, d => output : q
	_register3_r U1_register3_r (.q(w_q[2:0]), .clk(clk), .reset_n(reset_n), .d(w_d[2:0]));
	
	//o_logic instance
	//input : 3-bit q => output : La1, La0, Lb1, Lb0
	o_logic U2_o_logic (.La1(La[1]), .La0(La[0]), .Lb1(Lb[1]), .Lb0(Lb[0]), .q2(w_q[2]), .q1(w_q[1]), .q0(w_q[0]));
	
endmodule
