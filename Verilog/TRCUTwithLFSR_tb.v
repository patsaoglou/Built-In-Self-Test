module TRCUTwithLFSR_tb();

reg clk,rst,se;	// regs to drive trcutlfsr
wire so;		// wire to connect so with the tb so_values

reg [255:0] so_values; 	// reg to store bits from so
reg [10:0] so_values_idx; 	// reg to have idx of so_values

integer pseudo_rnd_vectors;// integer for vectors for-loop

// wiring up TRCUTwithLFSR
TRCUTwithLFSR trcutlfsr (
	.SE(se),
	.RST(rst),
	.CLK(clk),
	.SO(so)
);

initial begin
	rst = 1;		// reset regs of lfsr to seed and trcut regs to 0
	
	//	initilize array stuff
	so_values = 0; 
	so_values_idx = 0;
	se = 0;		// initilize scan-en
	clk = 0;  	// initilize clk
	#1;
	
	rst = 0;  	// setting rst to 0 to begin
	
	forever begin
		#5 clk =! clk;
	end
end

initial begin
	#1; //	delay so there is sync with first initial block
	
	// for-loop to for the 32 pseudo_rnd_vectors coming from the lfsr
	for (pseudo_rnd_vectors = 0; pseudo_rnd_vectors<32; pseudo_rnd_vectors = pseudo_rnd_vectors + 1) begin 
		se = 1; 
		#40;	// 4 cycles for shifting the vector into the scan chain
		se = 0;
		#10;	// 1 cycles for capturing the observation points
	end
end

initial begin
	#41	// wait so the first vector inside the scan chain to begin saving response
	forever begin
		if (se) begin	// if not in capture save the result of so
			so_values[so_values_idx] = so; // save si respose to array
			so_values_idx = so_values_idx + 1; //	increase idx
		end
		#10;
	end
end

endmodule