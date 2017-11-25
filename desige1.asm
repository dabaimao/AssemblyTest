assume cs:code
		data segment
		d1	db 5,10,00001010b
		d2	dw 0,2,0
		d3	db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
		d4	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
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
				mov sp,32					;初始化栈			
				
				call initial				;初始化表格行列指针
				mov di,ds:[3]
				mov cx,21
				mov bx,offset d3			;数据段偏移地址设置到d3段开头
				mov ah,0
				mov dx,0
				years:
					push cx
					push bx
					mov cx,4
					add bx,4
					year:
						dec bx
						mov al,ds:[bx]
						push ax
					loop year
					call show_str
					pop bx
					add bx,4
					pop cx
				loop years
				
				call initial				;初始化表格行列指针
				mov di,ds:[3]
				add di,20
				mov ds:[3],di
				mov cx,21
				mov ax,10
				mov bp,ax
				mov bx,offset d4			;数据段偏移地址设置到d4段开头
				capital:					;第二列显示
					push cx
					mov ax,ds:[bx]
					mov dx,ds:[bx+2]
					push bx
					call dtoc
					call show_str
					pop bx
					add bx,4
					pop cx
				loop capital
				
				call initial							;初始化表格行列指针
				mov di,ds:[3]
                                add di,40
				mov ds:[3],di
				mov cx,21
				mov ax,10
				mov bp,ax
				mov bx,offset d5						;数据段偏移地址设置到d5段开头
				emplo:
					push cx
					mov ax,ds:[bx]
					mov dx,0
					push bx
					call dtoc
					call show_str
					pop bx
					add bx,2
					pop cx				
				loop emplo
				
				call initial							;初始化表格行列指针
				mov di,ds:[3]
				add di,60
				mov ds:[3],di
				mov cx,21
				mov bx,offset d4						;数据段偏移地址设置到d4段开头
				mov si,offset d5						;数据段偏移地址设置到d5段开头
				mov ds:[7],si
				avg:
					push cx
					mov ax,ds:[bx]
					mov dx,ds:[bx+2]
					push bx
					mov si,ds:[7]				
					mov cx,ds:[si]
					mov bp,cx
					add si,2
					mov ds:[7],si
					call divdw
					mov cx,10
					mov bp,cx
					call dtoc
					call show_str
					pop bx
					add bx,4
					pop cx
				loop avg
	
			mov ax,4C00H
			int 21H
			
			dtoc:								;十进制转换子程序
				pop di								;返回指令地址暂时放入暂存中
				put:								
					mov cx,ax						;判断是否余数为零
					add cx,dx						;判断是否余数为零
					jcxz next
					call divdw						;调用三十二除法器
					add si,30H								
					push si
				jmp put
				next:
				push di								;返回寄存器中暂时存放指令地址
			ret
			
			show_str:								;显示子函数
				pop si
				mov di,ds:[3]
				mov ax,28
				sub ax,sp
				div word ptr ds:[5]
				mov cx,ax			
				display:
					pop ax
					mov ah,ds:[2]
					mov es:[di],ax
					add di,2
				loop display
				mov di,ds:[3]						;换行操作
				add di,160
				mov ds:[3],di
				push si
			ret
		
			divdw:									;三十二位除法器子程序
				mov bx,ax
				mov ax,dx
				mov dx,0
				div bp
				push ax
				mov ax,bx
				div bp
				mov si,dx
				pop dx
			ret
			
			initial:								;设定表格在显示器上输出的起始位置
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
