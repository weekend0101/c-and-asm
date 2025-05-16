ORG 0000H ; Set program start address
MOV P1, #08H ; Step 1: Energize coil 4 (bit 3) - Start
clockwise rotation (wavedrive)
ACALL DELAY ; Call delay to allow stepper to rotate a step
MOV P1, #04H ; Step 2: Energize coil 3 (bit 2)
ACALL DELAY ; Delay
MOV P1, #02H ; Step 3: Energize coil 2 (bit 1)
ACALL DELAY ; Delay
MOV P1, #01H ; Step 4: Energize coil 1 (bit 0)
ACALL DELAY ; Delay
ACALL DELAY ; Extra delay between direction changes (optional)
; --- Now rotate the stepper motor anti-clockwise in wavedrive mode ---

MOV P1, #01H ; Step 1: Energize coil 1 (bit 0) - Start anti-
clockwise rotation

ACALL DELAY ; Delay

5.B (180° CA & ACW - Full Step)
Write ALP to interface stepper motor with 89S52 and rotate the stepper motor in Full drive
stepping clockwise and anticlockwise direction for 180° continuously.

A B C D HEX
0 0 1 1 3
0 1 1 0 6
1 1 0 0 C
1 0 0 1 9

Clockwise (3 -> 6 -> C -> 9)
Anti Clockwise (9 -> C -> 6 -> 3)
MOV P1, #02H ; Step 2: Energize coil 2 (bit 1)
ACALL DELAY ; Delay
MOV P1, #04H ; Step 3: Energize coil 3 (bit 2)
ACALL DELAY ; Delay
MOV P1, #08H ; Step 4: Energize coil 4 (bit 3)
ACALL DELAY ; Delay
; --- Delay subroutine to create pause between steps ---
DELAY: MOV R1, #0FFH ; Outer loop count
UP3: MOV R2, #0FFH ; Middle loop count
UP1: MOV R3, #0EH ; Inner loop count (adjust this to fine-tune
delay)
UP: DJNZ R3, UP ; Decrement R3 and loop until 0
DJNZ R2, UP1 ; Decrement R2 and repeat inner loop
DJNZ R1, UP3 ; Decrement R1 and repeat outer loop
RET ; Return from delay subroutine
END ; End of program
