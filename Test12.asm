assume cs:code

        code segment
        start:
                mov ax,cs
                mov ds,ax
                mov si,offset d0
                mov ax,0
                mov es,ax
                mov di,0200H
                mov cx,offset d0end-offset d0
                rep movsb
                mov ax,0
                mov es,ax
                mov word ptr es:[0],0200H
                mov word ptr es:[2],0




        mov ax,4C00H
        int 21H
        d0:
        jmp short d0start
        db 'Overflow!'

        d0start:
                mov ax,cs
                mov ds,ax
                mov si,202H
					mov ax,0B800H
                mov es,ax
                mov di,12*160+36*2

                mov cx,9
                display:
                         mov al,[si]
					         mov es:[di],al
                         inc si
                         add di,2
                loop display
                mov ax,4C00H
                int 21H
        d0end:nop
        code ends
end start
