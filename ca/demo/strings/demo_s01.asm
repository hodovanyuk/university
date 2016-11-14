
; тестування підпрограми MoveLeft (модуль Strings)
; та програми MoveRight

.386

text    segment use16
assume  CS:text,DS:data

        ; з модуля STRINGS.OBJ:
        EXTRN MoveLeft:proc, MoveRight:proc
        ; з модуля STRIO.OBJ:
        EXTRN StrWrite:proc

begin:  mov AX,data
        mov DS,AX               ; завантажуємо адресу сегмента даних

        mov SI,offset src       ; завантаження адреси джерела
        push DS
        pop ES                  ; завантажуємо адресу сегмента даних у ES
        mov DI,offset dst1      ; завантажуємо адресу рядка-призначення
        xor BX,BX               ; встановлення BX <- 0
        xor DX,DX               ; встановлення DX <- 0
        mov CX,22               ; копіюється 22 символи
        call MoveLeft           ; виклик підпрограми копіювання
        call StrWrite           ; друк скопійованого рядка на екрані

        mov DI,offset dst2
        call MoveRight          ; виклик підпрограми копіювання
        call StrWrite           ; друк скопійованого рядка на екрані

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
dst1    db 100 dup (0)                 ; рядок, куди копіюється
src     db 'This is a test string.',0  ; рядок, що копіюється
dst2    db 100 dup (0)
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
