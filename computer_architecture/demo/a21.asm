
push3   macro a,b,c
        push a
        push b
        push c
        endm

        push3 AX,BX,CX

stars   macro
local   outpt
        mov CX,10               ; счетчик цикла
        mov AH,02h              ; функция вывода символа
        mov DL,'*'              ; символ
outpt:  int 21h                 ; вызов DOS
        loop outpt              ; цикл из СХ шагов
        endm

crlf    macro
        mov AH,02h              ; функция вывода символа
        mov DL,13               ; код возврата каретки
        int 21h                 ; вызов DOS
        mov DL,10               ; код перевода строки
        int 21h                 ; вызов DOS
        endm

stars   macro
local   outpt
        crlf                    ; вложенный макровызов
        mov CX,10               ; счетчик цикла
        mov AH,02h              ; функция вывода символа
        mov DL,'*'              ; символ
outpt:  int 21h                 ; вызов DOS
        loop outpt              ; цикл из CX шагов
        crlf                    ; вложенный макровызов
        endm

; Пример 21.1. Использование макрокоманд

; опишем макроопределения
crlf    macro
        ...                     ; текст макроопределения crlf
        endm

stars   macro
        ...                     ; текст макроопределения stars
        endm

; текст программы с макровызовами
text    segment
        assume CS:text,DS:data
begin:  mov AX,data
        mov DS,AX
        stars                   ; 1-й макровызов
        mov AH,09h
        mov DX,offset mesg1
        int 21h
        stars                   ; 2-й макровызов
        mov AH,09h
        mov DX,offset mesg2
        int 21h
        mov AX,4C00h
        int 21h
text    ends

data    segment
mesg1   db 'Первый фрагмент текста$'
mesg2   db 'Второй фрагмент текста$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

end     begin

; подключение макроса
include mymacro.mac
