ORG 0000H ; Set the origin address to 0000H (start of program
memory)
MOV R0, #36H ; Move the value 30H into register R0 (Source address
pointer)
MOV R1, #51H ; Move the value 40H into register R1 (Destination address
pointer)
MOV R2, #05H ; Move the value 05H into register R2 (Loop counter)
L1: MOV A, @R0 ; Move the value at the address pointed to by R0 into
the Accumulator (A)
SUBB A, #20H ; Subtract the immediate value 32H from the Accumulator
(A) with borrow
MOV B, #09H ; Move the value 09H into register B
DIV AB ; Divide Accumulator (A) by register B
MOV B, #05H ; Move the value 05H into register B
MUL AB ; Multiply Accumulator (A) by register B
MOV @R1, A ; Move the value in the Accumulator (A) to the address
pointed to by R1
INC R0 ; Increment R0
INC R1 ; Increment R1
DJNZ R2, L1 ; Decrement R2 and jump to L1 if R2 is not zero
END ; End of the assembly program
