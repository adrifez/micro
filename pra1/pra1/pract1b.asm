;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11
;_______________________________________________________________

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	CONTADOR DB 0
	TOME DW 0CAFEH
	TABLA100 DB 100 DUP (0)
	ERROR1 DB "Atención: Entrada de datos incorrecta."
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
	;GUARDAMOS EL SEXTO CARACTER EN AL
	MOV BL, ERROR1[5]

	;GUARDAMOS EL VALOR EN TABLA100
	MOV TABLA100[63H], BL
	
	;EXTRAEMOS EL VALOR DE TOME
	MOV CX, TOME
	
	;GUARDAMOS EL VALOR EN TABLA100
	MOV TABLA100[23H], CL
	MOV TABLA100[24H], CH
	
	;GUARDAMOS EL BYTE MAS SIGNIFICATIVO EN CONTADOR
	MOV CONTADOR, CH
	;FIN DEL PROGRAMA 
	
	MOV AX, 4C00H
	INT 21H

START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START