;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11
;_______________________________________________________________

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	CONTADOR DW 0
	IMPRIMIR DW 17 DUP (0)
DATOS ENDS
;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
	DB 40H DUP (0)
PILA ENDS
;_______________________________________________________________
; DEFINICION DEL SEGMENTO EXTRA 
EXTRA SEGMENT 
	RES DB 16 DUP (0)
EXTRA ENDS 
;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE CODIGO
CODE SEGMENT
ASSUME CS:CODE,DS:DATOS,ES:EXTRA,SS:PILA
;_______________________________________________________________
;COMIENZO DEL PROGRAMA 
printASCII PROC NEAR
	MOV AX, BX
	MOV BX, 10
	MOV DX, 0H		
	MOV SI, 0
jump:	DIV BX
	MOV CX, DX
	ADD CX, 48
	
	PUSH CX
	
	MOV DX, CONTADOR
	INC DX
	MOV CONTADOR, DX
	MOV DX, 0H
	
	CMP AX, 0H
	JNZ jump
	
	MOV SI, 0
	MOV AX, OFFSET RES
jump2:	POP CX
	MOV RES[SI], CL
	INC SI
	CMP SI, CONTADOR
	JNZ jump2
	MOV RES[SI], 36
	
	MOV DX, ES
	RET
printASCII ENDP
;FIN DEL PROGRAMA 
;_______________________________________________________________
; COMIENZO DEL PROCEDIMIENTO PRINCIPAL (START)
START PROC
	;INICIALIZA LOS REGISTROS DE SEGMENTO CON SUS VALORES 
	MOV AX, DATOS 
	MOV DS, AX 

	MOV AX, EXTRA 
	MOV ES, AX 

	MOV AX, PILA 
	MOV SS, AX
	MOV SP, 64
	;FIN DE LAS INICIALIZACIONES
	
	
	MOV BX, 1234
	CALL printASCII
	
	MOV SI, 0H
	MOV BX, OFFSET IMPRIMIR
	MOV ES, DX

	MOV BP, AX
jump3: ADD BP, SI 
	MOV CX, ES:[BP]
	MOV IMPRIMIR[SI], CX
	INC SI
	CMP CX, 36
	JNZ jump3
	
	;IMPRIMIMOS EL RESULTADO POR PANTALLA
	MOV AH,9
	MOV DX, BX
	INT 21H
	
	MOV AX, 4C00H
	INT 21H
	
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START

