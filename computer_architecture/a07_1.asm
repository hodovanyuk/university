; �ਬ�� 7.1. �������� 䠩��
text    segment
assume  cs:text, ds:data
begin:  mov AX,data             ; ���樠�����㥬
        mov DS,AX               ; ॣ���� DS
        mov AH,41h              ; �㭪�� 㤠����� 䠩��
        mov DX,offset fname     ; ���� ����� 䠩��
        int 21h                 ; �맮� DOS
        jc error                ; ���室, �᫨ �訡��
        mov AH,09h              ; �뢮� ᮮ�饭��
        mov DX,offset msgok     ; �� 㤠�����
        int 21h                 ; �맮� DOS
fin:    mov AX,4C00h            ; �����襭�� �ணࠬ��
        int 21h                 ; �맮� DOS
error:  mov AH,09h              ; �뢮� ᮮ�饭��
        mov DX,offset msgerr    ; �� �訡��
        int 21h                 ; �맮� DOS
        jmp fin                 ; ���室 �� �����襭��
text    ends

data    segment
fname   db 'd:\testfile.001',0  ; ᯥ�䨪��� 䠩��
msgok   db '���� 㤠���$'
msgerr  db '���� �� ������$'
data    ends

stk     segment stack
        db 256 dup (0)
stk     ends

        end begin
