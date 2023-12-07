//display output data
module cc_logic(d_next, op, shamt, d_in, d_out);
	input [2:0] op;			//operation code
	input [1:0] shamt;		//shift amount
	input [7:0] d_in;			//data in
	input [7:0] d_out;		//data out
	output reg [7:0] d_next;//next state of data
	
	wire [7:0] d_lsl;	//wire for result of LSL
	wire [7:0] d_lsr; //wire for result of LSR
	wire [7:0] d_asr; //wire for result of ASR
	
	//define parameters
	parameter NOP = 3'b000;
	parameter LOAD = 3'b001;
	parameter LSL = 3'b010;
	parameter LSR = 3'b011;
	parameter ASR = 3'b100;
	
	// Next State 
	always@ (op, shamt, d_in, d_out, d_lsl, d_lsr, d_asr)	//sensitive lists
	begin
		case(op)
		(NOP): d_next = d_out;	//No operation
		(LOAD): d_next = d_in;	//LOAD
		(LSL): d_next = d_lsl;	//Logical shift left
		(LSR): d_next = d_lsr;	//Logical shift right
		(ASR): d_next = d_asr;	//Arithmetic shift right
		default: d_next = 8'bx;	//wrong operation code
		endcase
	end

	LSL8 U0_LSL8(.d_in(d_in), .shamt(shamt), .d_out(d_lsl)); // instance of LSL8
	LSR8 U1_LSR8(.d_in(d_in), .shamt(shamt), .d_out(d_lsr)); // instance of LSR8
	ASR8 U2_ASR8(.d_in(d_in), .shamt(shamt), .d_out(d_asr)); // instance of ASR8
endmodule
