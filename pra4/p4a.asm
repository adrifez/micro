code segment
	assume cs:code
	
	org 100h
	
driver_start:
	; Comprobamos los argumentos de entrada
	mov al, es:[80h]
	cmp al, 0h
	jne compr_err
	
	mov ah, 9	
	mov dx, offset instr1
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset instr2
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset instr3
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset msg_grupo1
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset msg_grupo2
	int 21h
	mov dx, offset linefeed
	int 21h
	mov dx, offset linefeed
	int 21h
	
	push es
	xor ax, ax
	mov es, ax
	mov ax, es:[60h*4]
	pop es
	cmp ax, offset interfaz
	je installed
	jmp not_installed
	
installed:
	mov ah, 9
	mov dx, offset msg_inst
	int 21h
	jmp fin
	
not_installed:
	mov ah, 9
	mov dx, offset msg_noinst
	int 21h
	jmp fin
	
compr_err:
	cmp al, 3h
	jg fin
	mov al, es:[82h]
	cmp al, '/'
	jne fin
	
install:
	mov al, es:[83h]
	cmp al, 'I'
	jne uninstall
	jmp instalar
	
uninstall:
	cmp al, 'D'
	jne fin
	mov ax, 0100h
	int 60h
	
fin:
	ret
	
	;Variables del driver
	old_60h dw 0,0
	N db 14
	buff db 30 dup (?)
	linefeed db 13, 10, "$"
	instr1 db " /I si quiere instalar el driver$"
	instr2 db " /D si quiere desinstalarlo$"
	instr3 db " Nada para comprobar el estado de instalacion$"
	msg_grupo1 db " Grupo 2301, Pareja 11$"
	msg_grupo2 db " Adrian Fernandez Amador y Aitor Arnaiz del Val$"
	msg_inst db " El driver esta instalado$"
	msg_noinst db " El driver NO esta instalado$"

;Interfaz con el prog. residente
interfaz proc
	cmp ah, 00h
	jne desinst
	call detectar
	jmp driver_fin
desinst:
	cmp ah, 01h
	jne stringtocesar
	call desinstalar
	jmp driver_fin
stringtocesar:
	cmp ah, 11h
	jne cesartostring
	call strtoces
	jmp driver_fin
cesartostring:
	cmp ah, 12h
	jne driver_fin
	call cestostr
driver_fin:
	iret
interfaz endp

;Rutinas del programa residente

; String to cesar
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

; Cesar to string
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

; Detecta si el driver esta instalado
detectar proc
	mov ax, 0ABCDh
	ret
detectar endp

; Funcion que desinstala el driver
desinstalar proc
	push ax
	push es
	xor ax, ax
	mov es, ax
	
	cli
	
	;Vector 60h
	mov ax, old_60h
	mov es:[60h*4], ax
	mov ax, old_60h+2
	mov es:[60h*4+2], ax
	
	sti
	
	mov es, cs:[2ch]
	mov ah, 49h
	int 21h
	
	mov ax, cs
	mov es, ax
	mov ah, 49h
	int 21h
	
	pop es
	pop ax
	ret
desinstalar endp

;Funcion que instala el driver
instalar proc
	xor ax,ax
	mov es,ax
	
	cli
	
	mov ax, es:[60h*4]
	mov old_60h, ax
	mov ax, es:[60h*4+2]
	mov old_60h+2, ax
	
	mov es:[60h*4], offset interfaz
	mov es:[60h*4+2], cs
	
	sti
	
	mov dx, offset instalar
	int 27h
instalar endp
code ends
end driver_start