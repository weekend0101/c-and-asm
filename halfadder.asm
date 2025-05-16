ORG 0000H // Set the origin address to 0000H
MOV R0, #01H // Move the value 01H into register R0
MOV R1, #00H // Move the value 00H into register R1
L1: MOV A, R0 // Move the value in register R0 into the Accumulator
(A)
XRL A, R1 // XOR (exclusive OR) the value in register R1 with the
Accumulator (A), result in A
MOV R6, A // Move the result from Accumulator (A) to register R6
MOV A, R0 // Move the value in register R0 into the Accumulator (A)
ANL A, R1 // AND the value in register R1 with the Accumulator (A),
result in A
MOV R7, A // Move the result from Accumulator (A) to register R7
END // End of the assembly program
