//Traffic light controller
module tl_cntr_struct(La, Lb, clk, reset_n, Ta, Tb);
	input clk, reset_n, Ta, Tb;
	output [1:0] La, Lb;
	
	wire [1:0] w_d, w_q;
	
	//ns_logic instance
	//input : Ta, Tb, q1, q2 => output : d1, d0
	ns_logic U0_ns_logic(.d1(w_d[1]), .d0(w_d[0]), .Ta(Ta), .Tb(Tb), .q1(w_q[1]), .q0(w_q[0]));
	
	//_register2_r instance (2-bit)
	//input : clk, reset_b, d => output : q
	_register2_r_async U1_register2_r_async(.q(w_q[1:0]), .clk(clk), .reset_n(reset_n), .d(w_d[1:0]));
	
	//o_logic instance
	//input : q1, q0 => output : La1, La0, Lb1, Lb0
	o_logic U2_o_logic(.La1(La[1]), .La0(La[0]), .Lb1(Lb[1]), .Lb0(Lb[0]), .q1(w_q[1]), .q0(w_q[0]));
endmodule 
