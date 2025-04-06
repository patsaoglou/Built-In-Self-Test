module LFSR(
  input clk,
  input rst,	// ADDITION - reset signal to initialize LFSR with the seed value
  output reg [7:0] LFSR = 255
);

wire feedback = LFSR[7];

parameter SEED = 8'hA5; // ADDITION - passing seed parameter

always @(posedge clk or posedge rst)
	begin
	if (rst)
		LFSR <= SEED; // ADDITION - set initial seed
	else begin
	  LFSR[0] <= feedback;
	  LFSR[1] <= LFSR[0];
	  LFSR[2] <= LFSR[1] ^ feedback;
	  LFSR[3] <= LFSR[2] ^ feedback;
	  LFSR[4] <= LFSR[3] ^ feedback;
	  LFSR[5] <= LFSR[4];
	  LFSR[6] <= LFSR[5];
	  LFSR[7] <= LFSR[6];
	end
end
endmodule
