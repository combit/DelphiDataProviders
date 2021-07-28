{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLReport_Types.pas
 Module : LLReport_Types.pas
 Descr. : Implementation file for the List & Label 26 VCL-Component
 Version: 26.002
==================================================================================
}

unit LLReport_Types;

interface
{$WEAKPACKAGEUNIT ON}


Uses
  Windows, Classes, DB, Graphics, ObjTree, System.Contnrs, cmbtll26x, Dialogs, System.UITypes, System.Generics.Collections;


Type

  cmbtHWND = DWORD_PTR; // needed for C++Builder compatibility

  // initialized enum values need to be continued - otherwise they cannot be used directly
  // as designer property, because it will disapear in the designer!
  // Please also see class TEnumTranslater with static translation functions

  TLlExtensionType =(

      Export = LL_LLX_EXTENSIONTYPE_EXPORT,
      Barcode = LL_LLX_EXTENSIONTYPE_BARCODE,
      Obj = LL_LLX_EXTENSIONTYPE_OBJECT,
      Wizard = LL_LLX_EXTENSIONTYPE_WIZARD
   );

 TLlExportOption =(ExportAllInOneFile,
                      ExportFile,
                      ExportPath,
                      ExportTarget,
                      ExportQuiet,
                      ExportShowResult,
                      ExportShowResultAvailable,
                      ExportSendAsMail,
                      ExportSendAsMailAvailable,
                      ExportMailBody,
                      ExportMailHtmlBody,
                      ExportMailAttachmentList,
                      ExportMailSecureConnection,
                      ExportMailSmtpServerTimeOut,
                      ExportMailSmtpServerAddress,
                      ExportMailSmtpServerPort,
                      ExportMailSmtpUser,
                      ExportMailSmtpPassword,
                      ExportMailSmtpProxyType,
                      ExportMailSmtpProxyAddress,
                      ExportMailSmtpProxyPort,
                      ExportMailSmtpProxyUser,
                      ExportMailSmtpProxyPassword,
                      ExportMailSmtpSenderAddress,
                      ExportMailSmtpSenderName,
                      ExportMailSmtpReplyTo,
                      ExportMailSmtpFrom,
                      ExportMailSmtpPopBeforeSmtp,
                      ExportMailSmtpServerUser,
                      ExportMailSmtpServerPassword,
                      ExportMailTo,
                      ExportMailCc,
                      ExportMailBcc,
                      ExportMailProvider,
                      ExportMailSubject,
                      ExportMailShowDialog,
                      ExportMailSendResultAs,
                      ExportSaveAsZip,
                      ExportSaveAsZipAvailable,
                      ExportZipFile,
                      ExportZipPath,
                      ExportOnlyTableData,
                      ExportInfinitePage,
                      ExportSignResult,
                      ExportSignResultAvailable,
                      ExportSignatureProvider,
                      ExportSignatureProviderOption,
                      ExportSignatureFormat,
                      PictureFormat,
                      PictureJpegEncoding,
                      PictureJpegQuality,
                      PictureBitsPerPixel,
                      PictureCropFile,
                      PictureCropFrameWidth,
                      UsePosFrame,
                      VerbosityRectangle,
                      VerbosityBarcode,
                      VerbosityDrawing,
                      VerbosityEllipse,
                      VerbosityLine,
                      VerbosityText,
                      VerbosityTextFrames,
                      VerbosityRtf,
                      VerbosityRtfFrames,
                      VerbosityTable,
                      VerbosityTableCell,
                      VerbosityTableFrames,
                      VerbosityLLXObject,
                      VerbosityLLXObjectHtmlObject,
                      HtmlTitle,
                      HtmlFormHeader,
                      HtmlFormFooter,
                      LayouterPercentaged,
                      LayouterFixedPageHeight,
                      PdfTitle,
                      PdfSubject,
                      PdfKeywords,
                      PdfAuthor,
                      PdfCreator,
                      PdfEncryptionEncryptFile,
                      PdfEncryptionEnablePrinting,
                      PdfEncryptionEnableChanging,
                      PdfEncryptionEnableCopying,
                      PdfOwnerPassword,
                      PdfEncryptionLevel,
                      PdfFontMode,
                      PdfCompressStreamMethod,
                      PdfPdfAMode,
                      PdfDontStackWorldModifications,
                      PdfUserPassword,
                      PdfExcludedFonts,
                      PdfFileAttachments,
                      PdfConformance,
                      Resolution,
                      TxtFrameChar,
                      TxtSeparatorChar,
                      TxtIgnoreGroupLines,
                      TxtIgnoreHeaderFooterLines,
                      TxtCharset,
                      TtyEmulation,
                      TtyDestination,
                      TtyDefaultFilename,
                      TtyAdvanceAfterPrint,
                      TiffCompressionType,
                      TiffCompressionQuality,
                      XlsFontScalingPercentage,
                      XlsPrintingZoom,
                      XlsIgnoreGroupLines,
                      XlsIgnoreHeaderFooterLines,
                      XlsIgnoreLineWrapForDataOnlyExport,
                      XlsConvertNumeric,
                      XlsAllPagesOneSheet,
                      XlsWorksheetName,
                      XlsFileFormat,
                      XlsAutoFit,
                      XmlTitle,
                      XhtmlUseAdvancedCss,
                      XhtmlToolbarType,
                      XhtmlTitle,
                      XhtmlUseSeparateCss,
                      JqmTitle,
                      JqmCDN,
                      JqmListDataFilter,
                      JqmUseDividerLines,
                      JqmBaseTheme,
                      JqmHeaderTheme,
                      JqmDividerTheme,
                      JqmColumnMode,
                      DocxFontScalingPercentage,
                      DocxAllPagesOneFile,
                      DocxCellScalingPercentageHeight,
                      DocxCellScalingPercentageWidth,
                      DocxFloatingTableMode,
                      SvgTitle,
                      PdfZUGFeRDConformanceLevel,
                      PdfZUGFeRDXmlPath,
                      PdfZUGFeRDVersion,
                      PptxFontScalingPercentage,
                      PptxAnimation,
                      ExportMailPop3SocketTimeout,
                      ExportMailPop3SenderDomain,
                      ExportMailPop3ServerPort,
                      ExportMailPop3ServerAddress,
                      ExportMailPop3ServerUser,
                      ExportMailPop3ServerPassword,
                      ExportMailPop3ProxyAddress,
                      ExportMailPop3ProxyPort,
                      ExportMailPop3ProxyUser,
                      ExportMailPop3ProxyPassword,
                      ExportMailXmapiServerUser,
                      ExportMailXmapiServerPassword,
                      ExportMailXmapiSuppressLogonFailure,
                      ExportMailXmapiDeleteAfterSend,
                      ExportMailSignatureName,
                      JsonIndent);

   TLlExportTarget = (Pdf,
                      Html,
                      Rtf,
                      Bitmap,
                      MetaFile,
                      Tiff,
                      MultiTiff,
                      Jpeg,
                      Png,
                      Xls,
                      Xlsx,
                      Docx,
                      Xps,
                      Mhtml,
                      Xhtml,
                      Svg,
                      Jqm,
                      Xml,
                      Text,
                      TextLayout,
                      Tty,
                      Preview,
                      Pptx,
                      Json,
                      unknown);

  TLlAutoBoxType = (btNormalMeter,
                    btBridgeMeter,
                    btNormalwait,
                    btBridgeWait,
                    btEmptyWait,
                    btEmptyAbort,
                    btStandardWait,
                    btStandardAbort,
                    btMarquee,
                    btNone);

  TLlPrintMode = (pmNormal,
                  pmPreview,
                  //pmPreviewControl,
                  pmFile,
                  pmExport,
                  pmMultipleJobs,
                  pmKeepJob);

  TLlProject = (ptLabel,
                ptList,
                ptCard);

  TLlUnits = (uMillimeter_1_1000,
              uMillimeter_1_100,
              uMillimeter_1_10,
              uInch_1_100,
              uInch_1_1000,
              uSysDefault,
              uSysDefaultLoRes,
              uSysDefaultHiRes);


  TLlDebug = (dEnabled,
              dDWG,
              dNoCallbacks,
              dNoStorage,
              dLogToFile,
              dNoSysInfo,
              dPrinterInfo,
              dLicInfo);
  TLlDebugFlags = Set Of TLlDebug;

  TLlTableColoring = (tcListLabel,
                      tcProgram,
                      tcDontCare);

  TLlLanguage = (lDefault,
                 lGerman,
                 lEnglish,
                 //lArabic,
                 //lAfrikaans,
                 //lAlbanian,
                 //lBasque,
                 //lBulgarian,
                 //lByelorussion,
                 //lCatalan,
                 lChinese,
                 //lCroatian,
                 lCzech,
                 //lDanish,
                 lDutch,
                 //lEstonian,
                 //lFaeroese,
                 //lFarsi,
                 //Finnish,
                 lFrench,
                 //lGreek,
                 //lHebrew,
                 //lHungarian,
                 //lIcelandic,
                 //lIndonesian,
                 lItalian,
                 lJapanese,
                 //lKorean,
                 //lLatvian,
                 //lLizhuanian,
                 //lNorwegian,
                 lPolish,
                 lPortuguese,
                 //lRomanian,
                 lRussian,
                 lSlovak,
                 //lSlovenian,
                 //lSerbian,
                 lSpanish
                 //lSwedish,
                 //lThai,
                 //lTurkish,
                 //lUkrainian,
                 //lSerbianLatin,
                 //lChineseTraditional
                 );

 TLlAutoMasterMode = (mmNone,
                      mmAsFields,
                      mmAsVariables);

  TLLCPrintOption    = (poSetupDialog,
                        poExtSetupDialog,
                        poDialogOnPreview,
                        poPrintWithoutBox);

  TLLCDefineMode   = (dmVariable, dmFields);


  TEnumTranslator = class
    public
      class function TranslateAutoBoxType(AutoBoxType: TLlAutoBoxType): Integer; static;
      class function TranslatePrintMode(PrintMode: TLlPrintMode): Integer; static;
      class function TranslateProjectType(ProjectType: TLlProject): Integer; static;
      class function TranslateUnits(Units: TLlUnits): Integer; static;
      class function TranslateDebugFlags(DebugFlags: TLlDebugFlags): Integer; static;
      class function TranslateTableColoring(TableColoring: TLlTableColoring): Integer;
      class function TranslateLanguage(Language: TLlLanguage): Integer;
  End;

  TDataSetScrolledEvent      = procedure (Sender: TObject; Distance: Integer) of object;
  TDataSetRecordChangedEvent = procedure (Sender: TObject; Field: TField) of object;

  TLLDataLink = Class (TDataLink)
  private
    FOnActiveChanged  : TNotifyEvent;
    FOnRecordChanged  : TDataSetRecordChangedEvent;
    FOnDataSetChanged : TNotifyEvent;
    FOnDataSetScrolled: TDataSetScrolledEvent;
    FControl          : TComponent;
  protected
     procedure ActiveChanged; override;
     procedure RecordChanged(Field: TField); override;
     Procedure DataSetChanged; Override;
     procedure DataSetScrolled(Distance: Integer); Override;
  public
    constructor Create;
    property Control: TComponent read FControl write FControl;
    property OnActiveChanged  : TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnRecordChanged  : TDataSetRecordChangedEvent read FOnRecordChanged write FOnRecordChanged;
    property OnDataSetChanged : TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
    property OnDataSetScrolled: TDataSetScrolledEvent read FOnDataSetScrolled write FOnDataSetScrolled;
 end;

  TDetailSourceList = Class;

  TDetailSourceItem = class(TObjTreeNode)
  private
    FName: String;
    FOnSetName      : TNotifyEvent;
    FDataLink       : TLLDataLink;
    FPrimaryKeyField: String;
    FMasterKeyField : String;
    FDetailKeyField : String;
    FSortDescription: String;
    FParentName: String;

    procedure SetName(const Value: string);
    function  GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function  GetMasterSource: TDataSource;
    procedure LoadCompProperty(Reader: TReader);
    procedure StoreCompProperty(Writer: TWriter);
  protected
    function GetOwner: TComponent; reintroduce;
    function GenerateName: string; virtual;
    function GetDisplayName: string; override;
    function GetItem(Index: Integer): TDetailSourceItem;
    procedure SetItem(Index: Integer; Value: TDetailSourceItem);
    procedure AssignTo(Dest: TPersistent); Override;

    procedure DefineProperties(Filer: TFiler); Override;
  Public
    property Owner: TComponent read GetOwner;
    property    OnSetName: TNotifyEvent read FOnSetName write FOnSetName;
    constructor Create(Collection: TCollection); override;
    Destructor  Destroy; Override;
    function Add: TDetailSourceItem; reintroduce;
    function FindItemByName(Const AName: String): TDetailSourceItem;
    property Items[Index: Integer]: TDetailSourceItem read GetItem write SetItem; default;

    Property ParentName: String read FParentName write FParentName; //deprecated
  published
    Property Tag;
    property Name: string read FName write SetName;
    Property DataSource: TDataSource read GetDataSource Write SetDataSource;
    Property PrimaryKeyField: string read FPrimaryKeyField write FPrimaryKeyField;
    Property DetailKeyField: string read FDetailKeyField write FDetailKeyField;
    Property MasterSource: TDataSource read GetMasterSource;
    Property SortDescription: STring read FSortDescription write FSortDescription;
    Property MasterKeyField: string read FMasterKeyField write FMasterKeyField;
    
  End;

  TDetailSourceItemClass = class of TDetailSourceItem;

  TDetailSourceList = Class(TObjTree)
  private
    function GetItem(Index: Integer): TDetailSourceItem;
    procedure SetItem(Index: Integer; Value: TDetailSourceItem);
  protected
    function GetOwner: TComponent; reintroduce;
    Procedure ReorderOldParentName;
    property OwnerComponent: TComponent read GetOwner;
  public
    constructor Create(AOwner: TComponent; ADetailSourceItemClass: TDetailSourceItemClass);
    Destructor Destroy ; override;
    function Add: TDetailSourceItem;
    function ItemByName(Const AName: String): TDetailSourceItem;
    function FindItemByName(Const AName: String): TDetailSourceItem;
    property Items[Index: Integer]: TDetailSourceItem read GetItem write SetItem; default;
  End;

  TLLDataController = Class(TPersistent)
  Private
     FDatasource     : TDataSource;
     FDetailSources  : TDetailSourceList;
     FOwner          : TComponent;
     FSortDescription: String;

     FDataMember: String;
     FAutoMasterMode: TLlAutoMasterMode;

  Private
    procedure SetDataMember(const Value: String);
    procedure SetAutoMasterMode(const Value: TLlAutoMasterMode);

  public
     constructor Create(AOwner: TComponent);
     destructor  Destroy; Override;
     Property Owner: TComponent read FOwner write FOwner;

  Published
     Property DataSource: TDataSource read FDatasource write FDatasource;
     Property SortDescription: STring read FSortDescription write FSortDescription;
     Property DetailSources: TDetailSourceList read FDetailSources write FDetailSources;

     Property DataMember: String read FDataMember write SetDataMember;
     Property AutoMasterMode: TLlAutoMasterMode read FAutoMasterMode write SetAutoMasterMode default TLlAutoMasterMode.mmAsFields;
  End;

  TImageStorage = class(System.Contnrs.TObjectList)
  private
    function GetItem(Index: Integer): TPicture;
    procedure SetItem(Index: Integer; Value: TPicture);
  public
    function AddItem: TPicture;
    property Items[Index: Integer]: TPicture read GetItem write SetItem; default;
  end;

//--------------------------------------------------------------------------------------------------------------------


Resourcestring
  rsInternesDesignerRegisterNil = 'Internes DesignerRegister ist NIL';
  rsInternesReportRegisterNil = 'Internes ReportRegister ist NIL';
  rsInternesControllerRegisterNil = 'Internes ControllerRegister ist NIL';
  rsObjectNil = 'Übergebenes Objekt ist NIL';
  rsNotRegistered = 'Objekt nicht registriert';
  rsDetailSourceAlreadyExists = 'Eine Detail-Source mit dem Namen %s existiert bereits.';

implementation
uses TypInfo, SysUtils;

//==============================================================================
//  TEnumTranslater
//==============================================================================

class function TEnumTranslator.TranslateAutoBoxType(AutoBoxType: TLlAutoBoxType): Integer;
begin

  // pre-define with default value in LL
  Result := LL_BOXTYPE_STDABORT;

  case AutoBoxType of
    TLlAutoBoxType.btNormalMeter: Result := LL_BOXTYPE_NORMALMETER;
    TLlAutoBoxType.btBridgeMeter: Result := LL_BOXTYPE_BRIDGEMETER;
    TLlAutoBoxType.btNormalwait: Result := LL_BOXTYPE_NORMALWAIT;
    TLlAutoBoxType.btBridgeWait: Result := LL_BOXTYPE_BRIDGEWAIT;
    TLlAutoBoxType.btEmptyWait: Result := LL_BOXTYPE_EMPTYWAIT;
    TLlAutoBoxType.btEmptyAbort: Result := LL_BOXTYPE_EMPTYABORT;
    TLlAutoBoxType.btStandardWait: Result := LL_BOXTYPE_STDWAIT;
    TLlAutoBoxType.btStandardAbort: Result := LL_BOXTYPE_STDABORT;
    TLlAutoBoxType.btNone: Result := LL_BOXTYPE_NONE;
    TLlAutoBoxType.btMarquee: Result := 1008;
  end;

end;

class function TEnumTranslator.TranslatePrintMode(PrintMode: TLlPrintMode): Integer;
begin

  // pre-define with default value in LL
  Result := LL_PRINT_EXPORT;

  case PrintMode of
    TLlPrintMode.pmNormal: Result := LL_PRINT_NORMAL;
    TLlPrintMode.pmPreview: Result := LL_PRINT_PREVIEW;
    // TLlPrintMode.pmPreviewControl: Result := 3;
    TLlPrintMode.pmFile: Result := LL_PRINT_FILE;
    TLlPrintMode.pmExport: Result := LL_PRINT_EXPORT;
    TLlPrintMode.pmMultipleJobs: Result := LL_PRINT_MULTIPLE_JOBS;
    TLlPrintMode.pmKeepJob: Result := LL_PRINT_KEEPJOB;
  end;

end;

class function TEnumTranslator.TranslateProjectType(ProjectType: TLlProject): Integer;
begin

  // pre-define with default value in LL
  Result := LL_PROJECT_LIST;

  case ProjectType of
    TLlProject.ptLabel: Result := LL_PROJECT_LABEL;
    TLlProject.ptList: Result := LL_PROJECT_LIST;
    TLlProject.ptCard: Result := LL_PROJECT_CARD;
  end;

end;

