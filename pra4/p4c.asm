;_______________________________________________________________
; Autores: Adrián Fernández Amador
;          Aitor Arnaiz del Val
;
; Pareja: 11

;_______________________________________________________________
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	linefeed db 13, 10, "$"
	primera db "hola"
	segunda db "que"
	tercera db "tal"
	cuarta db "estas"
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
	mov al, 00101111b ; DV=010b, RS=1111b (15 == 2 Hz), no se como poner 16 para que sea 1 Hz
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


;rutina de servicio a la interrupcion
RTC_rsi PROC FAR
sti
push ax
mov al, 0Ch
out 70h, al ; Accede a registro 0Ch de RTC
in al, 71h ; Lee registro 0Ch de RTC
…..
final: ; Envía EOIs (RTC)
mov al, 20h
out 20h, al ; Master PIC
out 0A0h, al ; Slave PIC
pop ax
iret
RTC_rsi ENDP


CODE ENDS
end confRTC