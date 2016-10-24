; Пошук n-го числа Фібоначчі

.386
text    segment use16
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        mov AX,14

        cmp AX,2
        jle fibo1
        
        mov CX,AX
        dec CX
        dec CX
        mov AX,1
        mov BX,1
continue:
        add AX,BX
        xchg AX,BX
        loop continue
        mov DX,BX
        jmp finish
fibo1:
        mov DX,1
finish:
        mov AX,DX               ; зберігаємо результат у акумуляторі
        mov DI,offset num       ; знаходимо значення зсуву рядка

        call convert

        mov AH,09h 
        mov DX,offset fibo
        int 21h

        mov AX,4C00h
        int 21h

convert proc
        pusha

        mov SI,offset tmp
        cmp AX,0
        jz zeroAX
        
        push DI
continue2:
        xor DX,DX
        div [ base ]
        mov DI,DX
        mov BL,abc[DI]
        mov byte ptr [SI],BL
        inc SI
        cmp AX,0
        jnz continue2
        pop DI

continue3:
        dec SI
        mov BL,byte ptr [SI]
        cmp BL,'F'
        jz theEnd
        mov byte ptr [DI],BL
        inc DI
        jmp continue3

zeroAX:
        mov BL,'0'
        mov byte ptr [DI],BL
theEnd:
        popa
        ret
convert endp

text    ends

data    segment use16
fibo    db 'Fibo: '
num     db '     $'
abc     db '0123456789ABCDEF'
tmp     db 5 dup (?)
base    dw 10
data    ends

stk     segment stack use16     ;(18) начало сегмента стека
        db 256 dup (0)          ;(19) стек
stk     ends                    ;(20) конец сегмента стека

end begin                       ;(21) конец текста программы
