ORG 0000H
MOV DPTR, #1000H ; Source address in external RAM
MOV R1, #36H ; Destination address (internal RAM)
MOV R3, #05H ; Loop counter
L1: MOVX A,@DPTR ; Move data from external memory to A
MOV @R1, A ; Move data from A to internal RAM
INC DPTR ; Increment external memory pointer
INC R1 ; Increment internal memory pointer
DJNZ R3, L1 ; Decrement counter and loop
END
