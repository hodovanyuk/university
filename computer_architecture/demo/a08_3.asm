; �ᯮ�짮����� ���७��� ॣ���஢

.386
text    segment use16           ;(1) ��砫� ᥣ���� ������
assume  CS:text,DS:data         ;(2)

begin:  mov AX,data             ;(3) ���樠������ ᥣ���⭮��
        mov DS,AX               ;(4)    ॣ���� DS

; �뢥��� �� �࠭ ����஫��� ��ப� �� ��� ᨬ�����
        mov AH,09h              ;(3)
        mov DX,offset string    ;(4)
        int 21h                 ;(5)

; �࣠���㥬 �ணࠬ���� ����প�
        mov ECX,0FFFFFFFFh      ;(6) ���稪 横��
delay:  db 67h                  ;(7) ��䨪� ࠧ��� ����
        loop delay              ;(8) ����ਬ ������� loop 600 000 ࠧ

; �뢥��� �� �࠭ ����஫��� ��ப� �� ��� ᨬ�����
        mov AH,09h              ;(9)
        mov DX,offset string    ;(10)
        int 21h                 ;(11)

; �����訬 �ணࠬ��
        mov AX,4C00h            ;(12)
        int 21h                 ;(13)
text    ends                    ;(14) ����� ᥣ���� ������

data    segment use16           ;(15) ��砫� ᥣ���� ������
; ���� ������ (� ᥣ���� ������)
string  db '<> $'               ;(16)
data    ends                    ;(17) ����� ᥣ���� ������

stk     segment stack use16     ;(18) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(19) �⥪
stk     ends                    ;(20) ����� ᥣ���� �⥪�

end begin                       ;(21) ����� ⥪�� �ணࠬ��
