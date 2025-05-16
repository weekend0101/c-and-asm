ORG 0000H ; Set program start address at 0000H
MOV TMOD, #20H ; Configure Timer1 in Mode 2 (8-bit auto-reload)
MOV TH1, #-3 ; Load TH1 with -3 (FDH) to set baud rate ~9600 bps
(Assuming 11.0592MHz crystal)
MOV SCON, #50H ; Configure serial mode 1 (8-bit UART), REN=1
(enable reception)
SETB TR1 ; Start Timer1 (which is used for generating baud
rate)
AGAIN: MOV A, #' ' ; Load space character into accumulator
ACALL TRANS ; Call subroutine to transmit character via UART
MOV A, #"A" ; Load 'A' into accumulator
ACALL TRANS ; Transmit 'A'
MOV A, #'B' ; Load 'B'
ACALL TRANS ; Transmit 'B'
MOV A, #'H' ; Load 'H'
ACALL TRANS ; Transmit 'H'
MOV A, #'I' ; Load 'I'
ACALL TRANS ; Transmit 'I'
MOV A, #'S' ; Load 'S'
ACALL TRANS ; Transmit 'S'
MOV A, #'H' ; Load 'H'
ACALL TRANS ; Transmit 'H'
MOV A, #'E' ; Load 'E'
ACALL TRANS ; Transmit 'E'
MOV A, #'K' ; Load 'K'
ACALL TRANS ; Transmit 'K'
MOV A, #' ' ; Load space
ACALL TRANS ; Transmit space
MOV A, #' ' ; Load space
ACALL TRANS ; Transmit space
CLR P3.1 ; Clear TXD (P3.1) – optional, just to show manual
control (not necessary for UART)
TRANS: MOV SBUF, A ; Load accumulator value into Serial Buffer
Register to transmit
HERE: JNB TI, HERE ; Wait here until transmission is complete (TI =
1)
CLR TI ; Clear TI for next transmission
RET ; Return from subroutine
END ; End of program
