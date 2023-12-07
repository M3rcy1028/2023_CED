//module for 32-bit 2-to-1 mux
module mux2_32bits (y, d0, d1, s);
	input [31:0] d0, d1; //input d0, d1
	input s; 				//selection signal
	output [31:0] y; 		//output y
	
	//s = 0, select d0 / s = 1, select d1
	assign y = (s == 1'b0) ? d0 : d1; 
endmodule 