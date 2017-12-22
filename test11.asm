assume cs:code,ds:data
		data segment
			a1 db "Beginner,s All-purpose Symbolic Instruction Code.",0
		data ends
		code segment 
			begin:
				mov ax,data
				mov ds,ax
				mov si,offset a1              ;带入偏移地址
				call letterc
				
			mov ax,4C00H
			int 21h
			
			letterc:
				mov al,ds:[si]                 ;字符放入al寄存器
				cmp al,0    				   ;判断是否结尾
				je over						   ;结尾后结束程序
				cmp al,65                      ;判断是否是字母
				jna next               		   ;不是字母跳转到下一个字符
				cmp al,122                     ;判断是否是字母
				ja next                  	   ;不是字母跳转到下一个字符
				cmp al,97		               ;判断是否是小写字母
				jna next		               ;不是小写字母跳转到下一个字符
				and al,11011111B         	   ;小写字母改大写
				mov ds:[si],al                 ;大写化字母覆盖原内存地址
				next:
					add si,1
				jmp letterc
			over:
			ret
			
		code ends
end begin