function varargout = KikuchiGUI(varargin)
% KIKUCHIGUI MATLAB code for KikuchiGUI.fig
%      KIKUCHIGUI, by itself, creates a new KIKUCHIGUI or raises the existing
%      singleton*.
%
%      H = KIKUCHIGUI returns the handle to a new KIKUCHIGUI or the handle to
%      the existing singleton*.
%
%      KIKUCHIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KIKUCHIGUI.M with the given input arguments.
%
%      KIKUCHIGUI('Property','Value',...) creates a new KIKUCHIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KikuchiGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KikuchiGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KikuchiGUI

% Last Modified by GUIDE v2.5 19-Jan-2020 23:24:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KikuchiGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @KikuchiGUI_OutputFcn, ...
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


% --- Executes just before KikuchiGUI is made visible.
function KikuchiGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KikuchiGUI (see VARARGIN)

% Choose default command line output for KikuchiGUI

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KikuchiGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KikuchiGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function peaknum_Callback(hObject, eventdata, handles)
% hObject    handle to peaknum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peaknum as text
%        str2double(get(hObject,'String')) returns contents of peaknum as a double


% --- Executes during object creation, after setting all properties.
function peaknum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peaknum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nhood2_Callback(hObject, eventdata, handles)
% hObject    handle to Nhood2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nhood2 as text
%        str2double(get(hObject,'String')) returns contents of Nhood2 as a double


% --- Executes during object creation, after setting all properties.
function Nhood2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nhood2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function check_max1_Callback(hObject, eventdata, handles)
% hObject    handle to check_max1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_max1 as text
%        str2double(get(hObject,'String')) returns contents of check_max1 as a double


% --- Executes during object creation, after setting all properties.
function check_max1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_max1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function check_max_Callback(hObject, eventdata, handles)
% hObject    handle to check_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_max as text
%        str2double(get(hObject,'String')) returns contents of check_max as a double


% --- Executes during object creation, after setting all properties.
function check_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function peaknum1_Callback(hObject, eventdata, handles)
% hObject    handle to peaknum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peaknum1 as text
%        str2double(get(hObject,'String')) returns contents of peaknum1 as a double


% --- Executes during object creation, after setting all properties.
function peaknum1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peaknum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peaknum2_Callback(hObject, eventdata, handles)
% hObject    handle to peaknum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peaknum2 as text
%        str2double(get(hObject,'String')) returns contents of peaknum2 as a double


% --- Executes during object creation, after setting all properties.
function peaknum2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peaknum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nhood1_Callback(hObject, eventdata, handles)
% hObject    handle to Nhood1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nhood1 as text
%        str2double(get(hObject,'String')) returns contents of Nhood1 as a double


% --- Executes during object creation, after setting all properties.
function Nhood1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nhood1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_img.
function load_img_Callback(hObject, eventdata, handles)
% hObject    handle to load_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%点击图形化界面按钮之后的时间函数
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
    errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框
    return;
else
    image=[pathname,filename];%合成路径+文件名
    im=imread(image);%读取图
    set(handles.axes1,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes1);%%使用图像，操作在坐标1
    imshow(im,[]);%在坐标axes1显示原图像
    title('原始图像');
    %绑定变量和GUI
    peaknum_line = str2num(get(handles.peaknum1,'String'));
    peak_num_segline = str2num(get(handles.peaknum2,'String'));
    Nhood_line = str2num(get(handles.Nhood1,'String'));
    Nhood_segline = str2num(get(handles.Nhood2,'String'));
    check_max = str2num(get(handles.check_max,'String'));
    check_min = str2num(get(handles.check_min,'String'));
    check_theta = str2num(get(handles.check_theta,'String'));
    FakeDiminish = str2num(get(handles.FakeDiminish,'String'));
    check_max1 = str2num(get(handles.check_max1,'String'));
    check_min1 = str2num(get(handles.check_min1,'String'));
    check_theta1 = str2num(get(handles.check_theta1,'String'));
    FakeDiminish1 = str2num(get(handles.FakeDiminish1,'String'));
    node_dis = str2num(get(handles.NodeDis,'String'));
    node_nhood = str2num(get(handles.NodeNhood,'String'));
    node_num = str2num(get(handles.NodeNum,'String'));
    canny_sigma = str2num(get(handles.canny_sigma,'String'));
    canny_ratio = str2num(get(handles.canny_ratio,'String'));
    
    [Fitset,noderes,nodemap] = detect(im,peaknum_line,peak_num_segline,Nhood_line,Nhood_segline,check_max,check_min,check_theta,FakeDiminish,check_max1,check_min1,check_theta1,FakeDiminish1,node_dis,node_nhood,node_num,canny_sigma,canny_ratio);
    %%
    set(handles.axes2,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes2);%%使用图像，操作在坐标1
    imshow(im,[]);%在坐标axes2显示原图像
    title('交点图像');
    hold on;
    plot(noderes(:,2),noderes(:,1),'go');

    set(handles.axes3,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes3);%%使用图像，操作在坐标1
    imshow(nodemap,[]);%在坐标axes3显示原图像
    title('Map图像');

    set(handles.axes4,'HandleVisibility','ON');%打开坐标，方便操作
    axes(handles.axes4);%%使用图像，操作在坐标1
    imshow(im,[]);%在坐标axes2显示原图像
    title('hypo图像');
    hold on;
    %% 根据得到的中心线及对应线段拟合双曲线
    for i = 1:length(Fitset)
       tmp_shortLines = Fitset(i).ShortLines;
       tmp_StraightLine = Fitset(i).StraightLine;
       tmp_point_set = [];
       for j = 1:length(tmp_shortLines)
          tmp_point_set = [tmp_point_set;tmp_shortLines(j).point1;tmp_shortLines(j).point2];
       end
       [tmp_point_set,newLine] = Coordinate_transform(tmp_point_set,tmp_StraightLine,tmp_StraightLine.centerx,tmp_StraightLine.centery);
       rotateRad = Cal_rotRad(newLine);
       res_point_set = Coordinate_correction(tmp_point_set,newLine(2),rotateRad);
       for k = 1:length(res_point_set)
               res_point_set(k,1) = abs(res_point_set(k,1));
       end
       x1 = res_point_set(:,1);
       y1 = res_point_set(:,2);
       f = @(c,y1)c(1)*sqrt((y1.^2+c(2))/c(3)^2+1);
       c = real(lsqcurvefit(f,[1000 10000 10000],y1,abs(x1)));
       yy1 = linspace(-1000,1000,400);
       xx1 = c(1)*sqrt((yy1.^2+c(2))/c(3)^2+1);
       xx2 = -c(1)*sqrt((yy1.^2+c(2))/c(3)^2+1);
       hypo_curve1 = [xx1',yy1'];
       hypo_curve2 = [xx2',yy1'];
       cor_restore1 = Coordinate_correction(hypo_curve1,newLine(2),-rotateRad);
       cor_restore2 = Coordinate_correction(hypo_curve2,newLine(2),-rotateRad);
       cor_restore1 = Coordinate_detransform(cor_restore1,tmp_StraightLine.centerx,tmp_StraightLine.centery);
       cor_restore2 = Coordinate_detransform(cor_restore2,tmp_StraightLine.centerx,tmp_StraightLine.centery);
       plot(cor_restore1(:,1),cor_restore1(:,2),'r');
       hold on
       plot(cor_restore2(:,1),cor_restore2(:,2),'b');
       hold on
    end
end



function check_min1_Callback(hObject, eventdata, handles)
% hObject    handle to check_min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_min1 as text
%        str2double(get(hObject,'String')) returns contents of check_min1 as a double


% --- Executes during object creation, after setting all properties.
function check_min1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function check_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to check_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_theta1 as text
%        str2double(get(hObject,'String')) returns contents of check_theta1 as a double


% --- Executes during object creation, after setting all properties.
function check_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function check_min_Callback(hObject, eventdata, handles)
% hObject    handle to check_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_min as text
%        str2double(get(hObject,'String')) returns contents of check_min as a double


% --- Executes during object creation, after setting all properties.
function check_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function check_theta_Callback(hObject, eventdata, handles)
% hObject    handle to check_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of check_theta as text
%        str2double(get(hObject,'String')) returns contents of check_theta as a double


% --- Executes during object creation, after setting all properties.
function check_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to check_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FakeDiminish_Callback(hObject, eventdata, handles)
% hObject    handle to FakeDiminish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FakeDiminish as text
%        str2double(get(hObject,'String')) returns contents of FakeDiminish as a double


% --- Executes during object creation, after setting all properties.
function FakeDiminish_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FakeDiminish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NodeNum_Callback(hObject, eventdata, handles)
% hObject    handle to NodeNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NodeNum as text
%        str2double(get(hObject,'String')) returns contents of NodeNum as a double


% --- Executes during object creation, after setting all properties.
function NodeNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NodeNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NodeNhood_Callback(hObject, eventdata, handles)
% hObject    handle to NodeNhood (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NodeNhood as text
%        str2double(get(hObject,'String')) returns contents of NodeNhood as a double


% --- Executes during object creation, after setting all properties.
function NodeNhood_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NodeNhood (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NodeDis_Callback(hObject, eventdata, handles)
% hObject    handle to NodeDis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NodeDis as text
%        str2double(get(hObject,'String')) returns contents of NodeDis as a double


% --- Executes during object creation, after setting all properties.
function NodeDis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NodeDis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function canny_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to canny_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of canny_sigma as text
%        str2double(get(hObject,'String')) returns contents of canny_sigma as a double


% --- Executes during object creation, after setting all properties.
function canny_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to canny_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function canny_window_Callback(hObject, eventdata, handles)
% hObject    handle to canny_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of canny_window as text
%        str2double(get(hObject,'String')) returns contents of canny_window as a double


% --- Executes during object creation, after setting all properties.
function canny_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to canny_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function canny02_Callback(hObject, eventdata, handles)
% hObject    handle to canny02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of canny02 as text
%        str2double(get(hObject,'String')) returns contents of canny02 as a double


% --- Executes during object creation, after setting all properties.
function canny02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to canny02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function canny_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to canny_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of canny_ratio as text
%        str2double(get(hObject,'String')) returns contents of canny_ratio as a double


% --- Executes during object creation, after setting all properties.
function canny_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to canny_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dbscanmin_Callback(hObject, eventdata, handles)
% hObject    handle to dbscanmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbscanmin as text
%        str2double(get(hObject,'String')) returns contents of dbscanmin as a double


% --- Executes during object creation, after setting all properties.
function dbscanmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbscanmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dbscanfield_Callback(hObject, eventdata, handles)
% hObject    handle to dbscanfield (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbscanfield as text
%        str2double(get(hObject,'String')) returns contents of dbscanfield as a double


% --- Executes during object creation, after setting all properties.
function dbscanfield_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbscanfield (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FakeDiminish1_Callback(hObject, eventdata, handles)
% hObject    handle to FakeDiminish1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FakeDiminish1 as text
%        str2double(get(hObject,'String')) returns contents of FakeDiminish1 as a double


% --- Executes during object creation, after setting all properties.
function FakeDiminish1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FakeDiminish1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
