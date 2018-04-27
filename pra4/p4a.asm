code segment
	assume cs:code
	
	org 100h
	
driver_start:
	jmp instalar
	
	;Variables del driver
	old_60h dw 0,0
	N db 14
	buff db 30 dup (?)

;Interfaz con el prog. residente
interfaz proc
	cmp ah,00h
	jne desinst
	call detectar
	jmp fin
desinst:
	cmp ah,1h
	jne promedio
	call desinstalar
	jmp fin
stringtocesar:
	cmp ah,11h
	jne fin
	call strtoces
cesartostring:
	cmp ah,12h
	jne fin
	call cestostr
fin:
	iret
interfaz endp

;Rutinas del programa residente

;Funcion que desinstala el driver
desinstalar proc
	push ax
	push es
	xor ax,ax
	mov es,ax
	
	cli
	
	;Vector 60h
	mov ax,old_65h
	mov es:[60h*4],ax
	mov ax,old_65h+2
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
code ends
end driver_start