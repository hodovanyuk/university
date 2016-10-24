; ����� n-�� ����� Գ�������

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
        mov AX,DX               ; �������� ��������� � ����������
        mov DI,offset num       ; ��������� �������� ����� �����

        mov BX,0F000h           ; ��������� �����
        mov CX,4                ; ������� �������� �����
        mov DX,12               ; ���������� ���� �������� �����������
        push AX                 ; �������� ��������� �����

continue2:
        pop AX                  ; ������ �������� ��� �������
        push AX                 ; �������� ��� ���������� ������������
        push CX
        and AX,BX               ; �������� ������� ������� ���
        mov CX,DX
        shr AX,CL               ; ������� ����� ������ �� �������� ���
        mov CX,4                ; ������� ����� ������ �� 4 ���
        shr BX,CL
        sub DX,4                ; ��������� ��� ���� �� 4 ������
        mov SI,AX               ; �������� ������ � ������ SI
        push BX
        mov BL,abc[SI]          ; ������ ������, �� ������� ����
        mov [DI],BL             ; �������� ������ � �����
        pop BX
        inc DI                  ; ���������� �� ���������� ���� �������
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

stk     segment stack use16     ;(18) ������ �������� �����
        db 256 dup (0)          ;(19) ����
stk     ends                    ;(20) ����� �������� �����

end begin                       ;(21) ����� ������ ���������
