//32-bit 3-to-1 mux
module mux3_32bits(y, d0, d1, d2, s);
	input [31:0] d0, d1, d2; //input d0, d1, d2 
	input [1:0] s; 			 //selection
	output [31:0] y; 			 //output y
	
	//2'b00 : d2
	//2'b01 : d1
	//2'b10 : d0
	assign y = (s == 2'b10) ? d0 : ((s == 2'b01) ? d1 : d2);
endmodule 
