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
		push bx		;BX用于数据转移(输入起始的逻辑扇区号)
		push cx		;CH磁道号存放,CL该磁道上的某扇区号存放(不输入数据)
		push ax		;输入int13功能号(AH存放功能号,AL存放要调用的扇区数量)
		push dx		;DH磁头面,DL驱动器号输入
;-----------------------------------------------------------------------------
		mov ax,bx	;计算调用的逻辑扇区所在磁碟面
		mov bx,1440
		div bx		;计算结果DX为该面逻辑扇区号,AX为磁头号
		mov bx,ax	;磁头号暂时放入BX
		mov ax,dx	;扇区号放入AX
		pop dx		;驱动器号放入DL
		mov dh,bl	;磁头号放入DH
;-----------------------------------------------------------------------------
		mov bx,18	;计算设定逻辑扇区所在该面物理磁道的地址
		div bx		;计算结果AX为磁道号,DX为该磁道上制定逻辑扇区的物理地址
		mov ch,al	;磁道号放入CH
		mov cl,dl	;扇区号放入CL
;-----------------------------------------------------------------------------
		pop ax		;输入int13功能号(AH存放功能号,AL存放要调用的扇区数量)
;-----------------------------------------------------------------------------
		push cx
		push bx		;恢复现场
	new_int7cend:nop

code ends
end install