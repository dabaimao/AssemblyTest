assume cs:INSTALL
INSTALL segment
	COPY_BOOT:

	
	mov ax,4C00H
	int 21H
;=============================================================��Ҫ��װ����������
	BOOT_START:
;============================================================������
		jmp MENU
		md db "1) reset pc",10		;�˵���ʾ��Ϣ����
		   db "2) start system",10
		   db "3) clock",10
		   db "4) set clock",10
		   db 10
		   db "@shawnping testOS copyright",0
		MENU:
		call clear					;����
		mov ax,seg md
		mov ds,ax
		mov si,offset md
		call DISPLAY				;��ʾ�˵�
		
		SELECT:						;ѡ��ȴ�


		jmp SELECT


		mov ax,4C00H
		int 21H

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