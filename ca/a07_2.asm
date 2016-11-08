; �ਬ�� 7.2. �������� 䠩�� � �������� ��������� ��⥬��� ᡮ��
text    segment
assume  cs:text,ds:data
begin:  mov AX,data
        mov DS,AX
        mov AH,41h
        mov DX,offset fname
        int 21h
        jc error            ; ���室, �᫨ �訡��
        mov AH,09h          ; �뢮� ᮮ�饭��
        mov DX,offset msgok ; �� 㤠�����
        int 21h
fin:    mov AX,4C00h        ; �����襭�� �ணࠬ��
        int 21h
; ���� ������� �訡��
error:  cmp AX,02h          ; 䠩� �� ������?
        je notfound         ; ��, �뢥�� ᮮ�饭��
        cmp AX,03h          ; ���� �� ������?
        je wrongdir         ; ��, �뢥�� ᮮ�饭��
        cmp AX,05h          ; ����� ����饭?
        je noaccess         ; ��, �뢥�� ᮮ�饭��
        jmp fin
; ���� �뢮�� ᮮ�饭��
notfound:  
        mov DX,offset msg1
        jmp write
wrongdir:
        mov DX,offset msg2
        jmp write
noaccess:
        mov DX,offset msg3
write:  mov AH,09h
        int 21h
        jmp fin
text    ends

data    segment
fname   db 'd:\testfile.001',0
msgok   db '���� 㤠���$'
msg1    db '���� �� ������$'
msg2    db '��⠫�� ����७$'
msg3    db '����� ����饭$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

        end begin