class function TEnumTranslator.TranslateTableColoring(TableColoring: TLlTableColoring): Integer;
begin

  // pre-define with default value in LL
  Result := LL_COLORING_LL;

  case TableColoring of
    TLlTableColoring.tcListLabel: Result := LL_COLORING_LL;
    TLlTableColoring.tcProgram: Result := LL_COLORING_PROGRAM;
    TLlTableColoring.tcDontCare: Result := LL_COLORING_DONTCARE;
  end;

end;

class function TEnumTranslator.TranslateDebugFlags(DebugFlags: TLlDebugFlags): Integer;
begin

  // pre-define with default value in LL
  Result := 0;

  if TLlDebug.dEnabled in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTLL;

  end;

  if TLlDebug.dDWG in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTDWG;

  end;

  if TLlDebug.dNoCallbacks in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTLL_NOCALLBACKS;

  end;

  if TLlDebug.dNoStorage in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTLL_NOSTORAGE;

  end;

  if TLlDebug.dLogToFile in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTLL_LOGTOFILE;

  end;

  if TLlDebug.dNoSysInfo in DebugFlags then
  begin

    Result := Result + LL_DEBUG_CMBTLL_NOSYSINFO;

  end;

  if TLlDebug.dPrinterInfo in DebugFlags then
  begin

    Result := Result + LL_DEBUG_PRNINFO;

  end;

  if TLlDebug.dLicInfo in DebugFlags then
  begin

    Result := Result + 512;

  end;

