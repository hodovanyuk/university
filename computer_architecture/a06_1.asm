; ���������, ���������� �� ������
text    segment 'code'                ;(1) ������ �������� ������
        assume  CS:text, DS:data      ;(2) CS->�������, DS->������
begin:  mov  AX, data                 ;(3) ����� �������� ������ ��������
        mov  DS, AX                   ;(4) ������� � AX, ����� � DS
        mov  ES,AX

        push DS                       ;(5) �������� � ���� ���������� DS
        pop  ES                       ;(6) �������� ��� �� ����� � ES

        mov  AH,9                     ;(7) ������� DOS ������ �� �����
        mov  DX, offset message       ;(8) ����� ���������� ���������
        int  21h                      ;(9) ����� DOS
        mov  AX, 4C00h                ;(10) ������� ���������� ���������
        int  21h                      ;(11) ����� DOS
text    ends                          ;(12) ����� �������� ������

data    segment                       ;(13) ������ �������� ������
message db 'Hello, world!!! Remake.$' ;(14) ��������� �����
data    ends                          ;(15) ����� �������� ������

end     begin                         ;(16) ����� ��������� � ������ �����
