# Assignment - Built-In-Self-Test Implementation
In the previous assignment a traditional scan chain was implemented, and it was integrated into a basic circuit under test (CUT). From the test benches performed, the test vectors generated from the truth table of the CUT were fed into the scan chain, a capture was performed to get the observation points, and in the next 4 cycles we had the response of the CUT shifted out from SO.

While this test method was feasible for our test circuit which had 4 inputs, we concluded that the method becomes largely impractical as input number increases. The issues that arise are that it also becomes impractical and expensive to store the large number of test vectors on-chip, while feeding each test vector and checking if the response is the expected one is time-consuming.

To address the limitations of the previous testing methods, Build-In-Self-Test (BIST) architectures can be introduced to make testing scalable and optimal. Therefore, Linear Feedback Shift Registers (LFSRs) responsible for test pattern generation and Multiple Input Signature Registers (MISRs) responsible for generating a signature bit-stream based on the CUT’s response must be implemented and integrated as modules into the existing TRCUT made in the previous assignment.

# BIST Testing Flow
The test flow begins by setting the asynchronous reset of the TRCUTwithMISR to logic 1. This will reset all the combinational logic to a known state. More precisely, the reset will set the random seed of the LFSR to 0xA5, and the registers of the scan chain and the MISR to 0. In the next clock cycles (4 Cycles) SE is set 1 to shift the test vectors generated randomly by the LFSR into the TRCUT. In the 5th cycle the capture is performed by setting SE to logic 0. In the next clock cycles the response from the SO of the TRCUT is fed into the tap of the MISR so the generation of the signature can begin.

This process, in our test benches made, repeats for 32 captures-Pseudo-Random-Test-Vectors generated by the LFSR and after the last capture we additionally wait for 16 cycles to get the signature produced by the MISR.

The logic behind this process is that if there are no issues with the IC block tested, and the signature produced during testing matches the known-good one, then it is a Test-Passed. If the signature produced differs due to issues like stuck-at-faults or Bit-Errors caused by cosmic radiation during the testing phase, then the circuit block is a Test-Failed and therefore additional testing must be conducted to confirm that the errors were systematic and not random.

More detailed info, waveforms and testbenches are under the bist-report.pdf

Assignment material provided as part of the Circuit Reliability and Testing Course (Prof. Vasileios Tenentes)

# High level block

<img src=".\Resources\TRCUTwithMISRIMG.png">

# Synthesized Verilog

<img src=".\Resources\misr_trcut.jpg">

