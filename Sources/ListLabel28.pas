{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : ListLabel28.pas
 Module : List & Label 28
 Descr. : Implementation file for the List & Label 28 VCL-Component
 Version: 28.001
==================================================================================
}

unit ListLabel28;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Messages, Dialogs, DB, LLReport_Types, cmbtll28x, l28CommonInterfaces, l28FireDACInterfaces, Vcl.Menus, Vcl.AxCtrls,
     ComCtrls, Vcl.Imaging.jpeg, System.Contnrs, System.SyncObjs, LLDataProvider, LLDataSetDataProvider, System.Generics.Collections, activex, System.StrUtils, System.Types;

type

  TString = UnicodeString;
  PXChar = PWideChar;
  XChar  = WideChar;
  cmbtHWND = DWORD_PTR; // needed for C++Builder compatibility
  TObjectType = (otMarker, otText, otRectangle, otLine, otBarcode, otTable, otTemplate, otEllipse, otGroup, otRTF, otExtensionObject);

  TLlDesignerObject28PrintState = (llxpsWaiting, llxpsUnfinished, llxpsFinished, llxpsPastFinished);
  TCreateObjectEvent = procedure(Sender:TObject; ParentHandle: cmbtHWND) of object;
  TEditObjectEvent = procedure(Sender:TObject; ParentHandle: cmbtHWND; var HasChanged: Boolean) of object;
  TDrawObjectEvent = procedure(Sender:TObject; Canvas: TCanvas; Rect: TRect; IsDesignMode: boolean; var IsFinished: boolean) of object;
  TClickEvent = procedure(Sender: TObject; Canvas: TCanvas; Point: TPoint; ParentHandle: cmbtHWND) of object;
  TGetVariableSizeInfoEvent = procedure(Sender: TObject; const hDC: HDC; const Width: integer; var MinimumHeight, IdealHeight: integer) of object;
  TResetPrintStateEvent = procedure(Sender: TObject) of object;
  TLDesignerAction28InsertionType=(itAppend, itInsert);
  TLDesignerAction28LlActionState=(asEnabled, asDisabled);
  TExecuteActionEvent = procedure of object;
  TGetActionStateEvent = procedure(var state: TLDesignerAction28LlActionState) of object;
  TLlDesignerFunction28ParameterType=(ptAll, ptDouble,ptDate,ptBool,ptString,ptDrawing,ptBarcode);
  TEvaluateFunctionEvent = procedure(Sender:TObject; var ResultType: TLlDesignerFunction28ParameterType; var ResultValue: OleVariant; var DecimalPositions: integer; const ParameterCount: Integer; const Parameter1,Parameter2,Parameter3,Parameter4: OleVariant) of object;
  TParameterAutoCompleteEvent = procedure(Sender: TObject; ParameterIndex: integer; var Values: TStringList) of object;
  TCheckFunctionSyntaxEvent = procedure(Sender:TObject; var IsValid: bool; var ErrorText: String; var ResultType: TLlDesignerFunction28ParameterType; var DecimalPositions: integer; const ParameterCount: Integer; const Parameter1,Parameter2,Parameter3,Parameter4: OleVariant) of object;
  TLlRTFTextMode = (tmRTF, tmPlain);
  TLlRTFContentMode = (cmRaw, cmEvaluated);
  TLlRTFPrintState = (psPending, psFinished);
  ENoParentComponentError = class(Exception);
  TListLabel28 = class;

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TLlRTFControl28 = class(TCustomControl)
private
  FHandle: HLLRTFOBJ;
  FContentMode: TLlRTFContentMode;
  FPrintState: TLlRTFPrintState;
  FTextMode: TLlRTFTextMode;
  FMyParentComponent: TListLabel28;
  FFirst: boolean;
  procedure SetContentMode(const Value: TLlRTFContentMode);
  procedure SetPrintState(const Value: TLlRTFPrintState);
  procedure SetText(const Value: TString);
  procedure SetTextMode(const Value: TLlRTFTextMode);
  function GetText: TString;
  procedure SetMyParentComponent(const Value: TListLabel28);

protected
  procedure WndProc(var Message: TMessage); override;
public
  destructor Destroy; override;
  constructor Create(AOwner: TComponent); override;
  procedure CreateWnd; override;
  property Text: TString read GetText write SetText;
  property PrintState: TLlRTFPrintState read FPrintState write SetPrintState;
  function ProhibitAction(ControlID: integer):integer;
published
  property TabStop;
  property TabOrder;
  Property Align;
  property ParentComponent: TListLabel28 read FMyParentComponent write SetMyParentComponent;
  function CopyToClipboard: integer;
  function Display(Canvas: TCanvas; Rect: TRect; FromStart: boolean): integer;
  property TextMode: TLlRTFTextMode read FTextMode write SetTextMode;
  property ContentMode: TLlRTFContentMode read FContentMode write SetContentMode;
end;

TLlDesignerFunction28Parameter=class(TPersistent)
private
    FParameterDescription: String;
    FParameterType: TLlDesignerFunction28ParameterType;
    procedure SetParameterDescription(const Value: String);
    procedure SetParameterType(const Value: TLlDesignerFunction28ParameterType);
published
    property ParameterType: TLlDesignerFunction28ParameterType read FParameterType write SetParameterType;
    property ParameterDescription: String read FParameterDescription write SetParameterDescription;
end;

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TLlDesignerFunction28=class(TComponent,ILlXFunction,IUnknown)
private
  FParent:TListLabel28;
  FILlBase: pILlBase;
  FLLJob: HLLJOB;
  FRefCount: Integer;
  FLanguage: integer;
  FHLib : HMODULE;

  FMaximumParameters: integer;
  FMinimumParameters: integer;
  FParameter1: TLlDesignerFunction28Parameter;
  FParameter2: TLlDesignerFunction28Parameter;
  FParameter3: TLlDesignerFunction28Parameter;
  FParameter4: TLlDesignerFunction28Parameter;
  FResultType: TLlDesignerFunction28ParameterType;
  FVisible: boolean;
  FGroupName: String;
  FFunctionName: String;
  FDescription: String;
  FOnCheckFunctionSyntax: TCheckFunctionSyntaxEvent;
  FOnEvaluateFunction: TEvaluateFunctionEvent;
  FOnParameterAutoComplete: TParameterAutoCompleteEvent;
  procedure SetMaximumParameters(const Value: integer);
  procedure SetMinimumParameters(const Value: integer);
  procedure SetParameter1(const Value: TLlDesignerFunction28Parameter);
  procedure SetParameter2(const Value: TLlDesignerFunction28Parameter);
  procedure SetParameter3(const Value: TLlDesignerFunction28Parameter);
  procedure SetParameter4(const Value: TLlDesignerFunction28Parameter);
  procedure SetResultType(const Value: TLlDesignerFunction28ParameterType);
  procedure SetMyParentComponent(const Value: TListLabel28);
  procedure SetFunctionName(const Value: String);
  procedure SetGroupName(const Value: String);
  procedure SetVisible(const Value: boolean);
  procedure SetDescription(const Value: String);
  procedure SetOnCheckFunctionSyntax(const Value: TCheckFunctionSyntaxEvent);
  procedure SetOnEvaluateFunction(const Value: TEvaluateFunctionEvent);
  procedure SetOnParameterAutoComplete(const Value: TParameterAutoCompleteEvent);
protected
  function GetParameterTypeText(Value: TLlDesignerFunction28ParameterType):String;
  function GetLlFctparaTypeFromParamType(Value: TLlDesignerFunction28ParameterType): integer;
  function GetLlFieldTypeFromParamType(Value: TLlDesignerFunction28ParameterType): integer;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
  function SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult; stdcall;
  function SetOption (const nOption: integer; nValue: lParam): HResult;  stdcall;
  function GetOption (const nOption: integer; var pnValue: lParam): HResult; stdcall;
  function GetName(var pbsName: OLEString): HResult; stdcall;  // get name.
  function GetDescr(var pbsDescr: OLEString):HResult; stdcall; // get description
  function GetGroups(var pbsDescr: OLEString):HResult;  stdcall;
  function GetGroupDescr(const bsGroup:OLEString; var pbsDescr:OLEString): HResult; stdcall;
  function GetParaCount(var pnMinParas,pnMaxParas: integer): HResult; stdcall;
  function GetParaTypes(var pnTypeRes, pnTypeArg1, pnTypeArg2, pnTypeArg3, pnTypeArg4: integer): HResult; stdcall;
  function CheckSyntax(var pbsError: OLEString; var pnTypeRes: integer; var pnTypeResLL: cardinal; var pnDecs: cardinal; const nArgs: cardinal; VarArg1,VarArg2,VarArg3,VarArg4: OleVariant): HResult; stdcall;
  function Execute(var pVarRes: OleVariant; var pnTypeRes: integer; var pnTypeResLL: cardinal; var pnDecs: cardinal; const nArgs: cardinal; VarArg1,VarArg2,VarArg3,VarArg4: OleVariant) : HResult; stdcall;
  function GetVisibleFlag(var pbVisible: boolean) : HResult; stdcall;
  function GetParaValueHint(const nPara: integer; var pbsHint,pbsTabbedList: OLEString): HResult; stdcall;// nPara = 0..3
published
  property MinimumParameters: integer read FMinimumParameters write SetMinimumParameters;
  property MaximumParameters: integer read FMaximumParameters write SetMaximumParameters;
  property ResultType: TLlDesignerFunction28ParameterType read FResultType write SetResultType;
  property Parameter1: TLlDesignerFunction28Parameter read FParameter1 write SetParameter1;
  property Parameter2: TLlDesignerFunction28Parameter read FParameter2 write SetParameter2;
  property Parameter3: TLlDesignerFunction28Parameter read FParameter3 write SetParameter3;
  property Parameter4: TLlDesignerFunction28Parameter read FParameter4 write SetParameter4;
  property ParentComponent: TListLabel28 read FParent write SetMyParentComponent;
  property FunctionName: String read FFunctionName write SetFunctionName;
  property Description: String read FDescription write SetDescription;
  property GroupName: String read FGroupName write SetGroupName;
  property Visible: boolean read FVisible write SetVisible;
  property OnEvaluateFunction: TEvaluateFunctionEvent read FOnEvaluateFunction write SetOnEvaluateFunction;
  property OnParameterAutoComplete: TParameterAutoCompleteEvent read FOnParameterAutoComplete write SetOnParameterAutoComplete;
  property OnCheckFunctionSyntax: TCheckFunctionSyntaxEvent read FOnCheckFunctionSyntax write SetOnCheckFunctionSyntax;
end;

TListLabelDesignerProperty = class
protected
  FKeyList: TStringList;
  FValueList: TStringList;
public
  constructor create;
  constructor CreateCopy(Base: TListLabelDesignerProperty);
  destructor Destroy; override;
  procedure AddProperty(Key, Value: String);
  procedure SaveToStream(const Stream: IStream);
  procedure LoadFromStream(const Stream: IStream);
  function ContainsKey(Key: String): boolean;
  procedure RemoveProperty(Key: String);
  function GetValue(Key: String; var Value: String): boolean;
end;

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TLlDesignerObject28=class(TComponent,ILlXObject,IUnknown)
private
  fParent: TListLabel28;
  FFontHandle: THandle;
  FFontColor: TColor;
  FFontSize: integer;
  FCommandHandlerList: TList;
  FPrintState: TLlDesignerObject28PrintState;
  FOnClick: TClickEvent;
  FPopupMenu: TPopupMenu;
  FHint: String;
  FTooltipDescription: String;
  FOnGetVariableSizeInfo: TGetVariableSizeInfoEvent;
  FSupportsMultipage: boolean;
  FOnResetPrintState: TResetPrintStateEvent;
  procedure SetMyParentComponent(const Value: TListLabel28);
  procedure SetOnClick(const Value: TClickEvent);
  procedure SetPopupMenu(const Value: TPopupMenu);
  procedure SetHint(const Value: String);
  procedure SetOnGetVariableSizeInfo(const Value: TGetVariableSizeInfoEvent);
  procedure SetSupportsMultipage(const Value: boolean);
  procedure SetOnResetPrintState(const Value: TResetPrintStateEvent);
protected
  FRefCount: Integer;
  FILlXObjectNtfySink: pILlXObjectNtfySink ;
  FILlBase: pILlBase;
  FLLJob: HLLJOB;
  FIsCopy: boolean;

  FObjectName: String;
  FDescription: String;
  FOnInitialCreation: TCreateObjectEvent;
  FOnDraw: TDrawObjectEvent;
  FOnEdit: TEditObjectEvent;
  FIcon: TIcon;
  FLargeRibbonImage: TBitmap;
  FSmallRibbonImage: TBitmap;
  procedure SetDescription(const Value: String);
  procedure SetIcon(const Value: TIcon);
  procedure SetLargeRibbonImage(const Value: TBitmap);
  procedure SetSmallRibbonImage(const Value: TBitmap);
  procedure SetObjectName(const Value: String);
  procedure SetTooltipDescription(const Value: String);
  procedure SetOnDraw(const Value: TDrawObjectEvent);
  procedure SetOnEdit(const Value: TEditObjectEvent);
  procedure SetOnInitialCreation(const Value: TCreateObjectEvent);
public
  Properties: TListLabelDesignerProperty;
  constructor Create(AOwner: TComponent); override;
  constructor CreateCopy(AOwner:TComponent; Base: TLlDesignerObject28);
  destructor Destroy; override;
  function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
  function SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult; stdcall;
  function GetName(var pbsName: OLEString): HResult; stdcall;  // get name.
  function GetDescr(var pbsDescr: OLEString):HResult; stdcall; // get description
  function GetIcon(var phIcon: HIcon):HResult; stdcall;// get icon (must be released by LLX object)
  function IsProjectSupported(const nProjType: integer; var pbSupported: boolean): HResult;stdcall; // is project type (LL_PROJECT_xxx) supported
  function SetOption (const nOption: integer; nValue: lParam): HResult;  stdcall;
  function GetOption (const nOption: integer; var pnValue: lParam): HResult; stdcall;
  function SetOptionString(const sOption: OLEString; sValue:OLEString): HResult;stdcall;
  function GetOptionString(const sOption: OLEString; var psValue:OLEString): HResult;stdcall;
  function SetParameters(pIStream: IStream): HResult;stdcall;
  function GetParameters(pIStream: IStream ): HResult; stdcall;
  function Clone (var pIObject):HResult; stdcall;
  function FirstCreation(const hWndParent: cmbtHWND):HResult; stdcall;// Wizard?
  function GetMinDimensionsSCM(const bForNew: boolean; var ptMinSize: Size):HResult; stdcall;
  function Show(const hDC: HDC; var prcPaint: TRect; const hExportProfJob: HPROFJOB; const hExportProfList: HPROFLIST; const nExportVerbosity: integer; const nDestination: integer; const bSelected: boolean):HResult ;stdcall;
  function GetTrueRec(var prc: TRect):HResult ;stdcall;	// label, card projects only :-)
  function GetErrorcode: longint;stdcall;
  function AllowPageBreak:HResult ;stdcall;
  function ResetPrintState:HResult ;stdcall;
  function ForceResetPrintState:HResult ;stdcall;
  function PrintWaiting:HResult ;stdcall;
  function PrintUnfinished:HResult ;stdcall;
  function PrintFinished:HResult ;stdcall;
  function PrintPastFinished:HResult ;stdcall;
  function SetNtfySink(pNtfySink: pILlXObjectNtfySink):HResult ;stdcall; // must inc ref count and release when finished
  function Edit(const hWnd: cmbtHWND;ptMouse: TPoint):HResult ;stdcall;// S_FALSE for aborted, pNtfySink may be NULL!!!
  function ClearEditPartInfo:HResult ;stdcall;
  function CanEditPart(ptMouse: TPoint; var phMenu: hMenu):HResult ;stdcall; // item ID 10000 ff
  function EditPart(const hWnd: cmbtHWND;ptMouse: TPoint; const nMenuID: cardinal):HResult ;stdcall;
  function CancelEditPart:HResult ;stdcall;
  function OnDragDrop(pDataObj: IDataObject;const grfKeyState: Longword;p: TPoint; var pdwEffect: Longword; const bQuery: boolean):HResult ;stdcall;
  function IsSetFontSupported(var pbSupported: boolean):HResult ;stdcall;
  function SetFont(var pLF: LOGFONT; const nSize: cardinal; const rgbColor: COLORREF):HResult ;stdcall;
  function OnObject(const hDC: HDC; ptMouse: TPoint):HResult ;stdcall;
  function InObject(const hDC: HDC; ptMouse: TPoint):HResult ;stdcall;
  function CalcDistanceToFrame(const hDC: HDC; ptMouse: TPoint; var pnDistance: cardinal):HResult ;stdcall; // return in device coords - sorry, historical reasons! Return 65535 for non-inside click
  function OnMouseMove(const hDC: HDC; ptMouse: TPoint; var phCrs: hCursor) :HResult ;stdcall;  // S_FALSE for original cursor
  function OnMouseLButton(const hDC: HDC; ptMouse: TPoint; const hWnd: cmbtHWND) :HResult ;stdcall;
  function OnDeclareChartRow:HResult ;stdcall;
  function CanCreateObjectFromType(const nLLType: integer; const sVarName: OLEString; var prcCreate: TRect):HResult;stdcall;
  function GetVarSizeInfo(const hDC: HDC; const prcSpaceAvailable: cmbtll28x.pTRect; var pnMinHeight,pnIdealHeight: integer): HRESULT; stdcall;
published
  property Description: String read FDescription write SetDescription;
  property Hint: String read FHint write SetHint;
  property ParentComponent: TListLabel28 read FParent write SetMyParentComponent;
  property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
  property Icon: TIcon read FIcon write SetIcon;
  property LargeRibbonImage: TBitmap read FLargeRibbonImage write SetLargeRibbonImage;
  property SmallRibbonImage: TBitmap read FSmallRibbonImage write SetSmallRibbonImage;
  property ObjectName: String read FObjectName write SetObjectName;
  property TooltipDescription: String read FTooltipDescription write SetTooltipDescription;
  property SupportsMultipage: boolean read FSupportsMultipage write SetSupportsMultipage;
  property OnEdit: TEditObjectEvent read FOnEdit write SetOnEdit;
  property OnInitialCreation: TCreateObjectEvent read FOnInitialCreation write SetOnInitialCreation;
  property OnDraw: TDrawObjectEvent read FOnDraw write SetOnDraw;
  property OnClick: TClickEvent read FOnClick write SetOnClick;
  property OnGetVariableSizeInfo: TGetVariableSizeInfoEvent read FOnGetVariableSizeInfo write SetOnGetVariableSizeInfo;
  property OnResetPrintState: TResetPrintStateEvent read FOnResetPrintState write SetOnResetPrintState;
end;

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TLDesignerAction28=class(TComponent)
private
  FParent: TListLabel28;
  FAddToToolbar: boolean;
  FIconId: integer;
  FInsertionType: TLDesignerAction28InsertionType;
  FMenuHierachy: string;
  FMenuText: string;
  FTooltipText: string;
  FMenuId: integer;
  FOnGetActionState: TGetActionStateEvent;
  FShortCut: TShortCut;
  FOnExecuteAction: TExecuteActionEvent;
  procedure SetMenuId(const Value: integer);
  procedure SetOnGetActionState(const Value: TGetActionStateEvent);
  procedure SetShortCut(const Value: TShortCut);
  procedure SetOnExecuteAction(const Value: TExecuteActionEvent);
  property MenuId: integer read FMenuId write SetMenuId;
  procedure AddAction;
  procedure SetMyParentComponent(const Value: TListLabel28);
  procedure SetToToolbar(const Value: boolean);
  procedure SetIconId(const Value: integer);
  procedure SetInsertionType(const Value: TLDesignerAction28InsertionType);
  procedure SetMenuHierachy(const Value: string);
  procedure SetMenuText(const Value: string);
  procedure SetTooltipText(const Value: string);
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
published
  property AddToToolbar: boolean read FAddToToolbar write SetToToolbar;
  property IconId: integer read FIconId write SetIconId;
  property InsertionType: TLDesignerAction28InsertionType read FInsertionType write SetInsertionType;
  property MenuHierachy: string read FMenuHierachy write SetMenuHierachy;
  property MenuText: string read FMenuText write SetMenuText;
  property ParentComponent: TListLabel28 read FParent write SetMyParentComponent;
  property ShortCut: TShortCut read FShortCut write SetShortCut;
  property TooltipText: string read FTooltipText write SetTooltipText;
  property OnExecuteAction: TExecuteActionEvent read FOnExecuteAction write SetOnExecuteAction;
  property OnGetActionState: TGetActionStateEvent read FOnGetActionState write SetOnGetActionState;
end;


TDefinePrintOptionsEvent = procedure(Sender: TObject) of object;
TAutoDefineNewPageEvent = procedure(Sender: TObject; IsDesignMode: boolean) of object;
TAutoDefineNewLineEvent = procedure(Sender: TObject; IsDesignMode: boolean) of object;
TAutoDefineFieldEvent = procedure(Sender: TObject; IsDesignMode: boolean; var FieldName, FieldContent: TString; var FieldType: integer; var IsHandled: boolean) of object;
TAutoDefineVariableEvent = procedure(Sender: TObject; IsDesignMode: boolean; var VariableName, VariableContent: TString; var VariableType: integer; var IsHandled: boolean) of object;
TSaveFileNameEvent = procedure(Sender: TObject; FileName: TString) of object;
TPrintJobInfoEvent = procedure(Sender: TObject; LlJobID: HLLJOB; DeviceName: TString; JobID: cardinal; JobStatus: cardinal) of object;
TProjectLoadedEvent = procedure(Sender: TObject) of object;
TProjectEvent = procedure(Sender: TObject; IsDesignerPreview: boolean; IsPreDraw: boolean; Canvas: TCanvas; Rect: TRect) of object;
TObjectEvent = procedure(Sender: TObject; ObjectName: TString;
   ObjectType: TObjectType; IsPreDraw: boolean; Canvas: TCanvas; Rect: TRect; var EventResult: NativeInt) of object;
TPageEvent = procedure(Sender: TObject; IsDesignerPreview: boolean;
  IsPreDraw: boolean; var Canvas: TCanvas; Rect: TRect) of object;
TAutoNotifyProgress = procedure(Sender: TObject; Progress: integer) of object;
LlCore = class;
TListLabelExportOptions = class;
TLlExprEvaluator = class;


TDesignerFunctions = class(TList)

public
  procedure Add(TheFunction: TLlDesignerFunction28);

end;

TDesignerObjects = class(TList)

public
  procedure Add(TheObject: TLlDesignerObject28);

end;

TDesignerActions = class(TList)

public
  procedure Add(TheAction: TLDesignerAction28);

