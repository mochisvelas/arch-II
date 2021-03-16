	DATA 	EQU 0X21

	ORG	0X00
	GOTO	START

START
    BCF     STATUS, 5
    BCF     STATUS, 6

    MOVLW   B'01000001'
    MOVWF   ADCON0

    BSF     STATUS, 5
    BCF     STATUS, 6

    CLRF    TRISA
	CLRF	TRISB
    CLRF    TRISC
    CLRF    TRISD
    CLRF    TRISE

    ;MOVLW   B'00000000'
    MOVLW   B'00000111'
	;MOVLW    B'00000000'
    MOVWF   OPTION_REG

    MOVLW   B'00001110'
    MOVWF   ADCON1

    BSF     TRISA, 0

    BCF     STATUS, 5
    BCF     STATUS, 6

LOOP
    BTFSS   INTCON, T0IF
    GOTO LOOP
    BCF     INTCON, T0IF
    BSF     ADCON0, GO
WAIT
    BTFSC   ADCON0, GO
    GOTO WAIT
    MOVF    ADRESH, W
    MOVWF   PORTB
	;MOVF 	ADRESL, W
	;MOVWF 	PORTD
	CALL 	DISPLAY
    GOTO LOOP

DISPLAY
	MOVF	ADRESH,	W
	MOVWF	DATA
	BTFSC	DATA, 5
	GOTO EIGTH-NINE
	GOTO Z-TO-SEVEN

EIGTH-NINE
	BTFSC	DATA, 2
	GOTO NINE
	GOTO EIGHT

Z-TO-SEVEN
	BTFSC	DATA, 2
	GOTO O-TR-FI-SE
	GOTO Z-TW-FO-SI

O-TR-FI-SE
	BTFSC	DATA, 3
	GOTO TR-SE
	GOTO O-FI

O-FI
	BTFSC	DATA, 4
	GOTO FIVE
	GOTO ONE
TR-SE
	BTFSC	DATA, 4
	GOTO SEVEN
	GOTO THREE

Z-TW-FO-SI
	BTFSC	DATA, 3
	GOTO TW-SI
	GOTO Z-FO

TW-SI
	BTFSC	DATA, 4
	GOTO SIX
	GOTO TWO

Z-FO
	BTFSC	DATA, 4
	GOTO FOUR
	GOTO ZERO

ZERO
	MOVLW	B'11111111'
	MOVWF	PORTC
	MOVWF	PORTD
	BCF		PORTD, 2
	RETURN

ONE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 7
	BSF		PORTC, 6
	RETURN

TWO
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 4
	BSF		PORTC, 5
	BSF		PORTC, 7
	BSF		PORTD, 2
	BSF		PORTD, 4
	RETURN

THREE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 5
	BSF		PORTC, 6
	BSF		PORTC, 7
	BSF		PORTD, 2
	BSF		PORTD, 4
	RETURN

FOUR
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 6
	BSF		PORTC, 7
	BSF		PORTD, 2
	BSF		PORTD, 3
	RETURN

FIVE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 5
	BSF		PORTC, 6
	BSF		PORTD, 2
	BSF		PORTD, 3
	BSF		PORTD, 4
	RETURN

SIX
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 4
	BSF		PORTC, 5
	BSF		PORTC, 6
	BSF		PORTD, 2
	BSF		PORTD, 3
	BSF		PORTD, 4
	RETURN

SEVEN
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 7
	BSF		PORTC, 6
	BSF		PORTD, 4
	RETURN

EIGHT
	MOVLW	B'11111111'
	MOVWF	PORTC
	MOVWF	PORTD
	RETURN

NINE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 6
	BSF		PORTC, 7
	BSF		PORTD, 2
	BSF		PORTD, 3
	BSF		PORTD, 4
	RETURN
END