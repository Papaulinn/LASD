module mux_2x1
(input [7:0] i0, i1,
input sel,
output reg [7:0] out);

always @(*)
	if(sel) begin
	out=i1;
	
	end
	
	else begin
	
	out = i0;
	
	end
	
	
	
 endmodule
