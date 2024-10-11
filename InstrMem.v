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
		
	
	/*
		8'h00 : RD = 32'h0ff00083; //lb x1, 0xFF(x0) #Carrega a entrada paralela no registrador 1
		8'h04 : RD = 32'h0e100fa3; //sb x1, 0xFF(x0) #Salva o registrador 1 na saída paralela
		8'h08 : RD = 32'hfe000ce3; //beq x0, x0, init #Reinicia o laço
	
		8'h00 : RD = 32'h00100193; //lb x1, 0xFF(x0) #Carrega a entrada paralela no registrador 1
		8'h04 : RD = 32'h0ff00083; 
		8'h08 : RD = 32'h00108213; 
		8'h0C : RD = 32'h00327133;
		8'h10 : RD = 32'h0e200fa3; //sb x1, 0xFF(x0) #Salva o registrador 1 na saída paralela
		8'h14 : RD = 32'hfe0006e3; //beq x0, x0, init #Reinicia o laço
		*/
		default: RD = 32'h0;  // instrução default
	endcase


endmodule


/*
addi x4, x0, 7
addi x1, x0,2
ori x2, x1, 1
andi x3, x4, 1
init:
addi x1, x1, 1 
testeBne:
bne x1, x4, init #se a condição de parada for atingida, reinicia a rotina
*/