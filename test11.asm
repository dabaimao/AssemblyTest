assume cs:code,ds:data
		data segment
			a1 db "Beginner,s All-purpose Symbolic Instruction Code.",0
		data ends
		code segment 
			begin:
				mov ax,data
				mov ds,ax
				mov si,offset a1              ;����ƫ�Ƶ�ַ
				call letterc
				
			mov ax,4C00H
			int 21h
			
			letterc:
				mov al,ds:[si]                 ;�ַ�����al�Ĵ���
				cmp al,0    				   ;�ж��Ƿ��β
				je over						   ;��β���������
				cmp al,65                      ;�ж��Ƿ�����ĸ
				jna next               		   ;������ĸ��ת����һ���ַ�
				cmp al,122                     ;�ж��Ƿ�����ĸ
				ja next                  	   ;������ĸ��ת����һ���ַ�
				cmp al,97		               ;�ж��Ƿ���Сд��ĸ
				jna next		               ;����Сд��ĸ��ת����һ���ַ�
				and al,11011111B         	   ;Сд��ĸ�Ĵ�д
				mov ds:[si],al                 ;��д����ĸ����ԭ�ڴ��ַ
				next:
					add si,1
				jmp letterc
			over:
			ret
			
		code ends
end begin