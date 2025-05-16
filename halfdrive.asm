ORG 0000H ; Start of program memory
START:

UP: MOV R0, #32H ; Load R0 with 50 (32H hex)
; 50 half-steps × 7.2° = 360° (for a 7.2° stepper
motor)
; --- Clockwise Half-Step Sequence ---

MOV P1, #09H ; Step 1: Coils 1 and 4 energized (1001)
ACALL DELAY ; Wait
MOV P1, #08H ; Step 2: Only coil 4 energized (1000)
ACALL DELAY
MOV P1, #0CH ; Step 3: Coils 3 and 4 energized (1100)
ACALL DELAY
MOV P1, #04H ; Step 4: Only coil 3 energized (0100)
ACALL DELAY
MOV P1, #06H ; Step 5: Coils 2 and 3 energized (0110)
ACALL DELAY
MOV P1, #02H ; Step 6: Only coil 2 energized (0010)
ACALL DELAY
MOV P1, #03H ; Step 7: Coils 1 and 2 energized (0011)
ACALL DELAY
MOV P1, #01H ; Step 8: Only coil 1 energized (0001)
ACALL DELAY
DJNZ R0, UP ; Decrement R0 and repeat sequence until 360°
completed
; --- Anti-Clockwise Half-Step Sequence ---
UP1: MOV R0, #32H ; Reload R0 with 50 half-steps for another 360° in
reverse
MOV P1, #01H ; Step 1: Only coil 1 energized
ACALL DELAY
MOV P1, #03H ; Step 2: Coils 1 and 2
ACALL DELAY
MOV P1, #02H ; Step 3: Only coil 2
ACALL DELAY
MOV P1, #06H ; Step 4: Coils 2 and 3

6) To interface a 16x2 LCD (Liquid Crystal Display) with
an AVR ATmega32 microcontroller and program it
using the C language
Algorithm (LCD in 8 bit mode)
ACALL DELAY
MOV P1, #04H ; Step 5: Only coil 3
ACALL DELAY
MOV P1, #0CH ; Step 6: Coils 3 and 4
ACALL DELAY
MOV P1, #08H ; Step 7: Only coil 4
ACALL DELAY
MOV P1, #09H ; Step 8: Coils 4 and 1
ACALL DELAY
DJNZ R0, UP1 ; Decrement R0 and repeat sequence
; --- Delay Subroutine ---
DELAY: MOV R1, #0FFH ; Outer loop counter
L3: MOV R2, #0FFH ; Middle loop counter
L2: MOV R3, #0EH ; Inner loop counter
L1: DJNZ R3, L1 ; Inner loop countdown
DJNZ R2, L2 ; Middle loop countdown
DJNZ R1, L3 ; Outer loop countdown
RET ; Return from delay subroutine
END ; End of program
