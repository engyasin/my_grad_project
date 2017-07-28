function showscene2(cameras,voxels)
%SHOWSCENE: show a carve scene, including cameras, images and the model
%
%   SHOWSCENE(CAMERAS,VOXELS) shows the specified list of CAMERAS and the
%   current model as a surface fitted around VOXELS.
%
%   Example:
%   >> camera = loadcameradata(1);
%   >> camera.Silhouette = getsilhouette( camera.Image );
%   >> voxels = carve( makevoxels(50), camera );
%   >> showscene( camera, voxels );

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $

 narginchk( 1, 2 ) ;

%% Plot each camera centre
set(gca,'DataAspectRatio',[1 1 1])
hold on
spacecarving.showcamera2(cameras,2);
% N = numel(cameras);
% for ii=1:N
%     spacecarving.showcamera(cameras(ii),2);
% end
% added to make the view as wanted [YY].
camera_positions = cat( 2, cameras.T );                     
xlim = [min( camera_positions(1,:) ), max( camera_positions(1,:) )];
ylim = [min( camera_positions(2,:) ), max( camera_positions(2,:) )];
zlim = [min( camera_positions(3,:) ), max( camera_positions(3,:) )];
hold on
plot3(xlim(1)-0.5,ylim(1)-0.5,zlim(1)-0.5) % the min [YY]
plot3(xlim(2)+0.5,ylim(2)+0.5,zlim(2)+0.5) % the max [YY]
xlabel('X')
ylabel('Y')
zlabel('Z')


%% And show a surface around the object
if nargin>1 && ~isempty( voxels )
    spacecarving.showsurface( voxels );
end

%% Light the scene and adjust the view angle to make it a bit easier on 
% the eye
view(3);
grid on;
light('Position',[0 0 1]);
axis tight