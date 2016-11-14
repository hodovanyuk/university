
; ���������� ���������� StrInsert (������ Strings)
; �� �������� MoveRight

.386

text    segment use16
assume  CS:text,DS:data

        ; � ������ STRINGS.OBJ:
        EXTRN StrInsert:proc
        ; � ������ STRIO.OBJ:
        EXTRN StrWrite:proc

begin:  mov AX,data
        mov DS,AX               ; ����������� ������ �������� �����

        mov SI,offset s1        ; ������������ ������ �������
        push DS
        pop ES                  ; ����������� ������ �������� ����� � ES
        mov DI,offset s2        ; ����������� ������ �����-�����������
        mov DX,10
        call StrInsert          ; ������ ���������� �������
        call StrWrite           ; ���� ������������ ����� �� �����

        mov AX,4C00h
        int 21h

text    ends

data    segment use16
s1      db 'String for inserting.',0   ; �����, �� ������������
s2      db 50 dup ('1')                ; �����, � ���� ������������
        db 50 dup (0)
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end begin
