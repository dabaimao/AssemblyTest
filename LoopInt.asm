assume cs:code
code segment
    start:
    mov ax,code
    mov ds,ax
    mov si,offset ls
    mov ax,0
    mov es,ax
    mov di,0200H
    mov cx,offset lend-offset ls
    cld
    rep movsb

    mov ax,0
    mov ds,ax
    mov word ptr ds:[1F0H],0200H
    mov word ptr ds:[1F2H],0000H

    mov ax,4C00H
    int 21H
;================================
ls:
	dec cx
	jcxz over
	pop ax
	sub ax,bx
	push ax
	over:
		iret
lend:nop
;================================

code ends
end start
