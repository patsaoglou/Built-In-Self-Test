module MISR(
  input clk,
  input rst, // ADDITION - reset signal to initialize LFSR with the seed value
  input so_tap, // ADDITION - input for the so of the trcut
  output reg [15:0] LFSR = 65535
);

wire feedback = LFSR[15];

parameter SEED = 16'h0000; // ADDITION - passing seed parameter

always @(posedge clk or posedge rst)
begin
	if (rst)
		LFSR <= SEED; // ADDITION - set initial seed
	else begin
	  LFSR[0] <= feedback;
	  LFSR[1] <= LFSR[0];
	  LFSR[2] <= LFSR[1] ^ feedback ^ so_tap;
	  LFSR[3] <= LFSR[2] ^ feedback;
	  LFSR[4] <= LFSR[3];
	  LFSR[5] <= LFSR[4] ^ feedback;
	  LFSR[6] <= LFSR[5];
	  LFSR[7] <= LFSR[6];
	  LFSR[8] <= LFSR[7];
	  LFSR[9] <= LFSR[8];
	  LFSR[10] <= LFSR[9];
	  LFSR[11] <= LFSR[10];
	  LFSR[12] <= LFSR[11];
	  LFSR[13] <= LFSR[12];
	  LFSR[14] <= LFSR[13];
	  LFSR[15] <= LFSR[14];
	end
end
endmodule