end;

  // ==============================================================================================
  // TListLabel28
  // ==============================================================================================

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TListLabel28 = class(TComponent, ILlDomParent)
private
  FCore: LlCore;
  FAddVarsToFields: Boolean;
  FAutoBoxType: TLlAutoBoxType;
  FAutoDesignerPreview: Boolean;
  FAutoDestination: TLlPrintMode;
  FAutoProjectType: TLlProject;
  FAutoDialogTitle: String;
  FAutoFileAlsoNew: Boolean;
  FAutoProjectFile: String;
  FAutoShowSelectFile: Boolean;
  FAutoShowPrintOptions: Boolean;
  FCompressStorage: Boolean;
  FConvertCRLF: Boolean;
  FDelayTableHeader: Boolean;
  FIncludeFontDescent: Boolean;
  FIncrementalPreview: Boolean;
  FLicensingInfo: String;
  FNoParameterCheck: Boolean;
  FVarCaseSensitive: Boolean;
  FUnits: TLlUnits;
  FProjectPassword: String;
  FPreviewZoom: Integer;
  FMaximumIdleIterationsPerObject: Integer;
  FMaxRTFVersion: Integer;
  FPrinterless: Boolean;
  FDebug: TLlDebugFlags;
  FTableColoring: TLlTableColoring;
  FLanguage: TLlLanguage;
  FBaseJob: HLLJOB;
  FIsPrinting: Boolean;
  FDomDataProvider: TDataSetDataProvider;
  FNoPrintJobSupervision: Boolean;
  FNumCopies: Integer;
  lpfnNtfyProc: TFarProc;
  FShowErrors: Boolean;
  FDataController: TLLDataController;
  CurrentJobHandle: HJob;

  FPreviewCritSect : TCriticalSection;
  FDrillCritSect   : TCriticalSection;

  FPreviewThread   : TThread;
  FDrillDownThread : TThread;
  FDrillDownJobId  : integer;
  FDrilldownActive : Boolean;

  FRootTables : TStringList;
  FPassedTables: TStringList;
  FRelationsOfCurrentProvider: TObjectList<TListLabelTableRelation>;
  FPassedRelations: TObjectList<TListLabelTableRelation>;
  FDelayedRelations: TObjectList<TListLabelTableRelation>;
  FUsedIdentifiers: TStringList;
  FExportOptions: TListLabelExportOptions;
protected

  Meta: TMetafile;
  FOnDefinePrintOptionsEvent: TDefinePrintOptionsEvent;
  FOnAutoDefineField: TAutoDefineFieldEvent;
  FOnAutoDefineVariable: TAutoDefineVariableEvent;
  FOnAutoDefineNewPage: TAutoDefineNewPageEvent;
  FOnAutoDefineNewLine: TAutoDefineNewLineEvent;
  FOnAutoNotifyProgress: TAutoNotifyProgress;
  FOnSaveFileName: TSaveFileNameEvent;
  FOnPrintJobInfo: TPrintJobInfoEvent;
  FOnProjectLoaded: TProjectLoadedEvent;
  FOnProjectCallback: TProjectEvent;
  FOnObjectCallback: TObjectEvent;
  FOnPageCallback: TPageEvent;
  FLlXFunctionList: TDesignerFunctions;
  FLlXObjectList: TDesignerObjects;
  FLlXInterface: LlXInterface;
  FLlXActionList: TDesignerActions;
  property RootTables: TStringList read FRootTables;
  property PassedTables: TStringList read FPassedTables;
  property IsPrinting: Boolean read FIsPrinting;
  property DelayedRelations: TObjectList<TListLabelTableRelation> read FDelayedRelations;
  property PassedRelations: TObjectList<TListLabelTableRelation> read FPassedRelations;
  property RelationsOfCurrentProvider: TObjectList<TListLabelTableRelation> read FRelationsOfCurrentProvider;
  property UsedIdentifiers: TStringList read FUsedIdentifiers write FUsedIdentifiers;

  Function  InitDataProvider(JobHandle:HJob; DrillDownFilter: PFilterDescription): TDataSetDataProvider;
  Procedure DefineData(DataProvider: TDataSetDataProvider; table: TListLabelTable);
  Procedure DefineSortOrders(table: TListLabelTable);
  Procedure DefineRelatedTables(DataProvider: TDataSetDataProvider; TableName: String);
  Procedure PassTableAndHierarchy(DataProvider: TDataSetDataProvider; relation: TListLabelTableRelation; TableName: String;onlyFor1To1Relations: boolean);
  procedure GetChildTables(DataProvider: TDataSetDataProvider;TableName: string; var Tables: TStringList);
  procedure FillRootTables(DataProvider: TDataSetDataProvider;DataMember: string);
  procedure CleanUpDataStructure;
  function LlPrintGetPrinterInfo(var PrinterName, PrinterPort: TString): Integer;
  function LlSelectFileDlgTitle(ParentHandle: cmbtHWND; Title: TString; ProjectType: Integer; var ProjectName: TString): Integer;
  function LlGetUsedIdentifiers(ProjectName: string; IdentifierTypes: Cardinal): TStringList;
  procedure SaveFileNameCallback(pszFileName: PTChar);
  procedure PrintJobInfoCallback(pSCI:PSCLLPRINTJOBINFO);
  procedure ProjectLoadedEvent;
  procedure ProjectCallback(pSCP: PSCLLPROJECT);
  procedure ObjectCallback(pSCO: PSCLLOBJECT; var lResult: NativeInt);
  procedure PageCallback(pSCP: PSCLLPAGE);
  procedure NotifyProgressCallback(lParam: Integer);
  Function  JobInit(Var Jobhandle: HJob) : Boolean;
  Procedure JobFree(JobHandle: HJob; DataProvider: TDataSetDataProvider);

  procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  Function CheckError(ErrorCode: Integer): Integer;
  Function  OnDesignerPrintPreviewCallback(param: PSCLLDESIGNERPRINTJOB): LongInt;
  Function  OnDrillDownCallback(param: PSCLLDRILLDOWNJOBINFO): LongInt;
  Function  GetCore: LlCore;
Private
  procedure SetLanguage(const Value: TLlLanguage);
  procedure SetAddVarsToFields(const Value: Boolean);
  procedure SetShowErrors(const Value: Boolean);
  procedure SetAutoBoxType(const Value: TLlAutoBoxType);
  procedure SetAutoDesignerPreview(const Value: Boolean);
  procedure SetAutoDestination(const Value: TLlPrintMode);
  procedure SetAutoDialogTitle(const Value: String);
  procedure SetAutoFileAlsoNew(const Value: Boolean);
  procedure SetAutoProjectFile(const Value: String);
  procedure SetAutoProjectType(const Value: TLlProject);
  procedure SetAutoShowPrintOptions(const Value: Boolean);
  procedure SetAutoShowSelectFile(const Value: Boolean);
  procedure SetCompressStorage(const Value: Boolean);
  procedure SetConvertCRLF(const Value: Boolean);
  procedure SetDebug(const Value: TLlDebugFlags);
  procedure SetDelayTableHeader(const Value: Boolean);
  procedure SetIncludeFontDescent(const Value: Boolean);
  procedure SetIncrementalPreview(const Value: Boolean);
  procedure SetLicensingInfo(const Value: String);
  procedure SetMaximumIdleIterationsPerObject(const Value: Integer);
  procedure SetMaxRTFVersion(const Value: Integer);
  procedure SetPrinterless(const Value: Boolean);
  procedure SetNoParameterCheck(const Value: Boolean);
  procedure SetPreviewZoom(const Value: Integer);
  procedure SetProjectPassword(const Value: String);
  procedure SetTableColoring(const Value: TLlTableColoring);
  procedure SetUnits(const Value: TLlUnits);
  procedure SetVarCaseSensitive(const Value: Boolean);
  procedure SetNoPrintJobSupervision(const Value: Boolean);
  procedure OnDrillDownTerminating(Sender: TObject);
public

  Constructor Create(AOwner: TComponent); Override;
  destructor Destroy; Override;

  Procedure Design;
  Procedure Print;
  Procedure DoPreviewAndDrilldown( Wnd        : HWND;
                                   DrillDown   : Boolean;
                                   ProjectFile: String;
                                   OriginalProjectFile: String;
                                   MaxPages   : Integer;
                                   PreviewFile: String;
                                   AFilter     : PFilterDescription;
                                   AttachInfo  : THandle);
  Procedure DoExport(              Wnd        : HWND;
                                   const ProjectFile: String;
                                   const OriginalProjectFile: String;
                                   MaxPages   : Integer;
                                   const ExportFormat: String); overload;
  Procedure DoExport(              Wnd        : HWND;
                                   const ProjectFile: String;
                                   const OriginalProjectFile: String;
                                   MaxPages   : Integer;
                                   const ExportFormat, ExportPath, ExportFile: String;
                                   const ExportQuiet, ExportShow: Boolean); overload;
  Procedure AbortPrinting();

  Property ShowErrors: Boolean read FShowErrors write SetShowErrors default true;
  Property NoPrintJobSupervision: Boolean read FNoPrintJobSupervision write SetNoPrintJobSupervision Default false;
  Property Core: LlCore read GetCore;  
  // ILlDomParent
  procedure InitDataSource(projectFile: TString);
  procedure DeclareLlXObjectsToLL;
  function GetJobHandle: Integer;
published

  Property AddVarsToFields: Boolean read FAddVarsToFields write SetAddVarsToFields default false;
  Property AutoBoxType: TLlAutoBoxType read FAutoBoxType write SetAutoBoxType default TLlAutoBoxType.btNormalMeter;
  Property AutoDesignerPreview: Boolean read FAutoDesignerPreview write SetAutoDesignerPreview default true;
  Property AutoDestination: TLlPrintMode read FAutoDestination write SetAutoDestination default TLlPrintMode.pmExport;
  Property AutoProjectType: TLlProject read FAutoProjectType write SetAutoProjectType default TLlProject.ptList;
  Property AutoDialogTitle: String read FAutoDialogTitle write SetAutoDialogTitle;
  Property AutoFileAlsoNew: Boolean read FAutoFileAlsoNew write SetAutoFileAlsoNew Default true;
  Property AutoProjectFile: String read FAutoProjectFile write SetAutoProjectFile;
  Property AutoShowSelectFile: Boolean read FAutoShowSelectFile write SetAutoShowSelectFile Default true;
  Property AutoShowPrintOptions: Boolean read FAutoShowPrintOptions write SetAutoShowPrintOptions Default true;
  Property CompressStorage: Boolean read FCompressStorage write SetCompressStorage Default false;
  Property ConvertCRLF: Boolean read FConvertCRLF write SetConvertCRLF Default true;
  Property DelayTableHeader: Boolean read FDelayTableHeader write SetDelayTableHeader Default true;
  Property IncludeFontDescent: Boolean read FIncludeFontDescent write SetIncludeFontDescent Default true;
  Property IncrementalPreview: Boolean read FIncrementalPreview write SetIncrementalPreview Default true;
  Property LicensingInfo: String read FLicensingInfo write SetLicensingInfo;
  Property NoParameterCheck: Boolean read FNoParameterCheck write SetNoParameterCheck Default false;
  Property VarCaseSensitive: Boolean read FVarCaseSensitive write SetVarCaseSensitive Default false;
  Property Units: TLlUnits read FUnits write SetUnits Default TLlUnits.uSysDefault;
  Property ProjectPassword: String read FProjectPassword write SetProjectPassword;
  Property PreviewZoom: Integer read FPreviewZoom write SetPreviewZoom Default 100;
  Property MaximumIdleIterationsPerObject: Integer read FMaximumIdleIterationsPerObject write SetMaximumIdleIterationsPerObject Default 0;
  Property MaxRTFVersion: Integer read FMaxRTFVersion write SetMaxRTFVersion Default 1025;
  Property Printerless: Boolean read FPrinterless write SetPrinterless Default false;
  Property Debug: TLlDebugFlags read FDebug write SetDebug;
  Property TableColoring: TLlTableColoring read FTableColoring write SetTableColoring Default TLlTableColoring.tcListLabel;
  Property Language: TLlLanguage read FLanguage write SetLanguage Default TLlLanguage.lDefault;
  Property DataController: TLLDataController read FDataController Write FDataController;
  Property ExportOptions: TListLabelExportOptions read FExportOptions;
  Property DesignerFunctions: TDesignerFunctions read FLlXFunctionList;
  Property DesignerActions: TDesignerActions read FLlXActionList;
  Property DesignerObjects: TDesignerObjects read FLlXObjectList;

  // Events
  property OnDefinePrintOptions: TDefinePrintOptionsEvent read FOnDefinePrintOptionsEvent write FOnDefinePrintOptionsEvent;
  property OnAutoDefineNewPage: TAutoDefineNewPageEvent read FOnAutoDefineNewPage write FOnAutoDefineNewPage;
  property OnAutoDefineField: TAutoDefineFieldEvent read FOnAutoDefineField write FOnAutoDefineField;
  property OnAutoDefineVariable: TAutoDefineVariableEvent read FOnAutoDefineVariable write FOnAutoDefineVariable;
  property OnAutoDefineNewLine: TAutoDefineNewLineEvent read FOnAutoDefineNewLine write FOnAutoDefineNewLine;
  property OnAutoNotifyProgress: TAutoNotifyProgress read FOnAutoNotifyProgress write FOnAutoNotifyProgress;
  property OnSaveFileName: TSaveFileNameEvent read FOnSaveFileName write FOnSaveFileName;
  property OnPrintJobInfo: TPrintJobInfoEvent read FOnPrintJobInfo write FOnPrintJobInfo;
  property OnProjectLoaded: TProjectLoadedEvent read FOnProjectLoaded write FOnProjectLoaded;
  property OnProject: TProjectEvent read FOnProjectCallback write FOnProjectCallback;
  property OnObject: TObjectEvent read FOnObjectCallback write FOnObjectCallback;
  property OnPage: TPageEvent read FOnPageCallback write FOnPageCallback;
end;

//Core class
 LlCore = class (TObject)
 private
  fParentObject: TListLabel28;
 public
 Constructor Create(ParentObject: TListLabel28);

 function LlXSetParameter(extensionType: TLlExtensionType; extensionName: TString; name: TString; value: TString ): integer;
 function LlXGetParameter(extensionType: TLlExtensionType; ExtensionName: TString; Key: TString; var Value: TString): integer;
 function LlGetOptionString(OptionIndex: integer; var Value: TString): integer;
 function LlDefineVariableExt(FieldName: String; Contents: String; FieldType: integer): integer;
 function LlDefineVariableExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): integer;
 function LlDefineFieldExt(FieldName: String; Contents: String; FieldType: integer): integer;
 function LlDefineFieldExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): integer;
 function LlPrintGetOption(PrintOptionIndex: integer): integer;
 function LlPrintSetOption(PrintOptionIndex: integer; Value: lParam): integer; overload;
 function LlPrintSetOption(PrintOption: TLlPrintOption; Value: lParam): integer; overload;
 function LlSetOption(OptionIndex: integer; Value: lParam): integer; overload;
 function LlSetOption (Option: TLlOption; Value: lParam): integer; overload;
 function LlGetOption(OptionIndex: integer): integer; overload;
 function LlGetOption(Option: TLlOption): integer; overload;
 function LlSetOptionString(OptionIndex: integer; Value: TString): integer;
 function LlPrintSetOptionString(OptionIndex: integer; Value: TString): integer;
 function LlPrintGetOptionString(OptionIndex: integer; var Value: TString): integer;
 function LlPrintGetPrinterInfo(var PrinterName, PrinterPort: TString): Integer;
 function LlSetPrinterToDefault(ProjectType: integer; ProjectName: TString): integer;
 function LlSetPrinterDefaultsDir(Directory: TString): integer;
 function LlDlgEditLineEx(parentHandle: cmbtHWND;var formularText: TString; fieldType: integer; title: PTChar; useFields: boolean): integer;
 function LlDesignerAddAction(actionID: Cardinal; nFlags: Cardinal; menuText: TString; menuHierarchy: TString; tooltipText: TString; iconId: Cardinal; pvReserved: Pointer): integer;
 {$ifdef UNICODE}
 function LlSetPrinterInPrinterFile(ProjectType: cardinal; const ProjectName: TString; PrinterIndex: integer; const PrinterName: TString; const DevModePointer: _PCDEVMODEW): integer;
 {$else}
 function LlSetPrinterInPrinterFile(ProjectType: cardinal; const ProjectName: TString; PrinterIndex: integer; const PrinterName: TString; const DevModePointer: _PCDEVMODEA): integer;
 {$endif}
 {$ifdef UNICODE}
 function LlGetPrinterFromPrinterFile(ProjectType: Cardinal; ProjectName: TString; PrinterIndex: integer; var Printer: TString; var DevMode: _PDEVMODEW): Integer;
 {$else}
 function LlGetPrinterFromPrinterFile(ProjectType: Cardinal; ProjectName: TString; PrinterIndex: integer; var Printer: TString; var DevMode: _PDEVMODEA): Integer;
 {$endif}
end;


TListLabelExportOptions = class(TObject)
private
  fInternalOptionList: TDictionary<TString, TString>;
  fParent: TListLabel28;
  function GetExportOptionString(exportOption: TLlExportOption): TString;
  procedure SetExportOptions;
public
  procedure Clear();
  procedure Add(option: TString; value: TString);overload;
  procedure Add(option: TLlExportOption; value: TString);overload;
  function GetString(exportTarget: TLlExportTarget): TString;
  function GetExtensionFromExportTarget(exportTarget: TLlExportTarget): TString;
  function GetTargetFromString(target: TString): TLlExportTarget;
  function Keys(): TCollection;
  function Count(): integer;
  function Contains(option: TString): bool; overload;
  function Contains(option: TLlExportOption): bool; overload;
  constructor Create(parent: TListLabel28);
  destructor Destroy; Override;

end;

TLlExprEvaluator = class(TObject)
private
  FExprPointer: HLLEXPR;
  FParent: TListLabel28;
  FErrorValue: integer;
  FExprType: integer;
  FErrorText: TString;
  FResult: TString;
  FExpression: TString;
  procedure SetExpression(const Value: TString);
public
  constructor Create(Parent: TListLabel28; Expression: TString; IncludeTablefields: boolean);
  destructor Destroy; override;
  property ErrorText: TString read FErrorText;
  property Result: TString read FResult;
  property ErrorValue: integer read FErrorValue;
  property ExprType: integer read FExprType;
  property Expression: TString read FExpression write SetExpression;
  procedure EditExpression(title: TString);

end;


function NtfyCallback(nMsg: Cardinal; lParam: NativeUInt; lUserParam: NativeInt): NativeInt; export; stdcall;

Type
  TJulianDate = LongInt;

Function DateToJulian(ADate: TDateTime): TJulianDate;
Function JulianToDate(AJulDate: TJulianDate): TDateTime;
procedure StrPCopyExt(var Dest: ptChar; Source: TString; MinSize: integer);

Const
  CE_OK = 0;
  CE_Abort = -1;
  CE_Error = 1;
  CE_PageFull = -998;

implementation

uses ListLabelDataProviderInterface, LLThreads, UITypes;

Const
  JulZero = 2415018; { 30.12.1899 im Julianischen Format ! }

function NtfyCallback(nMsg: Cardinal; lParam: NativeUInt; lUserParam: NativeInt): NativeInt;
var
  lResult: NativeInt;
begin
  lResult := 0;
  case nMsg of
    LL_NTFY_DESIGNERPRINTJOB:
      Begin
        lResult :=TListLabel28(lUserParam).OnDesignerPrintPreviewCallback(pSCLLDESIGNERPRINTJOB(lParam));
      End;

    LL_NTFY_VIEWERDRILLDOWN:
      begin
        lResult:= TListLabel28(lUserParam).OnDrillDownCallBack(PSCLLDRILLDOWNJOBINFO(lParam));
      end;
    LL_CMND_SAVEFILENAME:
      begin
          (TListLabel28(lUserParam)).SaveFileNameCallback(PTChar(lparam));
      end;
    87:// LL_NTFY_PROGRESS
      begin
          (TListLabel28(lUserParam)).NotifyProgressCallback(Integer(lparam));
      end;
    LL_INFO_PRINTJOBSUPERVISION:
      begin
          (TListLabel28(lUserParam)).PrintJobInfoCallback(PSCLLPRINTJOBINFO(lParam));
      end;
    LL_NTFY_PROJECTLOADED:
      begin
		if (integer(lParam)=0) then
          (TListLabel28(lUserParam)).ProjectLoadedEvent;
      end;
    LL_CMND_PROJECT:
      begin
          (TListLabel28(lUserParam)).ProjectCallback(pSCLLPROJECT(lParam));
      end;
    LL_CMND_OBJECT:
      begin
          (TListLabel28(lUserParam)).ObjectCallback(pSCLLOBJECT(lParam), lResult);
      end;
    LL_CMND_PAGE:
      begin
          (TListLabel28(lUserParam)).PageCallback(pSCLLPAGE(lParam));
      end;
    LL_NTFY_QUEST_DRILLDOWNDENIED :
      begin
        if TListLabel28(lUserParam).FDrilldownActive then
          lResult:= 1
        else
          lResult:= 0;
      end;
  end;
  Result := lResult;
end;

// =====================================================================
// TListLabel28
// =====================================================================
Constructor TListLabel28.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  LL28xLoad();
  lpfnNtfyProc := nil;
  FDataController := TLLDataController.Create(self);
  FExportOptions := TListLabelExportOptions.Create(self);

  FPreviewCritSect := TCriticalSection.Create;
  FDrillCritSect   := TCriticalSection.Create;
  FUsedIdentifiers := nil;
  FRootTables := TStringList.Create;
  FPassedTables := TStringList.Create;
  FDelayedRelations := TObjectList<TListLabelTableRelation>.Create(false);
  FPassedRelations := TObjectList<TListLabelTableRelation>.Create(false);
  FNumCopies := 1;
  FAddVarsToFields := false;
  FShowErrors := true;
  FAutoDesignerPreview := true;
  FAutoDestination := TLlPrintMode.pmExport;
  FAutoProjectType := TLlProject.ptList;
  FAutoShowPrintOptions := true;
  FAutoShowSelectFile := true;
  FAutoFileAlsoNew := true;
  FCompressStorage := false;
  FConvertCRLF := true;
  FDelayTableHeader := true;
  FIncludeFontDescent := true;
  FIncrementalPreview := true;
  FNoParameterCheck := false;
  FVarCaseSensitive := false;
  FUnits := TLlUnits.uSysDefault;
  FProjectPassword := '';
  FPreviewZoom := 100;
  FMaximumIdleIterationsPerObject := 0;
  FMaxRTFVersion := 1025;
  FPrinterless := false;
  FTableColoring := TLlTableColoring.tcListLabel;
  FLanguage := TLlLanguage.lDefault;
  FBaseJob:=-1;
  FDomDataProvider:=nil;
  FCore:=nil;
  JobInit(FBaseJob);
  GetCore();
  FLlXActionList := TDesignerActions.Create;
  FLlXObjectList:= TDesignerObjects.Create;
  FLlXFunctionList:= TDesignerFunctions.Create;
  FLlXInterface:=nil;

end;

destructor TListLabel28.Destroy;
begin
  JobFree(FBaseJob, nil);
  if (lpfnNtfyProc <> nil) then  FreeProcInstance(lpfnNtfyProc);
  lpfnNtfyProc := nil;
  FPreviewCritSect.Free;
  FDrillCritSect.Free;
  FreeAndNil(FDataController);
  FRootTables.Free;
  FPassedTables.Free;
  FUsedIdentifiers.Free;
  FDomDataProvider.Free;
  FreeAndNil(FDelayedRelations);
  FreeAndNil(FPassedRelations);
  LL28xUnload();
  FCore.Free;
  FExportOptions.Free;
  FLlXActionList.Free;
  FLlXFunctionList.Free;
  FLlXObjectList.Free;
  inherited Destroy;
