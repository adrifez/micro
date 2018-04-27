_codigo_rutinas segment byte public
	assume cs:_codigo_rutinas
	
_DetectarDriver proc far
	push es
	xor ax,ax
	mov es,ax
	cmp word ptr es:[65h*4],0h
	jne _detectar_int
	cmp word ptr es:[65h*4+2],0h
	je _detectar_nodriver
_detectar_int:
	mov ah,00h
	int 65h
	cmp ax,0F0F0h
	jne _detectar_nodriver
	xor ax,ax
	jmp _detectar_fin
_detectar_nodriver:
	mov ax,1
_detectar_fin:
	pop es
	ret
_DetectarDriver endp

_DesinstalarDriver proc far
	mov ah,01h
	int 65h
	ret
_DesinstalarDriver endp

_Promediar proc far
	..............
	..............
	..............
_Promediar endp

public _DetectarDriver
public _DesinstalarDriver
public _Promediar

_codigo_rutinas ends
end
