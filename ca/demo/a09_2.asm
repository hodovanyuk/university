; �ਬ�� 9.2. �⥭�� � ��࠭���� � 䠩�� �������� �����稪� ���⪮�� ��᪠

text    segment                 ;( ) ��砫� ᥣ���� ������
assume  CS:text,DS:data         ;( )

begin:  mov AX,data             ;( ) ���樠������ ᥣ���⭮��
        mov DS,AX               ;( )    ॣ���� DS

; �⥭�� �������� �����稪�
        mov AH,02h              ;(1) �㭪�� �⥭�� ᥪ�஢
        mov AL,1                ;(2) ���⠥� 1 ᥪ��
        mov CH,0                ;(3) ����� 樫����
        mov CL,1                ;(4) ����� ᥪ��
        mov DH,0                ;(5) ����� �����孮��
        mov DL,80h              ;(6) ��� ���⪮�� ��᪠
        mov BX,offset mboot     ;( ) ���� ��� ���⠭����
        int 13h                 ;(7) ���室 � BIOS

; ᮧ����� 䠩� ��� ��࠭���� ���⠭����
        mov AH,3Ch              ;(8) �㭪�� (DOS) ᮧ����� 䠩��
        mov CX,0                ;(9) 䠩� �㤥� ��� ��ਡ�⮢
        mov DX,offset fname     ;(10) ᬥ饭�� ����� 䠩��
        int 21h                 ;(11) ���室 � DOS
        mov BX,AX               ;(12) ��࠭�� � �� ���ਯ�� 䠩��

; ����襬 � 䠩� ����� �� ���� mboot
        mov AH,40h              ;(13) �㭪�� ����� � 䠩�
        mov CX,512              ;(14) �᫮ �뢮����� ���⮢
        mov DX,offset mboot     ;(15) ᬥ饭�� ����
        int 21h                 ;(16) ���室 � DOS

; �����訬 �ணࠬ��
        mov AX,4C00h            ;( )
        int 21h                 ;( )
text    ends                    ;( ) ����� ᥣ���� ������

data    segment                 ;( ) ��砫� ᥣ���� ������
; ���� ������ (� ᥣ���� ������)
mboot   db 512 dup(0)           ;(17)
fname   db 'mboot.dat',0        ;(18)
data    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack           ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��
