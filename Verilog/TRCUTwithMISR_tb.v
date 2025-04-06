module TRCUTwithMISR_tb();

reg clk,rst,se;	// regs to drive trcutmisr
wire sign;			// wire to get signature out

reg [15:0] sign_values;	// reg array to hold signature bits

integer pseudo_rnd_vectors; // for-loop counter
integer sign_bits;

//	wiring up TRCUTwithMISR
TRCUTwithMISR trcutmisr (
	.SE(se),
	.RST(rst),
	.CLK(clk),
	.SIGN(sign)
);

initial begin
	rst = 1;	// reset regs of lfsr to seed and trcut regs to 0
	
	//	initilize array stuff
	sign_values = 0; 
	se = 0;		// initilize scan-en
	clk = 0;		// initilize clk
	#1;			
	
	// Forcing signals to simulate stuck-at faults 
	//force trcutmisr.trcut.b = 1;	
	
	rst = 0;		// setting rst to 0 to begin
		
	forever begin
		#5 clk =! clk;
	end
end

initial begin
	#1;	//	delay so there is sync with first initial block
	
	// for-loop to for the 32 pseudo_rnd_vectors coming from the misr
	for (pseudo_rnd_vectors = 0; pseudo_rnd_vectors<32 + 1; pseudo_rnd_vectors = pseudo_rnd_vectors + 1) begin 
		se = 1; 
		#40;	// 4 cycles for shifting the vector into the scan chain
		se = 0;
		#10;	// 1 cycles for capturing the observation points
		
		// Forcing signals to simulate cosmic radiation bit errors 
		if (pseudo_rnd_vectors == 21) begin
			force trcutmisr.trcut.Rbi.dffinstance.Q = 1;
			release trcutmisr.trcut.Rbi.dffinstance.Q;
		end
	end
end

initial begin
	#1641	// wait for the 32nd vector to get into the chain and save the response 
	for (sign_bits = 0; sign_bits<16; sign_bits = sign_bits + 1) begin 
		sign_values[sign_bits] = sign; 
		#10;
	end
end

endmodule