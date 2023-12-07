//arbiter for master requeset
module bus_arbit (m0_grant, m1_grant, clk, reset_n, m0_req, m1_req);
	input clk, reset_n, m0_req, m1_req;	//clock, active-low reset, master request
	output reg m0_grant, m1_grant;	//master grant signal
	
	reg s;	//selection signal
	
	//assign grant signal
	always @ (posedge clk or negedge reset_n)
	begin
		if (reset_n == 1'b0)
		begin
			m0_grant = 1'b1;
			m1_grant = 1'b0;
		end
		else //reset_n = 1
		begin
			if (s == 1'b0) //select m0
			begin
				m0_grant = 1'b1;
				m1_grant = 1'b0;
			end
			else	//select m1
			begin
				m0_grant = 1'b0;
				m1_grant = 1'b1;
			end
		end
	end
	
	//state transition
	always @ (m0_req, m1_req)
	begin
		if (reset_n == 1'b0) s = 0;
		else	//reset_n = 1
		begin
			if (m0_req == 1'b0)
			begin
				if (m1_req == 1'b1) s = 1;	//m1
				else s = 0;	//m0
			end
			else if (m0_req == 1'b1)	//m1
			begin
				if (m1_req == 1'b0)	s = 0;	//m1
				else s = 1'bx;	//error
			end
		end
	end
endmodule
