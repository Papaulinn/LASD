module ControlUnit (

input [6:0] Op,
input [2:0] Funct3,
input [6:0] Funct7,
output reg RegWrite, 
output reg ULASrc,
output reg [2:0] ULAControl,
output reg ResultSrc,
output reg MemWrite,
output reg [1:0] ImmSrc,
output reg Branch);



always @(*) 

	case(Op) 
	
		7'b0110011:
		
		begin 
		
		RegWrite	=1'b1; 
		ImmSrc = 2'bxx;
		ULASrc= 1'b0;
		MemWrite= 1'b0;
		ResultSrc= 1'b0;
		Branch = 1'b0;
			
			case({Funct7, Funct3})
			10'b0000000_000: ULAControl=3'b000;
			10'b0100000_000: ULAControl=3'b001;
			10'b0000000_111: ULAControl=3'b010;
			10'b0000000_110: ULAControl=3'b011;
			10'b0000000_010: ULAControl=3'b101;
			10'b0000000_100: ULAControl=3'b100;
			10'b0000000_101: ULAControl=3'b111;
			
			endcase
		end
		
		7'b0010011: //addi andi e ori
		begin
			
			RegWrite	=1'b1; 
			ImmSrc = 2'b00;
			ULASrc= 1'b1;
			MemWrite= 1'b0;
			ResultSrc= 1'b0;
			Branch= 1'b0;
			
			case(Funct3)
			3'b000: ULAControl=3'b000; // Addi
			3'b111: ULAControl=3'b010; // Andi
			3'b110: ULAControl=3'b011; // Ori
			
			endcase
		end
		
	
		7'b0000011: //LB
		
		begin
		
			RegWrite	=1'b1; 
			ImmSrc = 2'b00;
			ULASrc= 1'b1;
			ULAControl=3'b000;
			MemWrite= 1'b0;
			ResultSrc= 1'b1;
			Branch=1'b0;
		
		end
		
		7'b0100011 :  //SB
		
		begin
		
			RegWrite	=1'b0; 
			ImmSrc = 2'b01;
			ULASrc= 1'b1;
			ULAControl=3'b000;
			MemWrite= 1'b1;
			ResultSrc= 1'bx;
			Branch=1'b0;
		
		end
		
		7'b1100011 :  //BEQ
		begin	
		
	
			RegWrite	=1'b0; 
			ImmSrc = 2'b10;
			ULASrc= 1'b0;
			ULAControl=3'b001;
			MemWrite= 1'b0;
			ResultSrc= 1'bx;
			Branch=1'b1;
			
		end
		
		
		
		default  : 
		
		begin 
			RegWrite	=1'b0; 
			ImmSrc = 2'bxx;
			ULASrc= 1'b0;
			ULAControl=3'b000;
			MemWrite= 1'b0;
			ResultSrc= 1'b0;
			Branch=1'b0;
						
		end
		
		
		endcase
		
		
endmodule			
			