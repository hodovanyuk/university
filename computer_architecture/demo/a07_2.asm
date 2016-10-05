; Пример 7.2. Удаление файла с анализом возможных системных сбоев
text    segment
assume  cs:text,ds:data
begin:  mov AX,data
        mov DS,AX
        mov AH,41h
        mov DX,offset fname
        int 21h
        jc error            ; переход, если ошибка
        mov AH,09h          ; вывод сообщения
        mov DX,offset msgok ; об удалении
        int 21h
fin:    mov AX,4C00h        ; завершение программы
        int 21h
; блок анализа ошибок
error:  cmp AX,02h          ; файл не найден?
        je notfound         ; да, вывести сообщение
        cmp AX,03h          ; путь не найден?
        je wrongdir         ; да, вывести сообщение
        cmp AX,05h          ; доступ запрещен?
        je noaccess         ; да, вывести сообщение
        jmp fin
; блок вывода сообщений
notfound:  
        mov DX,offset msg1
        jmp write
wrongdir:
        mov DX,offset msg2
        jmp write
noaccess:
        mov DX,offset msg3
write:  mov AH,09h
        int 21h
        jmp fin
text    ends

data    segment
fname   db 'd:\testfile.001',0
msgok   db 'Файл удален$'
msg1    db 'Файл не найден$'
msg2    db 'Каталог неверен$'
msg3    db 'Доступ запрещен$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

        end begin
