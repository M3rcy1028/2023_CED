//Address decoder for bus module
module bus_addr(s0_sel, s1_sel, addr);
	input [7:0] addr; 		//address
	output reg s0_sel, s1_sel; //slave selection
	
	always @ (addr)
	begin
		if ((addr >= 8'h00) && (addr < 8'h20))	//select s0
		begin
			s0_sel = 1'b1;
			s1_sel = 1'b0;
		end
		else if ((addr >= 8'h20) && (addr < 8'h40))	//select s1
		begin
			s0_sel = 1'b0;
			s1_sel = 1'b1;
		end
		else	//non-selection
		begin
			s0_sel = 1'b0;
			s1_sel = 1'b0;
		end
	end
endmodule
