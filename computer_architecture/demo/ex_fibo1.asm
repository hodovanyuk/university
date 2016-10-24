; Пошук n-го числа Фібоначчі

.386
text    segment use16
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        mov AX,0Ah

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

        mov BX,0F000h           ; початкова маска
        mov CX,4                ; кількість ітерацій циклу
        mov DX,12               ; початковий зсув значення конвертації
        push AX                 ; зберігаємо початкове число

continue2:
        pop AX                  ; дістаємо значення для обробки
        push AX                 ; зберігаємо для наступного використання
        push CX
        and AX,BX               ; виділяємо потрібну четвірку бітів
        mov CX,DX
        shr AX,CL               ; зсуваємо число вправо до молодших бітів
        mov CX,4                ; зсуваємо маску вправо на 4 біти
        shr BX,CL
        sub DX,4                ; наступний раз зсув на 4 менший
        mov SI,AX               ; зберігаємо індекс в регістр SI
        push BX
        mov BL,abc[SI]          ; читаємо символ, що відповідає цифрі
        mov [DI],BL             ; зберігаємо символ у рядок
        pop BX
        inc DI                  ; переходимо до наступного місця символа
        pop CX
        loop continue2
        
        mov AH,09h 
        mov DX,offset fibo
        int 21h

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
fibo    db 'Fibo: '
num     db '****h$'
abc     db '0123456789ABCDEF'
data    ends

stk     segment stack use16     ;(18) начало сегмента стека
        db 256 dup (0)          ;(19) стек
stk     ends                    ;(20) конец сегмента стека

end begin                       ;(21) конец текста программы
