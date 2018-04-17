assume cs:INSTALL
INSTALL segment
	COPY_BOOT:

	
	mov ax,4C00H
	int 21H
;============================================================需要安装的引导程序集
	BOOT_START:
;============================================================主程序
		jmp MENU
			md db "1) reset pc",10		;菜单显示信息数据
			   db "2) start system",10
			   db "3) clock",10
			   db "4) set clock",10
			   db 10
			   db "@shawnping testOS copyright",0
			wt db 64 dup(0)			;等待输入字符行
;------------------------------------------
		MENU:
			call clear					;清屏
			mov ax,seg md
			mov ds,ax
			mov si,offset md
			call DISPLAY				;显示菜单

		SELECT:							;选择等待
			mov ah,0
			int 16h

			cmp al,
		jmp SELECT

			mov ax,4C00H
			int 21H
;=============================================================一号重启子程序
			
;=============================================================二号引导现有操作系统
		ORI_RESTATR:
			int 19H	
;=============================================================三号时钟程序
		TD0 db "CALENDAR",10
		TD1 db 0,0,"Y ",0,0,"M ",0,0,"D ",10
		TD2 db "TIME",10
		TD3 db 0,0,"H ",0,0,"M ",0,0,"S ",0
		TIMEDIS:
			call clear				;清屏
			mov ax,seg TD0			;设置display子程序显示数据源
			mov ds,ax
			mov si,offset TD0
		CLOCK:
;------------------------------------------BIOS时钟读取和显示程序
			mov al,9
			call HTOD
			mov TD1[0],ah
			mov TD1[1],al

			mov al,8
			call HTOD
			mov TD1[4],ah
			mov TD1[5],al

			mov al,7
			call HTOD
			mov TD1[8],ah
			mov TD1[9],al

			mov al,4
			call HTOD
			mov TD3[0],ah
			mov TD3[1],al

			mov al,2
			call HTOD
			mov TD3[4],ah
			mov TD3[5],al

			mov al,0
			call HTOD
			mov TD3[8],ah
			mov TD3[9],al
			call DISPLAY
		jmp CLOCK
;------------------------------------------十六进制转十进制显示程序
		HTOD:
			out 70H,al
			in al,71H
			mov ah,al
			mov cl,4
			shr ah,cl
			and al,00001111B

			add ah,30H
			add al,30H
		ret
		back_menuc:
			jmp MENU
;=============================================================四号设置时间
		SET_CLO:

;=============================================================返回菜单子程序
		RET_MENU:
			















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