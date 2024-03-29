_pract3b SEGMENT BYTE PUBLIC 'CODE'
ASSUME CS: _pract3b
PUBLIC _calcularAciertos, _calcularSemiaciertos
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
	PUSH CX
	
	; OBTENEMOS LOS ARGUMENTOS DE LA PILA
	MOV SI, [BP + 6];offset numSecreto
	MOV ES, [BP + 8];segmento numSecreto
	MOV DI, [BP + 10];offset intentodigitos
	MOV DS, [BP + 12];segmento intentodigitos
	
	; COMPARAMOS LOS DATOS
	MOV AX, 0H
	MOV BX, 0H
BUCLE: MOV CH, ES:[SI]
	ADD SI, 1
	MOV CL, DS:[DI]
	ADD DI, 1
	CMP CH, CL
	JE INCREMENTA
CONTADOR: INC BX ; INCREMENTAMOS EL CONTADOR DE LETRAS COMPARADAS HASTA 4
	CMP BX, 4
	JL BUCLE
	
	JMP FIN2
	
	; INCREMENTAMOS EL CONTADOR DE COINCIDENCIAS
INCREMENTA: INC AX
	JMP CONTADOR
	
	; SACAMOS BP DE LA PILA
FIN2: POP CX
	POP BX
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
_calcularSemiaciertos PROC FAR
	; GUARDAMOS EN LA PILA
	PUSH BP
	MOV BP, SP
	PUSH ES
	PUSH SI
	PUSH DS
	PUSH DI
	PUSH CX
	
	MOV CX, 0H
	MOV AX, 0H;AQUI GUARDAMOS EL NUMERO DE SEMIACIERTOS
	
	; OBTENEMOS LOS ARGUMENTOS DE LA PILA
	MOV SI, [BP + 6];offset numSecreto
	MOV ES, [BP + 8];segmento numSecreto
	MOV DI, [BP + 10];offset intentodigitos
	MOV DS, [BP + 12];segmento intentodigitos
	
	;SEMIACIERTOS CON EL PRIMER DIGITO DE NUMSECRETO
	MOV CH, ES:[SI]
	MOV CL, DS:[DI+1]
	CMP CH, CL;PRIMERO
	JNE SIG1
	ADD AX, 1
	JMP SEGUNDO
	
SIG1: MOV CL, DS:[DI+2]
	CMP CH, CL
	JNE SIG2
	ADD AX, 1
	JMP SEGUNDO
	
SIG2: MOV CL, DS:[DI+3]
	CMP CH, CL
	JNE SEGUNDO
	ADD AX, 1
	
	;SEMIACIERTOS CON EL SEGUNDO DIGITO DE NUMSECRETO
SEGUNDO: MOV CH, ES:[SI+1]
	MOV CL, DS:[DI]  
	CMP CH, CL
	JNE SIG3
	ADD AX, 1
	JMP TERCERO
SIG3: MOV CL, DS:[DI+2]
	CMP CH, CL
	JNE SIG4
	ADD AX, 1
	JMP TERCERO
SIG4: MOV CL, DS:[DI+3] 
	CMP CH, CL
	JNE TERCERO
	ADD AX, 1
	
	;SEMIACIERTOS CON EL TERCER DIGITO DE NUMSECRETO
TERCERO: MOV CH, ES:[SI+2]
	MOV CL, DS:[DI]
	CMP CH, CL
	JNE SIG5
	ADD AX, 1
	JMP CUARTO
SIG5: MOV CL, DS:[DI+1] 
	CMP CH, CL
	JNE SIG6
	ADD AX, 1
	JMP CUARTO
SIG6: MOV CL, DS:[DI+3]
	CMP CH, CL
	JNE CUARTO
	ADD AX, 1
	
	;SEMIACIERTOS CON EL CUARTO DIGITO DE NUMSECRETO
CUARTO: MOV CH, ES:[SI+3]
	MOV CL, DS:[DI]
	CMP CH, CL
	JNE SIG7
	ADD AX, 1
	JMP FIN
SIG7: MOV CL, DS:[DI+1] 
	CMP CH, CL
	JNE SIG8
	ADD AX, 1
	JMP FIN
SIG8: MOV CL, DS:[DI+2] 
	CMP CH, CL
	JNE FIN
	ADD AX, 1
	
	; SACAMOS DE LA PILA
FIN: POP CX 
	POP DI
	POP DS
	POP SI
	POP ES
	POP BP
	RET
_calcularSemiaciertos ENDP
; FINAL SEGUNDA RUTINA 
_pract3b ENDS
END