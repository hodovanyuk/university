text	segment
assume 	cs:text, ds:data

begin:	mov ax,data
	mov ds,ax
	mov ah,09h
	mov dx,offset mesg
	int 21h
	mov ah,4ch
	mov al,0
	int 21h
text	ends
data	segment
mesg	db 'Let the battle begin!$'
data 	ends
stk	segment stack
	db 256 dup (0)
stk	ends
	end begin