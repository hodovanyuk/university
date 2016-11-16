clc;clear all;close all;
% init
N = 30;
old = zeros(N,N);
T = 300;
fiaa = -2e-20;
fibb = -3e-20;
% uporyadivachinie
fiab = -4e-20;
% raspad
% fiab = 4e-20;
k = 1.3806504e-23;
% analitichna funkcia
ffi = @(i1, j1, i2, j2) (1/4)*((1+(old(i1,j1)/...
    (abs(old(i1,j1)))))*(old(i1,j1) + old(i2,j2))*fiaa - ...
    ((1-(old(i1,j1)/(abs(old(i1,j1)))))*(old(i1,j1) + ...
    old(i2,j2))*fibb) + 2*(old(i1,j1)-old(i2,j2)*(old(i1,j1)/...
    (abs(old(i1,j1))))*fiab));
% dobavlyam atomi dvuh grup
% for i=1:N
%     for j=1:N
%         if rand>0.5
%             old(i,j) = 1;
%         else
%             old(i,j) = -1;
%         end
%     end
% end
c = round(N / c);
imh = image(cat(3,(old==0),(old<0),(old>0)));
pause(.5);
while true
% for step =1:5000


    ai = round(((N-1)*rand+1));
    aj = round(((N-1)*rand+1));

    aiup = [ (ai-1<1)*N+(ai>=1)*(ai-1) aj ];
    airight = [ ai (aj+1>N)+(aj+1<=N)*(aj+1)];
    aidown = [ (ai+1>N)+(ai+1<=N)*(ai+1) aj ];
    aileft = [ ai (aj-1<1)*N+(aj>=1)*(aj-1) ];
    a_new_idx = [ aiup; airight; aidown; aileft ];
    rand_idx =  round((4-1)*rand+1);

    bi = a_new_idx(rand_idx,1);
    bj = a_new_idx(rand_idx,2);

    biup = [ (bi-1<1)*N+(bi>=1)*(bi-1) bj ];
    biright = [ bi (bj+1>N)+(bj+1<=N)*(bj+1)];
    bidown = [ (bi+1>N)+(bi+1<=N)*(bi+1) bj ];
    bileft = [ bi (bj-1<1)*N+(bj>=1)*(bj-1) ];

    % if a~=b 
    if old(ai,aj) ~= old(bi,bj);
        e1 = ffi(ai,aj,airight(1),airight(2)) + ffi(ai,aj,aidown(1),aidown(2))+...
            ffi(ai,aj,aileft(1),aileft(2)) + ffi(ai,aj,aiup(1),aiup(2)) + ...
            ffi(bi,bj,biright(1),biright(2)) + ffi(bi,bj,bidown(1),bidown(2))+...
            ffi(bi,bj,bileft(1),bileft(2)) + ffi(bi,bj,biup(1),biup(2));
        % swap
        old(ai,aj) = old(ai,aj)*(-1);
        old(bi,bj) = old(bi,bj)*(-1);
        e2 = ffi(ai,aj,airight(1),airight(2)) + ffi(ai,aj,aidown(1),aidown(2))+...
            ffi(ai,aj,aileft(1),aileft(2)) + ffi(ai,aj,aiup(1),aiup(2)) + ...
            ffi(bi,bj,biright(1),biright(2)) + ffi(bi,bj,bidown(1),bidown(2))+...
            ffi(bi,bj,bileft(1),bileft(2)) + ffi(bi,bj,biup(1),biup(2));
        delta_e = e2-e1; 
        if delta_e>0 && rand>=exp(delta_e/(k*T))
            old(ai,aj) = old(ai,aj)*(-1);
            old(bi,bj) = old(bi,bj)*(-1);
        end
    end
    set(imh,'cdata',cat(3,(old==0),(old<0),(old>0)))
    drawnow
    pause(.00001);

end
% set(imh,'cdata',cat(3,(old==0),(old<0),(old>0)))
% drawnow
