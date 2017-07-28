function [ fr ] = comp3d( vxl,mag )
% compress 3d data in memory.
%   Yasin Yousif 2015
jor=[vxl.XData,vxl.YData,vxl.ZData];

if abs(min(jor(:,1)))>max(jor(:,1))
       xm=abs(min(jor(:,1)));
        else
       xm=max(jor(:,1));
end
        if abs(min(jor(:,2)))>max(jor(:,2))
       ym=abs(min(jor(:,2)));
        else
       ym=max(jor(:,2));
        end
        if abs(min(jor(:,3)))>max(jor(:,3))
       zm=abs(min(jor(:,3)));
        else
       zm=max(jor(:,3));
        end
        vx=vxl.Resolution* mag;
        vy=vx;
        vz=vx;
        
% vx=input('enter voxel X :');
% vy=input('enter voxel Y :');
% vz=input('enter voxel Z :');
fr=uint8(zeros(2*ceil(xm/vx)+1,2*ceil(ym/vy)+1,2*ceil(zm/vz)+1));
% face=[1 2 3 4;1 4 5 6;1 2 7 6;2 7 8 3;6 7 8 5;5 4 3 8];
% clf
% hold on
for g=1:length(jor)
    a=floor((jor(g,1)+xm)/vx);
    b=floor((jor(g,2)+ym)/vy);
    c=floor((jor(g,3)+zm)/vz);
    fr(a+1,b+1,c+1)=fr(a+1,b+1,c+1)+1;
end

end

