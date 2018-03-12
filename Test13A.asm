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
ls:
    mov ax,0B800H
    mov es,ax
    mov al,160
    dec dh
    mul dh
    mov dh,0
    dec dl
    add dl,dl
    add al,dl
    mov di,ax
    mov di,ax
    mov ah,cl
;=============================================
    display:
    	mov al,[si]
	mov es:[di],ax
	mov es:[di],ax
	add di,2
	inc si
	cmp al,0
	je return
	jmp display
;=============================================
    return:
    iret
lend:nop

code ends
end start
