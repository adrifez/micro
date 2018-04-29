code segment
	assume cs:code
	
	org 100h
	
driver_start:
	push ax
	mov ax, es:[80h]
	cmp ax, 0h
	je estado
	
	cmp ax, 3h
	je erro
	
	mov ax, es:[82h]
	cmp ax, '/'
	jne erro
	
	mov ax, es:[83h]
	cmp ax, 'I'
	je instalar
	
	cmp ax, 'D'
	mov ax, 0100h
	int 60h
	
	jmp erro
	
;Variables del driver
	msg_instruccion db " Introduzca /I si quiere instalar el driver, /D si quiere desinstalarlo o ningun argumento si quiere ver el estado de instalacion del mismo $"
	msg_instalado db " El driver esta instalado $"
	msg_no_instalado db " El driver NO esta instalado $"
	msg_grupo db " Grupo 2301, Pareja 11, Adrian Fernandez Amador y Aitor Arnaiz del Val ", 0
	old_60h dw 0,0
	N db 14
	buff db 30 dup (?)	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
estado proc
	mov ah, 9	
	mov dx, offset msg_instruccion
	int 21h
	
	mov ah, 9	
	mov dx, offset msg_grupo
	int 21h
	
	mov ax, 0000h
	int 60h
	
	cmp ax, 0ABCDh
	je installed
	jne not_installed
	
installed: mov ah, 9
	mov dx, offset msg_instalado
	int 21h
	jmp fin3
	
not_installed: mov ah, 9
	mov dx, offset msg_no_instalado
	int 21h
	ret
fin3:	
estado endp	 

erro proc
	mov ah, 9	
	mov dx, offset msg_instruccion
	int 21h
	ret
erro endp	

;Funcion que instala el driver
instalar proc
	xor ax,ax
	mov es,ax
	
	cli
	
	mov ax,es:[60h*4]
	mov old_60h,ax
	mov ax,es:[60h*4+2]
	mov old_60h+2,ax
	
	mov es:[60h*4],offset interfaz
	mov es:[60h*4+2],cs
	
	sti
	
	mov dx,offset instalar
	int 27h
instalar endp

jmp finale1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Interfaz con el prog. residente
interfaz proc
	cmp ah,00h
	jne desinst
	call detectar
	jmp fin
desinst:
	cmp ah,01h
	jne stringtocesar
	call desinstalar
	jmp fin
stringtocesar:
	cmp ah,11h
	jne cesartostring
	call strtoces
cesartostring:
	cmp ah,12h
	jne fin
	call cestostr
fin:
	iret
interfaz endp


;Rutinas del programa residente
finale1: jmp finale2
;Funcion que desinstala el driver
desinstalar proc
	push ax
	push es
	xor ax,ax
	mov es,ax
	
	cli
	
	;Vector 60h
	mov ax,old_60h
	mov es:[60h*4],ax
	mov ax,old_60h+2
	mov es:[60h*4+2],ax
	
	sti
	
	mov es,cs:[2ch]
	mov ah,49h
	int 21h
	
	mov ax,cs
	mov es,ax
	mov ah,49h
	int 21h
	
	pop es
	pop ax
	ret
desinstalar endp

finale2: jmp finale3

strtoces proc
	; Guardamos los registros en la pila
	push si ax bx
	mov si, dx
	mov bx, 0
bucle1:
	mov al, ds:[si][bx]
	cmp al, '$'
	je fin1
	
	add al, N
	
	;Comprueba que el caracter esta entre A y Z
	cmp al, 'Z'
	jg overflow1
retof1:
	; Escribimos 
	mov buff[bx], al
	inc bx
	
	jmp bucle1
overflow1:
	sub al, 25
	jmp retof1
fin1:
	; Anadimos $ al final de la cadena
	mov buff[bx], '$'
	; Recuperamos los registros de la pila
	pop si
	ret
strtoces endp

finale3: jmp finale4

cestostr proc
	; Guardamos los registros en la pila
	push si ax bx
	mov si, dx
	mov bx, 0
bucle2:
	mov al, ds:[si][bx]
	cmp al, '$'
	je fin2
	
	sub al, N
	
	;Comprueba que el caracter esta entre A y Z
	cmp al, 'A'
	jl overflow2
retof2:
	; Escribimos 
	mov buff[bx], al
	inc bx
	
	jmp bucle2
overflow2:
	add al, 25
	jmp retof2
fin2:
	; Anadimos $ al final de la cadena
	mov buff[bx], '$'
	; Recuperamos los registros de la pila
	pop si
	ret
cestostr endp

;detectar si el driver esta instalado
detectar proc
	mov ax, 0ABCDh
	ret
detectar endp	

finale4: 


code ends
end driver_start