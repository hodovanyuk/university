; Программа, работающая со стеком
text    segment 'code'                ;(1) начало сегмента команд
        assume  CS:text, DS:data      ;(2) CS->команды, DS->данные
begin:  mov  AX, data                 ;(3) адрес сегмента данных загрузим
        mov  DS, AX                   ;(4) сначала в AX, затем в DS
        mov  ES,AX

        push DS                       ;(5) загрузим в стек содержимое DS
        pop  ES                       ;(6) выгрузим его из стека в ES

        mov  AH,9                     ;(7) функция DOS вывода на экран
        mov  DX, offset message       ;(8) адрес выводимого сообщения
        int  21h                      ;(9) вызов DOS
        mov  AX, 4C00h                ;(10) функция завершения программы
        int  21h                      ;(11) вызов DOS
text    ends                          ;(12) конец сегмента команд

data    segment                       ;(13) начало сегмента данных
message db 'Hello, world!!! Remake.$' ;(14) выводимый текст
data    ends                          ;(15) конец сегмента данных

end     begin                         ;(16) конец программы с точкой входа
