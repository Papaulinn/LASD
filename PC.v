module PC(

input clk, rst,
input [7:0] PCin,
output reg [7:0] PCout
);

always @(posedge clk or negedge rst) 
 
 begin
 
	if (!rst) begin
	
		PCout <= 8'b0;
		
		end else begin
		
		PCout <= PCin;
		
		end
		
	end 
	
endmodule
