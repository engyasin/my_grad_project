
vxl.XData=double(vxl.XData);
vxl.YData=double(vxl.YData);
vxl.ZData=double(vxl.ZData);
% =================================
vxl2.XData=decimate(vxl.XData,5);
vxl2.XData=decimate(vxl2.XData,4);
vxl2.XData=decimate(vxl2.XData,5);
% =================================
vxl2.YData=decimate(vxl.YData,5);
vxl2.YData=decimate(vxl2.YData,4);
vxl2.YData=decimate(vxl2.YData,5);
% ===============================
vxl2.ZData=decimate(vxl.ZData,5);
vxl2.ZData=decimate(vxl2.ZData,4);
vxl2.ZData=decimate(vxl2.ZData,5);
% ===============================



tri = delaunay(vxl2.XData,vxl2.YData,vxl2.ZData);
trisurf(tri,vxl2.XData,vxl2.YData,vxl2.ZData);