; Пример 1.1. Простейшая программа
text    segment 'code'                  ;(1) начало сегмента команд
        assume CS: text, DS: text       ;(2) сегментные регистры CS и DS
                                        ;    будут указывать на сегмент команд
begin:  mov AX, text                    ;(3) адрес сегмента команд загрузим
        jmp continue

message1 db 'Hello world!!!',10,13,'$'  ;(11) выводимый текст
message2 db '123456mmmnnnppp$'

;CR (caret)
;LF (line feed)

continue:
        mov DS, AX                      ;(4) сначала в AX, затем в DS
        mov AH, 09h                     ;(5) функция DOS 9h вывода на экран
        mov DX, offset message1          ;(б) адрес выводимого сообщения
        int 21h                         ;(7) вызов DOS
        mov AH, 09h                     ;(5) функция DOS 9h вывода на экран
        mov DX, offset message2          ;(б) адрес выводимого сообщения
        int 21h                         ;(7) вызов DOS
        mov AH, 4Ch                     ;(8) функция 4Ch завершения программы
        mov AL, 00h                     ;(9) код 0 успешного завершения
        int 21h                         ;(10) вызов DOS

text    ends                            ;(12) конец сегмента команд

        end begin                       ;(13) конец текста с точкой входа

db -> define byte(s)

AX BX CX DX
CS (code segment)
DS (data segment)
ES (additional data segment)
SS (stack segment)

PSP Program segment prefix

mov (move)
mov куди, звiдки
mov AX,0
mov AX,BX
mov AH,AL
AX
F   F    F   F
11111111 11111111
AH       AL

AX = FFFF
     AH AL

mov AH,0
AX = 00FF

mov AL,10
AX = 000A

mov DX,offset message
mov AH,09h
int 21h
