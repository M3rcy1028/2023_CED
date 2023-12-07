//calculate flags
module cal_flags32(c, n, z, v, op, result, co_add, co_prev_add);
	input [2:0] op;				//operation
	input [31:0] result;			//output
	input co_add, co_prev_add;	//carry-out bit, [MSB-1] position bit
	output c, n, z, v;			//condition flag
	
	assign c = (op[2:1] != 2'b11) ? 1'b0 : co_add;						//Carry
	assign n = result[31];	//MSB												//Negative
	assign z = (result == 32'b0) ? 1'b1 : 1'b0;							//Zero
	assign v = (op[2:1] != 2'b11) ? 1'b0 : co_add ^ co_prev_add;	//Overflow
endmodule
