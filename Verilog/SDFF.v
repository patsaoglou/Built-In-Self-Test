`timescale 1ns/1ps	

module SDFF(CLK, RST, DI, SI, SE, SO);
  input CLK, RST,DI, SI, SE;
  output SO;
  wire CLK,RST,SE,DI,SI;
  wire muxoutput;
    
  assign muxoutput=(SE==1)?SI:DI;
  
  MyDFF dffinstance(CLK, RST,muxoutput, SO); //CLK, D, Q
  

endmodule