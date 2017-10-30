assume cs:codesg,ds:datasg,ss:stacksg

datasg segment
		db "welcome to masm!"
		db 2,24h,71h
datasg ends

stacksg segment
		db 16 dup(0)
stacksg ends


codesg segment
		start:
		mov ax,datasg
		mov ds,ax
		mov si,10h
		mov di,1824
		mov ax,0b800h
		mov es,ax
		
		mov cx,3
		s1:
		mov bx,0
		push cx
		mov cx,16
		s:
			mov al,[bx]
			mov ah,[si]
			mov word ptr es:[di],ax
			add bx,1
			add di,2
		loop s
		inc si
		add di,128
		pop cx
		loop s1
		
		
		all:
		jmp short all
		mov ax,4c00h
		int 21h
		
codesg ends
end start