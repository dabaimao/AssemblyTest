assume cs:code

code segment
	
	md0 db " 1) reset pc",10				;菜单显示信息数据
	md1 db " 2) start system",10
	md2 db " 3) clock",10
	md3 db " 4) set clock",10
	md4 db 10
	md5 db "@shawnping testOS copyright",0
	cur db 16								;图形
	cud dw 0,0,0,0							;菜单坐标信息1,2,3,4行在数据段的起始偏移地址
	ini dw 0
;=======================================================================菜单主程序
	MAIN:
		mov ax,seg md0						;将md0开始的段地址送入ds寄存器
		mov ds,ax
		call CLEAR

		mov bx,offset md0[0]				;菜单栏每行其实位置的偏移地址信息
		mov cud[0],bx
		mov bx,offset md1[0]
		mov cud[2],bx
		mov bx,offset md2[0]
		mov cud[4],bx
		mov bx,offset md3[0]
		mov cud[6],bx
		

		mov bx,16							;光标放入初始位置
		mov ds:[0],bl
		mov bp,0
		mov bx,0
		mov di,160*8+24*2
		mov ini[0],di
;-----------------------------------------------------------------------菜单控制子程序
		MENU:
			mov si,offset md0
			call DISPLAY
			mov ax,0
			int 16H

			cmp ah,72
			jz UP
			cmp ah,80
			jz DOWN

			cmp ah,01H						;退出按ESC键
			jz FULLE
		jmp MENU
	FULLE:
		call CLEAR

	mov ax,4C00H
	int 21H
;=======================================================================光标操作程序
	UP:
		mov cx,32
		mov bx,cud[bp]
		mov ds:[bx],cl
		mov cl,cur[0]
		sbb bp,2
		jb BELO
		mov bx,cud[bp]
		mov ds:[bx],cl
	jmp MENU

		BELO:
			mov bp,6
			mov bx,cud[bp]
			mov ds:[bx],cl
		jmp MENU

	DOWN:
		mov cx,32
		mov bx,cud[bp]
		mov ds:[bx],cl
		mov cl,cur[0]
		add bp,2
		cmp bp,6
		ja HIGH1
		mov bx,cud[bp]
		mov ds:[bx],cl
	jmp MENU
		
		HIGH1:
			mov bp,0
			mov bx,cud[0]
			mov ds:[bx],cl
		jmp MENU
			


		

;=======================================================================显示子程序
	DISPLAY:
		mov ax,0B800H
		mov es,ax
		mov di,ini[0]
		mov bx,0
		mov ax,0
		s:
			mov al,ds:[si]
			cmp al,10
			jz newline
			cmp al,0
			jz DISPLAY_END
			mov es:[di],al
			inc si
			add bx,2						;列计数器
			add di,2
		jmp s
		newline:
			sub di,bx
			add di,160
			mov bx,0
			inc si
		jmp s
	DISPLAY_END:
		ret
;=======================================================================清屏子程序
	CLEAR:
		mov ax,0B800H
		mov es,ax
		mov si,0
		mov cx,2000
		mov dl,0
		mov dh,00001111B
		c:
			mov es:[si],dx
			add si,2
		loop c
	ret

code ends
end MAIN