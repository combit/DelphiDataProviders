{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLPreview.pas
 Module : LLPreview.pas
 Descr. : Implementation file for the List & Label 28 VCL-Component
 Version: 28.001
==================================================================================
}

unit LLPreview;

interface
{$WEAKPACKAGEUNIT ON}

uses
  System.SysUtils, System.Classes, WinApi.Windows, Vcl.Graphics, Vcl.Controls,
  cmbtLL28x, ListLabel28, LLReport_Types, l28CommonInterfaces, l28FireDACInterfaces;

const
  IDM_PRV_ZOOMMUL2=100;
  IDM_PRV_ZOOMPREV=101;
  IDM_PRV_FIRST=102;
  IDM_PRV_LAST=103;
  IDM_PRV_PREVIOUS=104;
  IDM_PRV_NEXT=105;
  IDM_PRV_DEFAULT=108;
  IDM_PRV_PRINTONE=112;
  IDM_PRV_PRINTALL=113;
  IDM_PRV_FILEEXIT=114;
  IDM_PRV_SENDTO=115;
  IDM_PRV_SAVEAS=116;
  IDM_PRV_FAX=117;
  IDM_PRV_SAVE_PDF=123;
  IDM_PRV_PAGECOMBO=124;
  IDM_PRV_ZOOMCOMBO=125;
  IDM_PRV_SLIDESHOWMODE=126;
  IDM_PRV_SEARCH=118;
  IDM_PRV_SEARCH_NEXT=119;
  IDM_PRV_SEARCH_TEXT=121;
  IDM_PRV_SEARCH_OPTIONS=122;

type
 {$if CompilerVersion > 19}
 {$define UNICODE}
 {$define USE_UNICODE_DLL}
 {$define UNICODESTRING_AWARE}
 {$ifend}
  TSelectedPageFrameType=(ftAreaFillSystem, ftAreaFillLikeWin7, ftAreaFill, ftFrame);
  TButtonState = (bsInvisible,bsDefault,bsEnabled, bsDisabled);
  TDropShadowType =(dstNone, dstStandard);
  TCloseMode = (cmKeepFile, cmDeleteFile);

  TLlPreviewPage = class
  private
    FHandle: HLLSTG;
    FPageIndex: integer;
    procedure SetJobName(const Value: TString);
    function GetCreationApp: TString;
    function GetCreationDLL: TString;
    function GetCreationUser: TString;
  protected
    function GetCopies: integer;
    function GetCreation: TString;
    function GetJobName: TString;
    function GetPageIndex: integer;
    function GetProjectFileName: TString;
    function GetOrientation: integer;
    function GetPrintablePageOffset: TSize;
    function GetPrintablePageSize: TSize;
    function GetPrinterDevice: TString;
    function GetPrinterName: TString;
    function GetPrinterPhysicalPage: boolean;
    function GetPhysicalPageSize: TSize;
    function GetPrinterPort: TString;
    function GetPrinterResolution: TSize;
    function GetUserValue: TString;
    procedure SetUserValue(Value: TString);
    function GetOptionValue(OptionIndex: integer): integer;
    function GetOptionString(OptionIndex: integer): TString;

  public
    function GetMetafile: TMetafile;
    procedure Draw(Canvas: TCanvas; Rect: TRect; ResolutionCorrection: boolean);
    constructor Create(FileHandle: HLLSTG; PageIndex: integer);
    property Copies: integer read GetCopies;
    property Creation: TString read GetCreation;
    property CreationApp: TString read GetCreationApp;
    property CreationDLL: TString read GetCreationDLL;
    property CreationUser: TString read GetCreationUser;
    property PageIndex: integer read GetPageIndex;
    property ProjectFileName: TString read GetProjectFileName;
    property JobName: TString read GetJobName write SetJobName;
    property Orientation: integer read GetOrientation;
    property PrintablePageOffset: TSize read GetPrintablePageOffset;
    property PrintablePageSize: TSize read GetPrintablePageSize;
    property PrinterName: TString read GetPrinterName;
    property PrinterDevice: TString read GetPrinterDevice;
    property PrinterPort: TString read GetPrinterPort;
    property PrinterResolution: TSize read GetPrinterResolution;
    property PrinterPhysicalPage: boolean read GetPrinterPhysicalPage;
    property PhysicalPageSize: TSize read GetPhysicalPageSize;
    property UserValue: TString read GetUserValue write SetUserValue;
  end;

  TLlPreviewFile = class
  private
    FHandle: HLLSTG;
  protected
    function GetPageCount: integer;
    function GetPage(const Index: integer): TLlPreviewPage;
  public
    property PageCount: integer read GetPageCount;
    property Page[const Index: integer]: TLlPreviewPage read GetPage; default;
    property Handle: HLLSTG read FHandle;
    constructor Create(FileName: TString; ReadOnly: boolean; Language: TLlLanguage = lDefault);
    destructor Destroy; override;
    procedure Append(FileToAppend: TLlPreviewFile);
    procedure Print(PrinterFirstPage: TString; PrinterFollowingPages: TString;
      StartPage: integer; EndPage: integer; Copies: integer; Flags: integer;
      MessageText: TString; ParentHandle: cmbtHWND);
    function ConvertTo(TargetFileName: TString; TargetFormat: TString): integer;
    procedure Delete;
  end;

  TLlRTFTextMode = (tmRTF, tmPlain);
  TLlRTFContentMode = (cmRaw, cmEvaluated);
  TLlRTFPrintState = (psPending, psFinished);
  TLlPreviewControl28 = class;

  TLlPreviewButtons=class(TPersistent)
  private
    FPrintToFax: TButtonState;
    FPrintAllPages: TButtonState;
    FGotoFirst: TButtonState;
    FSendTo: TButtonState;
    FPrintCurrentPage: TButtonState;
    FGotoPrev: TButtonState;
    FGotoLast: TButtonState;
    FExit: TButtonState;
    FSaveAs: TButtonState;
    FGotoNext: TButtonState;
    FZoomTimes2: TButtonState;
    FZoomRevert: TButtonState;
    FZoomReset: TButtonState;
    FParentComponent: TLlPreviewControl28;
    FPageCombo: TButtonState;
    FZoomCombo: TButtonState;
    FSearchStart: TButtonState;
    FSearchNext: TButtonState;
    FSearchOptions: TButtonState;
    FSearchText: TButtonState;
    FSlideShowMode: TButtonState;
    procedure SetExit(const Value: TButtonState);
    procedure SetGotoFirst(const Value: TButtonState);
    procedure SetGotoLast(const Value: TButtonState);
    procedure SetGotoNext(const Value: TButtonState);
    procedure SetGotoPrev(const Value: TButtonState);
    procedure SetPrintAllPages(const Value: TButtonState);
    procedure SetPrintCurrentPage(const Value: TButtonState);
    procedure SetPrintToFax(const Value: TButtonState);
    procedure SetSaveAs(const Value: TButtonState);
    procedure SetSendTo(const Value: TButtonState);
    procedure SetZoomReset(const Value: TButtonState);
    procedure SetZoomRevert(const Value: TButtonState);
    procedure SetZoomTimes2(const Value: TButtonState);
    procedure SetPageCombo(const Value: TButtonState);
    procedure SetZoomCombo(const Value: TButtonState);
    procedure SetSearchStart(const Value: TButtonState);
    procedure SetSearchNext(const Value: TButtonState);
    procedure SetSearchOptions(const Value: TButtonState);
    procedure SetSearchText(const Value: TButtonState);

    procedure SetSlideShowMode(const Value: TButtonState);
  public
    constructor create(AParent: TLlPreviewControl28);
  published
    property GotoFirst: TButtonState read FGotoFirst write SetGotoFirst;
    property GotoPrev: TButtonState read FGotoPrev write SetGotoPrev;
    property GotoNext: TButtonState read FGotoNext write SetGotoNext;
    property GotoLast: TButtonState read FGotoLast write SetGotoLast;
    property ZoomTimes2: TButtonState read FZoomTimes2 write SetZoomTimes2;
    property ZoomRevert: TButtonState read FZoomRevert write SetZoomRevert;
    property ZoomReset: TButtonState read FZoomReset write SetZoomReset;
    property PrintCurrentPage: TButtonState read FPrintCurrentPage write SetPrintCurrentPage;
    property PrintAllPages: TButtonState read FPrintAllPages write SetPrintAllPages;
    property PrintToFax: TButtonState read FPrintToFax write SetPrintToFax;
    property SendTo: TButtonState read FSendTo write SetSendTo;
    property SaveAs: TButtonState read FSaveAs write SetSaveAs;
    property Exit: TButtonState read FExit write SetExit;
    property PageCombo: TButtonState read FPageCombo write SetPageCombo;
    property ZoomCombo: TButtonState read FZoomCombo write SetZoomCombo;
    property SlideShowMode: TButtonState read FSlideShowMode write SetSlideShowMode;
    property SearchStart: TButtonState read FSearchStart write SetSearchStart;
    property SearchNext: TButtonState read FSearchNext write SetSearchNext;
    property SearchOptions: TButtonState read FSearchOptions write SetSearchOptions;
    property SearchText: TButtonState read FSearchText write SetSearchText;

  end;

  TPageChangedEvent = procedure(Sender: TObject; NewPageIndex: integer) of object;
  TButtonClickedEvent = procedure(Sender: TObject; ButtonID: integer; var IsHandled: boolean) of object;

