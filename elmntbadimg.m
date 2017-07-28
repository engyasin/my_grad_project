function [ imbinstrc ] = elmntbadimg( imbinstrc )
%elmntbadimg of [YY] creation for our grad project.
%   YY & his friends Pass from here.
%   Karma is not a bitch.
si=size(imbinstrc(1).Silhouette);
si(3)=numel(imbinstrc)+1;
% im5=true(si);

    
im5 = cat(4,imbinstrc.Silhouette,true([si(1) si(2)]));


close all

ny=floor(sqrt(si(3)));
nx=ceil(si(3)/ny);
montage(im5,'Size',[ny nx])
title('Choose the bad masks to delete & choose the last to return')
p=ginput(1);
x=ceil(p(1)/si(2));
y=ceil(p(2)/si(1))-1;
nimg=nx*y+x;

while nimg~=si(3)
imbinstrc(nimg).Silhouette=true([si(1) si(2)]);
im5(:,:,:,nimg) = true([si(1) si(2)]);
clf
montage(im5,'Size',[ny nx])
title('Choose bad masks to delete & choose the last to return')
drawnow

p=ginput(1);
x=ceil(p(1)/si(2));
y=ceil(p(2)/si(1))-1;
nimg=nx*y+x;

end
close(gcf)
end

