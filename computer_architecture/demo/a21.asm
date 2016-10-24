
push3   macro a,b,c
        push a
        push b
        push c
        endm

        push3 AX,BX,CX

stars   macro
local   outpt
        mov CX,10               ; ������� �����
        mov AH,02h              ; ������� ������ �������
        mov DL,'*'              ; ������
outpt:  int 21h                 ; ����� DOS
        loop outpt              ; ���� �� �� �����
        endm

crlf    macro
        mov AH,02h              ; ������� ������ �������
        mov DL,13               ; ��� �������� �������
        int 21h                 ; ����� DOS
        mov DL,10               ; ��� �������� ������
        int 21h                 ; ����� DOS
        endm

stars   macro
local   outpt
        crlf                    ; ��������� ����������
        mov CX,10               ; ������� �����
        mov AH,02h              ; ������� ������ �������
        mov DL,'*'              ; ������
outpt:  int 21h                 ; ����� DOS
        loop outpt              ; ���� �� CX �����
        crlf                    ; ��������� ����������
        endm

; ������ 21.1. ������������� �����������

; ������ ����������������
crlf    macro
        ...                     ; ����� ���������������� crlf
        endm

stars   macro
        ...                     ; ����� ���������������� stars
        endm

; ����� ��������� � �������������
text    segment
        assume CS:text,DS:data
begin:  mov AX,data
        mov DS,AX
        stars                   ; 1-� ����������
        mov AH,09h
        mov DX,offset mesg1
        int 21h
        stars                   ; 2-� ����������
        mov AH,09h
        mov DX,offset mesg2
        int 21h
        mov AX,4C00h
        int 21h
text    ends

data    segment
mesg1   db '������ �������� ������$'
mesg2   db '������ �������� ������$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

end     begin

; ����������� �������
include mymacro.mac
