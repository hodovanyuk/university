; �ਬ�� 10.1. ���� ���ᨬ��쭮�� ���祭��

text    segment                 ; ��砫� ᥣ���� ������
assume  CS:text,DS:data         ;

begin:  mov AX,data             ; ���樠������ ᥣ���⭮��
        mov DS,AX               ;    ॣ���� DS

        mov DL,mas              ;(1) DL = ���� ����� ���ᨢ�
        mov CX,8                ;(2) �� = �᫮ ����⮢ ����� ���� (����)
        mov BX,1                ;(3) �� = ������ ��ண� �����
cont:   cmp DL,mas[BX]          ;(4) DL > ᫥���饣� �����?
        jg next                 ;(5) ��, �� ������ ᫥���饣�
        mov DL,mas[BX]          ;(6) ���, � DL ����ᨬ ᫥���騩 �����
next:   inc BX                  ;(7) � �� ������ ᫥���饣�
        loop cont               ;(8) 横� �� ���� ���ᨢ�
; ��᫥ �����襭�� 横�� � DL ��室���� ���ᨬ���� �����

        mov AX,4C00h            ; �맮� �㭪樨 4Ch DOS
        int 21h

text    ends                    ; ����� ᥣ���� ������

data    segment                 ; ��砫� ᥣ���� ������
mas     db 1,2,5,30,127,9,8,3,4 ;(11) ���ᨢ � ��室�묨 ����묨
data    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack           ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��
