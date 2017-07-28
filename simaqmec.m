function [ im5 ] = simaqmec( )
%simaqmec just for debugging our project
%   optical 3d scanner , get the images from the files.
% .. put in 4d arranged form.
[im4,~]=findimages();
im5=im4(1).image;
for g=2:numel(im4)
    im5=cat(4,im5,im4(g).image);
end


%=======================[YY]==========================
%%  Load the images for the camera
function [images, filename] = findimages
    [filename, pathname] = uigetfile({'*.*'}, ...
                                     'Select ordered images' ,'multiselect','on');
    if ~iscell(filename)  % Assume canceled
        images = struct('image',[]);
        filename = {};
        return;
    end
    
     images(numel(filename)) = struct('image',[]);
    for n = 1:length(filename)
        filename{n} = [pathname filename{n}];
        images(n).image= imread(filename{n});    
    end
end
end
