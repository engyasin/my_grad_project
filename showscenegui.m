function varargout = showscenegui(varargin)
% SHOWSCENEGUI MATLAB code for showscenegui.fig
%      SHOWSCENEGUI, by itself, creates a new SHOWSCENEGUI or raises the existing
%      singleton*.
%
%      H = SHOWSCENEGUI returns the handle to a new SHOWSCENEGUI or the handle to
%      the existing singleton*.
%
%      SHOWSCENEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWSCENEGUI.M with the given input arguments.
%
%      SHOWSCENEGUI('Property','Value',...) creates a new SHOWSCENEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before showscenegui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to showscenegui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help showscenegui

% Last Modified by GUIDE v2.5 02-Mar-2015 19:34:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @showscenegui_OpeningFcn, ...
                   'gui_OutputFcn',  @showscenegui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before showscenegui is made visible.
function showscenegui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to showscenegui (see VARARGIN)

% Choose default command line output for showscenegui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%narginchk( 1, 2 ) ;
vararg.cameras=varargin{1};
vararg.voxels=varargin{2};
vararg.camnum=1;
setappdata(handles.figure1,'camandvox',vararg)
% UIWAIT makes showscenegui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = showscenegui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


% --- Executes on button press in shows1.
function shows1_Callback(hObject, eventdata, handles)
% hObject    handle to shows1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vararg=getappdata(handles.figure1,'camandvox');
cameras=vararg.cameras;
voxels=vararg.voxels;
axes(handles.scene1)
set(gca,'DataAspectRatio',[1 1 1])
hold on
spacecarving.showcamera2(cameras,2);
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


% --- Executes on button press in rightview.
function rightview_Callback(hObject, eventdata, handles)
% hObject    handle to rightview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vararg=getappdata(handles.figure1,'camandvox');
cameras=vararg.cameras;
camnum=vararg.camnum;
camnum=camnum+1;
if camnum>numel(cameras)
    camnum=1;
