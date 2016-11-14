
; шаблон програми

.386
text    segment use16
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        mov SI,offset src       ; DS:SI = src
        push DS
        pop ES
        mov DI,offset fname     ; ES:DI = fname
        cld                     ; DF = 0
        mov CX,12               ; max = 12 symbols (bytes)
        repe cmpsb              ; repeat until equal
        jne no                  ; jne = jump if not equal
        
yes:    ; повідомлення про рівні рядки
        mov AH,09h 
        mov DX,offset isEq
        int 21h
        jmp exit

no:     ; повідомлення про неоднакові символи (нерівні рядки)
        mov AH,09h 
        mov DX,offset notEq
        int 21h

exit:
        mov AX,4C00h
        int 21h

text    ends

data    segment use16
src     db 'MYFILE01.DAT'       ; сравниваемая строка
fname   db 'MYFILE02.DAT'       ; эталон
notEq   db 'Strings are not equal','$'
isEq    db 'Strings are equal','$'
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
