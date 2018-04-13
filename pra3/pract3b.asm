_pract3b SEGMENT BYTE PUBLIC 'CODE'
ASSUME CS: _pract3b
PUBLIC: _calcularAciertos, _calcularSemiaciertos
; --------------------------------
; COMIENZO DE PRIMERA RUTINA
_calcularAciertos PROC FAR
	; GUARDAMOS BP EN LA PILA
	PUSH BP
	MOV BP, SP
	
	

	; SACAMOS BP DE LA PILA
	POP BP
	RET
_calcularAciertos ENDP
; FINAL PRIMERA RUTINA
_pract3b ENDS
END