module InstrMem(
input [7:0] A,
output reg [31:0] RD);


always @(*)


	case (A)	
	
		8'h00 : RD = 32'h00700213;
		8'h04 : RD = 32'h00200093;
		8'h08 : RD = 32'h0010e113;
		8'h0C : RD = 32'h00127193;
		8'h10 : RD = 32'h00108093;
		8'h14 : RD = 32'hfe409ee3;
		
	

		default: RD = 32'h0;  // instrução default
	endcase


endmodule


