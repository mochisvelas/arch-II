;MOTION SENSOR THAT WILL INCREMENT NUMBER OF PEOPLE
;ALERT WHEN NUMBER OF PEOPLE IS TOO HIGH
;DIP SWITCH THAT WILL DECREMENT NUMBER OF PEOPLE
;MEASURE VOLTAGE WITH PHOTORESISTOR
;ALERT WHEN PHOTORESISTOR IS TO HIGH

	DATA 	EQU 0X21
	PCONT	EQU	0X22
	TCONT	EQU	0X23
    DE1     EQU 0X24
    DE2     EQU 0X25
    DE3     EQU 0X26

    ;BEGIN
	ORG	0X00
	GOTO	START

;CODE
START
    ;BANK 0
    BCF     STATUS, 5
    BCF     STATUS, 6

    ;CHANNEL A0
    MOVLW   B'01000001'
    MOVWF   ADCON0

    ;BANK 1
    BSF     STATUS, 5
    BCF     STATUS, 6

    CLRF    TRISA       ; PORT A ALL OUTPUT - PORT OF PHOTORESISTOR
	CLRF	TRISB 		; PORT B ALL OUTPUT - ALERTS
	CLRF	TRISC		; PORT C ALL OUTPUT - DISPLAY PEOPLE COUNTER
	CLRF	TRISD		; PORT D ALL OUTPUT - DISPLAY TEMPERATURE
    ;BSF     TRISA, 0    ; PHOTORESISTOR INPUT
	BSF		TRISC, 7	; DECREMENTOR PEOPLE COUNTER
	BSF		TRISD, 7	; PEOPLE COUNTER EMITTER RECEIVER

    ;PREESCALAR TIME - TIME TO GET VOLTAGE
    MOVLW   B'00000111'
	;MOVLW    B'00000000'
    MOVWF   OPTION_REG

    ;LAYOUT OF PORT A
    MOVLW   B'00001110'
    MOVWF   ADCON1

    BSF     TRISA, 0

    ;BANK 0
    BCF     STATUS, 5
    BCF     STATUS, 6

    ;INIT DISPLAYS TO 0
	MOVLW	B'00111111'
	MOVWF	PORTC
	MOVWF	PORTD

    ;INIT CONT
    MOVLW   0X00
    MOVWF   PCONT
    MOVWF   TCONT

    ;INIT ALARMS
    BCF     PORTB, 0        ;ALARM PEOPLE COUNTER
    BCF     PORTB, 1        ;ALARM TEMPERATURE

	GOTO	MAIN

MAIN
    CALL    TEMPERATURE
    MOVLW   0X0F
	;MOVLW	0x1F 31
	MOVWF	DE1
	MOVLW	0xFF
	MOVWF	DE2
	MOVWF	DE3
    CALL    DELAY
    CALL    PEOPLE
    CALL    DECPEOPLE
    CALL    ALERTS
	GOTO	MAIN

;==== TEMPERATURE ====
TEMPERATURE
    BTFSS   INTCON, T0IF
    GOTO TEMPERATURE
    BCF     INTCON, T0IF
    BSF     ADCON0, GO
WAIT
    BTFSC   ADCON0, GO
    GOTO WAIT
	CALL 	DISPTEMP
	MOVWF	PORTD
    RETURN

DISPTEMP
    MOVLW   B'00001111'
    MOVWF   DATA
	MOVFW	ADRESH
    ANDWF   DATA, 0X00
    MOVWF   DATA
    MOVWF   TCONT
    GOTO    GETNUM
    MOVWF   PORTD
    RETURN


PEOPLE
    ;RETURN IF NO INTERRUPTION
	BTFSC	PORTD, 7
    RETURN


    BCF     STATUS, 2
    MOVFW   PCONT
    XORLW   0X09
    BTFSC   STATUS, 2
    RETURN

    INCF    PCONT, 0X01
	MOVFW	PCONT
    MOVWF   DATA
    CALL    GETNUM
    MOVWF   PORTC
	RETURN

