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
	MOV AX, 15H
	MOV BX, 0BBH
	MOV CX, 3412H
	MOV DX, CX
	
	;PREPARACION DE ES PARA CARGAR DESDE MEMORIA
	MOV DX, 6000H
	MOV ES, DX
	MOV BL, ES:[5636H] ; Cargamos el contenido de 65636H en BL
	
	MOV BH, ES:[5637H] ; Cargamos el contenido de 65636H en BH
	
	;PREPARACION DE ES PARA ESCRIBIR EN MEMORIA
	MOV DX, 5000H
	MOV ES, DX
	MOV ES:[5H], CH ; Cargamos en 50005H el contenido de CH
	
	MOV AX, [DI] ; Cargamos en AX el contenido de la dir. contenida en DI
	
	MOV BX, [BP + 10H] ; Cargamos en AX el contenido de la dir. contenida en BP mas 10
	;FIN DEL PROGRAMA 
	
	MOV AX, 4C00H
	INT 21H
	
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START

