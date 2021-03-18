	DATA 	EQU 0X21
	CONT	EQU	0X22
    DE1     EQU 0X23
    DE2     EQU 0X24
    DE3     EQU 0X25

    ;BEGIN
	ORG	0X00
	GOTO	START

;CODE
START
	BSF		STATUS,5
	CLRF	TRISB 		; PORT B ALL OUTPUT
	CLRF	TRISD		; PORT D ALL OUTPUT
	CLRF	TRISC		; PORT C ALL OUTPUT
	BSF		TRISD, 7	; SELECTOR PART 1
	BSF		TRISD, 6	; EMITTER RECEIVER SIGNAL DETECTOR
	BCF		STATUS, 5
	MOVLW	0X00
	MOVWF	PORTB
	MOVLW	B'11111111'
	MOVWF	PORTC
	MOVWF	PORTD
	BCF		PORTD, 2
	GOTO	MENU

MENU
	BTFSC	PORTD, 7
	CALL	RIGHT
	BTFSS	PORTD, 7
	CALL	LEFT
	GOTO	MENU

LEFT
	MOVLW	B'11111110'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11111101'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11111011'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11110111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11101111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11011111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'10111111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'01111111'
	MOVWF	DATA
	CALL	MV
	RETURN

RIGHT
	MOVLW	B'01111111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'10111111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11011111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11101111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11110111'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11111011'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11111101'
	MOVWF	DATA
	CALL	MV
	MOVLW	B'11111110'
	MOVWF	DATA
	CALL	MV
	RETURN

MV
	MOVF	DATA, W
	MOVWF	PORTB
	MOVLW	0x1F
	MOVWF	DE1
	MOVLW	0xFF
	MOVWF	DE2
	MOVWF	DE3
	CALL	DELAY
	CALL	SIGNAL
	RETURN

;DELAY OF 31x255x255
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

;DISPLAY 1 == DISPLAY 2
;C0:PIN 15 -- D0:PIN 19 -> DISPLAY 1:E 
;C1:PIN 16 -- D1:PIN 20 -> DISPLAY 2:D 
;C2:PIN 17 -- D2:PIN 21 -> DISPLAY 4:C 
;C3:PIN 18 -- D3:PIN 22 -> DISPLAY 6:B 
;C4:PIN 23 -- D4:PIN 27 -> DISPLAY 7:A 
;C5:PIN 24 -- D5:PIN 28 -> DISPLAY 9:F 
;C6:PIN 25 -- D6:PIN 29 -> DISPLAY 10:G 
SIGNAL
	BTFSC	PORTD, 6
	RETURN
	MOVF	CONT, W
	XORLW	0X09
	BTFSC	STATUS, 2
	GOTO	ZERO
	CALL	NONZ
	RETURN

ZERO
	;RESET CONT
	MOVLW	0X00
	MOVWF	CONT
	;DISPLAY NUMBER 0
	MOVLW	B'11111111'
	MOVWF	PORTC
	MOVWF	PORTD
	BCF		PORTD, 2
	RETURN

NONZ
	BTFSS	PORTD, 6
	INCF	CONT, 0X01

	MOVF	CONT, W
	XORLW	0X01
	BTFSC	STATUS, 2
	GOTO	ONE

	MOVF	CONT, W
	XORLW	0X02
	BTFSC	STATUS, 2
	GOTO	TWO

	MOVF	CONT, W
	XORLW	0X03
	BTFSC	STATUS, 2
	GOTO	THREE

	MOVF	CONT, W
	XORLW	0X04
	BTFSC	STATUS, 2
	GOTO	FOUR

	MOVF	CONT, W
	XORLW	0X05
	BTFSC	STATUS, 2
	GOTO	FIVE

	MOVF	CONT, W
	XORLW	0X06
	BTFSC	STATUS, 2
	GOTO	SIX

	MOVF	CONT, W
	XORLW	0X07
	BTFSC	STATUS, 2
	GOTO	SEVEN

	MOVF	CONT, W
	XORLW	0X08
	BTFSC	STATUS, 2
	GOTO	EIGHT

	MOVF	CONT, W
	XORLW	0X09
	BTFSC	STATUS, 2
	GOTO	NINE

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
	BSF		PORTC, 4	;E
	BSF		PORTC, 5	;D
	BSF		PORTC, 7	;B
	BSF		PORTD, 2	;G
	BSF		PORTD, 4	;A
	RETURN

THREE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 5	;D
	BSF		PORTC, 6	;C
	BSF		PORTC, 7	;B
	BSF		PORTD, 2	;G
	BSF		PORTD, 4	;A
	RETURN

FOUR
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 6	;C
	BSF		PORTC, 7	;B
	BSF		PORTD, 2	;G
	BSF		PORTD, 3	;F
	RETURN

FIVE
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 5	;D
	BSF		PORTC, 6	;C
	BSF		PORTD, 2	;G
	BSF		PORTD, 3	;F
	BSF		PORTD, 4	;A
	RETURN

SIX
	MOVLW	0X00
	MOVWF	PORTC
	MOVWF	PORTD
	BSF		PORTC, 4	;E
	BSF		PORTC, 5	;D
	BSF		PORTC, 6	;C
	BSF		PORTD, 2	;G
	BSF		PORTD, 3	;F
	BSF		PORTD, 4	;A
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
	BSF		PORTC, 6	;C
	BSF		PORTC, 7	;B
	BSF		PORTD, 2	;G
	BSF		PORTD, 3	;F
	BSF		PORTD, 4	;A
	RETURN

END
