`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);


wire w_AddressAnd, w_En, w_ULASrc, w_RegWrite, w_memWrite, w_ResultSrc, w_Clk10HZ, w_PCSrc, w_Zero, w_Branch, w_AdressEn, w_PCSrc2,w_SaidaMux;
wire [2:0] w_ULAControl;
wire [1:0] w_ImmSrc;
wire [7:0] w_PCp4, w_Pc, w_rd1SrcA, w_rd2, w_SrcB, w_ULAResult, w_Wd3, w_Imm, w_RData, w_ImmPC, w_Pcn, w_RegData, w_DataIn, w_DataOut;
wire [31:0] w_Inst;
assign w_DataIn = SW[7:0];



decodHexa7seg H0(.entrada(w_Inst[3:0]), .saida(HEX0[0:6]));
decodHexa7seg H1(.entrada(w_Inst[7:4]), .saida(HEX1[0:6]));
decodHexa7seg H2(.entrada(w_Inst[11:8]), .saida(HEX2[0:6]));
decodHexa7seg H3(.entrada(w_Inst[15:12]), .saida(HEX3[0:6]));
decodHexa7seg H4(.entrada(w_Inst[19:16]), .saida(HEX4[0:6]));
decodHexa7seg H5(.entrada(w_Inst[23:20]), .saida(HEX5[0:6]));
decodHexa7seg H6(.entrada(w_Inst[27:24]), .saida(HEX6[0:6]));
decodHexa7seg H7(.entrada(w_Inst[31:28]), .saida(HEX7[0:6]));
assign w_d0x4 = w_Pc;

assign w_AdressEn =(w_ULAResult == 8'hFF) ? 1'b1 : 1'b0; 

assign LEDR[9] = w_RegWrite;
assign LEDR[8:7] = w_ImmSrc;	
assign LEDR[6] = w_ULASrc;
assign LEDR[5:3] = w_ULAControl; 
assign LEDR[1] = w_ResultSrc;
assign LEDR[2] = w_memWrite;
assign LEDR[0] = w_Branch;
assign LEDG[0] = w_Zero;


divFrequencia freq_1HZ(.clk(CLOCK_50), .clk1hz(w_Clk10HZ)) ;

assign w_PCSrc = w_Branch & w_Zero;
assign w_PCSrc2 = w_Branch & ~w_Zero;

							

					
adderImm Immadder(.A(w_Imm), .B(w_Pc), .C(w_ImmPC));


					
PC PC1(.PCin(w_Pcn), 
		.PCout(w_Pc),
		.clk(w_Clk10HZ),
		.rst(KEY[2]));
		

InstrMem InstrMem1 (.A(w_Pc), 
						.RD(w_Inst));
						

ControlUnit Unidade (.Op(w_Inst[6:0]), 
							.Funct3(w_Inst[14:12]), 
							.Funct7(w_Inst[31:25]), 
							.ULAControl(w_ULAControl),
							.ULASrc(w_ULASrc),
							.RegWrite(w_RegWrite),
							.ImmSrc(w_ImmSrc),
							.MemWrite(w_memWrite),
							.ResultSrc(w_ResultSrc),
							.Branch(w_Branch)
							);



Registrador RegisterFile(.ra1(w_Inst[19:15]), 
								.ra2(w_Inst[24:20]), 
								.wa3(w_Inst[11:7]),
								.we3(w_RegWrite),
								.wd3(w_Wd3),
								.clk(w_Clk10HZ),
								.reset(KEY[2]), 
								.rd1(w_rd1SrcA), 
								.rd2(w_rd2), 
								.S0(w_d0x0), 
								.S1(w_d0x1), 
								.S2(w_d0x2), 
								.S3(w_d0x3), 
								.S4(w_d1x0),
								.S5(), 
								.S6(w_d1x2), 
								.S7(w_d1x3));
								
mux_2x1 MuxULASrc (.i0(w_rd2), .i1(w_Imm), .sel(w_ULASrc), .out(w_SrcB));
mux_2x1 MuxResSrc(.i0(w_ULAResult), .i1(w_RegData), .sel(w_ResultSrc),.out(w_Wd3));

mux_4x1 MuxIMMSrc (.i0(w_Inst[31:20]), 
							.i1({w_Inst[31:25], w_Inst[11:7]}),
							.i2({ w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0}),
							.i3(),
							.sel(w_ImmSrc),
							.out(w_Imm));
							
						

ULA  ULA1(.SrcA(w_rd1SrcA),
			.SrcB(w_SrcB), 
			.ULAControl(w_ULAControl), 
			.Z(w_Zero),
			.ULAResult(w_ULAResult));


DataMem Mem(.A(w_ULAResult), .WD(w_rd2), .rst(KEY[2]), .clk(w_Clk10HZ), 
				.WE(w_memWrite), .RD(w_RData));



ParallelOUT parallalel ( .EN(w_memWrite),
								 .Adress(w_ULAResult),
								 .AdressAnd(w_AddressAnd),
								 .RegData(w_rd2),
								 .rst(KEY[0]),
								 .DataOut(w_DataOut),
								 .clk(w_Clk10HZ));
							
mux_2x1 Parallel_IN(.i0(w_RData), .i1(w_DataIn), .sel(w_AdressEn), .out(w_RegData));
//mux_2x1 BNE (.i0(w_PCp4), .i1(w_ImmPC), .sel(w_PCSrc2), .out(w_SaidaMux));

mux_2x1 MuxPcSrc(.i0(w_PCp4), .i1(w_ImmPC), .sel(w_PCSrc2), .out(w_Pcn));		 

adder4 somador4(.A(w_Pc), 
					.B(w_PCp4));


endmodule
