function makeIncidenceSymMatrix(ARG)
% ���� ���������� ������� ��������������, ������ �� ������ ���������� ���������� �����
% ARG - ������� �����
% ���������: ���������� ������� ��������������, ������ n x n, � ���������
%            ����� IM

global IM;
IM=rand(ARG);
IM=floor(IM*100)+1;
for i=1:ARG
    for j=i+1:ARG
        IM(i,j)=IM(j,i);
    end
end