%TITLE "Проверка чтения строки — by Tom Swan"

        IDEAL

        MODEL small
        STACK 256

MaxLen  EQU 128                 ; 128-символьная строка
cr      EQU 13                  ; ASCII-символ возврата каретки
lf      EQU 10                  ; ASCII-символ прогона строки

        DATASEG

exCode     db 0
welcome    db 'Welcome to Echo-String', cr, lf
           db 'Type any string and press Enter', cr, lf, lf, 0
testString db MaxLen DUP (0), 0  ; MaxLen символов + 0

        CODESEG

        ; ----- из STRI0.OBJ:
        EXTRN StrRead:proc, StrWrite:proc, NewLine:proc

Start:
        mov AX,@data            ; поместить в DS
        mov DS,AX               ; адрес сегмента данных
        mov ES,AX               ; сделать DS = ES

        mov DI,offset welcome   ; вывести приглашение
        call StrWrite

        mov DI,offset testString ; DI = адрес testString
        mov CX,MaxLen           ; CX = максимальная длина
        call StrRead            ; читать строку с клавиатуры
        call NewLine            ; перейти на новую строку
        call StrWrite           ; вывести строку на дисплей

Exit:
        mov AH,04Ch             ; функция DOS: выход из программы
        mov AL,[exCode]         ; возвратить значение кода выхода
        int 21h                 ; вызов DOS. Останов программы

        END Start               ; конец программы с указанием точки входа
