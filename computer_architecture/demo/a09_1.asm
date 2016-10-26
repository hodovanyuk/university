; �ਬ�� 9.1. �뢮� �� ��࠭ ����᪮�� ����ࠦ���� � ������� ���뢠��� BIOS 10h

text    segment                 ;(1) ��砫� ᥣ���� ������
assume  CS:text                 ;(2)

begin:  
; ��⠭���� ����᪨� �����०��
        mov AH,0h               ;(1) �㭪�� ��⠭���� �����०���
        mov AL,10h              ;(2) ����᪨� ०�� 16 梥⮢
        int 10h                 ;(3) �맮� BIOS
; �뢥��� �� ��࠭ ����� ��אַ㣮�쭨�
        mov AH,0Ch              ;(4) �㭪�� �뢮�� ���ᥫ�
        mov AL,0Eh              ;(5) ����� 梥�
        mov BH,0                ;(6) �������࠭��
        mov CX,50               ;(7) ��砫쭠� �-���न���
c2:     mov DX,10               ;(8) ��砫쭠� �-���न���
c1:     int 10h                 ;(9) �맮� BIOS - �뢮� �窨
        inc DX                  ;(10) ���६��� �� �
        cmp DX,330              ;(11) ��諨 �� �࠭��� �� �?
        jne c1                  ;(12) ���, �����塞 �뢮� �祪
        inc CX                  ;(13) ��諨 �� �࠭��� �� �, ���६��� �� �
        cmp CX,610              ;(14) ��諨 �� �࠭��� �� �?
        jne c2                  ;(15) ���, �����塞 �뢮� ���⨪����� �����

; ��⠭���� �ணࠬ�� ��� ������� १����
        mov AH,01h              ;(16) ��諨 �� �࠭��� �� �, ��⠭��
        int 21h                 ;(17) �㭪樥� ����� ᨬ���� � ����������

; ��ॢ���� ��⥬� ����� � ⥪�⮢� ०��
        mov AX,3                ;(18) ����⠭���� ⥪�⮢�
        int 10h                 ;(19) �����०��

; �����訬 �ணࠬ��
        mov AX,4C00h            ;(20)
        int 21h                 ;(21)

text    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack           ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��