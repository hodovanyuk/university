function makeIncidenceSymMatrix(ARG)
% ЅудуЇ симетричну матрицю ≥нцидентностей, в≥дстан≥ м≥ж м≥стами згенерован≥ випадковим чином
% ARG - к≥льк≥сть вузл≥в
% –езультат: симетрична матриц€ ≥нцидентностей, розм≥ру n x n, у глобальн≥й
%            зм≥нн≥й IM

global IM;
IM=rand(ARG);
IM=floor(IM*100)+1;
for i=1:ARG
    for j=i+1:ARG
        IM(i,j)=IM(j,i);
    end
end