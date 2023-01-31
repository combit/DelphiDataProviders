(* Pascal/Delphi runtime linkage constants and function definitions for LL28.DLL *)
(*  (c) combit GmbH *)
(*  [build of 2023-01-18 09:01:37] *)

unit cmbtLL28x;

{$if CompilerVersion > 12}
{$define ADOAVAILABLE}
{$ifend}

{$if CompilerVersion > 19}
{$define UNICODESTRING_AWARE}
{$define UNICODE}
{$define USE_UNICODE_DLL}
{$ifend}

{$ifdef WIN64}
{$A16}
{$else}
{$A+}
{$endif}

interface

uses windows
  , messages { hint: delete 'messages' for Pascal up to 7.x }
             { hint: if you get problems with 'activex' and Delphi < 3, use 'ole2' instead }
  , activex
  ;


type
{$ifdef UNICODE}
  TChar      = WChar;
  pTChar     = pWChar;
{$else}
  TChar      = char;
  pTChar     = pChar;
{$endif}
  pTRect     = ^TRECT;

(* type declarations *)

  HJOB                           = integer;
  HLLJOB                         = integer;
  HLLDOMOBJ                      = pChar;
  PHLLDOMOBJ                     = ^pChar;
  HLLEXPR                        = pChar;
  HLLINTERF                      = pChar;
  HSTG                           = lParam;
  HLLSTG                         = lParam;
  HLLRTFOBJ                      = lParam;
  _PRECT                         = ^tRect;
  _PCRECT                        = ^tRect;
  HLISTPOS                       = lParam;
  _LPHANDLE                      = ^tHandle;
  _LPINT                         = ^integer;
  _LPUINT                        = ^cardinal;
  _LCID                          = cardinal;
  _PBOOL                         = ^longbool;
  PHGLOBAL                       = ^tHandle;
  LLPUINT                        = ^cardinal;
  PVARIANT                       = ^VARIANT;
  PCVARIANT                      = ^VARIANT;
  _PDEVMODE                      = ^TDEVICEMODE;
  _PDEVMODEA                     = ^TDEVICEMODEA;
  _PDEVMODEW                     = ^TDEVICEMODEW;
  _PCDEVMODE                     = ^TDEVICEMODE;
  _PCDEVMODEA                    = ^TDEVICEMODEA;
  _PCDEVMODEW                    = ^TDEVICEMODEW;
  PSCLLCOLUMN                    = ^scLlColumn;
  CTL_GUID                       = tGUID;
  CTL_PGUID                      = ^tGUID;
  PIUNKNOWN                      = ^IUnknown;
  PPIUNKNOWN                     = ^PIUNKNOWN;
  _LPINTJAVADUMMY                = ^integer;
  _PUINT8                        = ^byte;
  _PCUINT8                       = ^byte;
  _PISTREAM                      = ^IStream;
  HLLTESTJOB                     = pChar;

 
 
 scLlCallback = record
  _nSize: integer;    (* size of the structure *)
  _lParam: lParam;    (* parameter (most likely address of structure) *)
  _lReply: lParam;    (* reply (defaults to 0) *)
   _lUserParameter: lParam;        (* user parameter *)
  end;
 PSCLLCALLBACK = ^scLlCallback;
 
 scLlMeterInfo = record
  _nSize: integer;    (* size of the structure *)
  _hWnd_: HWND;     (* L&L mainframe wnd *)
  _nTotal: cardinal;    (* total count of objects *)
  _nCurrent: cardinal;   (* current object number (0=start,...,total=end) *)
  _nJob: cardinal;    (* LL_METERINFO_... constants *)
  end;
 PSCLLMETERINFO = ^scLlMeterInfo;
 
 scLlExtFct = record
  _nSize: integer;       (* size of the structure *)
  _pszContents: pTchar;   (* contents of the parameter string (do not overwrite!!!) *)
  _bEvaluate: longbool;       (* TRUE on evaluation, FALSE on syntax check (fill _bError, _szError)! *)
   _szNewValue:array[0..$4000] of Tchar; (* new value *)
   _bError: integer;    (* FALSE *)
  _szError: array[0..127] of Tchar;(* error text *)
  end;
 PSCLLEXTFCT = ^scLlExtFct;
 
 scLlObject = record
  _nSize: integer;    (* size of the structure *)
  _pszName: pTchar;    (* name of the object *)
  _nType: integer;    (* LL_OBJ_.... constant *)
  _bPreDraw: longbool;    (* TRUE on call before draw, FALSE on call afterwards *)
  _hRefDC: hdc;       (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  _rcPaint: trect;    (* RECT in paint units (mm/10 or inch/100) *)
  end;
 PSCLLOBJECT = ^scLlObject;
 
 scLlPage = record
  _nSize: integer;    (* size of the structure *)
  _bDesignerPreview: longbool;  (* flag whether in preview or not *)
  _bPreDraw: longbool;    (* TRUE on call before draw, FALSE on call afterwards *)
  _hRefDC: hdc;     (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  end;
 PSCLLPAGE = ^scLlPage;
 
 scLlProject = record
  _nSize: integer;    (* size of the structure *)
  _bDesignerPreview: longbool;  (* flag whether in preview or not *)
  _bPreDraw: longbool;    (* TRUE on call before draw, FALSE on call afterwards *)
  _hRefDC: hdc;     (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  _rcPaint: trect;    (* RECT in paint units (mm/10 or inch/100) *)
  end;
 PSCLLPROJECT = ^scLlProject;
 
 scLlDrawUserObj = record
  _nSize: integer;    (* size of the structure *)
  _pszName: pTchar;    (* name of the variable *)
  _pszContents: pTchar;   (* contents of the variable (valid if def´d by VariableExt()) *)
  _lPara: lParam;     (* lPara of the variable *)
  _lpPtr: pchar;     (* lpPtr of the variable *)
  _hPara: thandle;    (* hContents of the variable (valid if def´d by VariableExtHandle()) *)
  _bIsotropic: longbool;    (* "Isotropic" flag *)
  _pszParameters: pTchar;   (* parameters (for USERDWGEDITABLE objects) *)
  _hRefDC: hdc;      (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  _rcPaint: trect;    (* RECT in paint units (mm/10 or inch/100) *)
   _nPaintMode: integer;   (* 0: Preview, 1: FastPreview, 2: Workspace (NYI) *)
  end;
 PSCLLDRAWUSEROBJ = ^scLlDrawUserObj;
 
 scLlEditUserObj = record
  _nSize: integer;    (* size of the structure *)
  _pszName: pTchar;    (* name of the variable *)
  _lPara: lParam;     (* lPara of the variable *)
  _lpPtr: pTchar;     (* lpPtr of the variable *)
  _hPara: thandle;    (* hContents of the variable (valid if def´d by VariableExtHandle()) *)
  _bIsotropic: longbool;    (* "Isotropic" flag *)
  _hWnd: hWnd;     (* parent window for dialog *)
  _pszParameters: pTchar;   (* parameter buffer *)
  _nParaBufSize: integer;   (* size of buffer *)
  end;
 PSCLLEDITUSEROBJ = ^scLlEditUserObj;
 
 scLlTableLine = record
  _nSize: integer;    (* size of the structure *)
  _nType: integer;    (* LL_TABLE_LINE_xxx constant *)
  _hRefDC: hdc;      (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  _rcPaint: tRect;    (* RECT in paint units (mm/10 or inch/100) *)
  _nPageLine: integer;      (* number of line on page *)
  _nLine: integer;    (* absolute number of line in table *)
  _bZebra: longbool;     (* zebra mode selected by user? *)
  _rcSpacing: tRect;    (* spaces around the frame *)
  end;
 PSCLLTABLELINE = ^scLlTableLine;
 
 scLlTableField = record
  _nSize: integer;    (* size of the structure *)
  _nType: integer;    (* LL_TABLE_FIELD_xxx constant *)
  _hRefDC: hdc;      (* HDC to get information from *)
  _hPaintDC: hdc;       (* HDC to paint on *)
  _rcPaint: tRect;    (* RECT in paint units (mm/10 or inch/100) *)
  _nLineDef: integer;       (* line definition index *)
  _nIndex: integer;       (* column index (0..) *)
  _rcSpacing: tRect;    (* spaces around the frame *)
  _pszContents: pTchar;
  _hContents: THandle;
  end;
 PSCLLTABLEFIELD = ^scLlTableField;
 
 scLlColumn = record
  _nSize: integer;    (* size of the structure *)
  _xPos: integer;     (* column position (paint units) *)
  _nWidth: integer;    (* width (paint units) *)
  _fntColumn: THandle;    (* column font *)
   end;
 
 scLlGroup = record
  _nSize: integer;    (* size of the structure *)
  _hRefDC: hdc;     (* HDC to get information from *)
  _hPaintDC: hdc;     (* HDC to paint on *)
  _rcPaint: tRect;    (* suggested RECT in paint units (mm/10 or inch/100), change .bottom value *)
   _fntHeader: THandle;   (* header default font *)
   _fntBody: THandle;    (* body   default font *)
   _fntFooter: THandle;   (* footer default font *)
  _nHeight: integer;    (* height of one body line (incl. spacing) *)
  _bPaint: longbool;     (* do paint, or do just calculate? *)
  _bFrameLeft: longbool;    (* frame on left side selected? *)
  _bFrameRight: longbool;    (* frame on right side selected? *)
  _lParam: integer;    (* function argument: user parameter 1 *)
  _lpParam: lParam;    (* function argument: user parameter 2 *)
  _nColumns: integer;    (* number of columns in this table *)
  _lpColumns: PSCLLCOLUMN;  (* pointer to an array of column structs *)
   end;
 PSCLLGROUP = ^scLlGroup;
 
 scLlPrinter = record
  _nSize: integer;    (* size of the structure *)
   _bFirst: longbool;        (* first or second printer? *)
   _nCmd: integer;        (* i command *)
   _hWnd: hWnd;         (* i *)
   _hDC: hdc;          (* i/o *)
   _nOrientation: smallint;     (* i/o *)
   _bPhysPage: longbool;       (* i/o, new L5 *)
   _nBufSize: integer;       (* i *)
   _pszBuffer: ptchar;       (* i, fill *)
   _nUniqueNumber : integer;    (* i *)
   _nUniqueNumberCompare: integer; (* i *)
   _nPaperFormat: integer;   (* i/o, (JobID for LL_CMND_CHANGE_DCPROPERTIES_DOC) *)
   _xPaperSize: integer;   (* i/o, mm/10 *)
   _yPaperSize: integer;   (* i/o, mm/10 *)
   end;
 PSCLLPRINTER = ^scLlPrinter;
 
 scLlDlgExprVarExt = record
  _nSize: integer;    (* size of the structure     *)
  _nFunction: integer;    (* function code (LL_DLGEXPR_VAREXTBTN_xxx)*)
   _hWndDialog: hWnd;    (* dialog handle      *)
  _pszPage: pchar;    (* "CondDlgVar"       *)
   _szValue: array[0..$4000] of Tchar; (* new value       *)
   _bFields: longbool;     (* FALSE        *)
  _nMask: longint;     (* LL_TEXT, ... OR LL_FOOTERFIELD... *)
  end;
 PSCLLDLGEXPRVAREXT = ^scLlDlgExprVarExt;
 
 scLlToolbar = record
  _nSize: integer;
  _hWnd : hWnd;
  _nType: cardinal;
  _hMenu: THandle;
  _nParam: THandle;
  end;
 PSCLLTOOLBAR = ^scLlToolbar;
 
 scLlDlgEditLineExParams = record
  _nSize: integer;       (* size of the structure *)
   _bEnableAskString: longbool;
   end;
 
 scLlDlgEditLineExParams8 = record
  _nSize: integer;       (* size of the structure *)
   _bEnableAskString: longbool;
   _bIncludeChartFields: longbool;
   end;
 
 scLlDlgEditLineExParams12a = record
  _nSize: integer;       (* size of the structure *)
  _bEnableAskString: longbool;
  _bIncludeChartFields: longbool;
  _pszwAllowedSourceTables: pWideChar;
  _nFlags: cardinal;
   end;
 
 scLlPrintJobInfo = record
  _nSize: integer;        (* size of the structure *)
  _hLlJob: HLLJOB;      (* the LL job that issued the job    *)
  _szDevice: array[0..79] of TCHAR;  (* printer device name      *)
  _dwJobID: cardinal;     (* an internal ID, NOT THE QUEUE ID (as different queues could have different IDs) *)
  _dwState: cardinal;     (* state (JOB_STATUS_xxx, see Windows API)  *)
  end;
 PSCLLPRINTJOBINFO = ^scLlPrintJobInfo;
 
 scLlDelayedValue = record
  _nSize: cardinal;
  _pszVarName: ptchar;
  _pszContents: ptchar;
  _nBufSize: cardinal;
  _hContents: tHandle;
  end;
 PSCLLDELAYEDVALUE = ^scLlDelayedValue;
 
 scLlDesignerPrintJob = record
  _nSize: cardinal;
  _nUserParam: lParam;
  _pszProjectFileName: ptchar;
  _pszOriginalProjectFileName: ptchar;
  _nPages: cardinal;
  _nFunction: cardinal;
  _hWndPreviewControl: hWnd;
  _hEvent: tHandle;
  _pszExportFormat: ptchar;
  _bWithoutDialog: longbool;
  end;
 PSCLLDESIGNERPRINTJOB = ^scLlDesignerPrintJob;
 
 scLLDrillDownJob = record
  _nSize : cardinal;
  _nFunction: cardinal;
  _nUserParameter: lParam;
  _pszTableID: ptchar;
  _pszRelationID: ptchar;
  _pszSubreportTableID: ptchar;
  _pszKeyField: ptchar;
  _pszSubreportKeyField: ptchar;
  _pszKeyValue: ptchar;
  _pszProjectFileName: ptchar;
  _pszPreviewFileName: ptchar;
  _pszTooltipText: ptchar;
  _pszTabText: ptchar;
  _hWnd: hWnd;
  _nID: longint;
   _hAttachInfo: thandle;
  _pszSRID: ptchar;
  _pszExportFormat: ptchar;
  end;
 
 PSCLLDRILLDOWNJOBINFO = ^scLLDrillDownJob;
 
 scLLNtfyHyperlink = record
  _nSize : cardinal;
  _nAction: cardinal;
  _pvHovertooltip: ^OleVariant;
  _pwszProtocol: pWideChar;
  _pwszData: pWideChar;
  end;
 
 PSCLLNTFYHYPERLINK = ^scLLNtfyHyperlink;
 
 scLLExpr2HostExpr = record
  _nSize: cardinal;
  _pszTableID: pWideChar;
  _nType: cardinal;
  _pvRes: ^OleVariant;
  _nArgs: cardinal;
  _pvName: ^OleVariant;
  _pv1: ^OleVariant;
  _pv2: ^OleVariant;
  _pv3: ^OleVariant;
  _pv4: ^OleVariant;
  end;
 
 PSCLLEXPR2HOSTEXPR = ^scLLEXPR2HOSTEXPR;
 
 scLlNtfyReportparametersCollected = record
   _nsize: cardinal;
   _hProject: HLLDOMOBJ;
   _pszTriggerPrintID : pWideChar;
   _pszNeedDataError : pWideChar;
   _pszNeedDataErrorWithKey: pWideChar;
   _pvRPDefinitions: ^OleVariant;
   _pvRPContents: ^OleVariant;
   end;
 
 PSCLLNTFYREPORTPARAMETERSCOLLECTED = ^scLlNtfyReportparametersCollected;


const
  CMBTLANG_DEFAULT            = -1;
  CMBTLANG_GERMAN             = 0;
  CMBTLANG_ENGLISH            = 1;
  CMBTLANG_ARAB               = 2;
  CMBTLANG_AFRIKAANS          = 3;
  CMBTLANG_ALBANIAN           = 4;
  CMBTLANG_BASQUE             = 5;
  CMBTLANG_BULGARIAN          = 6;
  CMBTLANG_BYELORUSSIAN       = 7;
  CMBTLANG_CATALAN            = 8;
  CMBTLANG_CHINESE            = 9;
  CMBTLANG_CROATIAN           = 10;
  CMBTLANG_CZECH              = 11;
  CMBTLANG_DANISH             = 12;
  CMBTLANG_DUTCH              = 13;
  CMBTLANG_ESTONIAN           = 14;
  CMBTLANG_FAEROESE           = 15;
  CMBTLANG_FARSI              = 16;
  CMBTLANG_FINNISH            = 17;
  CMBTLANG_FRENCH             = 18;
  CMBTLANG_GREEK              = 19;
  CMBTLANG_HEBREW             = 20;
  CMBTLANG_HUNGARIAN          = 21;
  CMBTLANG_ICELANDIC          = 22;
  CMBTLANG_INDONESIAN         = 23;
  CMBTLANG_ITALIAN            = 24;
  CMBTLANG_JAPANESE           = 25;
  CMBTLANG_KOREAN             = 26;
  CMBTLANG_LATVIAN            = 27;
  CMBTLANG_LITHUANIAN         = 28;
  CMBTLANG_NORWEGIAN          = 29;
  CMBTLANG_POLISH             = 30;
  CMBTLANG_PORTUGUESE         = 31;
  CMBTLANG_ROMANIAN           = 32;
  CMBTLANG_RUSSIAN            = 33;
  CMBTLANG_SLOVAK             = 34;
  CMBTLANG_SLOVENIAN          = 35;
  CMBTLANG_SERBIAN            = 36;
  CMBTLANG_SPANISH            = 37;
  CMBTLANG_SWEDISH            = 38;
  CMBTLANG_THAI               = 39;
  CMBTLANG_TURKISH            = 40;
  CMBTLANG_UKRAINIAN          = 41;
  CMBTLANG_SERBIAN_LATIN      = 42;
 CMBTLANG_CHINESE_TRADITIONAL = 48;
  LL_LINK_HPOS_NONE              = $0000;
  LL_LINK_HPOS_START             = $0001;
  LL_LINK_HPOS_END               = $0002;
  LL_LINK_HPOS_ABS               = $0003;
  LL_LINK_HPOS_MASK              = $0007;
  LL_LINK_VPOS_NONE              = $0000;
  LL_LINK_VPOS_START             = $0010;
  LL_LINK_VPOS_END               = $0020;
  LL_LINK_VPOS_ABS               = $0030;
  LL_LINK_VPOS_MASK              = $0070;
  LL_LINK_HSIZE_NONE             = $0000;
  LL_LINK_HSIZE_PROP             = $0100;
  LL_LINK_HSIZE_INV              = $0200;
  LL_LINK_HSIZE_MASK             = $0300;
  LL_LINK_VSIZE_NONE             = $0000;
  LL_LINK_VSIZE_PROP             = $1000;
  LL_LINK_VSIZE_INV              = $2000;
  LL_LINK_VSIZE_MASK             = $3000;
  LL_LINK_SIZEPOS_MASK           = $3377;
  LL_LINK_SIZEOFPARENT           = $4000;
  LL_DESIGNERPRINTCALLBACK_PREVIEW_START = 1;
  LL_DESIGNERPRINTCALLBACK_PREVIEW_ABORT = 2;
  LL_DESIGNERPRINTCALLBACK_PREVIEW_FINALIZE = 3;
  LL_DESIGNERPRINTCALLBACK_PREVIEW_QUEST_JOBSTATE = 4;
  LL_DESIGNERPRINTCALLBACK_EXPORT_START = 5;
  LL_DESIGNERPRINTCALLBACK_EXPORT_ABORT = 6;
  LL_DESIGNERPRINTCALLBACK_EXPORT_FINALIZE = 7;
  LL_DESIGNERPRINTCALLBACK_EXPORT_QUEST_JOBSTATE = 8;
  LL_DESIGNERPRINTTHREAD_STATE_STOPPED = 0;
  LL_DESIGNERPRINTTHREAD_STATE_SUSPENDED = 1;
  LL_DESIGNERPRINTTHREAD_STATE_RUNNING = 2;
  LL_INVOKEACTION_FLAG_SAVE_NO_PROJECTDESCRIPTIONCHECK = $0001;
                    (* in HIWORD in LlDesignerInvokeAction *)
  LL_DRILLDOWN_START             = 1;
  LL_DRILLDOWN_FINALIZE          = 2;
  LL_PRINTJOB_FINALIZE           = 3;
  LL_JOBOPENFLAG_NOLLXPRELOAD    = $00001000;
  LL_JOBOPENFLAG_ONLYEXACTLANGUAGE = $00002000;
                    (* do not look for '@@' LNG file *)
  LL_DEBUG_CMBTLL                = $0001;
                    (* debug CMBTLLnn.DLL *)
  LL_DEBUG_CMBTDWG               = $0002;
                    (* debug CMBTDWnn.DLL *)
  LL_DEBUG_CMBTLL_NOCALLBACKS    = $0004;
  LL_DEBUG_CMBTLL_NOSTORAGE      = $0008;
  LL_DEBUG_CMBTLL_NOWAITDLG      = $0010;
  LL_DEBUG_CMBTLL_NOSYSINFO      = $0020;
  LL_DEBUG_CMBTLL_LOGTOFILE      = $0040;
  LL_DEBUG_CMBTLS                = $0080;
                    (* debug CMBTLSnn.DLL *)
  LL_DEBUG_PRNINFO               = $0100;
                    (* issue basic printer operations *)
  LL_DEBUG_CMBTLL_OBJECTSTATES   = $0400;
                    (* issue object states after drawing (realdata printing only) *)
  LL_DEBUG_NOPRIVACYDATA         = $0800;
                    (* suppress field contents (useful if they might contain private data) *)
  LL_DEBUG_FORCE_SYSINFO         = $1000;
                    (* issue sysinfo even though it has been issued once already *)
  LL_DEBUG_EVAL2HOSTEXPRESSION   = $2000;
                    (* debug Eval2HostExpr processing *)
  LL_DEBUG_EXTENDED_DEBWINFLAGS  = $80000000;
                    (* internal usage *)
  LL_VERSION_MAJOR               = 1;
                    (* direct return of major version (f.ex. 1) *)
  LL_VERSION_MINOR               = 2;
                    (* direct return of minor version (f.ex. 13) *)
  LL_CMND_DRAW_USEROBJ           = 0;
                    (* callback for LL_DRAWING_USEROBJ *)
  LL_CMND_EDIT_USEROBJ           = 1;
                    (* callback for LL_DRAWING_USEROBJ_DLG *)
  LL_CMND_GETSIZE_USEROBJ        = 2;
  LL_CMND_GETSIZE_USEROBJ_SCM    = 3;
  LL_CMND_GETSIZE_USEROBJ_PIXEL  = 4;
  LL_CMND_TABLELINE              = 10;
                    (* callback for LL_CB_TABLELINE *)
  LL_TABLE_LINE_HEADER           = 0;
  LL_TABLE_LINE_BODY             = 1;
  LL_TABLE_LINE_FOOTER           = 2;
  LL_TABLE_LINE_FILL             = 3;
  LL_TABLE_LINE_GROUP            = 4;
  LL_TABLE_LINE_GROUPFOOTER      = 5;
  LL_CMND_TABLEFIELD             = 11;
                    (* callback for LL_CB_TABLEFIELD *)
  LL_TABLE_FIELD_HEADER          = 0;
  LL_TABLE_FIELD_BODY            = 1;
  LL_TABLE_FIELD_FOOTER          = 2;
  LL_TABLE_FIELD_FILL            = 3;
  LL_TABLE_FIELD_GROUP           = 4;
  LL_TABLE_FIELD_GROUPFOOTER     = 5;
  LL_CMND_EVALUATE               = 12;
                    (* callback for "External$" function *)
  LL_CMND_OBJECT                 = 20;
                    (* callback of LL_CB_OBJECT *)
  LL_CMND_PAGE                   = 21;
                    (* callback of LL_CB_PAGE *)
  LL_CMND_PROJECT                = 22;
                    (* callback of LL_CB_PROJECT *)
  LL_CMND_DRAW_GROUP_BEGIN       = 23;
                    (* callback for LlPrintBeginGroup *)
  LL_CMND_DRAW_GROUP_END         = 24;
                    (* callback for LlPrintEndGroup *)
  LL_CMND_DRAW_GROUPLINE         = 25;
                    (* callback for LlPrintGroupLine *)
  LL_RSP_GROUP_IMT               = 0;
  LL_RSP_GROUP_NEXTPAGE          = 1;
  LL_RSP_GROUP_OK                = 2;
  LL_RSP_GROUP_DRAWFOOTER        = 3;
  LL_CMND_HELP                   = 30;
                    (* lParam: HIWORD=HELP_xxx, LOWORD=Context # *)
  LL_CMND_ENABLEMENU             = 31;
                    (* undoc: lParam/LOWORD(lParam) = HMENU *)
  LL_CMND_MODIFYMENU             = 32;
                    (* undoc: lParam/LOWORD(lParam) = HMENU *)
  LL_CMND_SELECTMENU             = 33;
                    (* undoc: lParam=ID (return TRUE if processed) *)
  LL_CMND_GETVIEWERBUTTONSTATE   = 34;
                    (* HIWORD(lParam)=ID, LOWORD(lParam)=state *)
  LL_CMND_VARHELPTEXT            = 35;
                    (* lParam=LPSTR(Name), returns LPSTR(Helptext) *)
  LL_INFO_METER                  = 37;
                    (* lParam = addr(scLlMeterInfo) *)
  LL_METERJOB_LOAD               = 1;
  LL_METERJOB_SAVE               = 2;
  LL_METERJOB_CONSISTENCYCHECK   = 3;
  LL_METERJOB_PASS2              = 4;
  LL_METERJOB_PASS3              = 5;
  LL_NTFY_FAILSFILTER            = 1000;
                    (* data set fails filter expression *)
  LL_NTFY_VIEWERBTNCLICKED       = 38;
                    (* user presses a preview button (action will be done). lParam=ID. result: 0=allowed, 1=not allowed *)
  LL_CMND_DLGEXPR_VARBTN         = 39;
                    (* lParam: @scLlDlgExprVarExt, return: IDOK for ok *)
  LL_CMND_HOSTPRINTER            = 40;
                    (* lParam: scLlPrinter *)
  LL_PRN_CREATE_DC               = 1;
                    (* scLlPrinter._nCmd values *)
  LL_PRN_DELETE_DC               = 2;
  LL_PRN_SET_ORIENTATION         = 3;
  LL_PRN_GET_ORIENTATION         = 4;
  LL_PRN_EDIT                    = 5;
                    (* unused *)
  LL_PRN_GET_DEVICENAME          = 6;
  LL_PRN_GET_DRIVERNAME          = 7;
  LL_PRN_GET_PORTNAME            = 8;
  LL_PRN_RESET_DC                = 9;
  LL_PRN_COMPARE_PRINTER         = 10;
  LL_PRN_GET_PHYSPAGE            = 11;
  LL_PRN_SET_PHYSPAGE            = 12;
  LL_PRN_GET_PAPERFORMAT         = 13;
                    (* fill _nPaperFormat *)
  LL_PRN_SET_PAPERFORMAT         = 14;
                    (* _nPaperFormat, _xPaperSize, _yPaperSize *)
  LL_OEM_TOOLBAR_START           = 41;
  LL_OEM_TOOLBAR_END             = 50;
  LL_NTFY_EXPRERROR              = 51;
                    (* lParam = LPCSTR(error text) *)
  LL_CMND_CHANGE_DCPROPERTIES_CREATE = 52;
                    (* lParam = addr(scLlPrinter), _hDC is valid *)
  LL_CMND_CHANGE_DCPROPERTIES_DOC = 53;
                    (* lParam = addr(scLlPrinter), _hDC is valid *)
  LL_CMND_CHANGE_DCPROPERTIES_PAGE = 54;
                    (* lParam = addr(scLlPrinter), _hDC is valid *)
  LL_CMND_CHANGE_DCPROPERTIES_PREPAGE = 56;
                    (* lParam = addr(scLlPrinter), _hDC and _pszBuffer( DEVMODE* ) are valid *)
  LL_CMND_MODIFY_METAFILE        = 57;
                    (* lParam = handle of EMF (enh. metafile) *)
  LL_INFO_PRINTJOBSUPERVISION    = 58;
                    (* lParam = addr(scLlPrintJobInfo) *)
  LL_CMND_DELAYEDVALUE           = 59;
                    (* lParam = addr(scLlDelayedValue) *)
  LL_CMND_SUPPLY_USERDATA        = 60;
                    (* lParam = addr(scLlProjectUserData) *)
  LL_CMND_SAVEFILENAME           = 61;
                    (* lParam = LPCTSTR(Filename) *)
  LL_QUERY_IS_VARIABLE_OR_FIELD  = 62;
                    (* lParam = addr(scLlDelayDefineFieldOrVariable), must be enabled by CB mask. If returns TRUE, the var must be defined in the callback... *)
  LL_NTFY_PROJECTLOADED          = 63;
                    (* lParam = 0 *)
  LL_QUERY_DESIGNERACTIONSTATE   = 64;
  LL_NTFY_DESIGNERREADY          = 65;
                    (* lParam = 0 *)
  LL_NTFY_DESIGNERPRINTJOB       = 66;
  LL_NTFY_VIEWERDRILLDOWN        = 67;
  LL_NTFY_QUEST_DRILLDOWNDENIED  = 68;
                    (* see LS_VIEWERCONTROL_QUEST_DRILLDOWNDENIED *)
  LL_QUERY_DRILLDOWN_ADDITIONAL_BASETABLES_FOR_VARIABLES = 69;
                    (* lParam = scLlDDFilterInfo* *)
  LL_QUERY_DRILLDOWN_ADDITIONAL_TABLES = 70;
                    (* lParam = scLlDDFilterInfo* *)
  LL_NTFY_DRILLDOWN_DESIGNERACTION = 71;
                    (* lParam = scLlDDDesignerActionW* *)
  LL_NTFY_INPLACEDESIGNER_START  = 72;
  LL_NTFY_INPLACEDESIGNER_END    = 73;
  LL_QUERY_OWN_MENU              = 74;
                    (* lParam = HMENU -> return 1 if uses own menu *)
  LL_CMND_UPDATE_MENU            = 75;
  LL_NTFY_FRAMEHANDLE            = 76;
                    (* lParam -> handle of layout window ("L&LFrame") *)
  LL_QUERY_DEFAULTPROJECTSTREAM  = 77;
                    (* lParam -> IStream**. Return NONZERO when stream contains data *)
  LL_NTFY_QUEST_RP_REALDATAJOBDENIED = 78;
  LL_NTFY_QUEST_EXPANDABLEREGIONSJOBDENIED = 79;
  LL_NTFY_QUEST_INTERACTIVESORTINGJOBDENIED = 80;
  LL_QUERY_EXPR2HOSTEXPRESSION   = 81;
                    (* lParam = LLEXPR2HOSTEXPR*, return 0 for FAIL, 1 for OPTIMAL, 2 for INEXACT *)
  LL_NTFY_REPORTPARAMETERS_COLLECTED = 82;
                    (* lParam = &scNtfyReportparametersCollected, return LL_ERR_USER_ABORTED to abort, 0x01 to get RP stream, 0x02 to get RP contents, 0 to leave processing *)
  LL_NTFY_EXPORTERPAGEFINISHED   = 83;
                    (* lParam = &scNtfyExporterPageFinished *)
  LL_NTFY_HYPERLINK              = 84;
                    (* lParam = &scNtfyHyperlink *)
  LL_NTFY_SAVEREPORTSTATEITEM    = 85;
                    (* lParam = &scLLNtfyReportStateItem *)
  LL_NTFY_RESTOREREPORTSTATEITEM = 86;
                    (* lParam = &scLLNtfyReportStateItem *)
  LL_NTFY_PROGRESS               = 87;
                    (* lParam -> percentage of current progress *)
  LL_NTFY_TRIGGEREDJOBINUITHREAD = 88;
                    (* lParam -> user data *)
  LL_NTFY_PLEASE_TRANSLATE       = 89;
                    (* lParam=BSTR* *)
  LL_NTFY_PREVIEW_PRINT_START    = 99;
                    (* lParam = &scViewerControlPrintData, return 1 to abort print *)
  LL_NTFY_PREVIEW_PRINT_PAGE     = 100;
                    (* lParam = &scViewerControlPrintData, return 1 to abort loop *)
  LL_NTFY_PREVIEW_PRINT_END      = 101;
                    (* lParam = &scViewerControlPrintData *)
  LL_NTFY_EMF_PAGE               = 102;
                    (* lParam = &scLLNtfyEMF *)
  LL_QUERY_FILENAME_FOR_EXPORTJOB = 103;
                    (* lParam = VARIANT* (in: old filename, out:new filename) *)
  LL_QUERY_OBJECT_NOT_SUPPORTED  = 104;
                    (* lParam = &scLLQueryObjectAllowed *)
  LL_QUERY_REPLACE_FILESYSTEMITEM = 105;
                    (* lParam = &scLLQueryFilenameReplacement -> return 1 if replaced *)
  LL_QUERY_HOSTIMPORT            = 106;
                    (* lParam = &scLlNtfyHostImport -> return 1 if LL's internal routine is superseded *)
  LL_NTFY_PREVIEW_ACTIONRESULT   = 107;
                    (* see LS_VIEWERCONTROL_NTFY_ACTIONRESULT - for RealDataPreview *)
  LL_NTFY_DATA_LOSS              = 108;
                    (* lParam = LL_NTFYDATALOSS_XXX *)
  LL_NTFYDATALOSS_RTFDETECTION_NOT_ENOUGH_SPACE = 1;
  LL_NTFY_REPORTPARAMETERS_COLLECTION_FINISHED = 109;
                    (* lParam and result: see LL_NTFY_REPORTPARAMETERS_COLLECTED *)
  LL_NTFY_EXPRERROR_EX           = 110;
                    (* lParam = @scLlNtfyExprErrorEx *)
  LL_NTFY_EXPORTERPAGECOUNT      = 111;
                    (* lParam = &scLLNtfyExporterPageCount *)
  LL_NTFY_FIND_AND_REPLACE       = 112;
                    (* lParam = &scLLNtfyFindAndReplace, returns: 0 to replace, 1 to skip, 2 to cancel search globally *)
  LL_NTFY_PROJECTLOAD_EX         = 113;
                    (* lParam = &scLLNtfyProjectLoadEx, called before a project is loaded. SetErrortext to abort loading. *)
  LL_NTFY_JOBWILLCHANGE          = 114;
                    (* internal *)
  LL_NTFY_COMBINATIONPRINTSTEP   = 115;
                    (* lParam = &scLlCombinationPrintStep, return 0 on OK, error code on error *)
  LL_NTFY_LOADERROR_DATABASESTRUCTURE = 116;
                    (* lParam = @scLlNtfyDatabaseError *)
  LL_PROJECT_LABEL               = 1;
                    (* new names... *)
  LL_PROJECT_LIST                = 2;
  LL_PROJECT_CARD                = 3;
  LL_PROJECT_TOC                 = 4;
  LL_PROJECT_IDX                 = 5;
  LL_PROJECT_GTC                 = 6;
  LL_PROJECT_LAST                = 6;
  LL_PROJECT_MASK                = $000f;
  LL_OBJ_MARKER                  = 0;
                    (* internal use only *)
  LL_OBJ_TEXT                    = 1;
                    (* the following are used in the object callback *)
  LL_OBJ_RECT                    = 2;
  LL_OBJ_LINE                    = 3;
  LL_OBJ_BARCODE                 = 4;
  LL_OBJ_DRAWING                 = 5;
  LL_OBJ_TABLE                   = 6;
  LL_OBJ_TEMPLATE                = 7;
  LL_OBJ_ELLIPSE                 = 8;
  LL_OBJ_GROUP                   = 9;
                    (* internal use only *)
  LL_OBJ_RTF                     = 10;
  LL_OBJ_LLX                     = 11;
  LL_OBJ_INPUT                   = 12;
  LL_OBJ_LAST                    = 12;
                    (* last object type (for loops as upper bound) - if this is changed, change the contants in object.c too! *)
  LL_OBJ_REPORTCONTAINER         = 253;
                    (* for exporter *)
  LL_OBJ_PROJECT                 = 254;
                    (* for exporter *)
  LL_OBJ_PAGE                    = 255;
                    (* for exporter *)
  LL_DELAYEDVALUE                = $80000000;
  LL_TYPEMASK                    = $7fff0000;
  LL_ANYTYPE                     = $7fff0000;
  LL_TABLE_FIELDTYPEMASK         = $0000f800;
                    (* internal use *)
  LL_SUBTYPEMASK                 = $000003ff;
  LL_TYPEFLAGS                   = $8000f800;
  LL_HANDLESTREAM_TYPE_MASK      = $00000400;
  LL_HANDLESTREAM_BLOB           = $00000000;
                    (* binary data (images only) *)
  LL_HANDLESTREAM_UTF8           = $00000000;
                    (* UTF8-encoded string (non-images only) *)
  LL_HANDLESTREAM_UTF16          = $00000400;
                    (* UTF16-encoded string (non-images only) *)
  LL_TABLE_FOOTERFIELD           = $00008000;
                    (* 'or'ed for footline-only fields // reserved also for Variables (see "$$xx$$")!!!! *)
  LL_TABLE_GROUPFIELD            = $00004000;
                    (* 'or'ed for groupline-only fields *)
  LL_TABLE_HEADERFIELD           = $00002000;
                    (* 'or'ed for headline-only fields *)
  LL_TABLE_BODYFIELD             = $00001000;
                    (* 'or'ed for headline-only fields *)
  LL_TABLE_GROUPFOOTERFIELD      = $00000800;
                    (* 'or'ed for group-footer-line-only fields *)
  LL_BARCODE                     = $40000000;
  LL_BARCODE_METHODMASK          = $000000ff;
  LL_BARCODE_WITHTEXT            = $00000100;
  LL_BARCODE_WITHOUTTEXT         = $00000200;
  LL_BARCODE_TEXTDONTCARE        = $00000000;
  LL_BARCODE_EAN13               = $40000000;
  LL_BARCODE_EAN8                = $40000001;
  LL_BARCODE_GTIN13              = $40000000;
  LL_BARCODE_GTIN8               = $40000001;
  LL_BARCODE_UPCA                = $40000002;
  LL_BARCODE_UPCE                = $40000003;
  LL_BARCODE_3OF9                = $40000004;
  LL_BARCODE_25INDUSTRIAL        = $40000005;
  LL_BARCODE_25INTERLEAVED       = $40000006;
  LL_BARCODE_25DATALOGIC         = $40000007;
  LL_BARCODE_25MATRIX            = $40000008;
  LL_BARCODE_POSTNET             = $40000009;
  LL_BARCODE_FIM                 = $4000000A;
  LL_BARCODE_CODABAR             = $4000000B;
  LL_BARCODE_EAN128              = $4000000C;
  LL_BARCODE_GS1_128             = $4000000C;
  LL_BARCODE_CODE128             = $4000000D;
  LL_BARCODE_DP_LEITCODE         = $4000000E;
  LL_BARCODE_DP_IDENTCODE        = $4000000F;
  LL_BARCODE_GERMAN_PARCEL       = $40000010;
  LL_BARCODE_CODE93              = $40000011;
  LL_BARCODE_MSI                 = $40000012;
  LL_BARCODE_CODE11              = $40000013;
  LL_BARCODE_MSI_10_CD           = $40000014;
  LL_BARCODE_MSI_10_10           = $40000015;
  LL_BARCODE_MSI_11_10           = $40000016;
  LL_BARCODE_MSI_PLAIN           = $40000017;
  LL_BARCODE_EAN14               = $40000018;
  LL_BARCODE_GTIN14              = $40000018;
  LL_BARCODE_UCC14               = $40000019;
  LL_BARCODE_CODE39              = $4000001A;
  LL_BARCODE_CODE39_CRC43        = $4000001B;
  LL_BARCODE_PZN                 = $4000001C;
  LL_BARCODE_CODE39_EXT          = $4000001D;
  LL_BARCODE_JAPANESE_POSTAL     = $4000001E;
  LL_BARCODE_RM4SCC              = $4000001F;
  LL_BARCODE_RM4SCC_CRC          = $40000020;
  LL_BARCODE_SSCC                = $40000021;
  LL_BARCODE_ISBN                = $40000022;
  LL_BARCODE_GS1                 = $40000023;
  LL_BARCODE_GS1_TRUNCATED       = $40000024;
  LL_BARCODE_GS1_STACKED         = $40000025;
  LL_BARCODE_GS1_STACKED_OMNI    = $40000026;
  LL_BARCODE_GS1_LIMITED         = $40000027;
  LL_BARCODE_GS1_EXPANDED        = $40000028;
  LL_BARCODE_INTELLIGENT_MAIL    = $40000029;
  LL_BARCODE_PZN8                = $4000002A;
  LL_BARCODE_CODE128_FULL        = $4000002B;
  LL_BARCODE_EAN128_FULL         = $4000002C;
  LL_BARCODE_CODABLOCK_F         = $4000002D;
  LL_BARCODE_PHARMACODE          = $4000002E;
  LL_BARCODE_LLXSTART            = $40000040;
  LL_BARCODE_PDF417              = $40000040;
  LL_BARCODE_MAXICODE            = $40000041;
  LL_BARCODE_MAXICODE_UPS        = $40000042;
  LL_BARCODE_DATAMATRIX          = $40000044;
  LL_BARCODE_AZTEC               = $40000045;
  LL_BARCODE_QRCODE              = $40000046;
  LL_BARCODE_DATAMATRIX_PREMIUMADRESS = $40000047;
  LL_BARCODE_MICROPDF417         = $40000048;
  LL_BARCODE_QR_EPC              = $40000049;
  LL_DRAWING                     = $20000000;
  LL_DRAWING_METHODMASK          = $000000ff;
  LL_DRAWING_HMETA               = $20000001;
  LL_DRAWING_USEROBJ             = $20000002;
  LL_DRAWING_USEROBJ_DLG         = $20000003;
  LL_DRAWING_HBITMAP             = $20000004;
  LL_DRAWING_HICON               = $20000005;
  LL_DRAWING_HEMETA              = $20000006;
  LL_DRAWING_HDIB                = $20000007;
                    (* global handle to BITMAPINFO and bits *)
  LL_META_MAXX                   = 10000;
  LL_META_MAXY                   = 10000;
  LL_TEXT                        = $10000000;
  LL_TEXT_ALLOW_WORDWRAP         = $10000000;
  LL_TEXT_DENY_WORDWRAP          = $10000001;
  LL_TEXT_FORCE_WORDWRAP         = $10000002;
  LL_NUMERIC                     = $08000000;
  LL_NUMERIC_LOCALIZED           = $08000001;
  LL_NUMERIC_INTEGER             = $08000002;
                    (* flag *)
  LL_DATE                        = $04000000;
                    (* LL's own julian *)
  LL_DATE_METHODMASK             = $000000ff;
  LL_DATE_DELPHI_1               = $04000001;
  LL_DATE_DELPHI                 = $04000002;
                    (* DELPHI 2, 3, 4: OLE DATE *)
  LL_DATE_MS                     = $04000002;
                    (* MS C/Basic: OLE DATE *)
  LL_DATE_OLE                    = $04000002;
                    (* generic: OLE DATE *)
  LL_DATE_VFOXPRO                = $04000003;
                    (* nearly LL's own julian, has an offset of 1! *)
  LL_DATE_DMY                    = $04000004;
                    (* <d><sep><m><sep><yyyy>. Year MUST be 4 digits! *)
  LL_DATE_MDY                    = $04000005;
                    (* <m><sep><d><sep><yyyy>. Year MUST be 4 digits! *)
  LL_DATE_YMD                    = $04000006;
                    (* <yyyy><sep><m><sep><d>. Year MUST be 4 digits! *)
  LL_DATE_YYYYMMDD               = $04000007;
                    (* <yyyymmdd> *)
  LL_DATE_LOCALIZED              = $04000008;
                    (* localized (automatic VariantConversion) *)
  LL_DATE_JULIAN                 = $04000009;
                    (* variant 'date' is a julian date *)
  LL_DATE_CLARION                = $0400000a;
                    (* days since 1800-12-28 (what's so special about that day?) *)
  LL_DATE_YMD_AUTO               = $04000010;
                    (* wither DMY, MDY or YMD, automatically detected *)
  LL_BOOLEAN                     = $02000000;
  LL_RTF                         = $01000000;
  LL_HTML                        = $00800000;
  LL_PDF                         = $00400000;
  LL_INPUTOBJECT                 = $00200000;
                    (* internal use only *)
  LL_LLXOBJECT                   = $00100000;
                    (* internal use only *)
  LL_SUBTABLELIST                = $00080000;
                    (* internal use only *)
  LL_RETURN_ERROR_IF_FILE_NOT_FOUND = $00010000;
  LL_FIXEDNAME                   = $00008000;
  LL_NOSAVEAS                    = $00004000;
  LL_DESIGNER_OVER_CHILD         = $00002000;
  LL_EXPRCONVERTQUIET            = $00001000;
                    (* convert to new expressions without warning box *)
  LL_NONAMEINTITLE               = $00000800;
                    (* no file name appended to title *)
  LL_PRVOPT_PRN_USEDEFAULT       = $00000000;
  LL_PRVOPT_PRN_ASKPRINTERIFNEEDED = $00000001;
  LL_PRVOPT_PRN_ASKPRINTERALWAYS = $00000002;
  LL_PRVOPT_PRN_ALWAYSUSEDEFAULT = $00000003;
  LL_PRVOPT_PRN_ASSIGNMASK       = $00000003;
                    (* used by L&L *)
  LL_PRVOPT_FLAG_STANDALONEVIEWER = $00000010;
  LL_OPTION_COPIES               = 0;
                    (* compatibility only, please use LL_PRNOPT_...   *)
  LL_OPTION_STARTPAGE            = 1;
                    (* compatibility only, please use LL_PRNOPT_PAGE  *)
  LL_OPTION_PAGE                 = 1;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_OFFSET               = 2;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_COPIES_SUPPORTED     = 3;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_FIRSTPAGE            = 5;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_LASTPAGE             = 6;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_JOBPAGES             = 7;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_OPTION_PRINTORDER           = 8;
                    (* compatibility only, please use LL_PRNOPT_...  *)
  LL_PRNOPT_COPIES               = 0;
  LL_COPIES_HIDE                 = -32768;
                    (* anything negative... *)
  LL_PRNOPT_STARTPAGE            = 1;
  LL_PRNOPT_PAGE                 = 1;
                    (* ; please do not use STARTPAGE any more... *)
  LL_PAGE_HIDE                   = -32768;
                    (* must be exactly this value! *)
  LL_PRNOPT_OFFSET               = 2;
  LL_PRNOPT_COPIES_SUPPORTED     = 3;
  LL_PRNOPT_UNITS                = 4;
                    (* r/o *)
  LL_UNITS_MM_DIV_10             = 0;
                    (* for LL_PRNOPT_UNITS, LL_OPTION_UNITS and LL_OPTION_UNITS_DEFAULT *)
  LL_UNITS_INCH_DIV_100          = 1;
  LL_UNITS_INCH_DIV_1000         = 2;
  LL_UNITS_SYSDEFAULT_LORES      = 3;
                    (* mm/10, in/100 (depending on regional settings of the system) *)
  LL_UNITS_SYSDEFAULT            = 4;
                    (* mm/100, in/1000 (depending on regional settings of the system) *)
  LL_UNITS_MM_DIV_100            = 5;
  LL_UNITS_MM_DIV_1000           = 6;
  LL_UNITS_SYSDEFAULT_HIRES      = 7;
                    (* mm/100, in/1000 (depending on regional settings of the system) *)
  LL_PRNOPT_FIRSTPAGE            = 5;
  LL_PRNOPT_LASTPAGE             = 6;
  LL_PRNOPT_JOBPAGES             = 7;
  LL_PRNOPT_PRINTORDER           = 8;
  LL_PRINTORDER_HORZ_LTRB        = 0;
  LL_PRINTORDER_VERT_LTRB        = 1;
  LL_PRINTORDER_HORZ_RBLT        = 2;
  LL_PRINTORDER_VERT_RBLT        = 3;
  LL_PRNOPT_DEFPRINTERINSTALLED  = 11;
                    (* returns 0 for no default printer, 1 for default printer present *)
  LL_PRNOPT_PRINTDLG_DESTMASK    = 12;
                    (* any combination of the ones below... Default: all. Outdated, please use LL_OPTIONSTR_EXPORTS_ALLOWED *)
  LL_DESTINATION_PRN             = 1;
  LL_DESTINATION_PRV             = 2;
  LL_DESTINATION_FILE            = 4;
  LL_DESTINATION_EXTERN          = 8;
  LL_DESTINATION_MSFAX           = 16;
                    (* reserved *)
  LL_PRNOPT_PRINTDLG_DEST        = 13;
                    (* default destination; outdated, please use LL_PRNOPTSTR_EXPORT *)
  LL_PRNOPT_PRINTDLG_ONLYPRINTERCOPIES = 14;
                    (* show copies option in dialog only if they are supported by the printer. default: false *)
  LL_PRNOPT_JOBID                = 17;
  LL_PRNOPT_PAGEINDEX            = 18;
  LL_PRNOPT_USES2PASS            = 19;
                    (* r/o *)
  LL_PRNOPT_PAGERANGE_USES_ABSOLUTENUMBER = 20;
                    (* default: false *)
  LL_PRNOPT_USEMEMORYMETAFILE    = 22;
                    (* default: false *)
  LL_PRNOPT_PARTIALPREVIEW       = 23;
                    (* default: false *)
  LL_PRNOPT_ADDITIONALPAGES_FOR_TOTAL = 24;
                    (* internal *)
  LL_PRNOPT_HAS_TOTALPAGES       = 25;
                    (* internal *)
  LL_PRNOPT_COUNT_OF_ITEMS       = 26;
                    (* labels/cards *)
  LL_PRNOPT_IS_PREPROCESSING     = 27;
  LL_PRNOPT_PRINTDLG_ALLOW_NUMBER_OF_FIRST_PAGE = 28;
  LL_PRNOPT_NEXT_INDEX           = 29;
  LL_PRNOPTSTR_PRINTDST_FILENAME = 0;
                    (* print to file: default filename (LlGet/SetPrintOptionString) *)
  LL_PRNOPTSTR_EXPORTDESCR       = 1;
                    (* r/o, returns the description of the export chosen *)
  LL_PRNOPTSTR_EXPORT            = 2;
                    (* sets default exporter to use / returns the name of the export chosen *)
  LL_PRNOPTSTR_PRINTJOBNAME      = 3;
                    (* set name to be given to StartDoc() (lpszMessage of LlPrintWithBoxStart() *)
  LL_PRNOPTSTR_PRESTARTDOCESCSTRING = 4;
                    (* sent before StartDoc() *)
  LL_PRNOPTSTR_POSTENDDOCESCSTRING = 5;
                    (* sent after EndDoc() *)
  LL_PRNOPTSTR_PRESTARTPAGEESCSTRING = 6;
                    (* sent before StartPage() *)
  LL_PRNOPTSTR_POSTENDPAGEESCSTRING = 7;
                    (* sent after EndPage() *)
  LL_PRNOPTSTR_PRESTARTPROJECTESCSTRING = 8;
                    (* sent before first StartPage() of project *)
  LL_PRNOPTSTR_POSTENDPROJECTESCSTRING = 9;
                    (* sent after last EndPage() of project *)
  LL_PRNOPTSTR_PAGERANGES        = 10;
  LL_PRNOPTSTR_ISSUERANGES       = 11;
  LL_PRNOPTSTR_PREVIEWTITLE      = 12;
                    (* default: language dependent *)
  LL_PRNOPTSTR_PRINTDLG_ALWAYSSHOWCOPIESFOR = 13;
                    (* default: empty string *)
  LL_PRNOPTSTR_NEXT_INDEX        = 14;
  LL_PRINT_V1POINTX              = $00000000;
  LL_PRINT_NORMAL                = $00000100;
  LL_PRINT_PREVIEW               = $00000200;
  LL_PRINT_STORAGE               = $00000200;
                    (* same as LL_PRINT_PREVIEW *)
  LL_PRINT_FILE                  = $00000400;
  LL_PRINT_USERSELECT            = $00000800;
  LL_PRINT_EXPORT                = $00000800;
                    (* same as LL_PRINT_USERSELECT *)
  LL_PRINT_MODEMASK              = $00000f00;
  LL_PRINT_MULTIPLE_JOBS         = $00001000;
  LL_PRINT_KEEPJOB               = $00002000;
  LL_PRINT_IS_DOM_CALLER         = $00004000;
                    (* internal *)
  LL_PRINT_DOM_NOCREATEDC        = $00010000;
                    (* internal *)
  LL_PRINT_DOM_NOOBJECTLOAD      = $00020000;
                    (* internal *)
  LL_PRINT_REMOVE_UNUSED_VARS    = $00008000;
                    (* optimization flag *)
  LL_PRINT_OPTIMIZE_PRINTERS_IN_PRV_PRINT = $00040000;
                    (* optimization flag *)
  LL_BOXTYPE_BOXTYPEMASK         = $000000ff;
  LL_BOXTYPE_NONE                = $000000ff;
  LL_BOXTYPE_FLAG_ALLOWSUSPEND   = $40000000;
  LL_BOXTYPE_FLAG_USEMARQUEE     = $80000000;
  LL_BOXTYPE_NORMALMETER         = 0;
  LL_BOXTYPE_BRIDGEMETER         = 1;
  LL_BOXTYPE_NORMALWAIT          = 2;
  LL_BOXTYPE_BRIDGEWAIT          = 3;
  LL_BOXTYPE_EMPTYWAIT           = 4;
  LL_BOXTYPE_EMPTYABORT          = 5;
  LL_BOXTYPE_STDWAIT             = 6;
  LL_BOXTYPE_STDABORT            = 7;
  LL_BOXTYPE_MAX                 = 7;
  LL_FILE_ALSONEW                = $00008000;
  LL_SELECTFILEDLGTITLE_USE_OSFILENAME = $00010000;
  LL_FILE_FORCE_OS_DIALOG        = $00020000;
  LL_FCTPARATYPE_DOUBLE          = $0001;
  LL_FCTPARATYPE_DATE            = $0002;
  LL_FCTPARATYPE_STRING          = $0004;
  LL_FCTPARATYPE_BOOL            = $0008;
  LL_FCTPARATYPE_DRAWING         = $0010;
  LL_FCTPARATYPE_BARCODE         = $0020;
  LL_FCTPARATYPE_ALL             = $003f;
  LL_FCTPARATYPE_PARA1           = $8001;
  LL_FCTPARATYPE_PARA2           = $8002;
  LL_FCTPARATYPE_PARA3           = $8003;
  LL_FCTPARATYPE_PARA4           = $8004;
  LL_FCTPARATYPE_SAME            = $803f;
  LL_FCTPARATYPE_MASK            = $8fff;
  LL_FCTPARATYPEFLAG_NONULLCHECK = $00010000;
  LL_FCTPARATYPEFLAG_MULTIDIM_ALLOWED = $00020000;
                    (* internal *)
  LL_FCTPARATYPEFLAG_RAW         = $00080000;
                    (* parameter passed as string without evaluation *)
  LL_FCTPARATYPEFLAG_RAW_WITH_SYNTAXCHECK = $00040000;
                    (* parameter passed as string without evaluation *)
  LL_FCTPARATYPEFLAG_KEEP_LINEBREAKS = $00100000;
  LL_FCTPARATYPEFLAG_EXECUTE_ON_SYNTAXCHECK_AT_LOADTIME = $00200000;
  LL_EXPRTYPE_DOUBLE             = 1;
  LL_EXPRTYPE_DATE               = 2;
  LL_EXPRTYPE_STRING             = 3;
  LL_EXPRTYPE_BOOL               = 4;
  LL_EXPRTYPE_DRAWING            = 5;
  LL_EXPRTYPE_BARCODE            = 6;
  LL_OPTION_NEWEXPRESSIONS       = 0;
                    (* default: true *)
  LL_OPTION_ONLYONETABLE         = 1;
                    (* default: false *)
  LL_OPTION_TABLE_COLORING       = 2;
                    (* default: LL_COLORING_LL *)
  LL_COLORING_LL                 = 0;
  LL_COLORING_PROGRAM            = 1;
  LL_COLORING_DONTCARE           = 2;
  LL_OPTION_SUPERVISOR           = 3;
                    (* default: false *)
  LL_OPTION_UNITS                = 4;
                    (* default: see LL_OPTION_METRIC *)
  LL_OPTION_TABSTOPS             = 5;
                    (* default: LL_TABS_DELETE  *)
  LL_TABS_DELETE                 = 0;
  LL_TABS_EXPAND                 = 1;
  LL_OPTION_CALLBACKMASK         = 6;
                    (* default: 0x00000000 *)
  LL_CB_PAGE                     = $40000000;
                    (* callback for each page *)
  LL_CB_PROJECT                  = $20000000;
                    (* callback for each label *)
  LL_CB_OBJECT                   = $10000000;
                    (* callback for each object *)
  LL_CB_HELP                     = $08000000;
                    (* callback for HELP (F1/Button) *)
  LL_CB_TABLELINE                = $04000000;
                    (* callback for table line *)
  LL_CB_TABLEFIELD               = $02000000;
                    (* callback for table field *)
  LL_CB_QUERY_IS_VARIABLE_OR_FIELD = $01000000;
                    (* callback for delayload (LL_QUERY_IS_VARIABLE_OR_FIELD) *)
  LL_OPTION_CALLBACKPARAMETER    = 7;
                    (* default: 0 *)
  LL_OPTION_HELPAVAILABLE        = 8;
                    (* default: true *)
  LL_OPTION_SORTVARIABLES        = 9;
                    (* default: true *)
  LL_OPTION_SUPPORTPAGEBREAK     = 10;
                    (* default: true *)
  LL_OPTION_SHOWPREDEFVARS       = 11;
                    (* default: true *)
  LL_OPTION_USEHOSTPRINTER       = 13;
                    (* default: false // use host printer via callback *)
  LL_OPTION_EXTENDEDEVALUATION   = 14;
                    (* allows expressions in chevrons (amwin mode) *)
  LL_OPTION_TABREPRESENTATIONCODE = 15;
                    (* default: 247 (0xf7) *)
  LL_OPTION_SHOWSTATE            = 16;
                    (* r/o,  *)
  LL_OPTION_METRIC               = 18;
                    (* default: depends on Windows defaults *)
  LL_OPTION_ADDVARSTOFIELDS      = 19;
                    (* default: false *)
  LL_OPTION_MULTIPLETABLELINES   = 20;
                    (* default: true *)
  LL_OPTION_CONVERTCRLF          = 21;
                    (* default: true *)
  LL_OPTION_WIZ_FILENEW          = 22;
                    (* default: false *)
  LL_OPTION_RETREPRESENTATIONCODE = 23;
                    (* default: LL_CHAR_NEWLINE (182) *)
  LL_OPTION_PRVZOOM_PERC         = 25;
                    (* initial preview zoom *)
  LL_OPTION_PRVRECT_LEFT         = 26;
                    (* initial preview position *)
  LL_OPTION_PRVRECT_TOP          = 27;
  LL_OPTION_PRVRECT_WIDTH        = 28;
  LL_OPTION_PRVRECT_HEIGHT       = 29;
  LL_OPTION_STORAGESYSTEM        = 30;
                    (* DEPRECATED. Do not change. 0=LX4-compatible, 1=STORAGE (default)  *)
  LL_STG_COMPAT4                 = 0;
  LL_STG_STORAGE                 = 1;
  LL_OPTION_COMPRESSSTORAGE      = 31;
                    (* 0, 1, 10..17 *)
  LL_STG_COMPRESS_THREADED       = $00008000;
  LL_STG_COMPRESS_UNTHREADED     = $00010000;
  LL_OPTION_NOPARAMETERCHECK     = 32;
                    (* you need a bit more speed? *)
  LL_OPTION_NONOTABLECHECK       = 33;
                    (* don't check on "NO_TABLEOBJECT" error. Default TRUE (don't check) *)
  LL_OPTION_DRAWFOOTERLINEONPRINT = 34;
                    (* delay footerline printing to LlPrint(). Default FALSE *)
  LL_OPTION_PRVZOOM_LEFT         = 35;
                    (* initial preview position in percent of screen *)
  LL_OPTION_PRVZOOM_TOP          = 36;
  LL_OPTION_PRVZOOM_WIDTH        = 37;
  LL_OPTION_PRVZOOM_HEIGHT       = 38;
  LL_OPTION_SPACEOPTIMIZATION    = 40;
                    (* default: true *)
  LL_OPTION_REALTIME             = 41;
                    (* default: false *)
  LL_OPTION_AUTOMULTIPAGE        = 42;
                    (* default: true *)
  LL_OPTION_USEBARCODESIZES      = 43;
                    (* default: false *)
  LL_OPTION_MAXRTFVERSION        = 44;
                    (* default: 0xff00 *)
  LL_OPTION_VARSCASESENSITIVE    = 46;
                    (* default: false *)
  LL_OPTION_DELAYTABLEHEADER     = 47;
                    (* default: true *)
  LL_OPTION_OFNDIALOG_EXPLORER   = 48;
                    (* DEPRECATED. Do not change.  *)
  LL_OPTION_OFN_NOPLACESBAR      = $40000000;
  LL_OPTION_EMFRESOLUTION        = 49;
                    (* DEPRECATED. Do not change.  *)
  LL_OPTION_SETCREATIONINFO      = 50;
                    (* default: true *)
  LL_OPTION_XLATVARNAMES         = 51;
                    (* default: true *)
  LL_OPTION_LANGUAGE             = 52;
                    (* returns current language (r/o) *)
  LL_OPTION_PHANTOMSPACEREPRESENTATIONCODE = 54;
                    (* default: LL_CHAR_PHANTOMSPA *)
  LL_OPTION_LOCKNEXTCHARREPRESENTATIONCODE = 55;
                    (* default: LL_CHAR_LOCK *)
  LL_OPTION_EXPRSEPREPRESENTATIONCODE = 56;
                    (* default: LL_CHAR_EXPRSEP *)
  LL_OPTION_DEFPRINTERINSTALLED  = 57;
                    (* r/o *)
  LL_OPTION_CALCSUMVARSONINVISIBLELINES = 58;
                    (* default: false - only default value if no preferences in project *)
  LL_OPTION_NOFOOTERPAGEWRAP     = 59;
                    (* default: false - only default value if no preferences in project *)
  LL_OPTION_IMMEDIATELASTPAGE    = 64;
                    (* default: true *)
  LL_OPTION_LCID                 = 65;
                    (* default: LOCALE_USER_DEFAULT *)
  LL_OPTION_TEXTQUOTEREPRESENTATIONCODE = 66;
                    (* default: 1 *)
  LL_OPTION_SCALABLEFONTSONLY    = 67;
                    (* default: 1, 0 = all fonts, 2 = only TRUETYPE fonts (ignoring that the device may have downloadable truetype fonts), all others: all but raster fonts *)
  LL_OPTION_NOTIFICATIONMESSAGEHWND = 68;
                    (* default: NULL (parent window handle) *)
  LL_OPTION_DEFDEFFONT           = 69;
                    (* default: GetStockObject(ANSI_VAR_FONT) *)
  LL_OPTION_CODEPAGE             = 70;
                    (* default: CP_ACP; set codepage to use for conversions. *)
  LL_OPTION_FORCEFONTCHARSET     = 71;
                    (* default: false; set font's charset to the codepage according to LL_OPTION_LCID. Default: FALSE *)
  LL_OPTION_COMPRESSRTF          = 72;
                    (* default: true; compress RTF text > 1024 bytes in project file *)
  LL_OPTION_ALLOW_LLX_EXPORTERS  = 74;
                    (* default: true; allow ILlXExport extensions *)
  LL_OPTION_SUPPORTS_PRNOPTSTR_EXPORT = 75;
                    (* default: false: hides "set to default" button in "export option" tab in designer *)
  LL_OPTION_DEBUGFLAG            = 76;
  LL_OPTION_SKIPRETURNATENDOFRTF = 77;
                    (* default: false *)
  LL_OPTION_INTERCHARSPACING     = 78;
                    (* default: false: allows character interspacing in case of block justify *)
  LL_OPTION_INCLUDEFONTDESCENT   = 79;
                    (* default: true *)
  LL_OPTION_RESOLUTIONCOMPATIBLETO9X = 80;
                    (* DEPRECATED. default: false  *)
  LL_OPTION_USECHARTFIELDS       = 81;
                    (* default: false *)
  LL_OPTION_OFNDIALOG_NOPLACESBAR = 82;
                    (* default: false; do not use "Places" bar in NT2K? *)
  LL_OPTION_SKETCH_COLORDEPTH    = 83;
                    (* default: 24 *)
  LL_OPTION_FINAL_TRUE_ON_LASTPAGE = 84;
                    (* default: false: internal use *)
  LL_OPTION_INTERCHARSPACING_FORCED = 86;
                    (* default: false: forces character interspacing calculation in TEXT objects (possibly dangerous and slow) *)
  LL_OPTION_RTFAUTOINCREMENT     = 87;
                    (* default: false, to increment RTF char pointer if nothing can be printed *)
  LL_OPTION_UNITS_DEFAULT        = 88;
                    (* default: LL_OPTION_UNITS_SYSDEFAULT. Use for contols that query the units, where we need to return "sysdefault" also *)
  LL_OPTION_NO_MAPI              = 89;
                    (* default: false. Inhibit MAPI load for preview *)
  LL_OPTION_TOOLBARSTYLE         = 90;
                    (* default: LL_OPTION_TOOLBARSTYLE_STANDARD|LL_OPTION_TOOLBARSTYLEFLAG_DOCKABLE *)
  LL_OPTION_TOOLBARSTYLE_STANDARD = 0;
                    (* OFFICE97 alike style  *)
  LL_OPTION_TOOLBARSTYLE_OFFICEXP = 1;
                    (* DOTNET/OFFICE_XP alike style  *)
  LL_OPTION_TOOLBARSTYLE_OFFICE2003 = 2;
  LL_OPTION_TOOLBARSTYLEMASK     = $0f;
  LL_OPTION_TOOLBARSTYLEFLAG_GRADIENT = $80;
                    (* starting with XP, use gradient style  *)
  LL_OPTION_TOOLBARSTYLEFLAG_DOCKABLE = $40;
                    (* dockable toolbars?  *)
  LL_OPTION_TOOLBARSTYLEFLAG_CANCLOSE = $20;
                    (* internal use only  *)
  LL_OPTION_TOOLBARSTYLEFLAG_SHRINK_TO_FIT = $10;
                    (* internal use only  *)
  LL_OPTION_MENUSTYLE            = 91;
                    (* default: LL_OPTION_MENUSTYLE_STANDARD *)
  LL_OPTION_MENUSTYLE_STANDARD_WITHOUT_BITMAPS = 0;
                    (* values: see CTL  *)
  LL_OPTION_MENUSTYLE_STANDARD   = 1;
  LL_OPTION_MENUSTYLE_OFFICEXP   = 2;
  LL_OPTION_MENUSTYLE_OFFICE2003 = 3;
  LL_OPTION_RULERSTYLE           = 92;
                    (* default: LL_OPTION_RULERSTYLE_FLAT *)
  LL_OPTION_RULERSTYLE_FLAT      = $10;
  LL_OPTION_RULERSTYLE_GRADIENT  = $80;
  LL_OPTION_STATUSBARSTYLE       = 93;
  LL_OPTION_STATUSBARSTYLE_STANDARD = 0;
  LL_OPTION_STATUSBARSTYLE_OFFICEXP = 1;
  LL_OPTION_STATUSBARSTYLE_OFFICE2003 = 2;
  LL_OPTION_TABBARSTYLE          = 94;
  LL_OPTION_TABBARSTYLE_STANDARD = 0;
  LL_OPTION_TABBARSTYLE_OFFICEXP = 1;
  LL_OPTION_TABBARSTYLE_OFFICE2003 = 2;
  LL_OPTION_DROPWINDOWSTYLE      = 95;
  LL_OPTION_DROPWINDOWSTYLE_STANDARD = 0;
  LL_OPTION_DROPWINDOWSTYLE_OFFICEXP = 1;
  LL_OPTION_DROPWINDOWSTYLE_OFFICE2003 = 2;
  LL_OPTION_DROPWINDOWSTYLEMASK  = $0f;
  LL_OPTION_DROPWINDOWSTYLEFLAG_CANCLOSE = $20;
  LL_OPTION_INTERFACEWRAPPER     = 96;
                    (* returns IL<n>* *)
  LL_OPTION_FONTQUALITY          = 97;
                    (* LOGFONT.lfQuality, default: DEFAULT_QUALITY *)
  LL_OPTION_FONTPRECISION        = 98;
                    (* LOGFONT.lfOutPrecision, default: OUT_STRING_PRECIS *)
  LL_OPTION_UISTYLE              = 99;
                    (* UI collection, w/o *)
  LL_OPTION_UISTYLE_STANDARD     = 0;
                    (* 90=0x40, 91=1, 92=0x10, 93=0, 94=0, 95=0x20  *)
  LL_OPTION_UISTYLE_OFFICEXP     = 1;
                    (* 90=0x41, 91=2, 92=0x10, 93=1, 94=1, 95=0x21  *)
  LL_OPTION_UISTYLE_OFFICE2003   = 2;
                    (* 90=0x42, 91=3, 92=0x10, 93=2, 94=2, 95=0x22  *)
  LL_OPTION_NOFILEVERSIONUPGRADEWARNING = 100;
                    (* default: false *)
  LL_OPTION_UPDATE_FOOTER_ON_DATALINEBREAK_AT_FIRST_LINE = 101;
                    (* default: false *)
  LL_OPTION_ESC_CLOSES_PREVIEW   = 102;
                    (* shall ESC close the preview window (default: false) *)
  LL_OPTION_VIEWER_ASSUMES_TEMPFILE = 103;
                    (* shall the viewer assume that the file is a temporary file (and not store values in it)? default TRUE *)
  LL_OPTION_CALC_USED_VARS       = 104;
                    (* default: true *)
  LL_OPTION_NOPRINTJOBSUPERVISION = 106;
                    (* default: true *)
  LL_OPTION_CALC_SUMVARS_ON_PARTIAL_LINES = 107;
                    (* default: false *)
  LL_OPTION_BLACKNESS_SCM        = 108;
                    (* default: 0 *)
  LL_OPTION_PROHIBIT_USERINTERACTION = 109;
                    (* default: false *)
  LL_OPTION_PERFMON_INSTALL      = 110;
                    (* w/o, TRUE to install, FALSE to uninstall *)
  LL_OPTION_RESERVED111          = 111;
  LL_OPTION_VARLISTBUCKETCOUNT   = 112;
                    (* applied to future jobs only, default 1000 *)
  LL_OPTION_MSFAXALLOWED         = 113;
                    (* global flag - set at start of LL! Will allow/prohibit fax detection. Default: TRUE *)
  LL_OPTION_AUTOPROFILINGTICKS   = 114;
                    (* global flag - set at start of LL! Activates LL's thread profiling *)
  LL_OPTION_PROJECTBACKUP        = 115;
                    (* default: true *)
  LL_OPTION_ERR_ON_FILENOTFOUND  = 116;
                    (* default: false *)
  LL_OPTION_NOFAXVARS            = 117;
                    (* default: false *)
  LL_OPTION_NOMAILVARS           = 118;
                    (* default: false *)
  LL_OPTION_PATTERNRESCOMPATIBILITY = 119;
                    (* default: false *)
  LL_OPTION_NODELAYEDVALUECACHING = 120;
                    (* default: false *)
  LL_OPTION_FEATURE              = 1000;
  LL_OPTION_FEATURE_CLEARALL     = 0;
  LL_OPTION_FEATURE_SUPPRESS_JPEG_DISPLAY = 1;
  LL_OPTION_FEATURE_SUPPRESS_JPEG_CREATION = 2;
  LL_OPTION_VARLISTDISPLAY       = 121;
                    (* default: LL_OPTION_VARLISTDISPLAY_FOLDERPOS_TOP | LL_OPTION_VARLISTDISPLAY_VARSORT_ALPHA *)
  LL_OPTION_VARLISTDISPLAY_VARSORT_DECLARATIONORDER = $0000;
  LL_OPTION_VARLISTDISPLAY_VARSORT_ALPHA = $0001;
  LL_OPTION_VARLISTDISPLAY_VARSORT_MASK = $000f;
  LL_OPTION_VARLISTDISPLAY_FOLDERPOS_DECLARATIONORDER = $0000;
  LL_OPTION_VARLISTDISPLAY_FOLDERPOS_ALPHA = $0010;
                    (* only if LL_OPTION_VARLISTDISPLAY_VARSORT_ALPHA* is set  *)
  LL_OPTION_VARLISTDISPLAY_FOLDERPOS_TOP = $0020;
  LL_OPTION_VARLISTDISPLAY_FOLDERPOS_BOTTOM = $0030;
  LL_OPTION_VARLISTDISPLAY_FOLDERPOS_MASK = $00f0;
  LL_OPTION_VARLISTDISPLAY_LLFOLDERPOS_BOTTOM = $0100;
  LL_OPTION_VARLISTDISPLAY_INITSCROLLPOS_TOP = $0200;
  LL_OPTION_VARLISTDISPLAY_ALPHASORT_RESPECT_NUMBERS = $0400;
  LL_OPTION_WORKAROUND_RTFBUG_EMPTYFIRSTPAGE = 122;
  LL_OPTION_FORMULASTRINGCOMPARISONS_CASESENSITIVE = 123;
                    (* default: true *)
  LL_OPTION_FIELDS_IN_PROJECTPARAMETERS = 124;
                    (* default: false *)
  LL_OPTION_CHECKWINDOWTHREADEDNESS = 125;
                    (* default: false *)
  LL_OPTION_ISUSED_WILDCARD_AT_START = 126;
                    (* default: false *)
  LL_OPTION_ROOT_MUST_BE_MASTERTABLE = 127;
                    (* default: false *)
  LL_OPTION_DLLTYPE              = 128;
                    (* r/o *)
  LL_OPTION_DLLTYPE_32BIT        = $0001;
  LL_OPTION_DLLTYPE_64BIT        = $0002;
  LL_OPTION_DLLTYPE_BITMASK      = $000f;
  LL_OPTION_DLLTYPE_SDBCS        = $0010;
  LL_OPTION_DLLTYPE_UNICODE      = $0020;
  LL_OPTION_DLLTYPE_CHARSET      = $00f0;
  LL_OPTION_HLIBRARY             = 129;
                    (* r/o *)
  LL_OPTION_INVERTED_PAGEORIENTATION = 130;
                    (* default: false *)
  LL_OPTION_ENABLE_STANDALONE_DATACOLLECTING_OBJECTS = 131;
                    (* default: false *)
  LL_OPTION_USERVARS_ARE_CODESNIPPETS = 132;
                    (* default: false *)
  LL_OPTION_STORAGE_ADD_SUMMARYINFORMATION = 133;
                    (* default: false *)
  LL_OPTION_INCREMENTAL_PREVIEW  = 135;
                    (* default: true *)
  LL_OPTION_RELAX_AT_SHUTDOWN    = 136;
                    (* default: true *)
  LL_OPTION_NOPRINTERPATHCHECK   = 137;
                    (* default: false *)
  LL_OPTION_SUPPORT_HUGESTORAGEFS = 138;
                    (* deprecated, always true *)
  LL_OPTION_NOAUTOPROPERTYCORRECTION = 139;
                    (* default: false *)
  LL_OPTION_NOVARLISTRESET_ON_RESETPROJECTSTATE = 140;
                    (* default: false; *)
  LL_OPTION_DESIGNERPREVIEWPARAMETER = 141;
                    (* default: NULL *)
  LL_OPTION_RESERVED142          = 142;
  LL_OPTION_DESIGNEREXPORTPARAMETER = 143;
                    (* default: NULL *)
  LL_OPTION_DESIGNERPRINT_SINGLETHREADED = 144;
                    (* default: false *)
  LL_OPTION_ALLOW_COMMENTS_IN_FORMULA = 145;
                    (* default: true *)
  LL_OPTION_USE_MLANG_LINEBREAKALGORITHM = 146;
                    (* default: false (would use MLANG to calculate the line break algorithm) *)
  LL_OPTION_USE_JPEG_OR_PNG_OPTIMIZATION = 147;
                    (* default: true *)
  LL_OPTION_ENABLE_IMAGESMOOTHING = 148;
                    (* default: true (uses GDIPLUS - no smoothing on Win2000/98 if not GDIPLUS installed! Right now, applies only to JPEG.) *)
  LL_OPTION_MAXRTFVERSION_AVAILABLE = 159;
                    (* r/o *)
  LL_OPTION_CONDREPRESENTATIONCODES_LIKE_ANSI = 160;
                    (* default: false *)
  LL_OPTION_NULL_IS_NONDESTRUCTIVE = 161;
                    (* default: false *)
  LL_OPTION_DRILLDOWNPARAMETER   = 162;
                    (* default: NULL *)
  LL_OPTION_ROUNDINGSTRATEGY     = 163;
                    (* default: LL_ROUNDINGSTRATEGY_ARITHMETIC_SYMMETRIC *)
  LL_ROUNDINGSTRATEGY_BANKERSROUNDING = 0;
  LL_ROUNDINGSTRATEGY_ARITHMETIC_SYMMETRIC = 1;
  LL_OPTION_RESERVED164          = 164;
  LL_OPTION_RESERVED165          = 165;
  LL_OPTION_PICTURE_TRANSPARENCY_IS_WHITE = 166;
                    (* default: false (transparent) *)
  LL_OPTION_FLOATPRECISION       = 167;
                    (* global (not job specific!). Default: 0 (192 bit mantissa, 32 bit exponent) *)
  LL_OPTION_SUPPRESS_LRUENTRY    = 168;
  LL_OPTION_FORCEFIRSTGROUPHEADER = 169;
                    (* default: false (group match string is an empty string) *)
  LL_OPTION_SUPPORT_PDFINPUTFIELDS = 170;
                    (* PDF 3.0 supports text objects and check boxes as input objects - default: true *)
  LL_OPTION_ENHANCED_SKIPRETURNATENDOFRTF = 171;
                    (* default: false. *)
  LL_OPTION_HIERARCHICALDATASOURCE = 172;
                    (* default: false *)
  LL_OPTION_FORCE_HEADER_EVEN_ON_LARGE_FOOTERLINES = 173;
                    (* default: false *)
  LL_OPTION_PRINTERDEVICEOPTIMIZATION = 174;
                    (* default: true *)
  LL_OPTION_RTFHEIGHTSCALINGPERCENTAGE = 175;
                    (* default: 100 *)
  LL_OPTION_FORCE_DEFAULT_PRINTER_IN_PREVIEW = 176;
                    (* default: false *)
  LL_OPTION_SAVE_PROJECT_IN_UTF8 = 178;
                    (* INT, default 0 (meaning: project is saved as UTF16 if A API is not used), 1 (UTF-8 with BOM), 2 (UTF-8 without BOM) *)
  LL_DRILLDOWNFILTERSTRATEGY_ALLOW_ONLY_SUBTABLES = 0;
  LL_DRILLDOWNFILTERSTRATEGY_ALLOW_ALL_TABLES = 1;
  LL_DRILLDOWNFILTERSTRATEGY_ALLOW_SUBTABLES_AND_UNRELATED = 2;
  LL_DRILLDOWNFILTERSTRATEGY_ALLOW_SUBTABLES_AND_USERDEFINED = 3;
  LL_DRILLDOWNFILTERSTRATEGY_MASK = $0f;
  LL_DRILLDOWNFILTERFLAG_OFFER_BASERECORD_AS_VARIABLES = $10;
  LL_OPTION_DRILLDOWN_DATABASEFILTERING = 179;
                    (* default: 0 (filter all except subtables of the base table: LL_DRILLDOWNFILTERSTRATEGY_ALLOW_ONLY_SUBTABLES) *)
  LL_OPTION_SUPPRESS_TASKBARBUTTON_PROGRESSSTATE = 180;
                    (* default: false *)
  LL_OPTION_PRINTDLG_DEVICECHANGE_KEEPS_DEVMODESETTINGS = 181;
                    (* default: true *)
  LL_OPTION_DRILLDOWN_SUPPORTS_EMBEDDING = 182;
                    (* default: true *)
  LL_VARLISTCLEARSTRATEGY_EMPTY_LIST = 0;
  LL_VARLISTCLEARSTRATEGY_SET_NULL = 1;
  LL_VARLISTCLEARSTRATEGY_SET_DEFAULT = 2;
  LL_OPTION_VARLISTCLEARSTRATEGY_ON_DEFINE_START = 183;
                    (* default: LL_VARLISTCLEARSTRATEGY_EMPTY_LIST *)
  LL_OPTION_RESERVED184          = 184;
  LL_OPTION_KEEP_EMPTY_SUM_VARS  = 185;
                    (* default: false *)
  LL_OPTION_RESERVED187          = 187;
                    (* internal test flag *)
  LL_OPTION_DEFAULTDECSFORSTR    = 188;
                    (* default: 5. Sets the default number of decimals for Str$ *)
  LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_PRINTJOB = 189;
                    (* default: false *)
  LL_OPTION_DEFINEXXXSTART_COMPATIBLE_TO_PRE15 = 190;
  LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_DC = 191;
                    (* default: true *)
  LL_OPTION_BITMAP_RESOLUTION_FOR_PREVIEW = 192;
                    (* default: 0 (leave original size), suggestions are 300 or 600. -1 to use device default. *)
  LL_OPTION_DRAW_EMPTY_CHARTOBJECTS = 193;
                    (* default: false *)
  LL_OPTION_PREVIOUS_DEFAULTS_TO_NULL = 194;
                    (* default: false (for compatibility). Previous() returns NULL on first record if TRUE, otherwise some default value for the given datatype. *)
  LL_OPTION_FORCE_IMAGEEMBEDDING = 195;
                    (* default: false. Images added via the image dialog are always embedded. *)
  LL_OPTION_VARKEY_MAP_SHARP_S_TO_SS = 196;
                    (* default: false *)
  LL_OPTION_NO_LAYERED_WINDOWS   = 197;
                    (* default: false *)
  LL_OPTION_SCALED_PERCENTAGEFORMATTER = 198;
                    (* default: false (0.1="0.1%", true: 0.1="10%") *)
  LL_OPTION_USE_ANTIALIAS        = 199;
                    (* default: true *)
  LL_OPTION_FORCETABLELINECALLBACK = 200;
                    (* LL_CMND_TABLE_LINE is called even when COLORINGMODE_LL ist set, default: false *)
  LL_OPTION_EXPORTCONSUMER       = 201;
                    (* internal use only *)
  LL_OPTION_TOC_IDX_ITEMID       = 202;
                    (* internal use only *)
  LL_OPTION_FORCED2PASSMODE      = 203;
                    (* default: false *)
  LL_OPTION_SETVAR_ONLY_SETS_IF_CONTAINER_PRINTS = 204;
                    (* default: false *)
  LL_OPTION_SHOW_PREVIEW_AFTER_PRINT_END = 206;
                    (* "Export-ShowResult" sets this for PRV... *)
  LL_OPTION_PROPLIST_COMBOBOX_SCROLL_WRAPS = 207;
                    (* default: FALSE *)
  LL_OPTION_ALWAYS_CALC_GROUPCHANGE_CONDITION = 208;
                    (* default: false *)
  LL_OPTION_NULLHANDLING_SUPPORTED_IN_ENHMODE = 209;
                    (* default: false  *)
  LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_PREVIEWJOB = 210;
                    (* default: true *)
  LL_OPTION_USE_LEGACY_WORDWRAPPINGALGORITHM = 211;
                    (* default: false *)
  LL_OPTION_PREVIEW_USES_PRINTTHREAD = 212;
                    (* default: true *)
  LL_OPTION_LL_SUPPLIES_MESSAGELOOP_WHILE_PRINTING_TO_PREVIEW = 213;
                    (* default: true *)
  LL_OPTION_PRINTERDCCACHE_TIMEOUT_SEC = 214;
                    (* default: 60 (0 -> no cache) *)
  LL_OPTION_DESIGNER_RIBBONBACKGROUNDCOLOR = 215;
                    (* default: undefined (system default) *)
  LL_OPTION_INTERNAL_EMFCLEANUP  = 216;
                    (* no comment -> internal! *)
  LL_OPTION_RIBBON_DEFAULT_ENABLEDSTATE = 217;
                    (* default: true *)
  LL_OPTION_PRVFILEVERSION       = 218;
                    (* default: 0 (2 would be an optimized version, supported since LL18, usually a bit faster if printing > 5000 pages) *)
  LL_OPTION_TRY_REDUCE_BMPSIZE_BY_CONVERTING_TO_PNG_OR_JPEG = 219;
                    (* default: false *)
  LL_OPTION_NO_IMAGEFILEOPTIMIZATION = 220;
                    (* default: false. Set this to TRUE if you know you're replacing an image file during printing that is used in a project using its file name *)
  LL_OPTION_NO_ENFORCED_GROUPFOOTERPRIORITY_FOR_LAST_GROUPFOOTER = 221;
                    (* default: false. Compatibility to LL 16.008. *)
  LL_OPTION_ALLOW_COMBINED_COLLECTING_OF_DATA_FOR_COLLECTIONCONTROLS = 222;
                    (* default: true *)
  LL_OPTION_SUPPRESS_LOADERRORMESSAGES = 223;
                    (* default: false. Please take care that this is a reference counted flag, so add (true) and subtract (false) the same number of calls! [ChK] *)
  LL_OPTION_IGNOREFORMULARESULTMISMATCH_AT_LOADTIME = 224;
                    (* default: false. Switches the r8117 (err #3535) change back to the old behavior *)
  LL_OPTION_MAX_SIZE_OF_PROJECTINFOCACHE = 225;
                    (* default: 1000 *)
  LL_OPTION_NO_CORRECTION_OF_UNICODE_RTF = 226;
                    (* default: false *)
  LL_OPTION_MAY_RELEASE_UNNECESSARY_PROPS_AT_PRINTTIME = 227;
                    (* default: false *)
  LL_OPTION_DO_NOT_RESTORE_PREVSTATE_ON_FILTER_MISMATCH = 228;
                    (* default: false (LL17: implicitly TRUE until 17.006) *)
  LL_OPTION_SUPPORT_USERDEFINED_REPORTPAGELAYOUT = 229;
                    (* default: false *)
  LL_OPTION_DESIGNER_RIBBONTEXTCOLOR = 230;
                    (* default: undefined (system default) *)
  LL_PARTSHARINGFLAG_VARIABLES_TOC = $01;
  LL_PARTSHARINGFLAG_VARIABLES_IDX = $02;
  LL_PARTSHARINGFLAG_VARIABLES_GTC = $04;
  LL_OPTION_PARTSHARINGFLAGS     = 231;
                    (* default: 0xff *)
  LL_OPTION_PIECHARTORDER_COMPATIBLE_TO_PRE19 = 232;
                    (* default: 1 (LL18), 0 (>= LL19) *)
  LL_OPTION_DATABASESTRUCTURE_SORT_DECLARATIONORDER = 233;
                    (* default: false (sorted alphabetically) *)
  LL_OPTION_REPORT_PARAMETERS_REALDATAJOBPARAMETER = 234;
                    (* default: NULL *)
  LL_OPTION_EXPANDABLE_REGIONS_REALDATAJOBPARAMETER = 235;
                    (* default: NULL *)
  LL_OPTION_IMPROVED_TABLELINEANCHORING = 236;
                    (* default: TRUE *)
  LL_OPTION_INTERACTIVESORTING_REALDATAJOBPARAMETER = 237;
                    (* default: NULL *)
  LL_OPTION_TEMPFILESTRATEGY     = 238;
                    (* default: LL_TEMPFILESTRATEGY_SPEED *)
  LL_TEMPFILESTRATEGY_SPEED      = 0;
  LL_TEMPFILESTRATEGY_SIZE       = 1;
  LL_TEMPFILESTRATEGY_SECURITY   = 2;
  LL_OPTION_RTF_WHITE_BACKGROUND_IS_TRANSPARENT = 239;
                    (* default: TRUE (!) *)
  LL_OPTION_NO_DOTTED_LINE_ON_SECONDARY_AXIS = 240;
                    (* default: FALSE *)
  LL_OPTION_NO_PREVIOUS_VARLIST  = 241;
  LL_OPTION_COMMIT_FILE_ON_SAVE  = 242;
                    (* default: false *)
  LL_OPTION_DO_NOT_RTRIM_CELLTEXT = 243;
                    (* default: false *)
  LL_OPTION_ALLOW_FCT_TEXTWIDTH  = 244;
                    (* default: false *)
  LL_OPTION_PASTEOBJECTS_TO_FIRST_VISIBLE_LAYER = 245;
                    (* default: false *)
  LL_OPTION_EMPTY_FILE_TRIGGERS_PROJECT_WIZARD = 246;
                    (* default: false *)
  LL_OPTION_DELAY_UPDATE_REMAININGTABLESPACE = 247;
                    (* default: false  *)
  LL_OPTION_WIZARD_ADDS_ORGNAME_TO_UI = 248;
                    (* default: false *)
  LL_OPTION_PROHIBIT_EXTERNAL_FILES = 249;
                    (* default: false *)
  LL_OPTION_DRAWINGS_INLINED     = 250;
                    (* default: 0 (1 = inlined, 2 = leave as is, but no BLOBs - for GTC) *)
  LL_OPTION_SERIALIZE_PRINTAPI   = 251;
                    (* default: false *)
  LL_OPTION_PROJECTFILELOCKTIMEOUT_IN_MS = 252;
                    (* default: 10000 *)
  LL_OPTION_ILLDATAPROVIDER      = 253;
  LL_OPTION_RTF_SUPPORTS_PARABREAKOPTIONS = 254;
                    (* default: false *)
  LL_OPTION_FORCE_PDFEMBEDDING   = 255;
                    (* default: false. PDF documents added via the pdf dialog are always embedded *)
  LL_OPTION_IGNORE_NONSCALEABLEFONTPROPERTIES = 256;
                    (* default: false. PDF documents added via the pdf dialog are always embedded *)
  LL_DATAPROVIDERTHREADNESS_NONE = 0;
  LL_DATAPROVIDERTHREADNESS_ONE_INSTANCE_PER_THREAD = 1;
  LL_DATAPROVIDERTHREADNESS_DONTCARE = 2;
                    (* default  *)
  LL_OPTION_DATAPROVIDER_THREADEDNESS = 257;
  LL_OPTION_SUBREPORT_BASE       = 258;
  LL_OPTION_SUBREPORT_CLIENT     = 259;
  LL_OPTION_NO_IPICTURE_SUPPORT  = 260;
                    (* default: false *)
  LL_OPTION_FORCE_JPEG_RECOMPRESSION = 261;
                    (* default: false *)
  LL_OPTION_TEXTWRAP_TOLERANCE_PERC = 262;
                    (* default: 0 (no tolerance) *)
  LL_OPTION_NO_USERVARCHECK_ON_LOAD = 263;
                    (* default: false *)
  LL_OPTION_TOC_IDX_PAGE         = 264;
                    (* internal use only *)
  LL_OPTION_RTF_TAB_KEY_IS_TAB_FORMATTER = 265;
                    (* default: false *)
  LL_OPTION_VARLISTDISPLAY_LL_FOLDER_AT_END = 266;
                    (* default: false *)
  LL_OPTION_DOM_DO_NOT_KILL_EMPTY_TABLE = 267;
                    (* default: false *)
  LL_OPTION_ENABLE_INPUTOBJECTS_IN_TABLES = 268;
                    (* default: true *)
  LL_OPTION_MAX_ENTRIES_FOR_AUTOCOMPLETE = 269;
                    (* default: 200 *)
  LL_OPTION_DEFAULT_FOR_SHADOWPAGEWRAP = 270;
                    (* default: true *)
  LL_OPTION_MAX_UNDO_STEPS       = 271;
                    (* default: 10 *)
  LL_OPTION_HTML_USE_MAILFORMAT  = 272;
                    (* default: false *)
  LL_OPTION_CLIP_LABELS_TO_PROJECTAREA = 273;
                    (* default: false (may paint beyond the border not to lose any data) *)
  LL_OPTION_RESETPROJECTSTATE_FORCES_NEW_EXPORTJOB = 274;
  LL_OPTION_SCRIPTENGINE_ENABLED = 276;
                    (* default: false *)
  LL_OPTION_SCRIPTENGINE_TIMEOUTMS = 277;
                    (* default: 10000 *)
  LL_OPTION_SCRIPTENGINE_AUTOEXECUTE = 278;
                    (* default: false *)
  LL_OPTION_SHAPEFILE_TIMEOUTMS  = 279;
                    (* default: 1000  *)
  LL_OPTION_COUNTALLPRINTEDDATA_LASTPRINT = 280;
                    (* r/o *)
  LL_OPTION_SAVE_AS_ACTS_AS_EXPORT = 281;
                    (* default: false *)
  LL_OPTION_RESETPROJECTSTATE_TRIGGERS_NEW_SHEET = 282;
                    (* default: true *)
  LL_OPTION_HIDE_EXPORT_TAB_FROM_LAYOUT_CONFIG = 283;
                    (* default: false *)
  LL_OPTION_USE_VARLIST_NAMESORTINDEXCACHE = 284;
                    (* should be defined for job -1 *)
  LL_OPTION_NOCONTRASTOPTIMIZATION = 285;
                    (* default: false *)
  LL_OPTION_AUTORECOVERY_DISABLED = 286;
                    (* default: false *)
  LL_OPTION_AUTORECOVERY_SAVEOPTIONS = 287;
                    (* default: LL_AUTORECOVERY_SAVEOPTIONS_NEWFILE (value might be combination of following) *)
  LL_AUTORECOVERY_SAVEOPTIONS_NEWFILE = 1;
  LL_AUTORECOVERY_SAVEOPTIONS_OVERWRITE = 2;
  LL_OPTION_LINK_PRINTERQUEUES   = 288;
                    (* default: false, does not work yet *)
  LL_OPTION_FORCE_RTFMERGING     = 289;
                    (* default: false, forces to merge RTF contents even if there is just one part to load, compatibility switch *)
  LL_OPTION_W201512300001        = 290;
                    (* do not check on empty bodylines for "ActivateNextLine" - sort of "I know what I am doing in my print loop" *)
  LL_OPTION_CALCLINEHEIGHT_COMPATIBLE_TO_19 = 291;
                    (* LL19 had a wrong line height calculation, force compatible mode. Default: false. *)
  LL_OPTION_FORCE_UNIQUE_PARAMETERUISTRING = 292;
                    (* Report parameter UI strings will be forced as unique. Default: false. *)
  LL_OPTION_AUTOMATICFOOTER      = 293;
                    (* Creates automatically footer-line in table-line wizard. Default: true. *)
  LL_OPTION_SUPPORT_PREDEFINED_COLORS = 294;
                    (* default: for design/print job: always true. Otherwise false. *)
  LL_OPTION_FAVORITE_SETTINGS    = 295;
                    (* default: display button and use registry settings *)
  LL_FAVORITES_ENABLE_FAVORITES_BY_DEFAULT = $0001;
  LL_FAVORITES_HIDE_FAVORITES_BUTTON = $0002;
  LL_OPTION_NEWMODE_EXPRSTARTREPRESENTATIONCODE = 296;
                    (* default: 0xab *)
  LL_OPTION_NEWMODE_EXPRENDREPRESENTATIONCODE = 297;
                    (* default: 0xbb *)
  LL_OPTION_RESERVED_298         = 298;
                    (* outdated, not used any more *)
  LL_OPTION_ILLREPOSITORY        = 299;
                    (* host repository *)
  LL_OPTION_VARLISTLOOKUP_ALLOWS_GLOBALNAME = 300;
                    (* default: 0 *)
  LL_OPTION_FORCESAVEDESIGNSCHEME = 301;
                    (* default: false *)
  LL_OPTION_REPOSITORY_SINGLEPROJECTMODE = 302;
                    (* default: false *)
  LL_OPTION_ANIMATIONS_DISABLED  = 303;
                    (* default: 0 *)
  LL_OPTION_ANIMATIONS_DISABLED_DISABLEALL = $01;
  LL_OPTION_ANIMATIONS_DISABLED_HIDE_STD = $02;
  LL_OPTION_ANIMATIONS_DISABLED_HIDE_HTML = $04;
                    (*    *)
  LL_OPTION_UPDATE_INTERACTIONINFO_PER_PAGE = 304;
                    (* default: false. "true" means some overhead per page *)
  LL_OPTION_IS_REPORTSERVERDESIGNER = 305;
                    (* internal *)
  LL_OPTION_IMPROVED_FRAMEDRAWING = 306;
                    (* default: false *)
  LL_OPTION_POSTPAINT_TABLESEPARATORS = 307;
                    (* default: true *)
  LL_OPTION_CROSSTAB_USE_CELLVALUE_INSTEAD_OF_DISPLAYVALUE = 308;
                    (* default: false; *)
  LL_OPTION_SUPPORT_DELAYEDFIELDDEFINITION = 309;
                    (* default: false *)
  LL_OPTION_SUPPRESS_REALDATAPREVIEW_IN_DESIGNER = 310;
                    (* default: false *)
  LL_OPTION_MAX_RTFCONTROLS_IN_CACHE = 311;
                    (* default: 50 *)
  LL_OPTION_RDPEXPORT_CREATEMPFILEUNTILSAVEDONCE = 312;
                    (* internal *)
  LL_OPTION_CRC32_ONLY_FOR_RTFDATA_ABOVE = 313;
                    (* limit of RTF stream size (in KB) up to which RTF text and BLOBs are compared using MD5 - above, it's CRC32 only. Default: 100 KB *)
  LL_OPTION_PRINTER_FILE_SUPERSEDES_EXPORT_OPTIONS = 314;
                    (* settings in printer file supersede explicit export options *)
  LL_OPTION_TRANSLATIONFLAGS     = 315;
                    (* default: both directions. Right now, only the omittance of _SAVE works. *)
  LL_TRANSLATION_LOAD            = $01;
  LL_TRANSLATION_SAVE            = $02;
  LL_OPTION_PREVIEW_SCALES_RELATIVE_TO_PHYSICAL_SIZE = 316;
                    (* needs >= Windows 8.1. Stored in preview file to modify behaviour in viewer *)
  LL_PREVIEW_SCALE_PHYSICAL_DESIGNERPREVIEW = $01;
  LL_PREVIEW_SCALE_PHYSICAL_PREVIEW = $02;
  LL_OPTION_NODEFAULTFONTOVERRIDE = 317;
                    (* default: false *)
  LL_OPTION_TREEVIEWFILTER_VISIBILITYFLAGS = 318;
                    (* default: LL_TREEVIEWFILTER_IN_ALL_TREES *)
  LL_TREEVIEWFILTER_IN_VARTREE   = $0001;
  LL_TREEVIEWFILTER_IN_FCTWIZARD_VARTREE = $0002;
  LL_TREEVIEWFILTER_IN_ALL_TREES = $ffff;
  LL_OPTION_COMPAT_ALLOW_INVALID_CHARS_IN_SINGLEFIELDFORMULA = 319;
                    (* default: FALSE *)
  LL_OPTION_TREEVIEWFILTER_MAXIMUM_RECURSION_SEARCH_DEPTH = 320;
                    (* default: 10 *)
  LL_OPTION_USER_ABORT_CANCELS_POSTPRINTPROCESSING = 321;
                    (* default: false *)
  LL_OPTION_NOTOCRESET_ON_RESETPROJECTSTATE = 322;
                    (* default: false *)
  LL_OPTION_NOIDXRESET_ON_RESETPROJECTSTATE = 323;
                    (* default: false *)
  LL_OPTION_SUPPRESS_FORMULASUBITEMS_IN_VARTREE = 324;
                    (* default: false *)
  LL_OPTION_TEMPLATE_OVERRIDES_USER_DESIGNSCHEME = 325;
                    (* default: true *)
  LL_OPTION_ALLOW_ASSUMPTION_PRINTERS_CAN_PRINT_MULTIPLE_JOBS_IN_ONE_HDC = 326;
                    (* default: true *)
  LL_OPTION_PERSISTENT_PRINTER_USE_FOR_OUTPUT = 327;
                    (* default: false *)
  LL_OPTION_GET_CURRENT_PROJECTTYPE = 328;
                    (* R/O *)
  LL_OPTION_DELAY_CALC_OF_USED_VARS = 329;
                    (* default: false *)
  LL_OPTION_USE_FONT_SIZE_AS_MAXIMUM_SIZE_FOR_TEXTFITTING = 330;
                    (* default: false *)
  LL_OPTION_CLIP_FIELDS_EXCEEDING_TABLE_WIDTH = 331;
                    (* default: 0 *)
  LL_CLIP_FIELDS_VISUALLY        = 1;
  LL_CLIP_FIELDS_FIT_AT_LOAD_TIME = 2;
  LL_CLIP_FIELDS_FIT_AT_LOAD_TIME_PRINTING_ONLY = 3;
  LL_CLIP_FIELDS_FIT_COMPAT      = 4;
  LL_CLIP_FIELDS_METHOD_MASK     = $0f;
  LL_CLIP_FIELDS_FLAG_IGNORE_APPEARANCE_CONDITION = $10;
  LL_CLIP_FIELDS_FLAG_INCLUDE_NONCONST_WIDTH = $20;
  LL_OPTION_COMPAT_ALLOW_FIELDS_IN_PROJECT_FILTER = 332;
                    (* default: false *)
  LL_OPTION_SUPPRESS_CELLCLIPPING_TO_REPORTCONTAINER = 333;
                    (* default: false *)
  LL_OPTION_RSCRIPT_MULTIJOBEXECUTION = 334;
                    (* default: 0 *)
  LL_OPTION_RETRIES_FOR_STARTDOC = 335;
                    (* INT, default: 1 *)
  LL_OPTION_PRN_FORCE_PROJECTSIZE_AS_PAPERSIZE = 336;
                    (* default: 0 (1: if "ForcePaperFormat"=TRUE, do not iterate available paper formats and look up a matching one, just put the selected size in the DEVMODE structure and hope for the printer to accept it. 3: ) *)
  LL_OPTION_IS_PRINTING          = 337;
                    (* r/o, returns if there's an active print job for the current job *)
  LL_OPTION_IDLEITERATIONCHECK_MAX_ITERATIONS = 338;
                    (* 0 = no check. default: 0 *)
  LL_REPOSITORYTHREADNESS_NONE   = 0;
  LL_REPOSITORYTHREADNESS_DONTCARE = 1;
                    (* default  *)
  LL_REPOSITORYTHREADNESS_QUERY  = 2;
  LL_OPTION_REPOSITORY_THREADEDNESS = 339;
  LL_OPTION_ALLOW_EMPTY_STRING_IN_XLAT = 340;
                    (* default: false *)
  LL_OPTION_GTC_LASTPOSITION_CONSIDER_INDEX = 341;
                    (* default: false *)
  LL_OPTION_DESIGNERACTIONMESSAGE = 342;
                    (* r/o - joba handle can be any value, this is global *)
  LL_DESIGNERACTION_REFRESH_VARTREE = 1;
  LL_OPTION_DESIGNERFRAME_HWND   = 343;
                    (* r/o *)
  LL_OPTION_MULTISECTIONPRINT_MERGE = 344;
                    (* r/o *)
  LL_OPTION_COMPAT_ALLOW_FIELDS_IN_STATIC_TABLE = 345;
                    (* default: FALSE *)
  LL_OPTION_COMPAT_GROUPHEADER_SAME_PAGE_LOCAL_ONLY = 346;
                    (* default: false (must be set to true to behave as LL24) *)
  LL_OPTION_RESERVED_348         = 348;
                    (* see #37979 *)
  LL_OPTION_COMPAT_PROHIBITFILTERRELATIONS = 349;
                    (* default: FALSE *)
  LL_OPTION_ONLY_SHOW_EXISTING_PAPERSIZES_FOR_PRINTER = 350;
                    (* default: false... do not add system defined papers to the ist of the printer's paper sizes unless the driver does not return any *)
  LL_OPTION_DEFAULT_DECIMALS     = 351;
                    (* default: settings from registry/2. ATTENTION: global option *)
  LL_OPTION_ILLPREPRINTTEXTPROCESSOR = 353;
                    (* ILLPrePrintTextProcessor *)
  LL_OPTION_USERVAR_TRACKTEMPLATEOVERRIDE = 354;
                    (* default: false *)
  LL_OPTION_PROJECTVAR_IGNOREEMPTY = 355;
                    (* default: false *)
  LL_OPTION_SUPPRESS_FUNCTION_POPUP = 356;
                    (* default: false *)
  LL_OPTION_SUPPRESS_SYMBOLFONTMAPPING = 357;
                    (* default: false - attn: global option! *)
  LL_OPTION_COMPAT_ENABLE_FORCEWRAP_ON_EXPORT = 358;
                    (* default: false *)
  LL_OPTION_SORTINDEX_LCMAP_INITFLAGVALUE = 359;
                    (* default: 0x1400 *)
  LL_OPTION_EXPANDABLE_REGIONS_FORCE_STATE = 360;
                    (* default: 0 *)
  LL_OPTION_EXPANDABLE_REGIONS_FORCE_STATE_NEUTRAL = 0;
                    (* default  *)
  LL_OPTION_EXPANDABLE_REGIONS_FORCE_STATE_OPEN = 1;
  LL_OPTION_EXPANDABLE_REGIONS_FORCE_STATE_CLOSE = 2;
  LL_OPTION_COMPAT_NULL_IN_COND_ARG1_YIELDS_NULL = 361;
                    (* default: false *)
  LL_OPTION_SUPPRESSCROSSTHREADEDWARNING = 362;
                    (* default: 0 *)
  LL_OPTION_ALLOWSUBREPORTS      = 363;
                    (* default: 1 *)
  LL_OPTION_INTERNALRELOADOPERATION = 364;
                    (* default: 0 *)
  LL_INTERNALRELOADOPERATION_NEUTRAL = 0;
                    (* default  *)
  LL_INTERNALRELOADOPERATION_LOAD = 1;
  LL_INTERNALRELOADOPERATION_ERRORLIST = 2;
  LL_OPTION_COMPAT_BODYLINE_CELL_MAY_WRAP_EMPTY_ON_FIRST_PRINT = 365;
                    (* default: false *)
  LL_OPTION_RTFEDITOR_SUPPRESS_KEYBOARDAUTOSWITCH = 366;
                    (* default: false *)
  LL_OPTION_BUILDTREERECURSEOPTIONS = 367;
                    (* default: 32 threshold for active stacksize based formula evaluation recursion detection *)
  LL_OPTION_GROUPFOOTERS_ARE_IMMUTABLE = 368;
                    (* default: false *)
  LL_OPTION_DOM_MULTITHREADED_ACCESS = 369;
                    (* default: false *)
  LL_OPTION_CHART_LL27_FEATURES  = 370;
                    (* default: 0 *)
  LL_OPTION_SET_PREVIEW_ID_IN_ASSOC_FOR_SINGLETHREADED_PRINT = 371;
                    (* w/o, internal. Important for single-threaded preview *)
  LL_OPTION_SUPPRESS_TOOLTIPHINTS = 372;
                    (* default: false *)
  LL_OPTION_PROJECTPARAMETER_PRINTLANGUAGE_SHOW = 373;
                    (* default: false *)
  LL_OPTION_TABLENAMETRANSLATION_NOT_DISTINCT = 374;
                    (* default: false *)
  LL_OPTION_PRINTERLESS          = 375;
                    (* default: false *)
  LL_OPTION_WEBDESIGNER_STATEFLAGS = 376;
                    (* internal *)
  LL_WEBDESIGNER_STATEFLAGS_ACTIVE = $1;
  LL_WEBDESIGNER_STATEFLAGS_PRINTING = $2;
  LL_WEBDESIGNER_STATEFLAGS_INTERNAL_MASK = $ffff0000;
  LL_WEBDESIGNER_STATEFLAGS_INTERNAL_TOCIDXATROOT = $10000;
  LL_OPTION_DOM_IGNORE_EXPRESSIONERRORS = 377;
                    (* internal *)
  LL_OPTION_SUPPRESS_EMPTY_PAGES_ON_PRINT = 378;
                    (* default: false *)
  LL_OPTION_VIRTUALDEVICE_SCALINGOPTIONS = 379;
  LL_VIRTUALDEVICE_SCALINGOPTION_UNSCALED = 0;
                    (* factor 1 (dim(DC) = dim(Project)/DPI(DC))  *)
  LL_VIRTUALDEVICE_SCALINGOPTION_OPTIMIZE_TO_SCREENRES = 1;
                    (* optimize DPI according to dim(DC)  *)
  LL_VIRTUALDEVICE_SCALINGOPTION_OPTIMIZE_TO_SCREENRES_AT_LEAST_ONE = 2;
                    (* optimize DPI according to dim(DC), but don't scale below 1 (dim(Project)/DPI(DC))  *)
  LL_VIRTUALDEVICE_SCALINGOPTION_FIXED_DPI_THRESHOLD_MIN = 72;
                    (* use any value above or equal (and below or equal to _MAX) as the resolution in DPI  *)
  LL_VIRTUALDEVICE_SCALINGOPTION_FIXED_DPI_THRESHOLD_MAX = 2400;
  LL_OPTION_IGNORE_PROJECTSOURCE_FOR_DEVICEMATCHING = 380;
                    (* default: false *)
  LL_OPTION_COMPAT_KEEPCASEDIFFONLYTABLENAMES = 381;
                    (* default: false *)
  LL_OPTION_COMPAT_CROSSTAB_GANTT_SUPPORT_MINHEIGHTVALUE = 382;
                    (* default: false *)
  LL_OPTION_RTF_SHARE_OBJECTS_THRESHOLD = 383;
                    (* default: 100 *)
  LL_OPTION_COMPAT_PROHIBIT_DYNAMIC_REPORTPARAMETERCOLLECTION = 384;
                    (* default: false *)
  LL_OPTION_COMPAT_FORCE_PRNOPT_PAGE = 385;
                    (* internal *)
  LL_OPTION_INTENTIONAL_USER_ABORT = 386;
                    (* internal, R/O *)
  LL_OPTION_PROHIBIT_OLE_OBJECTS_IN_RTF = 387;
  LL_OPTION_COMPAT_ENABLE_EMF_OPTIMIZATION_IN_PDF_OBJECT = 388;
                    (* default: false, LL28: true *)
  LL_OPTION_USESIMPLEWINDOWSPENSTYLE_FRAMEDRAWING = 389;
                    (* default: false *)
  LL_OPTION_DISABLE_GDIPLUS_PATHS_IN_EMFDRAWINGS = 390;
                    (* default: false *)
  LL_OPTION_KEEP_EXPORTER_CONTROL_FILES_IN_MEMORY = 391;
                    (* default: false *)
  LL_OPTION_ALLOW_EMBEDDING_OF_PICTURES = 392;
                    (* default: true *)
  LL_OPTION_COMPAT_ALLOW_NEGATIVE_DISTANCE_BEFORE = 393;
                    (* default: false *)
  LL_OPTION_COMPAT_NULLSAFE_PRE_26_003 = 394;
                    (* default: false *)
  LL_OPTION_DEFAULT_DATE_FORMAT_INCLUDES_TIME = 395;
                    (* default: false *)
  LL_OPTION_SVG_TO_DIB_RESOLUTION = 396;
                    (* default: 150 DPI. 0 to fit to printer resolution *)
  LL_OPTION_SVG_TO_DIB_MAX_SIZE  = 397;
                    (* max area in pixel, default: x * y < 5 MB *)
  LL_OPTIONSTR_LABEL_PRJEXT      = 0;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LABEL_PRVEXT      = 1;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LABEL_PRNEXT      = 2;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_CARD_PRJEXT       = 3;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_CARD_PRVEXT       = 4;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_CARD_PRNEXT       = 5;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LIST_PRJEXT       = 6;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LIST_PRVEXT       = 7;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LIST_PRNEXT       = 8;
                    (* internal... (compatibility to L6) *)
  LL_OPTIONSTR_LLXPATHLIST       = 12;
  LL_OPTIONSTR_SHORTDATEFORMAT   = 13;
  LL_OPTIONSTR_DECIMAL           = 14;
                    (* decimal point, default: system *)
  LL_OPTIONSTR_THOUSAND          = 15;
                    (* thousands separator, default: system *)
  LL_OPTIONSTR_CURRENCY          = 16;
                    (* currency symbol, default: system *)
  LL_OPTIONSTR_EXPORTS_AVAILABLE = 17;
                    (* r/o *)
  LL_OPTIONSTR_EXPORTS_ALLOWED   = 18;
  LL_OPTIONSTR_DEFDEFFONT        = 19;
                    (* in "{(r,g,b),size,<logfont>}" *)
  LL_OPTIONSTR_EXPORTFILELIST    = 20;
  LL_OPTIONSTR_VARALIAS          = 21;
                    (* "<local>=<global>" *)
  LL_OPTIONSTR_MAILTO            = 24;
                    (* default TO: address for mailing from viewer *)
  LL_OPTIONSTR_MAILTO_CC         = 25;
                    (* default CC: address for mailing from viewer *)
  LL_OPTIONSTR_MAILTO_BCC        = 26;
                    (* default BCC: address for mailing from viewer *)
  LL_OPTIONSTR_MAILTO_SUBJECT    = 27;
                    (* default subject for mailing from viewer *)
  LL_OPTIONSTR_SAVEAS_PATH       = 28;
                    (* default filename for saving the LL file from viewer *)
  LL_OPTIONSTR_LABEL_PRJDESCR    = 29;
                    (* "Etikett" ... *)
  LL_OPTIONSTR_CARD_PRJDESCR     = 30;
  LL_OPTIONSTR_LIST_PRJDESCR     = 31;
  LL_OPTIONSTR_LLFILEDESCR       = 32;
                    (* "Vorschau-Datei" *)
  LL_OPTIONSTR_PROJECTPASSWORD   = 33;
                    (* w/o, of course :) *)
  LL_OPTIONSTR_FAX_RECIPNAME     = 34;
  LL_OPTIONSTR_FAX_RECIPNUMBER   = 35;
  LL_OPTIONSTR_FAX_QUEUENAME     = 36;
  LL_OPTIONSTR_FAX_SENDERNAME    = 37;
  LL_OPTIONSTR_FAX_SENDERCOMPANY = 38;
  LL_OPTIONSTR_FAX_SENDERDEPT    = 39;
  LL_OPTIONSTR_FAX_SENDERBILLINGCODE = 40;
  LL_OPTIONSTR_FAX_AVAILABLEQUEUES = 42;
                    (* r/o (Tab-separated) [job can be -1 or a valid job] *)
  LL_OPTIONSTR_LOGFILEPATH       = 43;
  LL_OPTIONSTR_LICENSINGINFO     = 44;
                    (* w/o, SERNO to define licensing state *)
  LL_OPTIONSTR_PRINTERALIASLIST  = 45;
                    (* multiple "PrnOld=PrnNew1[;PrnNew2[;...]]", erase with NULL or "" *)
  LL_OPTIONSTR_PREVIEWFILENAME   = 46;
                    (* path of preview file (directory will be overridden by LlPreviewSetTempPath(), if given) *)
  LL_OPTIONSTR_EXPORTS_ALLOWED_IN_PREVIEW = 47;
                    (* set in preview file *)
  LL_OPTIONSTR_HELPFILENAME      = 48;
  LL_OPTIONSTR_NULLVALUE         = 49;
                    (* string which represents the NULL value *)
  LL_OPTIONSTR_DEFAULT_EXPORT    = 50;
                    (* default export medium for new projects *)
  LL_OPTIONSTR_ORIGINALPROJECTFILENAME = 51;
                    (* fixup project path for relative paths in realdata preview/export in designer *)
  LL_OPTIONSTR_HIERARCHICALDATASOURCE_ROOT = 52;
                    (* internal use only *)
  LL_OPTIONSTR_PRINTERDEFINITIONFILENAME = 53;
                    (* override for P file name *)
  LL_OPTIONSTR_DOCINFO_DATATYPE  = 54;
                    (* DOCINFO.lpszDatatype *)
  LL_OPTIONSTR_IDX_PRJEXT        = 55;
  LL_OPTIONSTR_IDX_PRVEXT        = 56;
  LL_OPTIONSTR_IDX_PRNEXT        = 57;
  LL_OPTIONSTR_TOC_PRJDESCR      = 58;
  LL_OPTIONSTR_IDX_PRJDESCR      = 59;
  LL_OPTIONSTR_TOC_PRJEXT        = 60;
  LL_OPTIONSTR_TOC_PRVEXT        = 61;
  LL_OPTIONSTR_TOC_PRNEXT        = 62;
  LL_OPTIONSTR_DEFAULTSCHEME     = 63;
                    (* default: empty (COMBIT) *)
  LL_OPTIONSTR_DEFAULTPROJECTNAME = 64;
                    (* DOCINFO.lpszDatatype *)
  LL_OPTIONSTR_GTC_PRJEXT        = 65;
  LL_OPTIONSTR_GTC_PRVEXT        = 66;
  LL_OPTIONSTR_GTC_PRNEXT        = 67;
  LL_OPTIONSTR_GTC_PRJDESCR      = 68;
  LL_OPTIONSTR_ERRORTEXT_FROM_EXPORT = 69;
                    (* r/o *)
  LL_OPTIONSTR_DEFAULTPRJDESCR   = 70;
                    (* default: empty (localized version of 'List & Label project file') *)
  LL_OPTIONSTR_DEFAULTPRINTER    = 71;
                    (* if set, this printer is used instead of the system's default printer (applies to ALL JOBS, so job ID must be "-1"!) *)
  LL_OPTIONSTR_QUERY_LICENSINGINFO = 72;
                    (* r/o, returns serial number in return value *)
  LL_OPTIONSTR_RESERVED73        = 73;
  LL_OPTIONSTR_REPRESENTATION_BOOL_TRUE = 74;
  LL_OPTIONSTR_REPRESENTATION_BOOL_FALSE = 75;
  LL_OPTIONSTR_DEFAULT_FILENAME_FOR_SAVEAS = 76;
                    (* if set, this filename is used as a default name when "Save as" is chosen from the menu *)
  LL_OPTIONSTR_LABEL_PRJDESCR_SINGULAR = 77;
  LL_OPTIONSTR_LIST_PRJDESCR_SINGULAR = 78;
  LL_OPTIONSTR_CARD_PRJDESCR_SINGULAR = 79;
  LL_OPTIONSTR_TOC_PRJDESCR_SINGULAR = 80;
  LL_OPTIONSTR_IDX_PRJDESCR_SINGULAR = 81;
  LL_OPTIONSTR_GTC_PRJDESCR_SINGULAR = 82;
  LL_OPTIONSTR_DEFAULTIMAGEPATH  = 83;
  LL_OPTIONSTR_EMBEDDED_EXPORTS  = 84;
                    (* ';' separated list of exports, for example "DOCX;XLSX;PDF". default: none. NOT COMPATIBLE WITH LL_QUERY_FILENAME_FOR_EXPORTJOB (!) *)
  LL_OPTIONSTR_DRILLDOWN_ROOT    = 85;
                    (* internal *)
  LL_OPTIONSTR_LEGACY_EXPORTERS_ALLOWED = 86;
                    (* ';' separated list of legacy exporters (JQM, HTML) to be allowed. Default is empty. *)
  LL_OPTIONSTR_CHART_AXISLABEL_SPACINGDELTA = 87;
                    (* ';' separated list of spacing deltas (coord-x;coord-y;coord-z;label-x;label-y;label-z). Default is empty, hence all zero. *)
  LL_OPTIONSTR_INTELLISENSE_CONSTANTSFILTER = 88;
                    (* ';' separated list e.g. "-LL.Color*;+*" (deny all entries beginning with LL.Color and allow the rest). Default is empty (hence no constants in Intellisense). *)
  LL_OPTIONSTR_WEBDESIGNER_TABLERENDERLAYER = 89;
                    (* internal *)
  LL_OPTIONSTR_SYSINFO           = 90;
                    (* '\n' read only separated list of sysinfo e.g containing loaded modules *)
  LL_OPTIONSTR_DEFAULTVARHINT    = 91;
                    (* hint to be displayed in the function wizard if no variable or function is selected *)
  LL_OPTIONSTR_REPORTPARAMDLGTITLE = 92;
                    (* title for the report parameter value dialog that is displayed on exporting *)
  LL_OPTIONSTR_DEFAULTIMAGEPATH_FOR_REPOSITORY = 93;
  LL_SYSCOMMAND_MINIMIZE         = -1;
  LL_SYSCOMMAND_MAXIMIZE         = -2;
  LL_PHFG_AGGREGATE              = $01;
  LL_PHFG_PRINT                  = $02;
  LL_PHFG_CROSSTAB               = $04;
  LL_PHFG_OTHERS                 = $08;
  LL_PHFG_ALL                    = $FF;
  LL_DLGBOXMODE_3DBUTTONS        = $8000;
                    (* 'or'ed *)
  LL_DLGBOXMODE_3DFRAME2         = $4000;
                    (* 'OR'ed *)
  LL_DLGBOXMODE_3DFRAME          = $1000;
                    (* 'OR'ed *)
  LL_DLGBOXMODE_NOBITMAPS        = $2000;
                    (* 'or'ed *)
  LL_DLGBOXMODE_DONTCARE         = $0000;
                    (* load from INI *)
  LL_DLGBOXMODE_SAA              = $0001;
  LL_DLGBOXMODE_ALT1             = $0002;
  LL_DLGBOXMODE_ALT2             = $0003;
  LL_DLGBOXMODE_ALT3             = $0004;
  LL_DLGBOXMODE_ALT4             = $0005;
  LL_DLGBOXMODE_ALT5             = $0006;
  LL_DLGBOXMODE_ALT6             = $0007;
  LL_DLGBOXMODE_ALT7             = $0008;
  LL_DLGBOXMODE_ALT8             = $0009;
                    (* Win95 *)
  LL_DLGBOXMODE_ALT9             = $000A;
                    (* Win98 *)
  LL_DLGBOXMODE_ALT10            = $000B;
                    (* Win98 with gray/color button bitmaps like IE4 *)
  LL_DLGBOXMODE_TOOLTIPS98       = $0800;
                    (* DEPRECATED. Do not change.  *)
  LL_CTL_ADDTOSYSMENU            = $00000004;
                    (* from CTL *)
  LL_CTL_ALSOCHILDREN            = $00000010;
  LL_CTL_CONVERTCONTROLS         = $00010000;
  LL_GROUP_ALWAYSFOOTER          = $40000000;
  LL_PRINTERCONFIG_SAVE          = 1;
  LL_PRINTERCONFIG_RESTORE       = 2;
  LL_PRJTYPE_OPTION_FORCEDEFAULTSETTINGS = $8000;
  LL_PRJTYPE_OPTION_CREATEPARTSFROMPROJECT = $4000;
  LL_PRJTYPE_OPTION_NOMERGEPRINTERSETTINGS = $2000;
  LL_RTFTEXTMODE_RTF             = $0000;
  LL_RTFTEXTMODE_PLAIN           = $0001;
  LL_RTFTEXTMODE_EVALUATED       = $0000;
  LL_RTFTEXTMODE_RAW             = $0002;
  LL_RTFTEXTFLAG_ALL             = $0000;
  LL_RTFTEXTFLAG_SELECTION       = $0004;
  LL_ENUMFLAG_INCLUDE_INTERNAL   = 1;
                    (* include internal variables/fields *)
  LL_ERR_BAD_JOBHANDLE           = -1;
                    (* bad jobhandle *)
  LL_ERR_TASK_ACTIVE             = -2;
                    (* LlDefineLayout() only once in a job *)
  LL_ERR_BAD_OBJECTTYPE          = -3;
                    (* nObjType must be one of the allowed values (obsolete constant) *)
  LL_ERR_BAD_PROJECTTYPE         = -3;
                    (* nObjType must be one of the allowed values *)
  LL_ERR_PRINTING_JOB            = -4;
                    (* print job not opened, no print object *)
  LL_ERR_NO_BOX                  = -5;
                    (* LlPrintSetBoxText(...) called when no abort box exists! *)
  LL_ERR_ALREADY_PRINTING        = -6;
                    (* the current operation cannot be performed while a print job is open *)
  LL_ERR_NOT_YET_PRINTING        = -7;
                    (* LlPrintGetOptionString... *)
  LL_ERR_NO_PROJECT              = -10;
                    (* object with requested name does not exist (former ERR_NO_OBJECT) *)
  LL_ERR_NO_PRINTER              = -11;
                    (* printer couldn't be opened *)
  LL_ERR_PRINTING                = -12;
                    (* error while printing *)
  LL_ERR_EXPORTING               = -13;
                    (* error while exporting *)
  LL_ERR_NEEDS_VB                = -14;
                    (* '11...' needs VB.EXE *)
  LL_ERR_BAD_PRINTER             = -15;
                    (* PrintOptionsDialog(): no printer available *)
  LL_ERR_NO_PREVIEWMODE          = -16;
                    (* Preview functions: not in preview mode *)
  LL_ERR_NO_PREVIEWFILES         = -17;
                    (* PreviewDisplay(): no file found *)
  LL_ERR_PARAMETER               = -18;
                    (* bad parameter (usually NULL pointer) *)
  LL_ERR_BAD_EXPRESSION          = -19;
                    (* bad expression in LlExprEvaluate() and LlExprType() *)
  LL_ERR_BAD_EXPRMODE            = -20;
                    (* bad expression mode (LlSetExpressionMode()) *)
  LL_ERR_NO_TABLE                = -21;
                    (* not used *)
  LL_ERR_CFGNOTFOUND             = -22;
                    (* on LlPrintStart(), LlPrintWithBoxStart() [not found] *)
  LL_ERR_EXPRESSION              = -23;
                    (* on LlPrintStart(), LlPrintWithBoxStart() *)
  LL_ERR_CFGBADFILE              = -24;
                    (* on LlPrintStart(), LlPrintWithBoxStart() [read error, bad format] *)
  LL_ERR_BADOBJNAME              = -25;
                    (* on LlPrintEnableObject() - not a ':' at the beginning *)
  LL_ERR_NOOBJECT                = -26;
                    (* on LlPrintEnableObject() - "*" and no object in project *)
  LL_ERR_UNKNOWNOBJECT           = -27;
                    (* on LlPrintEnableObject() - object with that name not existing *)
  LL_ERR_NO_TABLEOBJECT          = -28;
                    (* LlPrint...Start() and no list in Project, or: *)
  LL_ERR_NO_OBJECT               = -29;
                    (* LlPrint...Start() and no object in project *)
  LL_ERR_NO_TEXTOBJECT           = -30;
                    (* LlPrintGetTextCharsPrinted() and no printable text in Project! *)
  LL_ERR_UNKNOWN                 = -31;
                    (* LlPrintIsVariableUsed(), LlPrintIsFieldUsed() *)
  LL_ERR_BAD_MODE                = -32;
                    (* LlPrintFields(), LlPrintIsFieldUsed() called on non-OBJECT_LIST *)
  LL_ERR_CFGBADMODE              = -33;
                    (* on LlDefineLayout(), LlPrint...Start(): file is in wrong expression mode *)
  LL_ERR_ONLYWITHONETABLE        = -34;
                    (* on LlDefinePageSeparation(), LlDefineGrouping() *)
  LL_ERR_UNKNOWNVARIABLE         = -35;
                    (* on LlGetVariableContents() *)
  LL_ERR_UNKNOWNFIELD            = -36;
                    (* on LlGetFieldContents() *)
  LL_ERR_UNKNOWNSORTORDER        = -37;
                    (* on LlGetFieldContents() *)
  LL_ERR_NOPRINTERCFG            = -38;
                    (* on LlPrintCopyPrinterConfiguration() - no or bad file *)
  LL_ERR_SAVEPRINTERCFG          = -39;
                    (* on LlPrintCopyPrinterConfiguration() - file could not be saved *)
  LL_ERR_NOVALIDPAGES            = -41;
                    (* could also be that 16 bit Viewer tries to open 32bit-only storage *)
  LL_ERR_NOTINHOSTPRINTERMODE    = -42;
                    (* cannot be done in Host Printer Mode (LlSetPrinterInPrinterFile()) *)
  LL_ERR_NOTFINISHED             = -43;
                    (* appears when a project reset() is done, but the table not finished *)
  LL_ERR_BUFFERTOOSMALL          = -44;
                    (* LlXXGetOptionStr() *)
  LL_ERR_BADCODEPAGE             = -45;
                    (* LL_OPTION_CODEPAGE *)
  LL_ERR_CANNOTCREATETEMPFILE    = -46;
                    (* cannot create temporary file *)
  LL_ERR_NODESTINATION           = -47;
                    (* no valid export destination *)
  LL_ERR_NOCHART                 = -48;
                    (* no chart control present *)
  LL_ERR_TOO_MANY_CONCURRENT_PRINTJOBS = -49;
                    (* WebServer: not enough print process licenses *)
  LL_ERR_BAD_WEBSERVER_LICENSE   = -50;
                    (* WebServer: bad license file *)
  LL_ERR_NO_WEBSERVER_LICENSE    = -51;
                    (* WebServer: no license file *)
  LL_ERR_INVALIDDATE             = -52;
                    (* LlSystemTimeFromLocaleString(): date not valid! *)
  LL_ERR_DRAWINGNOTFOUND         = -53;
                    (* only if LL_OPTION_ERR_ON_FILENOTFOUND set *)
  LL_ERR_NOUSERINTERACTION       = -54;
                    (* a call is used which would show a dialog, but LL is in Webserver mode *)
  LL_ERR_BADDATABASESTRUCTURE    = -55;
                    (* the project that is loading has a table that is not supported by the database *)
  LL_ERR_UNKNOWNPROPERTY         = -56;
  LL_ERR_INVALIDOPERATION        = -57;
  LL_ERR_PROPERTY_ALREADY_DEFINED = -58;
  LL_ERR_CFGFOUND                = -59;
                    (* on LlPrjOpen() with CREATE_NEW disposition, or of project file is r/o and access flag is r/w *)
  LL_ERR_SAVECFG                 = -60;
                    (* error while saving (LlProjectSave()) *)
  LL_ERR_WRONGTHREAD             = -61;
                    (* internal (.NET) *)
  LL_ERR_NO_SUCH_INFORMATION     = -62;
  LL_ERR_SINK_ALREADY_PRESENT    = -63;
  LL_ERR_SINK_NOT_PRESENT        = -64;
  LL_ERR_ACCESS_DENIED           = -65;
  LL_ERR_IDLEITERATION_DETECTED  = -66;
  LL_ERR_USER_ABORTED            = -99;
                    (* user aborted printing *)
  LL_ERR_BAD_DLLS                = -100;
                    (* DLLs not up to date (CTL, DWG, UTIL) *)
  LL_ERR_NO_LANG_DLL             = -101;
                    (* no or out-of-date language resource DLL *)
  LL_ERR_NO_MEMORY               = -102;
                    (* out of memory *)
  LL_ERR_EXCEPTION               = -104;
                    (* there was a GPF during the API execution. Any action that follows might cause problems! *)
  LL_ERR_LICENSEVIOLATION        = -105;
                    (* your license does not allow this call (see LL_OPTIONSTR_LICENSINGINFO) *)
  LL_ERR_NOT_SUPPORTED_IN_THIS_OS = -106;
                    (* the OS does not support this function *)
  LL_ERR_NO_MORE_DATA            = -107;
  LL_HINT_ABORT                  = -200;
                    (* LL aborted printing - data collection complete *)
  LL_WRN_FIRSTWARNING            = -900;
  LL_WRN_REPORTPARAMETERS_COLLECTION_FINISHED = -994;
                    (* internal use *)
  LL_WRN_ISNULL                  = -995;
                    (* LlExprEvaluate[Var]() *)
  LL_WRN_TABLECHANGE             = -996;
  LL_WRN_PRINTFINISHED           = -997;
                    (* LlRTFDisplay() *)
  LL_WRN_REPEAT_DATA             = -998;
                    (* notification: page is full, prepare for next page *)
  LL_CHAR_TEXTQUOTE              = 1;
  LL_CHAR_PHANTOMSPACE           = $200b;
  LL_CHAR_LOCK                   = $2060;
  LL_CHAR_NEWLINE                = 182;
                    (* "¶" *)
  LL_CHAR_EXPRSEP                = 164;
                    (* "¤" *)
  LL_CHAR_TAB                    = 247;
                    (* "÷" *)
  LL_CHAR_EAN128NUL              = 255;
  LL_CHAR_EAN128FNC1             = 254;
  LL_CHAR_EAN128FNC2             = 253;
  LL_CHAR_EAN128FNC3             = 252;
  LL_CHAR_EAN128FNC4             = 251;
  LL_CHAR_CODE93NUL              = 255;
  LL_CHAR_CODE93EXDOLLAR         = 254;
  LL_CHAR_CODE93EXPERC           = 253;
  LL_CHAR_CODE93EXSLASH          = 252;
  LL_CHAR_CODE93EXPLUS           = 251;
  LL_CHAR_CODE39NUL              = 255;
  LL_DLGEXPR_VAREXTBTN_ENABLE    = $00000001;
                    (* callback for simple Wizard extension *)
  LL_DLGEXPR_VAREXTBTN_DOMODAL   = $00000002;
  LL_LLX_EXTENSIONTYPE_EXPORT    = 1;
  LL_LLX_EXTENSIONTYPE_BARCODE   = 2;
  LL_LLX_EXTENSIONTYPE_OBJECT    = 3;
                    (* nyi *)
  LL_LLX_EXTENSIONTYPE_WIZARD    = 4;
                    (* nyi *)
  LL_LLX_EXTENSIONTYPEFLAG_FORCE_PUBLIC = $00010000;
  LL_LLX_EXTENSIONTYPEFLAG_FORCE_PRIVATE = $00020000;
  LL_LLX_EXTENSIONTYPE_TYPEMASK  = $0000000f;
  LL_DECLARECHARTROW_FOR_OBJECTS = $00000001;
  LL_DECLARECHARTROW_FOR_TABLECOLUMNS = $00000002;
                    (* body only *)
  LL_DECLARECHARTROW_FOR_TABLECOLUMNS_FOOTERS = $00000004;
  LL_GETCHARTOBJECTCOUNT_CHARTOBJECTS = 1;
  LL_GETCHARTOBJECTCOUNT_CHARTOBJECTS_BEFORE_TABLE = 2;
  LL_GETCHARTOBJECTCOUNT_CHARTCOLUMNS = 3;
                    (* body only *)
  LL_GETCHARTOBJECTCOUNT_CHARTCOLUMNS_FOOTERS = 4;
  LL_VARIANTFLAG_NEUTRAL         = $00000000;
  LL_VARIANTFLAG_USE_JULIAN_DATE = $00000001;
  LL_GRIPT_DIM_SCM               = 1;
  LL_GRIPT_DIM_PERC              = 2;
  LL_PARAMETERFLAG_PUBLIC        = $00000000;
  LL_PARAMETERFLAG_SAVEDEFAULT   = $00010000;
  LL_PARAMETERFLAG_PRIVATE       = $40000000;
  LL_PARAMETERFLAG_FORMULA       = $00000000;
  LL_PARAMETERFLAG_VALUE         = $20000000;
  LL_PARAMETERFLAG_GLOBAL        = $00000000;
  LL_PARAMETERFLAG_LOCAL         = $10000000;
  LL_PARAMETERFLAG_MASK          = $ffff0000;
  LL_PARAMETERTYPE_USER          = 0;
  LL_PARAMETERTYPE_FAX           = 1;
  LL_PARAMETERTYPE_MAIL          = 2;
  LL_PARAMETERTYPE_LLINTERNAL    = 4;
  LL_PARAMETERTYPE_MASK          = $0000000f;
  LL_PRJOPEN_AM_READWRITE        = $40000000;
  LL_PRJOPEN_AM_READONLY         = $00000000;
                    (* default *)
  LL_PRJOPEN_AM_MASK             = $40000000;
  LL_PRJOPEN_CD_OPEN_EXISTING    = $00000000;
                    (* fails if it does not exist - default *)
  LL_PRJOPEN_CD_CREATE_ALWAYS    = $10000000;
                    (* open (but do not read contents) if exists, create if not *)
  LL_PRJOPEN_CD_CREATE_NEW       = $20000000;
                    (* fails if already exists *)
  LL_PRJOPEN_CD_OPEN_ALWAYS      = $30000000;
                    (* open (and load) if exists, create if not *)
  LL_PRJOPEN_CD_MASK             = $30000000;
                    (* fails if it does not exist *)
  LL_PRJOPEN_EM_IGNORE_FORMULAERRORS = $08000000;
  LL_PRJOPEN_EM_MASK             = $08000000;
  LL_PRJOPEN_FLG_NOINITPRINTER   = $04000000;
  LL_PRJOPEN_FLG_NOOBJECTLOAD    = $02000000;
  LL_PRJOPEN_FLG_RESERVED        = $01000000;
                    (* internal use *)
  LL_ASSOCIATEPREVIEWCONTROLFLAG_DELETE_ON_CLOSE = $0001;
  LL_ASSOCIATEPREVIEWCONTROLFLAG_HANDLE_IS_ATTACHINFO = $0002;
  LL_ASSOCIATEPREVIEWCONTROLFLAG_PRV_REPLACE = $0000;
  LL_ASSOCIATEPREVIEWCONTROLFLAG_PRV_ADD_TO_CONTROL_STACK = $0004;
  LL_ASSOCIATEPREVIEWCONTROLFLAG_PRV_ADD_TO_CONTROL_IN_TAB = $0008;
  LL_ASSOCIATEPREVIEWCONTROLMASK_ATTACHLOCATION = $003c;
  LL_DESFILEOPEN_OPEN_EXISTING   = $00000000;
                    (* fails if it does not exist - default *)
  LL_DESFILEOPEN_CREATE_ALWAYS   = $10000000;
                    (* open (but do not read contents) if exists, create if not *)
  LL_DESFILEOPEN_CREATE_NEW      = $20000000;
                    (* fails if already exists *)
  LL_DESFILEOPEN_OPEN_ALWAYS     = $30000000;
                    (* open (and load) if exists, create if not *)
  LL_DESFILEOPEN_OPEN_IMPORT     = $40000000;
                    (* fails if it does not exist - only imports data *)
  LL_DESFILEOPEN_OPENMASK        = $70000000;
  LL_DESFILEOPENFLAG_SUPPRESS_SAVEDIALOG = $00000001;
  LL_DESFILEOPENFLAG_SUPPRESS_SAVE = $00000002;
  LL_DESFILESAVE_DEFAULT         = $00000000;
                    (* default *)
  LLDESADDACTIONFLAG_ADD_TO_TOOLBAR = $20000000;
  LLDESADDACTION_MENUITEM_APPEND = $00000000;
  LLDESADDACTION_MENUITEM_INSERT = $10000000;
  LLDESADDACTION_MENUITEM_POSITIONMASK = $10000000;
  LLDESADDACTION_ACCEL_CONTROL   = $00010000;
  LLDESADDACTION_ACCEL_SHIFT     = $00020000;
  LLDESADDACTION_ACCEL_ALT       = $00040000;
  LLDESADDACTION_ACCEL_VIRTKEY   = $00080000;
  LLDESADDACTION_ACCEL_KEYMODIFIERMASK = $000f0000;
  LLDESADDACTION_ACCEL_KEYCODEMASK = $0000ffff;
  LL_DESIGNEROPTSTR_PROJECTFILENAME = 1;
  LL_DESIGNEROPTSTR_WORKSPACETITLE = 2;
  LL_DESIGNEROPTSTR_PROJECTDESCRIPTION = 3;
  LL_USEDIDENTIFIERSFLAG_VARIABLES = $0001;
  LL_USEDIDENTIFIERSFLAG_FIELDS  = $0002;
  LL_USEDIDENTIFIERSFLAG_CHARTFIELDS = $0004;
  LL_USEDIDENTIFIERSFLAG_TABLES  = $0008;
  LL_USEDIDENTIFIERSFLAG_RELATIONS = $0010;
  LL_USEDIDENTIFIERSFLAG_FILES   = $0020;
  LL_TEMPFILENAME_DEFAULT        = $0000;
                    (* see UT *)
  LL_TEMPFILENAME_ENSURELONGPATH = $0001;
                    (* see UT *)
  LL_DICTIONARY_TYPE_STATIC      = 1;
  LL_DICTIONARY_TYPE_IDENTIFIER  = 2;
  LL_DICTIONARY_TYPE_TABLE       = 3;
  LL_DICTIONARY_TYPE_RELATION    = 4;
  LL_DICTIONARY_TYPE_SORTORDER   = 5;
  LL_DICTIONARY_TYPE_ALL         = 0;
                    (* only valid for NULL, NULL to clear all dictionaries in one run *)
  LL_UILANGUAGETYPE_NORMAL       = $00000001;
  LL_UILANGUAGETYPE_TRIAL        = $00000002;
  LL_ADDTABLEOPT_SUPPORTSSTACKEDSORTORDERS = $00000001;
  LL_ADDTABLEOPT_SUPPORTSADVANCEDFILTERING = $00000002;
  LL_ADDTABLEOPT_1TO1_RELATION_ONLY = $00000004;
  LL_INPLACEDESIGNERINTERACTION_QUERY_CANCLOSE = 1;
                    (* wParam = 0, lParam = &BOOL *)
  LL_EXPRXLATRESULT_OPTIMAL      = $00000000;
  LL_EXPRXLATRESULT_PARTIAL      = $00000001;
  LL_EXPRXLATRESULT_FAIL         = $00000002;
  LL_EXPRXLATRESULT_MASK         = $00000007;
                    (* some reserve *)
  LLSTGTESTSTGCMP_MASK_PAGECOUNT = $000000ff;
  LLSTGTESTSTGCMP_FLAG_PRVSINGLEPAGE = $00000100;
  LLSTGTESTSTGCMP_FLAG_EXCLUDE_EMBEDDEDSTORAGES = $00000200;
  LLSRTRIGGEREXPORT_DISCARD_EXPANDABLE_REGIONS = 1;
  LLJOBOPENCOPYEXFLAG_NO_COPY_FIELDLIST = $0001;
  LLJOBOPENCOPYEXFLAG_NO_COPY_DBSTRUCTS = $0002;
  LLJOBOPENCOPYEXFLAG_NO_COPY_XLATTABLES = $0004;
  LLJOBOPENCOPYEXFLAG_NO_COPY_LLXPARAMETERS = $0008;
  LL_DOM_CURRENT_OBJECT_LEVEL_OBJECT = 0;
  LL_DOM_CURRENT_OBJECT_LEVEL_CONTAINERITEM = 1;
  LL_DOM_CURRENT_OBJECT_LEVEL_FIELD = 2;
  LL_FIND_AND_REPLACE_FLAG_CASEINSENSITIVE = 0;
  LL_FIND_AND_REPLACE_FLAG_CASESENSITIVE = 1;

type
  pfnLlJobOpen           = function  
	(_nLanguage:       integer
	): HLLJOB; stdcall;
  pfnLlJobOpenLCID       = function  
	(_nLCID:           _LCID
	): HLLJOB; stdcall;
  pfnLlJobClose          = procedure 
	(_hLlJob:          HLLJOB
	); stdcall;
  pfnLlSetDebug          = procedure 
	(_nOnOff:          cardinal
	); stdcall;
  pfnLlGetVersion        = function  
	(_nCmd:            integer
	): cardinal; stdcall;
  pfnLlGetNotificationMessage= function  
	(_hLlJob:          HLLJOB
	): cardinal; stdcall;
  pfnLlSetNotificationMessage= function  
	(_hLlJob:          HLLJOB;
	 _nMessage:        cardinal
	): integer; stdcall;
  pfnLlSetNotificationCallback= function  
	(_hLlJob:          HLLJOB;
	 _lpfnNotify:      tFarProc
	): tFarProc; stdcall;
  pfnLlDefineFieldA      = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _lpbufContents:   pCHAR
	): integer; stdcall;
  pfnLlDefineFieldW      = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _lpbufContents:   pWCHAR
	): integer; stdcall;
  pfnLlDefineFieldExtA   = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _lpbufContents:   pCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldExtW   = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _lpbufContents:   pWCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldExtHandleA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _hContents:       tHandle;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldExtHandleW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _hContents:       tHandle;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldStart  = procedure 
	(_hLlJob:          HLLJOB
	); stdcall;
  pfnLlDefineVariableA   = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _lpbufContents:   pCHAR
	): integer; stdcall;
  pfnLlDefineVariableW   = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _lpbufContents:   pWCHAR
	): integer; stdcall;
  pfnLlDefineVariableExtA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _lpbufContents:   pCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineVariableExtW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _lpbufContents:   pWCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineVariableExtHandleA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _hContents:       tHandle;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineVariableExtHandleW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _hContents:       tHandle;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineVariableNameA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR
	): integer; stdcall;
  pfnLlDefineVariableNameW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR
	): integer; stdcall;
  pfnLlDefineVariableStart= procedure 
	(_hLlJob:          HLLJOB
	); stdcall;
  pfnLlDefineSumVariableA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _lpbufContents:   pCHAR
	): integer; stdcall;
  pfnLlDefineSumVariableW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _lpbufContents:   pWCHAR
	): integer; stdcall;
  pfnLlDefineLayoutA     = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pCHAR;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR
	): integer; stdcall;
  pfnLlDefineLayoutW     = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pWCHAR;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR
	): integer; stdcall;
  pfnLlDlgEditLineA      = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _lpBuf:           pCHAR;
	 _nBufSize:        integer
	): integer; stdcall;
  pfnLlDlgEditLineW      = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _lpBuf:           pWCHAR;
	 _nBufSize:        integer
	): integer; stdcall;
  pfnLlDlgEditLineExA    = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _nParaTypes:      cardinal;
	 _pszTitle:        pCHAR;
	 _bTable:          longbool;
	 _pvReserved:      pChar
	): integer; stdcall;
  pfnLlDlgEditLineExW    = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _nParaTypes:      cardinal;
	 _pszTitle:        pWCHAR;
	 _bTable:          longbool;
	 _pvReserved:      pChar
	): integer; stdcall;
  pfnLlPreviewSetTempPathA= function  
	(_hLlJob:          HLLJOB;
	 _pszPath:         pCHAR
	): integer; stdcall;
  pfnLlPreviewSetTempPathW= function  
	(_hLlJob:          HLLJOB;
	 _pszPath:         pWCHAR
	): integer; stdcall;
  pfnLlPreviewDeleteFilesA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pCHAR;
	 _pszPath:         pCHAR
	): integer; stdcall;
  pfnLlPreviewDeleteFilesW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pWCHAR;
	 _pszPath:         pWCHAR
	): integer; stdcall;
  pfnLlPreviewDisplayA   = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pCHAR;
	 _pszPath:         pCHAR;
	 _Wnd:             HWND
	): integer; stdcall;
  pfnLlPreviewDisplayW   = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pWCHAR;
	 _pszPath:         pWCHAR;
	 _Wnd:             HWND
	): integer; stdcall;
  pfnLlPreviewDisplayExA = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pCHAR;
	 _pszPath:         pCHAR;
	 _Wnd:             HWND;
	 _nOptions:        cardinal;
	 _pOptions:        pChar
	): integer; stdcall;
  pfnLlPreviewDisplayExW = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pWCHAR;
	 _pszPath:         pWCHAR;
	 _Wnd:             HWND;
	 _nOptions:        cardinal;
	 _pOptions:        pChar
	): integer; stdcall;
  pfnLlPrint             = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintAbort        = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintCheckLineFit = function  
	(_hLlJob:          HLLJOB
	): longbool; stdcall;
  pfnLlPrintEnd          = function  
	(_hLlJob:          HLLJOB;
	 _nPages:          integer
	): integer; stdcall;
  pfnLlPrintFields       = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintFieldsEnd    = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintGetCurrentPage= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintGetItemsPerPage= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintGetItemsPerTable= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintGetRemainingItemsPerTableA= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pCHAR
	): integer; stdcall;
  pfnLlPrintGetRemainingItemsPerTableW= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pWCHAR
	): integer; stdcall;
  pfnLlPrintGetRemItemsPerTableA= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pCHAR
	): integer; stdcall;
  pfnLlPrintGetRemItemsPerTableW= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pWCHAR
	): integer; stdcall;
  pfnLlPrintGetOption    = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer
	): lParam; stdcall;
  pfnLlPrintGetPrinterInfoA= function  
	(_hLlJob:          HLLJOB;
	 _pszPrn:          pCHAR;
	 _nPrnLen:         cardinal;
	 _pszPort:         pCHAR;
	 _nPortLen:        cardinal
	): integer; stdcall;
  pfnLlPrintGetPrinterInfoW= function  
	(_hLlJob:          HLLJOB;
	 _pszPrn:          pWCHAR;
	 _nPrnLen:         cardinal;
	 _pszPort:         pWCHAR;
	 _nPortLen:        cardinal
	): integer; stdcall;
  pfnLlPrintOptionsDialogA= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlPrintOptionsDialogW= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlPrintSelectOffsetEx= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND
	): integer; stdcall;
  pfnLlPrintSetBoxTextA  = function  
	(_hLlJob:          HLLJOB;
	 _szText:          pCHAR;
	 _nPercentage:     integer
	): integer; stdcall;
  pfnLlPrintSetBoxTextW  = function  
	(_hLlJob:          HLLJOB;
	 _szText:          pWCHAR;
	 _nPercentage:     integer
	): integer; stdcall;
  pfnLlPrintSetOption    = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _nValue:          lParam
	): integer; stdcall;
  pfnLlPrintUpdateBox    = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintStartA       = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR;
	 _nPrintOptions:   integer;
	 _nReserved:       integer
	): integer; stdcall;
  pfnLlPrintStartW       = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR;
	 _nPrintOptions:   integer;
	 _nReserved:       integer
	): integer; stdcall;
  pfnLlPrintWithBoxStartA= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR;
	 _nPrintOptions:   integer;
	 _nBoxType:        integer;
	 _hWnd:            HWND;
	 _pszTitle:        pCHAR
	): integer; stdcall;
  pfnLlPrintWithBoxStartW= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR;
	 _nPrintOptions:   integer;
	 _nBoxType:        integer;
	 _hWnd:            HWND;
	 _pszTitle:        pWCHAR
	): integer; stdcall;
  pfnLlPrinterSetupA     = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR
	): integer; stdcall;
  pfnLlPrinterSetupW     = function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR
	): integer; stdcall;
  pfnLlSelectFileDlgTitleExA= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pCHAR;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR;
	 _nBufSize:        cardinal;
	 _pReserved:       pChar
	): integer; stdcall;
  pfnLlSelectFileDlgTitleExW= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pWCHAR;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR;
	 _nBufSize:        cardinal;
	 _pReserved:       pChar
	): integer; stdcall;
  pfnLlSetDlgboxMode     = procedure 
	(_nMode:           cardinal
	); stdcall;
  pfnLlGetDlgboxMode     = function   : cardinal; stdcall;
  pfnLlExprParseA        = function  
	(_hLlJob:          HLLJOB;
	 _lpExprText:      pCHAR;
	 _bIncludeFields:  longbool
	): HLLEXPR; stdcall;
  pfnLlExprParseW        = function  
	(_hLlJob:          HLLJOB;
	 _lpExprText:      pWCHAR;
	 _bIncludeFields:  longbool
	): HLLEXPR; stdcall;
  pfnLlExprType          = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR
	): integer; stdcall;
  pfnLlExprErrorA        = procedure 
	(_hLlJob:          HLLJOB;
	 _pszBuf:          pCHAR;
	 _nBufSize:        cardinal
	); stdcall;
  pfnLlExprErrorW        = procedure 
	(_hLlJob:          HLLJOB;
	 _pszBuf:          pWCHAR;
	 _nBufSize:        cardinal
	); stdcall;
  pfnLlExprFree          = procedure 
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR
	); stdcall;
  pfnLlExprEvaluateA     = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuf:          pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlExprEvaluateW     = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuf:          pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlExprGetUsedVarsA  = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlExprGetUsedVarsW  = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlSetOption         = function  
	(_hLlJob:          HLLJOB;
	 _nMode:           integer;
	 _nValue:          lParam
	): integer; stdcall;
  pfnLlGetOption         = function  
	(_hLlJob:          HLLJOB;
	 _nMode:           integer
	): lParam; stdcall;
  pfnLlSetOptionStringA  = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR
	): integer; stdcall;
  pfnLlSetOptionStringW  = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR
	): integer; stdcall;
  pfnLlGetOptionStringA  = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetOptionStringW  = function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintSetOptionStringA= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR
	): integer; stdcall;
  pfnLlPrintSetOptionStringW= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR
	): integer; stdcall;
  pfnLlPrintGetOptionStringA= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintGetOptionStringW= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDesignerProhibitAction= function  
	(_hLlJob:          HLLJOB;
	 _nMenuID:         integer
	): integer; stdcall;
  pfnLlDesignerProhibitFunctionA= function  
	(_hLlJob:          HLLJOB;
	 _pszFunction:     pCHAR
	): integer; stdcall;
  pfnLlDesignerProhibitFunctionW= function  
	(_hLlJob:          HLLJOB;
	 _pszFunction:     pWCHAR
	): integer; stdcall;
  pfnLlDesignerProhibitFunctionGroup= function  
	(_hJob:            HLLJOB;
	 _nGroupFlags:     cardinal
	): integer; stdcall;
  pfnLlPrintEnableObjectA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pCHAR;
	 _bEnable:         longbool
	): integer; stdcall;
  pfnLlPrintEnableObjectW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pWCHAR;
	 _bEnable:         longbool
	): integer; stdcall;
  pfnLlSetFileExtensionsA= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        integer;
	 _pszObjectExt:    pCHAR;
	 _pszPrinterExt:   pCHAR;
	 _pszSketchExt:    pCHAR
	): integer; stdcall;
  pfnLlSetFileExtensionsW= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        integer;
	 _pszObjectExt:    pWCHAR;
	 _pszPrinterExt:   pWCHAR;
	 _pszSketchExt:    pWCHAR
	): integer; stdcall;
  pfnLlPrintGetTextCharsPrintedA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pCHAR
	): integer; stdcall;
  pfnLlPrintGetTextCharsPrintedW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pWCHAR
	): integer; stdcall;
  pfnLlPrintGetFieldCharsPrintedA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pCHAR;
	 _pszField:        pCHAR
	): integer; stdcall;
  pfnLlPrintGetFieldCharsPrintedW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pWCHAR;
	 _pszField:        pWCHAR
	): integer; stdcall;
  pfnLlPrintIsVariableUsedA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR
	): integer; stdcall;
  pfnLlPrintIsVariableUsedW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR
	): integer; stdcall;
  pfnLlPrintIsFieldUsedA = function  
	(_hLlJob:          HLLJOB;
	 _pszFieldName:    pCHAR
	): integer; stdcall;
  pfnLlPrintIsFieldUsedW = function  
	(_hLlJob:          HLLJOB;
	 _pszFieldName:    pWCHAR
	): integer; stdcall;
  pfnLlPrintOptionsDialogTitleA= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pCHAR;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlPrintOptionsDialogTitleW= function  
	(_hLlJob:          HLLJOB;
	 _hWnd:            HWND;
	 _pszTitle:        pWCHAR;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlSetPrinterToDefaultA= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        integer;
	 _pszObjName:      pCHAR
	): integer; stdcall;
  pfnLlSetPrinterToDefaultW= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        integer;
	 _pszObjName:      pWCHAR
	): integer; stdcall;
  pfnLlDefineSortOrderStart= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlDefineSortOrderA  = function  
	(_hLlJob:          HLLJOB;
	 _pszIdentifier:   pCHAR;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlDefineSortOrderW  = function  
	(_hLlJob:          HLLJOB;
	 _pszIdentifier:   pWCHAR;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlPrintGetSortOrderA= function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintGetSortOrderW= function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDefineGroupingA   = function  
	(_hLlJob:          HLLJOB;
	 _pszSortorder:    pCHAR;
	 _pszIdentifier:   pCHAR;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlDefineGroupingW   = function  
	(_hLlJob:          HLLJOB;
	 _pszSortorder:    pWCHAR;
	 _pszIdentifier:   pWCHAR;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlPrintGetGroupingA = function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintGetGroupingW = function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlAddCtlSupportA    = function  
	(_hWnd:            HWND;
	 _nFlags:          cardinal;
	 _pszInifile:      pCHAR
	): integer; stdcall;
  pfnLlAddCtlSupportW    = function  
	(_hWnd:            HWND;
	 _nFlags:          cardinal;
	 _pszInifile:      pWCHAR
	): integer; stdcall;
  pfnLlPrintBeginGroup   = function  
	(_hLlJob:          HLLJOB;
	 _lParam:          lParam;
	 _lpParam:         pChar
	): integer; stdcall;
  pfnLlPrintEndGroup     = function  
	(_hLlJob:          HLLJOB;
	 _lParam:          lParam;
	 _lpParam:         pChar
	): integer; stdcall;
  pfnLlPrintGroupLine    = function  
	(_hLlJob:          HLLJOB;
	 _lParam:          lParam;
	 _lpParam:         pChar
	): integer; stdcall;
  pfnLlPrintGroupHeader  = function  
	(_hLlJob:          HLLJOB;
	 _lParam:          lParam
	): integer; stdcall;
  pfnLlPrintGetFilterExpressionA= function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintGetFilterExpressionW= function  
	(_hLlJob:          HLLJOB;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintWillMatchFilter= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlPrintDidMatchFilter= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlGetFieldContentsA = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetFieldContentsW = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetVariableContentsA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetVariableContentsW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetSumVariableContentsA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetSumVariableContentsW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetUserVariableContentsA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetUserVariableContentsW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetVariableTypeA  = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR
	): integer; stdcall;
  pfnLlGetVariableTypeW  = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR
	): integer; stdcall;
  pfnLlGetFieldTypeA     = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR
	): integer; stdcall;
  pfnLlGetFieldTypeW     = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR
	): integer; stdcall;
  pfnLlPrintGetColumnInfoA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pCHAR;
	 _nCol:            integer;
	 _pCol:            PSCLLCOLUMN
	): integer; stdcall;
  pfnLlPrintGetColumnInfoW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjectName:   pWCHAR;
	 _nCol:            integer;
	 _pCol:            PSCLLCOLUMN
	): integer; stdcall;
  pfnLlSetPrinterDefaultsDirA= function  
	(_hLlJob:          HLLJOB;
	 _pszDir:          pCHAR
	): integer; stdcall;
  pfnLlSetPrinterDefaultsDirW= function  
	(_hLlJob:          HLLJOB;
	 _pszDir:          pWCHAR
	): integer; stdcall;
  pfnLlCreateSketchA     = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _lpszObjName:     pCHAR
	): integer; stdcall;
  pfnLlCreateSketchW     = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _lpszObjName:     pWCHAR
	): integer; stdcall;
  pfnLlViewerProhibitAction= function  
	(_hLlJob:          HLLJOB;
	 _nMenuID:         integer
	): integer; stdcall;
  pfnLlPrintCopyPrinterConfigurationA= function  
	(_hLlJob:          HLLJOB;
	 _lpszFilename:    pCHAR;
	 _nFunction:       integer
	): integer; stdcall;
  pfnLlPrintCopyPrinterConfigurationW= function  
	(_hLlJob:          HLLJOB;
	 _lpszFilename:    pWCHAR;
	 _nFunction:       integer
	): integer; stdcall;
  pfnLlSetPrinterInPrinterFileA= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR;
	 _nPrinterIndex:   integer;
	 _pszPrinter:      pCHAR;
	 _pDevMode:        _PCDEVMODEA
	): integer; stdcall;
  pfnLlSetPrinterInPrinterFileW= function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR;
	 _nPrinterIndex:   integer;
	 _pszPrinter:      pWCHAR;
	 _pDevMode:        _PCDEVMODEW
	): integer; stdcall;
  pfnLlRTFCreateObject   = function  
	(_hLlJob:          HLLJOB
	): HLLRTFOBJ; stdcall;
  pfnLlRTFDeleteObject   = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ
	): integer; stdcall;
  pfnLlRTFSetTextA       = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlRTFSetTextW       = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlRTFGetTextLength  = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nFlags:          integer
	): cardinal; stdcall;
  pfnLlRTFGetTextA       = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nFlags:          integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlRTFGetTextW       = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nFlags:          integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlRTFEditObject     = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _hWnd:            HWND;
	 _hPrnDC:          HDC;
	 _nProjectType:    integer;
	 _bModal:          longbool
	): integer; stdcall;
  pfnLlRTFCopyToClipboard= function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ
	): integer; stdcall;
  pfnLlRTFDisplay        = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _hDC:             HDC;
	 _pRC:             _PRECT;
	 _bRestart:        longbool;
	 _pnState:         LLPUINT
	): integer; stdcall;
  pfnLlRTFEditorProhibitAction= function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nControlID:      integer
	): integer; stdcall;
  pfnLlRTFEditorInvokeAction= function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nControlID:      integer
	): integer; stdcall;
  pfnLlDebugOutputA      = procedure 
	(_nIndent:         integer;
	 _pszText:         pCHAR
	); stdcall;
  pfnLlDebugOutputW      = procedure 
	(_nIndent:         integer;
	 _pszText:         pWCHAR
	); stdcall;
  pfnLlEnumGetFirstVar   = function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): HLISTPOS; stdcall;
  pfnLlEnumGetFirstField = function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): HLISTPOS; stdcall;
  pfnLlEnumGetFirstConstant= function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): HLISTPOS; stdcall;
  pfnLlEnumGetNextEntry  = function  
	(_hLlJob:          HLLJOB;
	 _nPos:            HLISTPOS;
	 _nFlags:          cardinal
	): HLISTPOS; stdcall;
  pfnLlEnumGetEntryA     = function  
	(_hLlJob:          HLLJOB;
	 _nPos:            HLISTPOS;
	 _pszNameBuf:      pCHAR;
	 _nNameBufSize:    cardinal;
	 _pszContBuf:      pCHAR;
	 _nContBufSize:    cardinal;
	 _pHandle:         _LPHANDLE;
	 _pType:           _LPINT
	): integer; stdcall;
  pfnLlEnumGetEntryW     = function  
	(_hLlJob:          HLLJOB;
	 _nPos:            HLISTPOS;
	 _pszNameBuf:      pWCHAR;
	 _nNameBufSize:    cardinal;
	 _pszContBuf:      pWCHAR;
	 _nContBufSize:    cardinal;
	 _pHandle:         _LPHANDLE;
	 _pType:           _LPINT
	): integer; stdcall;
  pfnLlPrintResetObjectStates= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlXSetParameterA    = function  
	(_hLlJob:          HLLJOB;
	 _nExtensionType:  integer;
	 _pszExtensionName:                pCHAR;
	 _pszKey:          pCHAR;
	 _pszValue:        pCHAR
	): integer; stdcall;
  pfnLlXSetParameterW    = function  
	(_hLlJob:          HLLJOB;
	 _nExtensionType:  integer;
	 _pszExtensionName:                pWCHAR;
	 _pszKey:          pWCHAR;
	 _pszValue:        pWCHAR
	): integer; stdcall;
  pfnLlXGetParameterA    = function  
	(_hLlJob:          HLLJOB;
	 _nExtensionType:  integer;
	 _pszExtensionName:                pCHAR;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlXGetParameterW    = function  
	(_hLlJob:          HLLJOB;
	 _nExtensionType:  integer;
	 _pszExtensionName:                pWCHAR;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintResetProjectState= function  
	(_hJob:            HLLJOB
	): integer; stdcall;
  pfnLlDefineChartFieldStart= procedure 
	(_hLlJob:          HLLJOB
	); stdcall;
  pfnLlDefineChartFieldExtA= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pCHAR;
	 _pszContents:     pCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineChartFieldExtW= function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR;
	 _pszContents:     pWCHAR;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlPrintDeclareChartRow= function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlPrintGetChartObjectCount= function  
	(_hLlJob:          HLLJOB;
	 _nType:           cardinal
	): integer; stdcall;
  pfnLlPrintIsChartFieldUsedA= function  
	(_hLlJob:          HLLJOB;
	 _pszFieldName:    pCHAR
	): integer; stdcall;
  pfnLlPrintIsChartFieldUsedW= function  
	(_hLlJob:          HLLJOB;
	 _pszFieldName:    pWCHAR
	): integer; stdcall;
  pfnLlGetChartFieldContentsA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetChartFieldContentsW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlEnumGetFirstChartField= function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): HLISTPOS; stdcall;
  pfnLlSetNotificationCallbackExt= function  
	(_hLlJob:          HLLJOB;
	 _nEvent:          integer;
	 _lpfnNotify:      tFarProc
	): tFarProc; stdcall;
  pfnLlExprEvaluateVar   = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pVar:            PVARIANT;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlExprTypeVar       = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR
	): integer; stdcall;
  pfnLlGetPrinterFromPrinterFileA= function  
	(_hJob:            HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjectName:   pCHAR;
	 _nPrinter:        integer;
	 _pszPrinter:      pCHAR;
	 _pnPrinterBufSize:                LLPUINT;
	 _pDevMode:        _PDEVMODEA;
	 _pnDevModeBufSize:                LLPUINT
	): integer; stdcall;
  pfnLlGetPrinterFromPrinterFileW= function  
	(_hJob:            HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjectName:   pWCHAR;
	 _nPrinter:        integer;
	 _pszPrinter:      pWCHAR;
	 _pnPrinterBufSize:                LLPUINT;
	 _pDevMode:        _PDEVMODEW;
	 _pnDevModeBufSize:                LLPUINT
	): integer; stdcall;
  pfnLlPrintGetRemainingSpacePerTableA= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pCHAR;
	 _nDimension:      integer
	): integer; stdcall;
  pfnLlPrintGetRemainingSpacePerTableW= function  
	(_hLlJob:          HLLJOB;
	 _pszField:        pWCHAR;
	 _nDimension:      integer
	): integer; stdcall;
  pfnLlDrawToolbarBackground= procedure 
	(_hDC:             HDC;
	 _pRC:             _PRECT;
	 _bHorz:           longbool;
	 _nTBMode:         integer
	); stdcall;
  pfnLlSetDefaultProjectParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pCHAR;
	 _pszValue:        pCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlSetDefaultProjectParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pWCHAR;
	 _pszValue:        pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlGetDefaultProjectParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        integer;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlGetDefaultProjectParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        integer;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlPrintSetProjectParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pCHAR;
	 _pszValue:        pCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlPrintSetProjectParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pWCHAR;
	 _pszValue:        pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlPrintGetProjectParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pCHAR;
	 _bEvaluated:      longbool;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        integer;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlPrintGetProjectParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszParameter:    pWCHAR;
	 _bEvaluated:      longbool;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        integer;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlCreateObject      = function  
	(_pIID:            CTL_PGUID;
	 _ppI:             PPIUNKNOWN
	): longbool; stdcall;
  pfnLlExprContainsVariableA= function  
	(_hLlJob:          HLLJOB;
	 _hExpr:           HLLEXPR;
	 _pszVariable:     pCHAR
	): integer; stdcall;
  pfnLlExprContainsVariableW= function  
	(_hLlJob:          HLLJOB;
	 _hExpr:           HLLEXPR;
	 _pszVariable:     pWCHAR
	): integer; stdcall;
  pfnLlExprIsConstant    = function  
	(_hLlJob:          HLLJOB;
	 _hExpr:           HLLEXPR
	): integer; stdcall;
  pfnLlProfileStartA     = function  
	(_hThread:         tHandle;
	 _pszDescr:        pCHAR;
	 _pszFilename:     pCHAR;
	 _nTicksMS:        integer
	): integer; stdcall;
  pfnLlProfileStartW     = function  
	(_hThread:         tHandle;
	 _pszDescr:        pWCHAR;
	 _pszFilename:     pWCHAR;
	 _nTicksMS:        integer
	): integer; stdcall;
  pfnLlProfileEnd        = procedure 
	(_hThread:         tHandle
	); stdcall;
  pfnLlDumpMemory        = procedure 
	(_bDumpAll:        longbool
	); stdcall;
  pfnLlDbAddTableA       = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszDisplayName:  pCHAR
	): integer; stdcall;
  pfnLlDbAddTableW       = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszDisplayName:  pWCHAR
	): integer; stdcall;
  pfnLlDbAddTableRelationA= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszParentTableID:                pCHAR;
	 _pszRelationID:   pCHAR;
	 _pszRelationDisplayName:                pCHAR
	): integer; stdcall;
  pfnLlDbAddTableRelationW= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszParentTableID:                pWCHAR;
	 _pszRelationID:   pWCHAR;
	 _pszRelationDisplayName:                pWCHAR
	): integer; stdcall;
  pfnLlDbAddTableSortOrderA= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszSortOrderID:  pCHAR;
	 _pszSortOrderDisplayName:                pCHAR
	): integer; stdcall;
  pfnLlDbAddTableSortOrderW= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszSortOrderID:  pWCHAR;
	 _pszSortOrderDisplayName:                pWCHAR
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableA= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _nTableIDLength:  cardinal;
	 _bCompletePath:   longbool
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableW= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _nTableIDLength:  cardinal;
	 _bCompletePath:   longbool
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableRelationA= function  
	(_hJob:            HLLJOB;
	 _pszRelationID:   pCHAR;
	 _nRelationIDLength:                cardinal
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableRelationW= function  
	(_hJob:            HLLJOB;
	 _pszRelationID:   pWCHAR;
	 _nRelationIDLength:                cardinal
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableSortOrderA= function  
	(_hJob:            HLLJOB;
	 _pszSortOrderID:  pCHAR;
	 _nSortOrderIDLength:                cardinal
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableSortOrderW= function  
	(_hJob:            HLLJOB;
	 _pszSortOrderID:  pWCHAR;
	 _nSortOrderIDLength:                cardinal
	): integer; stdcall;
  pfnLlDbDumpStructure   = function  
	(_hJob:            HLLJOB
	): integer; stdcall;
  pfnLlPrintDbGetRootTableCount= function  
	(_hJob:            HLLJOB
	): integer; stdcall;
  pfnLlDbSetMasterTableA = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR
	): integer; stdcall;
  pfnLlDbSetMasterTableW = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR
	): integer; stdcall;
  pfnLlDbGetMasterTableA = function  
	(_hJob:            HLLJOB;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDbGetMasterTableW = function  
	(_hJob:            HLLJOB;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlXSetExportParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszExtensionName:                pCHAR;
	 _pszKey:          pCHAR;
	 _pszValue:        pCHAR
	): integer; stdcall;
  pfnLlXSetExportParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszExtensionName:                pWCHAR;
	 _pszKey:          pWCHAR;
	 _pszValue:        pWCHAR
	): integer; stdcall;
  pfnLlXGetExportParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszExtensionName:                pCHAR;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlXGetExportParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszExtensionName:                pWCHAR;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlXlatNameA         = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlXlatNameW         = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDefineVariableVarA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineVariableVarW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldVarA   = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineFieldVarW   = function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineChartFieldVarA= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDefineChartFieldVarW= function  
	(_hLlJob:          HLLJOB;
	 _pszName:         pWCHAR;
	 _pValue:          PVARIANT;
	 _lPara:           integer;
	 _lpPtr:           pChar
	): integer; stdcall;
  pfnLlDesignerProhibitEditingObjectA= function  
	(_hLlJob:          HLLJOB;
	 _pszObject:       pCHAR
	): integer; stdcall;
  pfnLlDesignerProhibitEditingObjectW= function  
	(_hLlJob:          HLLJOB;
	 _pszObject:       pWCHAR
	): integer; stdcall;
  pfnLlGetUsedIdentifiersA= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetUsedIdentifiersW= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlExprGetUsedVarsExA= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _OrgName:         longbool
	): integer; stdcall;
  pfnLlExprGetUsedVarsExW= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _OrgName:         longbool
	): integer; stdcall;
  pfnLlDomGetProject     = function  
	(_hLlJob:          HLLJOB;
	 _phDOMObj:        PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomGetPropertyA   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDomGetPropertyW   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDomSetPropertyA   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pCHAR;
	 _pszValue:        pCHAR
	): integer; stdcall;
  pfnLlDomSetPropertyW   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pWCHAR;
	 _pszValue:        pWCHAR
	): integer; stdcall;
  pfnLlDomGetObjectA     = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pCHAR;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomGetObjectW     = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pWCHAR;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomGetSubobjectCount= function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pnCount:         _LPINTJAVADUMMY
	): integer; stdcall;
  pfnLlDomGetSubobject   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _nPosition:       integer;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomCreateSubobjectA= function  
	(_hDOMObj:         HLLDOMOBJ;
	 _nPosition:       integer;
	 _pszType:         pCHAR;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomCreateSubobjectW= function  
	(_hDOMObj:         HLLDOMOBJ;
	 _nPosition:       integer;
	 _pszType:         pWCHAR;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlDomDeleteSubobject= function  
	(_hDOMObj:         HLLDOMOBJ;
	 _nPosition:       integer
	): integer; stdcall;
  pfnLlDomMoveSubobject  = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _nPosition:       integer;
	 _nDelta:          integer
	): integer; stdcall;
  pfnLlProjectOpenA      = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pCHAR;
	 _nOpenMode:       cardinal
	): integer; stdcall;
  pfnLlProjectOpenW      = function  
	(_hLlJob:          HLLJOB;
	 _nObjType:        cardinal;
	 _pszObjName:      pWCHAR;
	 _nOpenMode:       cardinal
	): integer; stdcall;
  pfnLlProjectSaveA      = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pCHAR
	): integer; stdcall;
  pfnLlProjectSaveW      = function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pWCHAR
	): integer; stdcall;
  pfnLlProjectSaveCopyAsA= function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pCHAR
	): integer; stdcall;
  pfnLlProjectSaveCopyAsW= function  
	(_hLlJob:          HLLJOB;
	 _pszObjName:      pWCHAR
	): integer; stdcall;
  pfnLlProjectClose      = function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlDomGetPropertyCount= function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pnCount:         _LPINTJAVADUMMY
	): integer; stdcall;
  pfnLlAssociatePreviewControl= function  
	(_hLlJob:          HLLJOB;
	 _hWndControl:     HWND;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlGetErrortextA     = function  
	(_nError:          integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetErrortextW     = function  
	(_nError:          integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlSetPreviewOption  = function  
	(_hLlJob:          HLLJOB;
	 _nOption:         integer;
	 _nValue:          cardinal
	): integer; stdcall;
  pfnLlGetPreviewOption  = function  
	(_hLlJob:          HLLJOB;
	 _nOption:         integer;
	 _pnValue:         _LPUINT
	): integer; stdcall;
  pfnLlDesignerInvokeAction= function  
	(_hLlJob:          HLLJOB;
	 _nMenuID:         integer
	): integer; stdcall;
  pfnLlDesignerRefreshWorkspace= function  
	(_hLlJob:          HLLJOB
	): integer; stdcall;
  pfnLlDesignerFileOpenA = function  
	(_hLlJob:          HLLJOB;
	 _pszFilename:     pCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlDesignerFileOpenW = function  
	(_hLlJob:          HLLJOB;
	 _pszFilename:     pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlDesignerFileSaveA = function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlDesignerFileSaveW = function  
	(_hLlJob:          HLLJOB;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlDesignerAddActionA= function  
	(_hLlJob:          HLLJOB;
	 _nID:             cardinal;
	 _nFlags:          cardinal;
	 _pszMenuText:     pCHAR;
	 _pszMenuHierarchy:                pCHAR;
	 _pszTooltipText:  pCHAR;
	 _nIcon:           cardinal;
	 _pvReserved:      pChar
	): integer; stdcall;
  pfnLlDesignerAddActionW= function  
	(_hLlJob:          HLLJOB;
	 _nID:             cardinal;
	 _nFlags:          cardinal;
	 _pszMenuText:     pWCHAR;
	 _pszMenuHierarchy:                pWCHAR;
	 _pszTooltipText:  pWCHAR;
	 _nIcon:           cardinal;
	 _pvReserved:      pChar
	): integer; stdcall;
  pfnLlDesignerGetOptionStringA= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDesignerGetOptionStringW= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDesignerSetOptionStringA= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pCHAR
	): integer; stdcall;
  pfnLlDesignerSetOptionStringW= function  
	(_hLlJob:          HLLJOB;
	 _nIndex:          integer;
	 _pszBuffer:       pWCHAR
	): integer; stdcall;
  pfnLlJobOpenCopy       = function  
	(_hJob:            HLLJOB
	): HLLJOB; stdcall;
  pfnLlGetProjectParameterA= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pCHAR;
	 _pszParameter:    pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetProjectParameterW= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pWCHAR;
	 _pszParameter:    pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlConvertBLOBToStringA= function  
	(_pBytes:          _PCUINT8;
	 _nBytes:          cardinal;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertBLOBToStringW= function  
	(_pBytes:          _PCUINT8;
	 _nBytes:          cardinal;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertStringToBLOBA= function  
	(_pszText:         pCHAR;
	 _pBytes:          _PUINT8;
	 _nBytes:          cardinal
	): integer; stdcall;
  pfnLlConvertStringToBLOBW= function  
	(_pszText:         pWCHAR;
	 _pBytes:          _PUINT8;
	 _nBytes:          cardinal
	): integer; stdcall;
  pfnLlConvertStreamToStringA= function  
	(_pStream:         _PISTREAM;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertStreamToStringW= function  
	(_pStream:         _PISTREAM;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertStringToStreamA= function  
	(_pszText:         pCHAR;
	 _pStream:         _PISTREAM
	): integer; stdcall;
  pfnLlConvertStringToStreamW= function  
	(_pszText:         pWCHAR;
	 _pStream:         _PISTREAM
	): integer; stdcall;
  pfnLlConvertHGLOBALToStringA= function  
	(_hMemory:         tHandle;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertHGLOBALToStringW= function  
	(_hMemory:         tHandle;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _bWithCompression:                longbool
	): integer; stdcall;
  pfnLlConvertStringToHGLOBALA= function  
	(_pszText:         pCHAR;
	 _phMemory:        PHGLOBAL
	): integer; stdcall;
  pfnLlConvertStringToHGLOBALW= function  
	(_pszText:         pWCHAR;
	 _phMemory:        PHGLOBAL
	): integer; stdcall;
  pfnLlDbAddTableRelationExA= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszParentTableID:                pCHAR;
	 _pszRelationID:   pCHAR;
	 _pszRelationDisplayName:                pCHAR;
	 _pszKeyField:     pCHAR;
	 _pszParentKeyField:                pCHAR
	): integer; stdcall;
  pfnLlDbAddTableRelationExW= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszParentTableID:                pWCHAR;
	 _pszRelationID:   pWCHAR;
	 _pszRelationDisplayName:                pWCHAR;
	 _pszKeyField:     pWCHAR;
	 _pszParentKeyField:                pWCHAR
	): integer; stdcall;
  pfnLlDbAddTableSortOrderExA= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszSortOrderID:  pCHAR;
	 _pszSortOrderDisplayName:                pCHAR;
	 _pszField:        pCHAR
	): integer; stdcall;
  pfnLlDbAddTableSortOrderExW= function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszSortOrderID:  pWCHAR;
	 _pszSortOrderDisplayName:                pWCHAR;
	 _pszField:        pWCHAR
	): integer; stdcall;
  pfnLlGetUsedIdentifiersExA= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pCHAR;
	 _nIdentifierTypes:                cardinal;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetUsedIdentifiersExW= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pWCHAR;
	 _nIdentifierTypes:                cardinal;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetTempFileNameA  = function  
	(_pszPrefix:       pCHAR;
	 _pszExt:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlGetTempFileNameW  = function  
	(_pszPrefix:       pWCHAR;
	 _pszExt:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlGetDebug          = function   : cardinal; stdcall;
  pfnLlRTFEditorGetRTFControlHandle= function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ
	): HWND; stdcall;
  pfnLlGetDefaultPrinterA= function  
	(_pszPrinter:      pCHAR;
	 _pnPrinterBufSize:                LLPUINT;
	 _pDevMode:        _PDEVMODEA;
	 _pnDevModeBufSize:                LLPUINT;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlGetDefaultPrinterW= function  
	(_pszPrinter:      pWCHAR;
	 _pnPrinterBufSize:                LLPUINT;
	 _pDevMode:        _PDEVMODEW;
	 _pnDevModeBufSize:                LLPUINT;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlLocAddDictionaryEntryA= function  
	(_hLlJob:          HLLJOB;
	 _nLCID:           _LCID;
	 _pszKey:          pCHAR;
	 _pszValue:        pCHAR;
	 _nType:           cardinal
	): integer; stdcall;
  pfnLlLocAddDictionaryEntryW= function  
	(_hLlJob:          HLLJOB;
	 _nLCID:           _LCID;
	 _pszKey:          pWCHAR;
	 _pszValue:        pWCHAR;
	 _nType:           cardinal
	): integer; stdcall;
  pfnLlLocAddDesignLCID  = function  
	(_hLlJob:          HLLJOB;
	 _nLCID:           _LCID
	): integer; stdcall;
  pfnLlIsUILanguageAvailable= function  
	(_nLanguage:       integer;
	 _nTypesToLookFor: cardinal
	): cardinal; stdcall;
  pfnLlIsUILanguageAvailableLCID= function  
	(_nLCID:           _LCID;
	 _nTypesToLookFor: cardinal
	): cardinal; stdcall;
  pfnLlDbAddTableExA     = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pCHAR;
	 _pszDisplayName:  pCHAR;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlDbAddTableExW     = function  
	(_hJob:            HLLJOB;
	 _pszTableID:      pWCHAR;
	 _pszDisplayName:  pWCHAR;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlRTFSetTextExA     = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nFlags:          cardinal;
	 _pszText:         pCHAR
	): integer; stdcall;
  pfnLlRTFSetTextExW     = function  
	(_hLlJob:          HLLJOB;
	 _hRTF:            HLLRTFOBJ;
	 _nFlags:          cardinal;
	 _pszText:         pWCHAR
	): integer; stdcall;
  pfnLlInplaceDesignerInteraction= function  
	(_hLlJob:          HLLJOB;
	 _nAction:         cardinal;
	 _wParam:          lParam;
	 _lParam:          lParam
	): integer; stdcall;
  pfnLlGetProjectDescriptionA= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlGetProjectDescriptionW= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlPrintDbGetCurrentTableFilter= function  
	(_hJob:            HLLJOB;
	 _pvFilter:        PVARIANT;
	 _pvParams:        PVARIANT
	): integer; stdcall;
  pfnLlExprTranslateToHostExpressionA= function  
	(_hJob:            HLLJOB;
	 _hExpr:           HLLEXPR;
	 _pvFilter:        PVARIANT;
	 _pvParams:        PVARIANT;
	 _pszCurrentTableName:                pCHAR;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlExprTranslateToHostExpressionW= function  
	(_hJob:            HLLJOB;
	 _hExpr:           HLLEXPR;
	 _pvFilter:        PVARIANT;
	 _pvParams:        PVARIANT;
	 _pszCurrentTableName:                pWCHAR;
	 _pnFlags:         _LPUINT
	): integer; stdcall;
  pfnLlStgTestJobCreate  = function  
	(_pwszStg1:        pWCHAR;
	 _pwszStg1Title:   pWCHAR;
	 _pwszStg2:        pWCHAR;
	 _pwszStg2Title:   pWCHAR;
	 _nFlags:          cardinal;
	 _pvErrors:        PVARIANT;
	 _pvStorage:       PVARIANT;
	 _p:               _PBOOL
	): HLLTESTJOB; stdcall;
  pfnLlStgTestJobCmpPage = function  
	(_hJob:            HLLTESTJOB;
	 _nPage:           cardinal;
	 _nFlags:          cardinal;
	 _pvErrors:        PVARIANT;
	 _pvStorage:       PVARIANT
	): integer; stdcall;
  pfnLlStgTestJobDestroy = function  
	(_hJob:            HLLTESTJOB
	): integer; stdcall;
  pfnLlStgTestStgCmp     = function  
	(_pwszStg1:        pWCHAR;
	 _pwszStg1Title:   pWCHAR;
	 _pwszStg2:        pWCHAR;
	 _pwszStg2Title:   pWCHAR;
	 _nFlags:          cardinal;
	 _pvErrors:        PVARIANT;
	 _pvStorage:       PVARIANT
	): integer; stdcall;
  pfnLlStgTestStgCmpRUNDLL32= procedure 
	(_hwnd:            HWND;
	 _hinst:           tHandle;
	 _lpszCmdLine:     pCHAR;
	 _nCmdShow:        integer
	); stdcall;
  pfnLlStgTestStgCmp2    = function  
	(_pwszStg1:        pWCHAR;
	 _pwszStg1Title:   pWCHAR;
	 _pwszStg2:        pWCHAR;
	 _pwszStg2Title:   pWCHAR;
	 _nFlags:          cardinal;
	 _pwszStorage:     pWCHAR
	): integer; stdcall;
  pfnLlStgTestJobCmpEmbeddedStorages= function  
	(_hJob:            HLLTESTJOB;
	 _pvErrors:        PVARIANT
	): integer; stdcall;
  pfnLlSRTriggerExport   = function  
	(_hJob:            HLLJOB;
	 _hSessionJob:     HLLJOB;
	 _pszID:           pWCHAR;
	 _pszExportFormat: pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlUtilsGetVariantFromProfContentsInternal= function  
	(_pszText:         pWCHAR;
	 _v:               PVARIANT
	): integer; stdcall;
  pfnLlUtilsGetProfContentsFromVariantInternal= function  
	(_v:               PCVARIANT;
	 _vAsString:       PVARIANT
	): integer; stdcall;
  pfnLlExprGetUsedFunctionsA= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlExprGetUsedFunctionsW= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDesignerTriggerJobInUIThread= function  
	(_hLlJob:          HLLJOB;
	 _nUserData:       lParam
	): integer; stdcall;
  pfnLlUtilsComparePrinterInformation= function  
	(_pszDevice1:      pWCHAR;
	 _pszDriver1:      pWCHAR;
	 _pszDEVMODEW1:    _PCDEVMODEW;
	 _pszDevice2:      pWCHAR;
	 _pszDriver2:      pWCHAR;
	 _pszDEVMODEW2:    _PCDEVMODEW;
	 _nIgnoreFlags:    cardinal
	): integer; stdcall;
  pfnLlGetUsedIdentifiersExV= function  
	(_hLlJob:          HLLJOB;
	 _pszProjectName:  pWCHAR;
	 _nIdentifierTypes:                cardinal;
	 _pvArray:         PVARIANT
	): integer; stdcall;
  pfnLlDomGetPropertyV   = function  
	(_hDOMObj:         HLLDOMOBJ;
	 _pszName:         pWCHAR;
	 _pvValue:         PVARIANT
	): integer; stdcall;
  pfnLlExprGetUsedFunctionsV= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pvArray:         PVARIANT
	): integer; stdcall;
  pfnLlExprGetUsedVarsExV= function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR;
	 _pvArray:         PVARIANT;
	 _OrgName:         longbool
	): integer; stdcall;
  pfnLlGetTableRelationToActiveTable= function  
	(_hLlJob:          HLLJOB;
	 _pszTable:        pWCHAR;
	 _OrgName:         longbool;
	 _pvValue:         PVARIANT
	): integer; stdcall;
  pfnLlJobOpenCopyEx     = function  
	(_hJob:            HLLJOB;
	 _nFlags:          cardinal
	): HLLJOB; stdcall;
  pfnLlAddDebugSinkForThread= function  
	(_pSink:           PIUNKNOWN
	): tHandle; stdcall;
  pfnLlRemoveDebugSinkFromThread= function  
	(_hSink:           tHandle
	): integer; stdcall;
  pfnLlGetDebugSinkProxyModule= function  
	(_pszPrefix:       pWCHAR;
	 _pGUID:           CTL_PGUID;
	 _pvSink:          PVARIANT
	): integer; stdcall;
  pfnLlGetDebugSinkProxyCategory= function  
	(_nCategory:       integer;
	 _pGUID:           CTL_PGUID;
	 _pvSink:          PVARIANT
	): integer; stdcall;
  pfnLlDlgSelectFileOpen = function  
	(_hJob:            HLLJOB;
	 _hWndParent:      HWND;
	 _pszReposType:    pWCHAR;
	 _pszTitle:        pWCHAR;
	 _bWithCreateNew:  longbool;
	 _vFilenameOrID:   PVARIANT
	): integer; stdcall;
  pfnLlUtilsLcidFromLocaleName= function  
	(_pszLocaleName:   pWCHAR
	): integer; stdcall;
  pfnLlDesignerShowMessage= function  
	(_hJob:            HLLJOB;
	 _pszTitle:        pWCHAR;
	 _pszMessage:      pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLlExprConvertGlobalToLocal= function  
	(_hJob:            HLLJOB;
	 _pvVar:           PVARIANT
	): integer; stdcall;
  pfnLlExprConvertLocalToGlobal= function  
	(_hJob:            HLLJOB;
	 _pvVar:           PVARIANT
	): integer; stdcall;
  pfnLlUtilsGetProjectType= function  
	(_hJob:            HLLJOB;
	 _pszProjectFilename:                pWCHAR
	): integer; stdcall;
  pfnLlGetLastErrorText  = function  
	(_hJob:            HLLJOB;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlDomGetCurrentObject= function  
	(_hLlJob:          HLLJOB;
	 _nLevel:          integer;
	 _phDOMSubObj:     PHLLDOMOBJ
	): integer; stdcall;
  pfnLlUtilsIDFromOrgID  = function  
	(_hJob:            HLLJOB;
	 _pvVar:           PVARIANT
	): integer; stdcall;
  pfnLlProjectFindAndReplace= function  
	(_hJob:            HLLJOB;
	 _pszSearchText:   pWCHAR;
	 _pszReplaceText:  pWCHAR;
	 _nSARFlags:       cardinal
	): integer; stdcall;
  pfnLlExprParseQueryDelayedDefine= function  
	(_hLlJob:          HLLJOB;
	 _lpExprText:      pWCHAR;
	 _bIncludeFields:  longbool;
	 _IUnkLLExprParseQuery:                PIUNKNOWN
	): integer; stdcall;
  pfnLlExprTypeMask      = function  
	(_hLlJob:          HLLJOB;
	 _lpExpr:          HLLEXPR
	): integer; stdcall;
  pfnLlStgTestJobCmpEmbeddedStorages2= function  
	(_hJob:            HLLTESTJOB;
	 _pvErrors:        PVARIANT;
	 _pvarListOfProblematicStorages:                PVARIANT
	): integer; stdcall;
  pfnLlStgTestJobAddResultJobs= function  
	(_hJob:            HLLTESTJOB;
	 _pvarListOfProblematicStorages:                PCVARIANT
	): integer; stdcall;
  pfnLlStgCreateFrom     = function  
	(_hJob:            HLLJOB;
	 _nLCID:           cardinal;
	 _hWndForLengthyOpDialog:                HWND;
	 _pszFile:         pWCHAR;
	 _pszResultingFileNameBuffer:                pWCHAR;
	 _nResultingFileNameBufferSize:                cardinal;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlRemoveIdentifier  = function  
	(_hLlJob:          HLLJOB;
	 _pszVarName:      pWCHAR
	): integer; stdcall;
  pfnLlExprParseEx       = function  
	(_hLlJob:          HLLJOB;
	 _lpExprText:      pWCHAR;
	 _nParaTypes:      cardinal;
	 _bIncludeFields:  longbool
	): HLLEXPR; stdcall;

const
   LlJobOpen: pfnLlJobOpen = NIL;
   LlJobOpenLCID: pfnLlJobOpenLCID = NIL;
   LlJobClose: pfnLlJobClose = NIL;
   LlSetDebug: pfnLlSetDebug = NIL;
   LlGetVersion: pfnLlGetVersion = NIL;
   LlGetNotificationMessage: pfnLlGetNotificationMessage = NIL;
   LlSetNotificationMessage: pfnLlSetNotificationMessage = NIL;
   LlSetNotificationCallback: pfnLlSetNotificationCallback = NIL;
  {$ifdef UNICODE}
      LlDefineFieldO: pfnLlDefineFieldA = NIL;
     {$else}
      LlDefineField: pfnLlDefineFieldA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineField: pfnLlDefineFieldW = NIL;
     {$else}
      LlDefineFieldO: pfnLlDefineFieldW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldExtO: pfnLlDefineFieldExtA = NIL;
     {$else}
      LlDefineFieldExt: pfnLlDefineFieldExtA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldExt: pfnLlDefineFieldExtW = NIL;
     {$else}
      LlDefineFieldExtO: pfnLlDefineFieldExtW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldExtHandleO: pfnLlDefineFieldExtHandleA = NIL;
     {$else}
      LlDefineFieldExtHandle: pfnLlDefineFieldExtHandleA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldExtHandle: pfnLlDefineFieldExtHandleW = NIL;
     {$else}
      LlDefineFieldExtHandleO: pfnLlDefineFieldExtHandleW = NIL;
  {$endif}
   LlDefineFieldStart: pfnLlDefineFieldStart = NIL;
  {$ifdef UNICODE}
      LlDefineVariableO: pfnLlDefineVariableA = NIL;
     {$else}
      LlDefineVariable: pfnLlDefineVariableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariable: pfnLlDefineVariableW = NIL;
     {$else}
      LlDefineVariableO: pfnLlDefineVariableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableExtO: pfnLlDefineVariableExtA = NIL;
     {$else}
      LlDefineVariableExt: pfnLlDefineVariableExtA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableExt: pfnLlDefineVariableExtW = NIL;
     {$else}
      LlDefineVariableExtO: pfnLlDefineVariableExtW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableExtHandleO: pfnLlDefineVariableExtHandleA = NIL;
     {$else}
      LlDefineVariableExtHandle: pfnLlDefineVariableExtHandleA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableExtHandle: pfnLlDefineVariableExtHandleW = NIL;
     {$else}
      LlDefineVariableExtHandleO: pfnLlDefineVariableExtHandleW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableNameO: pfnLlDefineVariableNameA = NIL;
     {$else}
      LlDefineVariableName: pfnLlDefineVariableNameA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableName: pfnLlDefineVariableNameW = NIL;
     {$else}
      LlDefineVariableNameO: pfnLlDefineVariableNameW = NIL;
  {$endif}
   LlDefineVariableStart: pfnLlDefineVariableStart = NIL;
  {$ifdef UNICODE}
      LlDefineSumVariableO: pfnLlDefineSumVariableA = NIL;
     {$else}
      LlDefineSumVariable: pfnLlDefineSumVariableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineSumVariable: pfnLlDefineSumVariableW = NIL;
     {$else}
      LlDefineSumVariableO: pfnLlDefineSumVariableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineLayoutO: pfnLlDefineLayoutA = NIL;
     {$else}
      LlDefineLayout: pfnLlDefineLayoutA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineLayout: pfnLlDefineLayoutW = NIL;
     {$else}
      LlDefineLayoutO: pfnLlDefineLayoutW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDlgEditLineO: pfnLlDlgEditLineA = NIL;
     {$else}
      LlDlgEditLine: pfnLlDlgEditLineA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDlgEditLine: pfnLlDlgEditLineW = NIL;
     {$else}
      LlDlgEditLineO: pfnLlDlgEditLineW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDlgEditLineExO: pfnLlDlgEditLineExA = NIL;
     {$else}
      LlDlgEditLineEx: pfnLlDlgEditLineExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDlgEditLineEx: pfnLlDlgEditLineExW = NIL;
     {$else}
      LlDlgEditLineExO: pfnLlDlgEditLineExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewSetTempPathO: pfnLlPreviewSetTempPathA = NIL;
     {$else}
      LlPreviewSetTempPath: pfnLlPreviewSetTempPathA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewSetTempPath: pfnLlPreviewSetTempPathW = NIL;
     {$else}
      LlPreviewSetTempPathO: pfnLlPreviewSetTempPathW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDeleteFilesO: pfnLlPreviewDeleteFilesA = NIL;
     {$else}
      LlPreviewDeleteFiles: pfnLlPreviewDeleteFilesA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDeleteFiles: pfnLlPreviewDeleteFilesW = NIL;
     {$else}
      LlPreviewDeleteFilesO: pfnLlPreviewDeleteFilesW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDisplayO: pfnLlPreviewDisplayA = NIL;
     {$else}
      LlPreviewDisplay: pfnLlPreviewDisplayA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDisplay: pfnLlPreviewDisplayW = NIL;
     {$else}
      LlPreviewDisplayO: pfnLlPreviewDisplayW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDisplayExO: pfnLlPreviewDisplayExA = NIL;
     {$else}
      LlPreviewDisplayEx: pfnLlPreviewDisplayExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPreviewDisplayEx: pfnLlPreviewDisplayExW = NIL;
     {$else}
      LlPreviewDisplayExO: pfnLlPreviewDisplayExW = NIL;
  {$endif}
   LlPrint: pfnLlPrint = NIL;
   LlPrintAbort: pfnLlPrintAbort = NIL;
   LlPrintCheckLineFit: pfnLlPrintCheckLineFit = NIL;
   LlPrintEnd: pfnLlPrintEnd = NIL;
   LlPrintFields: pfnLlPrintFields = NIL;
   LlPrintFieldsEnd: pfnLlPrintFieldsEnd = NIL;
   LlPrintGetCurrentPage: pfnLlPrintGetCurrentPage = NIL;
   LlPrintGetItemsPerPage: pfnLlPrintGetItemsPerPage = NIL;
   LlPrintGetItemsPerTable: pfnLlPrintGetItemsPerTable = NIL;
  {$ifdef UNICODE}
      LlPrintGetRemainingItemsPerTableO: pfnLlPrintGetRemainingItemsPerTableA = NIL;
     {$else}
      LlPrintGetRemainingItemsPerTable: pfnLlPrintGetRemainingItemsPerTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetRemainingItemsPerTable: pfnLlPrintGetRemainingItemsPerTableW = NIL;
     {$else}
      LlPrintGetRemainingItemsPerTableO: pfnLlPrintGetRemainingItemsPerTableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetRemItemsPerTableO: pfnLlPrintGetRemItemsPerTableA = NIL;
     {$else}
      LlPrintGetRemItemsPerTable: pfnLlPrintGetRemItemsPerTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetRemItemsPerTable: pfnLlPrintGetRemItemsPerTableW = NIL;
     {$else}
      LlPrintGetRemItemsPerTableO: pfnLlPrintGetRemItemsPerTableW = NIL;
  {$endif}
   LlPrintGetOption: pfnLlPrintGetOption = NIL;
  {$ifdef UNICODE}
      LlPrintGetPrinterInfoO: pfnLlPrintGetPrinterInfoA = NIL;
     {$else}
      LlPrintGetPrinterInfo: pfnLlPrintGetPrinterInfoA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetPrinterInfo: pfnLlPrintGetPrinterInfoW = NIL;
     {$else}
      LlPrintGetPrinterInfoO: pfnLlPrintGetPrinterInfoW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintOptionsDialogO: pfnLlPrintOptionsDialogA = NIL;
     {$else}
      LlPrintOptionsDialog: pfnLlPrintOptionsDialogA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintOptionsDialog: pfnLlPrintOptionsDialogW = NIL;
     {$else}
      LlPrintOptionsDialogO: pfnLlPrintOptionsDialogW = NIL;
  {$endif}
   LlPrintSelectOffsetEx: pfnLlPrintSelectOffsetEx = NIL;
  {$ifdef UNICODE}
      LlPrintSetBoxTextO: pfnLlPrintSetBoxTextA = NIL;
     {$else}
      LlPrintSetBoxText: pfnLlPrintSetBoxTextA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintSetBoxText: pfnLlPrintSetBoxTextW = NIL;
     {$else}
      LlPrintSetBoxTextO: pfnLlPrintSetBoxTextW = NIL;
  {$endif}
   LlPrintSetOption: pfnLlPrintSetOption = NIL;
   LlPrintUpdateBox: pfnLlPrintUpdateBox = NIL;
  {$ifdef UNICODE}
      LlPrintStartO: pfnLlPrintStartA = NIL;
     {$else}
      LlPrintStart: pfnLlPrintStartA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintStart: pfnLlPrintStartW = NIL;
     {$else}
      LlPrintStartO: pfnLlPrintStartW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintWithBoxStartO: pfnLlPrintWithBoxStartA = NIL;
     {$else}
      LlPrintWithBoxStart: pfnLlPrintWithBoxStartA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintWithBoxStart: pfnLlPrintWithBoxStartW = NIL;
     {$else}
      LlPrintWithBoxStartO: pfnLlPrintWithBoxStartW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrinterSetupO: pfnLlPrinterSetupA = NIL;
     {$else}
      LlPrinterSetup: pfnLlPrinterSetupA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrinterSetup: pfnLlPrinterSetupW = NIL;
     {$else}
      LlPrinterSetupO: pfnLlPrinterSetupW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSelectFileDlgTitleExO: pfnLlSelectFileDlgTitleExA = NIL;
     {$else}
      LlSelectFileDlgTitleEx: pfnLlSelectFileDlgTitleExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSelectFileDlgTitleEx: pfnLlSelectFileDlgTitleExW = NIL;
     {$else}
      LlSelectFileDlgTitleExO: pfnLlSelectFileDlgTitleExW = NIL;
  {$endif}
   LlSetDlgboxMode: pfnLlSetDlgboxMode = NIL;
   LlGetDlgboxMode: pfnLlGetDlgboxMode = NIL;
  {$ifdef UNICODE}
      LlExprParseO: pfnLlExprParseA = NIL;
     {$else}
      LlExprParse: pfnLlExprParseA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprParse: pfnLlExprParseW = NIL;
     {$else}
      LlExprParseO: pfnLlExprParseW = NIL;
  {$endif}
   LlExprType: pfnLlExprType = NIL;
  {$ifdef UNICODE}
      LlExprErrorO: pfnLlExprErrorA = NIL;
     {$else}
      LlExprError: pfnLlExprErrorA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprError: pfnLlExprErrorW = NIL;
     {$else}
      LlExprErrorO: pfnLlExprErrorW = NIL;
  {$endif}
   LlExprFree: pfnLlExprFree = NIL;
  {$ifdef UNICODE}
      LlExprEvaluateO: pfnLlExprEvaluateA = NIL;
     {$else}
      LlExprEvaluate: pfnLlExprEvaluateA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprEvaluate: pfnLlExprEvaluateW = NIL;
     {$else}
      LlExprEvaluateO: pfnLlExprEvaluateW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprGetUsedVarsO: pfnLlExprGetUsedVarsA = NIL;
     {$else}
      LlExprGetUsedVars: pfnLlExprGetUsedVarsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprGetUsedVars: pfnLlExprGetUsedVarsW = NIL;
     {$else}
      LlExprGetUsedVarsO: pfnLlExprGetUsedVarsW = NIL;
  {$endif}
   LlSetOption: pfnLlSetOption = NIL;
   LlGetOption: pfnLlGetOption = NIL;
  {$ifdef UNICODE}
      LlSetOptionStringO: pfnLlSetOptionStringA = NIL;
     {$else}
      LlSetOptionString: pfnLlSetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetOptionString: pfnLlSetOptionStringW = NIL;
     {$else}
      LlSetOptionStringO: pfnLlSetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetOptionStringO: pfnLlGetOptionStringA = NIL;
     {$else}
      LlGetOptionString: pfnLlGetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetOptionString: pfnLlGetOptionStringW = NIL;
     {$else}
      LlGetOptionStringO: pfnLlGetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintSetOptionStringO: pfnLlPrintSetOptionStringA = NIL;
     {$else}
      LlPrintSetOptionString: pfnLlPrintSetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintSetOptionString: pfnLlPrintSetOptionStringW = NIL;
     {$else}
      LlPrintSetOptionStringO: pfnLlPrintSetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetOptionStringO: pfnLlPrintGetOptionStringA = NIL;
     {$else}
      LlPrintGetOptionString: pfnLlPrintGetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetOptionString: pfnLlPrintGetOptionStringW = NIL;
     {$else}
      LlPrintGetOptionStringO: pfnLlPrintGetOptionStringW = NIL;
  {$endif}
   LlDesignerProhibitAction: pfnLlDesignerProhibitAction = NIL;
  {$ifdef UNICODE}
      LlDesignerProhibitFunctionO: pfnLlDesignerProhibitFunctionA = NIL;
     {$else}
      LlDesignerProhibitFunction: pfnLlDesignerProhibitFunctionA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerProhibitFunction: pfnLlDesignerProhibitFunctionW = NIL;
     {$else}
      LlDesignerProhibitFunctionO: pfnLlDesignerProhibitFunctionW = NIL;
  {$endif}
   LlDesignerProhibitFunctionGroup: pfnLlDesignerProhibitFunctionGroup = NIL;
  {$ifdef UNICODE}
      LlPrintEnableObjectO: pfnLlPrintEnableObjectA = NIL;
     {$else}
      LlPrintEnableObject: pfnLlPrintEnableObjectA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintEnableObject: pfnLlPrintEnableObjectW = NIL;
     {$else}
      LlPrintEnableObjectO: pfnLlPrintEnableObjectW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetFileExtensionsO: pfnLlSetFileExtensionsA = NIL;
     {$else}
      LlSetFileExtensions: pfnLlSetFileExtensionsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetFileExtensions: pfnLlSetFileExtensionsW = NIL;
     {$else}
      LlSetFileExtensionsO: pfnLlSetFileExtensionsW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetTextCharsPrintedO: pfnLlPrintGetTextCharsPrintedA = NIL;
     {$else}
      LlPrintGetTextCharsPrinted: pfnLlPrintGetTextCharsPrintedA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetTextCharsPrinted: pfnLlPrintGetTextCharsPrintedW = NIL;
     {$else}
      LlPrintGetTextCharsPrintedO: pfnLlPrintGetTextCharsPrintedW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetFieldCharsPrintedO: pfnLlPrintGetFieldCharsPrintedA = NIL;
     {$else}
      LlPrintGetFieldCharsPrinted: pfnLlPrintGetFieldCharsPrintedA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetFieldCharsPrinted: pfnLlPrintGetFieldCharsPrintedW = NIL;
     {$else}
      LlPrintGetFieldCharsPrintedO: pfnLlPrintGetFieldCharsPrintedW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintIsVariableUsedO: pfnLlPrintIsVariableUsedA = NIL;
     {$else}
      LlPrintIsVariableUsed: pfnLlPrintIsVariableUsedA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintIsVariableUsed: pfnLlPrintIsVariableUsedW = NIL;
     {$else}
      LlPrintIsVariableUsedO: pfnLlPrintIsVariableUsedW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintIsFieldUsedO: pfnLlPrintIsFieldUsedA = NIL;
     {$else}
      LlPrintIsFieldUsed: pfnLlPrintIsFieldUsedA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintIsFieldUsed: pfnLlPrintIsFieldUsedW = NIL;
     {$else}
      LlPrintIsFieldUsedO: pfnLlPrintIsFieldUsedW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintOptionsDialogTitleO: pfnLlPrintOptionsDialogTitleA = NIL;
     {$else}
      LlPrintOptionsDialogTitle: pfnLlPrintOptionsDialogTitleA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintOptionsDialogTitle: pfnLlPrintOptionsDialogTitleW = NIL;
     {$else}
      LlPrintOptionsDialogTitleO: pfnLlPrintOptionsDialogTitleW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterToDefaultO: pfnLlSetPrinterToDefaultA = NIL;
     {$else}
      LlSetPrinterToDefault: pfnLlSetPrinterToDefaultA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterToDefault: pfnLlSetPrinterToDefaultW = NIL;
     {$else}
      LlSetPrinterToDefaultO: pfnLlSetPrinterToDefaultW = NIL;
  {$endif}
   LlDefineSortOrderStart: pfnLlDefineSortOrderStart = NIL;
  {$ifdef UNICODE}
      LlDefineSortOrderO: pfnLlDefineSortOrderA = NIL;
     {$else}
      LlDefineSortOrder: pfnLlDefineSortOrderA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineSortOrder: pfnLlDefineSortOrderW = NIL;
     {$else}
      LlDefineSortOrderO: pfnLlDefineSortOrderW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetSortOrderO: pfnLlPrintGetSortOrderA = NIL;
     {$else}
      LlPrintGetSortOrder: pfnLlPrintGetSortOrderA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetSortOrder: pfnLlPrintGetSortOrderW = NIL;
     {$else}
      LlPrintGetSortOrderO: pfnLlPrintGetSortOrderW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineGroupingO: pfnLlDefineGroupingA = NIL;
     {$else}
      LlDefineGrouping: pfnLlDefineGroupingA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineGrouping: pfnLlDefineGroupingW = NIL;
     {$else}
      LlDefineGroupingO: pfnLlDefineGroupingW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetGroupingO: pfnLlPrintGetGroupingA = NIL;
     {$else}
      LlPrintGetGrouping: pfnLlPrintGetGroupingA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetGrouping: pfnLlPrintGetGroupingW = NIL;
     {$else}
      LlPrintGetGroupingO: pfnLlPrintGetGroupingW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlAddCtlSupportO: pfnLlAddCtlSupportA = NIL;
     {$else}
      LlAddCtlSupport: pfnLlAddCtlSupportA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlAddCtlSupport: pfnLlAddCtlSupportW = NIL;
     {$else}
      LlAddCtlSupportO: pfnLlAddCtlSupportW = NIL;
  {$endif}
   LlPrintBeginGroup: pfnLlPrintBeginGroup = NIL;
   LlPrintEndGroup: pfnLlPrintEndGroup = NIL;
   LlPrintGroupLine: pfnLlPrintGroupLine = NIL;
   LlPrintGroupHeader: pfnLlPrintGroupHeader = NIL;
  {$ifdef UNICODE}
      LlPrintGetFilterExpressionO: pfnLlPrintGetFilterExpressionA = NIL;
     {$else}
      LlPrintGetFilterExpression: pfnLlPrintGetFilterExpressionA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetFilterExpression: pfnLlPrintGetFilterExpressionW = NIL;
     {$else}
      LlPrintGetFilterExpressionO: pfnLlPrintGetFilterExpressionW = NIL;
  {$endif}
   LlPrintWillMatchFilter: pfnLlPrintWillMatchFilter = NIL;
   LlPrintDidMatchFilter: pfnLlPrintDidMatchFilter = NIL;
  {$ifdef UNICODE}
      LlGetFieldContentsO: pfnLlGetFieldContentsA = NIL;
     {$else}
      LlGetFieldContents: pfnLlGetFieldContentsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetFieldContents: pfnLlGetFieldContentsW = NIL;
     {$else}
      LlGetFieldContentsO: pfnLlGetFieldContentsW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetVariableContentsO: pfnLlGetVariableContentsA = NIL;
     {$else}
      LlGetVariableContents: pfnLlGetVariableContentsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetVariableContents: pfnLlGetVariableContentsW = NIL;
     {$else}
      LlGetVariableContentsO: pfnLlGetVariableContentsW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetSumVariableContentsO: pfnLlGetSumVariableContentsA = NIL;
     {$else}
      LlGetSumVariableContents: pfnLlGetSumVariableContentsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetSumVariableContents: pfnLlGetSumVariableContentsW = NIL;
     {$else}
      LlGetSumVariableContentsO: pfnLlGetSumVariableContentsW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUserVariableContentsO: pfnLlGetUserVariableContentsA = NIL;
     {$else}
      LlGetUserVariableContents: pfnLlGetUserVariableContentsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUserVariableContents: pfnLlGetUserVariableContentsW = NIL;
     {$else}
      LlGetUserVariableContentsO: pfnLlGetUserVariableContentsW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetVariableTypeO: pfnLlGetVariableTypeA = NIL;
     {$else}
      LlGetVariableType: pfnLlGetVariableTypeA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetVariableType: pfnLlGetVariableTypeW = NIL;
     {$else}
      LlGetVariableTypeO: pfnLlGetVariableTypeW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetFieldTypeO: pfnLlGetFieldTypeA = NIL;
     {$else}
      LlGetFieldType: pfnLlGetFieldTypeA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetFieldType: pfnLlGetFieldTypeW = NIL;
     {$else}
      LlGetFieldTypeO: pfnLlGetFieldTypeW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetColumnInfoO: pfnLlPrintGetColumnInfoA = NIL;
     {$else}
      LlPrintGetColumnInfo: pfnLlPrintGetColumnInfoA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetColumnInfo: pfnLlPrintGetColumnInfoW = NIL;
     {$else}
      LlPrintGetColumnInfoO: pfnLlPrintGetColumnInfoW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterDefaultsDirO: pfnLlSetPrinterDefaultsDirA = NIL;
     {$else}
      LlSetPrinterDefaultsDir: pfnLlSetPrinterDefaultsDirA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterDefaultsDir: pfnLlSetPrinterDefaultsDirW = NIL;
     {$else}
      LlSetPrinterDefaultsDirO: pfnLlSetPrinterDefaultsDirW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlCreateSketchO: pfnLlCreateSketchA = NIL;
     {$else}
      LlCreateSketch: pfnLlCreateSketchA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlCreateSketch: pfnLlCreateSketchW = NIL;
     {$else}
      LlCreateSketchO: pfnLlCreateSketchW = NIL;
  {$endif}
   LlViewerProhibitAction: pfnLlViewerProhibitAction = NIL;
  {$ifdef UNICODE}
      LlPrintCopyPrinterConfigurationO: pfnLlPrintCopyPrinterConfigurationA = NIL;
     {$else}
      LlPrintCopyPrinterConfiguration: pfnLlPrintCopyPrinterConfigurationA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintCopyPrinterConfiguration: pfnLlPrintCopyPrinterConfigurationW = NIL;
     {$else}
      LlPrintCopyPrinterConfigurationO: pfnLlPrintCopyPrinterConfigurationW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterInPrinterFileO: pfnLlSetPrinterInPrinterFileA = NIL;
     {$else}
      LlSetPrinterInPrinterFile: pfnLlSetPrinterInPrinterFileA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetPrinterInPrinterFile: pfnLlSetPrinterInPrinterFileW = NIL;
     {$else}
      LlSetPrinterInPrinterFileO: pfnLlSetPrinterInPrinterFileW = NIL;
  {$endif}
   LlRTFCreateObject: pfnLlRTFCreateObject = NIL;
   LlRTFDeleteObject: pfnLlRTFDeleteObject = NIL;
  {$ifdef UNICODE}
      LlRTFSetTextO: pfnLlRTFSetTextA = NIL;
     {$else}
      LlRTFSetText: pfnLlRTFSetTextA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlRTFSetText: pfnLlRTFSetTextW = NIL;
     {$else}
      LlRTFSetTextO: pfnLlRTFSetTextW = NIL;
  {$endif}
   LlRTFGetTextLength: pfnLlRTFGetTextLength = NIL;
  {$ifdef UNICODE}
      LlRTFGetTextO: pfnLlRTFGetTextA = NIL;
     {$else}
      LlRTFGetText: pfnLlRTFGetTextA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlRTFGetText: pfnLlRTFGetTextW = NIL;
     {$else}
      LlRTFGetTextO: pfnLlRTFGetTextW = NIL;
  {$endif}
   LlRTFEditObject: pfnLlRTFEditObject = NIL;
   LlRTFCopyToClipboard: pfnLlRTFCopyToClipboard = NIL;
   LlRTFDisplay: pfnLlRTFDisplay = NIL;
   LlRTFEditorProhibitAction: pfnLlRTFEditorProhibitAction = NIL;
   LlRTFEditorInvokeAction: pfnLlRTFEditorInvokeAction = NIL;
  {$ifdef UNICODE}
      LlDebugOutputO: pfnLlDebugOutputA = NIL;
     {$else}
      LlDebugOutput: pfnLlDebugOutputA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDebugOutput: pfnLlDebugOutputW = NIL;
     {$else}
      LlDebugOutputO: pfnLlDebugOutputW = NIL;
  {$endif}
   LlEnumGetFirstVar: pfnLlEnumGetFirstVar = NIL;
   LlEnumGetFirstField: pfnLlEnumGetFirstField = NIL;
   LlEnumGetFirstConstant: pfnLlEnumGetFirstConstant = NIL;
   LlEnumGetNextEntry: pfnLlEnumGetNextEntry = NIL;
  {$ifdef UNICODE}
      LlEnumGetEntryO: pfnLlEnumGetEntryA = NIL;
     {$else}
      LlEnumGetEntry: pfnLlEnumGetEntryA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlEnumGetEntry: pfnLlEnumGetEntryW = NIL;
     {$else}
      LlEnumGetEntryO: pfnLlEnumGetEntryW = NIL;
  {$endif}
   LlPrintResetObjectStates: pfnLlPrintResetObjectStates = NIL;
  {$ifdef UNICODE}
      LlXSetParameterO: pfnLlXSetParameterA = NIL;
     {$else}
      LlXSetParameter: pfnLlXSetParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXSetParameter: pfnLlXSetParameterW = NIL;
     {$else}
      LlXSetParameterO: pfnLlXSetParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXGetParameterO: pfnLlXGetParameterA = NIL;
     {$else}
      LlXGetParameter: pfnLlXGetParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXGetParameter: pfnLlXGetParameterW = NIL;
     {$else}
      LlXGetParameterO: pfnLlXGetParameterW = NIL;
  {$endif}
   LlPrintResetProjectState: pfnLlPrintResetProjectState = NIL;
   LlDefineChartFieldStart: pfnLlDefineChartFieldStart = NIL;
  {$ifdef UNICODE}
      LlDefineChartFieldExtO: pfnLlDefineChartFieldExtA = NIL;
     {$else}
      LlDefineChartFieldExt: pfnLlDefineChartFieldExtA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineChartFieldExt: pfnLlDefineChartFieldExtW = NIL;
     {$else}
      LlDefineChartFieldExtO: pfnLlDefineChartFieldExtW = NIL;
  {$endif}
   LlPrintDeclareChartRow: pfnLlPrintDeclareChartRow = NIL;
   LlPrintGetChartObjectCount: pfnLlPrintGetChartObjectCount = NIL;
  {$ifdef UNICODE}
      LlPrintIsChartFieldUsedO: pfnLlPrintIsChartFieldUsedA = NIL;
     {$else}
      LlPrintIsChartFieldUsed: pfnLlPrintIsChartFieldUsedA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintIsChartFieldUsed: pfnLlPrintIsChartFieldUsedW = NIL;
     {$else}
      LlPrintIsChartFieldUsedO: pfnLlPrintIsChartFieldUsedW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetChartFieldContentsO: pfnLlGetChartFieldContentsA = NIL;
     {$else}
      LlGetChartFieldContents: pfnLlGetChartFieldContentsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetChartFieldContents: pfnLlGetChartFieldContentsW = NIL;
     {$else}
      LlGetChartFieldContentsO: pfnLlGetChartFieldContentsW = NIL;
  {$endif}
   LlEnumGetFirstChartField: pfnLlEnumGetFirstChartField = NIL;
   LlSetNotificationCallbackExt: pfnLlSetNotificationCallbackExt = NIL;
   LlExprEvaluateVar: pfnLlExprEvaluateVar = NIL;
   LlExprTypeVar: pfnLlExprTypeVar = NIL;
  {$ifdef UNICODE}
      LlGetPrinterFromPrinterFileO: pfnLlGetPrinterFromPrinterFileA = NIL;
     {$else}
      LlGetPrinterFromPrinterFile: pfnLlGetPrinterFromPrinterFileA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetPrinterFromPrinterFile: pfnLlGetPrinterFromPrinterFileW = NIL;
     {$else}
      LlGetPrinterFromPrinterFileO: pfnLlGetPrinterFromPrinterFileW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetRemainingSpacePerTableO: pfnLlPrintGetRemainingSpacePerTableA = NIL;
     {$else}
      LlPrintGetRemainingSpacePerTable: pfnLlPrintGetRemainingSpacePerTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetRemainingSpacePerTable: pfnLlPrintGetRemainingSpacePerTableW = NIL;
     {$else}
      LlPrintGetRemainingSpacePerTableO: pfnLlPrintGetRemainingSpacePerTableW = NIL;
  {$endif}
   LlDrawToolbarBackground: pfnLlDrawToolbarBackground = NIL;
  {$ifdef UNICODE}
      LlSetDefaultProjectParameterO: pfnLlSetDefaultProjectParameterA = NIL;
     {$else}
      LlSetDefaultProjectParameter: pfnLlSetDefaultProjectParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlSetDefaultProjectParameter: pfnLlSetDefaultProjectParameterW = NIL;
     {$else}
      LlSetDefaultProjectParameterO: pfnLlSetDefaultProjectParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetDefaultProjectParameterO: pfnLlGetDefaultProjectParameterA = NIL;
     {$else}
      LlGetDefaultProjectParameter: pfnLlGetDefaultProjectParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetDefaultProjectParameter: pfnLlGetDefaultProjectParameterW = NIL;
     {$else}
      LlGetDefaultProjectParameterO: pfnLlGetDefaultProjectParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintSetProjectParameterO: pfnLlPrintSetProjectParameterA = NIL;
     {$else}
      LlPrintSetProjectParameter: pfnLlPrintSetProjectParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintSetProjectParameter: pfnLlPrintSetProjectParameterW = NIL;
     {$else}
      LlPrintSetProjectParameterO: pfnLlPrintSetProjectParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetProjectParameterO: pfnLlPrintGetProjectParameterA = NIL;
     {$else}
      LlPrintGetProjectParameter: pfnLlPrintGetProjectParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintGetProjectParameter: pfnLlPrintGetProjectParameterW = NIL;
     {$else}
      LlPrintGetProjectParameterO: pfnLlPrintGetProjectParameterW = NIL;
  {$endif}
   LlCreateObject: pfnLlCreateObject = NIL;
  {$ifdef UNICODE}
      LlExprContainsVariableO: pfnLlExprContainsVariableA = NIL;
     {$else}
      LlExprContainsVariable: pfnLlExprContainsVariableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprContainsVariable: pfnLlExprContainsVariableW = NIL;
     {$else}
      LlExprContainsVariableO: pfnLlExprContainsVariableW = NIL;
  {$endif}
   LlExprIsConstant: pfnLlExprIsConstant = NIL;
  {$ifdef UNICODE}
      LlProfileStartO: pfnLlProfileStartA = NIL;
     {$else}
      LlProfileStart: pfnLlProfileStartA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProfileStart: pfnLlProfileStartW = NIL;
     {$else}
      LlProfileStartO: pfnLlProfileStartW = NIL;
  {$endif}
   LlProfileEnd: pfnLlProfileEnd = NIL;
   LlDumpMemory: pfnLlDumpMemory = NIL;
  {$ifdef UNICODE}
      LlDbAddTableO: pfnLlDbAddTableA = NIL;
     {$else}
      LlDbAddTable: pfnLlDbAddTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTable: pfnLlDbAddTableW = NIL;
     {$else}
      LlDbAddTableO: pfnLlDbAddTableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableRelationO: pfnLlDbAddTableRelationA = NIL;
     {$else}
      LlDbAddTableRelation: pfnLlDbAddTableRelationA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableRelation: pfnLlDbAddTableRelationW = NIL;
     {$else}
      LlDbAddTableRelationO: pfnLlDbAddTableRelationW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableSortOrderO: pfnLlDbAddTableSortOrderA = NIL;
     {$else}
      LlDbAddTableSortOrder: pfnLlDbAddTableSortOrderA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableSortOrder: pfnLlDbAddTableSortOrderW = NIL;
     {$else}
      LlDbAddTableSortOrderO: pfnLlDbAddTableSortOrderW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTableO: pfnLlPrintDbGetCurrentTableA = NIL;
     {$else}
      LlPrintDbGetCurrentTable: pfnLlPrintDbGetCurrentTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTable: pfnLlPrintDbGetCurrentTableW = NIL;
     {$else}
      LlPrintDbGetCurrentTableO: pfnLlPrintDbGetCurrentTableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTableRelationO: pfnLlPrintDbGetCurrentTableRelationA = NIL;
     {$else}
      LlPrintDbGetCurrentTableRelation: pfnLlPrintDbGetCurrentTableRelationA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTableRelation: pfnLlPrintDbGetCurrentTableRelationW = NIL;
     {$else}
      LlPrintDbGetCurrentTableRelationO: pfnLlPrintDbGetCurrentTableRelationW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTableSortOrderO: pfnLlPrintDbGetCurrentTableSortOrderA = NIL;
     {$else}
      LlPrintDbGetCurrentTableSortOrder: pfnLlPrintDbGetCurrentTableSortOrderA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlPrintDbGetCurrentTableSortOrder: pfnLlPrintDbGetCurrentTableSortOrderW = NIL;
     {$else}
      LlPrintDbGetCurrentTableSortOrderO: pfnLlPrintDbGetCurrentTableSortOrderW = NIL;
  {$endif}
   LlDbDumpStructure: pfnLlDbDumpStructure = NIL;
   LlPrintDbGetRootTableCount: pfnLlPrintDbGetRootTableCount = NIL;
  {$ifdef UNICODE}
      LlDbSetMasterTableO: pfnLlDbSetMasterTableA = NIL;
     {$else}
      LlDbSetMasterTable: pfnLlDbSetMasterTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbSetMasterTable: pfnLlDbSetMasterTableW = NIL;
     {$else}
      LlDbSetMasterTableO: pfnLlDbSetMasterTableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbGetMasterTableO: pfnLlDbGetMasterTableA = NIL;
     {$else}
      LlDbGetMasterTable: pfnLlDbGetMasterTableA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbGetMasterTable: pfnLlDbGetMasterTableW = NIL;
     {$else}
      LlDbGetMasterTableO: pfnLlDbGetMasterTableW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXSetExportParameterO: pfnLlXSetExportParameterA = NIL;
     {$else}
      LlXSetExportParameter: pfnLlXSetExportParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXSetExportParameter: pfnLlXSetExportParameterW = NIL;
     {$else}
      LlXSetExportParameterO: pfnLlXSetExportParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXGetExportParameterO: pfnLlXGetExportParameterA = NIL;
     {$else}
      LlXGetExportParameter: pfnLlXGetExportParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXGetExportParameter: pfnLlXGetExportParameterW = NIL;
     {$else}
      LlXGetExportParameterO: pfnLlXGetExportParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXlatNameO: pfnLlXlatNameA = NIL;
     {$else}
      LlXlatName: pfnLlXlatNameA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlXlatName: pfnLlXlatNameW = NIL;
     {$else}
      LlXlatNameO: pfnLlXlatNameW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableVarO: pfnLlDefineVariableVarA = NIL;
     {$else}
      LlDefineVariableVar: pfnLlDefineVariableVarA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineVariableVar: pfnLlDefineVariableVarW = NIL;
     {$else}
      LlDefineVariableVarO: pfnLlDefineVariableVarW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldVarO: pfnLlDefineFieldVarA = NIL;
     {$else}
      LlDefineFieldVar: pfnLlDefineFieldVarA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineFieldVar: pfnLlDefineFieldVarW = NIL;
     {$else}
      LlDefineFieldVarO: pfnLlDefineFieldVarW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineChartFieldVarO: pfnLlDefineChartFieldVarA = NIL;
     {$else}
      LlDefineChartFieldVar: pfnLlDefineChartFieldVarA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDefineChartFieldVar: pfnLlDefineChartFieldVarW = NIL;
     {$else}
      LlDefineChartFieldVarO: pfnLlDefineChartFieldVarW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerProhibitEditingObjectO: pfnLlDesignerProhibitEditingObjectA = NIL;
     {$else}
      LlDesignerProhibitEditingObject: pfnLlDesignerProhibitEditingObjectA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerProhibitEditingObject: pfnLlDesignerProhibitEditingObjectW = NIL;
     {$else}
      LlDesignerProhibitEditingObjectO: pfnLlDesignerProhibitEditingObjectW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUsedIdentifiersO: pfnLlGetUsedIdentifiersA = NIL;
     {$else}
      LlGetUsedIdentifiers: pfnLlGetUsedIdentifiersA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUsedIdentifiers: pfnLlGetUsedIdentifiersW = NIL;
     {$else}
      LlGetUsedIdentifiersO: pfnLlGetUsedIdentifiersW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprGetUsedVarsExO: pfnLlExprGetUsedVarsExA = NIL;
     {$else}
      LlExprGetUsedVarsEx: pfnLlExprGetUsedVarsExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprGetUsedVarsEx: pfnLlExprGetUsedVarsExW = NIL;
     {$else}
      LlExprGetUsedVarsExO: pfnLlExprGetUsedVarsExW = NIL;
  {$endif}
   LlDomGetProject: pfnLlDomGetProject = NIL;
  {$ifdef UNICODE}
      LlDomGetPropertyO: pfnLlDomGetPropertyA = NIL;
     {$else}
      LlDomGetProperty: pfnLlDomGetPropertyA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomGetProperty: pfnLlDomGetPropertyW = NIL;
     {$else}
      LlDomGetPropertyO: pfnLlDomGetPropertyW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomSetPropertyO: pfnLlDomSetPropertyA = NIL;
     {$else}
      LlDomSetProperty: pfnLlDomSetPropertyA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomSetProperty: pfnLlDomSetPropertyW = NIL;
     {$else}
      LlDomSetPropertyO: pfnLlDomSetPropertyW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomGetObjectO: pfnLlDomGetObjectA = NIL;
     {$else}
      LlDomGetObject: pfnLlDomGetObjectA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomGetObject: pfnLlDomGetObjectW = NIL;
     {$else}
      LlDomGetObjectO: pfnLlDomGetObjectW = NIL;
  {$endif}
   LlDomGetSubobjectCount: pfnLlDomGetSubobjectCount = NIL;
   LlDomGetSubobject: pfnLlDomGetSubobject = NIL;
  {$ifdef UNICODE}
      LlDomCreateSubobjectO: pfnLlDomCreateSubobjectA = NIL;
     {$else}
      LlDomCreateSubobject: pfnLlDomCreateSubobjectA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDomCreateSubobject: pfnLlDomCreateSubobjectW = NIL;
     {$else}
      LlDomCreateSubobjectO: pfnLlDomCreateSubobjectW = NIL;
  {$endif}
   LlDomDeleteSubobject: pfnLlDomDeleteSubobject = NIL;
   LlDomMoveSubobject: pfnLlDomMoveSubobject = NIL;
  {$ifdef UNICODE}
      LlProjectOpenO: pfnLlProjectOpenA = NIL;
     {$else}
      LlProjectOpen: pfnLlProjectOpenA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProjectOpen: pfnLlProjectOpenW = NIL;
     {$else}
      LlProjectOpenO: pfnLlProjectOpenW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProjectSaveO: pfnLlProjectSaveA = NIL;
     {$else}
      LlProjectSave: pfnLlProjectSaveA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProjectSave: pfnLlProjectSaveW = NIL;
     {$else}
      LlProjectSaveO: pfnLlProjectSaveW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProjectSaveCopyAsO: pfnLlProjectSaveCopyAsA = NIL;
     {$else}
      LlProjectSaveCopyAs: pfnLlProjectSaveCopyAsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlProjectSaveCopyAs: pfnLlProjectSaveCopyAsW = NIL;
     {$else}
      LlProjectSaveCopyAsO: pfnLlProjectSaveCopyAsW = NIL;
  {$endif}
   LlProjectClose: pfnLlProjectClose = NIL;
   LlDomGetPropertyCount: pfnLlDomGetPropertyCount = NIL;
   LlAssociatePreviewControl: pfnLlAssociatePreviewControl = NIL;
  {$ifdef UNICODE}
      LlGetErrortextO: pfnLlGetErrortextA = NIL;
     {$else}
      LlGetErrortext: pfnLlGetErrortextA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetErrortext: pfnLlGetErrortextW = NIL;
     {$else}
      LlGetErrortextO: pfnLlGetErrortextW = NIL;
  {$endif}
   LlSetPreviewOption: pfnLlSetPreviewOption = NIL;
   LlGetPreviewOption: pfnLlGetPreviewOption = NIL;
   LlDesignerInvokeAction: pfnLlDesignerInvokeAction = NIL;
   LlDesignerRefreshWorkspace: pfnLlDesignerRefreshWorkspace = NIL;
  {$ifdef UNICODE}
      LlDesignerFileOpenO: pfnLlDesignerFileOpenA = NIL;
     {$else}
      LlDesignerFileOpen: pfnLlDesignerFileOpenA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerFileOpen: pfnLlDesignerFileOpenW = NIL;
     {$else}
      LlDesignerFileOpenO: pfnLlDesignerFileOpenW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerFileSaveO: pfnLlDesignerFileSaveA = NIL;
     {$else}
      LlDesignerFileSave: pfnLlDesignerFileSaveA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerFileSave: pfnLlDesignerFileSaveW = NIL;
     {$else}
      LlDesignerFileSaveO: pfnLlDesignerFileSaveW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerAddActionO: pfnLlDesignerAddActionA = NIL;
     {$else}
      LlDesignerAddAction: pfnLlDesignerAddActionA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerAddAction: pfnLlDesignerAddActionW = NIL;
     {$else}
      LlDesignerAddActionO: pfnLlDesignerAddActionW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerGetOptionStringO: pfnLlDesignerGetOptionStringA = NIL;
     {$else}
      LlDesignerGetOptionString: pfnLlDesignerGetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerGetOptionString: pfnLlDesignerGetOptionStringW = NIL;
     {$else}
      LlDesignerGetOptionStringO: pfnLlDesignerGetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerSetOptionStringO: pfnLlDesignerSetOptionStringA = NIL;
     {$else}
      LlDesignerSetOptionString: pfnLlDesignerSetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDesignerSetOptionString: pfnLlDesignerSetOptionStringW = NIL;
     {$else}
      LlDesignerSetOptionStringO: pfnLlDesignerSetOptionStringW = NIL;
  {$endif}
   LlJobOpenCopy: pfnLlJobOpenCopy = NIL;
  {$ifdef UNICODE}
      LlGetProjectParameterO: pfnLlGetProjectParameterA = NIL;
     {$else}
      LlGetProjectParameter: pfnLlGetProjectParameterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetProjectParameter: pfnLlGetProjectParameterW = NIL;
     {$else}
      LlGetProjectParameterO: pfnLlGetProjectParameterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertBLOBToStringO: pfnLlConvertBLOBToStringA = NIL;
     {$else}
      LlConvertBLOBToString: pfnLlConvertBLOBToStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertBLOBToString: pfnLlConvertBLOBToStringW = NIL;
     {$else}
      LlConvertBLOBToStringO: pfnLlConvertBLOBToStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToBLOBO: pfnLlConvertStringToBLOBA = NIL;
     {$else}
      LlConvertStringToBLOB: pfnLlConvertStringToBLOBA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToBLOB: pfnLlConvertStringToBLOBW = NIL;
     {$else}
      LlConvertStringToBLOBO: pfnLlConvertStringToBLOBW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStreamToStringO: pfnLlConvertStreamToStringA = NIL;
     {$else}
      LlConvertStreamToString: pfnLlConvertStreamToStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStreamToString: pfnLlConvertStreamToStringW = NIL;
     {$else}
      LlConvertStreamToStringO: pfnLlConvertStreamToStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToStreamO: pfnLlConvertStringToStreamA = NIL;
     {$else}
      LlConvertStringToStream: pfnLlConvertStringToStreamA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToStream: pfnLlConvertStringToStreamW = NIL;
     {$else}
      LlConvertStringToStreamO: pfnLlConvertStringToStreamW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertHGLOBALToStringO: pfnLlConvertHGLOBALToStringA = NIL;
     {$else}
      LlConvertHGLOBALToString: pfnLlConvertHGLOBALToStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertHGLOBALToString: pfnLlConvertHGLOBALToStringW = NIL;
     {$else}
      LlConvertHGLOBALToStringO: pfnLlConvertHGLOBALToStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToHGLOBALO: pfnLlConvertStringToHGLOBALA = NIL;
     {$else}
      LlConvertStringToHGLOBAL: pfnLlConvertStringToHGLOBALA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlConvertStringToHGLOBAL: pfnLlConvertStringToHGLOBALW = NIL;
     {$else}
      LlConvertStringToHGLOBALO: pfnLlConvertStringToHGLOBALW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableRelationExO: pfnLlDbAddTableRelationExA = NIL;
     {$else}
      LlDbAddTableRelationEx: pfnLlDbAddTableRelationExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableRelationEx: pfnLlDbAddTableRelationExW = NIL;
     {$else}
      LlDbAddTableRelationExO: pfnLlDbAddTableRelationExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableSortOrderExO: pfnLlDbAddTableSortOrderExA = NIL;
     {$else}
      LlDbAddTableSortOrderEx: pfnLlDbAddTableSortOrderExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableSortOrderEx: pfnLlDbAddTableSortOrderExW = NIL;
     {$else}
      LlDbAddTableSortOrderExO: pfnLlDbAddTableSortOrderExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUsedIdentifiersExO: pfnLlGetUsedIdentifiersExA = NIL;
     {$else}
      LlGetUsedIdentifiersEx: pfnLlGetUsedIdentifiersExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetUsedIdentifiersEx: pfnLlGetUsedIdentifiersExW = NIL;
     {$else}
      LlGetUsedIdentifiersExO: pfnLlGetUsedIdentifiersExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetTempFileNameO: pfnLlGetTempFileNameA = NIL;
     {$else}
      LlGetTempFileName: pfnLlGetTempFileNameA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetTempFileName: pfnLlGetTempFileNameW = NIL;
     {$else}
      LlGetTempFileNameO: pfnLlGetTempFileNameW = NIL;
  {$endif}
   LlGetDebug: pfnLlGetDebug = NIL;
   LlRTFEditorGetRTFControlHandle: pfnLlRTFEditorGetRTFControlHandle = NIL;
  {$ifdef UNICODE}
      LlGetDefaultPrinterO: pfnLlGetDefaultPrinterA = NIL;
     {$else}
      LlGetDefaultPrinter: pfnLlGetDefaultPrinterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetDefaultPrinter: pfnLlGetDefaultPrinterW = NIL;
     {$else}
      LlGetDefaultPrinterO: pfnLlGetDefaultPrinterW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlLocAddDictionaryEntryO: pfnLlLocAddDictionaryEntryA = NIL;
     {$else}
      LlLocAddDictionaryEntry: pfnLlLocAddDictionaryEntryA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlLocAddDictionaryEntry: pfnLlLocAddDictionaryEntryW = NIL;
     {$else}
      LlLocAddDictionaryEntryO: pfnLlLocAddDictionaryEntryW = NIL;
  {$endif}
   LlLocAddDesignLCID: pfnLlLocAddDesignLCID = NIL;
   LlIsUILanguageAvailable: pfnLlIsUILanguageAvailable = NIL;
   LlIsUILanguageAvailableLCID: pfnLlIsUILanguageAvailableLCID = NIL;
  {$ifdef UNICODE}
      LlDbAddTableExO: pfnLlDbAddTableExA = NIL;
     {$else}
      LlDbAddTableEx: pfnLlDbAddTableExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlDbAddTableEx: pfnLlDbAddTableExW = NIL;
     {$else}
      LlDbAddTableExO: pfnLlDbAddTableExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlRTFSetTextExO: pfnLlRTFSetTextExA = NIL;
     {$else}
      LlRTFSetTextEx: pfnLlRTFSetTextExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlRTFSetTextEx: pfnLlRTFSetTextExW = NIL;
     {$else}
      LlRTFSetTextExO: pfnLlRTFSetTextExW = NIL;
  {$endif}
   LlInplaceDesignerInteraction: pfnLlInplaceDesignerInteraction = NIL;
  {$ifdef UNICODE}
      LlGetProjectDescriptionO: pfnLlGetProjectDescriptionA = NIL;
     {$else}
      LlGetProjectDescription: pfnLlGetProjectDescriptionA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlGetProjectDescription: pfnLlGetProjectDescriptionW = NIL;
     {$else}
      LlGetProjectDescriptionO: pfnLlGetProjectDescriptionW = NIL;
  {$endif}
   LlPrintDbGetCurrentTableFilter: pfnLlPrintDbGetCurrentTableFilter = NIL;
  {$ifdef UNICODE}
      LlExprTranslateToHostExpressionO: pfnLlExprTranslateToHostExpressionA = NIL;
     {$else}
      LlExprTranslateToHostExpression: pfnLlExprTranslateToHostExpressionA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprTranslateToHostExpression: pfnLlExprTranslateToHostExpressionW = NIL;
     {$else}
      LlExprTranslateToHostExpressionO: pfnLlExprTranslateToHostExpressionW = NIL;
  {$endif}
   LlStgTestJobCreate: pfnLlStgTestJobCreate = NIL;
   LlStgTestJobCmpPage: pfnLlStgTestJobCmpPage = NIL;
   LlStgTestJobDestroy: pfnLlStgTestJobDestroy = NIL;
   LlStgTestStgCmp: pfnLlStgTestStgCmp = NIL;
   LlStgTestStgCmpRUNDLL32: pfnLlStgTestStgCmpRUNDLL32 = NIL;
   LlStgTestStgCmp2: pfnLlStgTestStgCmp2 = NIL;
   LlStgTestJobCmpEmbeddedStorages: pfnLlStgTestJobCmpEmbeddedStorages = NIL;
   LlSRTriggerExport: pfnLlSRTriggerExport = NIL;
   LlUtilsGetVariantFromProfContentsInternal: pfnLlUtilsGetVariantFromProfContentsInternal = NIL;
   LlUtilsGetProfContentsFromVariantInternal: pfnLlUtilsGetProfContentsFromVariantInternal = NIL;
  {$ifdef UNICODE}
      LlExprGetUsedFunctionsO: pfnLlExprGetUsedFunctionsA = NIL;
     {$else}
      LlExprGetUsedFunctions: pfnLlExprGetUsedFunctionsA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlExprGetUsedFunctions: pfnLlExprGetUsedFunctionsW = NIL;
     {$else}
      LlExprGetUsedFunctionsO: pfnLlExprGetUsedFunctionsW = NIL;
  {$endif}
   LlDesignerTriggerJobInUIThread: pfnLlDesignerTriggerJobInUIThread = NIL;
   LlUtilsComparePrinterInformation: pfnLlUtilsComparePrinterInformation = NIL;
   LlGetUsedIdentifiersExV: pfnLlGetUsedIdentifiersExV = NIL;
   LlDomGetPropertyV: pfnLlDomGetPropertyV = NIL;
   LlExprGetUsedFunctionsV: pfnLlExprGetUsedFunctionsV = NIL;
   LlExprGetUsedVarsExV: pfnLlExprGetUsedVarsExV = NIL;
   LlGetTableRelationToActiveTable: pfnLlGetTableRelationToActiveTable = NIL;
   LlJobOpenCopyEx: pfnLlJobOpenCopyEx = NIL;
   LlAddDebugSinkForThread: pfnLlAddDebugSinkForThread = NIL;
   LlRemoveDebugSinkFromThread: pfnLlRemoveDebugSinkFromThread = NIL;
   LlGetDebugSinkProxyModule: pfnLlGetDebugSinkProxyModule = NIL;
   LlGetDebugSinkProxyCategory: pfnLlGetDebugSinkProxyCategory = NIL;
   LlDlgSelectFileOpen: pfnLlDlgSelectFileOpen = NIL;
   LlUtilsLcidFromLocaleName: pfnLlUtilsLcidFromLocaleName = NIL;
   LlDesignerShowMessage: pfnLlDesignerShowMessage = NIL;
   LlExprConvertGlobalToLocal: pfnLlExprConvertGlobalToLocal = NIL;
   LlExprConvertLocalToGlobal: pfnLlExprConvertLocalToGlobal = NIL;
   LlUtilsGetProjectType: pfnLlUtilsGetProjectType = NIL;
   LlGetLastErrorText: pfnLlGetLastErrorText = NIL;
   LlDomGetCurrentObject: pfnLlDomGetCurrentObject = NIL;
   LlUtilsIDFromOrgID: pfnLlUtilsIDFromOrgID = NIL;
   LlProjectFindAndReplace: pfnLlProjectFindAndReplace = NIL;
   LlExprParseQueryDelayedDefine: pfnLlExprParseQueryDelayedDefine = NIL;
   LlExprTypeMask: pfnLlExprTypeMask = NIL;
   LlStgTestJobCmpEmbeddedStorages2: pfnLlStgTestJobCmpEmbeddedStorages2 = NIL;
   LlStgTestJobAddResultJobs: pfnLlStgTestJobAddResultJobs = NIL;
   LlStgCreateFrom: pfnLlStgCreateFrom = NIL;
   LlRemoveIdentifier: pfnLlRemoveIdentifier = NIL;
   LlExprParseEx: pfnLlExprParseEx = NIL;

function  LL28xModuleName: String;
function  LL28xLoad: integer;
procedure LL28xUnload;

implementation

var hDLLLL28: HMODULE = 0;
var nDLLLL28Usage: longint = 0;

{$ifdef WIN64}
  const LibNameLL28DLL = 'CXLL28.DLL';
 {$else}
  const LibNameLL28DLL = 'CMLL28.DLL';
{$endif}

function  LL28xModuleName: String;
begin
  Result := LibNameLL28DLL;
end;

function  LL28xLoad: integer;
var nError: integer;
begin
  Result := 0;
  inc(nDLLLL28Usage);
  if (nDLLLL28Usage = 1) then
    begin
    nError := SetErrorMode($8000); { SEM_NOOPENFILEERRORBOX }
    {$ifdef UNICODESTRING_AWARE}
      hDLLLL28 := LoadLibrary(pWideChar(LL28xModuleName()));
     {$else}
      hDLLLL28 := LoadLibrary(pChar(LL28xModuleName()));
    {$endif}
    SetErrorMode(nError);

    if (hDLLLL28 = 0) then
      begin
      Result := -1;
      dec(nDLLLL28Usage);
      end
     else
      begin
      @LlJobOpen            := GetProcAddress(hDLLLL28,'LlJobOpen');
      @LlJobOpenLCID        := GetProcAddress(hDLLLL28,'LlJobOpenLCID');
      @LlJobClose           := GetProcAddress(hDLLLL28,'LlJobClose');
      @LlSetDebug           := GetProcAddress(hDLLLL28,'LlSetDebug');
      @LlGetVersion         := GetProcAddress(hDLLLL28,'LlGetVersion');
      @LlGetNotificationMessage := GetProcAddress(hDLLLL28,'LlGetNotificationMessage');
      @LlSetNotificationMessage := GetProcAddress(hDLLLL28,'LlSetNotificationMessage');
      @LlSetNotificationCallback := GetProcAddress(hDLLLL28,'LlSetNotificationCallback');
      {$ifdef UNICODE}
          @LlDefineFieldO := GetProcAddress(hDLLLL28,'LlDefineFieldA');
        {$else}
          @LlDefineField := GetProcAddress(hDLLLL28,'LlDefineFieldA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineField := GetProcAddress(hDLLLL28,'LlDefineFieldW');
        {$else}
          @LlDefineFieldO := GetProcAddress(hDLLLL28,'LlDefineFieldW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldExtO := GetProcAddress(hDLLLL28,'LlDefineFieldExtA');
        {$else}
          @LlDefineFieldExt := GetProcAddress(hDLLLL28,'LlDefineFieldExtA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldExt := GetProcAddress(hDLLLL28,'LlDefineFieldExtW');
        {$else}
          @LlDefineFieldExtO := GetProcAddress(hDLLLL28,'LlDefineFieldExtW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldExtHandleO := GetProcAddress(hDLLLL28,'LlDefineFieldExtHandleA');
        {$else}
          @LlDefineFieldExtHandle := GetProcAddress(hDLLLL28,'LlDefineFieldExtHandleA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldExtHandle := GetProcAddress(hDLLLL28,'LlDefineFieldExtHandleW');
        {$else}
          @LlDefineFieldExtHandleO := GetProcAddress(hDLLLL28,'LlDefineFieldExtHandleW');
      {$endif}
      @LlDefineFieldStart   := GetProcAddress(hDLLLL28,'LlDefineFieldStart');
      {$ifdef UNICODE}
          @LlDefineVariableO := GetProcAddress(hDLLLL28,'LlDefineVariableA');
        {$else}
          @LlDefineVariable := GetProcAddress(hDLLLL28,'LlDefineVariableA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariable := GetProcAddress(hDLLLL28,'LlDefineVariableW');
        {$else}
          @LlDefineVariableO := GetProcAddress(hDLLLL28,'LlDefineVariableW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableExtO := GetProcAddress(hDLLLL28,'LlDefineVariableExtA');
        {$else}
          @LlDefineVariableExt := GetProcAddress(hDLLLL28,'LlDefineVariableExtA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableExt := GetProcAddress(hDLLLL28,'LlDefineVariableExtW');
        {$else}
          @LlDefineVariableExtO := GetProcAddress(hDLLLL28,'LlDefineVariableExtW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableExtHandleO := GetProcAddress(hDLLLL28,'LlDefineVariableExtHandleA');
        {$else}
          @LlDefineVariableExtHandle := GetProcAddress(hDLLLL28,'LlDefineVariableExtHandleA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableExtHandle := GetProcAddress(hDLLLL28,'LlDefineVariableExtHandleW');
        {$else}
          @LlDefineVariableExtHandleO := GetProcAddress(hDLLLL28,'LlDefineVariableExtHandleW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableNameO := GetProcAddress(hDLLLL28,'LlDefineVariableNameA');
        {$else}
          @LlDefineVariableName := GetProcAddress(hDLLLL28,'LlDefineVariableNameA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableName := GetProcAddress(hDLLLL28,'LlDefineVariableNameW');
        {$else}
          @LlDefineVariableNameO := GetProcAddress(hDLLLL28,'LlDefineVariableNameW');
      {$endif}
      @LlDefineVariableStart := GetProcAddress(hDLLLL28,'LlDefineVariableStart');
      {$ifdef UNICODE}
          @LlDefineSumVariableO := GetProcAddress(hDLLLL28,'LlDefineSumVariableA');
        {$else}
          @LlDefineSumVariable := GetProcAddress(hDLLLL28,'LlDefineSumVariableA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineSumVariable := GetProcAddress(hDLLLL28,'LlDefineSumVariableW');
        {$else}
          @LlDefineSumVariableO := GetProcAddress(hDLLLL28,'LlDefineSumVariableW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineLayoutO := GetProcAddress(hDLLLL28,'LlDefineLayoutA');
        {$else}
          @LlDefineLayout := GetProcAddress(hDLLLL28,'LlDefineLayoutA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineLayout := GetProcAddress(hDLLLL28,'LlDefineLayoutW');
        {$else}
          @LlDefineLayoutO := GetProcAddress(hDLLLL28,'LlDefineLayoutW');
      {$endif}
      {$ifdef UNICODE}
          @LlDlgEditLineO := GetProcAddress(hDLLLL28,'LlDlgEditLineA');
        {$else}
          @LlDlgEditLine := GetProcAddress(hDLLLL28,'LlDlgEditLineA');
      {$endif}
      {$ifdef UNICODE}
          @LlDlgEditLine := GetProcAddress(hDLLLL28,'LlDlgEditLineW');
        {$else}
          @LlDlgEditLineO := GetProcAddress(hDLLLL28,'LlDlgEditLineW');
      {$endif}
      {$ifdef UNICODE}
          @LlDlgEditLineExO := GetProcAddress(hDLLLL28,'LlDlgEditLineExA');
        {$else}
          @LlDlgEditLineEx := GetProcAddress(hDLLLL28,'LlDlgEditLineExA');
      {$endif}
      {$ifdef UNICODE}
          @LlDlgEditLineEx := GetProcAddress(hDLLLL28,'LlDlgEditLineExW');
        {$else}
          @LlDlgEditLineExO := GetProcAddress(hDLLLL28,'LlDlgEditLineExW');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewSetTempPathO := GetProcAddress(hDLLLL28,'LlPreviewSetTempPathA');
        {$else}
          @LlPreviewSetTempPath := GetProcAddress(hDLLLL28,'LlPreviewSetTempPathA');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewSetTempPath := GetProcAddress(hDLLLL28,'LlPreviewSetTempPathW');
        {$else}
          @LlPreviewSetTempPathO := GetProcAddress(hDLLLL28,'LlPreviewSetTempPathW');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDeleteFilesO := GetProcAddress(hDLLLL28,'LlPreviewDeleteFilesA');
        {$else}
          @LlPreviewDeleteFiles := GetProcAddress(hDLLLL28,'LlPreviewDeleteFilesA');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDeleteFiles := GetProcAddress(hDLLLL28,'LlPreviewDeleteFilesW');
        {$else}
          @LlPreviewDeleteFilesO := GetProcAddress(hDLLLL28,'LlPreviewDeleteFilesW');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDisplayO := GetProcAddress(hDLLLL28,'LlPreviewDisplayA');
        {$else}
          @LlPreviewDisplay := GetProcAddress(hDLLLL28,'LlPreviewDisplayA');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDisplay := GetProcAddress(hDLLLL28,'LlPreviewDisplayW');
        {$else}
          @LlPreviewDisplayO := GetProcAddress(hDLLLL28,'LlPreviewDisplayW');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDisplayExO := GetProcAddress(hDLLLL28,'LlPreviewDisplayExA');
        {$else}
          @LlPreviewDisplayEx := GetProcAddress(hDLLLL28,'LlPreviewDisplayExA');
      {$endif}
      {$ifdef UNICODE}
          @LlPreviewDisplayEx := GetProcAddress(hDLLLL28,'LlPreviewDisplayExW');
        {$else}
          @LlPreviewDisplayExO := GetProcAddress(hDLLLL28,'LlPreviewDisplayExW');
      {$endif}
      @LlPrint              := GetProcAddress(hDLLLL28,'LlPrint');
      @LlPrintAbort         := GetProcAddress(hDLLLL28,'LlPrintAbort');
      @LlPrintCheckLineFit  := GetProcAddress(hDLLLL28,'LlPrintCheckLineFit');
      @LlPrintEnd           := GetProcAddress(hDLLLL28,'LlPrintEnd');
      @LlPrintFields        := GetProcAddress(hDLLLL28,'LlPrintFields');
      @LlPrintFieldsEnd     := GetProcAddress(hDLLLL28,'LlPrintFieldsEnd');
      @LlPrintGetCurrentPage := GetProcAddress(hDLLLL28,'LlPrintGetCurrentPage');
      @LlPrintGetItemsPerPage := GetProcAddress(hDLLLL28,'LlPrintGetItemsPerPage');
      @LlPrintGetItemsPerTable := GetProcAddress(hDLLLL28,'LlPrintGetItemsPerTable');
      {$ifdef UNICODE}
          @LlPrintGetRemainingItemsPerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemainingItemsPerTableA');
        {$else}
          @LlPrintGetRemainingItemsPerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemainingItemsPerTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetRemainingItemsPerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemainingItemsPerTableW');
        {$else}
          @LlPrintGetRemainingItemsPerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemainingItemsPerTableW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetRemItemsPerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemItemsPerTableA');
        {$else}
          @LlPrintGetRemItemsPerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemItemsPerTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetRemItemsPerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemItemsPerTableW');
        {$else}
          @LlPrintGetRemItemsPerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemItemsPerTableW');
      {$endif}
      @LlPrintGetOption     := GetProcAddress(hDLLLL28,'LlPrintGetOption');
      {$ifdef UNICODE}
          @LlPrintGetPrinterInfoO := GetProcAddress(hDLLLL28,'LlPrintGetPrinterInfoA');
        {$else}
          @LlPrintGetPrinterInfo := GetProcAddress(hDLLLL28,'LlPrintGetPrinterInfoA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetPrinterInfo := GetProcAddress(hDLLLL28,'LlPrintGetPrinterInfoW');
        {$else}
          @LlPrintGetPrinterInfoO := GetProcAddress(hDLLLL28,'LlPrintGetPrinterInfoW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintOptionsDialogO := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogA');
        {$else}
          @LlPrintOptionsDialog := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintOptionsDialog := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogW');
        {$else}
          @LlPrintOptionsDialogO := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogW');
      {$endif}
      @LlPrintSelectOffsetEx := GetProcAddress(hDLLLL28,'LlPrintSelectOffsetEx');
      {$ifdef UNICODE}
          @LlPrintSetBoxTextO := GetProcAddress(hDLLLL28,'LlPrintSetBoxTextA');
        {$else}
          @LlPrintSetBoxText := GetProcAddress(hDLLLL28,'LlPrintSetBoxTextA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintSetBoxText := GetProcAddress(hDLLLL28,'LlPrintSetBoxTextW');
        {$else}
          @LlPrintSetBoxTextO := GetProcAddress(hDLLLL28,'LlPrintSetBoxTextW');
      {$endif}
      @LlPrintSetOption     := GetProcAddress(hDLLLL28,'LlPrintSetOption');
      @LlPrintUpdateBox     := GetProcAddress(hDLLLL28,'LlPrintUpdateBox');
      {$ifdef UNICODE}
          @LlPrintStartO := GetProcAddress(hDLLLL28,'LlPrintStartA');
        {$else}
          @LlPrintStart := GetProcAddress(hDLLLL28,'LlPrintStartA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintStart := GetProcAddress(hDLLLL28,'LlPrintStartW');
        {$else}
          @LlPrintStartO := GetProcAddress(hDLLLL28,'LlPrintStartW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintWithBoxStartO := GetProcAddress(hDLLLL28,'LlPrintWithBoxStartA');
        {$else}
          @LlPrintWithBoxStart := GetProcAddress(hDLLLL28,'LlPrintWithBoxStartA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintWithBoxStart := GetProcAddress(hDLLLL28,'LlPrintWithBoxStartW');
        {$else}
          @LlPrintWithBoxStartO := GetProcAddress(hDLLLL28,'LlPrintWithBoxStartW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrinterSetupO := GetProcAddress(hDLLLL28,'LlPrinterSetupA');
        {$else}
          @LlPrinterSetup := GetProcAddress(hDLLLL28,'LlPrinterSetupA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrinterSetup := GetProcAddress(hDLLLL28,'LlPrinterSetupW');
        {$else}
          @LlPrinterSetupO := GetProcAddress(hDLLLL28,'LlPrinterSetupW');
      {$endif}
      {$ifdef UNICODE}
          @LlSelectFileDlgTitleExO := GetProcAddress(hDLLLL28,'LlSelectFileDlgTitleExA');
        {$else}
          @LlSelectFileDlgTitleEx := GetProcAddress(hDLLLL28,'LlSelectFileDlgTitleExA');
      {$endif}
      {$ifdef UNICODE}
          @LlSelectFileDlgTitleEx := GetProcAddress(hDLLLL28,'LlSelectFileDlgTitleExW');
        {$else}
          @LlSelectFileDlgTitleExO := GetProcAddress(hDLLLL28,'LlSelectFileDlgTitleExW');
      {$endif}
      @LlSetDlgboxMode      := GetProcAddress(hDLLLL28,'LlSetDlgboxMode');
      @LlGetDlgboxMode      := GetProcAddress(hDLLLL28,'LlGetDlgboxMode');
      {$ifdef UNICODE}
          @LlExprParseO := GetProcAddress(hDLLLL28,'LlExprParseA');
        {$else}
          @LlExprParse := GetProcAddress(hDLLLL28,'LlExprParseA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprParse := GetProcAddress(hDLLLL28,'LlExprParseW');
        {$else}
          @LlExprParseO := GetProcAddress(hDLLLL28,'LlExprParseW');
      {$endif}
      @LlExprType           := GetProcAddress(hDLLLL28,'LlExprType');
      {$ifdef UNICODE}
          @LlExprErrorO := GetProcAddress(hDLLLL28,'LlExprErrorA');
        {$else}
          @LlExprError := GetProcAddress(hDLLLL28,'LlExprErrorA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprError := GetProcAddress(hDLLLL28,'LlExprErrorW');
        {$else}
          @LlExprErrorO := GetProcAddress(hDLLLL28,'LlExprErrorW');
      {$endif}
      @LlExprFree           := GetProcAddress(hDLLLL28,'LlExprFree');
      {$ifdef UNICODE}
          @LlExprEvaluateO := GetProcAddress(hDLLLL28,'LlExprEvaluateA');
        {$else}
          @LlExprEvaluate := GetProcAddress(hDLLLL28,'LlExprEvaluateA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprEvaluate := GetProcAddress(hDLLLL28,'LlExprEvaluateW');
        {$else}
          @LlExprEvaluateO := GetProcAddress(hDLLLL28,'LlExprEvaluateW');
      {$endif}
      {$ifdef UNICODE}
          @LlExprGetUsedVarsO := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsA');
        {$else}
          @LlExprGetUsedVars := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprGetUsedVars := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsW');
        {$else}
          @LlExprGetUsedVarsO := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsW');
      {$endif}
      @LlSetOption          := GetProcAddress(hDLLLL28,'LlSetOption');
      @LlGetOption          := GetProcAddress(hDLLLL28,'LlGetOption');
      {$ifdef UNICODE}
          @LlSetOptionStringO := GetProcAddress(hDLLLL28,'LlSetOptionStringA');
        {$else}
          @LlSetOptionString := GetProcAddress(hDLLLL28,'LlSetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetOptionString := GetProcAddress(hDLLLL28,'LlSetOptionStringW');
        {$else}
          @LlSetOptionStringO := GetProcAddress(hDLLLL28,'LlSetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetOptionStringO := GetProcAddress(hDLLLL28,'LlGetOptionStringA');
        {$else}
          @LlGetOptionString := GetProcAddress(hDLLLL28,'LlGetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetOptionString := GetProcAddress(hDLLLL28,'LlGetOptionStringW');
        {$else}
          @LlGetOptionStringO := GetProcAddress(hDLLLL28,'LlGetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintSetOptionStringO := GetProcAddress(hDLLLL28,'LlPrintSetOptionStringA');
        {$else}
          @LlPrintSetOptionString := GetProcAddress(hDLLLL28,'LlPrintSetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintSetOptionString := GetProcAddress(hDLLLL28,'LlPrintSetOptionStringW');
        {$else}
          @LlPrintSetOptionStringO := GetProcAddress(hDLLLL28,'LlPrintSetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetOptionStringO := GetProcAddress(hDLLLL28,'LlPrintGetOptionStringA');
        {$else}
          @LlPrintGetOptionString := GetProcAddress(hDLLLL28,'LlPrintGetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetOptionString := GetProcAddress(hDLLLL28,'LlPrintGetOptionStringW');
        {$else}
          @LlPrintGetOptionStringO := GetProcAddress(hDLLLL28,'LlPrintGetOptionStringW');
      {$endif}
      @LlDesignerProhibitAction := GetProcAddress(hDLLLL28,'LlDesignerProhibitAction');
      {$ifdef UNICODE}
          @LlDesignerProhibitFunctionO := GetProcAddress(hDLLLL28,'LlDesignerProhibitFunctionA');
        {$else}
          @LlDesignerProhibitFunction := GetProcAddress(hDLLLL28,'LlDesignerProhibitFunctionA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerProhibitFunction := GetProcAddress(hDLLLL28,'LlDesignerProhibitFunctionW');
        {$else}
          @LlDesignerProhibitFunctionO := GetProcAddress(hDLLLL28,'LlDesignerProhibitFunctionW');
      {$endif}
      @LlDesignerProhibitFunctionGroup := GetProcAddress(hDLLLL28,'LlDesignerProhibitFunctionGroup');
      {$ifdef UNICODE}
          @LlPrintEnableObjectO := GetProcAddress(hDLLLL28,'LlPrintEnableObjectA');
        {$else}
          @LlPrintEnableObject := GetProcAddress(hDLLLL28,'LlPrintEnableObjectA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintEnableObject := GetProcAddress(hDLLLL28,'LlPrintEnableObjectW');
        {$else}
          @LlPrintEnableObjectO := GetProcAddress(hDLLLL28,'LlPrintEnableObjectW');
      {$endif}
      {$ifdef UNICODE}
          @LlSetFileExtensionsO := GetProcAddress(hDLLLL28,'LlSetFileExtensionsA');
        {$else}
          @LlSetFileExtensions := GetProcAddress(hDLLLL28,'LlSetFileExtensionsA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetFileExtensions := GetProcAddress(hDLLLL28,'LlSetFileExtensionsW');
        {$else}
          @LlSetFileExtensionsO := GetProcAddress(hDLLLL28,'LlSetFileExtensionsW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetTextCharsPrintedO := GetProcAddress(hDLLLL28,'LlPrintGetTextCharsPrintedA');
        {$else}
          @LlPrintGetTextCharsPrinted := GetProcAddress(hDLLLL28,'LlPrintGetTextCharsPrintedA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetTextCharsPrinted := GetProcAddress(hDLLLL28,'LlPrintGetTextCharsPrintedW');
        {$else}
          @LlPrintGetTextCharsPrintedO := GetProcAddress(hDLLLL28,'LlPrintGetTextCharsPrintedW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetFieldCharsPrintedO := GetProcAddress(hDLLLL28,'LlPrintGetFieldCharsPrintedA');
        {$else}
          @LlPrintGetFieldCharsPrinted := GetProcAddress(hDLLLL28,'LlPrintGetFieldCharsPrintedA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetFieldCharsPrinted := GetProcAddress(hDLLLL28,'LlPrintGetFieldCharsPrintedW');
        {$else}
          @LlPrintGetFieldCharsPrintedO := GetProcAddress(hDLLLL28,'LlPrintGetFieldCharsPrintedW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintIsVariableUsedO := GetProcAddress(hDLLLL28,'LlPrintIsVariableUsedA');
        {$else}
          @LlPrintIsVariableUsed := GetProcAddress(hDLLLL28,'LlPrintIsVariableUsedA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintIsVariableUsed := GetProcAddress(hDLLLL28,'LlPrintIsVariableUsedW');
        {$else}
          @LlPrintIsVariableUsedO := GetProcAddress(hDLLLL28,'LlPrintIsVariableUsedW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintIsFieldUsedO := GetProcAddress(hDLLLL28,'LlPrintIsFieldUsedA');
        {$else}
          @LlPrintIsFieldUsed := GetProcAddress(hDLLLL28,'LlPrintIsFieldUsedA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintIsFieldUsed := GetProcAddress(hDLLLL28,'LlPrintIsFieldUsedW');
        {$else}
          @LlPrintIsFieldUsedO := GetProcAddress(hDLLLL28,'LlPrintIsFieldUsedW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintOptionsDialogTitleO := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogTitleA');
        {$else}
          @LlPrintOptionsDialogTitle := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogTitleA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintOptionsDialogTitle := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogTitleW');
        {$else}
          @LlPrintOptionsDialogTitleO := GetProcAddress(hDLLLL28,'LlPrintOptionsDialogTitleW');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterToDefaultO := GetProcAddress(hDLLLL28,'LlSetPrinterToDefaultA');
        {$else}
          @LlSetPrinterToDefault := GetProcAddress(hDLLLL28,'LlSetPrinterToDefaultA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterToDefault := GetProcAddress(hDLLLL28,'LlSetPrinterToDefaultW');
        {$else}
          @LlSetPrinterToDefaultO := GetProcAddress(hDLLLL28,'LlSetPrinterToDefaultW');
      {$endif}
      @LlDefineSortOrderStart := GetProcAddress(hDLLLL28,'LlDefineSortOrderStart');
      {$ifdef UNICODE}
          @LlDefineSortOrderO := GetProcAddress(hDLLLL28,'LlDefineSortOrderA');
        {$else}
          @LlDefineSortOrder := GetProcAddress(hDLLLL28,'LlDefineSortOrderA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineSortOrder := GetProcAddress(hDLLLL28,'LlDefineSortOrderW');
        {$else}
          @LlDefineSortOrderO := GetProcAddress(hDLLLL28,'LlDefineSortOrderW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetSortOrderO := GetProcAddress(hDLLLL28,'LlPrintGetSortOrderA');
        {$else}
          @LlPrintGetSortOrder := GetProcAddress(hDLLLL28,'LlPrintGetSortOrderA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetSortOrder := GetProcAddress(hDLLLL28,'LlPrintGetSortOrderW');
        {$else}
          @LlPrintGetSortOrderO := GetProcAddress(hDLLLL28,'LlPrintGetSortOrderW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineGroupingO := GetProcAddress(hDLLLL28,'LlDefineGroupingA');
        {$else}
          @LlDefineGrouping := GetProcAddress(hDLLLL28,'LlDefineGroupingA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineGrouping := GetProcAddress(hDLLLL28,'LlDefineGroupingW');
        {$else}
          @LlDefineGroupingO := GetProcAddress(hDLLLL28,'LlDefineGroupingW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetGroupingO := GetProcAddress(hDLLLL28,'LlPrintGetGroupingA');
        {$else}
          @LlPrintGetGrouping := GetProcAddress(hDLLLL28,'LlPrintGetGroupingA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetGrouping := GetProcAddress(hDLLLL28,'LlPrintGetGroupingW');
        {$else}
          @LlPrintGetGroupingO := GetProcAddress(hDLLLL28,'LlPrintGetGroupingW');
      {$endif}
      {$ifdef UNICODE}
          @LlAddCtlSupportO := GetProcAddress(hDLLLL28,'LlAddCtlSupportA');
        {$else}
          @LlAddCtlSupport := GetProcAddress(hDLLLL28,'LlAddCtlSupportA');
      {$endif}
      {$ifdef UNICODE}
          @LlAddCtlSupport := GetProcAddress(hDLLLL28,'LlAddCtlSupportW');
        {$else}
          @LlAddCtlSupportO := GetProcAddress(hDLLLL28,'LlAddCtlSupportW');
      {$endif}
      @LlPrintBeginGroup    := GetProcAddress(hDLLLL28,'LlPrintBeginGroup');
      @LlPrintEndGroup      := GetProcAddress(hDLLLL28,'LlPrintEndGroup');
      @LlPrintGroupLine     := GetProcAddress(hDLLLL28,'LlPrintGroupLine');
      @LlPrintGroupHeader   := GetProcAddress(hDLLLL28,'LlPrintGroupHeader');
      {$ifdef UNICODE}
          @LlPrintGetFilterExpressionO := GetProcAddress(hDLLLL28,'LlPrintGetFilterExpressionA');
        {$else}
          @LlPrintGetFilterExpression := GetProcAddress(hDLLLL28,'LlPrintGetFilterExpressionA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetFilterExpression := GetProcAddress(hDLLLL28,'LlPrintGetFilterExpressionW');
        {$else}
          @LlPrintGetFilterExpressionO := GetProcAddress(hDLLLL28,'LlPrintGetFilterExpressionW');
      {$endif}
      @LlPrintWillMatchFilter := GetProcAddress(hDLLLL28,'LlPrintWillMatchFilter');
      @LlPrintDidMatchFilter := GetProcAddress(hDLLLL28,'LlPrintDidMatchFilter');
      {$ifdef UNICODE}
          @LlGetFieldContentsO := GetProcAddress(hDLLLL28,'LlGetFieldContentsA');
        {$else}
          @LlGetFieldContents := GetProcAddress(hDLLLL28,'LlGetFieldContentsA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetFieldContents := GetProcAddress(hDLLLL28,'LlGetFieldContentsW');
        {$else}
          @LlGetFieldContentsO := GetProcAddress(hDLLLL28,'LlGetFieldContentsW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetVariableContentsO := GetProcAddress(hDLLLL28,'LlGetVariableContentsA');
        {$else}
          @LlGetVariableContents := GetProcAddress(hDLLLL28,'LlGetVariableContentsA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetVariableContents := GetProcAddress(hDLLLL28,'LlGetVariableContentsW');
        {$else}
          @LlGetVariableContentsO := GetProcAddress(hDLLLL28,'LlGetVariableContentsW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetSumVariableContentsO := GetProcAddress(hDLLLL28,'LlGetSumVariableContentsA');
        {$else}
          @LlGetSumVariableContents := GetProcAddress(hDLLLL28,'LlGetSumVariableContentsA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetSumVariableContents := GetProcAddress(hDLLLL28,'LlGetSumVariableContentsW');
        {$else}
          @LlGetSumVariableContentsO := GetProcAddress(hDLLLL28,'LlGetSumVariableContentsW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUserVariableContentsO := GetProcAddress(hDLLLL28,'LlGetUserVariableContentsA');
        {$else}
          @LlGetUserVariableContents := GetProcAddress(hDLLLL28,'LlGetUserVariableContentsA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUserVariableContents := GetProcAddress(hDLLLL28,'LlGetUserVariableContentsW');
        {$else}
          @LlGetUserVariableContentsO := GetProcAddress(hDLLLL28,'LlGetUserVariableContentsW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetVariableTypeO := GetProcAddress(hDLLLL28,'LlGetVariableTypeA');
        {$else}
          @LlGetVariableType := GetProcAddress(hDLLLL28,'LlGetVariableTypeA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetVariableType := GetProcAddress(hDLLLL28,'LlGetVariableTypeW');
        {$else}
          @LlGetVariableTypeO := GetProcAddress(hDLLLL28,'LlGetVariableTypeW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetFieldTypeO := GetProcAddress(hDLLLL28,'LlGetFieldTypeA');
        {$else}
          @LlGetFieldType := GetProcAddress(hDLLLL28,'LlGetFieldTypeA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetFieldType := GetProcAddress(hDLLLL28,'LlGetFieldTypeW');
        {$else}
          @LlGetFieldTypeO := GetProcAddress(hDLLLL28,'LlGetFieldTypeW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetColumnInfoO := GetProcAddress(hDLLLL28,'LlPrintGetColumnInfoA');
        {$else}
          @LlPrintGetColumnInfo := GetProcAddress(hDLLLL28,'LlPrintGetColumnInfoA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetColumnInfo := GetProcAddress(hDLLLL28,'LlPrintGetColumnInfoW');
        {$else}
          @LlPrintGetColumnInfoO := GetProcAddress(hDLLLL28,'LlPrintGetColumnInfoW');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterDefaultsDirO := GetProcAddress(hDLLLL28,'LlSetPrinterDefaultsDirA');
        {$else}
          @LlSetPrinterDefaultsDir := GetProcAddress(hDLLLL28,'LlSetPrinterDefaultsDirA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterDefaultsDir := GetProcAddress(hDLLLL28,'LlSetPrinterDefaultsDirW');
        {$else}
          @LlSetPrinterDefaultsDirO := GetProcAddress(hDLLLL28,'LlSetPrinterDefaultsDirW');
      {$endif}
      {$ifdef UNICODE}
          @LlCreateSketchO := GetProcAddress(hDLLLL28,'LlCreateSketchA');
        {$else}
          @LlCreateSketch := GetProcAddress(hDLLLL28,'LlCreateSketchA');
      {$endif}
      {$ifdef UNICODE}
          @LlCreateSketch := GetProcAddress(hDLLLL28,'LlCreateSketchW');
        {$else}
          @LlCreateSketchO := GetProcAddress(hDLLLL28,'LlCreateSketchW');
      {$endif}
      @LlViewerProhibitAction := GetProcAddress(hDLLLL28,'LlViewerProhibitAction');
      {$ifdef UNICODE}
          @LlPrintCopyPrinterConfigurationO := GetProcAddress(hDLLLL28,'LlPrintCopyPrinterConfigurationA');
        {$else}
          @LlPrintCopyPrinterConfiguration := GetProcAddress(hDLLLL28,'LlPrintCopyPrinterConfigurationA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintCopyPrinterConfiguration := GetProcAddress(hDLLLL28,'LlPrintCopyPrinterConfigurationW');
        {$else}
          @LlPrintCopyPrinterConfigurationO := GetProcAddress(hDLLLL28,'LlPrintCopyPrinterConfigurationW');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterInPrinterFileO := GetProcAddress(hDLLLL28,'LlSetPrinterInPrinterFileA');
        {$else}
          @LlSetPrinterInPrinterFile := GetProcAddress(hDLLLL28,'LlSetPrinterInPrinterFileA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetPrinterInPrinterFile := GetProcAddress(hDLLLL28,'LlSetPrinterInPrinterFileW');
        {$else}
          @LlSetPrinterInPrinterFileO := GetProcAddress(hDLLLL28,'LlSetPrinterInPrinterFileW');
      {$endif}
      @LlRTFCreateObject    := GetProcAddress(hDLLLL28,'LlRTFCreateObject');
      @LlRTFDeleteObject    := GetProcAddress(hDLLLL28,'LlRTFDeleteObject');
      {$ifdef UNICODE}
          @LlRTFSetTextO := GetProcAddress(hDLLLL28,'LlRTFSetTextA');
        {$else}
          @LlRTFSetText := GetProcAddress(hDLLLL28,'LlRTFSetTextA');
      {$endif}
      {$ifdef UNICODE}
          @LlRTFSetText := GetProcAddress(hDLLLL28,'LlRTFSetTextW');
        {$else}
          @LlRTFSetTextO := GetProcAddress(hDLLLL28,'LlRTFSetTextW');
      {$endif}
      @LlRTFGetTextLength   := GetProcAddress(hDLLLL28,'LlRTFGetTextLength');
      {$ifdef UNICODE}
          @LlRTFGetTextO := GetProcAddress(hDLLLL28,'LlRTFGetTextA');
        {$else}
          @LlRTFGetText := GetProcAddress(hDLLLL28,'LlRTFGetTextA');
      {$endif}
      {$ifdef UNICODE}
          @LlRTFGetText := GetProcAddress(hDLLLL28,'LlRTFGetTextW');
        {$else}
          @LlRTFGetTextO := GetProcAddress(hDLLLL28,'LlRTFGetTextW');
      {$endif}
      @LlRTFEditObject      := GetProcAddress(hDLLLL28,'LlRTFEditObject');
      @LlRTFCopyToClipboard := GetProcAddress(hDLLLL28,'LlRTFCopyToClipboard');
      @LlRTFDisplay         := GetProcAddress(hDLLLL28,'LlRTFDisplay');
      @LlRTFEditorProhibitAction := GetProcAddress(hDLLLL28,'LlRTFEditorProhibitAction');
      @LlRTFEditorInvokeAction := GetProcAddress(hDLLLL28,'LlRTFEditorInvokeAction');
      {$ifdef UNICODE}
          @LlDebugOutputO := GetProcAddress(hDLLLL28,'LlDebugOutputA');
        {$else}
          @LlDebugOutput := GetProcAddress(hDLLLL28,'LlDebugOutputA');
      {$endif}
      {$ifdef UNICODE}
          @LlDebugOutput := GetProcAddress(hDLLLL28,'LlDebugOutputW');
        {$else}
          @LlDebugOutputO := GetProcAddress(hDLLLL28,'LlDebugOutputW');
      {$endif}
      @LlEnumGetFirstVar    := GetProcAddress(hDLLLL28,'LlEnumGetFirstVar');
      @LlEnumGetFirstField  := GetProcAddress(hDLLLL28,'LlEnumGetFirstField');
      @LlEnumGetFirstConstant := GetProcAddress(hDLLLL28,'LlEnumGetFirstConstant');
      @LlEnumGetNextEntry   := GetProcAddress(hDLLLL28,'LlEnumGetNextEntry');
      {$ifdef UNICODE}
          @LlEnumGetEntryO := GetProcAddress(hDLLLL28,'LlEnumGetEntryA');
        {$else}
          @LlEnumGetEntry := GetProcAddress(hDLLLL28,'LlEnumGetEntryA');
      {$endif}
      {$ifdef UNICODE}
          @LlEnumGetEntry := GetProcAddress(hDLLLL28,'LlEnumGetEntryW');
        {$else}
          @LlEnumGetEntryO := GetProcAddress(hDLLLL28,'LlEnumGetEntryW');
      {$endif}
      @LlPrintResetObjectStates := GetProcAddress(hDLLLL28,'LlPrintResetObjectStates');
      {$ifdef UNICODE}
          @LlXSetParameterO := GetProcAddress(hDLLLL28,'LlXSetParameterA');
        {$else}
          @LlXSetParameter := GetProcAddress(hDLLLL28,'LlXSetParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlXSetParameter := GetProcAddress(hDLLLL28,'LlXSetParameterW');
        {$else}
          @LlXSetParameterO := GetProcAddress(hDLLLL28,'LlXSetParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlXGetParameterO := GetProcAddress(hDLLLL28,'LlXGetParameterA');
        {$else}
          @LlXGetParameter := GetProcAddress(hDLLLL28,'LlXGetParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlXGetParameter := GetProcAddress(hDLLLL28,'LlXGetParameterW');
        {$else}
          @LlXGetParameterO := GetProcAddress(hDLLLL28,'LlXGetParameterW');
      {$endif}
      @LlPrintResetProjectState := GetProcAddress(hDLLLL28,'LlPrintResetProjectState');
      @LlDefineChartFieldStart := GetProcAddress(hDLLLL28,'LlDefineChartFieldStart');
      {$ifdef UNICODE}
          @LlDefineChartFieldExtO := GetProcAddress(hDLLLL28,'LlDefineChartFieldExtA');
        {$else}
          @LlDefineChartFieldExt := GetProcAddress(hDLLLL28,'LlDefineChartFieldExtA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineChartFieldExt := GetProcAddress(hDLLLL28,'LlDefineChartFieldExtW');
        {$else}
          @LlDefineChartFieldExtO := GetProcAddress(hDLLLL28,'LlDefineChartFieldExtW');
      {$endif}
      @LlPrintDeclareChartRow := GetProcAddress(hDLLLL28,'LlPrintDeclareChartRow');
      @LlPrintGetChartObjectCount := GetProcAddress(hDLLLL28,'LlPrintGetChartObjectCount');
      {$ifdef UNICODE}
          @LlPrintIsChartFieldUsedO := GetProcAddress(hDLLLL28,'LlPrintIsChartFieldUsedA');
        {$else}
          @LlPrintIsChartFieldUsed := GetProcAddress(hDLLLL28,'LlPrintIsChartFieldUsedA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintIsChartFieldUsed := GetProcAddress(hDLLLL28,'LlPrintIsChartFieldUsedW');
        {$else}
          @LlPrintIsChartFieldUsedO := GetProcAddress(hDLLLL28,'LlPrintIsChartFieldUsedW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetChartFieldContentsO := GetProcAddress(hDLLLL28,'LlGetChartFieldContentsA');
        {$else}
          @LlGetChartFieldContents := GetProcAddress(hDLLLL28,'LlGetChartFieldContentsA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetChartFieldContents := GetProcAddress(hDLLLL28,'LlGetChartFieldContentsW');
        {$else}
          @LlGetChartFieldContentsO := GetProcAddress(hDLLLL28,'LlGetChartFieldContentsW');
      {$endif}
      @LlEnumGetFirstChartField := GetProcAddress(hDLLLL28,'LlEnumGetFirstChartField');
      @LlSetNotificationCallbackExt := GetProcAddress(hDLLLL28,'LlSetNotificationCallbackExt');
      @LlExprEvaluateVar    := GetProcAddress(hDLLLL28,'LlExprEvaluateVar');
      @LlExprTypeVar        := GetProcAddress(hDLLLL28,'LlExprTypeVar');
      {$ifdef UNICODE}
          @LlGetPrinterFromPrinterFileO := GetProcAddress(hDLLLL28,'LlGetPrinterFromPrinterFileA');
        {$else}
          @LlGetPrinterFromPrinterFile := GetProcAddress(hDLLLL28,'LlGetPrinterFromPrinterFileA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetPrinterFromPrinterFile := GetProcAddress(hDLLLL28,'LlGetPrinterFromPrinterFileW');
        {$else}
          @LlGetPrinterFromPrinterFileO := GetProcAddress(hDLLLL28,'LlGetPrinterFromPrinterFileW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetRemainingSpacePerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemainingSpacePerTableA');
        {$else}
          @LlPrintGetRemainingSpacePerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemainingSpacePerTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetRemainingSpacePerTable := GetProcAddress(hDLLLL28,'LlPrintGetRemainingSpacePerTableW');
        {$else}
          @LlPrintGetRemainingSpacePerTableO := GetProcAddress(hDLLLL28,'LlPrintGetRemainingSpacePerTableW');
      {$endif}
      @LlDrawToolbarBackground := GetProcAddress(hDLLLL28,'LlDrawToolbarBackground');
      {$ifdef UNICODE}
          @LlSetDefaultProjectParameterO := GetProcAddress(hDLLLL28,'LlSetDefaultProjectParameterA');
        {$else}
          @LlSetDefaultProjectParameter := GetProcAddress(hDLLLL28,'LlSetDefaultProjectParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlSetDefaultProjectParameter := GetProcAddress(hDLLLL28,'LlSetDefaultProjectParameterW');
        {$else}
          @LlSetDefaultProjectParameterO := GetProcAddress(hDLLLL28,'LlSetDefaultProjectParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetDefaultProjectParameterO := GetProcAddress(hDLLLL28,'LlGetDefaultProjectParameterA');
        {$else}
          @LlGetDefaultProjectParameter := GetProcAddress(hDLLLL28,'LlGetDefaultProjectParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetDefaultProjectParameter := GetProcAddress(hDLLLL28,'LlGetDefaultProjectParameterW');
        {$else}
          @LlGetDefaultProjectParameterO := GetProcAddress(hDLLLL28,'LlGetDefaultProjectParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintSetProjectParameterO := GetProcAddress(hDLLLL28,'LlPrintSetProjectParameterA');
        {$else}
          @LlPrintSetProjectParameter := GetProcAddress(hDLLLL28,'LlPrintSetProjectParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintSetProjectParameter := GetProcAddress(hDLLLL28,'LlPrintSetProjectParameterW');
        {$else}
          @LlPrintSetProjectParameterO := GetProcAddress(hDLLLL28,'LlPrintSetProjectParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetProjectParameterO := GetProcAddress(hDLLLL28,'LlPrintGetProjectParameterA');
        {$else}
          @LlPrintGetProjectParameter := GetProcAddress(hDLLLL28,'LlPrintGetProjectParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintGetProjectParameter := GetProcAddress(hDLLLL28,'LlPrintGetProjectParameterW');
        {$else}
          @LlPrintGetProjectParameterO := GetProcAddress(hDLLLL28,'LlPrintGetProjectParameterW');
      {$endif}
      @LlCreateObject       := GetProcAddress(hDLLLL28,'LlCreateObject');
      {$ifdef UNICODE}
          @LlExprContainsVariableO := GetProcAddress(hDLLLL28,'LlExprContainsVariableA');
        {$else}
          @LlExprContainsVariable := GetProcAddress(hDLLLL28,'LlExprContainsVariableA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprContainsVariable := GetProcAddress(hDLLLL28,'LlExprContainsVariableW');
        {$else}
          @LlExprContainsVariableO := GetProcAddress(hDLLLL28,'LlExprContainsVariableW');
      {$endif}
      @LlExprIsConstant     := GetProcAddress(hDLLLL28,'LlExprIsConstant');
      {$ifdef UNICODE}
          @LlProfileStartO := GetProcAddress(hDLLLL28,'LlProfileStartA');
        {$else}
          @LlProfileStart := GetProcAddress(hDLLLL28,'LlProfileStartA');
      {$endif}
      {$ifdef UNICODE}
          @LlProfileStart := GetProcAddress(hDLLLL28,'LlProfileStartW');
        {$else}
          @LlProfileStartO := GetProcAddress(hDLLLL28,'LlProfileStartW');
      {$endif}
      @LlProfileEnd         := GetProcAddress(hDLLLL28,'LlProfileEnd');
      @LlDumpMemory         := GetProcAddress(hDLLLL28,'LlDumpMemory');
      {$ifdef UNICODE}
          @LlDbAddTableO := GetProcAddress(hDLLLL28,'LlDbAddTableA');
        {$else}
          @LlDbAddTable := GetProcAddress(hDLLLL28,'LlDbAddTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTable := GetProcAddress(hDLLLL28,'LlDbAddTableW');
        {$else}
          @LlDbAddTableO := GetProcAddress(hDLLLL28,'LlDbAddTableW');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableRelationO := GetProcAddress(hDLLLL28,'LlDbAddTableRelationA');
        {$else}
          @LlDbAddTableRelation := GetProcAddress(hDLLLL28,'LlDbAddTableRelationA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableRelation := GetProcAddress(hDLLLL28,'LlDbAddTableRelationW');
        {$else}
          @LlDbAddTableRelationO := GetProcAddress(hDLLLL28,'LlDbAddTableRelationW');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableSortOrderO := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderA');
        {$else}
          @LlDbAddTableSortOrder := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableSortOrder := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderW');
        {$else}
          @LlDbAddTableSortOrderO := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTableO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableA');
        {$else}
          @LlPrintDbGetCurrentTable := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTable := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableW');
        {$else}
          @LlPrintDbGetCurrentTableO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTableRelationO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableRelationA');
        {$else}
          @LlPrintDbGetCurrentTableRelation := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableRelationA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTableRelation := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableRelationW');
        {$else}
          @LlPrintDbGetCurrentTableRelationO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableRelationW');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTableSortOrderO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableSortOrderA');
        {$else}
          @LlPrintDbGetCurrentTableSortOrder := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableSortOrderA');
      {$endif}
      {$ifdef UNICODE}
          @LlPrintDbGetCurrentTableSortOrder := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableSortOrderW');
        {$else}
          @LlPrintDbGetCurrentTableSortOrderO := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableSortOrderW');
      {$endif}
      @LlDbDumpStructure    := GetProcAddress(hDLLLL28,'LlDbDumpStructure');
      @LlPrintDbGetRootTableCount := GetProcAddress(hDLLLL28,'LlPrintDbGetRootTableCount');
      {$ifdef UNICODE}
          @LlDbSetMasterTableO := GetProcAddress(hDLLLL28,'LlDbSetMasterTableA');
        {$else}
          @LlDbSetMasterTable := GetProcAddress(hDLLLL28,'LlDbSetMasterTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbSetMasterTable := GetProcAddress(hDLLLL28,'LlDbSetMasterTableW');
        {$else}
          @LlDbSetMasterTableO := GetProcAddress(hDLLLL28,'LlDbSetMasterTableW');
      {$endif}
      {$ifdef UNICODE}
          @LlDbGetMasterTableO := GetProcAddress(hDLLLL28,'LlDbGetMasterTableA');
        {$else}
          @LlDbGetMasterTable := GetProcAddress(hDLLLL28,'LlDbGetMasterTableA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbGetMasterTable := GetProcAddress(hDLLLL28,'LlDbGetMasterTableW');
        {$else}
          @LlDbGetMasterTableO := GetProcAddress(hDLLLL28,'LlDbGetMasterTableW');
      {$endif}
      {$ifdef UNICODE}
          @LlXSetExportParameterO := GetProcAddress(hDLLLL28,'LlXSetExportParameterA');
        {$else}
          @LlXSetExportParameter := GetProcAddress(hDLLLL28,'LlXSetExportParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlXSetExportParameter := GetProcAddress(hDLLLL28,'LlXSetExportParameterW');
        {$else}
          @LlXSetExportParameterO := GetProcAddress(hDLLLL28,'LlXSetExportParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlXGetExportParameterO := GetProcAddress(hDLLLL28,'LlXGetExportParameterA');
        {$else}
          @LlXGetExportParameter := GetProcAddress(hDLLLL28,'LlXGetExportParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlXGetExportParameter := GetProcAddress(hDLLLL28,'LlXGetExportParameterW');
        {$else}
          @LlXGetExportParameterO := GetProcAddress(hDLLLL28,'LlXGetExportParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlXlatNameO := GetProcAddress(hDLLLL28,'LlXlatNameA');
        {$else}
          @LlXlatName := GetProcAddress(hDLLLL28,'LlXlatNameA');
      {$endif}
      {$ifdef UNICODE}
          @LlXlatName := GetProcAddress(hDLLLL28,'LlXlatNameW');
        {$else}
          @LlXlatNameO := GetProcAddress(hDLLLL28,'LlXlatNameW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableVarO := GetProcAddress(hDLLLL28,'LlDefineVariableVarA');
        {$else}
          @LlDefineVariableVar := GetProcAddress(hDLLLL28,'LlDefineVariableVarA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineVariableVar := GetProcAddress(hDLLLL28,'LlDefineVariableVarW');
        {$else}
          @LlDefineVariableVarO := GetProcAddress(hDLLLL28,'LlDefineVariableVarW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldVarO := GetProcAddress(hDLLLL28,'LlDefineFieldVarA');
        {$else}
          @LlDefineFieldVar := GetProcAddress(hDLLLL28,'LlDefineFieldVarA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineFieldVar := GetProcAddress(hDLLLL28,'LlDefineFieldVarW');
        {$else}
          @LlDefineFieldVarO := GetProcAddress(hDLLLL28,'LlDefineFieldVarW');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineChartFieldVarO := GetProcAddress(hDLLLL28,'LlDefineChartFieldVarA');
        {$else}
          @LlDefineChartFieldVar := GetProcAddress(hDLLLL28,'LlDefineChartFieldVarA');
      {$endif}
      {$ifdef UNICODE}
          @LlDefineChartFieldVar := GetProcAddress(hDLLLL28,'LlDefineChartFieldVarW');
        {$else}
          @LlDefineChartFieldVarO := GetProcAddress(hDLLLL28,'LlDefineChartFieldVarW');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerProhibitEditingObjectO := GetProcAddress(hDLLLL28,'LlDesignerProhibitEditingObjectA');
        {$else}
          @LlDesignerProhibitEditingObject := GetProcAddress(hDLLLL28,'LlDesignerProhibitEditingObjectA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerProhibitEditingObject := GetProcAddress(hDLLLL28,'LlDesignerProhibitEditingObjectW');
        {$else}
          @LlDesignerProhibitEditingObjectO := GetProcAddress(hDLLLL28,'LlDesignerProhibitEditingObjectW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUsedIdentifiersO := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersA');
        {$else}
          @LlGetUsedIdentifiers := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUsedIdentifiers := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersW');
        {$else}
          @LlGetUsedIdentifiersO := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersW');
      {$endif}
      {$ifdef UNICODE}
          @LlExprGetUsedVarsExO := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsExA');
        {$else}
          @LlExprGetUsedVarsEx := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsExA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprGetUsedVarsEx := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsExW');
        {$else}
          @LlExprGetUsedVarsExO := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsExW');
      {$endif}
      @LlDomGetProject      := GetProcAddress(hDLLLL28,'LlDomGetProject');
      {$ifdef UNICODE}
          @LlDomGetPropertyO := GetProcAddress(hDLLLL28,'LlDomGetPropertyA');
        {$else}
          @LlDomGetProperty := GetProcAddress(hDLLLL28,'LlDomGetPropertyA');
      {$endif}
      {$ifdef UNICODE}
          @LlDomGetProperty := GetProcAddress(hDLLLL28,'LlDomGetPropertyW');
        {$else}
          @LlDomGetPropertyO := GetProcAddress(hDLLLL28,'LlDomGetPropertyW');
      {$endif}
      {$ifdef UNICODE}
          @LlDomSetPropertyO := GetProcAddress(hDLLLL28,'LlDomSetPropertyA');
        {$else}
          @LlDomSetProperty := GetProcAddress(hDLLLL28,'LlDomSetPropertyA');
      {$endif}
      {$ifdef UNICODE}
          @LlDomSetProperty := GetProcAddress(hDLLLL28,'LlDomSetPropertyW');
        {$else}
          @LlDomSetPropertyO := GetProcAddress(hDLLLL28,'LlDomSetPropertyW');
      {$endif}
      {$ifdef UNICODE}
          @LlDomGetObjectO := GetProcAddress(hDLLLL28,'LlDomGetObjectA');
        {$else}
          @LlDomGetObject := GetProcAddress(hDLLLL28,'LlDomGetObjectA');
      {$endif}
      {$ifdef UNICODE}
          @LlDomGetObject := GetProcAddress(hDLLLL28,'LlDomGetObjectW');
        {$else}
          @LlDomGetObjectO := GetProcAddress(hDLLLL28,'LlDomGetObjectW');
      {$endif}
      @LlDomGetSubobjectCount := GetProcAddress(hDLLLL28,'LlDomGetSubobjectCount');
      @LlDomGetSubobject    := GetProcAddress(hDLLLL28,'LlDomGetSubobject');
      {$ifdef UNICODE}
          @LlDomCreateSubobjectO := GetProcAddress(hDLLLL28,'LlDomCreateSubobjectA');
        {$else}
          @LlDomCreateSubobject := GetProcAddress(hDLLLL28,'LlDomCreateSubobjectA');
      {$endif}
      {$ifdef UNICODE}
          @LlDomCreateSubobject := GetProcAddress(hDLLLL28,'LlDomCreateSubobjectW');
        {$else}
          @LlDomCreateSubobjectO := GetProcAddress(hDLLLL28,'LlDomCreateSubobjectW');
      {$endif}
      @LlDomDeleteSubobject := GetProcAddress(hDLLLL28,'LlDomDeleteSubobject');
      @LlDomMoveSubobject   := GetProcAddress(hDLLLL28,'LlDomMoveSubobject');
      {$ifdef UNICODE}
          @LlProjectOpenO := GetProcAddress(hDLLLL28,'LlProjectOpenA');
        {$else}
          @LlProjectOpen := GetProcAddress(hDLLLL28,'LlProjectOpenA');
      {$endif}
      {$ifdef UNICODE}
          @LlProjectOpen := GetProcAddress(hDLLLL28,'LlProjectOpenW');
        {$else}
          @LlProjectOpenO := GetProcAddress(hDLLLL28,'LlProjectOpenW');
      {$endif}
      {$ifdef UNICODE}
          @LlProjectSaveO := GetProcAddress(hDLLLL28,'LlProjectSaveA');
        {$else}
          @LlProjectSave := GetProcAddress(hDLLLL28,'LlProjectSaveA');
      {$endif}
      {$ifdef UNICODE}
          @LlProjectSave := GetProcAddress(hDLLLL28,'LlProjectSaveW');
        {$else}
          @LlProjectSaveO := GetProcAddress(hDLLLL28,'LlProjectSaveW');
      {$endif}
      {$ifdef UNICODE}
          @LlProjectSaveCopyAsO := GetProcAddress(hDLLLL28,'LlProjectSaveCopyAsA');
        {$else}
          @LlProjectSaveCopyAs := GetProcAddress(hDLLLL28,'LlProjectSaveCopyAsA');
      {$endif}
      {$ifdef UNICODE}
          @LlProjectSaveCopyAs := GetProcAddress(hDLLLL28,'LlProjectSaveCopyAsW');
        {$else}
          @LlProjectSaveCopyAsO := GetProcAddress(hDLLLL28,'LlProjectSaveCopyAsW');
      {$endif}
      @LlProjectClose       := GetProcAddress(hDLLLL28,'LlProjectClose');
      @LlDomGetPropertyCount := GetProcAddress(hDLLLL28,'LlDomGetPropertyCount');
      @LlAssociatePreviewControl := GetProcAddress(hDLLLL28,'LlAssociatePreviewControl');
      {$ifdef UNICODE}
          @LlGetErrortextO := GetProcAddress(hDLLLL28,'LlGetErrortextA');
        {$else}
          @LlGetErrortext := GetProcAddress(hDLLLL28,'LlGetErrortextA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetErrortext := GetProcAddress(hDLLLL28,'LlGetErrortextW');
        {$else}
          @LlGetErrortextO := GetProcAddress(hDLLLL28,'LlGetErrortextW');
      {$endif}
      @LlSetPreviewOption   := GetProcAddress(hDLLLL28,'LlSetPreviewOption');
      @LlGetPreviewOption   := GetProcAddress(hDLLLL28,'LlGetPreviewOption');
      @LlDesignerInvokeAction := GetProcAddress(hDLLLL28,'LlDesignerInvokeAction');
      @LlDesignerRefreshWorkspace := GetProcAddress(hDLLLL28,'LlDesignerRefreshWorkspace');
      {$ifdef UNICODE}
          @LlDesignerFileOpenO := GetProcAddress(hDLLLL28,'LlDesignerFileOpenA');
        {$else}
          @LlDesignerFileOpen := GetProcAddress(hDLLLL28,'LlDesignerFileOpenA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerFileOpen := GetProcAddress(hDLLLL28,'LlDesignerFileOpenW');
        {$else}
          @LlDesignerFileOpenO := GetProcAddress(hDLLLL28,'LlDesignerFileOpenW');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerFileSaveO := GetProcAddress(hDLLLL28,'LlDesignerFileSaveA');
        {$else}
          @LlDesignerFileSave := GetProcAddress(hDLLLL28,'LlDesignerFileSaveA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerFileSave := GetProcAddress(hDLLLL28,'LlDesignerFileSaveW');
        {$else}
          @LlDesignerFileSaveO := GetProcAddress(hDLLLL28,'LlDesignerFileSaveW');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerAddActionO := GetProcAddress(hDLLLL28,'LlDesignerAddActionA');
        {$else}
          @LlDesignerAddAction := GetProcAddress(hDLLLL28,'LlDesignerAddActionA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerAddAction := GetProcAddress(hDLLLL28,'LlDesignerAddActionW');
        {$else}
          @LlDesignerAddActionO := GetProcAddress(hDLLLL28,'LlDesignerAddActionW');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerGetOptionStringO := GetProcAddress(hDLLLL28,'LlDesignerGetOptionStringA');
        {$else}
          @LlDesignerGetOptionString := GetProcAddress(hDLLLL28,'LlDesignerGetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerGetOptionString := GetProcAddress(hDLLLL28,'LlDesignerGetOptionStringW');
        {$else}
          @LlDesignerGetOptionStringO := GetProcAddress(hDLLLL28,'LlDesignerGetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerSetOptionStringO := GetProcAddress(hDLLLL28,'LlDesignerSetOptionStringA');
        {$else}
          @LlDesignerSetOptionString := GetProcAddress(hDLLLL28,'LlDesignerSetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlDesignerSetOptionString := GetProcAddress(hDLLLL28,'LlDesignerSetOptionStringW');
        {$else}
          @LlDesignerSetOptionStringO := GetProcAddress(hDLLLL28,'LlDesignerSetOptionStringW');
      {$endif}
      @LlJobOpenCopy        := GetProcAddress(hDLLLL28,'LlJobOpenCopy');
      {$ifdef UNICODE}
          @LlGetProjectParameterO := GetProcAddress(hDLLLL28,'LlGetProjectParameterA');
        {$else}
          @LlGetProjectParameter := GetProcAddress(hDLLLL28,'LlGetProjectParameterA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetProjectParameter := GetProcAddress(hDLLLL28,'LlGetProjectParameterW');
        {$else}
          @LlGetProjectParameterO := GetProcAddress(hDLLLL28,'LlGetProjectParameterW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertBLOBToStringO := GetProcAddress(hDLLLL28,'LlConvertBLOBToStringA');
        {$else}
          @LlConvertBLOBToString := GetProcAddress(hDLLLL28,'LlConvertBLOBToStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertBLOBToString := GetProcAddress(hDLLLL28,'LlConvertBLOBToStringW');
        {$else}
          @LlConvertBLOBToStringO := GetProcAddress(hDLLLL28,'LlConvertBLOBToStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToBLOBO := GetProcAddress(hDLLLL28,'LlConvertStringToBLOBA');
        {$else}
          @LlConvertStringToBLOB := GetProcAddress(hDLLLL28,'LlConvertStringToBLOBA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToBLOB := GetProcAddress(hDLLLL28,'LlConvertStringToBLOBW');
        {$else}
          @LlConvertStringToBLOBO := GetProcAddress(hDLLLL28,'LlConvertStringToBLOBW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStreamToStringO := GetProcAddress(hDLLLL28,'LlConvertStreamToStringA');
        {$else}
          @LlConvertStreamToString := GetProcAddress(hDLLLL28,'LlConvertStreamToStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStreamToString := GetProcAddress(hDLLLL28,'LlConvertStreamToStringW');
        {$else}
          @LlConvertStreamToStringO := GetProcAddress(hDLLLL28,'LlConvertStreamToStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToStreamO := GetProcAddress(hDLLLL28,'LlConvertStringToStreamA');
        {$else}
          @LlConvertStringToStream := GetProcAddress(hDLLLL28,'LlConvertStringToStreamA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToStream := GetProcAddress(hDLLLL28,'LlConvertStringToStreamW');
        {$else}
          @LlConvertStringToStreamO := GetProcAddress(hDLLLL28,'LlConvertStringToStreamW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertHGLOBALToStringO := GetProcAddress(hDLLLL28,'LlConvertHGLOBALToStringA');
        {$else}
          @LlConvertHGLOBALToString := GetProcAddress(hDLLLL28,'LlConvertHGLOBALToStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertHGLOBALToString := GetProcAddress(hDLLLL28,'LlConvertHGLOBALToStringW');
        {$else}
          @LlConvertHGLOBALToStringO := GetProcAddress(hDLLLL28,'LlConvertHGLOBALToStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToHGLOBALO := GetProcAddress(hDLLLL28,'LlConvertStringToHGLOBALA');
        {$else}
          @LlConvertStringToHGLOBAL := GetProcAddress(hDLLLL28,'LlConvertStringToHGLOBALA');
      {$endif}
      {$ifdef UNICODE}
          @LlConvertStringToHGLOBAL := GetProcAddress(hDLLLL28,'LlConvertStringToHGLOBALW');
        {$else}
          @LlConvertStringToHGLOBALO := GetProcAddress(hDLLLL28,'LlConvertStringToHGLOBALW');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableRelationExO := GetProcAddress(hDLLLL28,'LlDbAddTableRelationExA');
        {$else}
          @LlDbAddTableRelationEx := GetProcAddress(hDLLLL28,'LlDbAddTableRelationExA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableRelationEx := GetProcAddress(hDLLLL28,'LlDbAddTableRelationExW');
        {$else}
          @LlDbAddTableRelationExO := GetProcAddress(hDLLLL28,'LlDbAddTableRelationExW');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableSortOrderExO := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderExA');
        {$else}
          @LlDbAddTableSortOrderEx := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderExA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableSortOrderEx := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderExW');
        {$else}
          @LlDbAddTableSortOrderExO := GetProcAddress(hDLLLL28,'LlDbAddTableSortOrderExW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUsedIdentifiersExO := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersExA');
        {$else}
          @LlGetUsedIdentifiersEx := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersExA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetUsedIdentifiersEx := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersExW');
        {$else}
          @LlGetUsedIdentifiersExO := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersExW');
      {$endif}
      {$ifdef UNICODE}
          @LlGetTempFileNameO := GetProcAddress(hDLLLL28,'LlGetTempFileNameA');
        {$else}
          @LlGetTempFileName := GetProcAddress(hDLLLL28,'LlGetTempFileNameA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetTempFileName := GetProcAddress(hDLLLL28,'LlGetTempFileNameW');
        {$else}
          @LlGetTempFileNameO := GetProcAddress(hDLLLL28,'LlGetTempFileNameW');
      {$endif}
      @LlGetDebug           := GetProcAddress(hDLLLL28,'LlGetDebug');
      @LlRTFEditorGetRTFControlHandle := GetProcAddress(hDLLLL28,'LlRTFEditorGetRTFControlHandle');
      {$ifdef UNICODE}
          @LlGetDefaultPrinterO := GetProcAddress(hDLLLL28,'LlGetDefaultPrinterA');
        {$else}
          @LlGetDefaultPrinter := GetProcAddress(hDLLLL28,'LlGetDefaultPrinterA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetDefaultPrinter := GetProcAddress(hDLLLL28,'LlGetDefaultPrinterW');
        {$else}
          @LlGetDefaultPrinterO := GetProcAddress(hDLLLL28,'LlGetDefaultPrinterW');
      {$endif}
      {$ifdef UNICODE}
          @LlLocAddDictionaryEntryO := GetProcAddress(hDLLLL28,'LlLocAddDictionaryEntryA');
        {$else}
          @LlLocAddDictionaryEntry := GetProcAddress(hDLLLL28,'LlLocAddDictionaryEntryA');
      {$endif}
      {$ifdef UNICODE}
          @LlLocAddDictionaryEntry := GetProcAddress(hDLLLL28,'LlLocAddDictionaryEntryW');
        {$else}
          @LlLocAddDictionaryEntryO := GetProcAddress(hDLLLL28,'LlLocAddDictionaryEntryW');
      {$endif}
      @LlLocAddDesignLCID   := GetProcAddress(hDLLLL28,'LlLocAddDesignLCID');
      @LlIsUILanguageAvailable := GetProcAddress(hDLLLL28,'LlIsUILanguageAvailable');
      @LlIsUILanguageAvailableLCID := GetProcAddress(hDLLLL28,'LlIsUILanguageAvailableLCID');
      {$ifdef UNICODE}
          @LlDbAddTableExO := GetProcAddress(hDLLLL28,'LlDbAddTableExA');
        {$else}
          @LlDbAddTableEx := GetProcAddress(hDLLLL28,'LlDbAddTableExA');
      {$endif}
      {$ifdef UNICODE}
          @LlDbAddTableEx := GetProcAddress(hDLLLL28,'LlDbAddTableExW');
        {$else}
          @LlDbAddTableExO := GetProcAddress(hDLLLL28,'LlDbAddTableExW');
      {$endif}
      {$ifdef UNICODE}
          @LlRTFSetTextExO := GetProcAddress(hDLLLL28,'LlRTFSetTextExA');
        {$else}
          @LlRTFSetTextEx := GetProcAddress(hDLLLL28,'LlRTFSetTextExA');
      {$endif}
      {$ifdef UNICODE}
          @LlRTFSetTextEx := GetProcAddress(hDLLLL28,'LlRTFSetTextExW');
        {$else}
          @LlRTFSetTextExO := GetProcAddress(hDLLLL28,'LlRTFSetTextExW');
      {$endif}
      @LlInplaceDesignerInteraction := GetProcAddress(hDLLLL28,'LlInplaceDesignerInteraction');
      {$ifdef UNICODE}
          @LlGetProjectDescriptionO := GetProcAddress(hDLLLL28,'LlGetProjectDescriptionA');
        {$else}
          @LlGetProjectDescription := GetProcAddress(hDLLLL28,'LlGetProjectDescriptionA');
      {$endif}
      {$ifdef UNICODE}
          @LlGetProjectDescription := GetProcAddress(hDLLLL28,'LlGetProjectDescriptionW');
        {$else}
          @LlGetProjectDescriptionO := GetProcAddress(hDLLLL28,'LlGetProjectDescriptionW');
      {$endif}
      @LlPrintDbGetCurrentTableFilter := GetProcAddress(hDLLLL28,'LlPrintDbGetCurrentTableFilter');
      {$ifdef UNICODE}
          @LlExprTranslateToHostExpressionO := GetProcAddress(hDLLLL28,'LlExprTranslateToHostExpressionA');
        {$else}
          @LlExprTranslateToHostExpression := GetProcAddress(hDLLLL28,'LlExprTranslateToHostExpressionA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprTranslateToHostExpression := GetProcAddress(hDLLLL28,'LlExprTranslateToHostExpressionW');
        {$else}
          @LlExprTranslateToHostExpressionO := GetProcAddress(hDLLLL28,'LlExprTranslateToHostExpressionW');
      {$endif}
      @LlStgTestJobCreate   := GetProcAddress(hDLLLL28,'LlStgTestJobCreate');
      @LlStgTestJobCmpPage  := GetProcAddress(hDLLLL28,'LlStgTestJobCmpPage');
      @LlStgTestJobDestroy  := GetProcAddress(hDLLLL28,'LlStgTestJobDestroy');
      @LlStgTestStgCmp      := GetProcAddress(hDLLLL28,'LlStgTestStgCmp');
      @LlStgTestStgCmpRUNDLL32 := GetProcAddress(hDLLLL28,'LlStgTestStgCmpRUNDLL32');
      @LlStgTestStgCmp2     := GetProcAddress(hDLLLL28,'LlStgTestStgCmp2');
      @LlStgTestJobCmpEmbeddedStorages := GetProcAddress(hDLLLL28,'LlStgTestJobCmpEmbeddedStorages');
      @LlSRTriggerExport    := GetProcAddress(hDLLLL28,'LlSRTriggerExport');
      @LlUtilsGetVariantFromProfContentsInternal := GetProcAddress(hDLLLL28,'LlUtilsGetVariantFromProfContentsInternal');
      @LlUtilsGetProfContentsFromVariantInternal := GetProcAddress(hDLLLL28,'LlUtilsGetProfContentsFromVariantInternal');
      {$ifdef UNICODE}
          @LlExprGetUsedFunctionsO := GetProcAddress(hDLLLL28,'LlExprGetUsedFunctionsA');
        {$else}
          @LlExprGetUsedFunctions := GetProcAddress(hDLLLL28,'LlExprGetUsedFunctionsA');
      {$endif}
      {$ifdef UNICODE}
          @LlExprGetUsedFunctions := GetProcAddress(hDLLLL28,'LlExprGetUsedFunctionsW');
        {$else}
          @LlExprGetUsedFunctionsO := GetProcAddress(hDLLLL28,'LlExprGetUsedFunctionsW');
      {$endif}
      @LlDesignerTriggerJobInUIThread := GetProcAddress(hDLLLL28,'LlDesignerTriggerJobInUIThread');
      @LlUtilsComparePrinterInformation := GetProcAddress(hDLLLL28,'LlUtilsComparePrinterInformation');
      @LlGetUsedIdentifiersExV := GetProcAddress(hDLLLL28,'LlGetUsedIdentifiersExV');
      @LlDomGetPropertyV    := GetProcAddress(hDLLLL28,'LlDomGetPropertyV');
      @LlExprGetUsedFunctionsV := GetProcAddress(hDLLLL28,'LlExprGetUsedFunctionsV');
      @LlExprGetUsedVarsExV := GetProcAddress(hDLLLL28,'LlExprGetUsedVarsExV');
      @LlGetTableRelationToActiveTable := GetProcAddress(hDLLLL28,'LlGetTableRelationToActiveTable');
      @LlJobOpenCopyEx      := GetProcAddress(hDLLLL28,'LlJobOpenCopyEx');
      @LlAddDebugSinkForThread := GetProcAddress(hDLLLL28,'LlAddDebugSinkForThread');
      @LlRemoveDebugSinkFromThread := GetProcAddress(hDLLLL28,'LlRemoveDebugSinkFromThread');
      @LlGetDebugSinkProxyModule := GetProcAddress(hDLLLL28,'LlGetDebugSinkProxyModule');
      @LlGetDebugSinkProxyCategory := GetProcAddress(hDLLLL28,'LlGetDebugSinkProxyCategory');
      @LlDlgSelectFileOpen  := GetProcAddress(hDLLLL28,'LlDlgSelectFileOpen');
      @LlUtilsLcidFromLocaleName := GetProcAddress(hDLLLL28,'LlUtilsLcidFromLocaleName');
      @LlDesignerShowMessage := GetProcAddress(hDLLLL28,'LlDesignerShowMessage');
      @LlExprConvertGlobalToLocal := GetProcAddress(hDLLLL28,'LlExprConvertGlobalToLocal');
      @LlExprConvertLocalToGlobal := GetProcAddress(hDLLLL28,'LlExprConvertLocalToGlobal');
      @LlUtilsGetProjectType := GetProcAddress(hDLLLL28,'LlUtilsGetProjectType');
      @LlGetLastErrorText   := GetProcAddress(hDLLLL28,'LlGetLastErrorText');
      @LlDomGetCurrentObject := GetProcAddress(hDLLLL28,'LlDomGetCurrentObject');
      @LlUtilsIDFromOrgID   := GetProcAddress(hDLLLL28,'LlUtilsIDFromOrgID');
      @LlProjectFindAndReplace := GetProcAddress(hDLLLL28,'LlProjectFindAndReplace');
      @LlExprParseQueryDelayedDefine := GetProcAddress(hDLLLL28,'LlExprParseQueryDelayedDefine');
      @LlExprTypeMask       := GetProcAddress(hDLLLL28,'LlExprTypeMask');
      @LlStgTestJobCmpEmbeddedStorages2 := GetProcAddress(hDLLLL28,'LlStgTestJobCmpEmbeddedStorages2');
      @LlStgTestJobAddResultJobs := GetProcAddress(hDLLLL28,'LlStgTestJobAddResultJobs');
      @LlStgCreateFrom      := GetProcAddress(hDLLLL28,'LlStgCreateFrom');
      @LlRemoveIdentifier   := GetProcAddress(hDLLLL28,'LlRemoveIdentifier');
      @LlExprParseEx        := GetProcAddress(hDLLLL28,'LlExprParseEx');
      end;
    end;
end;

procedure LL28xUnload;
begin
  dec(nDLLLL28Usage);
  if (nDLLLL28Usage = 0) then
    begin
    if hDLLLL28 <> 0 then
      begin
      FreeLibrary(hDLLLL28);
      hDLLLL28 := 0;
      LlJobOpen := NIL;
      LlJobOpenLCID := NIL;
      LlJobClose := NIL;
      LlSetDebug := NIL;
      LlGetVersion := NIL;
      LlGetNotificationMessage := NIL;
      LlSetNotificationMessage := NIL;
      LlSetNotificationCallback := NIL;
      LlDefineField := NIL;
      LlDefineFieldO := NIL;
      LlDefineField := NIL;
      LlDefineFieldO := NIL;
      LlDefineFieldExt := NIL;
      LlDefineFieldExtO := NIL;
      LlDefineFieldExt := NIL;
      LlDefineFieldExtO := NIL;
      LlDefineFieldExtHandle := NIL;
      LlDefineFieldExtHandleO := NIL;
      LlDefineFieldExtHandle := NIL;
      LlDefineFieldExtHandleO := NIL;
      LlDefineFieldStart := NIL;
      LlDefineVariable := NIL;
      LlDefineVariableO := NIL;
      LlDefineVariable := NIL;
      LlDefineVariableO := NIL;
      LlDefineVariableExt := NIL;
      LlDefineVariableExtO := NIL;
      LlDefineVariableExt := NIL;
      LlDefineVariableExtO := NIL;
      LlDefineVariableExtHandle := NIL;
      LlDefineVariableExtHandleO := NIL;
      LlDefineVariableExtHandle := NIL;
      LlDefineVariableExtHandleO := NIL;
      LlDefineVariableName := NIL;
      LlDefineVariableNameO := NIL;
      LlDefineVariableName := NIL;
      LlDefineVariableNameO := NIL;
      LlDefineVariableStart := NIL;
      LlDefineSumVariable := NIL;
      LlDefineSumVariableO := NIL;
      LlDefineSumVariable := NIL;
      LlDefineSumVariableO := NIL;
      LlDefineLayout := NIL;
      LlDefineLayoutO := NIL;
      LlDefineLayout := NIL;
      LlDefineLayoutO := NIL;
      LlDlgEditLine := NIL;
      LlDlgEditLineO := NIL;
      LlDlgEditLine := NIL;
      LlDlgEditLineO := NIL;
      LlDlgEditLineEx := NIL;
      LlDlgEditLineExO := NIL;
      LlDlgEditLineEx := NIL;
      LlDlgEditLineExO := NIL;
      LlPreviewSetTempPath := NIL;
      LlPreviewSetTempPathO := NIL;
      LlPreviewSetTempPath := NIL;
      LlPreviewSetTempPathO := NIL;
      LlPreviewDeleteFiles := NIL;
      LlPreviewDeleteFilesO := NIL;
      LlPreviewDeleteFiles := NIL;
      LlPreviewDeleteFilesO := NIL;
      LlPreviewDisplay := NIL;
      LlPreviewDisplayO := NIL;
      LlPreviewDisplay := NIL;
      LlPreviewDisplayO := NIL;
      LlPreviewDisplayEx := NIL;
      LlPreviewDisplayExO := NIL;
      LlPreviewDisplayEx := NIL;
      LlPreviewDisplayExO := NIL;
      LlPrint := NIL;
      LlPrintAbort := NIL;
      LlPrintCheckLineFit := NIL;
      LlPrintEnd := NIL;
      LlPrintFields := NIL;
      LlPrintFieldsEnd := NIL;
      LlPrintGetCurrentPage := NIL;
      LlPrintGetItemsPerPage := NIL;
      LlPrintGetItemsPerTable := NIL;
      LlPrintGetRemainingItemsPerTable := NIL;
      LlPrintGetRemainingItemsPerTableO := NIL;
      LlPrintGetRemainingItemsPerTable := NIL;
      LlPrintGetRemainingItemsPerTableO := NIL;
      LlPrintGetRemItemsPerTable := NIL;
      LlPrintGetRemItemsPerTableO := NIL;
      LlPrintGetRemItemsPerTable := NIL;
      LlPrintGetRemItemsPerTableO := NIL;
      LlPrintGetOption := NIL;
      LlPrintGetPrinterInfo := NIL;
      LlPrintGetPrinterInfoO := NIL;
      LlPrintGetPrinterInfo := NIL;
      LlPrintGetPrinterInfoO := NIL;
      LlPrintOptionsDialog := NIL;
      LlPrintOptionsDialogO := NIL;
      LlPrintOptionsDialog := NIL;
      LlPrintOptionsDialogO := NIL;
      LlPrintSelectOffsetEx := NIL;
      LlPrintSetBoxText := NIL;
      LlPrintSetBoxTextO := NIL;
      LlPrintSetBoxText := NIL;
      LlPrintSetBoxTextO := NIL;
      LlPrintSetOption := NIL;
      LlPrintUpdateBox := NIL;
      LlPrintStart := NIL;
      LlPrintStartO := NIL;
      LlPrintStart := NIL;
      LlPrintStartO := NIL;
      LlPrintWithBoxStart := NIL;
      LlPrintWithBoxStartO := NIL;
      LlPrintWithBoxStart := NIL;
      LlPrintWithBoxStartO := NIL;
      LlPrinterSetup := NIL;
      LlPrinterSetupO := NIL;
      LlPrinterSetup := NIL;
      LlPrinterSetupO := NIL;
      LlSelectFileDlgTitleEx := NIL;
      LlSelectFileDlgTitleExO := NIL;
      LlSelectFileDlgTitleEx := NIL;
      LlSelectFileDlgTitleExO := NIL;
      LlSetDlgboxMode := NIL;
      LlGetDlgboxMode := NIL;
      LlExprParse := NIL;
      LlExprParseO := NIL;
      LlExprParse := NIL;
      LlExprParseO := NIL;
      LlExprType := NIL;
      LlExprError := NIL;
      LlExprErrorO := NIL;
      LlExprError := NIL;
      LlExprErrorO := NIL;
      LlExprFree := NIL;
      LlExprEvaluate := NIL;
      LlExprEvaluateO := NIL;
      LlExprEvaluate := NIL;
      LlExprEvaluateO := NIL;
      LlExprGetUsedVars := NIL;
      LlExprGetUsedVarsO := NIL;
      LlExprGetUsedVars := NIL;
      LlExprGetUsedVarsO := NIL;
      LlSetOption := NIL;
      LlGetOption := NIL;
      LlSetOptionString := NIL;
      LlSetOptionStringO := NIL;
      LlSetOptionString := NIL;
      LlSetOptionStringO := NIL;
      LlGetOptionString := NIL;
      LlGetOptionStringO := NIL;
      LlGetOptionString := NIL;
      LlGetOptionStringO := NIL;
      LlPrintSetOptionString := NIL;
      LlPrintSetOptionStringO := NIL;
      LlPrintSetOptionString := NIL;
      LlPrintSetOptionStringO := NIL;
      LlPrintGetOptionString := NIL;
      LlPrintGetOptionStringO := NIL;
      LlPrintGetOptionString := NIL;
      LlPrintGetOptionStringO := NIL;
      LlDesignerProhibitAction := NIL;
      LlDesignerProhibitFunction := NIL;
      LlDesignerProhibitFunctionO := NIL;
      LlDesignerProhibitFunction := NIL;
      LlDesignerProhibitFunctionO := NIL;
      LlDesignerProhibitFunctionGroup := NIL;
      LlPrintEnableObject := NIL;
      LlPrintEnableObjectO := NIL;
      LlPrintEnableObject := NIL;
      LlPrintEnableObjectO := NIL;
      LlSetFileExtensions := NIL;
      LlSetFileExtensionsO := NIL;
      LlSetFileExtensions := NIL;
      LlSetFileExtensionsO := NIL;
      LlPrintGetTextCharsPrinted := NIL;
      LlPrintGetTextCharsPrintedO := NIL;
      LlPrintGetTextCharsPrinted := NIL;
      LlPrintGetTextCharsPrintedO := NIL;
      LlPrintGetFieldCharsPrinted := NIL;
      LlPrintGetFieldCharsPrintedO := NIL;
      LlPrintGetFieldCharsPrinted := NIL;
      LlPrintGetFieldCharsPrintedO := NIL;
      LlPrintIsVariableUsed := NIL;
      LlPrintIsVariableUsedO := NIL;
      LlPrintIsVariableUsed := NIL;
      LlPrintIsVariableUsedO := NIL;
      LlPrintIsFieldUsed := NIL;
      LlPrintIsFieldUsedO := NIL;
      LlPrintIsFieldUsed := NIL;
      LlPrintIsFieldUsedO := NIL;
      LlPrintOptionsDialogTitle := NIL;
      LlPrintOptionsDialogTitleO := NIL;
      LlPrintOptionsDialogTitle := NIL;
      LlPrintOptionsDialogTitleO := NIL;
      LlSetPrinterToDefault := NIL;
      LlSetPrinterToDefaultO := NIL;
      LlSetPrinterToDefault := NIL;
      LlSetPrinterToDefaultO := NIL;
      LlDefineSortOrderStart := NIL;
      LlDefineSortOrder := NIL;
      LlDefineSortOrderO := NIL;
      LlDefineSortOrder := NIL;
      LlDefineSortOrderO := NIL;
      LlPrintGetSortOrder := NIL;
      LlPrintGetSortOrderO := NIL;
      LlPrintGetSortOrder := NIL;
      LlPrintGetSortOrderO := NIL;
      LlDefineGrouping := NIL;
      LlDefineGroupingO := NIL;
      LlDefineGrouping := NIL;
      LlDefineGroupingO := NIL;
      LlPrintGetGrouping := NIL;
      LlPrintGetGroupingO := NIL;
      LlPrintGetGrouping := NIL;
      LlPrintGetGroupingO := NIL;
      LlAddCtlSupport := NIL;
      LlAddCtlSupportO := NIL;
      LlAddCtlSupport := NIL;
      LlAddCtlSupportO := NIL;
      LlPrintBeginGroup := NIL;
      LlPrintEndGroup := NIL;
      LlPrintGroupLine := NIL;
      LlPrintGroupHeader := NIL;
      LlPrintGetFilterExpression := NIL;
      LlPrintGetFilterExpressionO := NIL;
      LlPrintGetFilterExpression := NIL;
      LlPrintGetFilterExpressionO := NIL;
      LlPrintWillMatchFilter := NIL;
      LlPrintDidMatchFilter := NIL;
      LlGetFieldContents := NIL;
      LlGetFieldContentsO := NIL;
      LlGetFieldContents := NIL;
      LlGetFieldContentsO := NIL;
      LlGetVariableContents := NIL;
      LlGetVariableContentsO := NIL;
      LlGetVariableContents := NIL;
      LlGetVariableContentsO := NIL;
      LlGetSumVariableContents := NIL;
      LlGetSumVariableContentsO := NIL;
      LlGetSumVariableContents := NIL;
      LlGetSumVariableContentsO := NIL;
      LlGetUserVariableContents := NIL;
      LlGetUserVariableContentsO := NIL;
      LlGetUserVariableContents := NIL;
      LlGetUserVariableContentsO := NIL;
      LlGetVariableType := NIL;
      LlGetVariableTypeO := NIL;
      LlGetVariableType := NIL;
      LlGetVariableTypeO := NIL;
      LlGetFieldType := NIL;
      LlGetFieldTypeO := NIL;
      LlGetFieldType := NIL;
      LlGetFieldTypeO := NIL;
      LlPrintGetColumnInfo := NIL;
      LlPrintGetColumnInfoO := NIL;
      LlPrintGetColumnInfo := NIL;
      LlPrintGetColumnInfoO := NIL;
      LlSetPrinterDefaultsDir := NIL;
      LlSetPrinterDefaultsDirO := NIL;
      LlSetPrinterDefaultsDir := NIL;
      LlSetPrinterDefaultsDirO := NIL;
      LlCreateSketch := NIL;
      LlCreateSketchO := NIL;
      LlCreateSketch := NIL;
      LlCreateSketchO := NIL;
      LlViewerProhibitAction := NIL;
      LlPrintCopyPrinterConfiguration := NIL;
      LlPrintCopyPrinterConfigurationO := NIL;
      LlPrintCopyPrinterConfiguration := NIL;
      LlPrintCopyPrinterConfigurationO := NIL;
      LlSetPrinterInPrinterFile := NIL;
      LlSetPrinterInPrinterFileO := NIL;
      LlSetPrinterInPrinterFile := NIL;
      LlSetPrinterInPrinterFileO := NIL;
      LlRTFCreateObject := NIL;
      LlRTFDeleteObject := NIL;
      LlRTFSetText := NIL;
      LlRTFSetTextO := NIL;
      LlRTFSetText := NIL;
      LlRTFSetTextO := NIL;
      LlRTFGetTextLength := NIL;
      LlRTFGetText := NIL;
      LlRTFGetTextO := NIL;
      LlRTFGetText := NIL;
      LlRTFGetTextO := NIL;
      LlRTFEditObject := NIL;
      LlRTFCopyToClipboard := NIL;
      LlRTFDisplay := NIL;
      LlRTFEditorProhibitAction := NIL;
      LlRTFEditorInvokeAction := NIL;
      LlDebugOutput := NIL;
      LlDebugOutputO := NIL;
      LlDebugOutput := NIL;
      LlDebugOutputO := NIL;
      LlEnumGetFirstVar := NIL;
      LlEnumGetFirstField := NIL;
      LlEnumGetFirstConstant := NIL;
      LlEnumGetNextEntry := NIL;
      LlEnumGetEntry := NIL;
      LlEnumGetEntryO := NIL;
      LlEnumGetEntry := NIL;
      LlEnumGetEntryO := NIL;
      LlPrintResetObjectStates := NIL;
      LlXSetParameter := NIL;
      LlXSetParameterO := NIL;
      LlXSetParameter := NIL;
      LlXSetParameterO := NIL;
      LlXGetParameter := NIL;
      LlXGetParameterO := NIL;
      LlXGetParameter := NIL;
      LlXGetParameterO := NIL;
      LlPrintResetProjectState := NIL;
      LlDefineChartFieldStart := NIL;
      LlDefineChartFieldExt := NIL;
      LlDefineChartFieldExtO := NIL;
      LlDefineChartFieldExt := NIL;
      LlDefineChartFieldExtO := NIL;
      LlPrintDeclareChartRow := NIL;
      LlPrintGetChartObjectCount := NIL;
      LlPrintIsChartFieldUsed := NIL;
      LlPrintIsChartFieldUsedO := NIL;
      LlPrintIsChartFieldUsed := NIL;
      LlPrintIsChartFieldUsedO := NIL;
      LlGetChartFieldContents := NIL;
      LlGetChartFieldContentsO := NIL;
      LlGetChartFieldContents := NIL;
      LlGetChartFieldContentsO := NIL;
      LlEnumGetFirstChartField := NIL;
      LlSetNotificationCallbackExt := NIL;
      LlExprEvaluateVar := NIL;
      LlExprTypeVar := NIL;
      LlGetPrinterFromPrinterFile := NIL;
      LlGetPrinterFromPrinterFileO := NIL;
      LlGetPrinterFromPrinterFile := NIL;
      LlGetPrinterFromPrinterFileO := NIL;
      LlPrintGetRemainingSpacePerTable := NIL;
      LlPrintGetRemainingSpacePerTableO := NIL;
      LlPrintGetRemainingSpacePerTable := NIL;
      LlPrintGetRemainingSpacePerTableO := NIL;
      LlDrawToolbarBackground := NIL;
      LlSetDefaultProjectParameter := NIL;
      LlSetDefaultProjectParameterO := NIL;
      LlSetDefaultProjectParameter := NIL;
      LlSetDefaultProjectParameterO := NIL;
      LlGetDefaultProjectParameter := NIL;
      LlGetDefaultProjectParameterO := NIL;
      LlGetDefaultProjectParameter := NIL;
      LlGetDefaultProjectParameterO := NIL;
      LlPrintSetProjectParameter := NIL;
      LlPrintSetProjectParameterO := NIL;
      LlPrintSetProjectParameter := NIL;
      LlPrintSetProjectParameterO := NIL;
      LlPrintGetProjectParameter := NIL;
      LlPrintGetProjectParameterO := NIL;
      LlPrintGetProjectParameter := NIL;
      LlPrintGetProjectParameterO := NIL;
      LlCreateObject := NIL;
      LlExprContainsVariable := NIL;
      LlExprContainsVariableO := NIL;
      LlExprContainsVariable := NIL;
      LlExprContainsVariableO := NIL;
      LlExprIsConstant := NIL;
      LlProfileStart := NIL;
      LlProfileStartO := NIL;
      LlProfileStart := NIL;
      LlProfileStartO := NIL;
      LlProfileEnd := NIL;
      LlDumpMemory := NIL;
      LlDbAddTable := NIL;
      LlDbAddTableO := NIL;
      LlDbAddTable := NIL;
      LlDbAddTableO := NIL;
      LlDbAddTableRelation := NIL;
      LlDbAddTableRelationO := NIL;
      LlDbAddTableRelation := NIL;
      LlDbAddTableRelationO := NIL;
      LlDbAddTableSortOrder := NIL;
      LlDbAddTableSortOrderO := NIL;
      LlDbAddTableSortOrder := NIL;
      LlDbAddTableSortOrderO := NIL;
      LlPrintDbGetCurrentTable := NIL;
      LlPrintDbGetCurrentTableO := NIL;
      LlPrintDbGetCurrentTable := NIL;
      LlPrintDbGetCurrentTableO := NIL;
      LlPrintDbGetCurrentTableRelation := NIL;
      LlPrintDbGetCurrentTableRelationO := NIL;
      LlPrintDbGetCurrentTableRelation := NIL;
      LlPrintDbGetCurrentTableRelationO := NIL;
      LlPrintDbGetCurrentTableSortOrder := NIL;
      LlPrintDbGetCurrentTableSortOrderO := NIL;
      LlPrintDbGetCurrentTableSortOrder := NIL;
      LlPrintDbGetCurrentTableSortOrderO := NIL;
      LlDbDumpStructure := NIL;
      LlPrintDbGetRootTableCount := NIL;
      LlDbSetMasterTable := NIL;
      LlDbSetMasterTableO := NIL;
      LlDbSetMasterTable := NIL;
      LlDbSetMasterTableO := NIL;
      LlDbGetMasterTable := NIL;
      LlDbGetMasterTableO := NIL;
      LlDbGetMasterTable := NIL;
      LlDbGetMasterTableO := NIL;
      LlXSetExportParameter := NIL;
      LlXSetExportParameterO := NIL;
      LlXSetExportParameter := NIL;
      LlXSetExportParameterO := NIL;
      LlXGetExportParameter := NIL;
      LlXGetExportParameterO := NIL;
      LlXGetExportParameter := NIL;
      LlXGetExportParameterO := NIL;
      LlXlatName := NIL;
      LlXlatNameO := NIL;
      LlXlatName := NIL;
      LlXlatNameO := NIL;
      LlDefineVariableVar := NIL;
      LlDefineVariableVarO := NIL;
      LlDefineVariableVar := NIL;
      LlDefineVariableVarO := NIL;
      LlDefineFieldVar := NIL;
      LlDefineFieldVarO := NIL;
      LlDefineFieldVar := NIL;
      LlDefineFieldVarO := NIL;
      LlDefineChartFieldVar := NIL;
      LlDefineChartFieldVarO := NIL;
      LlDefineChartFieldVar := NIL;
      LlDefineChartFieldVarO := NIL;
      LlDesignerProhibitEditingObject := NIL;
      LlDesignerProhibitEditingObjectO := NIL;
      LlDesignerProhibitEditingObject := NIL;
      LlDesignerProhibitEditingObjectO := NIL;
      LlGetUsedIdentifiers := NIL;
      LlGetUsedIdentifiersO := NIL;
      LlGetUsedIdentifiers := NIL;
      LlGetUsedIdentifiersO := NIL;
      LlExprGetUsedVarsEx := NIL;
      LlExprGetUsedVarsExO := NIL;
      LlExprGetUsedVarsEx := NIL;
      LlExprGetUsedVarsExO := NIL;
      LlDomGetProject := NIL;
      LlDomGetProperty := NIL;
      LlDomGetPropertyO := NIL;
      LlDomGetProperty := NIL;
      LlDomGetPropertyO := NIL;
      LlDomSetProperty := NIL;
      LlDomSetPropertyO := NIL;
      LlDomSetProperty := NIL;
      LlDomSetPropertyO := NIL;
      LlDomGetObject := NIL;
      LlDomGetObjectO := NIL;
      LlDomGetObject := NIL;
      LlDomGetObjectO := NIL;
      LlDomGetSubobjectCount := NIL;
      LlDomGetSubobject := NIL;
      LlDomCreateSubobject := NIL;
      LlDomCreateSubobjectO := NIL;
      LlDomCreateSubobject := NIL;
      LlDomCreateSubobjectO := NIL;
      LlDomDeleteSubobject := NIL;
      LlDomMoveSubobject := NIL;
      LlProjectOpen := NIL;
      LlProjectOpenO := NIL;
      LlProjectOpen := NIL;
      LlProjectOpenO := NIL;
      LlProjectSave := NIL;
      LlProjectSaveO := NIL;
      LlProjectSave := NIL;
      LlProjectSaveO := NIL;
      LlProjectSaveCopyAs := NIL;
      LlProjectSaveCopyAsO := NIL;
      LlProjectSaveCopyAs := NIL;
      LlProjectSaveCopyAsO := NIL;
      LlProjectClose := NIL;
      LlDomGetPropertyCount := NIL;
      LlAssociatePreviewControl := NIL;
      LlGetErrortext := NIL;
      LlGetErrortextO := NIL;
      LlGetErrortext := NIL;
      LlGetErrortextO := NIL;
      LlSetPreviewOption := NIL;
      LlGetPreviewOption := NIL;
      LlDesignerInvokeAction := NIL;
      LlDesignerRefreshWorkspace := NIL;
      LlDesignerFileOpen := NIL;
      LlDesignerFileOpenO := NIL;
      LlDesignerFileOpen := NIL;
      LlDesignerFileOpenO := NIL;
      LlDesignerFileSave := NIL;
      LlDesignerFileSaveO := NIL;
      LlDesignerFileSave := NIL;
      LlDesignerFileSaveO := NIL;
      LlDesignerAddAction := NIL;
      LlDesignerAddActionO := NIL;
      LlDesignerAddAction := NIL;
      LlDesignerAddActionO := NIL;
      LlDesignerGetOptionString := NIL;
      LlDesignerGetOptionStringO := NIL;
      LlDesignerGetOptionString := NIL;
      LlDesignerGetOptionStringO := NIL;
      LlDesignerSetOptionString := NIL;
      LlDesignerSetOptionStringO := NIL;
      LlDesignerSetOptionString := NIL;
      LlDesignerSetOptionStringO := NIL;
      LlJobOpenCopy := NIL;
      LlGetProjectParameter := NIL;
      LlGetProjectParameterO := NIL;
      LlGetProjectParameter := NIL;
      LlGetProjectParameterO := NIL;
      LlConvertBLOBToString := NIL;
      LlConvertBLOBToStringO := NIL;
      LlConvertBLOBToString := NIL;
      LlConvertBLOBToStringO := NIL;
      LlConvertStringToBLOB := NIL;
      LlConvertStringToBLOBO := NIL;
      LlConvertStringToBLOB := NIL;
      LlConvertStringToBLOBO := NIL;
      LlConvertStreamToString := NIL;
      LlConvertStreamToStringO := NIL;
      LlConvertStreamToString := NIL;
      LlConvertStreamToStringO := NIL;
      LlConvertStringToStream := NIL;
      LlConvertStringToStreamO := NIL;
      LlConvertStringToStream := NIL;
      LlConvertStringToStreamO := NIL;
      LlConvertHGLOBALToString := NIL;
      LlConvertHGLOBALToStringO := NIL;
      LlConvertHGLOBALToString := NIL;
      LlConvertHGLOBALToStringO := NIL;
      LlConvertStringToHGLOBAL := NIL;
      LlConvertStringToHGLOBALO := NIL;
      LlConvertStringToHGLOBAL := NIL;
      LlConvertStringToHGLOBALO := NIL;
      LlDbAddTableRelationEx := NIL;
      LlDbAddTableRelationExO := NIL;
      LlDbAddTableRelationEx := NIL;
      LlDbAddTableRelationExO := NIL;
      LlDbAddTableSortOrderEx := NIL;
      LlDbAddTableSortOrderExO := NIL;
      LlDbAddTableSortOrderEx := NIL;
      LlDbAddTableSortOrderExO := NIL;
      LlGetUsedIdentifiersEx := NIL;
      LlGetUsedIdentifiersExO := NIL;
      LlGetUsedIdentifiersEx := NIL;
      LlGetUsedIdentifiersExO := NIL;
      LlGetTempFileName := NIL;
      LlGetTempFileNameO := NIL;
      LlGetTempFileName := NIL;
      LlGetTempFileNameO := NIL;
      LlGetDebug := NIL;
      LlRTFEditorGetRTFControlHandle := NIL;
      LlGetDefaultPrinter := NIL;
      LlGetDefaultPrinterO := NIL;
      LlGetDefaultPrinter := NIL;
      LlGetDefaultPrinterO := NIL;
      LlLocAddDictionaryEntry := NIL;
      LlLocAddDictionaryEntryO := NIL;
      LlLocAddDictionaryEntry := NIL;
      LlLocAddDictionaryEntryO := NIL;
      LlLocAddDesignLCID := NIL;
      LlIsUILanguageAvailable := NIL;
      LlIsUILanguageAvailableLCID := NIL;
      LlDbAddTableEx := NIL;
      LlDbAddTableExO := NIL;
      LlDbAddTableEx := NIL;
      LlDbAddTableExO := NIL;
      LlRTFSetTextEx := NIL;
      LlRTFSetTextExO := NIL;
      LlRTFSetTextEx := NIL;
      LlRTFSetTextExO := NIL;
      LlInplaceDesignerInteraction := NIL;
      LlGetProjectDescription := NIL;
      LlGetProjectDescriptionO := NIL;
      LlGetProjectDescription := NIL;
      LlGetProjectDescriptionO := NIL;
      LlPrintDbGetCurrentTableFilter := NIL;
      LlExprTranslateToHostExpression := NIL;
      LlExprTranslateToHostExpressionO := NIL;
      LlExprTranslateToHostExpression := NIL;
      LlExprTranslateToHostExpressionO := NIL;
      LlStgTestJobCreate := NIL;
      LlStgTestJobCmpPage := NIL;
      LlStgTestJobDestroy := NIL;
      LlStgTestStgCmp := NIL;
      LlStgTestStgCmpRUNDLL32 := NIL;
      LlStgTestStgCmp2 := NIL;
      LlStgTestJobCmpEmbeddedStorages := NIL;
      LlSRTriggerExport := NIL;
      LlUtilsGetVariantFromProfContentsInternal := NIL;
      LlUtilsGetProfContentsFromVariantInternal := NIL;
      LlExprGetUsedFunctions := NIL;
      LlExprGetUsedFunctionsO := NIL;
      LlExprGetUsedFunctions := NIL;
      LlExprGetUsedFunctionsO := NIL;
      LlDesignerTriggerJobInUIThread := NIL;
      LlUtilsComparePrinterInformation := NIL;
      LlGetUsedIdentifiersExV := NIL;
      LlDomGetPropertyV := NIL;
      LlExprGetUsedFunctionsV := NIL;
      LlExprGetUsedVarsExV := NIL;
      LlGetTableRelationToActiveTable := NIL;
      LlJobOpenCopyEx := NIL;
      LlAddDebugSinkForThread := NIL;
      LlRemoveDebugSinkFromThread := NIL;
      LlGetDebugSinkProxyModule := NIL;
      LlGetDebugSinkProxyCategory := NIL;
      LlDlgSelectFileOpen := NIL;
      LlUtilsLcidFromLocaleName := NIL;
      LlDesignerShowMessage := NIL;
      LlExprConvertGlobalToLocal := NIL;
      LlExprConvertLocalToGlobal := NIL;
      LlUtilsGetProjectType := NIL;
      LlGetLastErrorText := NIL;
      LlDomGetCurrentObject := NIL;
      LlUtilsIDFromOrgID := NIL;
      LlProjectFindAndReplace := NIL;
      LlExprParseQueryDelayedDefine := NIL;
      LlExprTypeMask := NIL;
      LlStgTestJobCmpEmbeddedStorages2 := NIL;
      LlStgTestJobAddResultJobs := NIL;
      LlStgCreateFrom := NIL;
      LlRemoveIdentifier := NIL;
      LlExprParseEx := NIL;
      end;
    end;
end;

begin
end.
