function makeIncidenceMatrix(ARG)
% ���� ������� ��������������, ������� �� ������ ����������� ���������� �����
% ARG - ������� �����
% ���������: ������� ��������������, ������ n x n, � ���������� ������ IM

global IM;
IM=rand(ARG);
IM=floor(IM*100);
