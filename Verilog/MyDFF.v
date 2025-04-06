`timescale 1ns/1ps	

module MyDFF(CLK,RST,D, Q); //	ADDITION - reset signal to initialize DFF
  
  input CLK,RST,D;
  output Q;
  
  wire CLK, D;
  reg Q;
  
  always @ (posedge CLK or posedge RST)
  
  if (RST)
		 Q <= 0; // ADDITION - set DFF to 0
  else begin
    Q<=D;
end
  
endmodule
  
  
