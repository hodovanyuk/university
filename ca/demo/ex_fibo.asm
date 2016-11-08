; Пошук n-го числа Фібоначчі

.386
text    segment use16
assume  CS:text

begin:  mov AX,data
        mov DS,AX

        mov AX,5

        cmp AX,2
        jle fibo1
        
        mov CX,AX
        dec CX
        dec CX
        mov AX,1
        mov BX,1
continue:
        add AX,BX
        xchg AX,BX
        loop continue
        mov DX,BX
        jmp finish
fibo1:
        mov DX,1
finish:
        mov AX,4C00h
        int 21h
text    ends

stk     segment stack use16     ;(18) начало сегмента стека
        db 256 dup (0)          ;(19) стек
stk     ends                    ;(20) конец сегмента стека

end begin                       ;(21) конец текста программы
