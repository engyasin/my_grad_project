function [ Sn ] = segment2( pic )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   [YY] : Yasin Yousif 2014/Hims/Syria.

figure;

% ha=figure('name','Is that OK? type (dbquit) if not');imshow(ebw)
% keyboard
% close(ha)
imshow(pic);
h=imrect;
p = wait(h);
p=ceil(p);
[h,w,~]=size(pic);
mask=false(h,w);
mask(p(2):(p(2)+p(4)),p(1):(p(3)+p(1)))=true(p(4)+1,p(3)+1);

% bwn=cat(3,mask,mask,mask) & pic;
% here it should be improved by dirct thresholding but to return .. [YY]
Sn=((pic(:,:,1)>17)); % here differ from image to another. [YY]

% keyboard
Sn=Sn&mask;
% Sn=uint8(Sn);

Sn = imclearborder(Sn);

Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
clf
imshow(Sn)
pause(2)
close(gcf)
end

