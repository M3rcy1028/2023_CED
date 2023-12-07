`timescale 1ns/100ps

//testbench for write_operation module
module tb_write_operation; 
	reg tb_we; 				//write enable
	reg [2:0] tb_Addr; 	//write address
	wire [7:0] tb_to_reg; 	//selected register enable signal
	
	
	write_operation dut(.to_reg(tb_to_reg), .Addr(tb_Addr), .we(tb_we));
	
	initial 
	begin
		#0 tb_we = 0; tb_Addr = 0;
		#10 tb_Addr = 3'b101;
		#10 tb_we = 1;
		#10 tb_Addr = 3'b100;
		#10 tb_Addr = 3'b011;
		#10 tb_Addr = 3'b010;
		#10 tb_Addr = 3'b001;
		#10 tb_Addr = 3'b101;
		#10 tb_Addr = 3'b110;
		#10 tb_Addr = 3'b001;
		#10 tb_Addr = 3'b111;
		#10 $stop;
	end
endmodule
