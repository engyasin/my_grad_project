function [ Sn ] = segmenttest1( pic )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[h,w,~]=size(pic);

S1=pic(:,:,3)>pic(:,:,1)+15;
S2=pic(:,:,1)>pic(:,:,3)+1;
Sn=S1&S2;
Sn = imclearborder(Sn);
if sum(sum(Sn))<ceil(h*w/10)
    Sn=S1&S2;
end
Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
end

 

