;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11
;_______________________________________________________________

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	
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

	;COMIENZO DEL PROGRAMA 
	printASCII PROC FAR
		MOV AX, BX
		MOV BX, 10
		MOV DX, 0
jump:	DIV BX
		MOV CH, AH
		ADD CH, 48
		
		MOV RES[DX], CH
		INC DX
		
		CMP AH, 0
		MOV AH, 0
		JNZ jump
		
		MOV RES[DX], 36
		
		MOV CX, ES
		MOV AX, OFFSET RES
	printASCII ENDP
	;FIN DEL PROGRAMA 
	
	MOV AX, 4C00H
	INT 21H
	
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START

