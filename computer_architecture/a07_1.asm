; Пример 7.1. Удаление файла
text    segment
assume  cs:text, ds:data
begin:  mov AX,data             ; инициализируем
        mov DS,AX               ; регистр DS
        mov AH,41h              ; функция удаления файла
        mov DX,offset fname     ; адрес имени файла
        int 21h                 ; вызов DOS
        jc error                ; переход, если ошибка
        mov AH,09h              ; вывод сообщения
        mov DX,offset msgok     ; об удалении
        int 21h                 ; вызов DOS
fin:    mov AX,4C00h            ; завершение программы
        int 21h                 ; вызов DOS
error:  mov AH,09h              ; вывод сообщения
        mov DX,offset msgerr    ; об ошибке
        int 21h                 ; вызов DOS
        jmp fin                 ; переход на завершение
text    ends

data    segment
fname   db 'd:\testfile.001',0  ; спецификация файла
msgok   db 'Файл удален$'
msgerr  db 'Файл не найден$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

        end begin
