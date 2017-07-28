function [ Sn ] = bluedetect2back( pic )
% A func 4 3d scanner..
%   Done .. [YY]2015.
[h,w,~]=size(pic);

S1 =1.1.^(single(pic(:,:,3)-pic(:,:,1)));
S2 =1.1.^(single(pic(:,:,3)-pic(:,:,2)));
S3 =1.1.^(single(pic(:,:,3)-rgb2gray(pic)));
Sm=S1+S2+S3;
a=max(max(Sm));
Sl=(Sm<(0.00001*a));
Sl1=Sm.*Sl;
msl=sum(sum(Sl1))/sum(sum(Sl));
Sn=(Sm<msl);
% mblue=115;
% %    sum(sum(pic(:,:,3)))/(h*w);
% S3=pic(:,:,3)>mblue;
% Sn=~(S1&S2&S3);
Sn = imclearborder(Sn);
if sum(sum(Sn))<ceil(h*w/10)
    Sn=(Sm<msl);
end
Sn = bwareaopen(Sn, ceil(h*w/100));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
end