[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
TLlPreviewPageStyle = class(TPersistent)
  private
  fDropShadow: TDropShadowType;
  fShowPageNumbers: boolean;
  fParentComponent: TLlPreviewControl28;
  procedure SetDropShadow (const value: TDropShadowType);
  procedure SetShowPageNumbers (const value: boolean);
  public
  constructor create(AParent: TLlPreviewControl28);
  published
  property DropShadow: TDropShadowType read fDropShadow write SetDropShadow;
  property ShowPageNumbers : boolean read fShowPageNumbers write SetShowPageNumbers;

end;

TLlPreviewSelectionFrame = class(TPersistent)
private
  fParentComponent: TLlPreviewControl28;
  fFrameMarginHeight: integer;
  fFrameMarginWidth: integer;
  fFrameRoundedCorner: integer;
  fFrameColor: TColor;
  fFrameColorHighlighted: TColor;
  fFillColor: TColor;
  fFillColorHighlighted: TColor;
  fSelectedPageFrameType: TSelectedPageFrameType;
  procedure SetSelectedPageFrameType(const value: TSelectedPageFrameType);
  procedure SetFrameMarginHeight (const value: integer);
  procedure SetFrameMarginWidth (const value: integer);
  procedure SetFrameRoundedCorner (const value: integer);
  procedure SetFrameColor (const value: TColor);
  procedure SetFrameColorHighlighted (const value: TColor);
  procedure SetFillColor (const value: TColor);
  procedure SetFillColorHighlighted (const value: TColor);

public
  constructor create(AParent: TLlPreviewControl28);

published
  property MarginHeight: integer read fFrameMarginHeight write SetFrameMarginHeight;
  property MarginWidth: integer read fFrameMarginWidth write SetFrameMarginWidth;
  property RoundedCorner: integer read fFrameRoundedCorner write SetFrameRoundedCorner;
  property Color: TColor read fFrameColor write SetFrameColor;
  property ColorHighlighted: TColor read fFrameColorHighlighted write SetFrameColorHighlighted;
  property FillColor: TColor read fFillColor write SetFillColor;
  property FillColorHighlighted: TColor read fFillColorHighlighted write SetFillColorHighlighted;
  property FrameType: TSelectedPageFrameType read fSelectedPageFrameType write SetSelectedPageFrameType;

end;
  TLlPreviewControl28 = class(TCustomControl)
  private
    FPreviewPageStyle: TLlPreviewPageStyle;
    fPreviewSelectionFrame:TLlPreviewSelectionFrame;
    FFileName: TString;
    FShowToolbar: boolean;
    FToolbarButtons: TLlPreviewButtons;
    FInitializing: boolean;
    FNotifyProc: TFarProc;
    FBackgroundColor: TColor;
    FSaveAsFilePath: TString;
    FOnPageChanged: TPageChangedEvent;
    FOnButtonClicked: TButtonClickedEvent;
    FShowThumbnails: boolean;
    FLanguage: TLlLanguage;
    FhLlJob: integer;
    FCloseMode: TCloseMode;
    FShowUnprintableArea: boolean;
    procedure SetPreviewSelectionFrame (const Value: TLlPreviewSelectionFrame);
    procedure SetPreviewPageStyle (const Value: TLlPreviewPageStyle);
    procedure SetLanguage(const Value: TLlLanguage);
    procedure SetFileName(const Value: TString);
    procedure SetShowToolbar(const Value: boolean);
    procedure SetToolbarButtons(const Value: TLlPreviewButtons);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetSaveAsFilePath(const Value: TString);
  	function GetSaveAsFilePath: TString;
    function GetCurrentPage: integer;
    function GetPageCount: integer;
    procedure SetOnButtonClicked(const Value: TButtonClickedEvent);
    procedure SetShowThumbnails(const Value: boolean);
    procedure SetCloseMode(const Value: TCloseMode);
    procedure SetShowUnprintableArea(const Value: boolean);
  protected
    procedure CreateWnd; override;
    procedure DestroyWindowHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure RefreshOptions;
    procedure QuestButtonState(ButtonID: integer; var Result: NativeInt);
    function PWideToString(pw : PWideChar) : AnsiString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ZoomTimes2;
    procedure ZoomRevert;
    procedure ZoomReset;
	procedure SelectSlideshowTransition;
    function PrintCurrentPage(ShowPrintOptions: boolean) :integer;
    function PrintAllPages(ShowPrintOptions: boolean) :integer;
    procedure GotoFirst;
    procedure GotoLast;
    procedure GotoPrevious;
    procedure GotoNext;
    procedure SaveAs;
    procedure SetZoom(Percentage: integer);
    procedure SetSlideShowMode;
    procedure RefreshToolbar;
    procedure SetOptionString(Option: TString; Value: TString);
    procedure Attach(FParentComponent: TListLabel28; nFlags: Cardinal);
    procedure Detach;
    procedure SearchFirst(SearchString: TString; CaseSensitive: Boolean);
    procedure SearchNext;
    function GetActualButtonState(ButtonID: integer):integer;
    function GetOptionString(Option: TString): TString;
    function CanClose: boolean;
  published
    Property Align;
    Property TabStop;
    Property TabOrder;
    property OnEnter;
    property OnExit;
    property OnPageChanged: TPageChangedEvent read FOnPageChanged write FOnPageChanged;
    property OnButtonClicked: TButtonClickedEvent read FOnButtonClicked write SetOnButtonClicked;

    property SaveAsFilePath: TString read GetSaveAsFilePath write SetSaveAsFilePath;
    property InputFileName: TString read FFileName write SetFileName;
    property ShowToolbar: boolean read FShowToolbar write SetShowToolbar;
    property ShowThumbnails: boolean read FShowThumbnails write SetShowThumbnails;
    property ToolbarButtons: TLlPreviewButtons read FToolbarButtons write SetToolbarButtons;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property CurrentPage: integer read GetCurrentPage;
    property PageCount: integer read GetPageCount;
    Property Language: TLlLanguage read FLanguage write SetLanguage Default TLlLanguage.lDefault;
    property CloseMode: TCloseMode read FCloseMode write SetCloseMode;
    property ShowUnprintableArea: boolean read FShowUnprintableArea write SetShowUnprintableArea;
    property PageStyle: TLlPreviewPageStyle read FPreviewPageStyle write SetPreviewPageStyle;
    property SelectionFrame: TLlPreviewSelectionFrame read fPreviewSelectionFrame write SetPreviewSelectionFrame;
  end;

function StgsysNtfyCallback(nMsg: cardinal; lParam: NativeUInt; lUserParam: NativeInt): NativeInt; export; stdcall;

implementation

uses cmbtLS28x;


function StgsysNtfyCallback(nMsg: cardinal; lParam: NativeUInt; lUserParam: NativeInt): NativeInt;
var
  lResult: NativeInt;
  var IsHandled: boolean;
begin

  lResult := 0;
  IsHandled:=false;

  case nMsg of
    LS_VIEWERCONTROL_QUEST_BTNSTATE:
      begin
          TLlPreviewControl28(lUserParam).QuestButtonState(lParam,lResult);
      end;

    LS_VIEWERCONTROL_NTFY_PAGELOADED:
      begin
          if Assigned(TLlPreviewControl28(lUserParam).OnPageChanged) then
                  TLlPreviewControl28(lUserParam).OnPageChanged(TLlPreviewControl28(lUserParam),lParam);
      end;

    LS_VIEWERCONTROL_NTFY_BTNPRESSED:
      begin
          If Assigned(TLlPreviewControl28(lUserParam).OnButtonClicked) then
          begin
            TLlPreviewControl28(lUserParam).OnButtonClicked(TLlPreviewControl28(lUserParam),lParam, IsHandled);
            if IsHandled=true then lResult:=1;
          end;
      end;
  end;
  Result := lResult;
end;

{ TLlPreviewPage }


  constructor TLlPreviewPage.Create(FileHandle: HLLSTG; PageIndex: integer);
  begin
    inherited Create;
    FHandle := FileHandle;
    FPageIndex := PageIndex;
  end;

  procedure TLlPreviewPage.Draw(Canvas: TCanvas; Rect: TRect; ResolutionCorrection: boolean);
  var
    prnDC: HDC;
  begin
    if GetDeviceCaps(Canvas.Handle, TECHNOLOGY) = DT_RASDISPLAY then
      prnDC := 0
    else
      prnDC := Canvas.Handle;
    LlStgsysDrawPage(FHandle, Canvas.Handle, prnDC, False, @Rect, FPageIndex,
      ResolutionCorrection, nil);
  end;

  function TLlPreviewPage.GetCopies: integer;
  begin
    Result := GetOptionValue(LS_OPTION_COPIES);
  end;

  function TLlPreviewPage.GetCreation: TString;
  begin
    Result := GetOptionString(LS_OPTION_CREATION);
  end;

  function TLlPreviewPage.GetJobName: TString;
  begin
    Result := GetOptionString(LS_OPTION_JOBNAME);
  end;

  function TLlPreviewPage.GetMetafile: TMetafile;
  var
    mf: TMetafile;
  begin
    mf := TMetafile.Create;
    mf.Handle := LlStgsysGetPageMetafile(FHandle, FPageIndex);
    Result := mf;
  end;

  function TLlPreviewPage.GetOptionString(OptionIndex: integer): TString;
  var
    Buffer: PTChar;
    length: integer;
  begin
    length := cmbtLS28x.LlStgsysGetPageOptionString(FHandle, FPageIndex,
      OptionIndex, nil, 0);
    if length>0 then
    begin
      GetMem(Buffer, length * sizeof(TChar));
      Buffer^ := #0;
      cmbtLS28x.LlStgsysGetPageOptionString(FHandle, FPageIndex, OptionIndex, Buffer, length);
      Result := TString(Buffer);
      FreeMem(Buffer);
    end
    else
    begin
        result:='';
    end;
  end;

  function TLlPreviewPage.GetOptionValue(OptionIndex: integer): integer;
  begin
    Result := cmbtLS28x.LlStgsysGetPageOptionValue(FHandle, FPageIndex, OptionIndex);
  end;

  function TLlPreviewPage.GetOrientation: integer;
  begin
    Result := GetOptionValue(LS_OPTION_PRN_ORIENTATION);
  end;

  function TLlPreviewPage.GetPageIndex: integer;
  begin
    Result := FPageIndex;
  end;

  function TLlPreviewPage.GetProjectFileName: TString;
  begin
    Result := GetOptionString(LS_OPTION_PROJECTNAME);
  end;


  function TLlPreviewPage.GetPrintablePageOffset: TSize;
  begin
    Result.cx := GetOptionValue(LS_OPTION_PRN_PIXELSOFFSET_X);
    Result.cy := GetOptionValue(LS_OPTION_PRN_PIXELSOFFSET_Y);
  end;

  function TLlPreviewPage.GetPrintablePageSize: TSize;
  begin
    Result.cx := GetOptionValue(LS_OPTION_PRN_PIXELS_X);
    Result.cy := GetOptionValue(LS_OPTION_PRN_PIXELS_Y);
  end;

  function TLlPreviewPage.GetPrinterDevice: TString;
  begin
    Result := GetOptionString(LS_OPTION_PRTDEVICE);
  end;

  function TLlPreviewPage.GetPrinterName: TString;
  begin
    Result := GetOptionString(LS_OPTION_PRTNAME);
  end;

  function TLlPreviewPage.GetPhysicalPageSize: TSize;
  begin
    Result.cx := GetOptionValue(LS_OPTION_PRN_PIXELSPHYSICAL_X);
    Result.cy := GetOptionValue(LS_OPTION_PRN_PIXELSPHYSICAL_Y);
  end;

  function TLlPreviewPage.GetPrinterPhysicalPage: boolean;
  begin
    Result := (GetOptionValue(LS_OPTION_PHYSPAGE) <> 0);
  end;

  function TLlPreviewPage.GetPrinterPort: TString;
  begin
    Result := GetOptionString(LS_OPTION_PRTPORT);
  end;

  function TLlPreviewPage.GetPrinterResolution: TSize;
  begin
    Result.cx := GetOptionValue(LS_OPTION_PRN_PIXELSPERINCH_X);
    Result.cy := GetOptionValue(LS_OPTION_PRN_PIXELSPERINCH_Y);
  end;

  function TLlPreviewPage.GetUserValue: TString;
  begin
    Result := GetOptionString(LS_OPTION_USER);
  end;

  procedure TLlPreviewPage.SetJobName(const Value: TString);
  begin
    cmbtLS28x.LlStgsysSetPageOptionString(FHandle, FPageIndex,
      LS_OPTION_JOBNAME, PTChar(Value));
  end;

  procedure TLlPreviewPage.SetUserValue(Value: TString);
  begin
    cmbtLS28x.LlStgsysSetPageOptionString(FHandle, FPageIndex,
      LS_OPTION_USER, PTChar(Value));
  end;

  function TLlPreviewPage.GetCreationApp: TString;
  begin
    Result := GetOptionString(LS_OPTION_CREATIONAPP);
  end;

  function TLlPreviewPage.GetCreationDLL: TString;
  begin
    Result := GetOptionString(LS_OPTION_CREATIONDLL);
  end;

  function TLlPreviewPage.GetCreationUser: TString;
  begin
    Result := GetOptionString(LS_OPTION_CREATIONUSER);
  end;

 { TLlPreviewFile }

  procedure TLlPreviewFile.Append(FileToAppend: TLlPreviewFile);
  begin
    LlStgsysAppend(FHandle, FileToAppend.FHandle);
  end;

function TLlPreviewFile.ConvertTo(TargetFileName, TargetFormat: TString): integer;
begin
 Result := LlStgsysConvert(FHandle, PTChar(TargetFileName), PTChar(TargetFormat));
end;

constructor TLlPreviewFile.Create(FileName: TString; ReadOnly: boolean; Language: TLlLanguage);
  begin
    inherited Create;
    FHandle := LlStgsysStorageOpen(PTChar(FileName), nil, ReadOnly, True);

    if Language <> lDefault then
      begin
        LlStgsysSetUILanguage(FHandle, TEnumTranslator.TranslateLanguage(Language));
      end;
  end;

  procedure TLlPreviewFile.Delete;
  begin
    LlStgsysDeleteFiles(FHandle);
  end;

  destructor TLlPreviewFile.Destroy;
  begin
    LlStgsysStorageClose(FHandle);
    inherited Destroy;
  end;

  function TLlPreviewFile.GetPage(const Index: integer): TLlPreviewPage;
  begin
    if Index <= GetPageCount then
    begin
      Result := TLlPreviewPage.Create(FHandle, Index);
    end
    else
      Result := nil;
  end;

  function TLlPreviewFile.GetPageCount: integer;
  begin
    Result := LlStgsysGetPageCount(FHandle);
  end;

  procedure TLlPreviewFile.Print(PrinterFirstPage,
    PrinterFollowingPages: TString; StartPage, EndPage, Copies,
    Flags: integer; MessageText: TString; ParentHandle: cmbtHWND);
  var
    Prt1, Prt2: PTChar;
  begin
    if PrinterFirstPage = '' then Prt1 := nil
    else
      Prt1 := PTChar(PrinterFirstPage);
    if PrinterFollowingPages = '' then Prt2 := nil
    else
      Prt2 := PTChar(PrinterFollowingPages);
    LlStgsysPrint(FHandle, Prt1, Prt2,
      StartPage, EndPage, Copies, Flags, PTChar(MessageText), ParentHandle);
  end;

{ TLlPreviewButtons }

constructor TLlPreviewButtons.create(AParent: TLlPreviewControl28);
begin
  inherited create;
  FParentComponent:=AParent;
  Exit:=bsDefault;
  GotoFirst:=bsDefault;
  GotoLast:=bsDefault;
  GotoNext:=bsDefault;
  GotoPrev:=bsDefault;
  PrintAllPages:=bsDefault;
  PrintCurrentPage:=bsDefault;
  PrintToFax:=bsDefault;
  SaveAs:=bsDefault;
  SendTo:=bsDefault;
  ZoomReset:=bsDefault;
  ZoomRevert:=bsDefault;
  ZoomTimes2:=bsDefault;
  PageCombo:=bsDefault;
  ZoomCombo:=bsDefault;
  SlideShowMode:=bsDefault;
  SearchNext:=bsDefault;
  SearchOptions:=bsDefault;
  SearchStart:=bsDefault;
  SearchText:=bsDefault;
end;

procedure TLlPreviewButtons.SetExit(const Value: TButtonState);
begin
  FExit := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetGotoFirst(const Value: TButtonState);
begin
  FGotoFirst := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetGotoLast(const Value: TButtonState);
begin
  FGotoLast := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetGotoNext(const Value: TButtonState);
begin
  FGotoNext := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetGotoPrev(const Value: TButtonState);
begin
  FGotoPrev := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetPageCombo(const Value: TButtonState);
begin
  FPageCombo := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetPrintAllPages(const Value: TButtonState);
begin
  FPrintAllPages := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetPrintCurrentPage(const Value: TButtonState);
begin
  FPrintCurrentPage := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetPrintToFax(const Value: TButtonState);
begin
  FPrintToFax := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSaveAs(const Value: TButtonState);
begin
  FSaveAs := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSearchNext(const Value: TButtonState);
begin
  FSearchNext := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSearchOptions(const Value: TButtonState);
begin
  FSearchOptions := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSearchStart(const Value: TButtonState);
begin
  FSearchStart := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSearchText(const Value: TButtonState);
begin
  FSearchText := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSendTo(const Value: TButtonState);
begin
  FSendTo := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetSlideShowMode(const Value: TButtonState);
begin
  FSlideShowMode := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetZoomCombo(const Value: TButtonState);
begin
  FZoomCombo := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetZoomReset(const Value: TButtonState);
begin
  FZoomReset := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetZoomRevert(const Value: TButtonState);
begin
  FZoomRevert := Value;
  FParentComponent.RefreshToolbar;
end;

procedure TLlPreviewButtons.SetZoomTimes2(const Value: TButtonState);
begin
  FZoomTimes2 := Value;
  FParentComponent.RefreshToolbar;
end;

{PreviewPageStyle}

constructor TLlPreviewPageStyle.create(AParent: TLlPreviewControl28);
begin
  inherited create;
  fParentComponent:= AParent;
end;

procedure  TLlPreviewPageStyle.SetShowPageNumbers (const value: boolean);
begin
 SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_PAGENUMBER, NativeInt(value));
 fShowPageNumbers:= Value;
