; �ਬ�� 5.1. �ணࠬ��, �뢮���� �� �࠭ ���� ���᪠ ��� BIOS
text    segment 'code'      ;(1) ��砫� ᥣ���� ������
        assume CS:text      ;(2) ॣ���� CS �㤥� 㪠�뢠�� �� ᥣ���� text
begin:  mov AX,0F000h       ;(3) ᥣ����� ���� ��� BIOS
        mov DS,AX           ;(4) ����ᥬ ��� � DS
        mov AH,40h          ;(5) �㭪�� DOS �뢮�� �� �࠭
        mov BX,1            ;(6) ���ਯ�� �࠭�
        mov CX,8            ;(7) �뢥��� 8 ᨬ�����
        mov DX,0FFF5h       ;(8) ᬥ饭�� � �뢮����� ��ப�
        int 21h             ;(9) �맮� DOS
        mov AX,4C00h        ;(10) �㭪�� 4Ch � ��� �����襭�� 0
        int 21h             ;(11) �맮� DOS
text    ends                ;(12) ����� ᥣ���� ������
stk     segment             ;(13) ��砫� ᥣ���� �⥪�
        db 256 dup (0)      ;(14) �⥪
stk     ends                ;(15) ����� ᥣ���� �⥪�
        end begin           ;(16) ����� ⥪�� � �窮� �室�
