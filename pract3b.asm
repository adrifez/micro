_pract3b SEGMENT BYTE PUBLIC 'CODE'
ASSUME CS: _pract3b
PUBLIC: _calcularAciertos, _calcularSemiaciertos
; --------------------------------
; COMIENZO DE PRIMERA RUTINA
_calcularAciertos PROC FAR
	; GUARDAMOS EN LA PILA
	PUSH BP
	MOV BP, SP
	PUSH ES
	PUSH SI
	PUSH DS
	PUSH DI
	PUSH BX
	
	; OBTENEMOS LOS ARGUMENTOS DE LA PILA
	MOV SI, [BP + 6];offset numSecreto
	MOV ES, [BP + 8];segmento numSecreto
	MOV DI, [BP + 10];offset intentodigitos
	MOV DS, [BP + 12];segmento intentodigitos
	
	; COMPARAMOS LOS DATOS
	MOV AX, 0H
	MOV BX, 0H
BUCLE: CMP ES:[SI], DS:[DI]
	JE INCREMENTA
CONTADOR: INC BX ; INCREMENTAMOS EL CONTADOR DE LETRAS COMPARADAS HASTA 4
	CMP BX, 4
	JL BUCLE
	
	JMP FIN
	
	; INCREMENTAMOS EL CONTADOR DE COINCIDENCIAS
INCREMENTA: INC AX
	JMP CONTADOR
	
	; SACAMOS BP DE LA PILA
FIN: POP BX
	POP DI
	POP DS
	POP SI
	POP ES
	POP BP
	RET
_calcularAciertos ENDP
; FINAL PRIMERA RUTINA

; --------------------------------
; COMIENZO DE SEGUNDA RUTINA
:calcularSemiaciertos PROC FAR
	; GUARDAMOS EN LA PILA
	PUSH BP
	MOV BP, SP
	PUSH ES
	PUSH SI
	PUSH DS
	PUSH DI
	
	MOV AX, 0H;AQUI GUARDAMOS EL NUMERO DE SEMIACIERTOS
	
	; OBTENEMOS LOS ARGUMENTOS DE LA PILA
	MOV SI, [BP + 6];offset numSecreto
	MOV ES, [BP + 8];segmento numSecreto
	MOV DI, [BP + 10];offset intentodigitos
	MOV DS, [BP + 12];segmento intentodigitos
	
	;SEMIACIERTOS CON EL PRIMER DIGITO DE NUMSECRETO
	CMP ES:[SI], DS:[DI+1];PRIMERO
	JNE SIG1
	INC AX
	JMP SEGUNDO
	
SIG1: CMP ES:[SI], DS:[DI+2]
	JNE SIG2
	INC AX
	JMP SEGUNDO
	
SIG2: CMP ES:[SI], DS:[DI+3]
	JNE SEGUNDO
	INC AX
	
	;SEMIACIERTOS CON EL SEGUNDO DIGITO DE NUMSECRETO
SEGUNDO:CMP ES:[SI+1], DS:[DI]
	JNE SIG3
	INC AX
	JMP TERCERO
SIG3: CMP ES:[SI+1], DS:[DI+2]
	JNE SIG4
	INC AX
	JMP TERCERO
SIG4: CMP ES:[SI+1], DS:[DI+3]
	JNE TERCERO
	INC AX
	
	;SEMIACIERTOS CON EL TERCER DIGITO DE NUMSECRETO
TERCERO:CMP ES:[SI+2], DS:[DI]
	JNE SIG5
	INC AX
	JMP CUARTO
SIG5: CMP ES:[SI+2], DS:[DI+1]
	JNE SIG6
	INC AX
	JMP CUARTO
SIG6: CMP ES:[SI+2], DS:[DI+3]
	JNE CUARTO
	INC AX
	
	;SEMIACIERTOS CON EL CUARTO DIGITO DE NUMSECRETO
CUARTO:CMP ES:[SI+3], DS:[DI+1]
	JNE SIG7
	INC AX
	JMP FIN
SIG7: CMP ES:[SI+3], DS:[DI+2]
	JNE SIG8
	INC AX
	JMP FIN
SIG8: CMP ES:[SI+3], DS:[DI+3]
	JNE FIN
	INC AX
	
	; SACAMOS DE LA PILA
FIN: POP DI
	POP DS
	POP SI
	POP ES
	POP BP
	RET
calcularSemiaciertos ENDP
; FINAL SEGUNDA RUTINA 
_pract3b ENDS
END