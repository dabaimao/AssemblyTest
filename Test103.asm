assume cs:code
		data segment
			db 12,30,10101001b,10
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
			mov ax,stack			
			mov ss,ax				;初始化栈段和地址段
			mov sp,32
			mov di,ds:[3]			;转换为十进制
			mov si,4
			call dtoc
			
			mov si,4
			mov dh,ds:[0]    		;字符串输出行位置  
			mov dl,ds:[1]   		;字符串输出列位置  
			mov cl,ds:[2]    		;显示模式（8位）  
			call show_str			;调用子程序 show_str显示转换后的字符串
			
			mov ax,4c00h
			int 21h
			
			dtoc:					;子程序将内存单元中的数据转换为十进制
				mov bx,32
				dch:				;外层循环操作字型数据
					mov ax,[bx]
					mov cx,ax
					jcxz over		;判定是否循环到结尾终止符号设置为'0'
					dsn:			
						mov cx,ax	;判断数据是否转换完毕用求余方法，当求余结束时商为0
						jcxz after	;一个数据转换结束跳入后续处理
						div di
						add dx,30h	;添加30h符合ASCII码的十进制显示
						push dx		;数据入栈使用栈操作实现了逆序排序的第一步
						mov dx,0	;寄存器清零防止下一次求余运算出错
					loop dsn
					
					after:			;后续处理
						mov ax,sp	
 						mov cx,30
						sub ax,cx	;判断栈是否已经到底（数据出栈完毕）
						mov cx,ax
						jcxz next	;出栈结束跳转到next
						pop ax
						mov [si],al
						inc si
					loop after
					
					next:			
					inc si			
					mov ax,20h
					mov [si],ax		;在两数据之间显示空格
					add bx,2		;跳转到下一个双字节数据准备进行转换处理
				loop dch
			over:
				ret
			
			show_str:   			;子程序  
				mov ax,0b800h     
				mov es,ax   		;es寄存器指向显存段  
				mov ax,160 			;行位置控制↓  
				dec dh  
				mul dh  
				mov dh,0    		;行位置控制↑  
				dec dl      		;列位置控制↓  
				add dl,dl   		;列位置控制↑  
				add ax,dx  
				mov di,ax  
				mov ah,cl   		;计算最终输出位置=行x180+列  
				
				
				display:    		;输出字符串子程序  
					mov cx,ds:[si]  
					jcxz return  
					mov al,ds:[si]       
					mov es:[di],ax  
					add di,2  
					inc si  
				loop display  
			return:
				ret        			;返回call show_str  
		code ends
end start
