module TRCUTwithLFSR(SE,RST,CLK,SO);

input SE,RST,CLK;
output SO;

wire SE,RST,CLK,SI,SO;	// wires to connect modules
wire [7:0] LFSR_out; //	bus array for the lfsr output

assign SI = LFSR_out[0]; 	// connecting one bit of the LFSR with TRCUT(SI)

//	ADDITION - added reset to trcut chain to initialize dffs
TRCUT trcut (.clk(CLK),.si(SI),.se(SE),.RST(RST),.so(SO));
LFSR lfsr (.clk(CLK),.rst(RST),.LFSR(LFSR_out));
endmodule