function [ Sn ] = segment3( pic,msk )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   [YY] : Yasin Yousif 2014/Hims/Syria.

% mask=roipoly(pic); % OR:

% p=[166   272   267   170];
[h,w,~]=size(pic);
% mask=false(h,w);
% mask(p(2):(p(2)+p(4)),p(1):(p(3)+p(1)))=true(p(4)+1,p(3)+1);
% pic=pic.*uint8(cat(3,mask,mask,mask));
% gpic=rgb2gray(pic);
% level = graythresh(gpic);
% msk=im2bw(gpic,level);
% for the Jar.
sn1=(pic(:,:,2)>12)|(pic(:,:,1)>15&pic(:,:,2)>15&pic(:,:,3)>15); 
msk=sn1&msk;
Sn = imclearborder(msk);

Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
%---------my invinsion---------------[YY]--
% n1=activecontour(pic(:,:,1),Sn,20);
% n2=activecontour(pic(:,:,2),Sn,20);
% n3=activecontour(pic(:,:,3),Sn,20);
% Sn=n1|n2|n3;

clf
imshow(Sn)
pause(0.5)
close(gcf)

end