end;

class function TEnumTranslator.TranslateUnits(Units: TLlUnits): Integer;
begin

  // pre-define with default value in LL
  Result := LL_UNITS_SYSDEFAULT;

  case Units of
    TLlUnits.uMillimeter_1_1000: Result := LL_UNITS_MM_DIV_1000;
    TLlUnits.uMillimeter_1_100: Result := LL_UNITS_MM_DIV_100;
    TLlUnits.uMillimeter_1_10: Result := LL_UNITS_MM_DIV_10;
    TLlUnits.uInch_1_100: Result := LL_UNITS_INCH_DIV_100;
    TLlUnits.uInch_1_1000: Result := LL_UNITS_INCH_DIV_1000;
    TLlUnits.uSysDefault: Result := LL_UNITS_SYSDEFAULT;
    TLlUnits.uSysDefaultLoRes: Result := LL_UNITS_SYSDEFAULT_LORES;
    TLlUnits.uSysDefaultHiRes: Result := LL_UNITS_SYSDEFAULT_HIRES;
  end;

end;

class function TEnumTranslator.TranslateLanguage(Language: TLlLanguage): Integer;
begin

  //pre-define with default value in LL
  Result := CMBTLANG_DEFAULT;

  case Language of
    TLlLanguage.lDefault: Result := CMBTLANG_DEFAULT;
    TLlLanguage.lGerman: Result := CMBTLANG_GERMAN;
    TLlLanguage.lEnglish: Result := CMBTLANG_ENGLISH;
    //TLlLanguage.lArabic: Result := CMBTLANG_ARAB;
    //TLlLanguage.lAfrikaans: Result := CMBTLANG_AFRIKAANS;
    //TLlLanguage.lAlbanian: Result := CMBTLANG_ALBANIAN;
    //TLlLanguage.lBasque: Result := CMBTLANG_BASQUE;
    //TLlLanguage.lBulgarian: Result := CMBTLANG_BULGARIAN;
    //TLlLanguage.lByelorussion: Result := CMBTLANG_BYELORUSSIAN;
    //TLlLanguage.lCatalan: Result := CMBTLANG_CATALAN;
    TLlLanguage.lChinese: Result := CMBTLANG_CHINESE;
    //TLlLanguage.lCroatian: Result := CMBTLANG_CROATIAN;
    TLlLanguage.lCzech: Result := CMBTLANG_CZECH;
    //TLlLanguage.lDanish: Result := CMBTLANG_DANISH;
    TLlLanguage.lDutch: Result := CMBTLANG_DUTCH;
    //TLlLanguage.lEstonian: Result := CMBTLANG_ESTONIAN;
    //TLlLanguage.lFaeroese: Result := CMBTLANG_FAEROESE;
    //TLlLanguage.lFarsi: Result := CMBTLANG_FARSI;
    //TLlLanguage.Finnish: Result := CMBTLANG_FINNISH;
    TLlLanguage.lFrench: Result := CMBTLANG_FRENCH;
    //TLlLanguage.lGreek: Result := CMBTLANG_GREEK;
    //TLlLanguage.lHebrew: Result := CMBTLANG_HEBREW;
    //TLlLanguage.lHungarian: Result := CMBTLANG_HUNGARIAN;
    //TLlLanguage.lIcelandic: Result := CMBTLANG_ICELANDIC;
    //TLlLanguage.lIndonesian: Result := CMBTLANG_INDONESIAN;
    TLlLanguage.lItalian: Result := CMBTLANG_ITALIAN;
    TLlLanguage.lJapanese: Result := CMBTLANG_JAPANESE;
    //TLlLanguage.lKorean: Result := CMBTLANG_KOREAN;
    //TLlLanguage.lLatvian: Result := CMBTLANG_LATVIAN;
    //TLlLanguage.lLizhuanian: Result := CMBTLANG_LITHUANIAN;
    //TLlLanguage.lNorwegian: Result := CMBTLANG_NORWEGIAN;
    TLlLanguage.lPolish: Result := CMBTLANG_POLISH;
    TLlLanguage.lPortuguese: Result := CMBTLANG_PORTUGUESE;
    //TLlLanguage.lRomanian: Result := CMBTLANG_ROMANIAN;
    TLlLanguage.lRussian: Result := CMBTLANG_RUSSIAN;
    TLlLanguage.lSlovak: Result := CMBTLANG_SLOVAK;
    //TLlLanguage.lSlovenian: Result := CMBTLANG_SLOVENIAN;
    //TLlLanguage.lSerbian: Result := CMBTLANG_SERBIAN;
    TLlLanguage.lSpanish: Result := CMBTLANG_SPANISH;
    //TLlLanguage.lSwedish: Result := CMBTLANG_SWEDISH;
    //TLlLanguage.lThai: Result := CMBTLANG_THAI;
    //TLlLanguage.lTurkish: Result := CMBTLANG_TURKISH;
    //TLlLanguage.lUkrainian: Result := CMBTLANG_UKRAINIAN;
    //TLlLanguage.lSerbianLatin: Result := CMBTLANG_SERBIAN_LATIN;
    //TLlLanguage.lChineseTraditional: Result := CMBTLANG_CHINESE_TRADITIONAL;
  end;

