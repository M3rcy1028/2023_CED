//module for simple memory
module ram(dout, clk, cen, wen, addr, din);
	input	clk, cen, wen;		//clock, chip enable, write enable
	input [4:0] addr;			//address
	input [31:0] din;			//Data in
	output reg [31:0] dout;	//Data out
	
	reg [31:0] mem [0:31];	//declare memory
	integer i;					//for statement value
	
	//memory initialization
	initial 
	begin
		for (i = 0; i < 32; i = i + 1)
			mem[i] = 0;
	end
	
	//memory read and write
	always @ (posedge clk)
	begin
		if (cen == 1'b0)	//chip disable
		begin
			dout <= 32'b0;	//dout = 0
		end
		else if (cen == 1'b1 && wen == 1'b1)	//chip enable, write enable
		begin
			mem[addr] <= din;	//write din
			dout <= 32'b0;		//dout = 0;
		end
		else if (cen == 1'b1 && wen == 1'b0)	//chip enable, write disable (read memory[addr])
		begin
			dout <= mem[addr];	//dout = memory[addr]
		end
		else	//error
			dout <= 32'bx;
	end
endmodule
