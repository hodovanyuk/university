; Пример 14.1. Динамический вывод на экран характерных сегментных адресов 

.386
text    segment use16           ; начало сегмента команд
assume  CS:text,DS:data

main    proc
        mov AX,data
        mov DS,AX

; получим адрес окружения (находится по адресу 2Ch от начала PSP)
        mov AX,ES:[2Ch]
        mov SI,offset envir+10  ; смещение приемника
        call wrd_asc            ; преобразование адреса окружения в символы

; получим адрес PSP. Он находится в ES
        mov AX,ES
        mov SI,offset psp+10    ; смещение приемника
        call wrd_asc            ; преобразование адреса PSP в символы

; получим адрес сегмента команд. Он находится в CS
        mov AX,CS
        mov SI,offset csseg+10  ; смещение приемника
        call wrd_asc            ; преобразование адреса сегмента команд в символы

; выведем сформированный текст на экран
        mov AH,09h
        mov DX,offset envir
        int 21h

; завершим программу
        mov AX,4C00h
        int 21h

main    endp

; подпрограмма преобразования слова
; при вызове преобразуемое число в АХ,
; DS:SI = адрес поля для результата
wrd_asc proc
        pusha
        mov BX,0F000h
        mov DL,12
        mov CX,4
cccc:   push CX
        push AX
        and AX,BX
        mov CL,DL
        shr AX,CL
        call bin_asc
        mov byte ptr [SI],AL
        inc SI
        pop AX
        shr BX,4
        sub DL,4
        pop CX
        loop cccc
        popa
        ret
wrd_asc endp

; подпрограмма преобразования 16-ричной цифры
; преобразуемая четверка битов в младшей половине AL,
; результат в AL
bin_asc proc
        cmp AL,9
        ja lettr
        add AL,30h
        jmp ok
lettr:  add AL,37h
ok:     ret
bin_asc endp

text    ends

data    segment use16
envir   db 'Environmt=****h',13,10
psp     db 'Prefix   =****h',13,10
csseg   db 'Program  =****h',13,10,'$'
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end     main