end;

//==============================================================================
//  TLLDataLink
//==============================================================================

constructor TLLDataLink.Create;
Begin
   Inherited Create;
   VisualControl := True;
end;

procedure TLLDataLink.ActiveChanged;
begin
   //inherited;
   if Assigned(FOnActiveChanged) then FOnActiveChanged(Self);
end;

Procedure TLLDataLink.DataSetChanged;
Begin
//  inherited;
  if Assigned(FOnDataSetChanged) then FOnDataSetChanged(Self);
end;

procedure TLLDataLink.RecordChanged(Field: TField);
begin
   if Assigned(FOnRecordChanged) then FOnRecordChanged(Self,Field);
end;

procedure TLLDataLink.DataSetScrolled(Distance: Integer);
Begin
   //inherited;
   if Assigned(FOnDataSetScrolled) then FOnDataSetScrolled(Self,Distance);
end;

// === TLLDataController ===========================================================================

constructor TLLDataController.Create(AOwner: TComponent);
Begin
  inherited Create;
  FOwner:=AOwner;
  FDetailSources := TDetailSourceList.Create(AOwner, TDetailSourceItem);
  FAutoMasterMode := TLlAutoMasterMode.mmAsFields;
End;

destructor TLLDataController.Destroy;

Begin
  FDetailSources.Clear;

  FDetailSources.Free;
  inherited Destroy;
End;

procedure TLLDataController.SetAutoMasterMode(const Value: TLlAutoMasterMode);
begin
  FAutoMasterMode := Value;
end;

procedure TLLDataController.SetDataMember(const Value: String);
begin
  FDataMember := Value;
