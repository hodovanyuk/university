%TITLE "�������� ������ ������ � by Tom Swan"

        IDEAL

        MODEL small
        STACK 256

MaxLen  EQU 128                 ; 128-���������� ������
cr      EQU 13                  ; ASCII-������ �������� �������
lf      EQU 10                  ; ASCII-������ ������� ������

        DATASEG

exCode     db 0
welcome    db 'Welcome to Echo-String', cr, lf
           db 'Type any string and press Enter', cr, lf, lf, 0
testString db MaxLen DUP (0), 0  ; MaxLen �������� + 0

        CODESEG

        ; ----- �� STRI0.OBJ:
        EXTRN StrRead:proc, StrWrite:proc, NewLine:proc

Start:
        mov AX,@data            ; ��������� � DS
        mov DS,AX               ; ����� �������� ������
        mov ES,AX               ; ������� DS = ES

        mov DI,offset welcome   ; ������� �����������
        call StrWrite

        mov DI,offset testString ; DI = ����� testString
        mov CX,MaxLen           ; CX = ������������ �����
        call StrRead            ; ������ ������ � ����������
        call NewLine            ; ������� �� ����� ������
        call StrWrite           ; ������� ������ �� �������

Exit:
        mov AH,04Ch             ; ������� DOS: ����� �� ���������
        mov AL,[exCode]         ; ���������� �������� ���� ������
        int 21h                 ; ����� DOS. ������� ���������

        END Start               ; ����� ��������� � ��������� ����� �����
