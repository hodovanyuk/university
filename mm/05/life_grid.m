function [display_array] = life_grid(previous)
% [display_array] = life_grid(previous)
%
display_array = zeros(10*size(previous));  % create a larger display array
display_array(1:10:end,:) = 1;   % create grid
display_array(:,1:10:end) = 1;
display_array(end,:) = 1;
display_array(:,end) = 1;

for i = 1:rows(display_array)-1
for j = 1:columns(display_array)-1
       idata = floor((i-1)/10)+1;
       jdata = floor((j-1)/10)+1;
       if(previous(idata, jdata) == 1)
               display_array(i,j) = 1;
       end
end
end

end % end function life_grid