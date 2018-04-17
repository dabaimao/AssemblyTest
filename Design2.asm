assume cs:INSTALL
INSTALL segment
	COPY_BOOT:

	
	mov ax,4C00H
	int 21H
;============================================================��Ҫ��װ����������
	BOOT_START:
;============================================================������
		jmp MENU
			md db "1) reset pc",10		;�˵���ʾ��Ϣ����
			   db "2) start system",10
			   db "3) clock",10
			   db "4) set clock",10
			   db 10
			   db "@shawnping testOS copyright",0
			wt db 64 dup(0)			;�ȴ������ַ���
;------------------------------------------
		MENU:
			call clear					;����
			mov ax,seg md
			mov ds,ax
			mov si,offset md
			call DISPLAY				;��ʾ�˵�

		SELECT:							;ѡ��ȴ�
			mov ah,0
			int 16h

			cmp al,
		jmp SELECT

			mov ax,4C00H
			int 21H
;=============================================================һ�������ӳ���
			
;=============================================================�����������в���ϵͳ
		ORI_RESTATR:
			int 19H	
;=============================================================����ʱ�ӳ���
		TD0 db "CALENDAR",10
		TD1 db 0,0,"Y ",0,0,"M ",0,0,"D ",10
		TD2 db "TIME",10
		TD3 db 0,0,"H ",0,0,"M ",0,0,"S ",0
		TIMEDIS:
			call clear				;����
			mov ax,seg TD0			;����display�ӳ�����ʾ����Դ
			mov ds,ax
			mov si,offset TD0
		CLOCK:
;------------------------------------------BIOSʱ�Ӷ�ȡ����ʾ����
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
;------------------------------------------ʮ������תʮ������ʾ����
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
;=============================================================�ĺ�����ʱ��
		SET_CLO:

;=============================================================���ز˵��ӳ���
		RET_MENU:
			















;=============================================================�����ӳ���
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
;=============================================================��ʾ�ӳ�
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
				add bx,2				;�м�����
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