end;

// =====================================================================
// TDetailSourcesItem
// =====================================================================
constructor TDetailSourceItem.Create(Collection: TCollection);
Begin
  inherited Create(Collection);

  Collection.BeginUpdate;
  FName := GenerateName;

  OnSetName := UpdateEditorDisplay;

  FDataLink := TLLDataLink.Create;

  Collection.EndUpdate;
End;

destructor TDetailSourceItem.Destroy;
Begin
  FOnSetName := Nil;

  if Assigned(FDataLink) then
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
End;

function TDetailSourceItem.Add: TDetailSourceItem;
begin
  Result := inherited Add as TDetailSourceItem;
end;

function TDetailSourceItem.FindItemByName(Const AName: String): TDetailSourceItem;
var
  I: Integer;
  Temp: TDetailSourceItem;
Begin
  //Item within the entire tree
  Temp := Nil;
  for I := 0 to Count - 1 do
  Begin
    if AnsiCompareText(Self.Items[I].Name, AName) = 0 then
    Begin
      Temp := Self.Items[I];
      Break;
    End
    else begin
      Temp := Self.Items[I].FindItemByName(AName);
      if Temp <> Nil then
      begin
        Break;
      end;
    end;
  End;

  Result := Temp;
end;

function TDetailSourceItem.GetDisplayName: string;
Var
  DS_Name: STring;
begin
  if Assigned(Datasource) then
    DS_Name := Datasource.Name
  else
    DS_Name := 'empty';

  Result := FName + ' [' + DS_Name + ']';

  if Result = '' then
    Result := inherited GetDisplayName;
end;

function TDetailSourceItem.GetItem(Index: Integer): TDetailSourceItem;
Begin
  Result := inherited GetItem(Index) as TDetailSourceItem;
End;

