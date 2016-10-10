function varargout = GACut(varargin)
% GACUT M-file for GACut.fig
%      GACUT, by itself, creates a new GACUT or raises the existing
%      singleton*.
%
%      H = GACUT returns the handle to a new GACUT or the handle to
%      the existing singleton*.
%
%      GACUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GACUT.M with the given input arguments.
%
%      GACUT('Property','Value',...) creates a new GACUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GACut_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GACut_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GACut

% Last Modified by GUIDE v2.5 26-Apr-2006 22:26:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GACut_OpeningFcn, ...
                   'gui_OutputFcn',  @GACut_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% ==============================================================================================================================
% --- Executes just before GACut is made visible.
function GACut_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GACut (see VARARGIN)

% Choose default command line output for GACut
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global CH;                          % набір хромосом
global CHF;                         % значення фітнесу для хромосом
global BestResult;                  % значення найкращого результату
global GAResult;                    % значення поточного результату
global PLATES; PLATES=[];           % параметри пластинок (кожної окремо)
global PLATESSRC; PLATESSRC=[];     % параметри пластинок по групам (довжина х ширина х кількість)
global PLATE; PLATE=[0 0];          % довжина та ширина великої пластини
global INFO; INFO=0;                % загальна інформація

% UIWAIT makes GACut wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% ==============================================================================================================================
% --- Outputs from this function are returned to the command line.
function varargout = GACut_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditPlateLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPlateLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditPlateLength_Callback(hObject, eventdata, handles)
% hObject    handle to EditPlateLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPlateLength as text
%        str2double(get(hObject,'String')) returns contents of EditPlateLength as a double

global PLATE;
PLATE(1,1)=str2num(get(handles.EditPlateLength,'String'));
TEMP=PLATE(1,1)*PLATE(1,2);
set(handles.TextSquarePlate,'String',num2str(TEMP));
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditPlateWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPlateWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditPlateWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EditPlateWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPlateWidth as text
%        str2double(get(hObject,'String')) returns contents of EditPlateWidth as a double

global PLATE;
PLATE(1,2)=str2num(get(handles.EditPlateWidth,'String'));
TEMP=PLATE(1,1)*PLATE(1,2);
set(handles.TextSquarePlate,'String',num2str(TEMP));
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditPlatesLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPlatesLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditPlatesLength_Callback(hObject, eventdata, handles)
% hObject    handle to EditPlatesLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPlatesLength as text
%        str2double(get(hObject,'String')) returns contents of EditPlatesLength as a double
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditPlatesWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPlatesWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditPlatesWidth_Callback(hObject, eventdata, handles)
% hObject    handle to EditPlatesWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPlatesWidth as text
%        str2double(get(hObject,'String')) returns contents of EditPlatesWidth as a double
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditPlatesCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPlatesCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditPlatesCount_Callback(hObject, eventdata, handles)
% hObject    handle to EditPlatesCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPlatesCount as text
%        str2double(get(hObject,'String')) returns contents of EditPlatesCount as a double
% ==============================================================================================================================
% --- Executes on button press in ButtonAddPlates.
function ButtonAddPlates_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonAddPlates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PLATESSRC;
[m,n]=size(PLATESSRC);
ITEM=[str2num(get(handles.EditPlatesLength,'String')) ...
      str2num(get(handles.EditPlatesWidth,'String')) ...
      str2num(get(handles.EditPlatesCount,'String'))];
PLATESSRC=[PLATESSRC; ITEM];
ITEM_TEMP=ITEM(1,1)*ITEM(1,2)*ITEM(1,3);
TEMP=str2num(get(handles.TextSquarePlates,'String'));
set(handles.TextSquarePlates,'String',num2str(TEMP+ITEM_TEMP));
ITEM_TEMP=(ITEM(1,1)+ITEM(1,2))*2*ITEM(1,3);
TEMP=str2num(get(handles.TextPerimeterPlates,'String'));
set(handles.TextPerimeterPlates,'String',num2str(TEMP+ITEM_TEMP));

CD=get(handles.ListBoxPlates,'String');
[m,n]=size(CD);
TEMP=[num2str(ITEM(1,1)) ' x ' num2str(ITEM(1,2)) ' x ' num2str(ITEM(1,3))];
[m1,n1]=size(TEMP);
if n~=0
    if n>n1
        for i=n1+1:n TEMP=[TEMP ' ']; end
    elseif n<n1
        for i=n+1:n1 CD(:,i)=' '; end
    end
    CD=[CD; TEMP];
    set(handles.ListBoxPlates,'Value',m+1);
