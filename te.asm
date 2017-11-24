assume cs:code
		data segment
		d1	db 4,10,00001100b
		d2	dw 0,0
		dm	dw 16 dup(21h)
		d3	db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
		d4	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,345980,590827,803530,1183000,184300,2759000,3753000,469000,5937000
		d5	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800
		data ends
		
		stack segment
			db 32 dup(0)
		stack ends
		
		code segment
			start:
			mov ax,data					;将地址寄存器指向数据段
			mov ds,ax
			mov ax,stack
			mov ss,ax
			mov sp,32
			call initial
			
			mov bx,offset d2
			mov di,ds:[bx]
			mov bx,offset dm
			mov si,offset d3
			mov cx,21
			mov ah,ds:[2]
			years:
				push cx
				mov cx,4
				cache0:
					mov al,ds:[si]
					mov ds:[bx],ax
					inc si
					add bx,2
				loop cache0
				mov ds:[5],bx
				mov bx,offset dm
				mov cx,4
				call show_str
				mov bx,ds:[5]
				pop cx
			loop years
			
			mov ax,4C00H
			int 21H
			
			show_str:
				mov ax,ds:[bx]
				mov es:[di],ax
				add bx,2
				add di,2
			loop show_str 
			ret
			
			initial:					;设定表格在显示器上输出的起始位置
				mov ax,0B800H
				mov es,ax
				mov ax,160
				mov dh,ds:[0]
				mov dl,ds:[1]
				dec dh
				mul dh
				mov dh,0
				dec dl
				add dl,dl
				add ax,dx
				mov ds:[3],ax
			ret

		code ends
end start