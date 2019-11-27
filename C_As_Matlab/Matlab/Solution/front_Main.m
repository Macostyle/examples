function varargout = front_Main(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Main_OpeningFcn, ...
                       'gui_OutputFcn',  @Main_OutputFcn, ...
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

function Main_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
    
    global solve Start_tableCheck Init_VtableCheck Cond_tableDataCheck;
    Start_tableCheck = false;
    Init_VtableCheck = false;
    solve = zeros(0);
    
    initStart_table = {'<html>x''<sub>1</sub></html>', ''};
    
    set(handles.Start_table , 'Data', initStart_table);
    set(handles.SolveTask, 'Enable', 'off');
    set(handles.DeleteSolve, 'Enable', 'off');
    set(handles.TaskResults, 'Enable', 'off');

function varargout = Main_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
       
    
    
%Callbacks (Menu)----------------------------------------------------------

function MainTools_Callback(hObject, eventdata, handles)

function ExamplesLib_Callback(hObject, eventdata, handles)
    try
        global mainHandles;
        mainHandles = guihandles;
        run('front_Example.m');
    catch
        somethingWrong = errordlg('Exception invoked', 'Random Error code');
    end

function Help_Callback(hObject, eventdata, handles)
    run('GUI_Help.m');
        
function About_Callback(hObject, eventdata, handles)
    run('GUI_About.m');

function Exit_Callback(hObject, eventdata, handles)
    close;
    

%Callbacks (Parametrs)-----------------------------------------------------
    
function Start_table_CellEditCallback(hObject, eventdata, handles)
    try
        global Start_tableData;
        set(handles.Save, 'Checked', 'off');
        currentData = get(hObject, 'Data');
        countOfRows = size(currentData, 1);
        newData = zeros(0, 0);
      
        for i = 1:countOfRows
            if i ~= countOfRows
                if strcmp(currentData(i, 2), '')
                    for k = i+1:countOfRows
                        newRowName = ['<html>x''<sub>' num2str(k - 1) '</sub></html>'];
                        newRow = {newRowName, strjoin(currentData(k, 2))};
                        newData = [newData; newRow];
                    end
                    currentData = newData;
                    countOfRows = size(currentData, 1);
                    set(hObject, 'Data', currentData);
                    Start_tableDataTaskTableData = currentData;
                    break;
                else
                    newRowName = ['<html>x''<sub>' num2str(i) '</sub></html>'];
                    newRow = {newRowName, strjoin(currentData(i, 2))};
                    newData = [newData; newRow];
                end
            else
                newRowName = ['<html>x''<sub>' num2str(i) '</sub></html>'];
                newRow = {newRowName, strjoin(currentData(i, 2))};
                newData = [newData; newRow];
                currentData = newData;
                countOfRows = size(currentData, 1);
                
                if strcmp(currentData(i, 2), '')
                    set(hObject, 'Data', currentData);
                    Start_tableData = currentData;
                else
                    newRowName = ['<html>x''<sub>' num2str((countOfRows + 1)) '</sub></html>'];
                    newRow = {newRowName, ''};
                    newData = [currentData; newRow];
                    set(hObject, 'Data', newData);
                    Start_tableData = newData;
                end
            end
        end
        
        currentData = get(hObject, 'Data');
        condData = get(handles.Cond_table, 'Data');
        initData = get(handles.Init_Vtable, 'Data');
        
        if strcmp(currentData(end, 2), '') 
            if (size(currentData, 1) - 1) > size(condData, 1)
                condData = [condData; {''}];
                initData = [initData {''}];
            end
            if (size(currentData, 1) - 1) < size(condData, 1)
                condData = condData(1:end-1, :);
                initData = initData(:, 1:end-1);
            end
        else
            if size(currentData, 1) > size(condData, 1)
                condData = [condData; {''}];
                initData = [initData {''}];
            end
            if size(currentData, 1) < size(condData, 1)
                condData = condData(1:end-1, :);
                initData = initData(:, 1:end-1);
            end
        end
        
        set(handles.Cond_table, 'Data', condData);
        set(handles.Init_Vtable, 'Data', initData);
        
        T1 = get(handles.Cond_table, 'Data');
        T2 = get(handles.Init_Vtable, 'Data');
        T3 = get(hObject, 'Data');
        
        n = size(T3, 1)-1;
        
        for i = 1:n
            if strcmp(T1(n, 1), '') || strcmp(T2(1, n), '') || strcmp(T3(n, 2), '')
                set(handles.TaskResults, 'Enable', 'off');
                set(handles.SolveTask, 'Enable', 'off');
                set(handles.DeleteSolve, 'Enable', 'off');
                return
            end
        end
        set(handles.SolveTask, 'Enable', 'on');
        set(handles.TaskResults, 'Enable', 'off');
        set(handles.DeleteSolve, 'Enable', 'off');
    catch
        somethingWrong = errordlg('Start table problem', 'Random Error code');
    end
    
function Cond_table_CellEditCallback(hObject, eventdata, handles)
    global Cond_tableData;
    Cond_tableData = get(hObject, 'Data'); 
    set(handles.SolveTask, 'Enable', 'on');
    set(handles.TaskResults, 'Enable', 'off');
    set(handles.DeleteSolve, 'Enable', 'off');

function SegBegin_Callback(hObject, eventdata, handles)
        global segBegin;
        segBegin = get(hObject, 'String');
        segBegin = sym(segBegin);
        segBegin = double(segBegin);
        uicontrol(handles.SegEnd);

function SegEnd_Callback(hObject, eventdata, handles)
        global segEnd;
        segEnd = get(hObject, 'String');
        segEnd = sym(segEnd);
        segEnd = double(segEnd);
        uicontrol(handles.StepsCount);

function StepsCount_Callback(hObject, eventdata, handles)
        global stepsCount;
        stepsCount = get(hObject, 'String');
        stepsCount = sym(stepsCount);
        stepsCount = double(stepsCount);
        uicontrol(handles.AccuracyExternal);

function AccuracyExternal_Callback(hObject, eventdata, handles)
        global accuracyExternal;
        accuracyExternal = get(hObject, 'String');
        accuracyExternal = sym(accuracyExternal);
        accuracyExternal = double(accuracyExternal);
        uicontrol(handles.AccuracyInternal);

function AccuracyInternal_Callback(hObject, eventdata, handles)
        global accuracyInternal;
        accuracyInternal = get(hObject, 'String');
        accuracyInternal = sym(accuracyInternal);
        accuracyInternal = double(accuracyInternal);
        uicontrol(handles.SM_external);

function SM_external_Callback(hObject, eventdata, handles)
    global SM_external SM_externalName;
    SM_external = get(hObject, 'Value');
    SM_externalName = get(hObject, 'String');
    SM_externalName = SM_externalName(SM_external);
    uicontrol(handles.SM_internal);

function SM_internal_Callback(hObject, eventdata, handles)
    global SM_internal SM_internalName;
    SM_internal = get(hObject, 'Value');
    SM_internalName = get(hObject, 'String');
    SM_internalName = SM_internalName(SM_internal);
    uicontrol(handles.StepSize);
    
function StepSize_Callback(hObject, eventdata, handles)
        global stepSize;
        stepSize = get(hObject, 'String');
        stepSize = sym(stepSize);
        stepSize = double(stepSize);
        uicontrol(handles.TimeOfT);
    
function TimeOfT_Callback(hObject, eventdata, handles)
        global timeOfT;
        timeOfT = get(hObject, 'String');
        timeOfT = sym(timeOfT);
        timeOfT = double(timeOfT);

function Init_Vtable_CellEditCallback(hObject, eventdata, handles)
    global Init_VtableData;
    Init_VtableData = get(hObject, 'Data');
    Init_VtableData = sym(Init_VtableData);
    Init_VtableData = double(Init_VtableData);
    
    set(handles.SolveTask, 'Enable', 'on');
    set(handles.TaskResults, 'Enable', 'off');
    set(handles.DeleteSolve, 'Enable', 'off');


% Callbacks (Solve)--------------------------------------------------------
function SolveTask_Callback(hObject, eventdata, handles)
    try
        global solve Start_tableData Cond_tableData segBegin;
        global segEnd stepsCount accuracyExternal accuracyInternal;
        global SM_internal SM_external timeOfT Init_VtableData;
        global stepSize; 
        tic;
        set(handles.TaskResults, 'Enable', 'on');
        set(handles.DeleteSolve, 'Enable', 'on');

        solve = solve_eq(Start_tableData, Cond_tableData, segBegin, segEnd, stepsCount, accuracyExternal, accuracyInternal, SM_internal, stepSize, SM_external, timeOfT, Init_VtableData);
    catch
%         somethingWrong = errordlg('Solve problems', 'Random Error code');
    end

function TaskResults_Callback(hObject, eventdata, handles)
    try      
       run('front_Results.m');
    catch
        somethingWrong = errordlg('Results problems', 'Random Error code');
    end

function DeleteSolve_Callback(hObject, eventdata, handles)
        set(hObject, 'Enable', 'off');
        set(handles.TaskResults, 'Enable', 'off');  
        global solve;
        solve = zeros(0);
    

%KeyPressFcns -------------------------------------------------------------

function SegBegin_KeyPressFcn(hObject, eventdata, handles)

    
function SegEnd_KeyPressFcn(hObject, eventdata, handles)


function StepsCount_KeyPressFcn(hObject, eventdata, handles)


function AccuracyExternal_KeyPressFcn(hObject, eventdata, handles)
 

function AccuracyInternal_KeyPressFcn(hObject, eventdata, handles)


function TimeOfT_KeyPressFcn(hObject, eventdata, handles)

    
function StepSize_KeyPressFcn(hObject, eventdata, handles)
    


%CreateFcns----------------------------------------------------------------
function SegBegin_CreateFcn(hObject, eventdata, handles)
    global segBegin;
    segBegin = 0;
    
function SegEnd_CreateFcn(hObject, eventdata, handles)
    global segEnd;
    segEnd = 1;
    
function StepsCount_CreateFcn(hObject, eventdata, handles)
    global stepsCount;
    stepsCount = 1;

function AccuracyExternal_CreateFcn(hObject, eventdata, handles)
    global accuracyExternal;
    accuracyExternal = 0.001;

function AccuracyInternal_CreateFcn(hObject, eventdata, handles)
    global accuracyInternal;
    accuracyInternal = 0.001;

function SM_external_CreateFcn(hObject, eventdata, handles)
    global SM_external SM_external_Name;
    SM_external = 1;
    SM_external_Name = 'ode45';
    
function SM_internal_CreateFcn(hObject, eventdata, handles)
    global SM_internal SM_internal_Name;
    SM_internal = 1;
    SM_internal_Name = 'ode45';

function TimeOfT_CreateFcn(hObject, eventdata, handles)
    global timeOfT;
    timeOfT = 0;
    
function StepSize_CreateFcn(hObject, eventdata, handles)
    global stepSize;
    stepSize = 0.01;
%CreateFcns of task parametrs


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
