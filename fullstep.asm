ORG 0000H ; Start of program memory
START:

UP: MOV R0, #19H ; Load R0 with 25 (19H), number of steps for 180-
degree rotation

; Assuming 1.8° per step, 180° = 100 steps in half-
step or 50 in full-step

MOV P1, #09H ; Step 1: Energize coils 1 and 4 (binary: 1001)
ACALL DELAY ; Delay for motor to take a step
MOV P1, #0CH ; Step 2: Energize coils 3 and 4 (binary: 1100)
ACALL DELAY ; Delay
MOV P1, #06H ; Step 3: Energize coils 2 and 3 (binary: 0110)
ACALL DELAY ; Delay
MOV P1, #03H ; Step 4: Energize coils 1 and 2 (binary: 0011)
ACALL DELAY ; Delay
DJNZ R0, UP ; Decrement R0 and repeat UP loop until R0 = 0
; This completes 25 full-step cycles (100 steps) =
180 degrees
UP1:
MOV R0, #19H ; Reload R0 for next 180° rotation
MOV P1, #03H ; Step 1 (reversed sequence for another 180°
rotation)
ACALL DELAY
MOV P1, #06H ; Step 2
ACALL DELAY
MOV P1, #0CH ; Step 3
ACALL DELAY
MOV P1, #09H ; Step 4
ACALL DELAY
DJNZ R0, UP1 ; Repeat for 25 steps again
SJMP START ; Infinite loop – repeat 180° clockwise rotation
endlessly

;-------------------------------------

5.C (360° CW & ACW - Half Drive)
Write ALP to interface stepper motor with 89S52 and rotate the stepper motor in half drive
stepping clockwise and anticlockwise direction for 360° continuously.

A B C D HEX
0 0 0 1 1
0 0 1 1 3
0 0 1 0 2
0 1 1 0 6
0 1 0 0 4
1 1 0 0 C
1 0 0 0 8
1 0 0 1 9

Clockwise (1 -> 3 -> 2 -> 6 -> 4 -> C -> 8 -> 9)
Anti Clockwise (9 -> 8 -> C -> 4 -> 6 -> 2 -> 3 -> 1)
; Delay Subroutine
;-------------------------------------
DELAY: MOV R1, #0FFH ; Outer loop counter
UP2: MOV R2, #0FFH ; Middle loop counter
UP3: MOV R3, #0EH ; Inner loop counter
UP4: DJNZ R3, UP4 ; Delay loop
DJNZ R2, UP3 ; Repeat inner loop
DJNZ R1, UP2 ; Repeat middle loop
RET ; Return from delay subroutine
END ; End of program