end;

Function TListLabel28.OnDesignerPrintPreviewCallback(param: PSCLLDESIGNERPRINTJOB): LongInt;
Begin
   result:=0;
   case param^._nFunction of
     LL_DESIGNERPRINTCALLBACK_PREVIEW_START,
     LL_DESIGNERPRINTCALLBACK_EXPORT_START:
        Begin
          with FPreviewCritSect do
          try
            Enter;
            if Assigned(FPreviewThread) then
            Begin
               FPreviewThread.Terminate;
               FPreviewThread.Free;
            End;

            FPreviewThread:=TPrintPreviewThread.Create(True);

            with TPrintPreviewThread(FPreviewThread) do
            begin
              printInstance := self;
              FreeOnTerminate := False;

            // Setzen der Event Parameter:
              projectFile         := param._pszProjectFileName;
              originalProjectFile := param._pszOriginalProjectFileName;
              exportFormat        := param._pszExportFormat;
              controlHandle       := param._hWndPreviewControl;
              PageCount           := param._nPages;
              eventHandle         := param._hEvent;

              if param._nFunction = LL_DESIGNERPRINTCALLBACK_EXPORT_START then
                 doExport := true
              else
                 doExport := false;

              pageCount := param._nPages;

              Start();
            end;
          finally
             Leave;
          end;
        end;
     LL_DESIGNERPRINTCALLBACK_PREVIEW_ABORT,
     LL_DESIGNERPRINTCALLBACK_EXPORT_ABORT:
        begin
           with FPreviewCritSect do
           try
             Acquire;
             if Assigned(FPreviewThread) and
                not TPrintPreviewThread(FPreviewThread).Terminated then
                TPrintPreviewThread(FPreviewThread).Abort();
           finally
              Release;
           end;
        end;
     LL_DESIGNERPRINTCALLBACK_PREVIEW_FINALIZE,
     LL_DESIGNERPRINTCALLBACK_EXPORT_FINALIZE:
        Begin
          with FPreviewCritSect do
          try
            Acquire;
            if Assigned(FPreviewThread) then
            begin
              if not TPrintPreviewThread(FPreviewThread).Terminated then
              begin
                TPrintPreviewThread(FPreviewThread).FinalizePrinting();
                TPrintPreviewThread(FPreviewThread).WaitFor;
              end;
              FPreviewThread.Free;
              FPreviewThread:=nil;
            end;
          finally
            Release
          end;
        End;
     LL_DESIGNERPRINTCALLBACK_PREVIEW_QUEST_JOBSTATE,
     LL_DESIGNERPRINTCALLBACK_EXPORT_QUEST_JOBSTATE:
        Begin
           with FPreviewCritSect do
           try
             Acquire;
             if not Assigned(FPreviewThread) then
                result := 0;

             if Assigned(FPreviewThread) then
             begin
               if (TPrintPreviewThread(FPreviewThread).Terminated) then
                 result := 0
               else
                 result := 2;
             end;
           finally
             Release;
          end;
        End;
   end;
End;

Function  TListLabel28.OnDrillDownCallback(param: PSCLLDRILLDOWNJOBINFO): LongInt;
Begin
   result:=0;
   case param._nFunction of
      LL_DRILLDOWN_START:

        begin
          with FDrillCritSect do
          try
            Acquire;
            Inc(FDrillDownJobId);
            // might be assigned from previous print
            FDrillDownThread := TDrillDownThread.Create(true);
            With TDrillDownThread(FDrillDownThread) do
            Begin
				PrintInstance   := Self;
				FreeOnTerminate := true;
				UserParam       := param._nUserParameter;
				ParentTableName := param._pszTableID;
				RelationName    := param._pszRelationID;
				ChildTableName  := param._pszSubreportTableID;
				ParentKey       := param._pszKeyField;
				ChildKey        := param._pszSubreportKeyField;
				KeyValue        := param._pszKeyValue;
				ProjectFileName := param._pszProjectFileName;
				PreviewFileName := param._pszPreviewFileName;
				TooltipText     := param._pszTooltipText;
				TabText         := param._pszTabText;
				WindowHandle    := param._hWnd;
				JobID           := param._nID;
				AttachInfo      := param._hAttachInfo;
				OnTerminate		:= OnDrillDownTerminating;
				FDrillDownThread.Start();
				result:=FDrillDownJobId;
            end;
          finally
            Release;
          end;
        end;
      LL_DRILLDOWN_FINALIZE:
        begin
          with FDrillCritSect do
          try
            Acquire;
            if Assigned(FDrillDownThread) then
            begin
              if not TDrillDownThread(FDrillDownThread).Terminated then
              begin
                TDrillDownThread(FDrillDownThread).FinalizePrinting;
              end;
            end;
          finally
            Release;
          end;
        end;
   end;
End;

procedure TListLabel28.OnDrillDownTerminating(Sender: TObject);
begin
  FDrillDownThread := nil;
end;

procedure TListLabel28.NotifyProgressCallback(lParam: Integer);
begin
  if(Assigned(FOnAutoNotifyProgress)) then
    FOnAutoNotifyProgress(Self, lParam);
end;
procedure TListLabel28.SaveFileNameCallback(pszFileName: PTChar);
begin
  if Assigned(FOnSaveFileName) then
    FOnSaveFileName(Self, pszFileName);
end;

procedure TListLabel28.PrintJobInfoCallback(pSCI:PSCLLPRINTJOBINFO);
begin
    if Assigned (FOnPrintJobInfo) then
    begin
        FOnPrintJobInfo(self, pSCI^._hLlJob, pSCI^._szDevice, pSCI^._dwJobID, pSCI^._dwState);
    end;
end;

procedure TListLabel28.ProjectLoadedEvent;
begin
  if Assigned(FOnProjectLoaded) then
    FOnProjectLoaded(Self);
end;


procedure TListLabel28.ProjectCallback(pSCP: PSCLLPROJECT);
var
  Canvas: TCanvas;
  paintDC: HDC;
  Rect: TRect;
  Size: TSize;
  Point: TPoint;
begin
  if Assigned(FOnProjectCallback) then
  begin
  	paintDC:= pSCP^._hPaintDC;
    SaveDC(paintDC);
    Canvas := TCanvas.Create;
    try
      Canvas.handle := pSCP^._hPaintDC;
      GetWindowExtEx(Canvas.handle, Size);
      GetWindowOrgEx(Canvas.handle, Point);
      Rect.Top := Point.y;
      Rect.Bottom := Rect.Top + Size.cy;
      Rect.Left := Point.x;
      Rect.Right := Rect.Left + Size.cx;
      FOnProjectCallback(Self, pSCP^._bDesignerPreview, pSCP^._bPreDraw, Canvas, Rect);
    finally
      Canvas.Free;
	  RestoreDC(paintDC, -1);
    end;
  end;
end;

procedure TListLabel28.ObjectCallback(pSCO: PSCLLOBJECT; var lResult: NativeInt);
var
  Canvas: TCanvas;
  Rect: TRect;
  iResult: NativeInt;
begin
  iResult := 0;
  if Assigned(FOnObjectCallback) then
  begin
    SaveDC(pSCO^._hPaintDC);
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := pSCO^._hPaintDC;
      Rect := pSCO^._rcPaint;
      FOnObjectCallback(Self, TString(pSCO^._pszName), TObjectType(pSCO^._nType),
        pSCO^._bPreDraw, Canvas, Rect, iResult);
      pSCO^._rcPaint := Rect;
    finally
      Canvas.Free;
	  RestoreDC(pSCO^._hPaintDC, -1);
      lResult:=iResult;
    end;
  end;
end;

procedure TListLabel28.PageCallback(pSCP: PSCLLPAGE);
var
  Canvas: TCanvas;
  Rect: TRect;
  Size: TSize;
  Point: TPoint;
begin
  if Assigned(FOnPageCallback) then
  begin
    SaveDC(pSCP^._hPaintDC);
    Canvas := TCanvas.Create;
    try
      Canvas.handle := pSCP^._hPaintDC;
      GetWindowExtEx(Canvas.handle, Size);
      GetWindowOrgEx(Canvas.handle, Point);
      Rect.Top := Point.y;
      Rect.Bottom := Rect.Top + Size.cy;
      Rect.Left := Point.x;
      Rect.Right := Rect.Left + Size.cx;
      FOnPageCallback(Self, pSCP^._bDesignerPreview, pSCP^._bPreDraw, Canvas, Rect);
    finally
      Canvas.Free;
	  RestoreDC(pSCP^._hPaintDC, -1);
    end;
  end;
end;

procedure TListLabel28.SetVarCaseSensitive(const Value: Boolean);
begin
  FVarCaseSensitive := Value;
end;

procedure TListLabel28.SetLanguage(const Value: TLlLanguage);
var
  OldAddVarsToFields: Boolean;
  OldShowErrors: Boolean;
  OldCompressStorage: Boolean;
  OldConvertCRLF: Boolean;
  OldDelayTableHeader: Boolean;
  OldIncludeFontDescent: Boolean;
  OldIncrementalPreview: Boolean;
  OldLicensingInfo: String;
  OldNoParameterCheck: Boolean;
  OldVarCaseSensitive: Boolean;
  OldUnits: TLlUnits;
  OldProjectPassword: String;
  OldPreviewZoom: Integer;
  OldMaximumIdleIterationsPerObject: Integer;
  OldDebug: TLlDebugFlags;
  OldTableColoring: TLlTableColoring;

begin

  FLanguage := Value;

  OldAddVarsToFields := AddVarsToFields;
  OldShowErrors := ShowErrors;
  OldCompressStorage := CompressStorage;
  OldConvertCRLF := ConvertCRLF;
  OldDelayTableHeader := DelayTableHeader;
  OldIncludeFontDescent := IncludeFontDescent;
  OldIncrementalPreview := IncrementalPreview;
  OldLicensingInfo := LicensingInfo;
  OldNoParameterCheck := NoParameterCheck;
  OldVarCaseSensitive := VarCaseSensitive;
  OldUnits := Units;
  OldProjectPassword := ProjectPassword;
  OldPreviewZoom := PreviewZoom;
  OldMaximumIdleIterationsPerObject := MaximumIdleIterationsPerObject;
  OldDebug := Debug;
  OldTableColoring := TableColoring;

  if FBaseJob > 0 then
  begin
    LlSetNotificationCallback(FBaseJob, nil);
    LlJobClose(FBaseJob);
  end;

  CheckError(LlSetOption(-1, LL_OPTION_MAXRTFVERSION, FMaxRTFVersion));
  CheckError(LlSetOption(-1, integer(TLlOption.Printerless), integer(FPrinterless)));

  FBaseJob := LLJobOpen(TEnumTranslator.TranslateLanguage(FLanguage));
  if FBaseJob > -1 then
  begin
	JobInit(FBaseJob);
    AddVarsToFields := OldAddVarsToFields;
    ShowErrors := OldShowErrors;
    CompressStorage := OldCompressStorage;
    ConvertCRLF := OldConvertCRLF;
    DelayTableHeader := OldDelayTableHeader;
    IncludeFontDescent := OldIncludeFontDescent;
    IncrementalPreview := OldIncrementalPreview;
    LicensingInfo := OldLicensingInfo;
    NoParameterCheck := OldNoParameterCheck;
    VarCaseSensitive := OldVarCaseSensitive;
    Units := OldUnits;
    ProjectPassword := OldProjectPassword;
    PreviewZoom := OldPreviewZoom;
    MaximumIdleIterationsPerObject := OldMaximumIdleIterationsPerObject;
    Debug := OldDebug;
    TableColoring := OldTableColoring;
  end;

end;

// LL helper functions

function TListLabel28.LlPrintGetPrinterInfo(var PrinterName, PrinterPort: TString): Integer;
var
  BufPrinter, BufPort: PTChar;

begin
  GetMem(BufPrinter, 128 * sizeof(tChar));
  GetMem(BufPort, 40 * sizeof(tChar));
  BufPrinter^ := #0;
  BufPort^ := #0;
  Result := cmbtll28x.LlPrintGetPrinterInfo(CurrentJobHandle, BufPrinter, 128 - 1, BufPort, 40 - 1);
  PrinterName := TString(BufPrinter);
  PrinterPort := TString(BufPort);
  FreeMem(BufPrinter);
  FreeMem(BufPort);
end;

function TListLabel28.LlSelectFileDlgTitle(ParentHandle: cmbtHWND; Title: TString; ProjectType: Integer; var ProjectName: TString): Integer;
var
  pszProjectName: PTChar;

  begin
  pszProjectName := nil;
  StrPCopyExt(pszProjectName, ProjectName, 1024);
  Result := cmbtll28x.LlSelectFileDlgTitleEx(CurrentJobHandle, ParentHandle, PTChar(Title), ProjectType, pszProjectName, 1024 - 1, nil);
  ProjectName := TString(pszProjectName);
  FreeMem(pszProjectName);
end;



function TListLabel28.LlGetUsedIdentifiers(ProjectName: string; IdentifierTypes: Cardinal): TStringList;
var
  pszIdentifiers: PTChar;
  size: integer;


begin
  result:=nil;
  size:=cmbtll28x.LlGetUsedIdentifiersEx(CurrentJobHandle, PChar(ProjectName), IdentifierTypes, nil, 0);
  if (size<=0) then exit;

  GetMem(pszIdentifiers, (size+1)*2);
  cmbtll28x.LlGetUsedIdentifiersEx(CurrentJobHandle, PChar(ProjectName), IdentifierTypes, pszIdentifiers, size);
  result:=TStringList.Create;
  result.OwnsObjects:=true;
  result.Delimiter:=';';
  result.StrictDelimiter:=true;
  result.DelimitedText:=pszIdentifiers;
  FreeMem(pszIdentifiers);
end;


procedure TListLabel28.SetAddVarsToFields(const Value: Boolean);
begin

  FAddVarsToFields := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_ADDVARSTOFIELDS, Integer(FAddVarsToFields)));

end;

procedure TListLabel28.SetShowErrors(const Value: Boolean);
begin

  FShowErrors := Value;

end;

procedure TListLabel28.SetUnits(const Value: TLlUnits);
begin

  FUnits := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_UNITS, Integer(TEnumTranslator.TranslateUnits(FUnits))));

end;

procedure TListLabelExportOptions.SetExportOptions;
var
target: TString;
Item: TPair<TString, TString>;
begin
  if fInternalOptionList.ContainsKey('Export.Target') then
  begin
    target:= fInternalOptionList['Export.Target'];
  end;

  for Item in fInternalOptionList do
       fParent.Core.LlXSetParameter(TLlExtensionType.Export, target, Item.Key,
       Item.Value);
end;

procedure TListLabel28.SetNoPrintJobSupervision(const Value: Boolean);
begin

  FNoPrintJobSupervision := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_NOPRINTJOBSUPERVISION, Integer(Value)));

end;

procedure TListLabel28.SetLicensingInfo(const Value: String);
var
  tmp: PChar;
begin
  FLicensingInfo := Value;
  tmp := StrNew(PChar(FLicensingInfo));
  CheckError(LlSetOptionString(CurrentJobHandle, LL_OPTIONSTR_LICENSINGINFO, tmp));
  StrDispose(tmp);
end;

procedure TListLabel28.SetAutoBoxType(const Value: TLlAutoBoxType);
begin

  FAutoBoxType := Value;

end;

procedure TListLabel28.SetAutoDesignerPreview(const Value: Boolean);
begin

  FAutoDesignerPreview := Value;

end;

procedure TListLabel28.SetAutoDestination(const Value: TLlPrintMode);
begin

  FAutoDestination := Value;

end;

procedure TListLabel28.SetAutoDialogTitle(const Value: String);
begin

  FAutoDialogTitle := Value;

end;

procedure TListLabel28.SetAutoFileAlsoNew(const Value: Boolean);
begin

  FAutoFileAlsoNew := Value;

end;

procedure TListLabel28.SetAutoProjectFile(const Value: String);
begin

  FAutoProjectFile := Value;

end;

procedure TListLabel28.SetAutoProjectType(const Value: TLlProject);
begin

  FAutoProjectType := Value;

end;

procedure TListLabel28.SetAutoShowPrintOptions(const Value: Boolean);
begin

  FAutoShowPrintOptions := Value;

end;

procedure TListLabel28.SetAutoShowSelectFile(const Value: Boolean);
begin

  FAutoShowSelectFile := Value;

end;

procedure TListLabel28.SetCompressStorage(const Value: Boolean);
begin

  FCompressStorage := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_COMPRESSSTORAGE, Integer(FCompressStorage)));

end;

procedure TListLabel28.SetConvertCRLF(const Value: Boolean);
begin

  FConvertCRLF := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_CONVERTCRLF, Integer(FConvertCRLF)));

end;

procedure TListLabel28.SetDebug(const Value: TLlDebugFlags);
var
  LlDebugFlags: Integer;

begin

  FDebug := Value;
  LlDebugFlags := TEnumTranslator.TranslateDebugFlags(FDebug);
  if LlDebugFlags > 0 then
  begin
    LLSetDebug(LlDebugFlags);
  end;

end;

procedure TListLabel28.SetDelayTableHeader(const Value: Boolean);
begin

  FDelayTableHeader := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_DELAYTABLEHEADER, Integer(FDelayTableHeader)));

end;

procedure TListLabel28.SetIncludeFontDescent(const Value: Boolean);
begin

  FIncludeFontDescent := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_INCLUDEFONTDESCENT, Integer(FIncludeFontDescent)));

end;

procedure TListLabel28.SetIncrementalPreview(const Value: Boolean);
begin

  FIncrementalPreview := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_INCREMENTAL_PREVIEW, Integer(FIncrementalPreview)));

end;

procedure TListLabel28.SetMaximumIdleIterationsPerObject(const Value: Integer);
begin

  FMaximumIdleIterationsPerObject := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_IDLEITERATIONCHECK_MAX_ITERATIONS, Integer(FMaximumIdleIterationsPerObject)));

end;

procedure TListLabel28.SetPrinterless(const Value: Boolean);
begin
  FPrinterless := Value;
  SetLanguage(Language);
end;

procedure TListLabel28.SetMaxRTFVersion(const Value: Integer);
begin
  FMaxRTFVersion := Value;
  SetLanguage(Language); // makes sure to apply the value
end;

procedure TListLabel28.SetNoParameterCheck(const Value: Boolean);
begin

  FNoParameterCheck := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_NOPARAMETERCHECK, Integer(FNoParameterCheck)));

end;

procedure TListLabel28.SetPreviewZoom(const Value: Integer);
begin

  FPreviewZoom := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_PRVZOOM_PERC, FPreviewZoom));

end;

// Druck Prozeduren

Function TListLabel28.JobInit(Var Jobhandle: HJob): Boolean;
Var
  tmp : PChar;
  LlDebugFlags: Integer;

begin

  LlDebugFlags := TEnumTranslator.TranslateDebugFlags(FDebug);
  if LlDebugFlags > 0 then
  begin
    LLSetDebug(LlDebugFlags);
  end;

  if (Jobhandle = -1) then
  begin
    JobHandle := LLJobOpen(TEnumTranslator.TranslateLanguage(FLanguage));
  end;

  if JobHandle > -1 then
  begin
    tmp := StrNew(PChar(FLicensingInfo));
    LlSetOptionString(JobHandle, LL_OPTIONSTR_LICENSINGINFO, tmp);
    StrDispose(tmp);

    tmp := StrNew(PChar(FProjectPassword));
    LlSetOptionString(JobHandle, LL_OPTIONSTR_PROJECTPASSWORD, tmp);
    StrDispose(tmp);

    lpfnNtfyProc := TFarProc(@NtfyCallback);
    LlSetOption(JobHandle, LL_OPTION_CALLBACKPARAMETER, NativeInt(self));
    LlSetOption(JobHandle, LL_OPTION_CALLBACKMASK, LL_CB_PAGE or LL_CB_OBJECT or LL_CB_PROJECT );
    LlSetOption(JobHandle, LL_OPTION_NOPRINTJOBSUPERVISION, 0);
    LlSetNotificationCallback(JobHandle, lpfnNtfyProc);
    CheckError(LlSetOption(JobHandle, LL_OPTION_ADDVARSTOFIELDS, Integer(FAddVarsToFields)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_COMPRESSSTORAGE, Integer(FCompressStorage)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_CONVERTCRLF, Integer(FConvertCRLF)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_DELAYTABLEHEADER, Integer(FDelayTableHeader)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_INCREMENTAL_PREVIEW, Integer(FIncrementalPreview)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_NOPARAMETERCHECK, Integer(FNoParameterCheck)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_VARSCASESENSITIVE, Integer(FVarCaseSensitive)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_UNITS, Integer(TEnumTranslator.TranslateUnits(FUnits))));
    CheckError(LlSetOption(JobHandle, LL_OPTION_PRVZOOM_PERC, FPreviewZoom));
    CheckError(LlSetOption(JobHandle, LL_OPTION_IDLEITERATIONCHECK_MAX_ITERATIONS, FMaximumIdleIterationsPerObject));
    CheckError(LlSetOption(JobHandle, LL_OPTION_TABLE_COLORING, TEnumTranslator.TranslateTableColoring(FTableColoring)));
    CheckError(LlSetOption(JobHandle, LL_OPTION_DESIGNERPREVIEWPARAMETER, 1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_DESIGNERPRINT_SINGLETHREADED, 1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_DRILLDOWNPARAMETER,1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_INTERACTIVESORTING_REALDATAJOBPARAMETER, 1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_REPORT_PARAMETERS_REALDATAJOBPARAMETER,1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_EXPANDABLE_REGIONS_REALDATAJOBPARAMETER,1));
    CheckError(LlSetOption(JobHandle, LL_OPTION_INCLUDEFONTDESCENT, Integer(FIncludeFontDescent)));
	CheckError(LlSetOption(JobHandle, LL_OPTION_NOPRINTERPATHCHECK, Integer(True)));
    CurrentJobHandle:=Jobhandle;
  end;

  Result := JobHandle >- 1;
  if FNumCopies = 0 then
  begin
    FNumCopies := 1;
  end;

end;

Procedure TListLabel28.JobFree(JobHandle: HJob; DataProvider: TDataSetDataProvider);
begin
  if (DataProvider = nil) or (JobHandle <> FBaseJob) then
  begin
    LlSetNotificationCallback(JobHandle, nil);
    LLJobClose(JobHandle);
  end;
  if DataProvider<>nil then DataProvider.Free
end;

procedure TListLabel28.Notification(AComponent: TComponent; Operation: TOperation);
Var i : INteger;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) Then
  Begin
     if (AComponent is TDataSource) and (AComponent<>nil) and
        (FDataController<>nil) and (FDataController.DetailSources<>nil) then
     Begin
       for I := 0 to FDataController.DetailSources.Count-1 do
       Begin
         if (FDataController.DetailSources[i].DataSource <> nil) and
            (AComponent = FDataController.DetailSources[i].DataSource) Then
             FDataController.DetailSources[i].DataSource:=nil;
       End;
     End;
  end;
