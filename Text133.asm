assume cs:code
code segment
	s1: db 'Good,batter,best,','$'
	s2: db 'Never let it rest,','$'
	s3: db 'Till good is better,','$'
	s4: db 'And better,best.','$'
	s : dw  offset s1,offset s2,offset s3,offset s4
	row: db 2,4,6,8

	start:
		mov ax,cs
		mov ds,ax
		mov bx,offset row
		mov cx,4
	ok:
		mov bh,0
