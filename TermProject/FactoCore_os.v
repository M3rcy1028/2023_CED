//Factorial Core output logic
module FactoCore_os(s_dout, next_mul, clk, reset_n, s_wr, s_sel, opdone, result_h, result_l, s_addr);
	input clk, reset_n, s_wr, s_sel;				//clock, active-low reset, write/chip select signal
	input [63:0] opdone, result_h, result_l;	//readable inputs
	input [4:0] s_addr;								//address
	output reg [63:0] s_dout, next_mul;			//m_din output and next multiplier value
	
	//assign s_dout values
	always @ (*) begin
		if (reset_n == 0) begin
			s_dout <= 64'b0;
		end
		else if (s_sel == 1) begin
			if (s_wr == 0)	//read able
			begin
				if (s_addr == 5'd2)			//write opdone
					s_dout <= opdone;
				else if (s_addr == 5'd5)	//write result_h
					s_dout <= result_h;
				else if (s_addr == 5'd6)	//write result_l
					s_dout <= result_l;
			end
			else	//read disable
				s_dout <= 64'd0;
		end
	end
	
	//assign next_mul value
	always @ (*) begin
		if (reset_n == 0)
			next_mul <= 64'b0;
		else if (result_l == 64'b0)	//if result_l is zero
			next_mul <= result_h;
		else	//result_l is not zero
			next_mul <= result_l;
	end
	
endmodule
