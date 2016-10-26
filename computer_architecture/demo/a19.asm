
; ������ 19.1. �������������� ����������� �������-���������� �����
; � ���������� �����

.386                            ; ����� �������������� ������� �� 80386
        mov AH,02h              ; ������� ������ �������
        int 1Ah                 ; ���������� BIOS
        mov AL,CH               ; ������� � AL ����
        call bcd_asc            ; ����������� � �������
        mov word ptr time,AX    ; ������� � ������
        mov AL,CL               ; ������� � AL ������
        call bcd_asc            ; ����������� � �������
        mov word ptr time+3,AX  ; ������� � ������
        mov AL,DH               ; ������� � AL �������
        call bcd_asc            ; ����������� � �������
        mov word ptr time+6,AX  ; ������� � ������
        mov AH,09h              ; ������� ������ �� �����
        mov DX,offset clock     ; �������� ������
        int 21h                 ; ����� DOS

; ������������ �������������� ������������ BCD-����� � �������
; - �� ����� BCD � AL
; - �� ������ ������� � ��
bcd_asc proc
        mov AH,AL               ;(1) ������� ����� � � ��
        and AH,0Fh              ;(2) ������� � �� ������� �����
        add AH,'0'              ;(3) ����������� � ASCII
        and AL,0F0h             ;(4) ������� � AL ������� �����
        shr AL,4                ;(5) ����� � ������ ��������. ������� 80386!
        add AL,'0'              ;(6) ����������� � ASCII
        ret                     ;(7)
bcd_asc endp 

; � ����� ������
clock   db '������� ����� '
time    db 0,0,':',0,0,':',0,0,'$'
