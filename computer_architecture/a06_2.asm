; �ணࠬ�� � �६� ᥣ���⠬�
text    segment 'code'                ;(1) ��砫� ᥣ���� ������
        assume  CS:text, DS:data      ;(2) CS->�������, DS->�����

begin:  mov  AX, data                 ;(3) ���� ᥣ���� ������ ����㧨�
        mov  DS, AX                   ;(4) ᭠砫� � AX, ��⥬ � DS
        push DS                       ;(5) ����㧨� � �⥪ ᮤ�ন��� DS
        pop  ES                       ;(6) ���㧨� ��� �� �⥪� � ES
        mov  AH, 9                    ;(7) �㭪�� DOS �뢮�� �� �࠭
        mov  DX, offset message       ;(8) ���� �뢮������ ᮮ�饭��
        int  21h                      ;(9) �맮� DOS
        mov  AX, 4C00h                ;(10) �㭪�� �����襭�� �ணࠬ��
        int  21h                      ;(11) �맮� DOS
text    ends                          ;(12) ����� ᥣ���� ������

data    segment                       ;(13) ��砫� ᥣ���� ������
message db '��㪠 㬥�� ����� ��⨪$' ;(14) �뢮���� ⥪��
data    ends                          ;(15) ����� ᥣ���� ������

stk     segment stack                 ;(16) ��砫� ᥣ���� �⥪�
dw      128 dup (0)                   ;(17) ��� �⥪ �⢥���� 128 ᫮�
stk     ends                          ;(18) ����� ᥣ���� �⥪�

        end begin                     ;(19) ����� ⥪�� �ணࠬ��
