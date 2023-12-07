//output logic module
module os_logic(d_out, state, d_in);
	input [2:0] state;
	input [7:0] d_in;
	output reg [7:0] d_out;
	
	//Encoding states
	parameter IDLE_STATE = 3'b000;
	parameter LOAD_STATE = 3'b001;
	parameter INC_STATE = 3'b010;
	parameter INC2_STATE = 3'b011;
	parameter DEC_STATE = 3'b100;
	parameter DEC2_STATE = 3'b101;
	
	wire [7:0] d_inc, d_dec;
		
	always @ (state, d_in) 
	begin
		case(state)
		IDLE_STATE: d_out <= 8'h00;
		LOAD_STATE: d_out <= d_in;
		INC_STATE: d_out <= d_inc;
		INC2_STATE: d_out <= d_inc;
		DEC_STATE: d_out <= d_dec;
		DEC2_STATE: d_out <= d_dec;
		default:  d_out <= 8'hxx;
		endcase
	end
	
	//instance of CLA8
	cla8 U1_cla8(.s(d_dec), .co(), .a(d_out), .b(8'b1111_1110), .ci(1'b1));
	cla8 U0_cla8(.s(d_inc), .co(), .a(d_out), .b(8'b0000_0000), .ci(1'b1));
	
endmodule