end;

procedure TLlPreviewPageStyle.SetDropShadow(const value: TDropShadowType);
begin
  fDropShadow := Value;
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_DROPSHADOW, NativeInt(value));

end;

{TLlPreviewSelectFrame}

constructor TLlPreviewSelectionFrame.create(AParent: TLlPreviewControl28);
begin
  inherited create;
  fParentComponent:= AParent;
end;

procedure TLlPreviewSelectionFrame.SetSelectedPageFrameType(const value: TSelectedPageFrameType);
begin
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE, NativeInt(value));
  fSelectedPageFrameType:= value;
end;

procedure TLlPreviewSelectionFrame.SetFrameMarginHeight(const value: Integer);
begin
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_HEIGHT_PX, NativeInt(value));
  fFrameMarginHeight:= value;
end;

procedure TLlPreviewSelectionFrame.SetFrameMarginWidth;
begin
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_WIDTH_PX, NativeInt(value));
  fFrameMarginWidth:= value;
end;

procedure TLlPreviewSelectionFrame.SetFrameRoundedCorner(const value: Integer);
begin
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_ROUNDED_CORNER_PX, NativeInt(value));
  fFrameRoundedCorner:= value;
end;

procedure TLlPreviewSelectionFrame.SetFrameColor(const value: TColor);
begin
  fFrameColor:= value;
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FRAMECOLOR_ARGB, Color or NativeInt($FF000000));
end;

