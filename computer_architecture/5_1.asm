text	segment
assume 	cs:text, ds:data

begin:	mov ax,data
	mov ds,ax
	mov si,offset src
	push ds
	pop es
	mov di,offset dest
	cld
	mov cx,5
rep	movsb
	int 21h
	mov ah,4ch
	mov al,0
	int 21h
text	ends

data	segment
src	db 10,20,30,40,50
dest	db 5 dup (?)
data 	ends

stk	segment stack
	db 5 dup (?)
stk	ends


	end begin
