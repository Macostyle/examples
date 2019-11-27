function varargout = front_Example(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Example_OpeningFcn, ...
                       'gui_OutputFcn',  @Example_OutputFcn, ...
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

function Example_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

function varargout = Example_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;

function ExamplesListbox_Callback(hObject, eventdata, handles)

function ExamplesListbox_CreateFcn(hObject, eventdata, handles)

function OpenExample_Callback(hObject, eventdata, handles)
    try
        switch get(handles.ExamplesListbox, 'Value')
            case 1
                fileName = 'Examples/kray';
            case 2
                fileName = 'Examples/ekv';
            case 3
                fileName = 'Examples/energy';
        end
        
        global solve inputTaskTableData conditionsTableData segBegin;
        global segEnd stepsCount stepSize accuracyExternal accuracyInternal solvingMethodForExternalTask solvingMethodForInternalTask timeOfT initialVectorTableData;
        global mainHandles;
        
        load(fileName, 'solve', 'stepsCount', 'inputTaskTableData', 'conditionsTableData', 'segBegin', 'segEnd', 'stepsCount', 'accuracyExternal', 'accuracyInternal', 'solvingMethodForExternalTask', 'solvingMethodForInternalTask','timeOfT', 'initialVectorTableData', 'buttons');
        
        set(mainHandles.Start_table, 'Data', inputTaskTableData);
        set(mainHandles.Cond_table, 'Data', conditionsTableData);
        set(mainHandles.SegBegin, 'String', segBegin);
        set(mainHandles.SegEnd, 'String', segEnd);
        set(mainHandles.StepsCount, 'String', stepsCount);
        set(mainHandles.StepSize, 'String', stepSize);
        set(mainHandles.AccuracyExternal, 'String', accuracyExternal);
        set(mainHandles.AccuracyInternal, 'String', accuracyInternal);
        set(mainHandles.SM_external, 'Value', solvingMethodForExternalTask);
        set(mainHandles.SM_internal, 'Value', solvingMethodForInternalTask);
        set(mainHandles.TimeOfT, 'String', timeOfT);
        set(mainHandles.Init_Vtable, 'Data', initialVectorTableData);
        set(mainHandles.SolveTask, 'Enable', char(buttons(1, 1)));
        set(mainHandles.DeleteSolve, 'Enable', char(buttons(2, 1)));
        set(mainHandles.TaskResults, 'Enable', char(buttons(3, 1)));
        close;
    catch
        somethingWrong = errordlg('Example problems', 'Random Error code');
    end

function CloseExampleWindow_Callback(hObject, eventdata, handles)
    close;