procedure TLlPreviewSelectionFrame.SetFrameColorHighlighted(const value: TColor);
begin

  fFrameColorHighlighted:= value;
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FRAMECOLORHIGHLIGHTED_ARGB, ColorHighlighted or NativeInt($FF000000));
end;

procedure TLlPreviewSelectionFrame.SetFillColor(const value: TColor);
begin
  fFillColor:= value;
  SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FILLCOLOR_ARGB, FillColor or NativeInt($FF000000));
end;

procedure TLlPreviewSelectionFrame.SetFillColorHighlighted(const value: TColor);
begin
    fFillColorHighlighted:= value;
    SendMessage(fParentComponent.Handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FILLCOLORHIGHLIGHTED_ARGB, FillColorHighlighted or NativeInt($FF000000));
end;

{ TLlPreviewControl28 }

constructor TLlPreviewControl28.Create(AOwner: TComponent);
begin
    inherited create(AOwner);
    LS28xLoad();
    LL28xLoad();
    FNotifyProc := TFarProc(@StgsysNtfyCallback);
    FInitializing:=true;
    ShowToolbar:=true;
    ShowThumbnails:=true;
    ShowUnprintableArea:=false;
    InputFileName:='';
    BackgroundColor:=clWhite;
    FhLlJob := -1;
    FCloseMode := cmKeepFile;
    ToolbarButtons:=TLlPreviewButtons.create(self);
    PageStyle:= TLlPreviewPageStyle.create(self);
    SelectionFrame:= TLlPreviewSelectionFrame.create(self);