end;

Function TListLabel28.CheckError(ErrorCode: Integer): Integer;
Var
  Buffer: Array [0 .. 255] of char;
  ErrorText: TString;
begin
  Case ErrorCode of
    0:
      Result := CE_OK;
    -99:
      Result := CE_Abort;
    -998:
      Result := CE_PageFull;
  else
    Result := CE_Error;
  end;

  If (ErrorCode < 0) then
  begin

    LlGetErrortext(ErrorCode, Buffer, SizeOf(Buffer));
    ErrorText := IntToStr(ErrorCode) + ' (' + StrPas(Buffer) + ' )';

    If FShowErrors then
    begin
      if Result <> CE_Abort then
         MessageDlg(ErrorText, mtError, [mbOK], 0)
    end
    else
    begin
      Raise Exception.Create(ErrorText);
    end;

  end
  else
  begin
    Result := CE_OK;
  end;
end;

procedure TListLabel28.CleanUpDataStructure;
begin
  LlDbAddTable(CurrentJobHandle, '', '');
  PassedTables.Clear;
  PassedRelations.Clear;
  DelayedRelations.Clear;
end;

procedure TListLabel28.SetProjectPassword(const Value: String);
var
  tmp: PChar;

begin

  FProjectPassword := Value;
  tmp := StrNew(PChar(FProjectPassword));
  LlSetOptionString(CurrentJobHandle, LL_OPTIONSTR_PROJECTPASSWORD, tmp);
  StrDispose(tmp);

end;

procedure TListLabel28.SetTableColoring(const Value: TLlTableColoring);
begin

  FTableColoring := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_TABLE_COLORING, TEnumTranslator.TranslateTableColoring(FTableColoring)));

end;

function LlCore.LlDefineVariableExt(FieldName: String; Contents: String; FieldType: integer): integer;
var handled: boolean;
Begin
   if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);
   handled:=false;
   if Assigned(fParentObject.FOnAutoDefineVariable) then
      fParentObject.OnAutoDefineVariable(self, not fParentObject.IsPrinting, FieldName,Contents,FieldType,handled);

   if handled then exit(0);

   result := cmbtLL28x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), FieldType, '');

End;

function  LlCore.LlDefineVariableExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): Integer;
Begin
  if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);
   result:=0;
   case FieldType of
      LL_DRAWING_HMETA:
         result := cmbtLL28x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HEMETA, '');
      LL_DRAWING_HBITMAP:
         result := cmbtLL28x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HBITMAP, '');
      LL_DRAWING_HICON:
         result:= cmbtLL28x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HICON, '');
   end;
End;

//

function LlCore.LlDefineFieldExt(FieldName: String; Contents: String; FieldType: integer): integer;
var handled: boolean;
    tableName: String;
Begin
  if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);

  handled:=false;
  tableName:=LeftStr(FieldName, Pos('.', FieldName)-1);

  //needed for label projects
  if (fParentObject.FAutoProjectType <> ptList)  or ((fParentObject.DataController.DataMember = tableName)
        and (fParentObject.DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables)) then
    begin
      if Assigned(fParentObject.FOnAutoDefineVariable) then
        fParentObject.FOnAutoDefineVariable(self, not fParentObject.IsPrinting, FieldName,Contents,FieldType,handled);
    end
  else
    begin
      if Assigned(fParentObject.FOnAutoDefineField) then
        fParentObject.OnAutoDefineField(self, not fParentObject.IsPrinting, FieldName,Contents,FieldType,handled);
    end;

   if handled then exit(0);

   result := cmbtLL28x.LLDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), FieldType, '');

End;

function  LlCore.LlDefineFieldExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): Integer;
Begin
  if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);
   result:=0;
   case FieldType of
      LL_DRAWING_HMETA:
         result := cmbtLL28x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HEMETA, '');
      LL_DRAWING_HBITMAP:
         result := cmbtLL28x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HBITMAP, '');
      LL_DRAWING_HICON:
         result:= cmbtLL28x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HICON, '');
   end;
End;
function LlCore.LlXSetParameter(extensionType: TLlExtensionType; extensionName: TString; name: TString; value: TString ): integer;
begin
  Result := cmbtll28x.LlXSetParameter(fParentObject.CurrentJobHandle, Integer(extensionType), PChar(extensionName),PChar(name),PChar(value));
end;

function LlCore.LlXGetParameter(extensionType: TLlExtensionType; ExtensionName: TString; Key: TString; var Value: TString ): integer;
var
  Buffer: PTChar;
  length: integer;
begin
  length := cmbtll28x.LlXGetParameter(fParentObject.CurrentJobHandle, integer(extensionType), PTChar(ExtensionName),
    PTChar(Key), nil, 0);
  if length >0 then
  begin
  GetMem(Buffer, length * sizeof(TChar));
  Buffer^ := #0;
  Result := cmbtll28x.LlXGetParameter(fParentObject.CurrentJobHandle, integer(extensionType), PTChar(ExtensionName),
    PTChar(Key), Buffer, length);
  Value := TString(Buffer);
  FreeMem(Buffer);
end
  else
  begin
    Result :=length;
    Value  :='';
  end;
end;

function LlCore.LlSetOption(OptionIndex: Integer; Value: NativeInt): Integer;
begin
  Result := cmbtLL28x.LlSetOption(fParentObject.CurrentJobHandle, OptionIndex, Value);
end;

function LlCore.LlSetOption(Option: TLlOption; Value: NativeInt): Integer;
begin
  Result := LlSetOption(integer(Option), Value);
end;

function LlCore.LlPrintSetOption(PrintOptionIndex: Integer; Value: NativeInt): Integer;
begin
  Result := cmbtLL28x.LlPrintSetOption(fParentObject.CurrentJobHandle, PrintOptionIndex, Value);
end;

function LlCore.LlPrintSetOption(PrintOption: TLlPrintOption; Value: NativeInt): Integer;
begin
  Result := LlPrintSetOption(integer(PrintOption), value);
end;


function LlCore.LlSetOptionString(OptionIndex: integer; Value: TString): integer;
begin
  Result := cmbtLL28x.LlSetOptionString(fParentObject.CurrentJobHandle, OptionIndex, PTChar(Value));
end;

function LlCore.LlPrintSetOptionString(OptionIndex: integer;
  Value: TString): integer;
begin
  Result := cmbtLL28x.LlPrintSetOptionString(fParentObject.CurrentJobHandle, OptionIndex, PTChar(Value));
end;

function LlCore.LlPrintGetOptionString(OptionIndex: integer; var Value: TString): integer;
var
  Buffer: PTChar;
  length: integer;
begin
  length := cmbtLL28x.LlPrintGetOptionString(fParentObject.CurrentJobHandle, OptionIndex,
    nil, 0);
  if length>0 then
  begin
    GetMem(Buffer, length * sizeof(TChar));
    Buffer^ := #0;
    Result := cmbtLL28x.LlPrintGetOptionString(fParentObject.CurrentJobHandle, OptionIndex,
      Buffer, length);
    Value := TString(Buffer);
    FreeMem(Buffer);
  end
  else
  begin
    result:=length;
    Value:='';
  end;
end;
function LlCore.LlDesignerAddAction(actionID, nFlags: Cardinal; menuText,
  menuHierarchy, tooltipText: TString; iconId: Cardinal;
  pvReserved: Pointer): integer;
begin
  Result := cmbTLl28x.LlDesignerAddAction(fParentObject.CurrentJobHandle, actionID, nFlags, PTChar(menuText), PTChar(menuHierarchy), PTChar(tooltipText),iconID, pvReserved);
end;


function LlCore.LlDlgEditLineEx(parentHandle: cmbtHWND;var formularText: TString;
  fieldType: integer; title: PTChar; useFields: boolean): integer;
var
 nOption: integer;
 {$ifdef UNICODE}
    buffer: PWideChar;
 {$else}
    buffer: PAnsiChar;
 {$endif}
begin
  buffer := nil;
  nOption := LlGetOption(LL_OPTION_ADDVARSTOFIELDS);

  if useFields then
    LlSetOption(LL_OPTION_ADDVARSTOFIELDS, 1);

  StrPCopyExt(buffer, formularText, 16384);
  fParentObject.DeclareLlXObjectsToLL;
  result := cmbTLl28x.LlDlgEditLineEx(fParentObject.CurrentJobHandle, parentHandle, buffer, 16384, fieldType, title, useFields, nil);
  formularText := buffer;

  if useFields then
    LlSetOption(LL_OPTION_ADDVARSTOFIELDS, nOption);
  if result <> 0 then
    ShowMessage(IntToStr(result));
  LlSetOption(53,0);
  fParentObject.FLlXInterface:=nil;

end;

function LlCore.LlSetPrinterDefaultsDir(Directory: TString): integer;
begin
  Result := cmbtLL28x.LlSetPrinterDefaultsDir(fParentObject.CurrentJobHandle, PTChar(Directory));
end;

{$ifdef UNICODE}
function LlCore.LlSetPrinterInPrinterFile(ProjectType: cardinal;
  const ProjectName: TString; PrinterIndex: integer; const PrinterName: TString;
  const DevModePointer: _PCDEVMODEW): Integer;
{$else}
function LlCore.LlSetPrinterInPrinterFile(ProjectType: cardinal;
  const ProjectName: TString; PrinterIndex: integer; const PrinterName: TString;
  const DevModePointer: _PCDEVMODEA): integer;
{$endif}
begin
  Result := cmbtLL28x.LlSetPrinterInPrinterFile(fParentObject.CurrentJobHandle, ProjectType, PTChar(ProjectName),
    PrinterIndex, PTChar(PrinterName), DevModePointer);
end;

function LlCore.LlSetPrinterToDefault(ProjectType: integer; ProjectName: TString): integer;
begin
  Result := cmbtLL28x.LlSetPrinterToDefault(fParentObject.CurrentJobHandle, ProjectType, PTChar(ProjectName));
end;

function LlCore.LlGetOption(OptionIndex: integer
  ): integer;
begin
  Result := cmbtLL28x.LlGetOption(fParentObject.CurrentJobHandle, OptionIndex);
end;

function LlCore.LlGetOption(Option: TLlOption
  ): integer;
begin
  Result := LlGetOption(integer(Option));
end;

function LlCore.LlPrintGetOption(PrintOptionIndex: integer
  ): integer;
begin
  Result := cmbtLL28x.LlPrintGetOption(fParentObject.CurrentJobHandle, PrintOptionIndex);
end;


Procedure TListLabel28.Design;
Var
  OldMaster : Boolean;
  i, err, currentId           : Integer;
  showexcept       : Boolean;
  DataProvider     : TDataSetDataProvider;
  DataProviderIntf : TDataProviderInterfaceProxyRoot;
  LlProjectType: Integer;
  LlProjectTypeForFileDialog: Integer;
  ProjectFilename: TString;
  WindowHandle: cmbtHWND;

begin
  DeclareLlXObjectsToLL;
  currentId := 10100;
  if FLlXActionList.Count < 0 then
  begin
    for i := 0 to FLlXActionList.Count - 1 do
    begin
      TLDesignerAction28(FLlXActionList.Items[i]).MenuId := currentId;
      TLDesignerAction28(FLlXActionList.Items[i]).AddAction();
      Inc(currentId);
    end;
  end;

  err:=0;
  DataProvider:=nil;
  LlProjectType := TEnumTranslator.TranslateProjectType(FAutoProjectType);

  if FExportOptions <> nil then
  begin
    FExportOptions.SetExportOptions;
  end;

  if (DataController.DataSource = Nil) then
  begin
    raise Exception.Create('No DataSource defined.');
    Exit;
  end
  else if (DataController.DataSource.DataSet = Nil) then
  begin
    Raise Exception.Create('DataSource-DataSet not defined.');
    Exit;
  end;

  if (LlProjectType = LL_PROJECT_LIST) Then
  Begin
     showexcept := False;
     for i := 0 to DataController.DetailSources.Count - 1 do
     Begin
        showexcept := (Datacontroller.DetailSources[i].Datasource = nil) or
                      (Datacontroller.DetailSources[i].Datasource.DataSet = nil);
        if showexcept then break;
     end;

     if showexcept then
     Begin
        raise Exception.Create('DetailSource(s) dataset not defined.');
        Exit;
     End;
  end;

  OldMaster := DataController.DataSource.DataSet.Active;
  DataController.DataSource.DataSet.Active := True;

  for i := 0 to Datacontroller.DetailSources.Count - 1 do
    Datacontroller.DetailSources[i].Datasource.DataSet.Active := True;

  Try
    if Assigned(FOnAutoDefineNewPage) then
      OnAutoDefineNewPage(self, True);

    DataProvider:=InitDataProvider(CurrentJobHandle, nil);
    DataProviderIntf := TDataProviderInterfaceProxyRoot.Create(self, DataProvider);
    LlSetOption(CurrentJobHandle, LL_OPTION_ILLDATAPROVIDER, lParam(ILlDataProvider(DataProviderIntf)));

    if FAutoFileAlsoNew then
    begin
      LlProjectTypeForFileDialog := LlProjectType or LL_FILE_ALSONEW;
    end
    else
    begin
      LlProjectTypeForFileDialog := LlProjectType;
    end;

    if not (csDesigning in ComponentState) then
      WindowHandle := Application.handle
    else
      WindowHandle := GetActiveWindow();

    ProjectFilename := FAutoProjectFile;
    if FAutoShowSelectFile then
      err := CheckError(LlSelectFileDlgTitle(WindowHandle, PChar(FAutoDialogTitle), LlProjectTypeForFileDialog, ProjectFilename));

    if (err <> CE_Abort) then
      CheckError(LLDefineLayout(CurrentJobHandle, WindowHandle, PChar(FAutoDialogTitle), LlProjectType, PChar(ProjectFilename)));

  Finally
    DataController.DataSource.DataSet.Active := OldMaster;
    JobFree(CurrentJobHandle,DataProvider);
  end;
end;

Function TListLabel28.InitDataProvider(JobHandle:HJob; DrillDownFilter: PFilterDescription): TDataSetDataProvider;
Var
    i             : Integer;
    Tables        : TObjectList<TListLabelTable>;
    table         : TListLabelTable;
    Relations     : TObjectList<TListLabelTableRelation>;
    Relation      : TListLabelTableRelation;
    parent        : TDetailSourceItem;
    DataProvider  : TDataSetDataProvider;
    Filter        : String;
    DetailsCollection: TCollection;
Begin

   DataProvider := TDataSetDataProvider.Create;

  //Create and prepare DataProvider
  DetailsCollection := TCollection.Create(TDetailSourceItem);
  DataController.DetailSources.AsPlainList(DetailsCollection);

    Try
    for i := 0 to DetailsCollection.Count - 1 do
    begin
      if Assigned(DrillDownFilter) then
      Begin
        if (TDetailSourceItem(DetailsCollection.Items[i]).Name = DrillDownFilter.ParentTable) then
        Begin
          Filter := DrillDownFilter.ParentKeyField + '=' + DrillDownFilter.KeyValue;
        End
        else if (TDetailSourceItem(DetailsCollection.Items[i]).Name = DrillDownFilter.ChildTable) then
        Begin
          Filter := DrillDownFilter.ChildKeyField + '=' + DrillDownFilter.KeyValue;
        End;
      End
      else
		Filter := '';

		DataProvider.AddDataSet(TDetailSourceItem(DetailsCollection.Items[i]).Name,
													TDetailSourceItem(DetailsCollection.Items[i]).DataSource.DataSet,
													TDetailSourceItem(DetailsCollection.Items[i]).PrimaryKeyField,
													TDetailSourceItem(DetailsCollection.Items[i]).SortDescription,
													Filter);

     if TDetailSourceItem(DetailsCollection.Items[i]).ParentNode <> nil then
      Begin
        Parent := TDetailSourceItem(TDetailSourceItem(DetailsCollection.Items[i]).ParentNode);
        DataProvider.AddRelation(Parent.Name + '2' + TDetailSourceItem(DetailsCollection.Items[i]).Name,Parent.Name,
									TDetailSourceItem(DetailsCollection.Items[i]).Name,
									TDetailSourceItem(DetailsCollection.Items[i]).MasterKeyField,
									TDetailSourceItem(DetailsCollection.Items[i]).DetailKeyField);
      End;
    end;
  Finally
    DetailsCollection.Free;
  End;

   //Reset DataSource in LL
   CleanUpDataStructure;
   CheckError(LlDbAddTable(JobHandle, 'LLStaticTable', ''));

   //Pass tables from DataProvider to LL
   Tables := DataProvider.Tables;

   if DataController.DataMember <> '' then
   begin
      table := DataProvider.GetTable(DataController.DataMember);

      CheckError(LlDbAddTableEx(JobHandle, Pchar(table.TableName), Pchar(table.TableName),1)); //enable advanced sorting
      PassedTables.Add(table.TableName);

      if DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables then
        CheckError(LlDbSetMasterTable(JobHandle, PChar(table.TableName)));

      DefineData(DataProvider, table);
      DefineSortOrders(table);
      FRelationsOfCurrentProvider := DataProvider.Relations;
      FillRootTables(DataProvider, table.TableName);
      DefineRelatedTables(DataProvider, table.TableName);

       //label projects
      if FAutoProjectType <> ptList then
      begin
        LlDbSetMasterTable(JobHandle, PChar(Table.TableName));
      end;

      for relation in DelayedRelations do
      begin
        if PassedRelations.IndexOf(relation) <> -1 then
          continue;

        if (PassedTables.IndexOf(relation.ParentTableName) <> -1) and (PassedTables.IndexOf(relation.ChildTableName) <> -1) then
        begin
          LlDbAddTableRelationEx(JobHandle,
                               Pchar(relation.ChildTableName),
                               Pchar(relation.ParentTableName),
                               Pchar(relation.RelationName),
                               Pchar(relation.RelationName),
                               Pchar(relation.ChildTableName + '.' + relation.ChildColumnName),
                               Pchar(relation.ParentTableName + '.' + relation.ParentColumnName));
          PassedRelations.Add(relation);
        end;
      end;
      FreeAndNil(FRelationsOfCurrentProvider);
      table.Free;
   end
   else
   begin // no DataMember is set... pass all tables to LL

     for table in Tables do
     begin
        CheckError(LlDbAddTableEx(JobHandle, Pchar(Table.TableName), Pchar(Table.TableName),1)); // enable advanced sorting
        DefineData(DataProvider, table);
        DefineSortOrders(table);

        // for label projects, only one table (the first) is supported
        if FAutoProjectType <> ptList then
        begin
          LlDbSetMasterTable(JobHandle, PChar(Table.TableName));
          break;
        end;
     end;

     // pass relations  for list projects
     if FAutoProjectType = ptList then
     begin
       Relations := DataProvider.Relations;
       if (Relations <> nil) then
       begin
          for Relation in Relations do
          begin
             LlDbAddTableRelationEx( JobHandle,
                                     Pchar(Relation.ChildTableName),
                                     Pchar(Relation.ParentTableName),
                                     Pchar(Relation.RelationName),
                                     Pchar(Relation.RelationName),
                                     Pchar(Relation.ChildTableName + '.' + Relation.ChildColumnName),
                                     Pchar(Relation.ParentTableName + '.' + Relation.ParentColumnName));
           end;
           FreeAndNil(Relations);
       end;
     end;
   end;

   Tables.Free;
   result := DataProvider;

End;


procedure TListLabel28.DeclareLlXObjectsToLL;
begin
  FLlXInterface:=nil;
  FLlXInterface:=LlXInterface.Create(FLlXObjectList, FLlXFunctionList);

  Core.LlSetOption(53, lParam(ILlXInterface(FLlXInterface)));
end;

procedure TListLabel28.InitDataSource(projectFile: TString);
  var DataProvider: TDataSetDataProvider;
      DataProviderIntf: TDataProviderInterfaceProxyRoot;
      internalListExt: TString;
begin

  Core.LlGetOptionString(LL_OPTIONSTR_LIST_PRJEXT, internalListExt);
  if(StringReplace(ExtractFileExt(projectFile), '.', '', [rfReplaceAll, rfIgnoreCase]) = internalListExt) then
    begin
        DataProvider:=InitDataProvider(GetJobHandle,nil);
        DataProviderIntf := TDataProviderInterfaceProxyRoot.Create(self, DataProvider);
        LlSetOption(GetJobHandle, LL_OPTION_ILLDATAPROVIDER, lParam(ILlDataProvider(DataProviderIntf)));
        if (FDomDataProvider <> nil) then FDomDataProvider.Free;
        FDomDataProvider:=DataProvider;
    end;

end;

Procedure TListLabel28.DefineData(DataProvider: TDataSetDataProvider; table: TListLabelTable);
Var
  Rows          : TEnumerable<TListLabelTableRow>;
  RowEnumerator : TEnumerator<TListLabelTableRow>;
  Row           : TListLabelTableRow;
  Columns       : TObjectList<TListLabelTableColumn>;
  Column        : TListLabelTableColumn;

Begin

  // define cols/rows
  Rows:= table.Rows;
  RowEnumerator := Rows.GetEnumerator;

  // Pass columns
  Row := RowEnumerator.Current;
  Columns := Row.Columns;

  if Assigned(FOnAutoDefineNewLine) then
    OnAutoDefineNewLine(self, not FIsPrinting);


  for Column in Columns do
  Begin

     case Column.FieldType of
        LL_DRAWING_HMETA,
        LL_DRAWING_HBITMAP,
        LL_DRAWING_HICON:
        begin
          if ((AutoProjectType <> ptList) or ((DataController.DataMember = table.TableName) and (DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables))) then
          begin
            self.FCore.LlDefineVariableExtHandle(table.TableName + '.' + Column.ColumnName, Column.ImgHandle, Column.FieldType);
          end
          else
          begin
            self.FCore.LlDefineFieldExtHandle(table.TableName + '.' + Column.ColumnName, Column.ImgHandle, Column.FieldType);
          end;
        end
        else
        begin
          if ((AutoProjectType <> ptList) or ((DataController.DataMember = table.TableName) and (DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables))) then
          begin
            self.FCore.LlDefineVariableExt(table.TableName + '.' + Column.ColumnName, Column.Content, Column.FieldType)
          end
          else
          begin
            self.FCore.LlDefineFieldExt(table.TableName + '.' + Column.ColumnName, Column.Content, Column.FieldType)
          end;

        end;

     end;

  End;

  FreeAndNil(Columns);
  FreeAndNil(Row);
  FreeAndNil(RowEnumerator);
  FreeAndNil(Rows);

End;


Procedure TListLabel28.DefineSortOrders(table: TListLabelTable);
Var
  Rows          : TEnumerable<TListLabelTableRow>;
  RowEnumerator : TEnumerator<TListLabelTableRow>;
  Row           : TListLabelTableRow;
  Columns       : TObjectList<TListLabelTableColumn>;
  Column        : TListLabelTableColumn;

Begin

  // define cols/rows
  Rows:= table.Rows;
  RowEnumerator := Rows.GetEnumerator;

  // Pass columns
  Row := RowEnumerator.Current;
  Columns := Row.Columns;
  for Column in Columns do
  Begin

     Case Column.FieldType of
        LL_TEXT,
        LL_NUMERIC,
        LL_NUMERIC_INTEGER,
        LL_DATE_DELPHI,
        LL_BOOLEAN:
        Begin

          LlDbAddTableSortOrder(CurrentJobHandle, PChar(table.TableName),PChar(Column.ColumnName+ ':A'),
                                         PChar(Column.ColumnName+' [+]'));

          LlDbAddTableSortOrder(CurrentJobHandle, PChar(table.TableName),PChar(Column.ColumnName+ ':D'),
                                         PChar(Column.ColumnName+' [-]'));
        End;

     End;

  End;

  FreeAndNil(Columns);
  FreeAndNil(Row);
  FreeAndNil(RowEnumerator);
  FreeAndNil(Rows);

End;

procedure TListLabel28.FillRootTables(DataProvider: TDataSetDataProvider;
  DataMember: string);
begin
  RootTables.Clear;
  GetChildTables(DataProvider, DataMember, FRootTables);
end;


procedure TListLabel28.GetChildTables(DataProvider: TDataSetDataProvider;
  TableName: string; var Tables: TStringList);
var
      relation: TListLabelTableRelation;
begin
  if RelationsOfCurrentProvider = nil then
    exit;

  for relation in RelationsOfCurrentProvider do
    begin
      if (relation.ParentTableName = TableName) then
      begin
        if (tables.IndexOf(relation.ChildTableName) = -1) then
        begin
          tables.Add(relation.ChildTableName);
          GetChildTables(DataProvider, relation.ChildTableName, tables);
        end;

      end;

    end;
end;


function TListLabel28.GetJobHandle: Integer;
begin
  result:=CurrentJobHandle;
end;

Procedure TListLabel28.DefineRelatedTables(DataProvider: TDataSetDataProvider; TableName: String);
var
  relation: TListLabelTableRelation;
  relationsToPass: TObjectList<TListLabelTableRelation>;

begin
  if (RelationsOfCurrentProvider <> nil) then
  begin
    relationsToPass := TObjectList<TListLabelTableRelation>.create(false);
    for relation in RelationsOfCurrentProvider do
    begin
      if (TableName <> relation.ParentTableName) and (TableName <> relation.ChildTableName) then
        continue;

      if (TableName = relation.ParentTableName) and ((RootTables.IndexOf(TableName) <> -1) or (TableName = DataController.DataMember)) then
      begin
          PassTableAndHierarchy(DataProvider, relation, relation.ChildTableName, false);
      end
      else
      begin
        // remember for later, as the table might still be available on the root through a different relation
        relationsToPass.Add(relation);
      end;
    end;
    for relation in relationsToPass do
    begin
      PassTableAndHierarchy(DataProvider, relation, relation.ParentTableName, true);
    end;
    FreeAndNil(relationsToPass);
  end;
end;

Procedure TListLabel28.PassTableAndHierarchy(DataProvider: TDataSetDataProvider; relation: TListLabelTableRelation; TableName: String; onlyFor1To1Relations: boolean);
var table: TListLabelTable;
    options: cardinal;
Begin
  options:=1; // enable advanced sorting
  if onlyFor1To1Relations then
    options := options or 4;
  if PassedTables.IndexOf(TableName) <> -1 then
  begin
    DelayedRelations.Add(relation);
    exit;
  end;
  table := DataProvider.GetTable(TableName);
  LlDbAddTableEx(CurrentJobHandle, PChar(TableName), PChar(TableName), options);
  PassedTables.Add(TableName);
  DefineData(DataProvider, table);
  DefineSortOrders(table);
  DefineRelatedTables(DataProvider, TableName);
  table.Free;
End;


Procedure TListLabel28.Print;
Var
  i: Integer;
  temp: Array [0 .. 255] of char;
  OldMaster, ok : Boolean;
  DoPreview: Boolean;
  showexcept: Boolean;
  DataProviderIntf : TDataProviderInterfaceProxyRoot;
  DataProvider     : TDataSetDataProvider;
  LlProjectType: Integer;
  ProjectFilename: TString;
  WindowHandle: cmbtHWND;

begin
  DeclareLlXObjectsToLL;
  DataProvider:=Nil;
  OldMaster := false;
  if FExportOptions <> nil then
  begin
        FExportOptions.SetExportOptions;
  end;

  Try
    if (DataController.DataSource = Nil) then
    begin
      raise Exception.Create('No DataSource assigned.');
      Exit;
    end
    else if (DataController.DataSource.DataSet = Nil) then
    begin
      Raise Exception.Create('DataSource - DataSet not assigned.');
      Exit;
    end;

    LlProjectType := TEnumTranslator.TranslateProjectType(FAutoProjectType);

    if not (csDesigning in ComponentState) then
      WindowHandle := Application.handle
    else
      WindowHandle := GetActiveWindow();

    ProjectFilename := FAutoProjectFile;
    if FAutoShowSelectFile then
    begin
      LlSelectFileDlgTitle(WindowHandle, PChar(FAutoDialogTitle), LlProjectType, ProjectFilename)
    end;

    if (UsedIdentifiers <> nil) then UsedIdentifiers.Free;
    UsedIdentifiers:=LlGetUsedIdentifiers(ProjectFilename, LL_USEDIDENTIFIERSFLAG_VARIABLES or LL_USEDIDENTIFIERSFLAG_FIELDS or LL_USEDIDENTIFIERSFLAG_CHARTFIELDS);

    if (LlProjectType = LL_PROJECT_LIST) Then
    Begin
       showexcept := False;
       for i := 0 to DataController.DetailSources.Count - 1 do
       Begin
          showexcept := DataController.DetailSources[i].Datasource.DataSet = nil;
          if showexcept then break;
       end;

       if showexcept then
        Begin
          Raise Exception.Create('DetailSources - Dataset(s) not assigned.');
          Exit;
        End;
    end;

    if Assigned(DataController.DataSource.DataSet) then
    begin
      with DataController.DataSource.DataSet do
      begin
        Try
          OldMaster := Active;

         DataProvider:=InitDataProvider(CurrentJobHandle,nil);
         DataProviderIntf := TDataProviderInterfaceProxyRoot.Create(self, DataProvider);
         LlSetOption(CurrentJobHandle, LL_OPTION_ILLDATAPROVIDER, lParam(ILlDataProvider(DataProviderIntf)));

         for i := 0 to Datacontroller.DetailSources.Count - 1 do
            Datacontroller.DetailSources[i].Datasource.DataSet.Active := True;

         LlSetOption(CurrentJobHandle,LL_OPTION_SUPPORT_DELAYEDFIELDDEFINITION, 0);

          if not Active then
          begin
            Active := True;
            First;
          end;

          if Assigned(FOnAutoDefineNewPage) then
            OnAutoDefineNewPage(self, True);

          if not(CheckError(LLPrintWithBoxStart(CurrentJobHandle, LlProjectType, PChar(ProjectFilename), TEnumTranslator.TranslatePrintMode(FAutoDestination),
            TEnumTranslator.TranslateAutoBoxType(FAutoBoxType), WindowHandle, PChar(FAutoDialogTitle)))) = CE_OK then
            Abort;

          FIsPrinting := true;
          DoPreview := (TEnumTranslator.TranslatePrintMode(FAutoDestination) = LL_PRINT_PREVIEW);

          if Assigned(FOnDefinePrintOptionsEvent) then
            FOnDefinePrintOptionsEvent(self);

          ok := True;
          if FAutoShowPrintOptions then
          begin
            LlPrintSetOption(CurrentJobHandle, LL_PRNOPT_PRINTDLG_ONLYPRINTERCOPIES, 1);
            ok := CheckError(LLPrintOptionsDialog(CurrentJobHandle, WindowHandle, PChar(FAutoDialogTitle))) = CE_OK;
          end;

          if not(ok) then
          begin
            CheckError(LLPrintEnd(CurrentJobHandle, 0));
            FIsPrinting := false;
            Abort;
          end;

          Case LlPrintGetOption(CurrentJobHandle, LL_PRNOPT_PRINTDLG_DEST) of
            LL_DESTINATION_PRV:    DoPreview := True;
          end;

          if (DoPreview) then
          begin
            GetTempPath(255, temp);
            CheckError(LLPreviewSetTempPath(CurrentJobHandle, temp));
          end;

          if Assigned(FOnAutoDefineNewPage) then
            OnAutoDefineNewPage(self, False);

          while (LlPrint(CurrentJobHandle) = LL_WRN_REPEAT_DATA) and (LlPrintGetOption(CurrentJobHandle, LL_PRNOPT_PAGEINDEX) < LlPrintGetOption(CurrentJobHandle, LL_PRNOPT_LASTPAGE)) do
          begin
            if Assigned(FOnAutoDefineNewPage) then
              OnAutoDefineNewPage(self, False);
          end;

          LlPrintEnd(CurrentJobHandle,0);
          FIsPrinting := false;

          if DoPreview then
          begin
            CheckError(LLPreviewDisplay(CurrentJobHandle, PChar(FAutoProjectFile), temp, WindowHandle));
            CheckError(LLPreviewDeleteFiles(CurrentJobHandle, PChar(FAutoProjectFile), temp));
          end;
        finally
          Active := OldMaster;
          JobFree(CurrentJobHandle,DataProvider);
        end;
      end;
    end;
  Finally
    FreeAndNil(FUsedIdentifiers);
    FIsPrinting := false;
  End;
End;

procedure TListLabel28.DoExport(Wnd: HWND; const ProjectFile,
  OriginalProjectFile: String; MaxPages: Integer; const ExportFormat,
  ExportPath, ExportFile: String; const ExportQuiet, ExportShow: Boolean);
Var
  DataProvider    : TDataSetDataProvider;
  DataProviderIntf: TDataProviderInterfaceProxyRoot;
  JobHandle       : HJob;
  OldJobHandle    : HJob;
  ok : Boolean;
  char1, optionStrPath, optionStrFile, optionStrQuiet, optionStrShow: String;
begin
  DataProvider:=nil;
  JobHandle:=-1;
  OldJobHandle:=CurrentJobHandle;
  ok:=true;
  if FExportOptions <> nil then
  begin
    FExportOptions.SetExportOptions;
  end;

  Try
    with DataController.DataSource.DataSet do
    begin
      Try
        JobHandle := LlJobOpenCopyEx(CurrentJobHandle,LLJOBOPENCOPYEXFLAG_NO_COPY_FIELDLIST or LLJOBOPENCOPYEXFLAG_NO_COPY_DBSTRUCTS or LLJOBOPENCOPYEXFLAG_NO_COPY_XLATTABLES);

        if (JobHandle <= 0) then
          exit;

        CurrentJobHandle:=JobHandle;
        if (UsedIdentifiers <> nil) then UsedIdentifiers.Free;

        UsedIdentifiers:=LlGetUsedIdentifiers(ProjectFile,LL_USEDIDENTIFIERSFLAG_VARIABLES or LL_USEDIDENTIFIERSFLAG_FIELDS or LL_USEDIDENTIFIERSFLAG_CHARTFIELDS);
        DataProvider:=InitDataProvider(JobHandle,nil);
        DataProviderIntf := TDataProviderInterfaceProxyRoot.Create(self, DataProvider);
        LlSetOption(JobHandle, LL_OPTION_ILLDATAPROVIDER, lParam(ILlDataProvider(DataProviderIntf)));
        LlSetOption(JobHandle,LL_OPTION_SUPPORT_DELAYEDFIELDDEFINITION, 0);

        if not Active then
        begin
          Active := True;
          First;
        end;

        if Assigned(FOnAutoDefineNewPage) then
          OnAutoDefineNewPage(self, True);

        if not(CheckError(LLPrintWithBoxStart(JobHandle, TEnumTranslator.TranslateProjectType(FAutoProjectType), PChar(ProjectFile), LL_PRINT_EXPORT,
            TEnumTranslator.TranslateAutoBoxType(FAutoBoxType), Wnd, PChar(FAutoDialogTitle)))) = CE_OK then
            begin
              Abort;
            end;
        FIsPrinting := true;

        if Assigned(FOnAutoDefineNewPage) then
          OnAutoDefineNewPage(self, False);

        LlPrintSetOptionString(JobHandle,LL_PRNOPTSTR_EXPORT, PChar(ExportFormat));

        if ExportFormat.Length = 0 then
        begin
          LlPrintSetOption(CurrentJobHandle, LL_PRNOPT_PRINTDLG_ONLYPRINTERCOPIES, 1);
          ok := CheckError(LLPrintOptionsDialog(CurrentJobHandle, Wnd, PChar(FAutoDialogTitle))) = CE_OK;
        end;

        if ExportFile.Length > 0 then
        begin
          char1 := '1';
          if ExportPath.Length > 0 then
          begin
            optionStrPath := 'Export.Path';
            LlXSetExportParameter(JobHandle, PChar(ExportFormat), PChar(optionStrPath), PChar(ExportPath));
          end;
          optionStrFile := 'Export.File';
          LlXSetExportParameter(JobHandle, PChar(ExportFormat), PChar(optionStrFile), PChar(ExportFile));
          if ExportQuiet then
          begin
            optionStrQuiet := 'Export.Quiet';
            LlXSetExportParameter(JobHandle, PChar(ExportFormat), PChar(optionStrQuiet), PChar(char1));
          end;
          if ExportShow then
          begin
            optionStrShow := 'Export.ShowResult';
            LlXSetExportParameter(JobHandle, PChar(ExportFormat), PChar(optionStrShow), PChar(char1));
          end;
        end;

        if not(ok) then
          begin
            CheckError(LLPrintEnd(CurrentJobHandle, 0));
            FIsPrinting := false;
            Abort;
          end;



        while (LlPrint(JobHandle) = LL_WRN_REPEAT_DATA) and (LlPrintGetOption(JobHandle, LL_PRNOPT_PAGEINDEX) < LlPrintGetOption(JobHandle, LL_PRNOPT_LASTPAGE)) do
        begin
          if Assigned(FOnAutoDefineNewPage) then
            OnAutoDefineNewPage(self, False);
        end;
        LlPrintEnd(JobHandle,0);
        FIsPrinting := false;
      finally
        FIsPrinting := false;
        JobFree(JobHandle,DataProvider);
        CurrentJobHandle:=OldJobHandle;
      end;
    end;
  Finally
    FreeAndNil(FUsedIdentifiers);
  end;
End;

procedure TListLabel28.DoExport(Wnd: HWND; const ProjectFile, OriginalProjectFile: String;
  MaxPages: Integer; const ExportFormat: String);
begin
  DoExport(Wnd, ProjectFile, OriginalProjectFile, MaxPages, ExportFormat,
  '', '', False, False);
end;

Procedure TListLabel28.DoPreviewAndDrilldown( Wnd               : HWND;
                                           DrillDown          : Boolean;
                                           ProjectFile       : String;
                                           OriginalProjectFile: String;
                                           MaxPages          : Integer;
                                           PreviewFile       : String;
                                           AFilter            : PFilterDescription;
                                           AttachInfo         : THandle);
Var
  DataProvider    : TDataSetDataProvider;
  DataProviderIntf: TDataProviderInterfaceProxyRoot;
  JobHandle       : HJob;
  OldJobHandle    : HJob;
  PreviewFileName : String;

  // -----------------------------------------------------
  function GetTempFile: string;
  var Buffer: PWideChar;
  begin
    GetMem(Buffer, (MAX_PATH + 1) * sizeof(Char));
    LlGetTempFileName('~', 'll', Buffer, MAX_PATH+ 1, 0);
    result:=String(Buffer);
    FreeMem(Buffer);
  end;
  // -----------------------------------------------------

begin
  DataProvider:=nil;
  JobHandle:=-1;
  OldJobHandle:=CurrentJobHandle;
  if FExportOptions <> nil then
  begin
    FExportOptions.SetExportOptions;
  end;

  Try
    with DataController.DataSource.DataSet do
    begin
      Try
        JobHandle := LlJobOpenCopyEx(CurrentJobHandle,LLJOBOPENCOPYEXFLAG_NO_COPY_FIELDLIST or LLJOBOPENCOPYEXFLAG_NO_COPY_DBSTRUCTS or LLJOBOPENCOPYEXFLAG_NO_COPY_XLATTABLES);

        if (JobHandle <= 0) then
          exit;

        CurrentJobHandle:=JobHandle;
        if (UsedIdentifiers <> nil) then UsedIdentifiers.Free;

        UsedIdentifiers:=LlGetUsedIdentifiers(ProjectFile,LL_USEDIDENTIFIERSFLAG_VARIABLES or LL_USEDIDENTIFIERSFLAG_FIELDS or LL_USEDIDENTIFIERSFLAG_CHARTFIELDS);
        DataProvider:=InitDataProvider(JobHandle,AFilter);

        if DrillDown Then
        Begin
          FDrilldownActive:=True;
          PreviewFileName:=PreviewFile;
        end else
        Begin
          PreviewFileName := GetTempFile();
          LlSetOptionString(JobHandle,LL_OPTIONSTR_ORIGINALPROJECTFILENAME,PChar(OriginalProjectFile));
        end;

        LlSetOptionString(JobHandle,LL_OPTIONSTR_PREVIEWFILENAME, PChar(PreviewFileName));

        if DrillDown then
          LlAssociatePreviewControl(JobHandle,AttachInfo,
                                          LL_ASSOCIATEPREVIEWCONTROLFLAG_DELETE_ON_CLOSE or
                                          LL_ASSOCIATEPREVIEWCONTROLFLAG_HANDLE_IS_ATTACHINFO or
                                          LL_ASSOCIATEPREVIEWCONTROLFLAG_PRV_ADD_TO_CONTROL_STACK)
        else
          LlAssociatePreviewControl(JobHandle, Wnd, 1);

        DataProviderIntf := TDataProviderInterfaceProxyRoot.Create(self, DataProvider);
        LlSetOption(JobHandle, LL_OPTION_ILLDATAPROVIDER, lParam(ILlDataProvider(DataProviderIntf)));
        LlSetOption(JobHandle,LL_OPTION_SUPPORT_DELAYEDFIELDDEFINITION, 0);

        if not Active then
        begin
          Active := True;
          First;
        end;

        if Assigned(FOnAutoDefineNewPage) then
          OnAutoDefineNewPage(self, True);

        if not(CheckError(LLPrintWithBoxStart(JobHandle, TEnumTranslator.TranslateProjectType(FAutoProjectType), PChar(ProjectFile), LL_PRINT_PREVIEW,
            TEnumTranslator.TranslateAutoBoxType(FAutoBoxType), Wnd, PChar(FAutoDialogTitle)))) = CE_OK then
            begin
              Abort;
            end;
        FIsPrinting := true;

        if Assigned(FOnAutoDefineNewPage) then
          OnAutoDefineNewPage(self, False);

        while (LlPrint(JobHandle) = LL_WRN_REPEAT_DATA) and (LlPrintGetOption(JobHandle, LL_PRNOPT_PAGEINDEX) < LlPrintGetOption(JobHandle, LL_PRNOPT_LASTPAGE)) do
        begin
          if Assigned(FOnAutoDefineNewPage) then
            OnAutoDefineNewPage(self, False);
        end;
        LlPrintEnd(JobHandle,0);
        FIsPrinting := false;
      finally
        FIsPrinting := false;
        LlAssociatePreviewControl(JobHandle, 0, 1);
        JobFree(JobHandle,DataProvider);
        CurrentJobHandle:=OldJobHandle;
        if DrillDown then FDrilldownActive:=False;
      end;
    end;
  Finally
    FreeAndNil(FUsedIdentifiers);
  end;
End;


Procedure TListLabel28.AbortPrinting();
begin
  if (CurrentJobHandle > 0) then
  begin
    LlPrintAbort(CurrentJobHandle);
  end;
end;

function TListLabel28.GetCore: LlCore;
begin

  if(FCore = nil) then
    begin
      FCore := LlCore.Create(Self);
    end;
    Result:= FCore
end;

//

Constructor LlCore.Create(ParentObject: TListLabel28);
begin
   fParentObject := ParentObject;
end;

function LlCore.LlGetOptionString(OptionIndex: integer;
  var Value: TString): integer;
var
  Buffer: PTChar;
  Length: integer;
begin
  Length := cmbTLl28x.LlGetOptionString(fParentObject.CurrentJobHandle, OptionIndex, nil,
    0);
  if length>0 then
  begin
    GetMem(Buffer, Length * sizeof(TChar));
    Buffer^ := #0;
    Result := cmbTLl28x.LlGetOptionString(fParentObject.CurrentJobHandle, OptionIndex, Buffer,
      Length);
    Value := TString(Buffer);
    FreeMem(Buffer);
  end
  else
  begin
    result:=length;
    Value:='';
  end;
end;

{$ifdef UNICODE}
function LlCore.LlGetPrinterFromPrinterFile(ProjectType: Cardinal;
  ProjectName: TString; PrinterIndex: integer; var Printer: TString;
  var DevMode: _PDEVMODEW): Integer;

{$else}
function LlCore.LlGetPrinterFromPrinterFile(ProjectType: Cardinal; ProjectName: TString;
  PrinterIndex: integer; var Printer: TString;
  var DevMode: _PDEVMODEA): integer;
{$endif}
var
 BufPrinter: PTChar;
 {$ifdef UNICODE}
 BufDevMode: _PDEVMODEW;
 {$else}
 BufDevMode: _PDEVMODEA;
 {$endif}
 PrnSize, DevModeSize: cardinal;
 nRet: integer;
begin
  nRet := cmbTLl28x.LlGetPrinterFromPrinterFile(fParentObject.CurrentJobHandle, ProjectType, PTChar(ProjectName),
                                                PrinterIndex, nil, @PrnSize, nil, @DevModeSize);
  if nRet >= 0 then
  begin
   GetMem(BufPrinter, PrnSize*Sizeof(TChar));
   GetMem(BufDevMode, DevModeSize*Sizeof(TChar));
   BufPrinter^ := #0;
   nRet := cmbTLl28x.LlGetPrinterFromPrinterFile(fParentObject.CurrentJobHandle, ProjectType, PTChar(ProjectName),
                                                PrinterIndex, PTChar(BufPrinter), @PrnSize, BufDevMode, @DevModeSize);
   Printer := TString(BufPrinter);
   DevMode := BufDevMode;
   FreeMem(PTChar(BufPrinter));
  end;
  Result := nRet;
end;

function LlCore.LlPrintGetPrinterInfo(var PrinterName,
  PrinterPort: TString): Integer;
var
  BufPrinter, BufPort: PTChar;
begin
  GetMem(BufPrinter, 128 * sizeof(TChar));
  GetMem(BufPort, 40 * sizeof(TChar));
  BufPrinter^ := #0;
  BufPort^ := #0;
  Result := cmbTLl28x.LlPrintGetPrinterInfo(fParentObject.CurrentJobHandle, BufPrinter, 128 - 1, BufPort, 40 - 1);
  PrinterName := TString(BufPrinter);
  PrinterPort := TString(BufPort);
  FreeMem(BufPrinter);
  FreeMem(BufPort);
end;

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

//==============================================================================
//  TLlExprEvaluator
//==============================================================================
 constructor TLlExprEvaluator.Create(Parent: TListLabel28; Expression: TString;
    IncludeTablefields: boolean);
  var
    pszErrorBuffer: PTChar;
    {$ifdef VER90}
    Content: Variant;
    {$else}
    Content: OleVariant;
    {$endif}
  begin
    inherited Create;
    FParent := Parent;
    VariantInit(Content);
    GetMem(pszErrorBuffer, 1024 * sizeof(TChar));
    FParent.DeclareLlXObjectsToLL;
    FExprPointer := cmbtll28x.LlExprParse(Parent.CurrentJobHandle, PTChar(Expression), IncludeTablefields);
    FErrorValue := cmbtll28x.LlExprEvaluateVar(Parent.CurrentJobHandle, FExprPointer, cmbtll28x.PVARIANT(@Content), 0);
    if (FErrorValue = 0) then
    begin
      FResult := Content;
      FExprType := cmbtll28x.LlExprType(Parent.CurrentJobHandle, FExprPointer);
    end
    else
    begin
      FResult := '';
      FExprType := 0;
      cmbtll28x.LlExprError(Parent.CurrentJobHandle, pszErrorBuffer, 1024 - 1);
      FErrorText := TString(pszErrorBuffer);
    end;
    FExpression := Expression;
    VariantClear(Content);
    FreeMem(pszErrorBuffer);
  end;



procedure TLlExprEvaluator.SetExpression(const Value: TString);
begin
  FExpression := Value;
end;

procedure TLlExprEvaluator.EditExpression(title: TString);
var
  WinHandle: cmbtHWND;
begin

//  if FParent.Owner is TDataModule then
//    WinHandle := GetActiveWindow()
//  else
//  if TForm(FParent.Owner).HandleAllocated then
//    WinHandle := TForm(FParent.Owner).Handle
//  else
  WinHandle := GetActiveWindow();

  FParent.Core.LlDlgEditLineEx(WinHandle, FExpression, LL_TYPEMASK, PTChar(title), true);

end;

  destructor TLlExprEvaluator.Destroy;
  begin
    cmbtll28x.LlExprFree(FParent.CurrentJobHandle, FExprPointer);
    FParent.Core.LlSetOption(53,0);

    inherited Destroy;
  end;




{ TLl28RTFObject }

  function TLlRTFControl28.CopyToClipboard: integer;
  begin
    if Assigned(FMyParentComponent) then
        Result := LlRTFCopyToClipboard(FMyParentComponent.CurrentJobHandle, FHandle)
    else
    begin
        raise ENoParentComponentError.Create('No parent component assigned');
    end;
  end;


constructor TLlRTFControl28.Create(AOwner: TComponent);
begin
    inherited create(AOwner);
    PrintState := psPending;
    ContentMode := cmEvaluated;
    TextMode := tmRTF;
    FFirst:=true;
end;

procedure TLlRTFControl28.CreateWnd;
begin
    inherited CreateWnd;
    if FFirst then
    begin
        if not (csDesigning in ComponentState) then
        begin
            if Assigned(FMyParentComponent) then
            begin
               FHandle := LlRTFCreateObject(FMyParentComponent.CurrentJobHandle);
               cmbTLl28x.LlRTFEditObject(FMyParentComponent.CurrentJobHandle, FHandle, handle, 0, LL_PROJECT_LIST, false);
               FFirst:=False;
            end
            else
                raise ENoParentComponentError.Create('No parent component assigned');
        end;

    end;
end;

destructor TLlRTFControl28.Destroy;
  begin
    if not (csDesigning in ComponentState) and Assigned(FMyParentComponent) then
        LlRTFDeleteObject(FMyParentComponent.CurrentJobHandle, FHandle);
    inherited Destroy;
  end;

function TLlRTFControl28.Display(Canvas: TCanvas; Rect: TRect;
    FromStart: boolean): integer;
  var
    State: integer;
    pRect: cmbTLl28x._PRECT;
  begin
    if Assigned(FMyParentComponent) then
    begin
      if ((Rect.Left = Rect.Right) and (Rect.Top = Rect.Bottom)) then pRect := nil
      else
        pRect := @Rect;
      Result := LlRTFDisplay(FMyParentComponent.CurrentJobHandle,
        FHandle,
        Canvas.Handle,
        pRect,
        FromStart,
        LLPUINT(@State));
      if State = LL_WRN_REPEAT_DATA then
        PrintState := psPending
      else
        PrintState := psFinished;
    end
    else
    begin
        raise ENoParentComponentError.Create('No parent component assigned');
    end;

  end;


  function TLlRTFControl28.GetText: TString;
  var
    Flags: integer;
    Length: integer;
    Buffer: PTChar;
  begin
    Flags := 0;
    case TextMode of
      tmRTF: Flags := LL_RTFTEXTMODE_RTF;
      tmPlain: Flags := LL_RTFTEXTMODE_PLAIN;
    end;
    case ContentMode of
      cmRaw: Flags := Flags or LL_RTFTEXTMODE_RAW;
      cmEvaluated: Flags := Flags or LL_RTFTEXTMODE_EVALUATED;
    end;
    if Assigned(FMyParentComponent) then
    begin
      Length := LlRTFGetTextLength(FMyParentComponent.CurrentJobHandle, FHandle, Flags);
      if length>0 then
      begin
        GetMem(Buffer, (Length + 1) * sizeof(TChar));
        Buffer^ := #0;
        LlRTFGetText(FMyParentComponent.CurrentJobHandle, FHandle, Flags, Buffer, Length+1);
        Result := TString(Buffer);
        FreeMem(Buffer);
      end
      else
        result:='';
    end
    else
        raise ENoParentComponentError.Create('No parent component assigned');
  end;

  function TLlRTFControl28.ProhibitAction(ControlID: integer): integer;
begin
    result:=LlRTFEditorProhibitAction(FMyParentComponent.CurrentJobHandle, FHandle, ControlID);
end;

procedure TLlRTFControl28.SetContentMode(const Value: TLlRTFContentMode);
  begin
    FContentMode := Value;
  end;

  procedure TLlRTFControl28.SetMyParentComponent(const Value: TListLabel28);
begin
  FMyParentComponent := Value;
end;

procedure TLlRTFControl28.SetPrintState(const Value: TLlRTFPrintState);
  begin
    FPrintState := Value;
  end;

  procedure TLlRTFControl28.SetText(const Value: TString);
  begin
    if not (csDesigning in ComponentState) then
    begin
        if Assigned(FMyParentComponent) then
            LlRTFSetText(FMyParentComponent.CurrentJobHandle, FHandle, PTChar(Value))
        else
            raise ENoParentComponentError.Create('No parent component assigned');
    end;

  end;

  procedure TLlRTFControl28.SetTextMode(const Value: TLlRTFTextMode);
  begin
    FTextMode := Value;
  end;

procedure TLlRTFControl28.WndProc(var Message: TMessage);
var hCtl: HWND;
begin
  inherited;
  if Message.Msg = WM_GETDLGCODE then
  begin
        hCtl:=GetParent(GetFocus);
        while (hCtl<>0) and (hCtl<>GetDesktopWindow) do
        begin
                if hCtl = Handle then
                begin
                    Message.Result:=SendMessage(GetFocus, Message.Msg, Message.WParam, Message.LParam); // DLGC_WANTMESSAGE or DLGC_WANTARROWS or DLGC_WANTTAB;
                    break;
                end;
                hCtl:=GetParent(hCtl);
        end;
  end;
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
{TLlDesignerFunction28Parameter}

procedure TLlDesignerFunction28Parameter.SetParameterDescription(
  const Value: String);
begin
  FParameterDescription := Value;
end;

procedure TLlDesignerFunction28Parameter.SetParameterType(
  const Value: TLlDesignerFunction28ParameterType);
begin
  FParameterType := Value;
end;
{/TLlDesignerFunction28Parameter}

//==============================================================================
//  TListLabelExportOptions
//==============================================================================

  constructor TListLabelExportOptions.Create(parent: TListLabel28);
  begin
    inherited Create;
    fParent:= parent;
    fInternalOptionList:= TDictionary<TString, TString>.Create;
  end;

  destructor TListLabelExportOptions.Destroy;
  begin
    fInternalOptionList.Free;
      inherited Destroy;
  end;

  procedure TListLabelExportOptions.Clear();
  begin
  // clear data in LL job
    if fParent <> nil then
    begin
      fParent.Core.LlXSetParameter(TLlExtensionType.Export, '', '', '');
    end;

    // clear internal data
    fInternalOptionList.Clear();

  end;

  procedure TListLabelExportOptions.Add(option: TString; value: TString);
  begin
  // redmine ticket #4312
    if Contains(option) then
    begin
      fInternalOptionList.Remove(option);
    end;

    fInternalOptionList.Add(option, value);

  end;

  procedure TListLabelExportOptions.Add(option: TLlExportOption; value: TString);
  begin
    Add(GetExportOptionString(option), value);
  end;

  function TListLabelExportOptions.Keys(): TCollection;
  begin
    result:= TCollection(fInternalOptionList.Keys);
  end;

  function TListLabelExportOptions.Count(): integer;
  begin
    result:= fInternalOptionList.Count;
  end;

  function TListLabelExportOptions.Contains(option: TString): bool;
    begin
      result:= fInternalOptionList.ContainsKey(option);
    end;

  function TListLabelExportOptions.Contains(option: TLlExportOption): bool;
    begin
      result:= Contains(GetExportOptionString(option));
    end;

  //ExportEnumHelper
  function TListLabelExportOptions.GetExtensionFromExportTarget(exportTarget: TLlExportTarget): TString;
  begin
    case (exportTarget) of
      Pdf:
            result:= 'pdf';
      Html:
            result:= 'htm';
      Xhtml:
            result:= 'htm';
      Jqm:
            result:= 'htm';
      Rtf:
            result:= 'rtf';
      Bitmap:
            result:= 'bmp';
      MetaFile:
            result:= 'emf';
      Tiff:
            result:= 'tif';
      MultiTiff:
            result:= 'tif';
      Jpeg:
            result:= 'jpg';
      Png:
            result:= 'png';
      Xls:
            result:= 'xls';
      Xlsx:
            result:= 'xlsx';
      Docx:
            result:= 'docx';
      Xps:
            result:= 'xps';
      Mhtml:
            result:= 'mhtml';
      Xml:
            result:= 'xml';
      Text:
            result:= 'txt';
      TextLayout:
            result:= 'txt';
      Tty:
            result:= 'tty';
      Preview:
            result:= 'll';
      Svg:
            result:= 'svg';
      Pptx:
            result:= 'pptx';
      Json:
            result:= 'json';
      else
      result:= '';
      end;
  end;
  function TListLabelExportOptions.GetTargetFromString(target: TString): TLlExportTarget;
  var upperTarget: TString;
  begin
      upperTarget:= target.ToUpper;

      if upperTarget =      'HTML5' then begin
      //doesn't matter what to return
                          result:= Html;
      end
      else if upperTarget = 'PDF' then  begin
                          result:= Pdf;
      end

      else if upperTarget = 'HTML' then  begin
                          result:= Html;
      end
      else if upperTarget = 'RTF' then  begin
                          result:= Rtf;
      end
      else if upperTarget = 'PICTURE_BMP' then begin
                          result:= Bitmap;
      end
      else if upperTarget = 'PICTURE_EMF' then begin
                          result:= MetaFile;
      end

      else if upperTarget =  'PICTURE_TIFF' then begin
                          result:= Tiff;
      end

      else if upperTarget =  'PICTURE_MULTITIFF' then begin
                          result:= MultiTiff;
      end

      else if upperTarget =   'PICTURE_JPEG' then begin
                          result:= Jpeg;
      end

      else if upperTarget =   'PICTURE_PNG' then begin
                          result:= Png;
      end

      else if upperTarget =   'XLS' then begin
                          result:= Xls;
      end

      else if upperTarget =    'XLSX' then begin
                          result:= Xlsx;
      end

      else if upperTarget =    'DOCX' then begin
                          result:= Docx;
      end

      else if upperTarget =     'XPS' then begin
                          result:= Xps;
      end

      else if upperTarget =     'MHTML' then begin
                          result:= Mhtml;
      end

      else if upperTarget =     'XHTML' then begin
                          result:= Xhtml;
      end

      else if upperTarget =      'SVG' then begin
                          result:= Svg;
      end

      else if upperTarget =      'JQM' then begin
                          result:= Jqm;
      end

      else if upperTarget =      'XML' then begin
                          result:= Xml;
      end

      else if upperTarget =      'TXT' then begin
                          result:= Text;
      end

      else if upperTarget =      'TXT_LAYOUT' then begin
                          result:= TextLayout;
      end

      else if upperTarget =      'TTY' then begin
                          result:= Tty;
      end

      else if upperTarget =      'PRV' then begin
                          result:= Preview;
      end

      else if upperTarget =      'PPTX' then begin
                          result:= Pptx;
      end

      else if upperTarget =      'JSON' then begin
                          result:= Json;
      end
      else begin
       result:= unknown;
      end;

  end;
  function TListLabelExportOptions.GetString(exportTarget: TLlExportTarget): TString;
  begin
      case (exportTarget) of
      Pdf:
          result:= 'PDF';
      Html:
          result:= 'HTML';
      Rtf:
          result:= 'RTF';
      Bitmap:
          result:= 'PICTURE_BMP';
      MetaFile:
          result:= 'PICTURE_EMF';
      Tiff:
          result:= 'PICTURE_TIFF';
      MultiTiff:
          result:= 'PICTURE_MULTITIFF';
      Jpeg:
          result:= 'PICTURE_JPEG';
      Png:
          result:= 'PICTURE_PNG';
      Xls:
          result:= 'XLS';
      Xlsx:
          result:= 'XLS';
      Docx:
          result:= 'DOCX';
      Xps:
          result:= 'XPS';
      Mhtml:
          result:= 'MHTML';
      Xhtml:
          result:= 'XHTML';
      Jqm:
          result:= 'JQM';
      Xml:
          result:= 'XML';
      Text:
          result:= 'TXT';
      TextLayout:
          result:= 'TXT_LAYOUT';
      Tty:
          result:= 'TTY';
      Preview:
          result:= 'PRV';
      Svg:
          result:= 'SVG';
      Pptx:
          result:= 'PPTX';
      Json:
          result:= 'JSON';
      else
          result:='';
      end;

  end;
  function TListLabelExportOptions.GetExportOptionString(exportOption: TLlExportOption): TString;
    begin
      case TLlExportOption(exportOption) of
        ExportFile:
                            result:= 'Export.File';
        ExportPath:
                            result:= 'Export.Path';
        ExportAllInOneFile:
                            result:= 'Export.AllInOneFile';
        ExportTarget:
                            result:= 'Export.Target';
        ExportQuiet:
                            result:= 'Export.Quiet';
        ExportShowResult:
                            result:= 'Export.ShowResult';
        ExportShowResultAvailable:
                            result:= 'Export.ShowResultAvailable';
        ExportSendAsMail:
                            result:= 'Export.SendAsMail';
        ExportSendAsMailAvailable:
                            result:= 'Export.SendAsMailAvailable';
        ExportMailBody:
                            result:= 'Export.Mail.Body';
        ExportMailHtmlBody:
                            result:= 'Export.Mail.Body:text/html';
        ExportMailSecureConnection:
                            result:= 'Export.Mail.SecureConnection';
        ExportMailAttachmentList:
                            result:= 'Export.Mail.AttachmentList';
        ExportMailSmtpServerTimeOut:
                            result:= 'Export.Mail.SMTP.ServerTimeOut';
        ExportMailSmtpServerAddress:
                            result:= 'Export.Mail.SMTP.ServerAddress';
        ExportMailSmtpServerPort:
                            result:= 'Export.Mail.SMTP.ServerPort';
        ExportMailSmtpUser:
                            result:= 'Export.Mail.SMTP.User';
        ExportMailSmtpPassword:
                            result:= 'Export.Mail.SMTP.Password';
        ExportMailSmtpProxyType:
                            result:= 'Export.Mail.SMTP.ProxyType';
        ExportMailSmtpProxyAddress:
                            result:= 'Export.Mail.SMTP.ProxyAddress';
        ExportMailSmtpProxyPort:
                            result:= 'Export.Mail.SMTP.ProxyPort';
        ExportMailSmtpProxyUser:
                            result:= 'Export.Mail.SMTP.ProxyUser';
        ExportMailSmtpProxyPassword:
                            result:= 'Export.Mail.SMTP.ProxyPassword';
        ExportMailSmtpSenderAddress:
                            result:= 'Export.Mail.SMTP.SenderAddress';
        ExportMailSmtpSenderName:
                            result:= 'Export.Mail.SMTP.SenderName';
        ExportMailSmtpReplyTo:
                            result:= 'Export.Mail.SMTP.ReplyTo';
        ExportMailSmtpFrom:
                            result:= 'Export.Mail.SMTP.From';
        ExportMailSmtpPopBeforeSmtp:
                            result:= 'Export.Mail.SMTP.POPBeforeSMTP';
        ExportMailSmtpServerUser:
                            result:= 'Export.Mail.SMTP.ServerUser';
        ExportMailSmtpServerPassword:
                            result:= 'Export.Mail.SMTP.ServerPassword';
        ExportMailTo:
                            result:= 'Export.Mail.To';
        ExportMailCc:
                            result:= 'Export.Mail.CC';
        ExportMailBcc:
                            result:= 'Export.Mail.BCC';
        ExportMailProvider:
                            result:= 'Export.Mail.Provider';
        ExportMailSubject:
                            result:= 'Export.Mail.Subject';
        ExportMailShowDialog:
                            result:= 'Export.Mail.ShowDialog';
        ExportMailSendResultAs:
                            result:= 'Export.Mail.SendResultAs';
        ExportSaveAsZip:
                            result:= 'Export.SaveAsZIP';
        ExportSaveAsZipAvailable:
                            result:= 'Export.SaveAsZIPAvailable';
        ExportZipFile:
                            result:= 'Export.ZIPFile';
        ExportZipPath:
                            result:= 'Export.ZIPPath';
        ExportOnlyTableData:
                            result:= 'Export.OnlyTableData';
        ExportInfinitePage:
                            result:= 'Export.InfinitePage';
        ExportSignResult:
                            result:= 'Export.SignResult';
        ExportSignResultAvailable:
                            result:= 'Export.SignResultAvailable';
        ExportSignatureProvider:
                            result:= 'Export.SignatureProvider';
        ExportSignatureProviderOption:
                            result:= 'Export.SignatureProvider.Option';
        ExportSignatureFormat:
                            result:= 'Export.SignatureFormat';
        PictureJpegEncoding:
                            result:= 'Picture.JpegEncoding';
        PictureFormat:
                            result:= 'Picture.Format';
        PictureJpegQuality:
                            result:= 'Picture.JPEGQuality';
        PictureBitsPerPixel:
                            result:= 'Picture.BitsPerPixel';
        PictureCropFile:
                            result:= 'Picture.CropFile';
        PictureCropFrameWidth:
                            result:= 'Picture.CropFrameWidth';
        UsePosFrame:
                            result:= 'UsePosFrame';
        VerbosityRectangle:
                            result:= 'Verbosity.Rectangle';
        VerbosityBarcode:
                            result:= 'Verbosity.Barcode';
        VerbosityDrawing:
                            result:= 'Verbosity.Drawing';
        VerbosityEllipse:
                            result:= 'Verbosity.Ellipse';
        VerbosityLine:
                            result:= 'Verbosity.Line';
        VerbosityText:
                            result:= 'Verbosity.Text';
        VerbosityTextFrames:
                            result:= 'Verbosity.Text.Frames';
        VerbosityRtf:
                            result:= 'Verbosity.RTF';
        VerbosityRtfFrames:
                            result:= 'Verbosity.RTF.Frames';
        VerbosityTable:
                            result:= 'Verbosity.Table';
        VerbosityTableCell:
                            result:= 'Verbosity.Table.Cell';
        VerbosityTableFrames:
                            result:= 'Verbosity.Table.Frames';
        VerbosityLLXObject:
                            result:= 'Verbosity.LLXObject';
        VerbosityLLXObjectHtmlObject:
                            result:= 'Verbosity.LLXObject.HTMLObj';
        HtmlTitle:
                            result:= 'HTML.Title';
        HtmlFormHeader:
                            result:= 'HTML.FormHeader';
        HtmlFormFooter:
                            result:= 'HTML.FormFooter';
        LayouterPercentaged:
                            result:= 'Layouter.Percentaged';
        LayouterFixedPageHeight:
                            result:= 'Layouter.FixedPageHeight';
        PdfTitle:
                            result:= 'PDF.Title';
        PdfSubject:
                            result:= 'PDF.Subject';
        PdfKeywords:
                            result:= 'PDF.Keywords';
        PdfAuthor:
                            result:= 'PDF.Author';
        PdfCreator:
                            result:= 'PDF.Creator';
        PdfEncryptionEncryptFile:
                            result:= 'PDF.Encryption.EncryptFile';
        PdfEncryptionEnablePrinting:
                            result:= 'PDF.Encryption.EnablePrinting';
        PdfEncryptionEnableChanging:
                            result:= 'PDF.Encryption.EnableChanging';
        PdfEncryptionEnableCopying:
                            result:= 'PDF.Encryption.EnableCopying';
		PdfEncryptionEnableFillingForms:
                            result:= 'PDF.Encryption.EnableFillingForms';
		PdfEncryptionEnableAnnotating:
                            result:= 'PDF.Encryption.EnableAnnotating';
        PdfEncryptionLevel:
                            result:= 'PDF.Encryption.Level';
        PdfOwnerPassword:
                            result:= 'PDF.OwnerPassword';
        PdfUserPassword:
                            result:= 'PDF.UserPassword';
        PdfExcludedFonts:
                            result:= 'PDF.ExcludedFonts';
        PdfCompressStreamMethod:
                            result:= 'PDF.CompressStreamMethod';
        PdfFileAttachments:
                            result:= 'PDF.FileAttachments';
        PdfConformance:
                            result:= 'PDF.Conformance';
        PdfZUGFeRDXmlPath:
                            result:= 'PDF.ZUGFeRDXmlPath';
        PdfZUGFeRDConformanceLevel:
                            result:= 'PDF.ZUGFeRDConformanceLevel';
        PdfZUGFeRDVersion:
                            result:= 'PDF.ZUGFeRDVersion';
        Resolution:
                            result:= 'Resolution';
        TxtFrameChar:
                            result:= 'TXT.FrameChar';
        TxtSeparatorChar:
                            result:= 'TXT.SeparatorChar';
        TxtIgnoreGroupLines:
                            result:= 'TXT.IgnoreGroupLines';
        TxtIgnoreHeaderFooterLines:
                            result:= 'TXT.IgnoreHeaderFooterLines';
        TxtCharset:
                            result:= 'TXT.Charset';
        TtyEmulation:
                            result:= 'TTY.Emulation';
        TtyDestination:
                            result:= 'TTY.Destination';
        TtyDefaultFilename:
                            result:= 'TTY.DefaultFilename';
        TtyAdvanceAfterPrint:
                            result:= 'TTY.AdvanceAfterPrint';
        TiffCompressionType:
                            result:= 'TIFF.CompressionType';
        TiffCompressionQuality:
                            result:= 'TIFF.CompressionQuality';
        XlsFontScalingPercentage:
                            result:= 'XLS.FontScalingPercentage';
        XlsPrintingZoom:
                            result:= 'XLS.PrintingZoom';
        XlsIgnoreGroupLines:
                            result:= 'XLS.IgnoreGroupLines';
        XlsIgnoreHeaderFooterLines:
                            result:= 'XLS.IgnoreHeaderFooterLines';
        XlsIgnoreLineWrapForDataOnlyExport:
                            result:= 'XLS.IgnoreLinewrapForDataOnlyExport';
        XlsConvertNumeric:
                            result:= 'XLS.ConvertNumeric';
        XlsAllPagesOneSheet:
                            result:= 'XLS.AllPagesOneSheet';
        XlsWorksheetName:
                            result:= 'XLS.WorksheetName';
        XlsAutoFit:
                            result:= 'XLS.AutoFit';
        XmlTitle:
                            result:= 'XML.Title';
        XhtmlUseAdvancedCss:
                            result:= 'XHTML.UseAdvancedCSS';
        XhtmlToolbarType:
                            result:= 'XHTML.ToolbarType';
        XhtmlTitle:
                            result:= 'XHTML.Title';
        XhtmlUseSeparateCss:
                            result:= 'XHTML.UseSeparateCSS';
        JqmTitle:
                            result:= 'JQM.Title';
        JqmCDN:
                            result:= 'JQM.CDN';
        JqmListDataFilter:
                            result:= 'JQM.ListDataFilter';
        JqmUseDividerLines:
                            result:= 'JQM.UseDividerLines';
        JqmBaseTheme:
                            result:= 'JQM.BaseTheme';
        JqmHeaderTheme:
                            result:= 'JQM.HeaderTheme';
        JqmDividerTheme:
                            result:= 'JQM.DividerTheme';
        JqmColumnMode:
                            result:= 'JQM.ColumnMode';
        DocxFontScalingPercentage:
                            result:= 'DOCX.FontScalingPercentage';
        DocxAllPagesOneFile:
                            result:= 'DOCX.AllPagesOneFile';
        DocxCellScalingPercentageWidth:
                            result:= 'DOCX.CellScalingPercentageWidth';
        DocxCellScalingPercentageHeight:
                            result:= 'DOCX.CellScalingPercentageHeight';
        DocxFloatingTableMode:
                            result:= 'DOCX.FloatingTableMode';
        SvgTitle:
                            result:= 'SVG.Title';
        XlsFileFormat:
                            result:= 'XLS.FileFormat';
        PptxFontScalingPercentage:
                            result:= 'PPTX.FontScalingPercentage';
        PptxAnimation:
                            result:= 'PPTX.Animation';
        ExportMailPop3SocketTimeout:
                            result:= 'Export.Mail.POP3.SocketTimeout';
        ExportMailPop3SenderDomain:
                            result:= 'Export.Mail.POP3.SenderDomain';
        ExportMailPop3ServerPort:
                            result:= 'Export.Mail.POP3.ServerPort';
        ExportMailPop3ServerAddress:
                            result:= 'Export.Mail.POP3.ServerAddress';
        ExportMailPop3ServerUser:
                            result:= 'Export.Mail.POP3.ServerUser';
        ExportMailPop3ServerPassword:
                            result:= 'Export.Mail.POP3.ServerPassword';
        ExportMailPop3ProxyAddress:
                            result:= 'Export.Mail.POP3.ProxyAddress';
        ExportMailPop3ProxyPort:
                            result:= 'Export.Mail.POP3.ProxyPort';
        ExportMailPop3ProxyUser:
                            result:= 'Export.Mail.POP3.ProxyUser';
        ExportMailPop3ProxyPassword:
                            result:= 'Export.Mail.POP3.ProxyPassword';
        ExportMailXmapiServerUser:
                            result:= 'Export.Mail.XMAPI.ServerUser';
        ExportMailXmapiServerPassword:
                            result:= 'Export.Mail.XMAPI.ServerPassword';
        ExportMailXmapiSuppressLogonFailure:
                            result:= 'Export.Mail.XMAPI.SuppressLogonFailure';
        ExportMailXmapiDeleteAfterSend:
                            result:= 'Export.Mail.XMAPI.DeleteAfterSend';
        ExportMailSignatureName:
                            result:= 'Export.Mail.SignatureName';
        JsonIndent:
                            result:= 'JSON.Indent';
      else
      result:= '';
      end;

    end;

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

{TDesignerFunctiions, DesignerObjects, DesignerActions}
procedure TDesignerFunctions.Add(TheFunction: TLlDesignerFunction28);
begin
  inherited Add(TheFunction);
end;

procedure TDesignerObjects.Add(TheObject: TLlDesignerObject28);
begin
  inherited Add(TheObject);
end;

procedure TDesignerActions.Add(TheAction: TLDesignerAction28);
begin
  inherited Add(TheAction);
end;

{/TDesignerFunctiions, DesignerObjects, DesignerActions}

{TL28XFunctionen}

constructor TLlDesignerFunction28.Create(AOwner: TComponent);
begin
    inherited create(AOwner);
    FParameter1:=TLlDesignerFunction28Parameter.Create;
    FParameter2:=TLlDesignerFunction28Parameter.Create;
    FParameter3:=TLlDesignerFunction28Parameter.Create;
    FParameter4:=TLlDesignerFunction28Parameter.Create;
    Visible:=true;
    FRefCount:=0;
    FHLib:=0;
end;


destructor TLlDesignerFunction28.Destroy;
begin
    FParameter1.Free;
    FParameter2.Free;
    FParameter3.Free;
    FParameter4.Free;
    inherited destroy;
end;



function TLlDesignerFunction28._AddRef: Integer;
begin
	Result := InterlockedIncrement(FRefCount);
  InterlockedIncrement(l28FireDACInterfaces.g_nObjects);
end;

function TLlDesignerFunction28._Release: Integer;
begin
    InterlockedDecrement(l28FireDACInterfaces.g_nObjects);
	Result := InterlockedDecrement(FRefCount);
    if Result = 0 then
    begin
      if FILlBase[0]<>nil then
          FILlBase[0]:=nil;

    end;

end;

function TLlDesignerFunction28.CheckSyntax(var pbsError: OLEString;
  var pnTypeRes: integer; var pnTypeResLL, pnDecs: cardinal;
  const nArgs: cardinal; VarArg1, VarArg2, VarArg3,
  VarArg4: OleVariant): HResult;
var IsValid: LongBool;
    TmpResultType: TLlDesignerFunction28ParameterType;
    ErrorText: String;
    Decimals: integer;
begin
   IsValid:=true;
   Decimals:=pnDecs;
   TmpResultType:=ResultType;
   if Assigned(FOnCheckFunctionSyntax) then
   	begin
    	 FOnCheckFunctionSyntax(self, IsValid, ErrorText, TmpResultType, Decimals, nArgs,VarArg1, VarArg2, VarArg3,VarArg4);
   	end;
    pnTypeRes:=GetLlFctparaTypeFromParamType(TmpResultType);
    pbsError:=ErrorText;
    pnDecs:=Decimals;
    pnTypeResLL := GetLlFieldTypeFromParamType(TmpResultType);
   if IsValid then
    result:=S_OK
   else
   begin
    pnTypeRes:=-1;
    result:=E_FAIL;
   end;
end;

function TLlDesignerFunction28.Execute(var pVarRes: OleVariant; var pnTypeRes: integer;
  var pnTypeResLL, pnDecs: cardinal; const nArgs: cardinal; VarArg1,
  VarArg2, VarArg3, VarArg4: OleVariant): HResult;
var
    TmpResultType: TLlDesignerFunction28ParameterType;
    Decimals: integer;

begin
    Decimals:=pnDecs;
    TmpResultType:=ResultType;
    if Assigned(FOnEvaluateFunction) then
    FOnEvaluateFunction(self, TmpResultType,pVarRes, Decimals, nArgs, VarArg1, VarArg2, VarArg3, VarArg4);
    pnTypeRes:=GetLlFctparaTypeFromParamType(TmpResultType);
    pnDecs:=Decimals;
    pnTypeResLL := GetLlFieldTypeFromParamType(TmpResultType);
    result:=S_OK;
end;

function TLlDesignerFunction28.GetDescr(var pbsDescr: OLEString): HResult;
var ResultString: String;
    ParameterString: String;
begin
    ResultString := Format('%s', [GetParameterTypeText(ResultType)]);
    if(MaximumParameters >= 1) then
    begin
        if(MinimumParameters < 1) then
            ParameterString:=ParameterString+Format('[%s]', [GetParameterTypeText(Parameter1.ParameterType)])
        else
            ParameterString:=ParameterString+Format('%s', [GetParameterTypeText(Parameter1.ParameterType)])
    end;

    if(MaximumParameters >= 2) then
    begin
        if(MinimumParameters < 2) then
            ParameterString:=ParameterString+Format(', [%s]', [GetParameterTypeText(Parameter2.ParameterType)])
        else
            ParameterString:=ParameterString+Format(', %s', [GetParameterTypeText(Parameter2.ParameterType)])
    end;

    if(MaximumParameters >= 3) then
    begin
        if(MinimumParameters < 3) then
            ParameterString:=ParameterString+Format(', [%s]', [GetParameterTypeText(Parameter3.ParameterType)])
        else
            ParameterString:=ParameterString+Format(', %s', [GetParameterTypeText(Parameter3.ParameterType)])
    end;

    if(MaximumParameters >= 4) then
    begin
        if(MinimumParameters < 4) then
            ParameterString:=ParameterString+Format(', [%s]', [GetParameterTypeText(Parameter4.ParameterType)])
        else
            ParameterString:=ParameterString+Format(', %s', [GetParameterTypeText(Parameter4.ParameterType)])
    end;

    pbsDescr := Format('%s(%s)'+chr(9)+'%s'+chr(9)+'%s', [FunctionName, ParameterString, ResultString, Description]);
    result:=S_OK;
end;

function TLlDesignerFunction28.GetGroupDescr(const bsGroup: OLEString;
  var pbsDescr: OLEString): HResult;
begin
    pbsDescr:=GroupName;
    result:=S_OK;
end;

function TLlDesignerFunction28.GetGroups(var pbsDescr: OLEString): HResult;
begin
    pbsDescr:=GroupName;
    result:=S_OK;
end;

function TLlDesignerFunction28.GetName(var pbsName: OLEString): HResult;
begin
    pbsName:=FunctionName;
    result:=S_OK;

end;

function TLlDesignerFunction28.GetOption(const nOption: integer;
  var pnValue: lParam): HResult;
begin
    pnValue:=0;
    result:=S_OK;
end;

function TLlDesignerFunction28.GetParaCount(var pnMinParas,
  pnMaxParas: integer): HResult;
begin
    pnMinParas:=MinimumParameters;
    pnMaxParas:=MaximumParameters;
    result:=S_OK;
end;

function TLlDesignerFunction28.GetLlFctparaTypeFromParamType(Value: TLlDesignerFunction28ParameterType): integer;
begin
    result:=LL_FCTPARATYPE_STRING;
    if(Value=ptBarcode) then result:=LL_FCTPARATYPE_BARCODE;
    if(Value=ptDrawing) then result:=LL_FCTPARATYPE_DRAWING;
    if(Value=ptBool) then result:=LL_FCTPARATYPE_BOOL;
    if(Value=ptDate) then result:=LL_FCTPARATYPE_DATE;
    if(Value=ptDouble) then result:=LL_FCTPARATYPE_DOUBLE ;
    if(Value=ptAll) then result:=LL_FCTPARATYPE_ALL;
end;

function TLlDesignerFunction28.GetLlFieldTypeFromParamType(Value: TLlDesignerFunction28ParameterType): integer;
begin
    result:=LL_TEXT;
    if(Value=ptBarcode) then result:=LL_BARCODE;
    if(Value=ptDrawing) then result:=LL_DRAWING;
    if(Value=ptBool) then result:=LL_BOOLEAN;
    if(Value=ptDate) then result:=LL_DATE;
    if(Value=ptDouble) then result:=LL_NUMERIC;
end;


function TLlDesignerFunction28.GetParameterTypeText(Value: TLlDesignerFunction28ParameterType):String;
var Text: Array[0..6] of String;

function LoadStringEx(hInstance: HMODULE; uID: Longint): String;
var Buffer: PXChar;
begin
     GetMem(Buffer, 1024);
     LoadString(hInstance, uID, Buffer, 1024);
     Result:=Buffer;
     Result:=Copy(Result,1,Pos(',',Result)-1);
     FreeMem(Buffer,1024);
end;

begin
    Text[0]:=LoadStringEx(FHLib,11506);
    Text[1]:=LoadStringEx(FHLib,11500);
    Text[2]:=LoadStringEx(FHLib,11501);
    Text[3]:=LoadStringEx(FHLib,11503);
    Text[4]:=LoadStringEx(FHLib,11502);
    Text[5]:=LoadStringEx(FHLib,11504);
    Text[6]:=LoadStringEx(FHLib,11505);

    result:=Text[integer(Value)];
end;

function TLlDesignerFunction28.GetParaTypes(var pnTypeRes, pnTypeArg1, pnTypeArg2,
  pnTypeArg3, pnTypeArg4: integer): HResult;
begin
    pnTypeRes:=GetLlFctparaTypeFromParamType(ResultType);
    pnTypeArg1:=GetLlFctparaTypeFromParamType(Parameter1.ParameterType);
    pnTypeArg2:=GetLlFctparaTypeFromParamType(Parameter2.ParameterType);
    pnTypeArg3:=GetLlFctparaTypeFromParamType(Parameter3.ParameterType);
    pnTypeArg4:=GetLlFctparaTypeFromParamType(Parameter4.ParameterType);
    result:=S_OK;
end;

function TLlDesignerFunction28.GetParaValueHint(const nPara: integer; var pbsHint,
  pbsTabbedList: OLEString): HResult;

var ValueList: TStringList;
    index: integer;
begin
    case nPara of
      0: pbsHint:=Parameter1.ParameterDescription;
      1: pbsHint:=Parameter2.ParameterDescription;
      2: pbsHint:=Parameter3.ParameterDescription;
      3: pbsHint:=Parameter4.ParameterDescription;
    end;

    if Assigned(FOnParameterAutocomplete) then
    begin
        pbsTabbedList:='';
        ValueList:=TStringList.Create;
        ValueList.Clear;
        FOnParameterAutocomplete(self, nPara, ValueList);
        for index:=0 to ValueList.Count-1 do
        begin
            pbsTabbedList:=pbsTabbedList+ValueList[index]+chr(9);
        end;
        ValueList.Free;
    end
    else
        pbsTabbedList:='';

    result:=S_OK;
end;

function TLlDesignerFunction28.GetVisibleFlag(var pbVisible: boolean): HResult;
begin
    pbVisible:=visible;
    result:=S_OK;
end;

function TLlDesignerFunction28.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
	Result := S_OK;
	pointer(obj) := NIL;

	if IsEqualGuid(iid,IID_IUnknown) then
        IUnknown(obj):=IUnknown(self);

    if IsEqualGuid(iid,IID_LLX_IFUNCTION) then
        ILlXFunction(obj) := ILlXFunction(self);

    if pointer(obj) = NIL then
        Result := E_NOINTERFACE;

end;

procedure TLlDesignerFunction28.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

function TLlDesignerFunction28.SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult;
begin
  if (hLLJob=0) then
  begin
      result:=S_OK;
      exit;
  end;
  FLlJob:=hLlJob;
  if FILlBase[0]<>nil then
      FILlBase[0]:=nil;
  FILlBase:=pInfo;
  result:=S_OK;
end;

procedure TLlDesignerFunction28.SetMaximumParameters(const Value: integer);
begin
  FMaximumParameters := Value;
end;

procedure TLlDesignerFunction28.SetMinimumParameters(const Value: integer);
begin
  FMinimumParameters := Value;
end;

function TLlDesignerFunction28.SetOption(const nOption: integer; nValue: lParam): HResult;
begin
    case nOption of
        LLXFUNCTION_OPTION_LANGUAGE: FLanguage:=nValue;
        LLXFUNCTION_OPTION_HLIBRARY: FHLib:=nValue;
    end;
    result:=S_OK;
end;

procedure TLlDesignerFunction28.SetParameter1(const Value: TLlDesignerFunction28Parameter);
begin

  FParameter1.ParameterType:=Value.ParameterType;
  FParameter1.ParameterDescription:=Value.ParameterDescription;
end;

procedure TLlDesignerFunction28.SetParameter2(const Value: TLlDesignerFunction28Parameter);
begin
  FParameter2.ParameterType:=Value.ParameterType;
  FParameter2.ParameterDescription:=Value.ParameterDescription;
end;

procedure TLlDesignerFunction28.SetParameter3(const Value: TLlDesignerFunction28Parameter);
begin
  FParameter3.ParameterType:=Value.ParameterType;
  FParameter3.ParameterDescription:=Value.ParameterDescription;

end;

procedure TLlDesignerFunction28.SetParameter4(const Value: TLlDesignerFunction28Parameter);
begin
  FParameter4.ParameterType:=Value.ParameterType;
  FParameter4.ParameterDescription:=Value.ParameterDescription;
end;

procedure TLlDesignerFunction28.SetResultType(
  const Value: TLlDesignerFunction28ParameterType);
begin
  FResultType := Value;
end;

procedure TLlDesignerFunction28.SetFunctionName(const Value: String);
begin
  FFunctionName := Value;
end;

procedure TLlDesignerFunction28.SetGroupName(const Value: String);
begin
  FGroupName := Value;
end;

procedure TLlDesignerFunction28.SetMyParentComponent(const Value: TListLabel28);
begin
  FParent := Value;
  FParent.DesignerFunctions.Add(self);
end;

procedure TLlDesignerFunction28.SetVisible(const Value: boolean);
begin
  FVisible := Value;
end;

procedure TLlDesignerFunction28.SetOnCheckFunctionSyntax(
  const Value: TCheckFunctionSyntaxEvent);
begin
  FOnCheckFunctionSyntax := Value;
end;

procedure TLlDesignerFunction28.SetOnEvaluateFunction(
  const Value: TEvaluateFunctionEvent);
begin
  FOnEvaluateFunction := Value;
end;

procedure TLlDesignerFunction28.SetOnParameterAutoComplete(
  const Value: TParameterAutoCompleteEvent);
begin
  FOnParameterAutoComplete := Value;
end;

{/TLlDesignerFunction28}
{TListLabelDesignerProperty}

constructor TListLabelDesignerProperty.create;
begin
    inherited create;
    FKeyList:=TStringList.Create;
    FValueList:=TStringList.Create;
    FKeyList.Sorted:=false;
    FValueList.Sorted:=false;
end;

constructor TListLabelDesignerProperty.CreateCopy(Base: TListLabelDesignerProperty);
var TempStream: TMemoryStream;
begin
    create;
    TempStream:=TMemoryStream.Create;
    Base.FKeyList.SaveToStream(TempStream);
    TempStream.Seek(0, soFromBeginning);
    FKeyList.LoadFromStream(TempStream);
    TempStream.Clear;
    Base.FValueList.SaveToStream(TempStream);
    TempStream.Seek(0, soFromBeginning);
    FValueList.LoadFromStream(TempStream);
    TempStream.Free;
end;

destructor TListLabelDesignerProperty.Destroy;
begin
    FKeyList.Free;
    FValueList.Free;
    inherited destroy;
end;

procedure TListLabelDesignerProperty.AddProperty(Key, Value: String);
var Pos: integer;
begin
    Pos:=FKeyList.IndexOf(Key);
    if Pos<>-1 then
    begin
      FKeyList.Delete(Pos);
      FValueList.Delete(Pos);
    end;
    FKeyList.Add(Key);
    FValueList.Add(Value);
end;

function TListLabelDesignerProperty.ContainsKey(Key: String): boolean;
begin
    result:=(FKeyList.IndexOf(Key)<>-1);

end;


function TListLabelDesignerProperty.GetValue(Key: String; var Value: String): boolean;
var Pos: integer;
begin
    result:=false;
    Pos:=FKeyList.IndexOf(Key);
    if Pos=-1 then
    begin
        Value:='';
        exit;
    end;
    result:=true;
    Value:=FValueList[Pos];
end;

procedure TListLabelDesignerProperty.LoadFromStream(const Stream: IStream);
var OStream: TOleStream;
    TempList: TStringList;
    index: integer;
    IsKey: Boolean;

begin
    IsKey:=true;
    TempList:=TStringList.Create;
    OStream:=TOleStream.Create(Stream);
    OStream.Seek(0,soFromBeginning);
    TempList.LoadFromStream(OStream);
    OStream.Free;
    FKeyList.Clear;
    FValueList.Clear;

    for Index:=0 to TempList.Count-1 do
    begin
        if TempList[index]='$$$LLDELIMITER§§§' then
            IsKey:=false
        else
            if IsKey=true then
                FKeyList.Add(TempList[index])
            else
                FValueList.Add(TempList[index]);
    end;

    TempList.Free;


end;

procedure TListLabelDesignerProperty.RemoveProperty(Key: String);
var Pos: integer;
begin
    Pos:=FKeyList.IndexOf(Key);
    if Pos<>-1 then
    begin
        FKeyList.Delete(Pos);
        FValueList.Delete(Pos);
    end;
end;

procedure TListLabelDesignerProperty.SaveToStream(const Stream: IStream);
var OStream: TOleStream;
    TempList: TStringList;
    index: integer;

begin
    TempList:=TStringList.Create;
    for Index:=0 to FKeyList.Count-1 do
    begin
        TempList.Add(FKeyList[index]);
    end;
    TempList.Add('$$$LLDELIMITER§§§');
    for Index:=0 to FValueList.Count-1 do
    begin
        TempList.Add(FValueList[index]);
    end;
    OStream:=TOleStream.Create(Stream);
    TempList.SaveToStream(OStream);
    OStream.Free;
    TempList.Free;
end;

{/TListLabelDesignerProperty}
{TLlDesignerObject28}

function TLlDesignerObject28._AddRef: Integer;
begin
  	Result := InterlockedIncrement(FRefCount);
    InterlockedIncrement(l28FireDACInterfaces.g_nObjects);
end;

function TLlDesignerObject28._Release: Integer;
begin
    InterlockedDecrement(l28FireDACInterfaces.g_nObjects);
	Result := InterlockedDecrement(FRefCount);
    if Result = 0 then
    begin
      if FILlBase[0]<>nil then
          FILlBase[0]:=nil;
      if FILlXObjectNtfySink[0]<>nil then
          FILlXObjectNtfySink[0]:=nil;
      if FIsCopy then
        self.Destroy;
    end;

end;



function TLlDesignerObject28.AllowPageBreak: HResult;
begin
    if SupportsMultipage then
        result:=S_OK
    else
        result:=S_FALSE;
end;

function TLlDesignerObject28.CalcDistanceToFrame(const hDC: HDC; ptMouse: TPoint;
  var pnDistance: cardinal): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.CancelEditPart: HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.CanCreateObjectFromType(const nLLType: integer;
  const sVarName: OLEString; var prcCreate: TRect): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.CanEditPart(ptMouse: TPoint;
  var phMenu: hMenu): HResult;

var UniqueID: cardinal;

function CreateMenuCopy(Source: TMenuItem; Dest: HMENU; var CommandHandlerList:TList):HMENU;
var hDestTemp: HMENU;
    Buffer:PXChar;
    ItemIndex: integer;
    MII:MENUITEMINFO;
    Handler: TNotifyEvent;
begin
    GetMem(Buffer,256);
    hDestTemp:= Dest;
    if Dest=0 then hDestTemp:=CreatePopupMenu;

    for ItemIndex:=0 to GetMenuItemCount(Source.Handle)-1 do
    begin
        fillchar(MII, sizeof(MII)-4,0);
		MII.cbSize:=sizeof(MII)-4;
		MII.fMask:=MIIM_DATA or MIIM_ID or MIIM_TYPE or MIIM_SUBMENU or MIIM_STATE or MIIM_CHECKMARKS;
		MII.dwTypeData:=Buffer;
		MII.cch:=256;
		GetMenuItemInfo(Source.Handle,ItemIndex,true,MII);
        MII.dwItemData:=0;
		if (MII.hSubMenu<>0) then
        begin
            MII.hSubMenu := CreateMenuCopy(Source.Items[ItemIndex],0, CommandHandlerList);
        end;

		if (MII.fType and MFT_SEPARATOR<>0) then
			AppendMenu(hDestTemp,MF_SEPARATOR,0,nil)
		  else
          begin
            MII.wID:=UniqueID;
            Handler:=TNotifyEvent(Source.Items[ItemIndex].OnClick);
            if Assigned(Handler) then
             CommandHandlerList.Add(Addr(Handler))
            else
             CommandHandlerList.Add(nil);
            inc(UniqueID);
			InsertMenuItem(hDestTemp,ItemIndex,TRUE,MII);
          end;
    end;
	result:=hDestTemp;
    FreeMem(Buffer);
end;

begin
    UniqueID:=10000;
    FCommandHandlerList.Clear;
    if Assigned(PopupMenu) then
    	phMenu:=CreateMenuCopy(PopupMenu.Items,0,FCommandHandlerList);
    result:=S_OK;
end;

function TLlDesignerObject28.ClearEditPartInfo: HResult;
begin
    result:=S_OK;
end;

function TLlDesignerObject28.Clone(var pIObject): HResult;
var pObject: TLlDesignerObject28;
begin
    try
      pObject := TLlDesignerObject28.CreateCopy(owner,self);
      if FAILED(pObject.QueryInterface(IID_LLX_IOBJECT,pIObject)) then
          begin
          pObject.Free;
          Result := E_FAIL;
          exit;
          end;
     result:=S_OK;
    except
     Result := E_FAIL;
    end;
end;

constructor TLlDesignerObject28.Create(AOwner: TComponent);
begin
    FRefCount:=0;
    FIcon:=TIcon.Create;
    FLargeRibbonImage:=TBitmap.Create;
    FSmallRibbonImage:=TBitmap.Create;
    FIsCopy:=false;
    FFontHandle:=0;
    FFontColor:=clBlack;
    FFontSize:= 12;
    FPrintState:=llxpsWaiting;
    FSupportsMultipage:=false;
    FCommandHandlerList:=TList.Create;
    Properties:=TListLabelDesignerProperty.create;
    inherited create(AOwner);
end;

constructor TLlDesignerObject28.CreateCopy(AOwner:TComponent; Base: TLlDesignerObject28);
var index: integer;
begin
     inherited create(AOwner);
     FRefCount:=0;
     FIsCopy:=True;
     FLLJob:=Base.FLLJob;
     FOnEdit:=Base.FOnEdit;
     FOnDraw:=Base.FOnDraw;
     FOnClick:=Base.FOnClick;
     FOnGetVariableSizeInfo:=Base.FOnGetVariableSizeInfo;
     FPopupMenu:=Base.FPopupMenu;
     FSupportsMultipage:=Base.FSupportsMultipage;
     FCommandHandlerList:=TList.Create;
     FHint:=Base.FHint;
     for index:=0 to Base.FCommandHandlerList.Count-1 do
     begin
         FCommandHandlerList.Add(Base.FCommandHandlerList[index]);
     end;

     FOnInitialCreation:=Base.FOnInitialCreation;
     ParentComponent:=Base.ParentComponent;
     Description:=Base.Description;
     ObjectName:=Base.ObjectName;
     Icon:=Base.Icon;
     LargeRibbonImage:=Base.LargeRibbonImage;
     SmallRibbonImage:=Base.SmallRibbonImage;
     TooltipDescription:=Base.TooltipDescription;
     FFontHandle:=Base.FFontHandle;
     FFontColor:=Base.FFontColor;
     FFontSize:=Base.FFontSize;
     if Base.FILlBase[0]<> nil then
     begin
        FILlBase[0]:=Base.FILlBase[0];
     end
     else
        FILlBase[0]:=nil;

     if Base.FILlXObjectNtfySink[0]<>nil then
     begin
        FILlXObjectNtfySink[0]:=Base.FILlXObjectNtfySink[0];
     end
     else
        FILlXObjectNtfySink[0]:=nil;

     Properties:=TListLabelDesignerProperty.CreateCopy(Base.Properties);
end;

destructor TLlDesignerObject28.Destroy;
begin
    if Assigned(fParent) then
     try
         fParent.DesignerObjects.Remove(self);
     except
     end;
    FIcon.Free;
    FLargeRibbonImage.Free;
    FSmallRibbonImage.Free;
    FCommandHandlerList.Free;
    Properties.Free;
    inherited destroy;
end;

function TLlDesignerObject28.Edit(const hWnd: cmbtHWND; ptMouse: TPoint): HResult;
var ChangedFlag: boolean;
begin
    ChangedFlag:=false;
    if Assigned(FOnEdit) then
    begin
        FOnEdit(self, hWnd, ChangedFlag);
        if ChangedFlag then
            FILlXObjectNtfySink[0].UpdateView(LLX_OBJECTNOTIFYSINK_UPDATEVIEWFLAG_OBJECTCHANGED, true)
        else
            FILlXObjectNtfySink[0].UpdateView(0,true);
    end;
    result:=S_OK;
end;

function TLlDesignerObject28.EditPart(const hWnd: cmbtHWND; ptMouse: TPoint;
  const nMenuID: cardinal): HResult;

var
    Handler: TNotifyEvent;
    TheItem: TMenuItem;

function FindMenuItem(Menu: TMenuItem; HandlerProc: Pointer): TMenuItem;
var ItemIndex: integer;
begin
    result:=nil;
    for ItemIndex:=0 to GetMenuItemCount(Menu.Handle)-1 do
    begin
          if Menu.Items[ItemIndex].Count<>0 then
            result:=FindMenuItem(Menu.Items[ItemIndex], HandlerProc)
          else
          begin
            Handler:=TNotifyEvent(Menu.Items[ItemIndex].OnClick);
            if Addr(Handler) = HandlerProc then
            begin
              result:=Menu.Items[ItemIndex];
              exit;
            end;
          end;
    end;
end;
begin
    TheItem:=FindMenuItem(PopupMenu.Items, FCommandHandlerList[nMenuID-10000]);
    if Assigned(TheItem) then
        if Assigned(TheItem.OnClick) then
        begin
            TheItem.OnClick(self);
            FILlXObjectNtfySink[0].UpdateView(LLX_OBJECTNOTIFYSINK_UPDATEVIEWFLAG_OBJECTCHANGED, true);
        end;
    result:=S_OK;
end;

function TLlDesignerObject28.FirstCreation(const hWndParent: cmbtHWND): HResult;
begin
    if Assigned(FOnInitialCreation) then
        FOnInitialCreation(self, hWndParent);
    result:=E_NOTIMPL; // force edit dialog anyway
end;

function TLlDesignerObject28.ForceResetPrintState: HResult;
begin
    FPrintState:=llxpsWaiting;
    if Assigned(FOnResetPrintState) then
        FOnResetPrintState(self);
    result:=S_OK;
end;

function TLlDesignerObject28.GetDescr(var pbsDescr: OLEString): HResult;
begin
    pbsDescr:=Description;
    result:=S_OK;
end;

function TLlDesignerObject28.GetErrorcode: longint;
begin
    result:=0;
end;

function TLlDesignerObject28.GetIcon(var phIcon: HIcon): HResult;
begin
    if Assigned(Icon) then
        phIcon:=Icon.Handle
    else
        phIcon:=0;
    result:=S_OK;
end;

function TLlDesignerObject28.GetMinDimensionsSCM(const bForNew: boolean;
  var ptMinSize: Size): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.GetName(var pbsName: OLEString): HResult;
begin
    pbsName:=ObjectName;
    result:=S_OK;
end;

function TLlDesignerObject28.GetOption(const nOption: integer;
  var pnValue: lParam): HResult;
begin
    case nOption of
        LLXOBJECT_OPTION_USABLE_AS_OBJECT: pnValue:=1;
        LLXOBJECT_OPTION_USABLE_IN_CELL: pnValue:=1;
        LLXOBJECT_OPTION_USABLE_IN_STATIC_CELL: pnValue:=1;
        LLXOBJECT_OPTION_SUPPORTS_VARSIZE:
            begin
                if Assigned(FOnGetVariableSizeInfo) then
                    pnValue:=1
                else
                    pnValue:=0;
            end;
        LLXOBJECT_OPTION_BITMAP_SMALL:
          begin
            pnValue:=SmallRibbonImage.Handle;
          end;
        LLXOBJECT_OPTION_BITMAP_LARGE:
          begin
            pnValue:=LargeRibbonImage.Handle;
          end
    else
        pnValue:=0;
    end;
    result:=S_OK;

end;

function TLlDesignerObject28.GetOptionString(const sOption: OLEString;
  var psValue: OLEString): HResult;
begin
    psValue := '';
    if (sOption = 'LL.MouseMove.HelpString') then
        psValue:=Hint;
    if (sOption = 'TooltipDescr') then
        psValue:=TooltipDescription;
    result:=S_OK;
end;

function TLlDesignerObject28.GetParameters(pIStream: IStream): HResult;
begin
    Properties.SaveToStream(pIStream);
    result:=S_OK;
end;

function TLlDesignerObject28.GetTrueRec(var prc: TRect): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.InObject(const hDC: HDC; ptMouse: TPoint): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.IsProjectSupported(const nProjType: integer;
  var pbSupported: boolean): HResult;
begin
    pbSupported:=true;
    result:=S_OK;
end;

function TLlDesignerObject28.IsSetFontSupported(var pbSupported: boolean): HResult;
begin
    pbSupported:=true;
    result:=S_OK;
end;

function TLlDesignerObject28.OnDeclareChartRow: HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.OnDragDrop(pDataObj: IDataObject;
  const grfKeyState: Longword; p: TPoint; var pdwEffect: Longword;
  const bQuery: boolean): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.OnMouseLButton(const hDC: HDC; ptMouse: TPoint;
  const hWnd: cmbtHWND): HResult;
var
	Canvas: TCanvas;
begin
	Canvas:=nil;
    if Assigned(FOnClick) then
    begin
      try
        SaveDC(hDC);
        Canvas:=TCanvas.Create;
        Canvas.Handle:=hDC;
        FOnClick(self, Canvas, ptMouse, hWnd);
      finally;
	    if Assigned(Canvas) then
        Canvas.Free;
        RestoreDC(hDC, -1);
      end;
    end;
    result:=S_OK;
end;

function TLlDesignerObject28.OnMouseMove(const hDC: HDC; ptMouse: TPoint;
  var phCrs: hCursor): HResult;
begin
    result:=S_OK;
end;

function TLlDesignerObject28.OnObject(const hDC: HDC; ptMouse: TPoint): HResult;
begin
    result:=E_NOTIMPL;
end;

function TLlDesignerObject28.PrintFinished: HResult;
begin
    if FPrintState=llxpsFinished then
        result:=S_OK
    else
        result:=S_FALSE;
end;

function TLlDesignerObject28.PrintPastFinished: HResult;
begin
    if FPrintState=llxpsPastFinished then
        result:=S_OK
    else
        result:=S_FALSE;

end;

function TLlDesignerObject28.PrintUnfinished: HResult;
begin
    if FPrintState=llxpsUnfinished then
        result:=S_OK
    else
        result:=S_FALSE;

end;

function TLlDesignerObject28.PrintWaiting: HResult;
begin
    if FPrintState=llxpsWaiting then
        result:=S_OK
    else
        result:=S_FALSE;
end;

function TLlDesignerObject28.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
	Result := S_OK;
	pointer(obj) := NIL;

	if IsEqualGuid(iid,IID_IUnknown) then
        IUnknown(obj):=IUnknown(self);

    if IsEqualGuid(iid,IID_LLX_IObject) then
        ILlXObject(obj) := ILlXObject(self);

    if pointer(obj) = NIL then
        Result := E_NOINTERFACE;

end;

function TLlDesignerObject28.ResetPrintState: HResult;
begin
    if FSupportsMultipage then
    begin
        FPrintState:=llxpsWaiting;
        if Assigned(FOnResetPrintState) then
            FOnResetPrintState(self);
    end;
    result:=S_OK;
end;

procedure TLlDesignerObject28.SetDescription(const Value: String);
begin
  FDescription := Value;
end;

function TLlDesignerObject28.SetFont(var pLF: LOGFONT; const nSize: cardinal;
  const rgbColor: COLORREF): HResult;
begin
    if (FFontHandle<>0) then DeleteObject(FFontHandle);
    FFontHandle:=CreateFontIndirect(pLF);
    FFontColor:=rgbColor;
    FFontSize:=nSize;
    result:=S_OK;
end;

procedure TLlDesignerObject28.SetIcon(const Value: TIcon);
begin
  if not Assigned(FIcon) then FIcon:=TIcon.Create;
    FIcon.Assign(Value);
end;

procedure TLlDesignerObject28.SetSmallRibbonImage(const Value: TBitmap);
begin
  if not Assigned(FSmallRibbonImage) then FSmallRibbonImage:=TBitmap.Create;
    FSmallRibbonImage.Assign(Value);
end;

procedure TLlDesignerObject28.SetLargeRibbonImage(const Value: TBitmap);
begin
  if not Assigned(FLargeRibbonImage) then FLargeRibbonImage:=TBitmap.Create;
    FLargeRibbonImage.Assign(Value);
end;


function TLlDesignerObject28.SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult;
begin
    if (hLLJob=0) then
    begin
        result:=S_OK;
        exit;
    end;
    FLlJob:=hLlJob;
    if FILlBase[0]<>nil then
        FILlBase[0]:=nil;
    FILlBase:=pInfo;

    result:=S_OK;

end;

function TLlDesignerObject28.SetNtfySink(pNtfySink: pILlXObjectNtfySink): HResult;
begin
    if FILlXObjectNtfySink[0] <> nil then
        FILlXObjectNtfySink[0]:=nil;

    FILlXObjectNtfySink[0]:=pNtfySink[0];
    result:=S_OK;
end;

procedure TLlDesignerObject28.SetObjectName(const Value: String);
begin
  FObjectName := Value;
end;

procedure TLlDesignerObject28.SetTooltipDescription(const Value: String);
begin
  FTooltipDescription := Value;
end;

procedure TLlDesignerObject28.SetOnDraw(const Value: TDrawObjectEvent);
begin
  FOnDraw := Value;
end;

procedure TLlDesignerObject28.SetOnEdit(const Value: TEditObjectEvent);
begin
  FOnEdit := Value;
end;

procedure TLlDesignerObject28.SetOnInitialCreation(const Value: TCreateObjectEvent);
begin
  FOnInitialCreation := Value;
end;

function TLlDesignerObject28.SetOption(const nOption: integer; nValue: lParam): HResult;
begin
    result:=S_OK;
end;

function TLlDesignerObject28.SetOptionString(const sOption: OLEString;
  sValue: OLEString): HResult;
begin
    result:=S_OK;
end;

function TLlDesignerObject28.SetParameters(pIStream: IStream): HResult;
begin
    Properties.LoadFromStream(pIStream);
    result:=S_OK;
end;

function TLlDesignerObject28.Show(const hDC: HDC; var prcPaint: TRect;
  const hExportProfJob: HPROFJOB; const hExportProfList: HPROFLIST;
  const nExportVerbosity, nDestination: integer;
  const bSelected: boolean): HResult;

var Canvas: TCanvas;
    Rect: TRect;
    IsFinished: boolean;
begin
    if SupportsMultipage and (PrintFinished=S_OK) then
        FPrintState:=llxpsPastFinished;
    if FPrintState<llxpsFinished then
    begin
      if Assigned(FOnDraw) then
      begin
		    SaveDC(hDC);
        Canvas:=TCanvas.create;
        with Canvas do
        begin
          Handle:=hDC;
          with Font do
          begin
            Handle:=FFontHandle;
            Color:=FFontColor;
            Size:=FFontSize;
          end;
        end;
        Rect:=prcPaint;
        IsFinished:=false;
        FOnDraw(self,Canvas,Rect,nDestination<>LLXOBJECT_DESTINATION_PRINTER,IsFinished);
        if IsFinished then
            FPrintState:=llxpsFinished
        else
            FPrintState:=llxpsUnfinished;
            Canvas.free;
		    RestoreDC(hDC, -1);
      end;
    end
    else
    begin
        prcPaint.Bottom:=prcPaint.Top;
    end;
    if not SupportsMultipage then
        ResetPrintState;
    result:=S_OK;
end;

procedure TLlDesignerObject28.SetMyParentComponent(const Value: TListLabel28);
begin
  fParent := Value;
  fParent.DesignerObjects.Add(self);
end;

procedure TLlDesignerObject28.SetOnClick(const Value: TClickEvent);
begin
  FOnClick := Value;
end;

procedure TLlDesignerObject28.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then
  begin
    Value.FreeNotification(Self);
  end;
end;

procedure TLlDesignerObject28.SetHint(const Value: String);
begin
  FHint := Value;
end;

procedure TLlDesignerObject28.SetOnGetVariableSizeInfo(
  const Value: TGetVariableSizeInfoEvent);
begin
  FOnGetVariableSizeInfo := Value;
end;

procedure TLlDesignerObject28.SetSupportsMultipage(const Value: boolean);
begin
  FSupportsMultipage := Value;
end;


procedure TLlDesignerObject28.SetOnResetPrintState(
  const Value: TResetPrintStateEvent);
begin
  FOnResetPrintState := Value;
end;

function TLlDesignerObject28.GetVarSizeInfo(const hDC: HDC;
  const prcSpaceAvailable: cmbTLl28x.pTRect; var pnMinHeight,
  pnIdealHeight: integer): HRESULT;
begin
    if (prcSpaceAvailable = nil) and (FPrintState<llxpsFinished) then
    begin
        pnIdealHeight:=1000;  // just a dumy value indicating there's data to print
        result:=S_OK;
        exit;
    end
    else
    if Assigned(FOnGetVariableSizeInfo) then
    begin
        FOnGetVariableSizeInfo(self, hDC, (prcSpaceAvailable^.Right-prcSpaceAvailable^.Left), pnMinHeight, pnIdealHeight);
        result:=S_OK;
    end
    else
        result:=E_NOTIMPL;
end;

{/TLlDesignerObject28}

{ TLDesignerAction28 }

procedure TLDesignerAction28.AddAction;
var
  flags: integer;
  shiftState: TShiftState;
  key: Word;
begin

  if FInsertionType = itAppend then
    flags := $00000000
  else
    flags := $00000001;

  if FAddToToolbar then
    flags := flags or $20000000; // LLDESADDACTIONFLAG_ADD_TO_TOOLBAR

  ShortCutToKey(FShortCut, key, shiftState);
  if (ssCtrl in shiftState) then
    flags := flags or $00010000; // LLDESADDACTION_ACCEL_CONTROL

  if (ssShift in shiftState) then
    flags := flags or $00020000;

  if (ssAlt in shiftState) then
    flags := flags or $00040000;

  flags := flags or $00080000; // LLDESADDACTION_ACCEL_VIRTKEY

  flags := flags or  (FShortCut and $fff);

  FParent.Core.LlDesignerAddAction(FMenuId, flags, FMenuText, FMenuHierachy, FTooltipText, FIconId, nil);
end;

constructor TLDesignerAction28.Create(AOwner: TComponent);
begin
    inherited create(AOwner);
end;

destructor TLDesignerAction28.Destroy;
begin
  inherited destroy;
end;

procedure TLDesignerAction28.SetIconId(const Value: integer);
begin
  FIconId := Value;
end;

procedure TLDesignerAction28.SetInsertionType(const Value: TLDesignerAction28InsertionType);
begin
  FInsertionType := Value;
end;

procedure TLDesignerAction28.SetMenuHierachy(const Value: string);
begin
  FMenuHierachy := Value;
end;

procedure TLDesignerAction28.SetMenuId(const Value: integer);
begin
  FMenuId := Value;
end;

procedure TLDesignerAction28.SetMenuText(const Value: string);
begin
  FMenuText := Value;
end;

procedure TLDesignerAction28.SetMyParentComponent(const Value: TListLabel28);
begin
  FParent := Value;
  FParent.DesignerActions.Add(self);
end;

procedure TLDesignerAction28.SetOnExecuteAction(const Value: TExecuteActionEvent);
begin
  FOnExecuteAction := Value;
end;

procedure TLDesignerAction28.SetOnGetActionState(const Value: TGetActionStateEvent);
begin
  FOnGetActionState := Value;
end;

procedure TLDesignerAction28.SetShortCut(const Value: TShortCut);
begin
  FShortCut := Value;
end;

procedure TLDesignerAction28.SetTooltipText(const Value: string);
begin
  FTooltipText := Value;
end;

procedure TLDesignerAction28.SetToToolbar(const Value: boolean);
begin
  FAddToToolbar := Value;
end;

{\ TLDesignerAction28 }

Function DateToJulian(ADate: TDateTime): TJulianDate;
begin
  if ADate = 0 then
    DateToJulian := JulZero
  else
    DateToJulian := Trunc(ADate) + JulZero;
end;

Function JulianToDate(AJulDate: TJulianDate): TDateTime;
begin
  JulianToDate := AJulDate - JulZero;
end;

procedure StrPCopyExt(var Dest: ptChar; Source: TString; MinSize: integer);
  var
    ActSize: integer;
  begin
    if MinSize > SizeOf(ptChar) * (length(Source) + 1) then ActSize := MinSize
    else
      ActSize := SizeOf(ptChar) * (length(Source) + 1);
    if (Dest <> nil) then
      FreeMem(Dest);
    GetMem(Dest, ActSize);
    {$ifdef UNICODE}
    Move(ptCHAR(Source)^, Dest^, SizeOf(ptChar) * (length(Source)));
    Dest[length(Source)] := #0;
    {$else}
    StrPCopy(Dest, Source);
    {$endif}
  end;

end.