procedure TDetailSourceItem.SetItem(Index: Integer; Value: TDetailSourceItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TDetailSourceItem.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then
  begin
    if Dest is TDetailSourceItem then
    begin
      TDetailSourceItem(Dest).PrimaryKeyField := Self.PrimaryKeyField;
      TDetailSourceItem(Dest).MasterKeyField := Self.MasterKeyField;
      TDetailSourceItem(Dest).DetailKeyField := Self.DetailKeyField;
      TDetailSourceItem(Dest).SortDescription := Self.SortDescription;
      TDetailSourceItem(Dest).Name := Self.Name;
      TDetailSourceItem(Dest).DataSource := Self.DataSource;
    end;
  end;
end;

procedure TDetailSourceItem.LoadCompProperty(Reader: TReader);
Var
  s: String;
begin
  if FParentName = '' then
begin
   s:=Reader.ReadString;
    if s <> '' then
      FParentName := s;
  end;
end;

procedure TDetailSourceItem.StoreCompProperty(Writer: TWriter);
begin
  if FParentName <> '' then
    Writer.WriteString(FParentName);
end;

procedure TDetailSourceItem.DefineProperties(Filer: TFiler);
begin
   inherited; { allow base classes to define properties }
  // deprecated, only available for compatibility reasons
  Filer.DefineProperty('ParentName', LoadCompProperty, StoreCompProperty, (Self.FParentName <> ''));
end;

function TDetailSourceItem.GenerateName: string;
var
  i: Integer;
begin
  i := 0;
  repeat
    Result := 'DetailSource' + IntToStr(i);
    inc(i);
  until TDetailSourceList(Collection).ItemByName(Result) = nil;
end;

function TDetailSourceItem.GetOwner: TComponent;
begin
  result := nil;
  try
    if Collection is TDetailSourceList then
      Result := TDetailSourceList(Collection).OwnerComponent
    else if (Self.GetRootTree is TDetailSourceList) then
      Result := TDetailSourceList(Self.GetRootTree).OwnerComponent;
  except
    Result := nil;
  end;
end;

procedure TDetailSourceItem.SetName(const Value: string);
Begin
  if FName <> Value then
  begin
    if (TDetailSourceList(Collection).ItemByName(Value) <> nil) then
      raise EInvalidOperation.CreateFmt(rsDetailSourceAlreadyExists, [Value]);
    FName := Value;
    Changed(False);
    if Assigned(FOnSetName) then
      FOnSetName(self);
  end;
end;

Function TDetailSourceItem.GetDataSource: TDataSource;
begin
  result := Nil;
  if Assigned(FDataLink.DataSource) then
  Result := FDataLink.Datasource;
end;

Procedure TDetailSourceItem.SetDataSource(Value: TDataSource);
var
  IsLoading: Boolean;
Begin
  IsLoading := False;

  if Self.RootTree <> Nil then
  Begin
    IsLoading := (csLoading in TDetailSourceList(Self.RootTree).OwnerComponent.ComponentState);
  End;

  if not(IsLoading and FDataLink.DataSourceFixed) and (FDataLink.DataSource <> Value) then
    Begin
       FDataLink.Datasource := Value;

    if Assigned(FOnSetName) then
      FOnSetName(Self);
  End;
end;

function TDetailSourceItem.GetMasterSource: TDataSource;
Begin
   if ParentNode<>nil then
      result:=TDetailSourceItem(ParentNode).Datasource
   else
      result:=nil;
End;

// =====================================================================
// TDetailSourcesList = TObjTree
// =====================================================================

constructor TDetailSourceList.Create(AOwner: TComponent; ADetailSourceItemClass: TDetailSourceItemClass);
Begin
  inherited Create(AOwner, ADetailSourceItemClass);
end;

Destructor TDetailSourceList.Destroy;
Begin
  inherited Destroy;
End;

function TDetailSourceList.GetItem(Index: Integer): TDetailSourceItem;
begin
  Result := TDetailSourceItem(inherited GetItem(Index));
end;

procedure TDetailSourceList.SetItem(Index: Integer; Value: TDetailSourceItem);
begin
  inherited SetItem(Index, Value);
end;

function TDetailSourceList.GetOwner: TComponent;
begin
  result := inherited GetOwner as TComponent;
end;

Procedure TDetailSourceList.ReorderOldParentName;
var
  i: Integer;
  PName, MyName: String;
  Element: TDetailSourceItem;
begin
  // Converts the old flat structure to the new tree structure at runtime and in design mode.
  // Only applied to the first level nodes and only if the old property "ParentName" is still present in the DFM.
  for I := (Self.Count - 1) downto 0 do
  begin
    Try
      if (Self.Items[i].ParentName <> '')  then
      begin
        //old entry, must be moved, but only if it has no subentries
        PName := Self.Items[i].ParentName;
        Element := Self.FindItemByName(PName);
        MyName := Self.Items[i].Name;
        if Element <> Nil then
        begin
          if (Element.OwnCollection <> Nil) then
          begin
            Self.Items[i].ParentName := '';
            Self.Items[i].Collection := Element.OwnCollection;
          end;
        end;
      end;
    Except
      on E:exception do
      begin
        if Self.OwnerComponent is TComponent then
        begin
          if MessageDlg('Reorder: ' +MyName + ' on ' +Self.OwnerComponent.ClassName+'.'+TComponent(Self.OwnerComponent).Name+ ': '+E.Message, mtError, mbOKCancel, 0) = mrCancel then
          begin
            Break;
          end;
        end
        else begin
          if MessageDlg('Reorder: ' +MyName + ' on ' +Self.OwnerComponent.ClassName+ ': '+E.Message, mtError, mbOKCancel, 0) = mrCancel then
          begin
            Break;
          end;
        end;
      end;
    End;
  end;
end;

function TDetailSourceList.Add: TDetailSourceItem;
begin
  Result := TDetailSourceItem(inherited Add);
end;

function TDetailSourceList.ItemByName(Const AName: String): TDetailSourceItem;
var
  i: Integer;
begin
  //Item within your own collection
  result := nil;
  for I := 0 to Count - 1 do
  Begin
    if AnsiCompareText(Items[I].Name, AName) = 0 then
    Begin
      result := Items[I];
      Break;
    End;
  End;
end;

function TDetailSourceList.FindItemByName(Const AName: String): TDetailSourceItem;
var
  I: Integer;
  Temp: TDetailSourceItem;
begin
  //Item within the entire tree
  Temp := Nil;
  for i := 0 to Count - 1 do
  Begin
    if AnsiCompareText(Items[i].Name, AName) = 0 then
    Begin
      Temp := Items[I];
      Break;
    End
    else begin
      Temp := Items[I].FindItemByName(AName);
      if Temp <> Nil then
      begin
      Break;
    End;
  End;
end;

  Result := Temp;
end;

// =====================================================================
// TImageStorage
// =====================================================================

function TImageStorage.GetItem(Index: Integer): TPicture;
begin
  Result := TPicture(inherited GetItem(Index));
end;

procedure TImageStorage.SetItem(Index: Integer; Value: TPicture);
Begin
  inherited SetItem(Index, Value);
End;

function TImageStorage.AddItem: TPicture;
var
  APicture: TPicture;
Begin
  APicture := TPicture.Create;
  inherited Add(APicture);
  Result := APicture;
End;

end.
