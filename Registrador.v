module Registrador(
input [2:0] ra1, 
input [2:0] ra2, 
input [2:0] wa3, 
input we3,
input [7:0] wd3,
input clk,
input reset,
output reg [7:0] rd1, 
output reg [7:0] rd2,
output reg [7:0] S0, S1 ,S2 ,S3 ,S4 ,S5 ,S6, S7
);

reg [7:0] register [7:0];

//wa3: endereço que vai ser escrito, wd3: o que vai ser escrito, ra1 e ra2: exibe o registrador no display escolhido

//sequencial


always @(posedge clk or negedge reset) 
begin
 
	if(!reset) begin
		register[0]<=0;
		register[1]<=0;
		register[2]<=0;
		register[3]<=0;
		register[4]<=0;
		register[5]<=0;
		register[6]<=0;
		register[7]<=0;
	end 
	else begin 	
	if(we3 && wa3) 
		register[wa3] <= wd3;
	
end 
end

//combinacional

always @ (*) 
begin
	register[0] = 8'd0;
	rd1 = register[ra1];
	rd2 = register[ra2];
	S0 = register[0];
	S1 = register[1];
	S2 = register[2];
	S3 = register[3];
	S4 = register[4];
	S5 = register[5];
	S6 = register[6];
	S7 = register[7];
end

endmodule