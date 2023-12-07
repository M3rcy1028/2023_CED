`timescale 1ns/100ps

//32-bit ALU testbench
module tb_alu32;
	reg clk, reset;					//clock, reset
	reg[31:0] tb_a, tb_b, yex;		//input a, b, expected result
	reg[2:0] tb_op;					//operation code
	reg cex, nex, zex, vex;			//expected c,n,z,v
	//result of ALU
	wire[31:0] tb_y;					//result
	wire tb_c, tb_n, tb_z, tb_v;	//carry, negative, zero, overflow
	
	//variables for testvector
	reg[31:0] vectornum, errors;		//index for testvector array, conting the number of errors
	reg[150:0] testvectors[10000:0];	//arrays of testvectors
		
	//instance
	alu32 dut(.result(tb_y), .c(tb_c), .n(tb_n), .z(tb_z), .v(tb_v), .a(tb_a), .b(tb_b), .op(tb_op));
	
	//Generate clock
	always
		begin
			clk = 1; #5; clk = 0; #5;
		end
		
	//Initialization
	initial
		begin
			$readmemb("alu32_testvectors.tv", testvectors);
			vectornum = 0; errors = 0;
			#0 reset = 1; #10 reset = 0;	//setup reset
			#120 $stop;							//stop after 120ns
		end
	
	//Apply testvector on rising edge of clk
	always @(posedge clk)
		begin
			#1; {yex, cex, nex, zex, vex, tb_a, tb_b, tb_op} = testvectors[vectornum];
		end
	
	//Check results on falling edge of clk
	always @(negedge clk)
	if (~reset) //skip when reset = 1
	begin 
		if (tb_y !== yex) //if y doens't equal to expected y
		begin
			$display("Error: tb_a = %b, tb_b = %b, tb_op = %b", tb_a, tb_b, tb_op);	//error messages
			$display("output y = %b (%b expected)", tb_y, yex);
			errors = errors + 1;
		end
		if (tb_c !== cex) //if c doens't equal to expected c
		begin
			$display("Error: tb_a = %b, tb_b = %b, tb_op = %b", tb_a, tb_b, tb_op);	//error messages
			$display("output c = %b (%b expected)", tb_c, cex);
			errors = errors + 1;
		end
		if (tb_n !== nex) //if n doens't equal to expected n
		begin
			$display("Error: tb_a = %b, tb_b = %b, tb_op = %b", tb_a, tb_b, tb_op);	//error messages
			$display("output n = %b (%b expected)", tb_n, nex);
			errors = errors + 1;
		end
		if (tb_z !== zex) //if z doens't equal to expected z
		begin
			$display("Error: tb_a = %b, tb_b = %b, tb_op = %b", tb_a, tb_b, tb_op);	//error messages
			$display("output z = %b (%b expected)", tb_z, zex);
			errors = errors + 1;
		end
		if (tb_v !== vex) //if v doens't equal to expected v
		begin
			$display("Error: tb_a = %b, tb_b = %b, tb_op = %b", tb_a, tb_b, tb_op);	//error messages
			$display("output v= %b (%b expected)", tb_v, vex);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;	//increase index
		if (testvectors[vectornum] === 32'bx)	//end of file 
		begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule 
 
