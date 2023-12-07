//ram module
module ram (s_dout, clk, cen, wen, s_addr, s_din);
	input clk, cen, wen;		//clock, chip enable, write enable
	input [7:0] s_addr;		//address
	input [63:0] s_din;		//data in
	output reg [63:0] s_dout;	//data out
	
	//memory address map region : 0x0000 ~ 0x00FF (256)
	reg [63:0] mem [0:255];	//word size : 64, storage size : 256
	integer i;					//for statement value
	
	//memory initialization
	initial 
	begin
		for (i = 0; i < 256; i = i + 1)
			mem[i] = 0;
	end
	
	//memory read and write
	always @ (posedge clk)
	begin
		if (cen == 1'b0)	//chip disable
		begin
			s_dout <= 64'b0;	//s_dout = 0
		end
		else begin	//chip enable
			if (wen == 1'b1)	//write enable
			begin
				mem[s_addr] <= s_din;	//write s_din
				s_dout <= 64'b0;		//s_dout = 0;
			end
			else if (wen == 1'b0)	//read mem[s_addr]
			begin
				s_dout <= mem[s_addr];	//s_dout = memory[s_addr]
			end
		end
	end
	
endmodule
