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

;INICIALIZACION DE LOS REGISTROS
	MOV CX, 0535H
	MOV DS, CX
	MOV BX, 0210H
	MOV CX, 1011H
	MOV DI, CX
	
;PROGRAMA
	MOV AL, DS:[1234H] ; AL contiene el byte de memoria situado en el offset 1234H del segmento de datos
	MOV AX, [BX] ; AX contiene dos bytes de memoria situados en el offset 210H del segmento de datos 
	MOV [DI], AL ; Guarda en el offset 1011 del segmento de datos el contenido de AL
	
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START