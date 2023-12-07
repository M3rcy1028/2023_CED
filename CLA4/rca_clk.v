//Ripple carry adder with register
module rca_clk(s, co, clk, a, b, ci);
	input clk;					//Clock
	input [31:0] a, b;		//input 32-bit data a, b
	input ci;					//input carry-in
	output [31:0] s;			//Output 32-bit Sum
	output co;					//Output Carry-out
	
	reg [31:0] reg_a, reg_b;//Registers of 32-bit reg_a, reg_b
	reg reg_ci;					//Registers of carry-in
	reg [31:0] reg_s;			//Registers of 32-bit Sum
	reg reg_co;					//Registers of carry-out
	
	wire [31:0] wire_s;		//wire for sum
	wire wire_co;				//wire for carry-out
	
	always@(posedge clk)		//if clk == 1, then update register
	begin
		//update values of registers	
		reg_a <= a;
		reg_b <= b;
		reg_ci <= ci;
		reg_s <= wire_s;
		reg_co <= wire_co;
	end
	
	//Instantiation rca32 module
	rca32 U0_rca32(.s(wire_s), .co(wire_co), .a(reg_a), .b(reg_b), .ci(reg_ci)); 
	
	//Assign module outputs to registered outputs
	assign s = reg_s;
	assign co = reg_co;
	
endmodule
