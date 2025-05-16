ORG 0000H ; Set program start address at memory location
0000H
MOV SCON, #50H ; Configure serial communication:
; Mode 1 (8-bit UART), REN = 1 (Receive enable)
MOV TMOD, #20H ; Timer1 mode 2: 8-bit auto-reload (used for baud
rate generation)
MOV TH1, #0FDH ; Load TH1 with 0FDH (-3 in 2's complement), sets
baud rate:
; 9600 baud with 11.0592 MHz crystal
SETB TR1 ; Start Timer1
MAIN_LOOP: ; Main loop label - waits for data to be received
JNB RI, MAIN_LOOP ; Wait here until RI (Receive Interrupt flag) is
set (data received)
MOV A, SBUF ; Move received character from Serial Buffer to
Accumulator

MOV P1, A ; Display received character on Port 1 (for
debugging/output)
CLR RI ; Clear the Receive Interrupt flag for next byte

5) Stepper motor interfacing with 8051 Microcontroller
and drive with different modes.
Algorithm for Stepper Motor Control
MOV DPTR, #MESSAGE ; Load address of message ("WELCOME TO VIIT
SHREYAS") into DPTR
SEND_MSG: ; Start of subroutine to send the message byte by
byte
CLR A ; Clear accumulator (A = 0)
MOVC A, @A+DPTR ; Move code memory content at address (A + DPTR)
into A
JZ MAIN_LOOP ; If A = 0 (end of string), go back to wait for
next received character
MOV SBUF, A ; Move character to Serial Buffer Register to send
via UART
JNB TI, $ ; Wait until transmission is complete (TI = 1)
CLR TI ; Clear Transmit Interrupt flag for next character
INC DPTR ; Move to the next character in the message
SJMP SEND_MSG ; Repeat the process to send the next character
MESSAGE: ; Message stored in code memory
DB 'WELCOME TO VIIT ABHISHEK', 0 ; Message string, terminated by 0
END ; End of program
