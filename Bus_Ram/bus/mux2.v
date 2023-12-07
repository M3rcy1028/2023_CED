//1-bit 2-to-1 mux
module mux2 (y, d0, d1, s);
	input d0, d1; 	//input d0, d1
	input s; 		//selection
	output y; 		//output 

	//s = 0, select d0 / s = 1, select d1
	assign y = (s == 0) ? d0 : d1;
endmodule 