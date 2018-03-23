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
	;FIN DE LAS INICIALIZACIONES

	;COMIENZO DEL PROGRAMA
	;INICIALIZACION DE LOS REGISTROS
	MOV CX, 0535H
	MOV DS, CX
	MOV BX, 0210H
	MOV CX, 1011H
	MOV DI, CX
	
	MOV AL, DS:[1234H] ; Guarda en AL el contenido de 5350H + 1234H
	MOV AX, [BX] ; Guarda en AX el contenido de 5350H + 0210H 
	MOV [DI], AL ; Guarda en la dir. 5350H + 1011H el contenido de AL
	;FIN DEL PROGRAMA 
	
	MOV AX, 4C00H
	INT 21H
	
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START