end
%h=axes(handles.scene1);
view((cameras(camnum).T)')
set(handles.scene1,'CameraPosition',(cameras(camnum).T)') % maybe before view command or after ? [YY].
set(handles.textmn,'String',strcat('Current camera: ',num2str(camnum)))

vararg.camnum=camnum;
setappdata(handles.figure1,'camandvox',vararg)

% --- Executes on button press in liftview.
function liftview_Callback(hObject, eventdata, handles)
% hObject    handle to liftview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vararg=getappdata(handles.figure1,'camandvox');
cameras=vararg.cameras;
camnum=vararg.camnum;
camnum=camnum-1;
if camnum<1
    camnum=numel(cameras);
end
%h=axes(handles.scene1);
view((cameras(camnum).T)')
set(handles.scene1,'CameraPosition',(cameras(camnum).T)') % maybe before view command or after ? [YY].

set(handles.textmn,'String',strcat('Current camera: ',num2str(camnum)))
vararg.camnum=camnum;
setappdata(handles.figure1,'camandvox',vararg)


% --- Executes on button press in Rot.
function Rot_Callback(hObject, eventdata, handles)
% hObject    handle to Rot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% rotate3d(handles.scene1)

% --- Executes on button press in Zoo_m.
function Zoo_m_Callback(hObject, eventdata, handles)
% hObject    handle to Zoo_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.scene1);
zoom on


% --- Executes on button press in rotatecon.
function rotatecon_Callback(hObject, eventdata, handles)
% hObject    handle to rotatecon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:36
	camroll(handles.scene1,10)
	drawnow
end


% --- Executes on button press in cravec.
function cravec_Callback(hObject, eventdata, handles)
% hObject    handle to cravec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vararg=getappdata(handles.figure1,'camandvox');
cameras=vararg.cameras;
voxels=vararg.voxels;
camnum=vararg.camnum;
voxels = spacecarving.carve2( voxels, cameras(camnum) );        % here come our guinusity..[YY]
xlim = [min( voxels.XData )-2*voxels.Resolution,max( voxels.XData )+2*voxels.Resolution];
ylim = [min( voxels.YData )-2*voxels.Resolution,max( voxels.YData )+2*voxels.Resolution];
zlim = [min( voxels.ZData )-2*voxels.Resolution,max( voxels.ZData )+2*voxels.Resolution];

voxels = spacecarving.makevoxels( xlim, ylim, zlim, 20000 );


axes(handles.scene1)
hold off
plot3(0,0,0,'g*')
set(gca,'DataAspectRatio',[1 1 1])
hold on
spacecarving.showcamera2(cameras,2);
% clc
% ---------------Here just to expand the view of the axes [YY]-------------
camera_positions = cat( 2, cameras.T );                     
xlim = [min( camera_positions(1,:) ), max( camera_positions(1,:) )];
ylim = [min( camera_positions(2,:) ), max( camera_positions(2,:) )];
zlim = [min( camera_positions(3,:) ), max( camera_positions(3,:) )];
hold on
plot3(xlim(1)-0.5,ylim(1)-0.5,zlim(1)-0.5) % the min [YY]
plot3(xlim(2)+0.5,ylim(2)+0.5,zlim(2)+0.5) % the max [YY]
%------------------------End up ..[YY]-------------------------------------
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
vararg.voxels=voxels;
setappdata(handles.figure1,'camandvox',vararg)


% --- Executes on button press in cravefin.
function cravefin_Callback(hObject, eventdata, handles)
% hObject    handle to cravefin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vararg=getappdata(handles.figure1,'camandvox');
cameras=vararg.cameras;
voxels=vararg.voxels;
camnum=vararg.camnum;
if ~isfield(vararg,'filtered')
xlim = [min( voxels.XData ),max( voxels.XData )] ;
ylim = [min( voxels.YData ),max( voxels.YData )] ;
zlim = [min( voxels.ZData ),max( voxels.ZData )] ;
voxels = spacecarving.makevoxels( xlim, ylim, zlim, 3000000 ); 
end
% for the momery here we increase the resoulation ..[YY]
vararg.filtered=1;
voxels = spacecarving.carve2( voxels, cameras(camnum) );

axes(handles.scene1)
hold off
plot3(0,0,0,'g*')
set(gca,'DataAspectRatio',[1 1 1])
hold on
spacecarving.showcamera2(cameras,2);%  .. TODO [YY].Note: ...
clc
% ---------------Here just to expand the view of the axes [YY]-------------
camera_positions = cat( 2, cameras.T );                     
xlim = [min( camera_positions(1,:) ), max( camera_positions(1,:) )];
ylim = [min( camera_positions(2,:) ), max( camera_positions(2,:) )];
zlim = [min( camera_positions(3,:) ), max( camera_positions(3,:) )];
hold on
plot3(xlim(1)-0.5,ylim(1)-0.5,zlim(1)-0.5) % the min [YY]
plot3(xlim(2)+0.5,ylim(2)+0.5,zlim(2)+0.5) % the max [YY]
%------------------------End up ..[YY]-------------------------------------
xlabel('X')
ylabel('Y')
zlabel('Z')
disp('size of result voxels')
size(voxels.XData)
% showsufacevmec (voxels)
%% And show a surface around the object
if nargin>1 && ~isempty( voxels )      %Note: here [YY]
    spacecarving.showsurface( voxels );
end

%% Light the scene and adjust the view angle to make it a bit easier on 
% the eye
view(3);
grid on
light('Position',[0 0 1]);
axis tight
vararg.voxels=voxels;
setappdata(handles.figure1,'camandvox',vararg)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in savevxl.
function savevxl_Callback(hObject, eventdata, handles)
% hObject    handle to savevxl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vararg=getappdata(handles.figure1,'camandvox');
voxels=vararg.voxels;
% evalin('base','vxls=voxels;');

checkLabels = {'Save voxels data to variable named:'}; 
varNames = {'vxls'}; 
items = {voxels};
export2wsdlg(checkLabels,varNames,items,...
             'Save voxels to Workspace');
         
