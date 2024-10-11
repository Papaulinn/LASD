module divFrequencia(input clk, output reg clk1hz);

reg[24:0] contador;
	always @(posedge clk)
		begin
			if(contador==25000000)
				begin
				clk1hz=~clk1hz;
				contador = 0;
				end
			else
		contador = contador+1;
		
	end
	
endmodule 