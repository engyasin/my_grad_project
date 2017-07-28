function Sn = getsilhouette2( im )
%GETSILHOUETTE - find the silhouette of an object centered in the image

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $
nn=170;
[h,w,~] = size(im);
Sn=~((im(:,:,1)>nn).*(im(:,:,2)>nn).*(im(:,:,3)>nn));
% Initial segmentation based on more red than blue
%S = im(:,:,1) > (im(:,:,3)-2);

% Remove regions touching the border or smaller than 10% of image area
 
Sn = imclearborder(Sn);
%sum(Sn)/sum(ones(h,w))

while (sum(Sn)/sum(ones(h,w)))<0.18
    nn=nn-10;
    Sn=~((im(:,:,1)>nn).*(im(:,:,2)>nn).*(im(:,:,3)>nn));
    Sn = imclearborder(Sn);
end
% 
% Sn = imclearborder(Sn);
Sn = bwareaopen(Sn, ceil(h*w/10));

% Now remove holes < 1% image area
Sn = ~bwareaopen(~Sn, ceil(h*w/100));
