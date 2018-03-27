;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11
;_______________________________________________________________

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	PALABRA DB 1, 0, 1, 1
	TAM DW 28
	MATRIZ DB 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1
DATOS ENDS
;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
	DB 40H DUP (0)
PILA ENDS
;_______________________________________________________________
; DEFINICION DEL SEGMENTO EXTRA 
EXTRA SEGMENT 
	RES DB 7 DUP (0)
EXTRA ENDS 
;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE CODIGO
CODE SEGMENT
ASSUME CS:CODE,DS:DATOS,ES:EXTRA,SS:PILA
;_______________________________________________________________
;COMIENZO DE LA RUTINA 
multMATRIZ PROC NEAR
	;INICIALIZACIONES
	MOV SI, 0H
	MOV DL, 7
	
	bucleMULT: MOV AX, SI
	DIV DL ;AL ES LA FILA Y AH ES LA COLUMNA
	MOV CX, AX ; GUARDAMOS AMBOS VALORES EN CX
	
	;MULT=PALABRA[AL]*MATRIZ[AL][AH]
	MOV BX, CX
	MOV BH, 0H
	MOV AL, PALABRA[BX] ;BL
	MUL MATRIZ[SI] ;EL RESULTADO ESTA EN AX
	
	;RES[AH]+=MULT
	MOV BX, CX
	MOV CL, 8
	SHR BX, CL
	MOV CX, 0H
	MOV CL, RES[BX] ;BH
	ADD CX, AX
	MOV RES[BX], CL ;BH
	
	;COMPROBAMOS LA CONDICION DE SALIDA
	INC SI
	CMP SI, TAM
	JNZ bucleMULT
	
	;CALCULAMOS EN MODULO 2
	MOV SI, 0
	MOV DL, 2
	MOV CL, 8
	modulo: MOV AX, 0H
	MOV AL, RES[SI]
	DIV DL
	SHR AX, CL
	MOV RES[SI], AL
	INC SI
	CMP SI, TAM
	JNZ modulo
	RET
multMATRIZ ENDP
;FIN DE LA RUTINA 
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
	;FIN DE LAS INICIALIZACIONES
	
	;COMIENZO DEL PROGRAMA 
	CALL multMATRIZ
	;FIN DEL PROGRAMA 
	
	MOV AX, 4C00H
	INT 21H

START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START