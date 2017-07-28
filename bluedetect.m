function [ Sn ] = bluedetect( pic )
% A func 4 3d scanner..
%   Done .. [YY]2015.
[h,w,~]=size(pic);
S1 = pic(:,:,1) < (pic(:,:,3)-9);
S2 = pic(:,:,2) < (pic(:,:,3)-2);
Sn=~(S1&S2);
Sn = imclearborder(Sn);

Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
end

