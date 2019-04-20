assume cs:code,ss:stack,ds:data
;=============================================
;=============================================
data    segment
    
data    ends
;=============================================
;=============================================
stack   segment
    dw  256 dup(0)
stack   ends
;=============================================
;=============================================
code    segment
start:  mov ax,stack
        mov ss,ax
        mov ax,data
        mov ds,ax
        mov ax,4F02H        
        mov bx,107H
        int 10H
        call lidraw


        mov ax,4C00H
        int 21H
;=============================================
;=============================================
;_____________________________________________
lidata      segment         
    ptrAx   dw  0
    ptrAy   dw  0
    ptrBx   dw  600
    ptrBy   dw  800
    detaX   dw  0
    detaY   dw  0
	direct	dw	0
    policy  dw  0
    stepX   dw  1
    stepY   dw  1
    color   db  00001111B
lidata      ends
;>>>>>>>>>>>>>>>>>>>>>>>
lidraw: push ax 
        push bx
        push cx
        push dx
        push si
        push di
        push ds
        mov ax,lidata
        mov ds,ax

;_____________________________________________
		mov ah,0CH
		mov al,color
		mov cx,ptrAx 
		mov dx,ptrAy
		int 10H

		mov bx,ptrBx
		sub bx,ptrAx
		jb revX
cont0:	mov detaX,bx
		cmp detaX,0
		je drawH

		mov bx,ptrBy
		sub bx,ptrAy
		jb revY
cont1:	mov detaY,bx
		cmp detaY,0
		je drawV

		mov bx,detaX
		cmp bx,detaY
		ja blok0
		xchg bx,detaY
		xchg bx,detaX
		mov direct,1

;_____________________________________________
		jmp blok0

revX:	neg bx
		mov stepX,-1
		jmp cont0

revY:	neg bx
		mov stepY,-1
		jmp cont1

drawH:	add dx,stepY
		int 10H
		cmp dx,ptrBy
		jne drawH
		jmp over

drawV:	add cx,stepX
		int 10H
		cmp	cx,ptrBx
		jne drawV
		jmp over
blok0:
;_____________________________________________
		mov bx,detaY
		add bx,detaY
		sub bx,detaX
		mov policy,bx
		mov si,1

slant:	cmp policy,8000H
		ja	lower
		jbe upper
cont2:	int 10H
		cmp cx,ptrBx
		jnz slant
;_____________________________________________
jmp		blok1

lower:	add bx,detaY
		add bx,detaY
		mov policy,bx
		cmp si,direct
		jz  mid0
		add cx,stepX
		jmp cont2
mid0:	add dx,stepY
		jmp cont2

upper:	add bx,detaY
		add bx,detaY
		sub bx,detaX
		sub bx,detaX
		mov policy,bx
		add cx,stepX
		add dx,stepY
		jmp cont2
blok1:
;_____________________________________________
over:   
		pop ds
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
;_____________________________________________
code    ends
end     start