DECPEOPLE
    MOVFW   PCONT
    XORLW   0X00
    BTFSC   STATUS, 2
    RETURN
    BTFSS   PORTC, 7
    RETURN
    DECF    PCONT, 0X01
	MOVFW	PCONT
    MOVWF   DATA
    CALL    GETNUM
    MOVWF   PORTC
    RETURN

ALERTS
    ;TEMPERATURE ALERT
    MOVLW   0X06
    ;MOVLW   B'01110111'
    SUBWF   TCONT, 0X00
    BTFSC   STATUS, C   ;CHECK IF SUB WAS POSITIVE
    BSF     PORTB, 1
    BTFSS   STATUS, C   ;CHECK IF SUB WAS POSITIVE
    BCF     PORTB, 1

    ;PEOPLE ALERT
    MOVFW   PCONT
    XORLW   0X09
	BTFSC	STATUS, 2
    BSF     PORTB, 0
	BTFSS	STATUS, 2
    BCF     PORTB, 0
    RETURN

GETNUM

    MOVF    DATA, W
    XORLW   B'00000000'
	BTFSC	STATUS, 2
	GOTO	ZERO

    MOVF    DATA, W
    XORLW   B'00000001'
	BTFSC	STATUS, 2
	GOTO	ONE

    MOVF    DATA, W
    XORLW   B'00000010'
	BTFSC	STATUS, 2
	GOTO	TWO

    MOVF    DATA, W
    XORLW   B'00000011'
	BTFSC	STATUS, 2
	GOTO	THREE

    MOVF    DATA, W
    XORLW   B'00000100'
	BTFSC	STATUS, 2
	GOTO	FOUR

    MOVF    DATA, W
    XORLW   B'00000101'
	BTFSC	STATUS, 2
	GOTO	FIVE

    MOVF    DATA, W
    XORLW   B'00000110'
	BTFSC	STATUS, 2
	GOTO	SIX

    MOVF    DATA, W
    XORLW   B'00000111'
	BTFSC	STATUS, 2
	GOTO	SEVEN

    MOVF    DATA, W
    XORLW   B'00001000'
	BTFSC	STATUS, 2
	GOTO	EIGHT

    MOVF    DATA, W
    XORLW   B'00001001'
	BTFSC	STATUS, 2
	GOTO	NINE
    GOTO    NINE


;DISPLAY 1 == DISPLAY 2
;C0:PIN 15 -- D0:PIN 19 -> DISPLAY 1:E
;C1:PIN 16 -- D1:PIN 20 -> DISPLAY 2:D
;C2:PIN 17 -- D2:PIN 21 -> DISPLAY 4:C
;C3:PIN 18 -- D3:PIN 22 -> DISPLAY 6:B
;C4:PIN 23 -- D4:PIN 27 -> DISPLAY 7:A
;C5:PIN 24 -- D5:PIN 28 -> DISPLAY 9:F
;C6:PIN 25 -- D6:PIN 29 -> DISPLAY 10:G
ZERO
	MOVLW	B'00111111'     ;0
    RETURN

ONE
	MOVLW	B'00001100'     ;1
	RETURN

TWO
	MOVLW	B'01011011'     ;2
	RETURN

THREE
	MOVLW	B'01011110'     ;3
	RETURN

FOUR
	MOVLW	B'01101100'     ;4
	RETURN

FIVE
	MOVLW	B'01110110'     ;5
	MOVWF	PORTD
	RETURN

SIX
	MOVLW	B'01110111'     ;6
	RETURN

SEVEN
	MOVLW	B'00011100'     ;7
	RETURN

EIGHT
	MOVLW	B'01111111'     ;8
	RETURN

NINE
	MOVLW	B'01111100'     ;9
	RETURN

DELAY
	DECFSZ	DE1, 0X01
	GOTO DELAY2
	RETURN

DELAY2
	DECFSZ	DE2, 0X01
	GOTO DELAY3
    MOVLW   0XFF
    MOVWF   DE2
	GOTO DELAY

DELAY3
    DECFSZ  DE3, 0X01
    GOTO    DELAY3
    MOVLW   0XFF
    MOVWF   DE3
    GOTO DELAY2

END
