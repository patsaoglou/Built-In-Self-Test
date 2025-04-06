module TRCUTwithMISR(SE,RST,CLK,SIGN);

input SE,RST,CLK;
output SIGN;

wire SE,RST,CLK,SI,SIGN,SO; // wires to connect modules
wire [7:0] LFSR_out; //	bus array for the lfsr output
wire [15:0] MISR_bus; // for the misr output

assign SI = LFSR_out[0]; 	// connecting one bit of the LFSR with TRCUT(SI)
assign SIGN = MISR_bus[15]; // assign SIGN to the last bit of the MISR 

TRCUT trcut (.clk(CLK),.si(SI),.se(SE),.RST(RST),.so(SO));
LFSR lfsr (.clk(CLK),.rst(RST),.LFSR(LFSR_out));
MISR misr (.clk(CLK),.rst(RST),.so_tap(SO),.LFSR(MISR_bus));
endmodule