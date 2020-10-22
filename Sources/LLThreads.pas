{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLThreads.pas
 Module : List & Label 26
 Descr. : Implementation file for the List & Label 26 VCL-Component
 Version: 26.000
==================================================================================
}

unit LLThreads;

interface
{$WEAKPACKAGEUNIT ON}
uses
  Classes, SysUtils, Windows, ListLabel26;

type

  TPrintPreviewThread = class(TThread)
  private
    FPrintInstance      : TListLabel26;
    FProjectFile        : string;
    FOriginalProjectFile: string;
    FExportFormat       : String;
    FControlHandle      : HWND;
    FEventHandle        : Cardinal;
    FPageCount          : integer;
    FDoExport           : boolean;
    FTerminated         : boolean;
    FIsPrinting         : boolean;
    procedure DesignerPrintPreview();
  protected
    procedure Execute; override;
  public

    procedure FinalizePrinting();
    procedure Abort();

    property PrintInstance: TListLabel26 read FPrintInstance write FPrintInstance;
    Property ProjectFile  : string read FProjectFile write FProjectFile;
    Property OriginalProjectFile: string read FOriginalProjectFile write FOriginalProjectFile;
    Property ExportFormat: String read FExportFormat write FExportFormat;
    Property ControlHandle : HWND read FControlHandle write FControlHandle;
    Property EventHandle   : Cardinal read FEventHandle write FEventHandle;
    Property PageCount     : integer read FPageCount write FPageCount;
    Property DoExport      : boolean read FDoExport write FDoExport;
    Property Terminated    : boolean read FTerminated write FTerminated;
    Property IsPrinting    : boolean read FIsPrinting write FIsPrinting;
  end;

  TDrillDownThread = class(TThread)
  private
    FUserParam      : integer;
    FPreviewFileName: String;
    FTabText        : String;
    FProjectFileName: String;
    FParentKey      : String;
    FParentTableName: String;
    FAttachInfo     : THandle;
    FPrintInstance  : TListLabel26;
    FTerminated     : boolean;
    FKeyValue       : String;
    FJobID          : longint;
    FTooltipText    : String;
    FRelationName   : String;
    FWindowHandle   : HWND;
    FChildKey       : String;
    FChildTableName : String;
    procedure DoDrillDown;
  protected
    procedure Execute; override;
  public
    property Terminated: boolean read FTerminated write FTerminated;
    property PrintInstance: TListLabel26 read FPrintInstance write FPrintInstance;
    property UserParam: integer read FUserParam write FUserParam;
    property ParentTableName: String read FParentTableName write FParentTableName;
    property RelationName: String read FRelationName write FRelationName;
    property ChildTableName: String read FChildTableName write FChildTableName;
    property ParentKey: String read FParentKey write FParentKey;
    property ChildKey: String read FChildKey write FChildKey;
    property KeyValue: String read FKeyValue write FKeyValue;
    property ProjectFileName: String read FProjectFileName write FProjectFileName;
    property PreviewFileName: String read FPreviewFileName write FPreviewFileName;
    property TooltipText: String read FTooltipText write FTooltipText;
    property TabText: String read FTabText write FTabText;
    property WindowHandle: HWND read FWindowHandle write FWindowHandle;
    property JobID: longint read FJobID write FJobID;
    property AttachInfo: THandle read FAttachInfo write FAttachInfo;
    procedure FinalizePrinting();
  end;

implementation
uses cmbtLS26x, LLDataSetDataProvider;
procedure TPrintPreviewThread.Abort;
begin
  PrintInstance.AbortPrinting;
  Terminated := True;
  IsPrinting := False;
  Terminated := True;
end;

procedure TPrintPreviewThread.DesignerPrintPreview;
begin

  Try
     IsPrinting:=True;
     PostMessage(controlHandle, LS_VIEWERCONTROL_UPDATE_TOOLBAR, 0, 0);
     if (not DoExport) then
       printInstance.DoPreviewAndDrilldown(ControlHandle, False, ProjectFile, OriginalProjectFile, PageCount,'',nil,0)
     else
       printInstance.DoExport(FControlHandle, ProjectFile, OriginalProjectFile, PageCount, ExportFormat);
  Finally
     Terminated := true;
     IsPrinting := False;
  End;


end;

procedure TPrintPreviewThread.Execute;
begin
  IsPrinting := false;
  Synchronize(DesignerPrintPreview);
end;

procedure TPrintPreviewThread.FinalizePrinting();
begin
  Abort();
end;

//==============================================================================
// TDrillDownThread
//==============================================================================

procedure TDrillDownThread.DoDrillDown;
Var Filter : TFilterDescription;
    Function StripField(AName:String): STring;
    Var p : INteger;
    Begin
       p:=Pos('.',AName);
       if p>0 then
         result:=Copy(Aname,p+1,Length(AName))
       else
         result:='';
    End;
begin
   Try
     Filter.ParentTable    := FParentTableName;
     Filter.ParentKeyField := StripField(FParentKey);
     Filter.ChildTable     := FChildTableName;
     Filter.ChildKeyField  := StripField(FChildKey);
     Filter.KeyValue       := FKeyValue;

     printInstance.DoPreviewAndDrilldown( FWindowHandle,
                                          True,
                                          ProjectFileName,
                                          '',
                                          0,
                                          PreviewFileName,
                                          @Filter,
                                          AttachInfo);
  Finally
     Terminated := true;
  End;
end;

procedure TDrillDownThread.Execute;
begin
  DoDrillDown;
end;

procedure TDrillDownThread.FinalizePrinting;
begin
  Terminated := True;
end;

end.
