 function [xlim,ylim,zlim] = findmodel3( cameras )
%FINDMODEL: locate the model to be carved relative to the cameras
%
%   [XLIM,YLIM,ZLIM] = FINDMODEL(CAMERAS) determines the bounding box (x, y
%   and z limits) of the model which is to be carved. This allows the
%   initial voxel volume to be constructed.

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $lj
camera_positions = cat( 2, cameras.T );
xlim = [min( camera_positions(1,:) ), max( camera_positions(1,:) )];
ylim = [min( camera_positions(2,:) ), max( camera_positions(2,:) )];
zlim = [min( camera_positions(3,:) ), max( camera_positions(3,:) )];

% 4 zmin if Unknown we will take 45d.. [YY]
zlim(1)=-30;  %if naragin...bla bla.
% zlim(1)=zlim(2)-(sqrt( diff( xlim ).^2 + diff( ylim ).^2 )/2);
% 4 zmax never change unless the cameras not above the body... [YY]

% Move the limits in a bit since the object must be inside the circle
xrange = diff( xlim );
xlim   = xlim + xrange/4*[1 -1];
yrange = diff( ylim );
ylim = ylim + yrange/4*[1 -1]; 

% Now perform a rough and ready space-carving to narrow down where it is
voxels = spacecarving.makevoxels( xlim, ylim, zlim, 100000 );
disp('save here ')
keyboard


for ii=1:numel(cameras)
    voxels = spacecarving.carve2( voxels, cameras(ii) );
end

% Make sure something is left!
if isempty( voxels.XData )
    error( 'SpaceCarving:FindModel', 'Nothing left after initial serach! Check your camera matrices.' );
end

% Check the limits of where we found data and expand by the resolution
xlim = [min( voxels.XData ),max( voxels.XData )] + 2*voxels.Resolution*[-1 1];
ylim = [min( voxels.YData ),max( voxels.YData )] + 2*voxels.Resolution*[-1 1];
zlim = [min( voxels.ZData ),max( voxels.ZData )] + 2*voxels.Resolution*[-1 1];
