; ������ 1.1. ���������� ���������
text    segment 'code'                  ;(1) ������ �������� ������
        assume CS: text, DS: text       ;(2) ���������� �������� CS � DS
                                        ;    ����� ��������� �� ������� ������
begin:  mov AX, text                    ;(3) ����� �������� ������ ��������
        jmp continue

message1 db 'Hello world!!!',10,13,'$'  ;(11) ��������� �����
message2 db '123456mmmnnnppp$'

;CR (caret)
;LF (line feed)

continue:
        mov DS, AX                      ;(4) ������� � AX, ����� � DS
        mov AH, 09h                     ;(5) ������� DOS 9h ������ �� �����
        mov DX, offset message1          ;(�) ����� ���������� ���������
        int 21h                         ;(7) ����� DOS
        mov AH, 09h                     ;(5) ������� DOS 9h ������ �� �����
        mov DX, offset message2          ;(�) ����� ���������� ���������
        int 21h                         ;(7) ����� DOS
        mov AH, 4Ch                     ;(8) ������� 4Ch ���������� ���������
        mov AL, 00h                     ;(9) ��� 0 ��������� ����������
        int 21h                         ;(10) ����� DOS

text    ends                            ;(12) ����� �������� ������

        end begin                       ;(13) ����� ������ � ������ �����

db -> define byte(s)

AX BX CX DX
CS (code segment)
DS (data segment)
ES (additional data segment)
SS (stack segment)

PSP Program segment prefix

mov (move)
mov ����, ��i���
mov AX,0
mov AX,BX
mov AH,AL
AX
F   F    F   F
11111111 11111111
AH       AL

AX = FFFF
     AH AL

mov AH,0
AX = 00FF

mov AL,10
AX = 000A

mov DX,offset message
mov AH,09h
int 21h
