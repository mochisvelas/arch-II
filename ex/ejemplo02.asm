;CONFIGURACION

DATO EQU 0x21

;INICIO DE PROGRAMA
	ORG	0X00
	GOTO	START

;CODIGO
START
	BSF	STATUS,5
	CLRF	TRISB 		; TODOS SON SALIDA
	BCF	STATUS, RP0
	BCF	STATUS,5
	MOVLW	0X00
	MOVWF	PORTB
	GOTO	MENU

MENU
	CALL	MV1
	CALL	MV2
	GOTO	MENU


MV
	MOVF	DATO, W
	MOVWF	PORTB
	RETURN

MV1
	MOVLW	B'00000001'
	MOVWF	DATO
	CALL	MV
	RETURN

MV2
	MOVLW	B'00000010'
	MOVWF	DATO
	CALL	MV
	RETURN

END
