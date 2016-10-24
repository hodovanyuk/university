; �ਬ�� 13.2. ��⨬���஢����� ��楤�� �८�ࠧ������ ����筮�� �᫠
; � ᨬ������ ���

.386
text    segment use16           ; ��砫� ᥣ���� ������
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
wrd_asc proc                    ;(1)
        pusha                   ;(2) ��࠭�� �� ॣ�����
        mov BX,0F000h           ;(3) � �� �㤥� ��᪠ ��⮢
        mov DL,12               ;(4) � DL �㤥� �᫮ ᤢ���� ��
        mov CX,4                ;(5) ���稪 横��
cccc:   push CX                 ;(6) ��࠭�� ���
        push AX                 ;(7) ��࠭�� ��室��� �᫮ � �⥪�
        and AX,BX               ;(8) �뤥��� �⢥�� ��⮢
        mov CL,DL               ;(9) ��ࠢ�� � CL �᫮ ᤢ����
        shr AX,CL               ;(10) ᤢ���� �� CL ��� ��ࠢ�
        call bin_asc            ;(11) �८�ࠧ㥬 � ᨬ��� ASCII
        mov byte ptr [SI],AL    ;(12) ��ࠢ�� � ��ப� १����
        inc SI                  ;(13) ᤢ������ �� ��ப� ��ࠢ�
        pop AX                  ;(14) ��୥� � �� ��室��� �᫮
        shr BX,4                ;(15) �������㥬 ���� ��⮢
        sub DL,4                ;(16) �������㥬 �᫮ ᤢ����
        pop CX                  ;(18) ����⠭���� ���稪 横��
        loop cccc               ;(19) 横�
        popa                    ;(20) ����⠭���� �� ॣ�����
        ret                     ;(21) ������ �� ����ணࠬ��
wrd_asc endp                    ;(22)

; ����ணࠬ�� �८�ࠧ������ 16-�筮� ����
; �८�ࠧ㥬�� �⢥ઠ ��⮢ � ����襩 �������� AL,
; १���� � AL
bin_asc proc                    ;(39) ��砫� ��楤���
        cmp AL,9                ;(40) ��� > 9
        ja lettr                ;(41) ��, �� �८�ࠧ������ � �㪢�
        add AL,30h              ;(42) ���, �८�ࠧ㥬 � ᨬ��� 0..9
        jmp ok                  ;(43) � �� ��室 �� ����ணࠬ��
lettr:  add AL,37h              ;(44) �८�ࠧ㥬 � ᨬ��� A..F
ok:     ret                     ;(45) ������ � ��뢠���� ��楤���
bin_asc endp                    ;(46) ����� ��楤���

text    ends                    ; ����� ᥣ���� ������

data    segment use16           ; ��砫� ᥣ���� ������
string  db 4 dup ('?'),'h$'     ;(47)
data    ends                    ;(22) ����� ᥣ���� ������

stk     segment stack use16     ;(23) ��砫� ᥣ���� �⥪�
        db 256 dup (0)          ;(24) �⥪
stk     ends                    ;(25) ����� ᥣ���� �⥪�

end begin                       ;(26) ����� ⥪�� �ணࠬ��
