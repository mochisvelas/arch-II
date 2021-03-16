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
	CALL 	DISPLAY
    GOTO LOOP

;=== BIT DISTRO ===
;8  4   2   1
;5  4   3   2
;0  0   0   0 -> 0
;0  0   0   1 -> 1
;0  0   1   0 -> 2
;0  0   0   1 -> 3
;0  0   0   1 -> 4
;0  0   0   1 -> 5
;0  0   0   1 -> 6
;0  0   0   1 -> 7
;0  0   0   1 -> 8
;0  0   0   1 -> 9
;0  0   0   1 -> 10
;0  0   0   1 -> 11
;0  0   0   1 -> 12
;0  0   0   1 -> 13
;0  0   0   1 -> 14
;0  0   0   1 -> 15
;WE'LL SEE IF THIS WORKS
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
	MOVLW	B'00111111'
    RETURN

ONE
	MOVLW	B'00001100'
	RETURN

TWO
	MOVLW	B'01011011'
	RETURN

THREE
	MOVLW	B'01011110'
	RETURN

FOUR
	MOVLW	B'01101100'
	RETURN

FIVE
	MOVLW	B'01110110'
	RETURN

SIX
	MOVLW	B'01110111'
	RETURN

SEVEN
	MOVLW	B'00011100'
	RETURN

EIGHT
	MOVLW	B'01111111'
	RETURN

NINE
	MOVLW	B'01111100'
	RETURN

END
