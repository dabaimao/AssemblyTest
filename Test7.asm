assume ds:data,cs:code,ss:table
		 data segment
			db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984'
			db '1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
			dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
			dd 345980,590827,803530,1183000,184300,2759000,3753000,469000,5937000
			dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800
		 data ends
		 
		 table segment
			db 21 dup('year summ ne ?? ')
		 table ends
		 
		 code segment
		 start:mov ax,data
			   mov ds,ax
			   mov ax,table
			   mov es,ax
			   mov bx,0
			   mov si,0
			   mov di,0
			   
			   mov cx,21	   
			 s:mov ax,[bx]
			   mov es:[si],ax
			   mov ax,[bx+2]
			   mov es:[si+2],ax
			   
			   mov ax,[bx+84]
			   mov es:[si+5],dx
			   mov ax,[bx+86]
			   mov es:[si+7],dx
			   
			   mov ax,[di+168]
			   mov es:[si+10],ax
			   
			   mov ax,[bx+84]
			   mov dx,[bx+86]
			   div word ptr [di+168]
			   mov word ptr es:[si+13],ax
			   
			   add di,2
			   add bx,4
			   add si,16
		  loop s
		  
			mov ax,4c00h
			int 21h
		 code ends 
end start