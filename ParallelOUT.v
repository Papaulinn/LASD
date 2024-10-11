module ParallelOUT (
  input EN,
  input [7:0]Adress,
  input AdressAnd,
  input [7:0]RegData,
  input rst,
  output reg [7:0] DataOut,
  input clk);
  
  
  always @(posedge clk or negedge rst)
    begin 
      if(!rst) 
        DataOut <= 0;
      
        else begin
			DataOut <= (Adress == 8'hFF && EN==1'b1) ? RegData : DataOut;
        
      end
    end
	 
 endmodule 