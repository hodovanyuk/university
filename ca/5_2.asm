text	segment
assume 	cs:text, ds:data

begin:	mov ax, data
	mov ds,ax
	mov si, offset sourc
	push ds
	pop es
	mov di, offset fname
	cld
repe	cmpsb
	jne no

yes:	mov ah,09h
        mov dx,offset cpm

no:	mov ah,09h
        mov dx,offset ucpm

	int 21h		;end
	mov ah,4ch
	mov al,0
	int 21h
text	ends

data	segment
sourc 	db 'MYFILE01.~AT'	;input string
fname 	db 'MYFILE01.DAT'	;origin
cpm     db 'strings are same'
ucpm    db 'strings are not same'
data 	ends

stk	segment stack
	db 5 dup (?)
stk	ends

	end begin