end;

procedure TLlPreviewControl28.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);
    Params.ExStyle:=Params.ExStyle or WS_EX_CLIENTEDGE;
end;

procedure TLlPreviewControl28.CreateWindowHandle(
  const Params: TCreateParams);
begin
    if not (csDesigning in ComponentState) then
    begin
    {$ifdef UNICODE}
      {$ifdef UNICODESTRING_AWARE}
        StrCopy(PChar(@Params.WinClassName), LsGetViewerControlClassName);
      {$else}
        StrCopy(@Params.WinClassName,PChar(PWideToString(LsGetViewerControlClassName)));
      {$endif}
    {$else}
        StrCopy(PChar(@Params.WinClassName), LsGetViewerControlClassName);
    {$endif}
    end;
    inherited CreateWindowHandle(Params);
end;

procedure TLlPreviewControl28.CreateWnd;
begin
    inherited CreateWnd;
    SendMessage(handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_USERDATA, lparam(self));
    SendMessage(handle,LS_VIEWERCONTROL_SET_NTFYCALLBACK, 0, lparam(FNotifyProc));
    FInitializing:=false;
    if not (csDesigning in ComponentState) then
    begin
        RefreshOptions;
        RefreshToolbar;
    end;
end;

procedure TLlPreviewControl28.DestroyWindowHandle;
begin
    if IsWindow(handle) then
        inherited DestroyWindowHandle;
