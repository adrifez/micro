;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11
;_______________________________________________________________

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	linefeed db 13, 10, "$"
	info db "Pareja 11: N = 11 + 3 = 14$"
	text1 db "Mensaje original:$"
	text2 db "Codificacion del mensaje:$"
	text3 db "Reversion de la codificacion:$"
	msg db "MENSAJEACODIFICAR$" ; Mensaje a codificar
	cmsg db "ASBGOXSOQCRWTWQOF$" ; Mensaje a decodificar
DATOS ENDS
;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
	db 40h dup (0)
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
	; Inicializacion de segmentos
	mov ax, DATOS
	mov ds, ax
	mov ax, EXTRA
	mov es, ax

	; Imprimimos informacion por pantalla
	mov ah, 9
	mov dx, offset info
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset text1
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset msg
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset text2
	int 21h
	mov dx, offset linefeed
	int 21h
	
	; Llamada a la rutina de codificacion
	mov ah, 11h
	mov dx, offset msg
	int 60h
	
	; Imprimimos saltos de linea
	mov ah, 9
	mov dx, offset linefeed
	int 21h
	mov dx, offset linefeed
	int 21h
	
	; Imprimimos informacion por pantalla
	mov ah, 9
	mov dx, offset text3
	int 21h
	mov dx, offset linefeed
	int 21h
	
	; Llamada a la rutina de decodificacion
	mov ah, 12h
	mov dx, offset cmsg
	int 60h
	
	;FIN DEL PROGRAMA
	mov ax, 4C00h
	int 21h
START ENDP
;FIN DEL SEGMENTO DE CODIGO
CODE ENDS
;FIN DE PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END START
