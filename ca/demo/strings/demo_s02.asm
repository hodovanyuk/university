
; тестування підпрограми StrInsert (модуль Strings)
; та програми MoveRight

.386

text    segment use16
assume  CS:text,DS:data

        ; з модуля STRINGS.OBJ:
        EXTRN StrInsert:proc
        ; з модуля STRIO.OBJ:
        EXTRN StrWrite:proc

begin:  mov AX,data
        mov DS,AX               ; завантажуємо адресу сегмента даних

        mov SI,offset s1        ; завантаження адреси джерела
        push DS
        pop ES                  ; завантажуємо адресу сегмента даних у ES
        mov DI,offset s2        ; завантажуємо адресу рядка-призначення
        mov DX,10
        call StrInsert          ; виклик підпрограми вставки
        call StrWrite           ; друк скопійованого рядка на екрані

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
s1      db 'String for inserting.',0   ; рядок, що вставляється
s2      db 50 dup ('1')                ; рядок, у який вставляється
        db 50 dup (0)
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
