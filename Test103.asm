assume cs:code
		data segment
			db 12,30,2,10
			db 28 dup(0)
			dw 123,12666,1,8,3,38,0
		data ends
		
		stack segment
			db 32 dup(0)
		stack ends
		
		code segment
			start:
			mov ax,data
			mov ds,ax
			mov di,ds:[3]
			mov si,4
			call dtoc
			
			mov si,4
			mov dh,ds:[0]    ;字符串输出行位置  
			mov dl,ds:[1]   ;字符串输出列位置  
			mov cl,ds:[2]    ;显示模式（8位）  
			call show_str
			
			mov ax,4c00h
			int 21h
			
			dtoc:
				mov bx,32
				dch:
					mov ax,[bx]
					mov cx,ax
					jcxz over
					dsn:
						mov cx,ax
						jcxz next
						div di
						add dx,30h
						mov [si],dl
						inc si
						mov dx,0
					loop dsn
					next:
					inc si
					mov ax,20h
					mov [si],ax
					add bx,2
				loop dch
			over:
				ret
			
			show_str:   ;子程序  
				mov ax,0b800h     
				mov es,ax   ;es寄存器指向显存段  
				mov ax,160  ;行位置控制↓  
				dec dh  
				mul dh  
				mov dh,0    ;行位置控制↑  
				dec dl      ;列位置控制↓  
				add dl,dl   ;列位置控制↑  
				add ax,dx  
				mov di,ax  
				mov ah,cl   ;计算最终输出位置=行x180+列  
				
				
				display:    ;输出字符串子程序  
					mov cx,ds:[si]  
					jcxz return  
					mov al,ds:[si]       
					mov es:[di],ax  
					add di,2  
					inc si  
				loop display  
			return:
				ret        ;返回call show_str  
		code ends
end start
