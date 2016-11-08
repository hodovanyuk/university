; Пример 11.1. Вывод на экран текста в обрамлении

text    segment
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        mov AH,09h
        mov DX,offset msg
        int 21h

        mov AX,4C00h
        int 21h

text    ends

data    segment
msg     db 10*80 dup (20h)      ; прокрутка 10 строк экрана
; вывод трех строк (пробелы, обрамление, текст, пробелы)
        db 35 dup (20h),0C9h,9 dup (0CDh),03Bh,34 dup (20h)
        db 35 dup (20h),0BAh,10h,'ОСТАНОВ',11h,0BAh,34 dup (20h)
        db 35 dup (20h),0C8h,9 dup (0CDh),0BCh,34 dup (20h)
        db 11*80 dup (20h)      ; прокрутка еще 11 строк экрана
        db '$'                  ; завершающий знак доллара для функции 09h
data    ends                    ;(22) конец сегмента данных

stk     segment stack           ;(23) начало сегмента стека
        db 256 dup (0)          ;(24) стек
stk     ends                    ;(25) конец сегмента стека

end begin                       ;(26) конец текста программы
