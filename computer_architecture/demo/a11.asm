; �ਬ�� 11.1. �뢮� �� �࠭ ⥪�� � ��ࠬ�����

text    segment
assume  CS:text,DS:data

begin:  mov AX,data
        mov DS,AX

        mov AH,09h
        mov DX,offset msg
        int 21h

        mov AX,4C00h
        int 21h

text    ends

data    segment
msg     db 10*80 dup (20h)      ; �ப��⪠ 10 ��ப �࠭�
; �뢮� ��� ��ப (�஡���, ��ࠬ�����, ⥪��, �஡���)
        db 35 dup (20h),0C9h,9 dup (0CDh),03Bh,34 dup (20h)
        db 35 dup (20h),0BAh,10h,'�������',11h,0BAh,34 dup (20h)
        db 35 dup (20h),0C8h,9 dup (0CDh),0BCh,34 dup (20h)
        db 11*80 dup (20h)      ; �ப��⪠ �� 11 ��ப �࠭�
        db '$'                  ; �������騩 ���� ������ ��� �㭪樨 09h
data    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack           ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��
