{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLReport_Types.pas
 Module : LLReport_Types.pas
 Descr. : Implementation file for the List & Label 30 VCL-Component
 Version: 30.000
==================================================================================
}

unit LLReport_Types;

interface
{$WEAKPACKAGEUNIT ON}
Uses
  Windows, Classes, DB, Graphics, ObjTree, System.Contnrs, cmbtll30x, Dialogs, System.UITypes;

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
					  PdfEncryptionEnableFillingForms,
					  PdfEncryptionEnableAnnotating,
                      PdfOwnerPassword,
                      PdfEncryptionLevel,
                      PdfCompressStreamMethod,
                      PdfUserPassword,
                      PdfExcludedFonts,
                      PdfFileAttachments,
                      PdfConformance,
					  PdfUseSimpleFrames,
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
                      JsonIndent,
                      DocxAuthor,
                      DocxTitle,
                      DocxKeywords,
                      DocxSubject,
                      XhtmlEnableAccessibility,
                      XhtmlFixedHeader,
                      XlsAutoFormula,
                      XlsProtectionProtectSheets,
                      XlsProtectionProtectSheetsPassword,
                      XlsProtectionProtectSheetsMode,
                      XlsHeaderContent,
                      XlsHeaderMargin,
                      XlsFooterContent,
                      XlsFooterMargin,
                      ExportMailGraphAuthType,
                      ExportMailGraphClientId,
                      ExportMailGraphTenantId,
                      ExportMailGraphScope,
                      ExportMailGraphRedirectUri,
                      ExportMailGraphSecretClientKeyId,
                      ExportMailGraphSecretClientKeyValue,
                      ExportMailGraphUserName,
                      ExportMailGraphUserObjectId,
                      ExportMailGraphUserPassword,
                      ExportMailGraphBearerToken,
                      ExportMailSmtpOAuth2BearerToken
                      );

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
                      Json);

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

  TLlProject = (ptUnknown = 0,
                ptLabel = LL_PROJECT_LABEL,
                ptList = LL_PROJECT_LIST,
                ptCard = LL_PROJECT_CARD);

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
                 //lByelorussian,
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
                 //lLithuanian,
                 //lNorwegian,
                 //lPolish,
                 lPortuguese,
                 //lRomanian,
                 //lRussian,
                 lSlovak,
                 //lSlovenian,
                 //lSerbian,
                 lSpanish
                 //lSwedish,
                 //lThai,
                 //lTurkish,
                 //lUkrainian,
                 //lSerbianLatin,
                 //lChineseTraditional,
                 //lPortugueseBrazilian,
                 //lSpanishColombia
                 );

 TLlAutoMasterMode = (mmNone,
                      mmAsFields,
                      mmAsVariables);

  TLLCPrintOption    = (poSetupDialog,
                        poExtSetupDialog,
                        poDialogOnPreview,
                        poPrintWithoutBox);

  TLLCDefineMode   = (dmVariable, dmFields);

  TLlPrintOption   =(
        Copies = LL_PRNOPT_COPIES,
        StartPage = LL_PRNOPT_STARTPAGE,
        Page = LL_PRNOPT_PAGE,
        Offset = LL_PRNOPT_OFFSET,
        Copies_Supported = LL_PRNOPT_COPIES_SUPPORTED,
        Units = LL_PRNOPT_UNITS,
        FirstPage = LL_PRNOPT_FIRSTPAGE,
        LastPage = LL_PRNOPT_LASTPAGE,
        JobPages = LL_PRNOPT_JOBPAGES,
        PrintOrder = LL_PRNOPT_PRINTORDER,
        PrintOrder_Printer1 = 9,
        PrintOrder_Printer2 = 10,
        DefaultPrinterInstalled = LL_PRNOPT_DEFPRINTERINSTALLED,
        Dialog_DestinationMask = LL_PRNOPT_PRINTDLG_DESTMASK,
        Dialog_Destination = LL_PRNOPT_PRINTDLG_DEST,
        Dialog_OnlyPrinterCopies = LL_PRNOPT_PRINTDLG_ONLYPRINTERCOPIES,
        UseMemoryMetafile = LL_PRNOPT_USEMEMORYMETAFILE,
        PageIndex = 18
    );

  TLlOption =(
        NewExpressions = LL_OPTION_NEWEXPRESSIONS,
        OnlyOneTable = LL_OPTION_ONLYONETABLE,
        TableColoring = LL_OPTION_TABLE_COLORING,
        SuperVisor = LL_OPTION_SUPERVISOR,
        OptionUnits = LL_OPTION_UNITS,
        TabStops = LL_OPTION_TABSTOPS,
        CallbackMask = LL_OPTION_CALLBACKMASK,
        CallbackParameter = LL_OPTION_CALLBACKPARAMETER,
        HelpAvailable = LL_OPTION_HELPAVAILABLE,
        SortVariables = LL_OPTION_SORTVARIABLES,
        SupportPagebreak = LL_OPTION_SUPPORTPAGEBREAK,
        ShowPredefinedVariables = LL_OPTION_SHOWPREDEFVARS,
        UseHostprinter = LL_OPTION_USEHOSTPRINTER,
        ExtendedEvaluation = LL_OPTION_EXTENDEDEVALUATION,
        TabRepresentationCode = LL_OPTION_TABREPRESENTATIONCODE,
        Metric = LL_OPTION_METRIC,
        AddVarsToFields = LL_OPTION_ADDVARSTOFIELDS,
        ConvertCRLF = LL_OPTION_CONVERTCRLF,
        Wizard_FileNew = LL_OPTION_WIZ_FILENEW,
        ReturnRepresentationCode = LL_OPTION_RETREPRESENTATIONCODE,
        Preview_Zoom_Percent = LL_OPTION_PRVZOOM_PERC,
        Preview_RectLeft = LL_OPTION_PRVRECT_LEFT,
        Preview_RectTop = LL_OPTION_PRVRECT_TOP,
        Preview_RectWidth = LL_OPTION_PRVRECT_WIDTH,
        Preview_RectHeight = LL_OPTION_PRVRECT_HEIGHT,
        StorageSystem = LL_OPTION_STORAGESYSTEM,
        CompressStorage = LL_OPTION_COMPRESSSTORAGE,
        NoParameterCheck = LL_OPTION_NOPARAMETERCHECK,
        NoNoTableCheck = LL_OPTION_NONOTABLECHECK,
        DrawFooterLineOnPrint = LL_OPTION_DRAWFOOTERLINEONPRINT,
        Preview_Zoom_Left = LL_OPTION_PRVZOOM_LEFT,
        Preview_Zoom_Top = LL_OPTION_PRVZOOM_TOP,
        Preview_Zoom_Width = LL_OPTION_PRVZOOM_WIDTH,
        Preview_Zoom_Height = LL_OPTION_PRVZOOM_HEIGHT,
        SpaceOptimization = LL_OPTION_SPACEOPTIMIZATION,
        Realtime = LL_OPTION_REALTIME,
        AutoMultiPage = LL_OPTION_AUTOMULTIPAGE,
        UseBarcodeSizes = LL_OPTION_USEBARCODESIZES,
        MaxRtfVersion = LL_OPTION_MAXRTFVERSION,
        VarsCaseSensitive = LL_OPTION_VARSCASESENSITIVE,
        DelayTableHeader = LL_OPTION_DELAYTABLEHEADER,
        EmfResolution = LL_OPTION_EMFRESOLUTION,
        SetCreationInfo = LL_OPTION_SETCREATIONINFO,
        XlatVarnames = LL_OPTION_XLATVARNAMES,
        TranslationFlags = LL_OPTION_TRANSLATIONFLAGS,
        PhantomspaceRepresentationCode = LL_OPTION_PHANTOMSPACEREPRESENTATIONCODE,
        LockNextCharRepresentationCode = LL_OPTION_LOCKNEXTCHARREPRESENTATIONCODE,
        ExpressionSeparatorRepresentationCode = LL_OPTION_EXPRSEPREPRESENTATIONCODE,
        OptionDefaultPrinterInstalled = LL_OPTION_DEFPRINTERINSTALLED,
        NoFooterPagewrap = LL_OPTION_NOFOOTERPAGEWRAP,
        ImmediateLastpage = LL_OPTION_IMMEDIATELASTPAGE,
        LCID = LL_OPTION_LCID,
        TextquoteRepresentationCode = LL_OPTION_TEXTQUOTEREPRESENTATIONCODE,
        DefaultDefaultFont = LL_OPTION_DEFDEFFONT,
        Codepage = LL_OPTION_CODEPAGE,
        ForceFontCharset = LL_OPTION_FORCEFONTCHARSET,
        CompressRtf = LL_OPTION_COMPRESSRTF,
        AllowLlxExporters = LL_OPTION_ALLOW_LLX_EXPORTERS,
        Supports_PRNOPSTR_Export = LL_OPTION_SUPPORTS_PRNOPTSTR_EXPORT,
        DebugFlag = LL_OPTION_DEBUGFLAG,
        SkipReturnAtEndOfRtf = LL_OPTION_SKIPRETURNATENDOFRTF,
        InterCharSpacing = LL_OPTION_INTERCHARSPACING,
        IncludeFontDescent = LL_OPTION_INCLUDEFONTDESCENT,
        ResolutioncompatibleTo9x = LL_OPTION_RESOLUTIONCOMPATIBLETO9X,
        UseChartFields = LL_OPTION_USECHARTFIELDS,
        OpenFileDialog_NoPlacesBar = LL_OPTION_OFNDIALOG_NOPLACESBAR,
        SketchColorDepth = LL_OPTION_SKETCH_COLORDEPTH,
        LLXInterface = 53,
        UIStyle = LL_OPTION_UISTYLE,
        NoFileVersionUpgradeWarning = LL_OPTION_NOFILEVERSIONUPGRADEWARNING,
        ScalableFontsOnly = LL_OPTION_SCALABLEFONTSONLY,
        NoPrintJobSupervision = LL_OPTION_NOPRINTJOBSUPERVISION,
        ProhibitUserInteraction = LL_OPTION_PROHIBIT_USERINTERACTION,
        EscClosesPreview = LL_OPTION_ESC_CLOSES_PREVIEW,
        IncrementalPreview = LL_OPTION_INCREMENTAL_PREVIEW,
        NoPrinterPathCheck = 137, // LL_OPTION_NOPRINTERPATHCHECK (137)
        CalcSumVarsOnPartialLines = LL_OPTION_CALC_SUMVARS_ON_PARTIAL_LINES,
        NoAutoPropertyCorrection = LL_OPTION_NOAUTOPROPERTYCORRECTION,
        DesignerPreviewParameter = LL_OPTION_DESIGNERPREVIEWPARAMETER,
        DesignerExportParameter = LL_OPTION_DESIGNEREXPORTPARAMETER,
        Reserved = LL_OPTION_SKETCH_COLORDEPTH,
        DesignerPrintSingleThreaded = LL_OPTION_DESIGNERPRINT_SINGLETHREADED,
        DrillDownParameter = 162,
        RoundingStrategy = 163,
        CalcSumVarsOnInvisibleLines = LL_OPTION_CALCSUMVARSONINVISIBLELINES,
        RibbonDefaultEnabledState = 217,
        AllowCombinedCollectingOfDataForCollectionControls = 222,
        SuppressLoadErrorMessages = LL_OPTION_SUPPRESS_LOADERRORMESSAGES,
        ReportParameterJobParameter = 234, //LL_OPTION_RP_REALDATAJOBPARAMETER
        ExpandableRegionsJobParameter = 235, //LL_OPTION_EXPANDABLE_REGIONS_REALDATAJOBPARAMETER
        InteractiveSortingJobParameter = 237, // LL_OPTION_INTERACTIVESORTING_REALDATAJOBPARAMETER
        DataproviderThreadedness = 257, // LL_OPTION_DATAPROVIDER_THREADEDNESS
        ScriptingEngineEnabled = 276, // LL_OPTION_SCRIPTENGINE_ENABLED
        ScriptingEngineTimeoutMs = 277, // LL_OPTION_SCRIPTENGINE_TIMEOUTMS
        ScriptingEngineAutoExecute = 278, // LL_OPTION_SCRIPTENGINE_AUTOEXECUTE
        ProjectBackup = LL_OPTION_PROJECTBACKUP,
        PrintedRecordsCount = LL_OPTION_COUNTALLPRINTEDDATA_LASTPRINT,
        /// <summary>Customize the auto recovery dialogue by providing a combination of supported modes (combine flags of <see cref="LlAutoRecoveryOption"/>).</summary>
        AutoRecoverySaveOptions = LL_OPTION_AUTORECOVERY_SAVEOPTIONS,
        /// <summary>For report parameter choices from the data source, this option lets the designer show only distinct display values (instead of removing duplicates from the real values only).</summary>
        ForceUniqueReportParameterDisplayValues = LL_OPTION_FORCE_UNIQUE_PARAMETERUISTRING,
        /// <summary>Use flags (0x1: Designer, 0x2: Preview Window) to decide where to match the physical size on screen. Requires Win 8.1 or newer.</summary>
        PreviewScalesRelativeToPhysicalSize = 316, // LL_OPTION_PREVIEW_SCALES_RELATIVE_TO_PHYSICAL_SIZE
        /// <summary>Use flags (0x1: Main variable/fields window, 0x2: variable treeview in fuction wizard) to enable or disable the filter edit control. Default: all enabled.</summary>
        TreeviewFilterVisibilityFlags = 318, // LL_OPTION_TREEVIEWFILTER_VISIBILITYFLAGS
        /// <summary>Limits the recursion depth when searching in the variable tree when tables have cyclic relations.</summary>
        TreeviewFilterMaximumRecursionDepth = 320,  // LL_OPTION_TREEVIEWFILTER_MAXIMUM_RECURSION_SEARCH_DEPTH
        GetCurrentProjectType = 328, // LL_OPTION_GET_CURRENT_PROJECTTYPE   returns the project type of the currently loaded project (list/card/label) or LL_ERR_NOPROJECT
        ImprovedTableLineAnchoring = 236, // LL_OPTION_IMPROVED_TABLELINEANCHORING
        SaveProjectInUtf8 = 178, // LL_OPTION_SAVE_PROJECT_IN_UTF8 (178) /* BOOL, default 0 (meaning: project is saved as UNICODE if A API is not used) */
        Printerless = 375,
		UseSimpleWindowsPenStyleFrameDrawing = 389, // LL_OPTION_USESIMPLEWINDOWSPENSTYLE_FRAMEDRAWING (389) /* default: false */
		UseSvg2Bmp = LL_OPTION_USE_SVG2BMP,
		MultiSectionPrintMerge = LL_OPTION_MULTISECTIONPRINT_MERGE
	); 

  TExportEnumHelper = class
  public

    class function GetExportOptionString(const exportOption: TLlExportOption): string; static;
    class function GetTargetFromString(const target: string): TLlExportTarget; static;
    class function GetExtensionFromExportTarget(exportTarget: TLlExportTarget): string; static;
    class function GetString(exportTarget: TLlExportTarget): string; static;

  end;

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
//  TExportEnumHelper
//==============================================================================

class function TExportEnumHelper.GetExportOptionString(const exportOption: TLlExportOption): string;
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
      PdfUseSimpleFrames:
                          result:= 'PDF.UseSimpleFrames';
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
      DocxAuthor:
                          result := 'DOCX.Author';
      DocxTitle:
                          result := 'DOCX.Title';
      DocxKeywords:
                          result := 'DOCX.Keywords';
      DocxSubject:
                          result := 'DOCX.Subject';
      XhtmlFixedHeader:
                          result := 'XHTML.FixedHeader';
      XhtmlEnableAccessibility:
                          result := 'XHTML.EnableAccessibility';
      XlsAutoFormula:
                          result := 'XLS.AutoFormula';
      XlsProtectionProtectSheets:
                          result := 'XLS.Protection.ProtectSheets';
      XlsProtectionProtectSheetsPassword:
                          result := 'XLS.Protection.ProtectSheetsPassword';
      XlsProtectionProtectSheetsMode:
                          result := 'XLS.Protection.ProtectSheetsMode';
      XlsHeaderContent:
                          result := 'XLS.HeaderContent';
      XlsHeaderMargin:
                          result := 'XLS.HeaderMargin';
      XlsFooterContent:
                          result := 'XLS.FooterContent';
      XlsFooterMargin:
                          result := 'XLS.FooterMargin';
      ExportMailGraphAuthType:
                          result := 'Export.Mail.Graph.AuthType';
      ExportMailGraphClientId:
                          result := 'Export.Mail.Graph.ClientId';
      ExportMailGraphTenantId:
                          result := 'Export.Mail.Graph.TenantId';
      ExportMailGraphScope:
                          result := 'Export.Mail.Graph.Scope';
      ExportMailGraphRedirectUri:
                          result := 'Export.Mail.Graph.RedirectUri';
      ExportMailGraphSecretClientKeyId:
                          result := 'Export.Mail.Graph.SecretClientKeyId';
      ExportMailGraphSecretClientKeyValue:
                          result := 'Export.Mail.Graph.SecretClientKeyValue';
      ExportMailGraphUserName:
                          result := 'Export.Mail.Graph.UserName';
      ExportMailGraphUserObjectId:
                          result := 'Export.Mail.Graph.UserObjectId';
      ExportMailGraphUserPassword:
                          result := 'Export.Mail.Graph.UserPassword';
      ExportMailGraphBearerToken:
                          result := 'Export.Mail.Graph.BearerToken';
      ExportMailSmtpOAuth2BearerToken:
                          result := 'Export.Mail.SMTP.OAUTH2.BearerToken';
    else
                          result:= '';
    end;

end;

class function TExportEnumHelper.GetTargetFromString(const target: string): TLlExportTarget;
begin

  if UpperCase(target) = 'HTML5' then
    Result := TLlExportTarget.Pdf
  else if UpperCase(target) = 'PDF' then
    Result := TLlExportTarget.Pdf
  else if UpperCase(target) = 'HTML' then
    Result := TLlExportTarget.Html
  else if UpperCase(target) = 'RTF' then
    Result := TLlExportTarget.Rtf
  else if UpperCase(target) = 'PICTURE_BMP' then
    Result := TLlExportTarget.Bitmap
  else if UpperCase(target) = 'PICTURE_EMF' then
    Result := TLlExportTarget.MetaFile
  else if UpperCase(target) = 'PICTURE_TIFF' then
    Result := TLlExportTarget.Tiff
  else if UpperCase(target) = 'PICTURE_MULTITIFF' then
    Result := TLlExportTarget.MultiTiff
  else if UpperCase(target) = 'PICTURE_JPEG' then
    Result := TLlExportTarget.Jpeg
  else if UpperCase(target) = 'PICTURE_PNG' then
    Result := TLlExportTarget.Png
  else if UpperCase(target) = 'XLS' then
    Result := TLlExportTarget.Xls
  else if UpperCase(target) = 'XLSX' then
    Result := TLlExportTarget.Xlsx
  else if UpperCase(target) = 'DOCX' then
    Result := TLlExportTarget.Docx
  else if UpperCase(target) = 'XPS' then
    Result := TLlExportTarget.Xps
  else if UpperCase(target) = 'MHTML' then
    Result := TLlExportTarget.Mhtml
  else if UpperCase(target) = 'XHTML' then
    Result := TLlExportTarget.Xhtml
  else if UpperCase(target) = 'SVG' then
    Result := TLlExportTarget.Svg
  else if UpperCase(target) = 'JQM' then
    Result := TLlExportTarget.Jqm
  else if UpperCase(target) = 'XML' then
    Result := TLlExportTarget.Xml
  else if UpperCase(target) = 'TXT' then
    Result := TLlExportTarget.Text
  else if UpperCase(target) = 'TXT_LAYOUT' then
    Result := TLlExportTarget.TextLayout
  else if UpperCase(target) = 'TTY' then
    Result := TLlExportTarget.Tty
  else if UpperCase(target) = 'PRV' then
    Result := TLlExportTarget.Preview
  else if UpperCase(target) = 'PPTX' then
    Result := TLlExportTarget.Pptx
  else if UpperCase(target) = 'JSON' then
    Result := TLlExportTarget.Json
  else
    raise Exception.Create(target + ' is an unknown export target');

end;

class function TExportEnumHelper.GetExtensionFromExportTarget(exportTarget: TLlExportTarget): string;
begin
  case exportTarget of
    TLlExportTarget.Pdf:
      Result := 'pdf';
    TLlExportTarget.Html, TLlExportTarget.Xhtml, TLlExportTarget.Jqm:
      Result := 'htm';
    TLlExportTarget.Rtf:
      Result := 'rtf';
    TLlExportTarget.Bitmap:
      Result := 'bmp';
    TLlExportTarget.MetaFile:
      Result := 'emf';
    TLlExportTarget.Tiff, TLlExportTarget.MultiTiff:
      Result := 'tif';
    TLlExportTarget.Jpeg:
      Result := 'jpg';
    TLlExportTarget.Png:
      Result := 'png';
    TLlExportTarget.Xls:
      Result := 'xls';
    TLlExportTarget.Xlsx:
      Result := 'xlsx';
    TLlExportTarget.Docx:
      Result := 'docx';
    TLlExportTarget.Xps:
      Result := 'xps';
    TLlExportTarget.Mhtml:
      Result := 'mhtml';
    TLlExportTarget.Xml:
      Result := 'xml';
    TLlExportTarget.Text, TLlExportTarget.TextLayout:
      Result := 'txt';
    TLlExportTarget.Tty:
      Result := 'tty';
    TLlExportTarget.Preview:
      Result := 'll';
    TLlExportTarget.Svg:
      Result := 'svg';
    TLlExportTarget.Pptx:
      Result := 'pptx';
    TLlExportTarget.Json:
      Result := 'json';
    else
      Result := '';
  end;
end;

class function TExportEnumHelper.GetString(exportTarget: TLlExportTarget): string;
begin
  case exportTarget of
    TLlExportTarget.Pdf:
      Result := 'PDF';
    TLlExportTarget.Html:
      Result := 'HTML';
    TLlExportTarget.Rtf:
      Result := 'RTF';
    TLlExportTarget.Bitmap:
      Result := 'PICTURE_BMP';
    TLlExportTarget.MetaFile:
      Result := 'PICTURE_EMF';
    TLlExportTarget.Tiff:
      Result := 'PICTURE_TIFF';
    TLlExportTarget.MultiTiff:
      Result := 'PICTURE_MULTITIFF';
    TLlExportTarget.Jpeg:
      Result := 'PICTURE_JPEG';
    TLlExportTarget.Png:
      Result := 'PICTURE_PNG';
    TLlExportTarget.Xls, TLlExportTarget.Xlsx:
      Result := 'XLS';
    TLlExportTarget.Docx:
      Result := 'DOCX';
    TLlExportTarget.Xps:
      Result := 'XPS';
    TLlExportTarget.Mhtml:
      Result := 'MHTML';
    TLlExportTarget.Xhtml:
      Result := 'XHTML';
    TLlExportTarget.Jqm:
      Result := 'JQM';
    TLlExportTarget.Xml:
      Result := 'XML';
    TLlExportTarget.Text:
      Result := 'TXT';
    TLlExportTarget.TextLayout:
      Result := 'TXT_LAYOUT';
    TLlExportTarget.Tty:
      Result := 'TTY';
    TLlExportTarget.Preview:
      Result := 'PRV';
    TLlExportTarget.Svg:
      Result := 'SVG';
    TLlExportTarget.Pptx:
      Result := 'PPTX';
    TLlExportTarget.Json:
      Result := 'JSON';
    else
      Result := '';
  end;
end;

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
    //TLlLanguage.lByelorussian: Result := CMBTLANG_BYELORUSSIAN;
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
    //TLlLanguage.lLithuanian: Result := CMBTLANG_LITHUANIAN;
    //TLlLanguage.lNorwegian: Result := CMBTLANG_NORWEGIAN;
    //TLlLanguage.lPolish: Result := CMBTLANG_POLISH;
    TLlLanguage.lPortuguese: Result := CMBTLANG_PORTUGUESE;
    //TLlLanguage.lRomanian: Result := CMBTLANG_ROMANIAN;
    //TLlLanguage.lRussian: Result := CMBTLANG_RUSSIAN;
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
    //TLlLanguage.lPortugueseBrazilian: Result := CMBTLANG_PORTUGUESE_BRAZILIAN;
    //TLlLanguage.lSpanishColombia: Result := CMBTLANG_SPANISH_COLOMBIA;
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
