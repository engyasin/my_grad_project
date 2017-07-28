function [ Pm ] = generatec43d( immat,th2,r,camobject,Pm )
%generatep43d is a function for getting P matrices for cameras around the
%object 
%   this function is for our 3d scanner grad project [YY MK SHH]

 th1=360/size(immat,4);
 K=camobject.IntrinsicMatrix';
 if nargin<5            % Care.. [YY]
 Pm = struct( ...
    'Image', {}, ...
    'P', {}, ...
    'K', {}, ...
    'R', {}, ...
    'T', {}, ...
    'Silhouette', {} );
 end
for n=1:(360/th1)
    Pm(n).R=(rotz(th1*(n-1),'deg')*roty(th2,'deg')*rotz(-90,'deg')*rotx(-90,'deg'))';
    Pm(n).T=(r*[-cosd(th1*(n-1)),-sind(th1*(n-1)),0])';
end

for g=1:round(360/th1)
      t=(-Pm(g).R')\Pm(g).T;
      Pm(g).rawP=K*[Pm(g).R,t]; 
      Pm(g).P = Pm(g).rawP;
%       if g==(180/th1)+1
%           K(1,2)=-K(1,2);
%           K(1,1)=-K(1,1);
%           K(2,2)=-K(2,2);
%       end
      Pm(g).K = K;
      
%       Pm(g).Image=imread(strcat('C:\Users\HORIZON LINE\Documents\MATLAB\SpaceCarving\test1calib\objectnamed\'...
%           ,sprintf('pics%02d.png', g )));
        Pm(g).Image=immat(:,:,:,g);
        Pm(g).Image = undistortImage(Pm(g).Image, camobject);
end
if nargin<5         % Care .. [YY]
% for c=1:numel(Pm)
%     Pm(c).Silhouette = segment1( Pm(c).Image );
% end
end
    