else
    CD=TEMP;
    set(handles.ListBoxPlates,'Value',1);
end
set(handles.ListBoxPlates,'String',CD);
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function ListBoxPlates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxPlates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
% --- Executes on selection change in ListBoxPlates.
function ListBoxPlates_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxPlates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ListBoxPlates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxPlates
% ==============================================================================================================================
% --- Executes on button press in ButtonRemovePlates.
function ButtonRemovePlates_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonRemovePlates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PLATESSRC;
[m,n]=size(PLATESSRC);

CD=get(handles.ListBoxPlates,'String');
CDindex=get(handles.ListBoxPlates,'Value');

[m,n]=size(CD);
if (CDindex>=1) && (CDindex<=m)
    CD=[CD(1:CDindex-1,:); CD(CDindex+1:m,:)];
    PERIMETER=(PLATESSRC(CDindex,1)+PLATESSRC(CDindex,2))*2*PLATESSRC(CDindex,3);
    SQUARE=PLATESSRC(CDindex,1)*PLATESSRC(CDindex,2)*PLATESSRC(CDindex,3);
    PLATESSRC=[PLATESSRC(1:CDindex-1,:); PLATESSRC(CDindex+1:m,:)];
    TEMP=str2num(get(handles.TextSquarePlates,'String'));
    set(handles.TextSquarePlates,'String',num2str(TEMP-SQUARE));
    TEMP=str2num(get(handles.TextPerimeterPlates,'String'));
    set(handles.TextPerimeterPlates,'String',num2str(TEMP-PERIMETER));
    if (CDindex>m-1) CDindex=m-1; end
    set(handles.ListBoxPlates,'String',CD);
    set(handles.ListBoxPlates,'Value',CDindex);
end
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditChromosomes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditChromosomes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditChromosomes_Callback(hObject, eventdata, handles)
% hObject    handle to EditChromosomes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditChromosomes as text
%        str2double(get(hObject,'String')) returns contents of EditChromosomes as a double
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditMutations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditMutations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditMutations_Callback(hObject, eventdata, handles)
% hObject    handle to EditMutations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditMutations as text
%        str2double(get(hObject,'String')) returns contents of EditMutations as a double
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function EditIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
function EditIterations_Callback(hObject, eventdata, handles)
% hObject    handle to EditIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditIterations as text
%        str2double(get(hObject,'String')) returns contents of EditIterations as a double
% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function ListBoxChromosomes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxChromosomes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
% --- Executes on selection change in ListBoxChromosomes.
function ListBoxChromosomes_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxChromosomes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ListBoxChromosomes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxChromosomes
% ==============================================================================================================================
% --- Executes on button press in ButtonViewCH.
function ButtonViewCH_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonViewCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global CH;
global CHF;
global PLATE;

VALUE=get(handles.ListBoxChromosomes,'Value');
CD=get(handles.ListBoxChromosomes,'String');
[m,n]=size(CD);
if (VALUE>=1) && (VALUE<=m)
    plotChromosome(CH(VALUE,:),PLATE,CHF(VALUE,1));
end
% ==============================================================================================================================
% --- Executes on button press in ButtonGenerateCH.
function ButtonGenerateCH_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonGenerateCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global CH;                          % набір хромосом
global CHF;                         % значення фітнесу для хромосом
global PLATES;                      % параметри пластинок (кожної окремо)
global PLATESSRC;                   % параметри пластинок по групам (довжина х ширина х кількість)
global PLATE;                       % довжина та ширина великої пластини
global INFO;                        % загальна інформація
global BestResult;                  % значення найкращого результату
global GAResult;                    % значення поточного результату
global INFO;

% створюємо масив пластинок
[m,n]=size(PLATESSRC);
PLATES=[];
for i=1:m
    for j=1:PLATESSRC(i,3)
        PLATES=[PLATES; [PLATESSRC(i,1) PLATESSRC(i,2)]];
    end
end
% вибираємо кількість хромосом для генерації
COUNT=get(handles.EditChromosomes,'String');
COUNT=floor(str2num(COUNT));
% генеруємо масив хромосом
[CH,CHF]=getChromosomes(PLATE,PLATES,COUNT,0);
% згенерувавши - записуємо хромосоми зі значеннями фітнесу у ListBox
CD=[];
for i=1:COUNT
    [m,n]=size(CD);
    CURRENT=[num2str(i) ' : ' num2str(CHF(i,1))];
    if n==0
        CD=CURRENT;
    else
        [m1,n1]=size(CURRENT);
        if n>n1
            for j=n1+1:n CURRENT=[CURRENT ' ']; end
        elseif n<n1
            for j=n+1:n1 CD(:,j)=' '; end
        end
        CD=[CD; CURRENT];
    end
