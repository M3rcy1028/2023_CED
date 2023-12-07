//Carry lock-ahead adder with register
module cla_clk(s, co, clk, a, b, ci);
	input clk;					//Clock
	input [31:0] a, b;		//input 32-bit data a, b
	input ci;					//input 1 bit Carry-in
	output [31:0] s;			//output 32-bit Sum
	output co;					//output Carry-out
	
	reg [31:0] reg_a, reg_b;//Register of input a, b
	reg reg_ci;					//Register of carry-in
	reg [31:0] reg_s;			//Register of sum
	reg reg_co;					//Register of carry-out
	
	wire [31:0] wire_s;		//wire for sum
	wire wire_co;				//wire for carry-out
	
	//Capture inputs and outputs
	always@(posedge clk)
	begin
		//update values of registers	
		reg_a <= a;
		reg_b <= b;
		reg_ci <= ci;
		reg_s <= wire_s;
		reg_co <= wire_co;
	end
	
	//Instantiate the CLA32
	cla32 U0_cla32(.s(wire_s), .co(wire_co), .a(reg_a), .b(reg_b), .ci(reg_ci));
	
	//Assign module outputs to registered outputs
	assign co = reg_co;
	assign s = reg_s;
	
endmodule
