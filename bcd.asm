ORG 0000H // Set the origin address to 0000H
SETB PSW.3 // Set bit 3 of the PSW to 1. This selects register bank
1.
MOV R0, #02H // Move the value 02H into register R0
MOV R1, #08H // Move the value 08H into register R1
MOV A, R1 // Move the value in register R1 into the Accumulator (A)
ADD A, R0 // Add the value in register R0 to the Accumulator (A)
DA A // Decimal Adjust Accumulator: adjusts the result in A to
a valid packed BCD format after an addition
END
