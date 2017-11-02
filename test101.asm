assume cs:code,ss:stack
	
	data segment
		db 'Welcome to masm!',0
	data ends
	
	stack segment
		db 16 dup(0)
	stack ends
	
	
	code segment
		start:
		mov dh,8
		mov dl,3
		mov cl,2
		mov ax,data
		mov ds,ax
		mov si,0
		call show_str
		
		mov ax,4c00h
		int 21h
		
		show_str:
		mov ax,0B800h
		mov es,ax
		mov ax,160
		mul dh
		mov dh,0
		add ax,dx
		mov di,ax
		
		mov ah,cl
		s:
		mov cx,[si]
		jcxz ot
		mov al,[si]
		mov es:[di+1],ax
		add di,2
		add si,1
		loop s
		
		ot:
		retf
	code ends 
end start