end;


procedure TLlPreviewControl28.Detach;
var
 CurrentInputFileName: TString;
begin
  CurrentInputFileName := InputFileName;
  LlAssociatePreviewControl(FhLlJob, 0, 0);
  if ( (CurrentInputFileName <> '') and (CloseMode = cmDeleteFile) ) then
  {$ifdef UNICODE}
    DeleteFileW(PWideChar(CurrentInputFileName));
  {$else}
    DeleteFile(PAnsiChar(CurrentInputFileName));
  {$endif}
end;

destructor TLlPreviewControl28.Destroy;
begin
    ToolbarButtons.Free;
    PageStyle.Free;
    SelectionFrame.Free;
    LS28xUnload;
    LL28xUnload;
    inherited destroy;
end;

function TLlPreviewControl28.GetActualButtonState(ButtonID: integer):integer;
begin
    if ShowToolbar then
        result:=SendMessage(handle, LS_VIEWERCONTROL_GET_TOOLBARBUTTONSTATE, ButtonID,0)
    else
        result:=LL_ERR_PARAMETER;

end;

function TLlPreviewControl28.GetOptionString(Option: TString): TString;
var Size: integer;
    Buffer: PTChar;
begin
    Size:=SendMessage(handle, LS_VIEWERCONTROL_GET_OPTIONSTRLEN, NativeInt(PTChar(Option)), 0);
    if Size>0 then
    begin
      GetMem(Buffer,Size*sizeof(TChar));
      Buffer^ := #0;
      SendMessage(handle, LS_VIEWERCONTROL_GET_OPTIONSTR, NativeUInt(PTChar(Option)), NativeInt(Buffer));
      result:=Buffer;
      FreeMem(Buffer);
    end
    else
        result:='';
end;
procedure TLlPreviewControl28.SetPreviewPageStyle(const Value: TLlPreviewPageStyle);
begin
  FPreviewPageStyle:= Value;
end;

procedure TLlPreviewControl28.SetPreviewSelectionFrame(const Value: TLlPreviewSelectionFrame);
begin
  fPreviewSelectionFrame:= Value;
end;

function TLlPreviewControl28.GetCurrentPage: integer;
begin
     result:=SendMessage(handle, LS_VIEWERCONTROL_GET_PAGE, 0, 0);
