assume cs:code,ds:data,ss:stack
		data segment
			db 32 dup(0)
		data ends
		stack segment
			db 32 dup(0)
		stack ends
		
		code segment
			start:
			mov ax,32
			mov sp,ax
			mov ax,12666
			mov si,0
			call dtoc
			mov si,0
			mov dh,8
			mov dl,80
			mov cl,2
			call show_str
			
			mov ax,4c00H
			int 21h
			
			dtoc:
				dc0:
				jcxz dc1
				div ax
				add dx,30h
				pop dx
				mov cx,dx
				loop dc0
				
				dc1:
				jcxz resdd
				mov cx,bx
				pop bx
				mov ds:[si],bx
				inc si
				loop dc1				
			resdd:
			ret
			
			show_str:
				mov ax,0B800H
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
				jcxz reshow
				mov al,[si]		
				mov es:[di],ax
				add di,2
				inc si
				loop display
			reshow:
			ret
		code ends
end start