//calculate flags
module cal_flags4(c, n, z, v, op, result, co_add, c3_add);
	input [2:0] op;			//operation
	input [3:0] result;		//output
	input co_add, c3_add;	
	output c, n, z, v;		//condition flag	
	
	assign c = (op[2:1] != 2'b11) ? 1'b0 : co_add;				//Carry
	assign n = result[3]; //MSB										//Negative
	assign z = (result == 4'b0) ? 1'b1 : 1'b0;					//Zero
	assign v = (op[2:1] != 2'b11) ? 1'b0 : co_add ^ c3_add;	//Overflow
endmodule
