{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : ListLabel25.pas
 Module : List & Label 25
 Descr. : Implementation file for the List & Label 25 VCL-Component
 Version: 25.000
==================================================================================
}

unit ListLabel25;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Messages, Dialogs, DB, LLReport_Types, cmbtll25x,l25CommonInterfaces,
     ComCtrls, Vcl.Imaging.jpeg, System.Contnrs, System.SyncObjs, LLDataProvider, LLDataSetDataProvider, System.Generics.Collections, System.StrUtils;

type

    TString = UnicodeString;
    PXChar = PWideChar;
    XChar  = WideChar;
    TObjectType = (otMarker, otText, otRectangle, otLine, otBarcode, otTable, otTemplate, otEllipse, otGroup, otRTF, otExtensionObject);

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
       ObjectType: TObjectType; IsPreDraw: boolean; Canvas: TCanvas; Rect: TRect; var EventResult: integer) of object;
    TPageEvent = procedure(Sender: TObject; IsDesignerPreview: boolean;
      IsPreDraw: boolean; var Canvas: TCanvas; Rect: TRect) of object;
    TAutoNotifyProgress = procedure(Sender: TObject; Progress: integer) of object;
    LlCore = class;


  // ==============================================================================================
  // TListLabel25
  // ==============================================================================================

	[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TListLabel25 = class(TComponent, ILlDomParent)
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
    procedure SetNoParameterCheck(const Value: Boolean);
    procedure SetPreviewZoom(const Value: Integer);
    procedure SetProjectPassword(const Value: String);
    procedure SetTableColoring(const Value: TLlTableColoring);
    procedure SetUnits(const Value: TLlUnits);
    procedure SetVarCaseSensitive(const Value: Boolean);
    procedure SetNoPrintJobSupervision(const Value: Boolean);

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
                                     ProjectFile: String;
                                     OriginalProjectFile: String;
                                     MaxPages   : Integer;
                                     ExportFormat: String);

    Procedure AbortPrinting();

    Property ShowErrors: Boolean read FShowErrors write SetShowErrors default true;
    Property NoPrintJobSupervision: Boolean read FNoPrintJobSupervision write SetNoPrintJobSupervision Default false;
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
    Property Debug: TLlDebugFlags read FDebug write SetDebug;
    Property TableColoring: TLlTableColoring read FTableColoring write SetTableColoring Default TLlTableColoring.tcListLabel;
    Property Language: TLlLanguage read FLanguage write SetLanguage Default TLlLanguage.lDefault;
    Property DataController: TLLDataController read FDataController Write FDataController;
    Property Core: LlCore read GetCore;

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
    fParentObject: TListLabel25;
   public
   Constructor Create(ParentObject: TListLabel25);
   function LlGetOptionString(OptionIndex: integer; var Value: TString): integer;
   function LlDefineVariableExt(FieldName: String; Contents: String; FieldType: integer): integer;
   function LlDefineVariableExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): integer;
   function LlDefineFieldExt(FieldName: String; Contents: String; FieldType: integer): integer;
   function LlDefineFieldExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): integer;
   function LlSetOption(OptionIndex: integer; Value: lParam): integer;
   function LlGetOption(OptionIndex: integer): integer;
   function LlSetOptionString(OptionIndex: integer; Value: TString): integer;

  end;

function NtfyCallback(nMsg: Integer; lParam: LongInt; lUserParam: LongInt): LongInt; export; stdcall;

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

function NtfyCallback(nMsg: Integer; lParam: LongInt; lUserParam: LongInt): LongInt;
var
  lResult: NativeInt;
begin
  lResult := 0;
  case nMsg of
    LL_NTFY_DESIGNERPRINTJOB:
      Begin
        lResult :=TListLabel25(lUserParam).OnDesignerPrintPreviewCallback(pSCLLDESIGNERPRINTJOB(lParam));
      End;

    LL_NTFY_VIEWERDRILLDOWN:
      begin
        lResult:= TListLabel25(lUserParam).OnDrillDownCallBack(PSCLLDRILLDOWNJOBINFO(lParam));
      end;
    LL_CMND_SAVEFILENAME:
      begin
          (TListLabel25(lUserParam)).SaveFileNameCallback(PTChar(lparam));
      end;
    87:// LL_NTFY_PROGRESS
      begin
          (TListLabel25(lUserParam)).NotifyProgressCallback(Integer(lparam));
      end;
    LL_INFO_PRINTJOBSUPERVISION:
      begin
          (TListLabel25(lUserParam)).PrintJobInfoCallback(PSCLLPRINTJOBINFO(lParam));
      end;
    LL_NTFY_PROJECTLOADED:
      begin
		if (integer(lParam)=0) then
          (TListLabel25(lUserParam)).ProjectLoadedEvent;
      end;
    LL_CMND_PROJECT:
      begin
          (TListLabel25(lUserParam)).ProjectCallback(pSCLLPROJECT(lParam));
      end;
    LL_CMND_OBJECT:
      begin
          (TListLabel25(lUserParam)).ObjectCallback(pSCLLOBJECT(lParam), lResult);
      end;
    LL_CMND_PAGE:
      begin
          (TListLabel25(lUserParam)).PageCallback(pSCLLPAGE(lParam));
      end;
    LL_NTFY_QUEST_DRILLDOWNDENIED :
      begin
        if TListLabel25(lUserParam).FDrilldownActive then
          lResult:= 1
        else
          lResult:= 0;
      end;
  end;
  Result := lResult;
end;

// =====================================================================
// TListLabel25
// =====================================================================
Constructor TListLabel25.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  LL25xLoad();
  lpfnNtfyProc := nil;
  FDataController := TLLDataController.Create(self);

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
  FTableColoring := TLlTableColoring.tcListLabel;
  FLanguage := TLlLanguage.lDefault;
  FBaseJob:=-1;
  FDomDataProvider:=nil;
  FCore:=nil;
  JobInit(FBaseJob);
  GetCore();

end;

destructor TListLabel25.Destroy;
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
  LL25xUnload();
  FCore.Free;
  inherited Destroy;
end;

Function TListLabel25.OnDesignerPrintPreviewCallback(param: PSCLLDESIGNERPRINTJOB): LongInt;
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

Function  TListLabel25.OnDrillDownCallback(param: PSCLLDRILLDOWNJOBINFO): LongInt;
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

procedure TListLabel25.NotifyProgressCallback(lParam: Integer);
begin
  if(Assigned(FOnAutoNotifyProgress)) then
    FOnAutoNotifyProgress(Self, lParam);
end;
procedure TListLabel25.SaveFileNameCallback(pszFileName: PTChar);
begin
  if Assigned(FOnSaveFileName) then
    FOnSaveFileName(Self, pszFileName);
end;

procedure TListLabel25.PrintJobInfoCallback(pSCI:PSCLLPRINTJOBINFO);
begin
    if Assigned (FOnPrintJobInfo) then
    begin
        FOnPrintJobInfo(self, pSCI^._hLlJob, pSCI^._szDevice, pSCI^._dwJobID, pSCI^._dwState);
    end;
end;

procedure TListLabel25.ProjectLoadedEvent;
begin
  if Assigned(FOnProjectLoaded) then
    FOnProjectLoaded(Self);
end;


procedure TListLabel25.ProjectCallback(pSCP: PSCLLPROJECT);
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

procedure TListLabel25.ObjectCallback(pSCO: PSCLLOBJECT; var lResult: NativeInt);
var
  Canvas: TCanvas;
  Rect: TRect;
  iResult: integer;
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

procedure TListLabel25.PageCallback(pSCP: PSCLLPAGE);
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

procedure TListLabel25.SetVarCaseSensitive(const Value: Boolean);
begin
  FVarCaseSensitive := Value;
end;

procedure TListLabel25.SetLanguage(const Value: TLlLanguage);
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

function TListLabel25.LlPrintGetPrinterInfo(var PrinterName, PrinterPort: TString): Integer;
var
  BufPrinter, BufPort: PTChar;

begin
  GetMem(BufPrinter, 128 * sizeof(tChar));
  GetMem(BufPort, 40 * sizeof(tChar));
  BufPrinter^ := #0;
  BufPort^ := #0;
  Result := cmbtll25x.LlPrintGetPrinterInfo(CurrentJobHandle, BufPrinter, 128 - 1, BufPort, 40 - 1);
  PrinterName := TString(BufPrinter);
  PrinterPort := TString(BufPort);
  FreeMem(BufPrinter);
  FreeMem(BufPort);
end;

function TListLabel25.LlSelectFileDlgTitle(ParentHandle: cmbtHWND; Title: TString; ProjectType: Integer; var ProjectName: TString): Integer;
var
  pszProjectName: PTChar;

  begin
  pszProjectName := nil;
  StrPCopyExt(pszProjectName, ProjectName, 1024);
  Result := cmbtll25x.LlSelectFileDlgTitleEx(CurrentJobHandle, ParentHandle, PTChar(Title), ProjectType, pszProjectName, 1024 - 1, nil);
  ProjectName := TString(pszProjectName);
  FreeMem(pszProjectName);
end;



function TListLabel25.LlGetUsedIdentifiers(ProjectName: string; IdentifierTypes: Cardinal): TStringList;
var
  pszIdentifiers: PTChar;
  size: integer;


begin
  result:=nil;
  size:=cmbtll25x.LlGetUsedIdentifiersEx(CurrentJobHandle, PChar(ProjectName), IdentifierTypes, nil, 0);
  if (size<=0) then exit;

  GetMem(pszIdentifiers, (size+1)*2);
  cmbtll25x.LlGetUsedIdentifiersEx(CurrentJobHandle, PChar(ProjectName), IdentifierTypes, pszIdentifiers, size);
  result:=TStringList.Create;
  result.OwnsObjects:=true;
  result.Delimiter:=';';
  result.StrictDelimiter:=true;
  result.DelimitedText:=pszIdentifiers;
  FreeMem(pszIdentifiers);
end;


procedure TListLabel25.SetAddVarsToFields(const Value: Boolean);
begin

  FAddVarsToFields := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_ADDVARSTOFIELDS, Integer(FAddVarsToFields)));

end;

procedure TListLabel25.SetShowErrors(const Value: Boolean);
begin

  FShowErrors := Value;

end;

procedure TListLabel25.SetUnits(const Value: TLlUnits);
begin

  FUnits := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_UNITS, Integer(TEnumTranslator.TranslateUnits(FUnits))));

end;

procedure TListLabel25.SetNoPrintJobSupervision(const Value: Boolean);
begin

  FNoPrintJobSupervision := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_NOPRINTJOBSUPERVISION, Integer(Value)));

end;

procedure TListLabel25.SetLicensingInfo(const Value: String);
begin
  FLicensingInfo := Value;
end;

procedure TListLabel25.SetAutoBoxType(const Value: TLlAutoBoxType);
begin

  FAutoBoxType := Value;

end;

procedure TListLabel25.SetAutoDesignerPreview(const Value: Boolean);
begin

  FAutoDesignerPreview := Value;

end;

procedure TListLabel25.SetAutoDestination(const Value: TLlPrintMode);
begin

  FAutoDestination := Value;

end;

procedure TListLabel25.SetAutoDialogTitle(const Value: String);
begin

  FAutoDialogTitle := Value;

end;

procedure TListLabel25.SetAutoFileAlsoNew(const Value: Boolean);
begin

  FAutoFileAlsoNew := Value;

end;

procedure TListLabel25.SetAutoProjectFile(const Value: String);
begin

  FAutoProjectFile := Value;

end;

procedure TListLabel25.SetAutoProjectType(const Value: TLlProject);
begin

  FAutoProjectType := Value;

end;

procedure TListLabel25.SetAutoShowPrintOptions(const Value: Boolean);
begin

  FAutoShowPrintOptions := Value;

end;

procedure TListLabel25.SetAutoShowSelectFile(const Value: Boolean);
begin

  FAutoShowSelectFile := Value;

end;

procedure TListLabel25.SetCompressStorage(const Value: Boolean);
begin

  FCompressStorage := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_COMPRESSSTORAGE, Integer(FCompressStorage)));

end;

procedure TListLabel25.SetConvertCRLF(const Value: Boolean);
begin

  FConvertCRLF := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_CONVERTCRLF, Integer(FConvertCRLF)));

end;

procedure TListLabel25.SetDebug(const Value: TLlDebugFlags);
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

procedure TListLabel25.SetDelayTableHeader(const Value: Boolean);
begin

  FDelayTableHeader := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_DELAYTABLEHEADER, Integer(FDelayTableHeader)));

end;

procedure TListLabel25.SetIncludeFontDescent(const Value: Boolean);
begin

  FIncludeFontDescent := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_INCLUDEFONTDESCENT, Integer(FIncludeFontDescent)));

end;

procedure TListLabel25.SetIncrementalPreview(const Value: Boolean);
begin

  FIncrementalPreview := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_INCREMENTAL_PREVIEW, Integer(FIncrementalPreview)));

end;

procedure TListLabel25.SetMaximumIdleIterationsPerObject(const Value: Integer);
begin

  FMaximumIdleIterationsPerObject := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_IDLEITERATIONCHECK_MAX_ITERATIONS, Integer(FMaximumIdleIterationsPerObject)));

end;

procedure TListLabel25.SetMaxRTFVersion(const Value: Integer);
begin
  FMaxRTFVersion := Value;
  SetLanguage(Language); // makes sure to apply the value
end;

procedure TListLabel25.SetNoParameterCheck(const Value: Boolean);
begin

  FNoParameterCheck := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_NOPARAMETERCHECK, Integer(FNoParameterCheck)));

end;

procedure TListLabel25.SetPreviewZoom(const Value: Integer);
begin

  FPreviewZoom := Value;
  CheckError(LlSetOption(CurrentJobHandle, LL_OPTION_PRVZOOM_PERC, FPreviewZoom));

end;

// Druck Prozeduren

Function TListLabel25.JobInit(Var Jobhandle: HJob): Boolean;
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
    LlSetOption(JobHandle, LL_OPTION_CALLBACKPARAMETER, Integer(self));
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

Procedure TListLabel25.JobFree(JobHandle: HJob; DataProvider: TDataSetDataProvider);
begin
  if (DataProvider = nil) or (JobHandle <> FBaseJob) then
  begin
    LlSetNotificationCallback(JobHandle, nil);
    LLJobClose(JobHandle);
  end;
  if DataProvider<>nil then DataProvider.Free
end;

procedure TListLabel25.Notification(AComponent: TComponent; Operation: TOperation);
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

Function TListLabel25.CheckError(ErrorCode: Integer): Integer;
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

      Case MessageDlg(ErrorText, mtError, [mbCancel, mbOK], 0) of
        mrCancel:
          Result := CE_Abort;
        mrOK:
          Result := ErrorCode;
      end
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

procedure TListLabel25.CleanUpDataStructure;
begin
  LlDbAddTable(CurrentJobHandle, '', '');
  PassedTables.Clear;
  PassedRelations.Clear;
  DelayedRelations.Clear;
end;

procedure TListLabel25.SetProjectPassword(const Value: String);
var
  tmp: PChar;

begin

  FProjectPassword := Value;
  tmp := StrNew(PChar(FProjectPassword));
  LlSetOptionString(CurrentJobHandle, LL_OPTIONSTR_PROJECTPASSWORD, tmp);
  StrDispose(tmp);

end;

procedure TListLabel25.SetTableColoring(const Value: TLlTableColoring);
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

   case FieldType of
      LL_DATE_DELPHI:
         result := cmbtLL25x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_DATE_Delphi, '');
      LL_TEXT:
         result := cmbtLL25x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_TEXT, '');
      LL_Numeric:
         result:= cmbtLL25x.LlDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_Numeric,'');
      LL_NUMERIC_INTEGER:
         result:= cmbtLL25x.LlDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_NUMERIC_INTEGER,'');
      LL_BOOLEAN:
        result:= cmbtLL25x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_BOOLEAN,'');
      LL_RTF:
         result := cmbtLL25x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_RTF, nil);
      else Begin
         result := cmbtLL25x.LLDefineVariableExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_TEXT, '');
      End;
   end;
End;

function  LlCore.LlDefineVariableExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): Integer;
Begin
  if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);
   result:=0;
   case FieldType of
      LL_DRAWING_HMETA:
         result := cmbtLL25x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HEMETA, nil);
      LL_DRAWING_HBITMAP:
         result := cmbtLL25x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HBITMAP, nil);
      LL_DRAWING_HICON:
         result:= cmbtLL25x.LlDefineVariableExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HICON, nil);
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

   case FieldType of
      LL_DATE_DELPHI:
         result := cmbtLL25x.LLDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_DATE_Delphi, '');
      LL_TEXT:
         result := cmbtLL25x.LLDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_TEXT, '');
      LL_Numeric:
         result:= cmbtLL25x.LlDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_Numeric,'');
      LL_NUMERIC_INTEGER:
         result:= cmbtLL25x.LlDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_NUMERIC_INTEGER,'');
      LL_BOOLEAN:
        result:= cmbtLL25x.LlDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_BOOLEAN,'');
      LL_RTF:
         result := cmbtLL25x.LLDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_RTF, nil);
      else Begin
         result := cmbtLL25x.LLDefineFieldExt(fParentObject.CurrentJobHandle, PWideChar(Fieldname), PWideChar(Contents), LL_TEXT, '');
      End;
   end;
End;

function  LlCore.LlDefineFieldExtHandle(FieldName: String; Handle : Cardinal; FieldType: integer): Integer;
Begin
  if (fParentObject.UsedIdentifiers <> nil) and (fParentObject.UsedIdentifiers.IndexOf(FieldName) = -1) then exit(0);
   result:=0;
   case FieldType of
      LL_DRAWING_HMETA:
         result := cmbtLL25x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HEMETA, nil);
      LL_DRAWING_HBITMAP:
         result := cmbtLL25x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HBITMAP, nil);
      LL_DRAWING_HICON:
         result:= cmbtLL25x.LlDefineFieldExtHandle(fParentObject.CurrentJobHandle, PWideChar(Fieldname), Handle,LL_DRAWING_HICON, nil);
   end;
End;


function LlCore.LlSetOption(OptionIndex: Integer; Value: NativeInt): Integer;
begin
  Result := cmbtLL25x.LlSetOption(fParentObject.CurrentJobHandle, OptionIndex, Value);
end;

function LlCore.LlSetOptionString(OptionIndex: integer; Value: TString): integer;
begin
  Result := cmbtLL25x.LlSetOptionString(fParentObject.CurrentJobHandle, OptionIndex, PTChar(Value));
end;

function LlCore.LlGetOption(OptionIndex: integer
  ): integer;
begin
  Result := cmbtLL25x.LlGetOption(fParentObject.CurrentJobHandle, OptionIndex);
end;

Procedure TListLabel25.Design;
Var
  OldMaster : Boolean;
  i, err           : Integer;
  showexcept       : Boolean;
  DataProvider     : TDataSetDataProvider;
  DataProviderIntf : TDataProviderInterfaceProxyRoot;
  LlProjectType: Integer;
  LlProjectTypeForFileDialog: Integer;
  ProjectFilename: TString;
  WindowHandle: cmbtHWND;

begin
  err:=0;
  DataProvider:=nil;
  LlProjectType := TEnumTranslator.TranslateProjectType(FAutoProjectType);

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

Function TListLabel25.InitDataProvider(JobHandle:HJob; DrillDownFilter: PFilterDescription): TDataSetDataProvider;
Var
    i             : Integer;
    Tables        : TObjectList<TListLabelTable>;
    table         : TListLabelTable;
    Relations     : TObjectList<TListLabelTableRelation>;
    Relation      : TListLabelTableRelation;
    parent        : TDetailSourceItem;
    DataProvider  : TDataSetDataProvider;
    Filter        : String;
Begin

   DataProvider := TDataSetDataProvider.Create;

   // Create and prepare DataProvider
   for I := 0 to Datacontroller.DetailSources.Count-1 do with DataController do
   Begin
      Filter:='';
      if Assigned(DrillDownFilter) then
      Begin
        if (DetailSources[i].Name = DrillDownFilter.ParentTable) then
        Begin
           Filter:='['+DrillDownFilter.ParentKeyField + ']=' + QuotedStr(DrillDownFilter.KeyValue);
        End else
        if (DetailSources[i].Name = DrillDownFilter.ChildTable) then
        Begin
           Filter:='['+DrillDownFilter.ChildKeyField+ ']=' + QuotedStr(DrillDownFilter.KeyValue);
        End;
      End;

      DataProvider.AddDataSet(DetailSources[i].Name,
                               DetailSources[i].Datasource.DataSet,
                               DetailSources[i].PrimaryKeyField,
                               DetailSources[i].SortDescription,
                               Filter);

      if DetailSources[i].ParentNode<>nil then
      Begin
         parent:=TDetailSourceItem(DetailSources[i].ParentNode);
         DataProvider.AddRelation(parent.Name + '2' + DetailSources[i].Name,
                                   parent.Name,
                                   DetailSources[i].Name,
                                   DetailSources[i].MasterKeyField,
                                   DetailSources[i].DetailKeyField);
      End;

   End;

   // Reset DataSource in LL
   CleanUpDataStructure;
   CheckError(LlDbAddTable(JobHandle, 'LLStaticTable', ''));

   // Pass tables from DataProvider to LL
   Tables := DataProvider.Tables;

   if DataController.DataMember <> '' then
   begin
      table := DataProvider.GetTable(DataController.DataMember);

      CheckError(LlDbAddTableEx(JobHandle, Pchar(table.TableName), Pchar(table.TableName),1)); // enable advanced sorting
      PassedTables.Add(table.TableName);

      if DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables then
        CheckError(LlDbSetMasterTable(JobHandle, PChar(table.TableName)));


      DefineData(DataProvider, table);
      DefineSortOrders(table);
      FRelationsOfCurrentProvider := DataProvider.Relations;
      FillRootTables(DataProvider, table.TableName);
      DefineRelatedTables(DataProvider, table.TableName);

       // label projects
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


procedure TListLabel25.DeclareLlXObjectsToLL;
begin
  // NYI
end;

procedure TListLabel25.InitDataSource(projectFile: TString);
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


Procedure TListLabel25.DefineData(DataProvider: TDataSetDataProvider; table: TListLabelTable);
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


Procedure TListLabel25.DefineSortOrders(table: TListLabelTable);
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

procedure TListLabel25.FillRootTables(DataProvider: TDataSetDataProvider;
  DataMember: string);
begin
  RootTables.Clear;
  GetChildTables(DataProvider, DataMember, FRootTables);
end;


procedure TListLabel25.GetChildTables(DataProvider: TDataSetDataProvider;
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


function TListLabel25.GetJobHandle: Integer;
begin
  result:=CurrentJobHandle;
end;

Procedure TListLabel25.DefineRelatedTables(DataProvider: TDataSetDataProvider; TableName: String);
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

Procedure TListLabel25.PassTableAndHierarchy(DataProvider: TDataSetDataProvider; relation: TListLabelTableRelation; TableName: String; onlyFor1To1Relations: boolean);
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


Procedure TListLabel25.Print;
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

  DataProvider:=Nil;
  OldMaster := false;

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

procedure TListLabel25.DoExport(Wnd: HWND; ProjectFile, OriginalProjectFile: String;
  MaxPages: Integer; ExportFormat: String);
Var
  DataProvider    : TDataSetDataProvider;
  DataProviderIntf: TDataProviderInterfaceProxyRoot;
  JobHandle       : HJob;
  OldJobHandle    : HJob;
  ProjectPath     : STring;
  ok : Boolean;

begin
  DataProvider:=nil;
  JobHandle:=-1;
  OldJobHandle:=CurrentJobHandle;
  ok:=true;
  Try
    ProjectPath:=StringReplace(ProjectFile, ExtractFileExt(ProjectFile),'',[]);

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

        if not(CheckError(LLPrintWithBoxStart(JobHandle, TEnumTranslator.TranslateProjectType(FAutoProjectType), PChar(ProjectPath), LL_PRINT_EXPORT,
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

Procedure TListLabel25.DoPreviewAndDrilldown( Wnd               : HWND;
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
  ProjectPath     : STring;
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
  Try
    ProjectPath:=StringReplace(ProjectFile, ExtractFileExt(ProjectFile),'',[]);

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

        if not(CheckError(LLPrintWithBoxStart(JobHandle, TEnumTranslator.TranslateProjectType(FAutoProjectType), PChar(ProjectPath), LL_PRINT_PREVIEW,
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


Procedure TListLabel25.AbortPrinting();
begin
  if (CurrentJobHandle > 0) then
  begin
    LlPrintAbort(CurrentJobHandle);
  end;
end;

function TListLabel25.GetCore: LlCore;
begin

  if(FCore = nil) then
    begin
      FCore := LlCore.Create(Self);
    end;
    Result:= FCore
end;

//

Constructor LlCore.Create(ParentObject: TListLabel25);
begin
   fParentObject := ParentObject;
end;

function LlCore.LlGetOptionString(OptionIndex: integer;
  var Value: TString): integer;
var
  Buffer: PTChar;
  Length: integer;
begin
  Length := cmbTLl25x.LlGetOptionString(fParentObject.CurrentJobHandle, OptionIndex, nil,
    0);
  if length>0 then
  begin
    GetMem(Buffer, Length * sizeof(TChar));
    Buffer^ := #0;
    Result := cmbTLl25x.LlGetOptionString(fParentObject.CurrentJobHandle, OptionIndex, Buffer,
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


{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

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

