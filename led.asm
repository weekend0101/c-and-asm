ORG 0000H ; Origin, starting address of program memory
START:
JB P2.3, BUZZON ; If switch at P2.3 is HIGH, go to BUZZON
JNB P2.3, BUZZOFF ; If switch at P2.3 is LOW, go to BUZZOFF

;------------------------------------------------------
BUZZON:
SETB P2.1 ; Turn ON buzzer (assuming active HIGH at P2.1)
MOV P0, #00H ; Turn OFF all LEDs / Relay
CALL DELAY ; Delay for ON duration
MOV P0, #0FFH ; Turn ON all LEDs / Relay (simulate relay active)
CALL DELAY ; Delay for ON duration
JB P2.3, BUZZON ; Stay in BUZZON loop if switch is still pressed
JNB P2.3, BUZZOFF ; Else go to BUZZOFF

;------------------------------------------------------
BUZZOFF:
CLR P2.1 ; Turn OFF buzzer
MOV P0, #00H ; Turn OFF all LEDs / Relay
CALL DELAY ; Delay for OFF duration
MOV P0, #0F0H ; Turn ON upper nibble LEDs / Relay
CALL DELAY ; Delay for ON duration
JB P2.3, BUZZON ; If switch is pressed, go to BUZZON
JNB P2.3, BUZZOFF ; Else remain in BUZZOFF loop

;------------------------------------------------------
; Simple software delay subroutine
DELAY:
MOV R2, #05H ; Outer loop count
T: MOV R3, #0FFH ; Middle loop count
Q: MOV R4, #0FFH ; Inner loop count

3) Interfacing of 16x2 LCD in 8 bit mode with 8051
Microcontroller.
Algorithm (LCD in 8 bit mode)

Algorithm for command subroutine (for 8 bit mode)
R: NOP ; No operation (waste time)
DJNZ R4, R ; Decrement inner loop
DJNZ R3, Q ; Decrement middle loop
DJNZ R2, T ; Decrement outer loop
RET ; Return from delay
END