end
% записуємо масив отриманих хромосом        
set(handles.ListBoxChromosomes,'String',CD);
set(handles.ListBoxChromosomes,'Value',1);
% очищуємо попередні результати
GAResult=[];
BestResult=[];
INFO=0;
set(handles.ListBoxResults,'String',[]);
set(handles.ListBoxResults,'Value',1);
% ==============================================================================================================================
% --- Executes on button press in ButtonOneIteration.
function ButtonOneIteration_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOneIteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CH;                          % набір хромосом
global CHF;                         % значення фітнесу для хромосом
global BestResult;                  % значення найкращого результату
global GAResult;                    % значення поточного результату
global PLATES;                      % параметри пластинок (кожної окремо)
global PLATESSRC;                   % параметри пластинок по групам (довжина х ширина х кількість)
global PLATE;                       % довжина та ширина великої пластини
global INFO;

PERC=str2num(get(handles.EditMutations,'String'));
[GARes,BestRes,CH,CHF]=GA(1,CH,CHF,PERC,PLATES,PLATE);
CD=get(handles.ListBoxResults,'String');

% додаємо результат до інших результатів
GAResult=[GAResult; GARes];
[m1,n1]=size(BestResult);
if (n1==0)
    BestResult=GARes;
elseif GARes(1,1)<BestResult(1,1)
    BestResult=GARes;
end
% додаємо до списку результатів
[m,n]=size(CD);
INFO=INFO+1;
CURRENT=[num2str(INFO) ' : ' num2str(GARes(1,1))];
if n==0
    CD=CURRENT;
else
    [m1,n1]=size(CURRENT);
    if n>n1
        for j=n1+1:n CURRENT=[CURRENT ' ']; end
    elseif n<n1
        for j=n+1:n1 CD(:,j)=' '; end
    end
    CD=[CD; CURRENT];
end
set(handles.ListBoxResults,'String',CD);
set(handles.ListBoxResults,'Value',INFO);
% визначаємо кількість хромосом
[COUNT,n]=size(CH);
% записуємо хромосоми зі значеннями фітнесу у ListBox
CD=[];
for i=1:COUNT
    [m,n]=size(CD);
    CURRENT=[num2str(i) ' : ' num2str(CHF(i,1))];
    if n==0
        CD=CURRENT;
    else
        [m1,n1]=size(CURRENT);
        if n>n1
            for j=n1+1:n CURRENT=[CURRENT ' ']; end
        elseif n<n1
            for j=n+1:n1 CD(:,j)=' '; end
        end
        CD=[CD; CURRENT];
    end
end
% записуємо масив отриманих хромосом        
set(handles.ListBoxChromosomes,'String',CD);
set(handles.ListBoxChromosomes,'Value',1);

% ==============================================================================================================================
% --- Executes during object creation, after setting all properties.
function ListBoxResults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
% ==============================================================================================================================
% --- Executes on selection change in ListBoxResults.
function ListBoxResults_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ListBoxResults contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxResults
% ==============================================================================================================================
% --- Executes on button press in ButtonViewResults.
function ButtonViewResults_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonViewResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GAResult;
global PLATE;

VALUE=get(handles.ListBoxResults,'Value');
CD=get(handles.ListBoxResults,'String');
[m,n]=size(CD);
[m1,n1]=size(GAResult);
if (VALUE>=1) && (VALUE<=m)
    plotChromosome(GAResult(VALUE,2:n1),PLATE,GAResult(VALUE,1));
end
% ==============================================================================================================================
% --- Executes on button press in ButtonDoGA.
function ButtonDoGA_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonDoGA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global BestResult;
global GAResult;
global INFO;

ITEM=str2num(get(handles.EditIterations,'String'));
%f=figure;
%X=[1:INFO];
%Y=GAResult(1:INFO,1); Y=Y';
%plot(X,Y,'.b');
%get(get(f,'Children'))
for i=1:ITEM
    ButtonOneIteration_Callback(hObject, eventdata, handles);
%    X=[X INFO];
%    Y=[Y GAResult(INFO,1)];
%    set(get(f,'Children'),'XTick',X,'YTick',Y);
end
% ==============================================================================================================================
% --- Executes on button press in ButtonBestCH.
function ButtonBestCH_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonBestCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global BestResult;
global PLATE;

[m,n]=size(BestResult);
if (m==1)
    plotChromosome(BestResult(1,2:n),PLATE,BestResult(1,1));
end

% ==============================================================================================================================
% --- Executes on button press in ButtonClear.
function ButtonClear_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