end;

function TLlPreviewControl28.GetPageCount: integer;
begin
     result:=SendMessage(handle, LS_VIEWERCONTROL_GET_PAGECOUNT, 0, 0);
end;

procedure TLlPreviewControl28.GotoFirst;
begin
    SendMessage(handle,LS_VIEWERCONTROL_SET_PAGE, 0, 0);
end;

procedure TLlPreviewControl28.GotoLast;
var
    Pages: integer;
begin
    Pages:=SendMessage(handle,LS_VIEWERCONTROL_GET_PAGECOUNT, 0, 0);
    SendMessage(handle,LS_VIEWERCONTROL_SET_PAGE, Pages-1, 0);
end;

procedure TLlPreviewControl28.GotoNext;
var
    CurrentPage: integer;
begin
    CurrentPage:=SendMessage(handle,LS_VIEWERCONTROL_GET_PAGE, 0, 0);
    SendMessage(handle,LS_VIEWERCONTROL_SET_PAGE, CurrentPage+1, 0);
end;

procedure TLlPreviewControl28.SaveAs;
begin
    SendMessage(handle,LS_VIEWERCONTROL_SAVE_TO_FILE, 0, 0);
end;


procedure TLlPreviewControl28.GotoPrevious;

var
    CurrentPage: integer;
begin
    CurrentPage:=SendMessage(handle,LS_VIEWERCONTROL_GET_PAGE, 0, 0);
    if CurrentPage>0 then
        SendMessage(handle,LS_VIEWERCONTROL_SET_PAGE, CurrentPage-1, 0);
end;

function TLlPreviewControl28.PrintAllPages(ShowPrintOptions: boolean): integer;
var Value: integer;
begin
    if ShowPrintOptions then Value:=1 else Value:=0;
   Result:= SendMessage(handle,LS_VIEWERCONTROL_PRINT_ALL, Value, 0);
end;

function TLlPreviewControl28.PrintCurrentPage(ShowPrintOptions: boolean): integer;
var Value: integer;
begin
    if ShowPrintOptions then Value:=1 else Value:=0;
    Result:= SendMessage(handle,LS_VIEWERCONTROL_PRINT_CURRENT, Value, 0);
end;

function TLlPreviewControl28.PWideToString(pw: PWideChar): AnsiString;
var
  buffer : PAnsiChar;
  iLen : integer;
begin
  iLen := lstrlenw(pw)+1;
  GetMem(buffer, iLen);
  WideCharToMultiByte(CP_ACP, 0, pw, iLen, buffer, iLen*2, nil, nil);
  Result := buffer;
  FreeMem(buffer);
end;

procedure TLlPreviewControl28.QuestButtonState(ButtonID: integer;
  var Result: NativeInt);
begin
    case ButtonID of
        IDM_PRV_ZOOMMUL2        : Result:=integer(ToolbarButtons.ZoomTimes2)-1;
        IDM_PRV_ZOOMPREV        : Result:=integer(ToolbarButtons.ZoomRevert)-1;
        IDM_PRV_FIRST           : Result:=integer(ToolbarButtons.GotoFirst)-1;
        IDM_PRV_LAST            : Result:=integer(ToolbarButtons.GotoLast)-1;
        IDM_PRV_PREVIOUS        : Result:=integer(ToolbarButtons.GotoPrev)-1;
        IDM_PRV_NEXT            : Result:=integer(ToolbarButtons.GotoNext)-1;
        IDM_PRV_DEFAULT         : Result:=integer(ToolbarButtons.ZoomReset)-1;
        IDM_PRV_PRINTONE        : Result:=integer(ToolbarButtons.PrintCurrentPage)-1;
        IDM_PRV_PRINTALL        : Result:=integer(ToolbarButtons.PrintAllPages)-1;
        IDM_PRV_FILEEXIT        : Result:=integer(ToolbarButtons.Exit)-1;
        IDM_PRV_SENDTO          : Result:=integer(ToolbarButtons.SendTo)-1;
        IDM_PRV_SAVEAS          : Result:=integer(ToolbarButtons.SaveAs)-1;
        IDM_PRV_FAX             : Result:=integer(ToolbarButtons.PrintToFax)-1;
        IDM_PRV_PAGECOMBO       : Result:=integer(ToolbarButtons.PageCombo)-1;
        IDM_PRV_ZOOMCOMBO       : Result:=integer(ToolbarButtons.ZoomCombo)-1;
        IDM_PRV_SLIDESHOWMODE   : Result:=integer(ToolbarButtons.SlideShowMode)-1;
        IDM_PRV_SEARCH          : Result:=integer(ToolbarButtons.SearchStart)-1;
        IDM_PRV_SEARCH_NEXT     : Result:=integer(ToolbarButtons.SearchNext)-1;
        IDM_PRV_SEARCH_TEXT     : Result:=integer(ToolbarButtons.SearchText)-1;
        IDM_PRV_SEARCH_OPTIONS  : Result:=integer(ToolbarButtons.SearchOptions)-1;

    else
        Result:=0;
    exit;
    end;

end;

procedure TLlPreviewControl28.RefreshOptions;
begin
    SetFileName(InputFileName);
    SetShowToolbar(FShowToolbar);
    SetBackgroundColor(FBackgroundColor);
    SetShowThumbnails(FShowThumbnails);
    SetSaveAsFilePath(FSaveAsFilePath);
end;

procedure TLlPreviewControl28.RefreshToolbar;
begin
    if not FInitializing then
        SendMessage(handle, LS_VIEWERCONTROL_NTFY_TOOLBARUPDATE, 0, 0);
end;

procedure TLlPreviewControl28.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  if not FInitializing then
  begin
    SendMessage(handle, LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_BGCOLOR,BackgroundColor);
  end;
end;

