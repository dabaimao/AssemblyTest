assume cs:code
code segment
	install:
		mov ax,code
		mov ds,ax
		mov si,offset new_int7c
		mov ax,0
		mov es,ax
		mov di,200H
		mov cx,offset new_int7cend-offset new_int7c
		cld
		rep movsb

		mov word ptr es:[1F0H],0200H
		mov word ptr es:[1F2H],0000H

	
	mov ax,4c00h
	int 21h

	new_int7c:
;-----------------------------------------------------------------------------
		push bx		;BX��������ת��(������ʼ���߼�������)
		push cx		;CH�ŵ��Ŵ��,CL�ôŵ��ϵ�ĳ�����Ŵ��(����������)
		push ax		;����int13���ܺ�(AH��Ź��ܺ�,AL���Ҫ���õ���������)
		push dx		;DH��ͷ��,DL������������
;-----------------------------------------------------------------------------
		mov ax,bx	;������õ��߼��������ڴŵ���
		mov bx,1440
		div bx		;������DXΪ�����߼�������,AXΪ��ͷ��
		mov bx,ax	;��ͷ����ʱ����BX
		mov ax,dx	;�����ŷ���AX
		pop dx		;�������ŷ���DL
		mov dh,bl	;��ͷ�ŷ���DH
;-----------------------------------------------------------------------------
		mov bx,18	;�����趨�߼��������ڸ�������ŵ��ĵ�ַ
		div bx		;������AXΪ�ŵ���,DXΪ�ôŵ����ƶ��߼������������ַ
		mov ch,al	;�ŵ��ŷ���CH
		mov cl,dl	;�����ŷ���CL
;-----------------------------------------------------------------------------
		pop ax		;����int13���ܺ�(AH��Ź��ܺ�,AL���Ҫ���õ���������)
;-----------------------------------------------------------------------------
		push cx
		push bx		;�ָ��ֳ�
	new_int7cend:nop

code ends
end install