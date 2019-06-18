assume cs:code,ds:data,ss:stack
data        segment
    binary  db 8 dup(0)
    input   db 86

data        ends

stack       segment stack
            db  1024 dup(0)
stack       ends
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;³ÌÐò¶Î
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
code        segment
start:      mov     ax,data
            mov     ds,ax
            mov     ax,stack
            mov     ss,ax
            mov     sp,1024
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;Ö÷³ÌÐò¶Î
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
main:       mov     cx,8
            mov     si,0
            mov     al,1
            mov     ah,al
            jmp     bin
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
draw:       mov     al,1FH
            jmp     go
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
bin:        and     al,input
            jnz     draw

go:         mov     binary[si],al
            inc     si
            shl     ah,1
            mov     al,ah
            loop    bin

            mov     ax,4F02H
            mov     bx,107H
            int     10H

            mov     cx,640
            mov     dx,0
            mov     ax,0C1FH
            int     10H

            mov     cx,1
            mov     dx,1
            mov     si,0

jadge:      push    cx
            push    dx
            mov     di,1
            mov     bx,di
            mov     si,0
            dec     dx
            dec     cx
            mov     ax,0D00H

jloop:      int     10H
            and     bl,al
            add     si,bx
            shl     di,1
            mov     bx,di
            inc     cx
            cmp     di,8
            jb      jloop

            pop     dx
            pop     cx
            mov     ax,0C00H

            mov     al,binary[si]
            mov     bx,0
            int     10H

            mov     ax,0D00H
            inc     cx
            cmp     cx,1279
            jb      jadge
            mov     cx,1
            inc     dx
            cmp     dx,632
            jb      jadge
inputwait:       
            mov     ax,0
            int     16H
            cmp     al,27
            je      quit
            jmp     inputwait
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
quit:       mov     ax,0003H
            int     10H

            mov     ax,4C00H
            int     21H
code        ends
end         start


