function showcamera2(ax,camera,n)
%SHOWCAMERA: draw a schematic of a camera
%
%   SHOWCAMERA(CAMERA) draws a camera on the current axes
%
%   SHOWCAMERA(AXES,CAMERA) draws a camera on the specified axes
%
%   Example:
%   >> cameras = loadcameradata(1:3);
%   >> showcamera(cameras)
%
%   See also: LOADCAMERADATA

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $

if nargin<3         % here I changed care..[YY]
    n=camera;
    camera = ax;     
    ax = gca();
    
end

scale = 0.2;
subsample = 16;
if n==1        % here if n=1 the default but one camera or 2 my way & all the cameras....
for c=1:numel(camera)
    cam_t = camera(c).T;
    
    % Draw the camera centre
    plot3(camera(c).T(1),camera(c).T(2),camera(c).T(3),'b.','markersize',5);
    
    % Now work out where the image corners are
    [h,w,colordepth] = size(camera(c).Image); %#ok<NASGU>
    imcorners = [0 w 0 w
        0 0 h h
        1 1 1 1];
    worldcorners = iBackProject( imcorners, scale, camera(c) );
    iPlotLine(cam_t, worldcorners(:,1), 'b-')
    hold on
    iPlotLine(cam_t, worldcorners(:,2), 'b-')
    iPlotLine(cam_t, worldcorners(:,3), 'b-')
    iPlotLine(cam_t, worldcorners(:,4), 'b-')
    
    
    
    % Now draw the image plane. We will need the coords of every pixel in order
    % to do the texturemap
    [x,y,z] = meshgrid( 1:subsample:w, 1:subsample:h, 1 );
    pix = [x(:),y(:),z(:)]';
    worldpix = iBackProject( pix, scale, camera(c) );
    smallim = camera(c).Image(1:subsample:end,1:subsample:end,:);
    surface('XData', reshape(worldpix(1,:),h/subsample,w/subsample), ...
        'YData', reshape(worldpix(2,:),h/subsample,w/subsample), ...
        'ZData', reshape(worldpix(3,:),h/subsample,w/subsample), ...
        'FaceColor','texturemap', ...
        'EdgeColor','none',...
        'CData', smallim );
end
set( ax,'DataAspectRatio', [1 1 1] )
elseif n==2
hold on  


vp = camera(1).T - 5 * spacecarving.getcameradirection( camera(1) );
    line([camera(1).T(1),vp(1)],[camera(1).T(2),vp(2)],[camera(1).T(3),vp(3)],'color',[1 0 0],'LineWidth',2)
%  R2=[0 0 1]\(spacecarving.getcameradirection( camera(1) )');
%  R1=-camera(1).R;  
%  Rf=R2/R1;% Rf istead of [-camera(1).R,camera(1).T;0 0 0 1].. [YY]
Rf=camera(1).R;
cmn=CentralCamera('name','c1','T',[Rf,camera(1).T;0 0 0 1],'scale',50);
cmn.pp=[size(camera(1).Image,1)/2,size(camera(1).Image,2)/2];
cmn.npix=[size(camera(1).Image,1),size(camera(1).Image,2)];
 plot_camera(cmn,'Tcam',[Rf,camera(1).T;0 0 0 1],'scale',0.2,'color',rand(3,1)','label')
for k=2:numel(camera)
    
  
%     plot_camera(cmn,'Tcam',[-camera(k).R,camera(k).T;0 0 0 1],'scale',0.2,'color',rand(3,1)','label')
    vp = camera(k).T - 5 * spacecarving.getcameradirection( camera(k) );
    disp(spacecarving.getcameradirection( camera(k) ))
    line([camera(k).T(1),vp(1)],[camera(k).T(2),vp(2)],[camera(k).T(3),vp(3)],'color',[1 0 0],'LineWidth',2)
%     R2=[0 0 1]\(spacecarving.getcameradirection( camera(k) )');
%     R1=-camera(k).R;  
%     Rf=R2/R1;% Rf istead of [-camera(1).R,camera(1).T;0 0 0 1].. [YY]
Rf=camera(k).R;
    cmn=CentralCamera('name',sprintf('c%2d',k),'T',[Rf,camera(k).T;0 0 0 1],'scale',50);
    cmn.pp=[size(camera(k).Image,1)/2,size(camera(k).Image,2)/2];
    cmn.npix=[size(camera(k).Image,1),size(camera(k).Image,2)];
    plot_camera(cmn,'Tcam',[Rf,camera(k).T;0 0 0 1],'scale',0.2,'color',rand(3,1)','label')
    [h,w,~] = size(camera(k).Image);
    [x,y,z] = meshgrid( 1:subsample:w, 1:subsample:h, 1 );
    pix = [x(:),y(:),z(:)]';
    worldpix = iBackProject( pix, scale, camera(k) );
    smallim = camera(k).Image(1:subsample:end,1:subsample:end,:);
    surface('XData', reshape(worldpix(1,:),h/subsample,w/subsample), ...
        'YData', reshape(worldpix(2,:),h/subsample,w/subsample), ...
        'ZData', reshape(worldpix(3,:),h/subsample,w/subsample), ...
        'FaceColor','texturemap', ...
        'EdgeColor','none',...
        'CData', smallim );
end
% here not revisioned ..[YY]
[h,w,~] = size(camera(1).Image);
[x,y,z] = meshgrid( 1:subsample:w, 1:subsample:h, 1 );
    pix = [x(:),y(:),z(:)]';
    worldpix = iBackProject( pix, scale, camera(1) );
    smallim = camera(1).Image(1:subsample:end,1:subsample:end,:);
    surface('XData', reshape(worldpix(1,:),h/subsample,w/subsample), ...
        'YData', reshape(worldpix(2,:),h/subsample,w/subsample), ...
        'ZData', reshape(worldpix(3,:),h/subsample,w/subsample), ...
        'FaceColor','texturemap', ...
        'EdgeColor','none',...
        'CData', smallim );
%     disp('Just for one Camera the direction')
%      dirn = getcameradirection( camera );
%     clc
end
%-------------------------------------------------------------------------%
function X = iBackProject( x, dist, camera )
%IBACKPROJECT - backproject an image location a distance DIST and return
%   the equivalent world location.
if size(x,1)==2
    x = [x;ones(1,size(x,2))];
end

X = camera.K \ x;
normX = sqrt(sum(X.*X,1));
X = X ./ repmat(normX,size(X,1),1);
X = repmat(camera.T,1,size(x,2)) - dist * camera.R'*X;

%-------------------------------------------------------------------------%
function iPlotLine(x0, x1, style)
plot3([x0(1),x1(1)], [x0(2),x1(2)], [x0(3),x1(3)], style);
