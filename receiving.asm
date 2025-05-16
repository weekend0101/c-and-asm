ORG 0H ; Program start address
; Initialize UART
START:
MOV TMOD, #0x20 ; Timer 1, mode 2 (8-bit auto reload)
MOV TH1, #-3 ; Load TH1 for 9600 baud rate
MOV SCON, #0x50 ; Set UART to mode 1 (8-bit data, 1 stop bit,
receive enabled)
SETB TR1 ; Start Timer 1
; Main Loop
MAIN_LOOP:
JNB RI, MAIN_LOOP ; Wait until receive interrupt flag (RI) is set
MOV A, SBUF ; Move received data from the serial buffer to
accumulator
MOV P0, A ; Send received data to port 1 (or use as needed)
ACALL DELAY
CLR RI ; Clear receive interrupt flag
SJMP MAIN_LOOP ; Loop back to wait for the next byte
DELAY:
MOV TMOD, #01H
MOV R0, #07H
L4:
MOV TH0, #00H
MOV TL0, #00H
SETB TR0
HERE: JNB TF0, HERE
CLR TR0
CLR TF0
DJNZ R0, L4
RET
END
