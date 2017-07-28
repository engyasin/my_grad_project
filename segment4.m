function [ Sn ] = segment4( pic )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   [YY] : Yasin Yousif 2014/Hims/Syria.


gpic=rgb2gray(pic);
level = graythresh(gpic);
msk=im2bw(gpic,level);
sn1=(pic(:,:,1)>100|pic(:,:,2)>100|pic(:,:,3)>100);
msk=sn1|msk;

% [labeled,~] = bwlabel(msk,8);
% info=regionprops(labeled,'all');
% [~,b]=max(cat(1,info.Area));
% p=info(b).BoundingBox;
[h,w,~]=size(pic);
msk = imclearborder(msk);

msk = bwareaopen(msk, ceil(h*w/100));

% Now remove holes < 1% image area
msk = ~bwareaopen(~msk, ceil(h*w/100));
% p=[166   272   267   170];

% msk=false(h,w);
% msk((p(2):(p(2)+p(4))),(p(1):(p(3)+p(1))))=true(p(4)+1,p(3)+1);
%-----------part1 [YY]--------------------
tic
n1=activecontour(pic(:,:,1),msk,20);
n2=activecontour(pic(:,:,2),msk,20);
n3=activecontour(pic(:,:,3),msk,20);
Sn=n1|n2|n3;
toc

Sn = imclearborder(Sn);

Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
%---------my invinsion---------------[YY]--


clf
imshow(Sn)
pause(3)
close(gcf)

end

