module DataMem (
input [7:0] A,
input [7:0] WD,
output reg [7:0] RD,
input WE,
input rst,
input clk);

reg [7:0] memoria[255:0];

always @(*) 
	begin

		RD=memoria[A];
	
	end 


always @(posedge clk or negedge rst)  begin

integer i;

	if(!rst) begin

		for(i=0; i<256; i=i+1) 
			begin
				memoria[i]<=8'b0;
			end
	end else begin
			if (WE) memoria[A] = WD;

	end
end

endmodule
	