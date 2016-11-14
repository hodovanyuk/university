
; ���������� ���������� MoveLeft (������ Strings)
; �� �������� MoveRight

.386

text    segment use16
assume  CS:text,DS:data

        ; � ������ STRINGS.OBJ:
        EXTRN MoveLeft:proc, MoveRight:proc
        ; � ������ STRIO.OBJ:
        EXTRN StrWrite:proc

begin:  mov AX,data
        mov DS,AX               ; ����������� ������ �������� �����

        mov SI,offset src       ; ������������ ������ �������
        push DS
        pop ES                  ; ����������� ������ �������� ����� � ES
        mov DI,offset dst1      ; ����������� ������ �����-�����������
        xor BX,BX               ; ������������ BX <- 0
        xor DX,DX               ; ������������ DX <- 0
        mov CX,22               ; ��������� 22 �������
        call MoveLeft           ; ������ ���������� ���������
        call StrWrite           ; ���� ������������ ����� �� �����

        mov DI,offset dst2
        call MoveRight          ; ������ ���������� ���������
        call StrWrite           ; ���� ������������ ����� �� �����

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
dst1    db 100 dup (0)                 ; �����, ���� ���������
src     db 'This is a test string.',0  ; �����, �� ���������
dst2    db 100 dup (0)
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
