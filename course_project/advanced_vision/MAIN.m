
MINAREA = 10;
oldTargets = [];
dirName = 'input';
images = dir([dirName,'/*.jpg']);

Im0 = double(imread([dirName,'/',images(1).name],'jpg'));
Im1 = double(imread([dirName,'/',images(2).name],'jpg'));
Im2 = double(imread([dirName,'/',images(3).name],'jpg'));
Im3 = double(imread([dirName,'/',images(4).name],'jpg'));
Im4 = double(imread([dirName,'/',images(5).name],'jpg'));
Im5 = double(imread([dirName,'/',images(6).name],'jpg'));
Imback = (Im0 + Im1 + Im2 + Im3 + Im4 + Im5)/6;
[MR,MC,Dim] = size(Imback);
MAXSTEP = length(images);
for step = 140:MAXSTEP
    step
    % load image
    fileName = [dirName,'/',images(step).name]; 
    Imwork = double(imread(fileName,'jpg'));
    % cleanup image
    cleanIm = erode(Imwork,Imback);
    % get targets
    labeled = bwlabel(cleanIm,4);
    newTargets = regionprops(labeled,['basic']);
    % compare new targets with old
    newTargets = compareTargets(oldTargets,newTargets);

    if isfield(newTargets, 'Vel')
        newTargets = newTargets([newTargets(:).Vel] > 1);
    end

    plotTargets(1,cleanIm,newTargets,imread(fileName,'jpg'));
    if ~isempty(oldTargets)
       old = struct2table(oldTargets,'AsArray',true)
    else 
       old = 'null'
    end
    if ~isempty(newTargets)
       new = struct2table(newTargets,'AsArray',true)
    else
        new = 'null'
    end
    pause(0.4);
    oldTargets = newTargets;
end


