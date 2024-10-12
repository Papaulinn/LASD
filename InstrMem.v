module InstrMem(
input [7:0] A,
output reg [31:0] RD);


always @(*)


	case (A)	
	
		8'h00 : RD = 32'h00700213; //addi x4, x0, 7
		8'h04 : RD = 32'h00200093; //addi x1, x0,2
		8'h08 : RD = 32'h0010e113; //ori x2, x1, 1
		8'h0C : RD = 32'h00127193;//andi x3, x4, 1
		//initi
		8'h10 : RD = 32'h00108093; //addi x1, x1, 1 
		8'h14 : RD = 32'hfe409ee3; //bne x1, x4, init
		
	

		default: RD = 32'h0;  // instrução default
	endcase


endmodule