procedure TLlPreviewControl28.SetCloseMode(const Value: TCloseMode);
begin
  FCloseMode := Value;
end;

procedure TLlPreviewControl28.SetFileName(const Value: TString);
begin
  if not (csDesigning in ComponentState) then
  begin
    if not FInitializing then
    begin
        SendMessage(handle,LS_VIEWERCONTROL_SET_FILENAME,0,NativeInt(PTChar(Value)));
        invalidate;
    end;
  end;
  FFileName := Value;
end;

procedure TLlPreviewControl28.SetLanguage(const Value: TLlLanguage);
begin
  SendMessage(handle, LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_LANGUAGE, TEnumTranslator.TranslateLanguage(value));
  FLanguage := Value;
end;

procedure TLlPreviewControl28.SetOptionString(Option, Value: TString);
begin
  SendMessage(handle, LS_VIEWERCONTROL_SET_OPTIONSTR, NativeUInt(PTChar(Option)), NativeInt(PTChar(Value)));
end;

procedure TLlPreviewControl28.SetSlideShowMode;
begin
  SendMessage(handle, LS_VIEWERCONTROL_SET_THEATERMODE, 1, 1);
end;

procedure TLlPreviewControl28.SetSaveAsFilePath(const Value: TString);
begin
  FSaveAsFilePath := Value;
  if not (csDesigning in ComponentState) then
  begin
    if not FInitializing then
      SendMessage(handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_SAVEASFILEPATH, NativeInt(PTChar(Value)));
  end;
end;

function TLlPreviewControl28.GetSaveAsFilePath: TString;
var Buffer: PTChar;
begin

  if not (csDesigning in ComponentState) then
  begin

    // ask the preview-control for the selected file-path
    GetMem(Buffer, 1024 * sizeof(TChar));
    Buffer^ := #0;
    SendMessage(handle, LS_VIEWERCONTROL_GET_OPTION, integer(LS_OPTION_SAVEASFILEPATH), NativeInt(Buffer));
    Result := Buffer;
    FreeMem(Buffer);

  end
  else
  begin

    Result := FSaveAsFilePath;

  end;

end;

procedure TLlPreviewControl28.SetShowToolbar(const Value: boolean);
var IntValue: integer;
begin
  FShowToolbar := Value;
  if not (csDesigning in ComponentState) then
  begin
    if Value then IntValue:=1 else IntValue:=0;
    if not FInitializing then SendMessage(handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_TOOLBAR, IntValue);
  end;
end;

procedure TLlPreviewControl28.SetShowUnprintableArea(const Value: boolean);
var IntValue: integer;
begin
  FShowUnprintableArea:=Value;
  if not (csDesigning in ComponentState) then
  begin
    if Value then IntValue:=1 else IntValue:=0;
      if not FInitializing then SendMessage(handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_SHOW_UNPRINTABLE_AREA,IntValue);
  end;
end;

procedure TLlPreviewControl28.SetToolbarButtons(
  const Value: TLlPreviewButtons);
begin
  FToolbarButtons := Value;
end;

procedure TLlPreviewControl28.SetZoom(Percentage: integer);
begin
    SendMessage(handle,LS_VIEWERCONTROL_SET_ZOOM, Percentage, 0);
end;


procedure TLlPreviewControl28.ZoomReset;
begin
    SendMessage(handle,LS_VIEWERCONTROL_RESET_ZOOM, 0, 0);
end;

procedure TLlPreviewControl28.ZoomRevert;
begin
    SendMessage(handle,LS_VIEWERCONTROL_POP_ZOOM, 0, 0);
end;

procedure TLlPreviewControl28.SelectSlideshowTransition;
begin
    SendMessage(handle,LS_VIEWERCONTROL_SELECT_THEATERXFORM , 0, 0);
end;

procedure TLlPreviewControl28.ZoomTimes2;
begin
    SendMessage(handle,LS_VIEWERCONTROL_SET_ZOOM_TWICE, 0, 0);
end;

procedure TLlPreviewControl28.Attach(FParentComponent: TListLabel28;
  nFlags: Cardinal);
begin
  FhLlJob := FParentComponent.GetJobHandle;
  LlAssociatePreviewControl(FhLlJob, Self.Handle, nFlags);
end;

procedure TLlPreviewControl28.SearchFirst(SearchString: TString; CaseSensitive: Boolean);
var wParam: NativeUInt;
begin
  if CaseSensitive = True then
  begin
     wParam := 0;
  end
  else
  begin
    wParam := LS_VCITEM_SEARCHFLAG_CASEINSENSITIVE;
  end;

  SendMessage(handle, LS_VIEWERCONTROL_SEARCH,
   LS_VCITEM_SEARCH_FIRST Or wParam,
   NativeInt(PTChar(SearchString)));
end;

procedure TLlPreviewControl28.SearchNext;
begin
  SendMessage(handle, $400 + 29 (*LS_VIEWERCONTROL_SEARCH*), 1 (*LS_VCITEM_SEARCH_NEXT*), 0);
end;

function TLlPreviewControl28.CanClose: boolean;
begin
    if SendMessage(handle,LS_VIEWERCONTROL_QUERY_ENDSESSION, 0, 0)=1 then
        result:=true
    else
        result:=false;
end;

procedure TLlPreviewControl28.SetOnButtonClicked(
  const Value: TButtonClickedEvent);
begin
  FOnButtonClicked := Value;
end;

procedure TLlPreviewControl28.SetShowThumbnails(const Value: boolean);
var IntValue: integer;
begin
  FShowThumbnails:=Value;
  if not (csDesigning in ComponentState) then
  begin
    if Value then IntValue:=1 else IntValue:=0;
    if not FInitializing then SendMessage(handle,LS_VIEWERCONTROL_SET_OPTION, LS_OPTION_NAVIGATIONBAR,IntValue);
  end;
end;


end.
