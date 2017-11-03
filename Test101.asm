assume cs:code
data segment
		db 'Welcome to masm!',0
data ends

code segment
		strat:
		mov dh,8 	;字符串输出行位置
		mov dl,80	;字符串输出列位置
		mov cl,2	;显示模式（8位）
		mov ax,data	
		mov ds,ax	;ds寄存器指向data段
		mov si,0	;偏移地址指向段头0000h
		call show_str	;跳转到子程序show_str
	
		mov ax,4c00h
		int 21h
		
			show_str:	;子程序
			mov ax,0b800h	
			mov es,ax	;es寄存器指向显存段
			mov ax,160	;行位置控制↓
			dec dh
			mul dh
			mov dh,0	;行位置控制↑
			dec dl		;列位置控制↓
			add dl,dl	;列位置控制↑
			add ax,dx
			mov di,ax
			mov ah,cl	;计算最终输出位置=行x180+列
		
			display:	;输出字符串子程序
			mov cx,[si]
			jcxz return
			mov al,[si]		
			mov es:[di],ax
			add di,2
			inc si
			loop display
			return:
			retf		;返回call show_str
		
		
		
code ends
end strat
