; �ਬ�� 13.1. �८�ࠧ������ ����筮�� �᫠ � 16-���� ᨬ������ ���

text    segment                 ; ��砫� ᥣ���� ������
assume  CS:text,DS:data

begin:  mov AX,data             ; ���樠������ ᥣ���⭮��
        mov DS,AX               ;    ॣ���� DS

        mov AX,16385            ;(1) �८�ࠧ㥬�� �᫮
        mov SI,offset string    ;(2) ���� १����
        call wrd_asc            ;(3) �맮� ����ணࠬ�� wrd_asc

        mov AH,09h              ;(4) �㭪�� �뢮�� �� �࠭
        mov DX,offset string    ;(5)
        int 21h                 ;(6) �맮� DOS

; �����訬 �ணࠬ��
        mov AX,4C00h
        int 21h

; ����ணࠬ�� �८�ࠧ������ ᫮��
; �� �맮�� �८�ࠧ㥬�� �᫮ � ��,
; DS:SI = ���� ���� ��� १����
wrd_asc proc                    ;(7) ��砫� ��楤���
        push AX                 ;(8) ��࠭�� ��室��� �᫮ � �⥪�
        and AX,0F000h           ;(9) �뤥��� �⢥�� ��⮢
        mov CL,12               ;(10) ᤢ���� �� �� 12 ���
        shr AX,CL               ;(11)    � ��砫� AL
        call bin_asc            ;(12) �८�ࠧ㥬 � ᨬ��� ASCII
        mov byte ptr [SI],AL    ;(13) ��ࠢ�� � ��ப� १����
        pop AX                  ;(14) ��୥� ��室��� �᫮
        push AX                 ;(15) � ��࠭�� ��� ᭮��
        and AX,0F00h            ;(16) �뤥��� �⢥�� ��⮢
        mov CL,8                ;(17) ᤢ���� �� �� 8 ���
        shr AX,CL               ;(18)    � ��砫� AL
        inc SI                  ;(19) ᤢ������ �� ��ப� १����
        call bin_asc            ;(20) �८�ࠧ㥬 � ᨬ��� ASCII
        mov byte ptr [SI],AL    ;(21) ��ࠢ�� � ��ப� १����
        pop AX                  ;(22) ��୥� ��室��� �᫮
        push AX                 ;(23) � ��࠭�� ��� ᭮��
        and AX,0F0h             ;(24) �뤥��� �⢥�� ��⮢
        mov CL,4                ;(25) ᤢ���� �� �� 4 ���
        shr AX,CL               ;(26)    � ��砫� AL
        inc SI                  ;(27) ᤢ������ �� ��ப� १����
        call bin_asc            ;(28) �८�ࠧ㥬 � ᨬ��� ASCII
        mov byte ptr [SI],AL    ;(29) ��ࠢ�� � ��ப� १����
        pop AX                  ;(30) ��୥� ��室��� �᫮
        push AX                 ;(31) � ��࠭�� ��� ᭮��
        and AX,0Fh              ;(32) �뤥��� �⢥�� ��⮢
        inc SI                  ;(33) ᤢ������ �� ��ப� १����
        call bin_asc            ;(34) �८�ࠧ㥬 � ᨬ��� ASCII
        mov	byte ptr [SI],AL    ;(35) ��ࠢ�� � ��ப� १����
        pop AX                  ;(36) ����⠭���� �� � �⥪
        ret                     ;(37) ������ � ��뢠���� ��楤���
wrd_asc endp                    ;(38) ����� ��楤���

; ����ணࠬ�� �८�ࠧ������ 16-�筮� ����
; �८�ࠧ㥬�� �⢥ઠ ��⮢ � ����襩 �������� AL,
; १���� � AL
bin_asc proc                    ;(39) ��砫� ��楤���
        cmp	AL,9                ;(40) ��� > 9
        ja lettr                ;(41) ��, �� �८�ࠧ������ � �㪢�
        add	AL,30h              ;(42) ���, �८�ࠧ㥬 � ᨬ��� 0..9
        jmp ok                  ;(43) � �� ��室 �� ����ணࠬ��
lettr:  add AL,37h              ;(44) �८�ࠧ㥬 � ᨬ��� A..F
ok:     ret                     ;(45) ������ � ��뢠���� ��楤���
bin_asc endp                    ;(46) ����� ��楤���

text    ends                    ; ����� ᥣ���� ������

data    segment                 ; ��砫� ᥣ���� ������
string  db 4 dup ('?'),'h$'     ;(47)
data    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack           ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��
