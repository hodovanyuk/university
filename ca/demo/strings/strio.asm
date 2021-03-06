%TITLE "��������� �����-������ ����� � by Tom Swan"

        IDEAL

        MODEL small

;-----����������������

BufSize EQU 255                 ; ������������ ������ ������ (<=255)
ASCnull EQU 0                   ; ASCII ����
ASCcr   EQU 13                  ; ASCII-������ �������� �������
ASClf   EQU 10                  ; ASCII-������ ������� ������

;----- ��������� ������ ��� DOS ������� 0�h
STRUC   StrBuffer
maxlen  db BufSize              ; ������������ ����� ������
strlen  db 0                    ; ����� ������
chars   db BufSize DUP (?)      ; ����� ��� StrRead
ENDS    StrBuffer

        DATASEG

buffer  StrBuffer <>            ; ���������� ������ ��� ReadStr

        CODESEG

; ----- ��: STRINGS.OBJ

        EXTRN StrLength:proc, StrCopy:proc

        PUBLIC StrRead, StrWrite, StrWrite2, NewLine

; ------------------------------------------------------------------
; StrRead ������ ������ � ���������������
; ����:
; DI = ����� ������ ����������
; CL = ������������ ����� ������, ������� ������� ������������
; ���������: ���� CL = 0, StrRead ������ �� ������
; ���������: ���������� ������ ������ ����� ����� CL+1 ����
; ���������: ����� ������ ���������� 255 ���������
; �����:
; ������, ������������� �� ������������ ���������� ����� � ��� �����
; ��������:
; �� ������������
; ------------------------------------------------------------------
PROC    StrRead
        or CL,CL                ; CL = �?
        jz @@99                 ; e��� ��, ������� �� exit

        push AX                 ; ��������� ���������� ��������
        push BX
        push DX
        push SI

        mov [buffer.maxlen],CL  ; ���������� ���� maxlen
        mov AH,0Ah              ; ������� DOS ������ �� ������
        mov DX,offset buffer.maxlen   ; ��������� ����� struc � DS:DX
        int 21h                 ; ����� DOS ��� ������ ������
        xor BH,BH               ; �������� ������� ���� BX
        mov BL,[buffer.strlen]  ; BX = # chars � ������
        mov [BX+buffer.chars],ASCnull ; �������� cr �� null
        mov SI,offset buffer.chars    ; ��������� ����� ������ � SI
        call StrCopy            ; ����������� chars � ������ ������������
        pop SI                  ; ������������ ��������
        pop DX
        pop BX
        pop AX
@@99:
        ret                     ; ������� � ���������� ���������
ENDP    StrRead

; ------------------------------------------------------------------
; StrWrite/StrWrite2 �������� ������ �� ����������� ���������� ������ ; ����:
; DI = ����� ������ (s)
; CX = ���������� ������������ �������� (������ ��� StrWrite2)
; �����:
; ������ s ���������� �� ����������� ���������� ������
; ��������:
; CX (������ ��� StrWrite)
; ------------------------------------------------------------------
PROC    StrWrite
        call StrLength          ; ���������� CX = ����� ������

PROC    StrWrite2               ; ���������� ����� �����
        push AX                 ; ��������� ���������� ��������
        push BX
        push DX

        mov BX,1                ; ����������� ���������� ������
        mov DX,di               ; ������ ���������� � DS:DX
        mov AH,40h              ; DOS ������ � ���� ��� �� ����������
        int 21h                 ; ����� DOS (on ret AX=# chars written)

        pop DX                  ; ������������ ��������
        pop BX
        pop AX
        ret                     ; ������� � ���������� ���������
ENDP    StrWrite2               ; ����� ������������� ���������
ENDP    StrWrite                ; ����� ������� ���������

; ------------------------------------------------------------------
; NewLme ������� �� ����� ������ �� ����������� ���������� ������
; ����:
; ���
; �����:
; �� ���������� ������ ���������� ������ �������� �������
;    � ������� ������
; ��������:
; AH, DL
; ------------------------------------------------------------------
PROC    NewLine
        mov AH,2                ; ������� ������ ������� DOS
        mov DL,ASCcr            ; ��������� � DL ������ �������� �������
        int 21h                 ; ������� ������ �������� �������
        mov DL,ASClf            ; ��������� � DL ������ ������� ������
        int 21h                 ; ������� ������ ������� ������
        ret                     ; ������� � ���������� ���������
ENDP    NewLine

        END                     ; ����� ������ STRI�
