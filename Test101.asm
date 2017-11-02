assume cs:code
data segment
		db 'Welcome to masm!',0
data ends

code segment
		strat:
		mov dh,8
		mov dl,80
		mov cl,2
		mov ax,data
		mov ds,ax
		mov si,0
		call show_str
	
		mov ax,4c00h
		int 21h
		
		show_str:
		mov ax,0b800h
		mov es,ax
		mov ax,160
		dec dh
		mul dh
		mov dh,0
		dec dl
		add dl,dl
		add ax,dx
		mov di,ax
		mov ah,cl
		
		display:
		mov cx,[si]
		jcxz return
		mov al,[si]		
		mov es:[di],ax
		add di,2
		inc si
		loop display
		return:
		retf
		
		
		
code ends
end strat