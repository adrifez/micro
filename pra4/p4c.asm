;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	linefeed db 13, 10, "$"
	text1 db "Mensaje original: $"
	text2 db "Mensaje codificado: $"
	msg db "MENSAJEACODIFICAR$" ; Mensaje a codificar
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
; COMIENZO DEL PROCEDIMIENTO PRINCIPAL

;rutina de configuracion del RTC
confRTC PROC FAR 
	push ax
	mov al, 0Ah
	
	
	; FIJAR LA FRECUENCIA
	out 70h, al ; Accede a registro 0Ah
	mov al, 00101111b ; DV=010b, RS=1111b (15 == 2 Hz)
	out 71h, al ; Escribe registro 0Ah
	
	
	; ACTIVAR INTERRUPCIONES
	mov al, 0Bh
	out 70h, al ; Accede a registro 0Bh
	in al, 71h ; Lee registro 0Bh
	mov ah, al
	or ah, 01000000b ; Activa PIE
	mov al, 0Bh
	out 70h, al ; Accede a registro 0Bh
	mov al, ah
	out 71h, al ; Escribe registro 0Bh
	
	pop ax
	ret
confRTC ENDP

;_______________________________________________________________
; COMIENZO DEL PROCEDIMIENTO PRINCIPAL (START)
START PROC
	; Inicializacion de segmentos
	mov ax, DATOS
	mov ds, ax
	mov ax, EXTRA
	mov es, ax
	
	; Imprimimos informacion
	mov ah, 9
	mov dx, offset text1
	int 21h
	mov dx, offset msg
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset text2
	int 21h

	; Preparamos la interrupcion
	mov dx, offset msg
	call confRTC
	
	;FIN DEL PROGRAMA
	mov ax, 4C00h
	int 21h
START ENDP

CODE ENDS
END START