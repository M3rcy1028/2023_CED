//8-bit 2-to-1 mux
module mux2_8bits (y, d0, d1, s); // 8bits 2-inut mux
	input [7:0] d0, d1;	//input d0, d1 
	input s; 				//selection
	output [7:0] y; 		//output
	
	//s = 0, select d0 / s = 1, select d1
	assign y = (s == 1'b0) ? d0 : d1; 
endmodule 