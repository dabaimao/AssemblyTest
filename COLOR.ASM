assume cs:code,ds:data,ss:stack

data	segment
	markrow dw 0
	markcol	db 0
data	ends

stack	segment
stack	ends

code	segment
start:	mov		ax,data
		mov		ds,ax
		mov		ax,stack
		mov		ss,ax
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		mov		ax,0013H		;进入13号显示模式
		int		10H
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		mov		dx,0
		mov		ah,0CH
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
color:	mov		cx,0
		mov		al,00100000B
		mov		si,20
brush:	int		10H
		inc		cx
		cmp		cx,si
		jb		brush
		add		si,20
		add		al,00101111B
		cmp		cx,320
		jb		brush
		inc		dx
		cmp		dx,200
		jb		color

		call	waitE
		

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		mov		ax,0003H		;恢复默认显示模式
		int		10H
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		mov		ax,4C00H		;调用结束程序终端
		int		21H
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;子程序段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

waitE:	mov		ah,0
		int		16H
		cmp		al,27
		jne		waitE
ret

code	ends
end	start
