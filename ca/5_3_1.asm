text	segment
assume 	cs:text, ds:data

begin:	mov ax, data
	mov ds,ax
	
	mov di,offset tail
	cld
	mov al,' '
	mov cx,80
repe	scasb
	je blank

gotit:  mov ah,09h
        mov dx,offset cpm

blank:  mov ah,09h
        mov dx,offset cpm

	int 21h		;end
	mov ah,4ch
	mov al,0
	int 21h
text	ends

data	segment
tail	db '   /S:3'

data 	ends

	end begin