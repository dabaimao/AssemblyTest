assume cs:INSTALL
INSTALL segment
	COPY_BOOT:

	
	mov ax,4C00H
	int 21H
;=============================================================需要安装的引导程序集
	BOOT_START:
;============================================================主程序
		jmp MENU
		md db "1) reset pc",10		;菜单显示信息数据
		   db "2) start system",10
		   db "3) clock",10
		   db "4) set clock",10
		   db 10
		   db "@shawnping testOS copyright",0
		MENU:
		call clear					;清屏
		mov ax,seg md
		mov ds,ax
		mov si,offset md
		call DISPLAY				;显示菜单
		
		SELECT:						;选择等待


		jmp SELECT


		mov ax,4C00H
		int 21H

;=============================================================清屏子程序
		clear:
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
;=============================================================显示子程
		DISPLAY:
			mov ax,0B800H
			mov es,ax
			mov di,160*12
			mov bx,0
			s:
				mov al,ds:[si]
				cmp al,10
				jz newline
				cmp al,0
				jz DISPLAY_END
				mov es:[di],al
				inc si
				add bx,2				;列计数器
				add di,2
			jmp s
			newline:
				sub di,bx
				add di,160
				mov bx,0
				inc si
			jmp s
		DISPLAY_END:ret
;=============================================================
	BOOT_END:nop

INSTALL ends
end COPY_BOOT