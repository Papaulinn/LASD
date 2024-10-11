module contador_mod_10(input clk, input rst, output reg[3:0] contador);

	always @(posedge clk, negedge rst)
		begin 
			if(rst==0)
			contador=0;
			else 
				begin	if(contador==9)
				contador =0 ;
				else 
					contador = contador +1;
				end
			end
			
endmodule 