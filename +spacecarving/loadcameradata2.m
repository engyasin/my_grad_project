function cameras = loadcameradata2(dataDir, idx)
%LOADCAMERADATA: Load the dino data
%
%   CAMERAS = LOADCAMERADATA() loads the dinosaur data and returns a
%   structure array containing the camera definitions. Each camera contains
%   the image, internal calibration and external calibration.
%
%   CAMERAS = LOADCAMERADATA(IDX) loads only the specified file indices.
%
%   Example:
%   >> cameras = loadcameradata(1:3);
%   >> showcamera(cameras)
%
%   See also: SHOWCAMERA

%   Copyright 2005-2009 The MathWorks, Inc.
%   $Revision: 1.0 $    $Date: 2006/06/30 00:00:00 $

if nargin<2
    idx = 1:20;
    
end

cameras = struct( ...
    'Image', {}, ...
    'P', {}, ...
    'K', {}, ...
    'R', {}, ...
    'T', {}, ...
    'Silhouette', {} );

%% First, import the camera Pmatrices
rawP = load( fullfile( dataDir, 'monster_pmatrix.mat') );

%% Now loop through loading the images
tmwMultiWaitbar('Loading images',0);
for ii=idx(:)'
    % We try both JPG and PPM extensions, trying JPEG first since it is
    % the faster to load
    nn=171+ii;
    filename = fullfile( dataDir, sprintf( 'IMG_2%03d.jpg', nn ) );
    if exist( filename, 'file' )~=2
        % Try PPM
        filename = fullfile( dataDir, sprintf( 'viff.%03d.ppm', ii ) );
        if exist( filename, 'file' )~=2
            % Failed
            error( 'SpaceCarving:ImageNotFound', ...
                'Could not find image %d (''viff.%03d.jpg/.ppm'')', ...
                ii, ii );
        end
    end

%     K=rawP.monster_ps{ii,1}{1,1};
%     R=rawP.monster_ps{ii,1}{2,1}; % Recovered: here I added (-) for convinence.. [YY]
%     t=rawP.monster_ps{ii,1}{3,1};
%     cameras(ii).rawP = rawP.monster_ps{ii,1}{4,1};
    cameras(ii).P = rawP.monster_ps{ii,1}{4,1};     % 4: P , 3:T , 2: R , 1: k;
    cameras(ii).K =rawP.monster_ps{ii,1}{1,1};
    cameras(ii).R =rawP.monster_ps{ii,1}{2,1};
    cameras(ii).T = rawP.monster_ps{ii,1}{3,1};
    rwp=cameras(ii).K*[-cameras(ii).R cameras(ii).T];
%     rwp(3,1:4)=cameras(ii).P(3,1:4);
    cameras(ii).rawP=rwp;
%     [K,R,t] = spacecarving.decomposeP(rawP.monster_ps{ii,1}{4,1});
%     cameras(ii).rawP = rawP.monster_ps{ii,1}{4,1};
%     cameras(ii).P = rawP.monster_ps{ii,1}{4,1};
%     cameras(ii).K = K/K(3,3);
%     cameras(ii).R = R;
%     cameras(ii).T = t;% -R'*t;
    cameras(ii).Image = imread( filename );
    cameras(ii).Silhouette = [];
    tmwMultiWaitbar('Loading images',ii/max(idx));
end
tmwMultiWaitbar('Loading images','close');

