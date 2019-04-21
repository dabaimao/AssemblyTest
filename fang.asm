assume cs:code,ds:data,ss:stack
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;数据区域
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
data segment
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;变量区域
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;常量区域
data ends

stack segment
	db 128 dup(0)
stack ends

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;主程序段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
code segment
start:	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax

	mov ax,0013H
	int 10H

	mov ah,0CH	
	mov al,11100000B
	mov cx,0
	mov dx,0
	mov si,0
	mov di,0
	call render

	call wait1

	mov ax,0003H
	int 10H

	mov ax,4C00H
	int 21H	
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;子程序区埄1�7
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;渲染子程庄1�7
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
render:	mov cx,0	

renini:	int 10H
	cmp si,39
	inc si
	ja  zerox
go0:	cmp cx,319
	inc cx
	jbe renini

	cmp di,39
	inc di
	ja  zeroy
go1:	cmp dx,199
	inc dx
	jbe render
ret	
zerox:	mov si,0
	not al
	jmp go0
zeroy:	mov di,0
	not al
	jmp go1

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;等待操作指示子程庄1�7
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
wait1:	push ax
	wait0:
	mov ah,0
	int 16H
	cmp al,'e'
	je wait0
	pop ax
ret

code ends
end start
