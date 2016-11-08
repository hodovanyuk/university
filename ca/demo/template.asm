
; шаблон програми

.386
text    segment use16
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        ; код програми

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
dummy   db ?                    ; непотрібна змінна
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
