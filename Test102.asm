assume cs:code,ss:stack,ds:data
		data segment
			db 8 dup(0)	
		data ends
		stack segment
			db 8 dup(0)
		stack ends
		
		code segment
			start:
			mov ax,0FFFFh
			mov dx,0FFFFh
			mov cx,02h
			call divdw
			
			mov ax,4c00h
			int 21h
			
			divdw:
				mov bx,ax
				mov ax,dx
				mov dx,0
				div cx
				
				push ax
				mov ax,bx
				div cx
				mov cx,dx
				pop dx
			ret
		code ends
end start