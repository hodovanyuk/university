; �ਬ�� 14.1. �������᪨� �뢮� �� �࠭ �ࠪ���� ᥣ������ ���ᮢ 

.386
text    segment use16           ; ��砫� ᥣ���� ������
assume  CS:text,DS:data

main    proc
        mov AX,data
        mov DS,AX

; ����稬 ���� ���㦥��� (��室���� �� ����� 2Ch �� ��砫� PSP)
        mov AX,ES:[2Ch]
        mov SI,offset envir+10  ; ᬥ饭�� �ਥ�����
        call wrd_asc            ; �८�ࠧ������ ���� ���㦥��� � ᨬ����

; ����稬 ���� PSP. �� ��室���� � ES
        mov AX,ES
        mov SI,offset psp+10    ; ᬥ饭�� �ਥ�����
        call wrd_asc            ; �८�ࠧ������ ���� PSP � ᨬ����

; ����稬 ���� ᥣ���� ������. �� ��室���� � CS
        mov AX,CS
        mov SI,offset csseg+10  ; ᬥ饭�� �ਥ�����
        call wrd_asc            ; �८�ࠧ������ ���� ᥣ���� ������ � ᨬ����

; �뢥��� ��ନ஢���� ⥪�� �� �࠭
        mov AH,09h
        mov DX,offset envir
        int 21h

; �����訬 �ணࠬ��
        mov AX,4C00h
        int 21h

main    endp

; ����ணࠬ�� �८�ࠧ������ ᫮��
; �� �맮�� �८�ࠧ㥬�� �᫮ � ��,
; DS:SI = ���� ���� ��� १����
wrd_asc proc
        pusha
        mov BX,0F000h
        mov DL,12
        mov CX,4
cccc:   push CX
        push AX
        and AX,BX
        mov CL,DL
        shr AX,CL
        call bin_asc
        mov byte ptr [SI],AL
        inc SI
        pop AX
        shr BX,4
        sub DL,4
        pop CX
        loop cccc
        popa
        ret
wrd_asc endp

; ����ணࠬ�� �८�ࠧ������ 16-�筮� ����
; �८�ࠧ㥬�� �⢥ઠ ��⮢ � ����襩 �������� AL,
; १���� � AL
bin_asc proc
        cmp AL,9
        ja lettr
        add AL,30h
        jmp ok
lettr:  add AL,37h
ok:     ret
bin_asc endp

text    ends

data    segment use16
envir   db 'Environmt=****h',13,10
psp     db 'Prefix   =****h',13,10
csseg   db 'Program  =****h',13,10,'$'
data    ends

stk     segment stack use16
        db 256 dup (0)
stk     ends

end     main
