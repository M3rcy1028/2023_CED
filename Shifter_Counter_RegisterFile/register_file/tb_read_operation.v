`timescale 1ns/100ps

//testbench for read_operation
module tb_read_operation; 
	reg [31:0] tb_from_reg0, tb_from_reg1, tb_from_reg2, tb_from_reg3, tb_from_reg4, tb_from_reg5, tb_from_reg6, tb_from_reg7;
	reg [2:0] tb_Addr; 	//Read address
	wire [31:0] tb_Data; //Data out.
	
	read_operation dut(.Data(tb_Data), .Addr(tb_Addr), .from_reg0(tb_from_reg0), .from_reg1(tb_from_reg1), .from_reg2(tb_from_reg2),
	.from_reg3(tb_from_reg3), .from_reg4(tb_from_reg4), .from_reg5(tb_from_reg5), .from_reg6(tb_from_reg6), .from_reg7(tb_from_reg7));
	
	initial begin
		#0 tb_from_reg0=0;tb_from_reg1=0; tb_from_reg2=0;tb_from_reg3=0;tb_from_reg4=0;tb_from_reg5=0;tb_from_reg6=0;tb_from_reg7=0;tb_Addr=0;
		#10 tb_from_reg0=32'hffff_ffff; tb_from_reg1=32'h1111_1111; tb_from_reg2=32'h1234_5678; tb_from_reg3=32'h1357_9bdf; 
		tb_from_reg4=32'habcd_1234; tb_from_reg5=32'hef12_6793; tb_from_reg6=32'h9876_5432; tb_from_reg7=32'h2468_acde;
		#10 tb_Addr=3'b001;
		#10 tb_Addr=3'b010;
		#10 tb_Addr=3'b011;
		#10 tb_Addr=3'b100;
		#10 tb_Addr=3'b101;
		#10 tb_Addr=3'b110;
		#10 tb_Addr=3'b111;
		#20 $stop;
	end
endmodule