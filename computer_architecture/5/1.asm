; �ਬ�� 1.1. ���⥩�� �ணࠬ��
text    segment 'code'                  ;(1) ��砫� ᥣ���� ������
        assume CS: text, DS: text       ;(2) ᥣ����� ॣ����� CS � DS
                                        ;    ���� 㪠�뢠�� �� ᥣ���� ������
begin:  mov AX, text                    ;(3) ���� ᥣ���� ������ ����㧨�
        mov DS, AX                      ;(4) ᭠砫� � AX, ��⥬ � DS
        mov AH, 09h                     ;(5) �㭪�� DOS 9h �뢮�� �� �࠭
        mov DX, offset message          ;(�) ���� �뢮������ ᮮ�饭��
        int 21h                         ;(7) �맮� DOS
        mov AH, 4Ch                     ;(8) �㭪�� 4Ch �����襭�� �ணࠬ��
        mov AL, 00h                     ;(9) ��� 0 �ᯥ譮�� �����襭��
        int 21h                         ;(10) �맮� DOS
message db 'Hello world'   ;(11) �뢮���� ⥪��
text    ends                            ;(12) ����� ᥣ���� ������
        end begin                       ;(13) ����� ⥪�� � �窮� �室�
