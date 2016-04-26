

function varargout = RippleGUI2(varargin)
% RippleGUI2 MATLAB code for RippleGUI2.fig
%      RippleGUI2, by itself, creates a new RippleGUI2 or raises the existing
%      singleton*.
%
%      H = RippleGUI2 returns the handle to a new RippleGUI2 or the handle to
%      the existing singleton*.
%
%      RippleGUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RippleGUI2.M with the given input arguments.
%
%      RippleGUI2('Property','Value',...) creates a new RippleGUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RippleGUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RippleGUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RippleGUI2

% Last Modified by GUIDE v2.5 08-Apr-2016 22:23:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @RippleGUI2_OpeningFcn, ...
    'gui_OutputFcn',  @RippleGUI2_OutputFcn, ...
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


% --- Executes just before RippleGUI2 is made visible.
function RippleGUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RippleGUI2 (see VARARGIN)

% Choose default command line output for RippleGUI2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RippleGUI2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RippleGUI2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Opening Serial Communications start other scripts
%% Initialize variables.
filename = 'C:\Users\Skyler\Desktop\RippleFinal\RippleStart.txt';
delimiter = '::';
formatSpec = '%s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
StartFileData = dataArray{:, 2};
clearvars filename delimiter formatSpec fileID dataArray ans;
%%

filename = cell2mat(StartFileData(7));
pythonFilePath= strcat(cell2mat(StartFileData(8)),' &');
py=system(pythonFilePath);


%% Initializations

%set gui axes to variables
ecgAxes = findobj(gcf,'Tag','axes1');
set(get(ecgAxes, 'XLabel'), 'String', 'Time');
set(get(ecgAxes, 'YLabel'), 'String', 'mV');
set(get(ecgAxes, 'Title'), 'String', 'ECG','Color','White');
respAxes = findobj(gcf,'Tag','axes2');
set(get(respAxes, 'XLabel'), 'String', 'Time');
set(get(respAxes, 'YLabel'), 'String', 'mV');
set(get(respAxes, 'Title'), 'String', 'Resp. Impedance','Color','White');
RedAxes = findobj(gcf,'Tag','axes3');
set(get(RedAxes, 'XLabel'), 'String', 'Time');
set(get(RedAxes, 'YLabel'), 'String', 'N');
set(get(RedAxes, 'Title'), 'String', 'PPG Red','Color','White');
IRAxes = findobj(gcf,'Tag','axes4');
set(get(IRAxes, 'XLabel'), 'String', 'Time');
set(get(IRAxes, 'YLabel'), 'String', 'N');
set(get(IRAxes, 'Title'), 'String', 'PPG Infrared','Color','White');

SpO2Avrg = -1;
avgBPM = 0;
nLines = 0;
RespRate = 'none';
%Sp02 filter:
%25 tap, lowpass fir filter of the first order with cutoff at Nyquest freq. 0.08
fir = fir1(25,0.08);
fir2 = fir1(25,0.08);
%flag timer inizialize

HRflag1Last = tic;
HRflag2Last = tic;
HRflag3Last = tic;
HRflag4Last = tic;
RRflag1Last = tic;
RRflag2Last = tic;
SpO2flag1Last = tic;
SpO2flag2Last = tic;
%% Main Loop, reading data into Matlab and graphing
while(py==0)
    %Reading Data from file for ecg, resp and PPG
    %using a perl script to scan file quickly for length
    %the perl code that is in the countline.pl script is:
    %while (<>) {};
    %print $.,"\n";
    nLines=str2double(perl('countlines.pl',filename));
    
    if(nLines < 3000)
        startRow = 2;
    else
        startRow = nLines-2980;
    end
    delimiter = ',';
    formatSpec = '%f%f%f%f%f%f%[^\n\r]';
    fileID = fopen(filename,'r');
    FileData = textscan(fileID, formatSpec, 'Delimiter', delimiter,'EmptyValue' ,NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', true);
    fclose(fileID);
    
    %% Allocate imported array to column variable names
    DataPoint = FileData{:, 1}';
    Resp = FileData{:, 2}';
    ECG = FileData{:, 3}';
    IR = FileData{:, 4}';
    Red = FileData{:, 5}';
    SpO2 = FileData{:, 6}';
    %     if(~isempty(DataPoint))
    %         nLines = DataPoint(length(DataPoint));
    %     end
    %% Data manipulation
    if(length(ECG)>50)
        %Detrend data
        ECG = detrend(ECG,'constant');
        %Filter out powerline and other noise
        ECG =  sgolayfilt(ECG,7,21);
       % ECG = filter(fir,1,ECG);
        Resp = sgolayfilt(Resp,3,31);
        IR = filter(fir,1,IR);
        Red = filter(fir,1,Red);
        
        
        %% plots
        
        plot(ecgAxes, (ECG));
        plot(respAxes, (Resp));
        plot(RedAxes, (Red(30:length(Red))));
        plot(IRAxes, (IR(30:length(Red))));
        drawnow
        
        %% Calculations
        %% SpO2
        % Calculate Sp02 (done on arduino now)
        %         SpO2 = (log(yVal_Red(1,1))/log(yVal_IR(1,1))*2);
        %         Per_SpO2 = 100 - SpO2;
        SpO2Samples=0;
        SpO2Total=0;
        for j = 1:length(SpO2)
            if(SpO2(j) > -1)
                SpO2Total = SpO2(j) + SpO2Total;
                SpO2Samples = SpO2Samples + 1;
            end
        end
        if(SpO2Total>0)
            SpO2Avrg = SpO2Total/SpO2Samples;
            set(handles.edit5, 'string', num2str(round(SpO2Avrg)))
        end
        if(SpO2Total<0)
            set(handles.edit5, 'string', 'err')
        end
        
        %% BPM
        ECGthreshold = 0;
        totalBPM = 0;
        %Calculate R wave threshold
        if(length(ECG)>2880)
            [magECG,locsECG] = findpeaks(ECG(length(ECG)-250:length(ECG)));
            if(max(magECG)>60000)
                ECGthreshold = 0;
            elseif(max(magECG)<5000 && max(magECG) > 1000)
                ECGthreshold = 0.3 * max(magECG);
            elseif(max(magECG) < 1000)
                ECGthreshold = inf;
            else
                ECGthreshold = 0.6 * max(magECG);
            end
            
            % Calculate R-R interval and BPM
            if(ECGthreshold>0)
                [~,locs_Rwave] = findpeaks(ECG(length(ECG)-900:length(ECG)),'MinPeakHeight' ,ECGthreshold);
                if(length(locs_Rwave)>2)
                    i =2;
                    while( length(locs_Rwave)>= i)
                        r_rInterval = (locs_Rwave(i) - locs_Rwave(i-1))/120;
                        totalBPM = (1/r_rInterval * 60) + totalBPM;
                        i = i+1;
                        avgBPM = totalBPM/(i-2);
                    end
                    if(avgBPM <250)
                        set(handles.edit2, 'string', num2str(avgBPM));
                    else
                        avgBPM = 'err'
                        set(handles.edit2, 'string', 'err');
                    end
                else
                    avgBPM = 0;
                    set(handles.edit2, 'string', num2str(avgBPM));
                end
            end
        end
        %% RPM
        % Calculation for RPM
        if(length(Resp)>1500)
            [~,locs] = findpeaks(Resp,'MinPeakProminence',250);
            RespRate = round(length(locs)/(length(Resp)/6000));
            set(handles.edit3, 'string', num2str(RespRate));
        end
        
        %% Flags
        if(nLines>1550)
            %Heart rate flags
            if((avgBPM < 40) )
                if(mod(HRflag1Last ,toc(HRflag1Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Low BPM: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','yellow');
                    HRflag1Last = tic;
                end
            end
            if(avgBPM < 20)
                if(mod(HRflag2Last ,toc(HRflag2Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Very low BPM: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','red');
                    HRflag2Last = tic;
                end
            end
            if(avgBPM == 0)
                if(mod(HRflag3Last ,toc(HRflag3Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'No Heart Beat Detected: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','red');
                    HRflag3Last = tic;
                end
            end
            if(avgBPM == 'err')
                if(mod(HRflag4Last ,toc(HRflag4Last)) >30)
                    
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Check Leads: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','green');
                    HRflag4Last = tic;
                end
            end
            %Resp Rate flags
            if(RespRate > 30)
                if(mod(RRflag1Last ,toc(RRflag1Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Heavy Breathing Detected: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','yellow');
                    RRflag1Last = tic;
                end
            end
            if(RespRate == 0)
                if(mod(RRflag2Last ,toc(RRflag2Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'))
                    typeOfFlag = 'No Breathing Detected: '
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','red');
                    RRflag2Last = tic;
                end
            end
            %SpO2 flags
            if(SpO2Avrg == -1)
                if(mod(SpO2flag1Last ,(SpO2flag1Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Check Pulse Ox sensor: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','yellow');
                    SpO2flag1Last = tic;
                end
            end
            if((SpO2Avrg < 85) && (SpO2Avrg > 0))
                if(mod(SpO2flag2Last ,toc(SpO2flag1Last)) >30)
                    timeOfFlag = char(datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
                    typeOfFlag = 'Low SpO2: ';
                    currentflags = get(handles.text11, 'string');
                    set(handles.text11, 'string',[currentflags, typeOfFlag, timeOfFlag, '; ']);
                    set(handles.text11,'ForegroundColor','red');
                    SpO2flag2Last = tic;
                end
            end
        end
        
    end
end






% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = get(handles.edit6,'String') + datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z') + '.txt';
fid = fopen( fileName, 'a' );

fclose(fid);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text11 as text
%        str2double(get(hObject,'String')) returns contents of text11 as a double


% --- Executes during object creation, after setting all properties.
function text11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
