assume cs:code
		data segment
			db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984'
			db '1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
			dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
			dd 345980,590827,803530,1183000,184300,2759000,3753000,469000,5937000
			dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800
			dw 34 dup(0)
		data ends
		stack segment
			db 64 dup(0)
		stack ends
		
		code segment
			start:
				mov ax,data
				mov ds,ax
				mov ax,stack
				mov ss,ax
				mov sp,64
				
				mov bx,0
				mov cx,21
				format:
					push cx
					mov si,0
					
					mov ah,2
					mov al,[bx]
					mov cx,4
					call trans
					
					mov al,20h
					mov cx,6
					call trans
					
					mov dx,[bx+86]
					mov ax,[bx+84]
					mov di,10
					call dtoc
					
					add bx,4
					pop cx
				loop format

			mov ax,4C00H
			int 21H
			
			trans:
				mov [bx+si+210],ax
				inc si
			loop trans
			ret
			
			dtoc:
				compmod:
					mov cx,ax
					jcxz enterstack
					div di
					add dx,30h
					push dx
					mov dx,0
				loop compmod
				
				enterstack:
				
			ret	
			
			
			
			
		code ends
end start
