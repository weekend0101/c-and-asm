ORG 0000H // Set the origin address to 0000H (start of program
memory)
SETB PSW.3 // Set bit 3 of the PSW (Program Status Word) to 1. This
selects register bank 1.
MOV R1, #30H // Move the value 30H into register R1 (Source Address)
MOV R0, #0AH // Move the value 0AH into register R0 (Number of bytes to
add)
MOV R2, #00H // Move the value 00H into register R2 (Initialize sum to
0)
LOOP:MOV A, @R1 // Move the value at the address pointed to by R1 into
the Accumulator (A)
ADD A, R2 // Add the value in register R2 to the Accumulator (A)
MOV R2, A // Move the sum from Accumulator (A) to R2
JNC NOCARRY // Jump to NOCARRY if Carry flag is not set
INC R3 // Increment R3
NOCARRY:INC R1 // Increment R1
DJNZ R0, LOOP // Decrement R0 and jump to LOOP if R0 is not zero
NOP // No Operation
END
