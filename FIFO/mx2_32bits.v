//32-bit 2-to-1 MUX
module mx2_32bits(y, s, d0, d1);
	input [31:0] d0, d1; //input d0, d1
	input s; 				//selection
	output [31:0] y; 		//y
	
	assign y = (s==0) ? d0:d1;
	
endmodule 