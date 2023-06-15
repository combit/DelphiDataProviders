(* Pascal/Delphi constants and function definitions for LL28.DLL *)
(*  (c) combit GmbH *)
(*  [build of 2023-06-07 09:06:13] *)

unit cmbtLL28;

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
  LL_WEBDESIGNER_STATEFLAGS_SAVE_REBUILDDBSTRUCT = $4;
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
  LL_OPTION_TRIM_ALSO_EXTENDEDSPACECHARS = 398;
                    (* default: false *)
  LL_OPTION_HIDE_EXTENDED_PRINTMODES = 399;
                    (* default: false *)
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
  LL_JOBSTATEFLAG_VARLIST        = $00000001;
  LL_JOBSTATEFLAG_FIELDLIST      = $00000002;
  LL_JOBSTATEFLAG_CHARTFIELDLIST = $00000004;
  LL_JOBSTATEFLAG_DATABASESTRUCT = $00000008;
  LL_JOBSTATEFLAG_DICTIONARIES   = $00000010;
  LL_JOBSTATEFLAG_JOBSETTINGS    = $00000020;
  LL_JOBSTATEFLAG_ALL            = $0000003F;
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

function   LlJobOpen
	(nLanguage:                      integer
	): HLLJOB; stdcall;

function   LlJobOpenLCID
	(nLCID:                          _LCID
	): HLLJOB; stdcall;

procedure  LlJobClose
	(hLlJob:                         HLLJOB
	); stdcall;

procedure  LlSetDebug
	(nOnOff:                         cardinal
	); stdcall;

function   LlGetVersion
	(nCmd:                           integer
	): cardinal; stdcall;

function   LlGetNotificationMessage
	(hLlJob:                         HLLJOB
	): cardinal; stdcall;

function   LlSetNotificationMessage
	(hLlJob:                         HLLJOB;
	 nMessage:                       cardinal
	): integer; stdcall;

function   LlSetNotificationCallback
	(hLlJob:                         HLLJOB;
	 lpfnNotify:                     tFarProc
	): tFarProc; stdcall;

  {$ifdef UNICODE}
    function   LlDefineFieldA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineField
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineField
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineFieldW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldExtA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldExtW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldExtHandleA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldExtHandle
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldExtHandle
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldExtHandleW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

procedure  LlDefineFieldStart
	(hLlJob:                         HLLJOB
	); stdcall;

  {$ifdef UNICODE}
    function   LlDefineVariableA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineVariable
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariable
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineVariableW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableExtA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableExtW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableExtHandleA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableExtHandle
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableExtHandle
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableExtHandleW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 hContents:                      tHandle;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableNameA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineVariableName
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableName
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineVariableNameW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR
	): integer; stdcall;
  {$endif}

procedure  LlDefineVariableStart
	(hLlJob:                         HLLJOB
	); stdcall;

  {$ifdef UNICODE}
    function   LlDefineSumVariableA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineSumVariable
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 lpbufContents:                  pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineSumVariable
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineSumVariableW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 lpbufContents:                  pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineLayoutA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineLayout
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineLayout
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineLayoutW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDlgEditLineA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 lpBuf:                          pCHAR;
	 nBufSize:                       integer
	): integer; stdcall;
   {$else}
    function   LlDlgEditLine
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 lpBuf:                          pCHAR;
	 nBufSize:                       integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDlgEditLine
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 lpBuf:                          pWCHAR;
	 nBufSize:                       integer
	): integer; stdcall;
   {$else}
    function   LlDlgEditLineW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 lpBuf:                          pWCHAR;
	 nBufSize:                       integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDlgEditLineExA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 nParaTypes:                     cardinal;
	 pszTitle:                       pCHAR;
	 bTable:                         longbool;
	 pvReserved:                     pChar
	): integer; stdcall;
   {$else}
    function   LlDlgEditLineEx
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 nParaTypes:                     cardinal;
	 pszTitle:                       pCHAR;
	 bTable:                         longbool;
	 pvReserved:                     pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDlgEditLineEx
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 nParaTypes:                     cardinal;
	 pszTitle:                       pWCHAR;
	 bTable:                         longbool;
	 pvReserved:                     pChar
	): integer; stdcall;
   {$else}
    function   LlDlgEditLineExW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 nParaTypes:                     cardinal;
	 pszTitle:                       pWCHAR;
	 bTable:                         longbool;
	 pvReserved:                     pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewSetTempPathA
	(hLlJob:                         HLLJOB;
	 pszPath:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlPreviewSetTempPath
	(hLlJob:                         HLLJOB;
	 pszPath:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewSetTempPath
	(hLlJob:                         HLLJOB;
	 pszPath:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPreviewSetTempPathW
	(hLlJob:                         HLLJOB;
	 pszPath:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDeleteFilesA
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlPreviewDeleteFiles
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDeleteFiles
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPreviewDeleteFilesW
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDisplayA
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR;
	 Wnd:                            HWND
	): integer; stdcall;
   {$else}
    function   LlPreviewDisplay
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR;
	 Wnd:                            HWND
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDisplay
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR;
	 Wnd:                            HWND
	): integer; stdcall;
   {$else}
    function   LlPreviewDisplayW
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR;
	 Wnd:                            HWND
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDisplayExA
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR;
	 Wnd:                            HWND;
	 nOptions:                       cardinal;
	 pOptions:                       pChar
	): integer; stdcall;
   {$else}
    function   LlPreviewDisplayEx
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR;
	 pszPath:                        pCHAR;
	 Wnd:                            HWND;
	 nOptions:                       cardinal;
	 pOptions:                       pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPreviewDisplayEx
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR;
	 Wnd:                            HWND;
	 nOptions:                       cardinal;
	 pOptions:                       pChar
	): integer; stdcall;
   {$else}
    function   LlPreviewDisplayExW
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR;
	 pszPath:                        pWCHAR;
	 Wnd:                            HWND;
	 nOptions:                       cardinal;
	 pOptions:                       pChar
	): integer; stdcall;
  {$endif}

function   LlPrint
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintAbort
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintCheckLineFit
	(hLlJob:                         HLLJOB
	): longbool; stdcall;

function   LlPrintEnd
	(hLlJob:                         HLLJOB;
	 nPages:                         integer
	): integer; stdcall;

function   LlPrintFields
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintFieldsEnd
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintGetCurrentPage
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintGetItemsPerPage
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintGetItemsPerTable
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintGetRemainingItemsPerTableA
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemainingItemsPerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetRemainingItemsPerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemainingItemsPerTableW
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetRemItemsPerTableA
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemItemsPerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetRemItemsPerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemItemsPerTableW
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR
	): integer; stdcall;
  {$endif}

function   LlPrintGetOption
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer
	): lParam; stdcall;

  {$ifdef UNICODE}
    function   LlPrintGetPrinterInfoA
	(hLlJob:                         HLLJOB;
	 pszPrn:                         pCHAR;
	 nPrnLen:                        cardinal;
	 pszPort:                        pCHAR;
	 nPortLen:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetPrinterInfo
	(hLlJob:                         HLLJOB;
	 pszPrn:                         pCHAR;
	 nPrnLen:                        cardinal;
	 pszPort:                        pCHAR;
	 nPortLen:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetPrinterInfo
	(hLlJob:                         HLLJOB;
	 pszPrn:                         pWCHAR;
	 nPrnLen:                        cardinal;
	 pszPort:                        pWCHAR;
	 nPortLen:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetPrinterInfoW
	(hLlJob:                         HLLJOB;
	 pszPrn:                         pWCHAR;
	 nPrnLen:                        cardinal;
	 pszPort:                        pWCHAR;
	 nPortLen:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintOptionsDialogA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintOptionsDialog
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintOptionsDialog
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintOptionsDialogW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

function   LlPrintSelectOffsetEx
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintSetBoxTextA
	(hLlJob:                         HLLJOB;
	 szText:                         pCHAR;
	 nPercentage:                    integer
	): integer; stdcall;
   {$else}
    function   LlPrintSetBoxText
	(hLlJob:                         HLLJOB;
	 szText:                         pCHAR;
	 nPercentage:                    integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintSetBoxText
	(hLlJob:                         HLLJOB;
	 szText:                         pWCHAR;
	 nPercentage:                    integer
	): integer; stdcall;
   {$else}
    function   LlPrintSetBoxTextW
	(hLlJob:                         HLLJOB;
	 szText:                         pWCHAR;
	 nPercentage:                    integer
	): integer; stdcall;
  {$endif}

function   LlPrintSetOption
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 nValue:                         lParam
	): integer; stdcall;

function   LlPrintUpdateBox
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintStartA
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrintOptions:                  integer;
	 nReserved:                      integer
	): integer; stdcall;
   {$else}
    function   LlPrintStart
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrintOptions:                  integer;
	 nReserved:                      integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintStart
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrintOptions:                  integer;
	 nReserved:                      integer
	): integer; stdcall;
   {$else}
    function   LlPrintStartW
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrintOptions:                  integer;
	 nReserved:                      integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintWithBoxStartA
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrintOptions:                  integer;
	 nBoxType:                       integer;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintWithBoxStart
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrintOptions:                  integer;
	 nBoxType:                       integer;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintWithBoxStart
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrintOptions:                  integer;
	 nBoxType:                       integer;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintWithBoxStartW
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrintOptions:                  integer;
	 nBoxType:                       integer;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrinterSetupA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrinterSetup
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrinterSetup
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrinterSetupW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSelectFileDlgTitleExA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nBufSize:                       cardinal;
	 pReserved:                      pChar
	): integer; stdcall;
   {$else}
    function   LlSelectFileDlgTitleEx
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nBufSize:                       cardinal;
	 pReserved:                      pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSelectFileDlgTitleEx
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nBufSize:                       cardinal;
	 pReserved:                      pChar
	): integer; stdcall;
   {$else}
    function   LlSelectFileDlgTitleExW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nBufSize:                       cardinal;
	 pReserved:                      pChar
	): integer; stdcall;
  {$endif}

procedure  LlSetDlgboxMode
	(nMode:                          cardinal
	); stdcall;

function   LlGetDlgboxMode : cardinal; stdcall;

  {$ifdef UNICODE}
    function   LlExprParseA
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pCHAR;
	 bIncludeFields:                 longbool
	): HLLEXPR; stdcall;
   {$else}
    function   LlExprParse
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pCHAR;
	 bIncludeFields:                 longbool
	): HLLEXPR; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprParse
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pWCHAR;
	 bIncludeFields:                 longbool
	): HLLEXPR; stdcall;
   {$else}
    function   LlExprParseW
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pWCHAR;
	 bIncludeFields:                 longbool
	): HLLEXPR; stdcall;
  {$endif}

function   LlExprType
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR
	): integer; stdcall;

  {$ifdef UNICODE}
    procedure  LlExprErrorA
	(hLlJob:                         HLLJOB;
	 pszBuf:                         pCHAR;
	 nBufSize:                       cardinal
	); stdcall;
   {$else}
    procedure  LlExprError
	(hLlJob:                         HLLJOB;
	 pszBuf:                         pCHAR;
	 nBufSize:                       cardinal
	); stdcall;
  {$endif}

  {$ifdef UNICODE}
    procedure  LlExprError
	(hLlJob:                         HLLJOB;
	 pszBuf:                         pWCHAR;
	 nBufSize:                       cardinal
	); stdcall;
   {$else}
    procedure  LlExprErrorW
	(hLlJob:                         HLLJOB;
	 pszBuf:                         pWCHAR;
	 nBufSize:                       cardinal
	); stdcall;
  {$endif}

procedure  LlExprFree
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR
	); stdcall;

  {$ifdef UNICODE}
    function   LlExprEvaluateA
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuf:                         pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprEvaluate
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuf:                         pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprEvaluate
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuf:                         pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprEvaluateW
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuf:                         pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprGetUsedVarsA
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedVars
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprGetUsedVars
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedVarsW
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlSetOption
	(hLlJob:                         HLLJOB;
	 nMode:                          integer;
	 nValue:                         lParam
	): integer; stdcall;

function   LlGetOption
	(hLlJob:                         HLLJOB;
	 nMode:                          integer
	): lParam; stdcall;

  {$ifdef UNICODE}
    function   LlSetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
   {$else}
    function   LlSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
   {$else}
    function   LlSetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintSetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintSetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlDesignerProhibitAction
	(hLlJob:                         HLLJOB;
	 nMenuID:                        integer
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDesignerProhibitFunctionA
	(hLlJob:                         HLLJOB;
	 pszFunction:                    pCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerProhibitFunction
	(hLlJob:                         HLLJOB;
	 pszFunction:                    pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerProhibitFunction
	(hLlJob:                         HLLJOB;
	 pszFunction:                    pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerProhibitFunctionW
	(hLlJob:                         HLLJOB;
	 pszFunction:                    pWCHAR
	): integer; stdcall;
  {$endif}

function   LlDesignerProhibitFunctionGroup
	(hJob:                           HLLJOB;
	 nGroupFlags:                    cardinal
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintEnableObjectA
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 bEnable:                        longbool
	): integer; stdcall;
   {$else}
    function   LlPrintEnableObject
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 bEnable:                        longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintEnableObject
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 bEnable:                        longbool
	): integer; stdcall;
   {$else}
    function   LlPrintEnableObjectW
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 bEnable:                        longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetFileExtensionsA
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjectExt:                   pCHAR;
	 pszPrinterExt:                  pCHAR;
	 pszSketchExt:                   pCHAR
	): integer; stdcall;
   {$else}
    function   LlSetFileExtensions
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjectExt:                   pCHAR;
	 pszPrinterExt:                  pCHAR;
	 pszSketchExt:                   pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetFileExtensions
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjectExt:                   pWCHAR;
	 pszPrinterExt:                  pWCHAR;
	 pszSketchExt:                   pWCHAR
	): integer; stdcall;
   {$else}
    function   LlSetFileExtensionsW
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjectExt:                   pWCHAR;
	 pszPrinterExt:                  pWCHAR;
	 pszSketchExt:                   pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetTextCharsPrintedA
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetTextCharsPrinted
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetTextCharsPrinted
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetTextCharsPrintedW
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetFieldCharsPrintedA
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 pszField:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetFieldCharsPrinted
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 pszField:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetFieldCharsPrinted
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 pszField:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintGetFieldCharsPrintedW
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 pszField:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintIsVariableUsedA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsVariableUsed
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintIsVariableUsed
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsVariableUsedW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintIsFieldUsedA
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsFieldUsed
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintIsFieldUsed
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsFieldUsedW
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintOptionsDialogTitleA
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintOptionsDialogTitle
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintOptionsDialogTitle
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintOptionsDialogTitleW
	(hLlJob:                         HLLJOB;
	 hWnd:                           HWND;
	 pszTitle:                       pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterToDefaultA
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlSetPrinterToDefault
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterToDefault
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlSetPrinterToDefaultW
	(hLlJob:                         HLLJOB;
	 nObjType:                       integer;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
  {$endif}

function   LlDefineSortOrderStart
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDefineSortOrderA
	(hLlJob:                         HLLJOB;
	 pszIdentifier:                  pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineSortOrder
	(hLlJob:                         HLLJOB;
	 pszIdentifier:                  pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineSortOrder
	(hLlJob:                         HLLJOB;
	 pszIdentifier:                  pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineSortOrderW
	(hLlJob:                         HLLJOB;
	 pszIdentifier:                  pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetSortOrderA
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetSortOrder
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetSortOrder
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetSortOrderW
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineGroupingA
	(hLlJob:                         HLLJOB;
	 pszSortorder:                   pCHAR;
	 pszIdentifier:                  pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineGrouping
	(hLlJob:                         HLLJOB;
	 pszSortorder:                   pCHAR;
	 pszIdentifier:                  pCHAR;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineGrouping
	(hLlJob:                         HLLJOB;
	 pszSortorder:                   pWCHAR;
	 pszIdentifier:                  pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDefineGroupingW
	(hLlJob:                         HLLJOB;
	 pszSortorder:                   pWCHAR;
	 pszIdentifier:                  pWCHAR;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetGroupingA
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetGrouping
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetGrouping
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetGroupingW
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlAddCtlSupportA
	(hWnd:                           HWND;
	 nFlags:                         cardinal;
	 pszInifile:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlAddCtlSupport
	(hWnd:                           HWND;
	 nFlags:                         cardinal;
	 pszInifile:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlAddCtlSupport
	(hWnd:                           HWND;
	 nFlags:                         cardinal;
	 pszInifile:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlAddCtlSupportW
	(hWnd:                           HWND;
	 nFlags:                         cardinal;
	 pszInifile:                     pWCHAR
	): integer; stdcall;
  {$endif}

function   LlPrintBeginGroup
	(hLlJob:                         HLLJOB;
	 lParam:                         lParam;
	 lpParam:                        pChar
	): integer; stdcall;

function   LlPrintEndGroup
	(hLlJob:                         HLLJOB;
	 lParam:                         lParam;
	 lpParam:                        pChar
	): integer; stdcall;

function   LlPrintGroupLine
	(hLlJob:                         HLLJOB;
	 lParam:                         lParam;
	 lpParam:                        pChar
	): integer; stdcall;

function   LlPrintGroupHeader
	(hLlJob:                         HLLJOB;
	 lParam:                         lParam
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintGetFilterExpressionA
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetFilterExpression
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetFilterExpression
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintGetFilterExpressionW
	(hLlJob:                         HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlPrintWillMatchFilter
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlPrintDidMatchFilter
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlGetFieldContentsA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetFieldContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetFieldContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetFieldContentsW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetVariableContentsA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetVariableContentsW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetSumVariableContentsA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetSumVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetSumVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetSumVariableContentsW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUserVariableContentsA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUserVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUserVariableContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUserVariableContentsW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetVariableTypeA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlGetVariableType
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetVariableType
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlGetVariableTypeW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetFieldTypeA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlGetFieldType
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetFieldType
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlGetFieldTypeW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetColumnInfoA
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 nCol:                           integer;
	 pCol:                           PSCLLCOLUMN
	): integer; stdcall;
   {$else}
    function   LlPrintGetColumnInfo
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pCHAR;
	 nCol:                           integer;
	 pCol:                           PSCLLCOLUMN
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetColumnInfo
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 nCol:                           integer;
	 pCol:                           PSCLLCOLUMN
	): integer; stdcall;
   {$else}
    function   LlPrintGetColumnInfoW
	(hLlJob:                         HLLJOB;
	 pszObjectName:                  pWCHAR;
	 nCol:                           integer;
	 pCol:                           PSCLLCOLUMN
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterDefaultsDirA
	(hLlJob:                         HLLJOB;
	 pszDir:                         pCHAR
	): integer; stdcall;
   {$else}
    function   LlSetPrinterDefaultsDir
	(hLlJob:                         HLLJOB;
	 pszDir:                         pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterDefaultsDir
	(hLlJob:                         HLLJOB;
	 pszDir:                         pWCHAR
	): integer; stdcall;
   {$else}
    function   LlSetPrinterDefaultsDirW
	(hLlJob:                         HLLJOB;
	 pszDir:                         pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlCreateSketchA
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 lpszObjName:                    pCHAR
	): integer; stdcall;
   {$else}
    function   LlCreateSketch
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 lpszObjName:                    pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlCreateSketch
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 lpszObjName:                    pWCHAR
	): integer; stdcall;
   {$else}
    function   LlCreateSketchW
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 lpszObjName:                    pWCHAR
	): integer; stdcall;
  {$endif}

function   LlViewerProhibitAction
	(hLlJob:                         HLLJOB;
	 nMenuID:                        integer
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintCopyPrinterConfigurationA
	(hLlJob:                         HLLJOB;
	 lpszFilename:                   pCHAR;
	 nFunction:                      integer
	): integer; stdcall;
   {$else}
    function   LlPrintCopyPrinterConfiguration
	(hLlJob:                         HLLJOB;
	 lpszFilename:                   pCHAR;
	 nFunction:                      integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintCopyPrinterConfiguration
	(hLlJob:                         HLLJOB;
	 lpszFilename:                   pWCHAR;
	 nFunction:                      integer
	): integer; stdcall;
   {$else}
    function   LlPrintCopyPrinterConfigurationW
	(hLlJob:                         HLLJOB;
	 lpszFilename:                   pWCHAR;
	 nFunction:                      integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterInPrinterFileA
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrinterIndex:                  integer;
	 pszPrinter:                     pCHAR;
	 const pDevMode:                 _PCDEVMODEA
	): integer; stdcall;
   {$else}
    function   LlSetPrinterInPrinterFile
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nPrinterIndex:                  integer;
	 pszPrinter:                     pCHAR;
	 const pDevMode:                 _PCDEVMODEA
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetPrinterInPrinterFile
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrinterIndex:                  integer;
	 pszPrinter:                     pWCHAR;
	 const pDevMode:                 _PCDEVMODEW
	): integer; stdcall;
   {$else}
    function   LlSetPrinterInPrinterFileW
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nPrinterIndex:                  integer;
	 pszPrinter:                     pWCHAR;
	 const pDevMode:                 _PCDEVMODEW
	): integer; stdcall;
  {$endif}

function   LlRTFCreateObject
	(hLlJob:                         HLLJOB
	): HLLRTFOBJ; stdcall;

function   LlRTFDeleteObject
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlRTFSetTextA
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlRTFSetText
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlRTFSetText
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlRTFSetTextW
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

function   LlRTFGetTextLength
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         integer
	): cardinal; stdcall;

  {$ifdef UNICODE}
    function   LlRTFGetTextA
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlRTFGetText
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlRTFGetText
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlRTFGetTextW
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlRTFEditObject
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 hWnd:                           HWND;
	 hPrnDC:                         HDC;
	 nProjectType:                   integer;
	 bModal:                         longbool
	): integer; stdcall;

function   LlRTFCopyToClipboard
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ
	): integer; stdcall;

function   LlRTFDisplay
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 hDC:                            HDC;
	 pRC:                            _PRECT;
	 bRestart:                       longbool;
	 pnState:                        LLPUINT
	): integer; stdcall;

function   LlRTFEditorProhibitAction
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nControlID:                     integer
	): integer; stdcall;

function   LlRTFEditorInvokeAction
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nControlID:                     integer
	): integer; stdcall;

  {$ifdef UNICODE}
    procedure  LlDebugOutputA
	(nIndent:                        integer;
	 pszText:                        pCHAR
	); stdcall;
   {$else}
    procedure  LlDebugOutput
	(nIndent:                        integer;
	 pszText:                        pCHAR
	); stdcall;
  {$endif}

  {$ifdef UNICODE}
    procedure  LlDebugOutput
	(nIndent:                        integer;
	 pszText:                        pWCHAR
	); stdcall;
   {$else}
    procedure  LlDebugOutputW
	(nIndent:                        integer;
	 pszText:                        pWCHAR
	); stdcall;
  {$endif}

function   LlEnumGetFirstVar
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): HLISTPOS; stdcall;

function   LlEnumGetFirstField
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): HLISTPOS; stdcall;

function   LlEnumGetFirstConstant
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): HLISTPOS; stdcall;

function   LlEnumGetNextEntry
	(hLlJob:                         HLLJOB;
	 nPos:                           HLISTPOS;
	 nFlags:                         cardinal
	): HLISTPOS; stdcall;

  {$ifdef UNICODE}
    function   LlEnumGetEntryA
	(hLlJob:                         HLLJOB;
	 nPos:                           HLISTPOS;
	 pszNameBuf:                     pCHAR;
	 nNameBufSize:                   cardinal;
	 pszContBuf:                     pCHAR;
	 nContBufSize:                   cardinal;
	 pHandle:                        _LPHANDLE;
	 pType:                          _LPINT
	): integer; stdcall;
   {$else}
    function   LlEnumGetEntry
	(hLlJob:                         HLLJOB;
	 nPos:                           HLISTPOS;
	 pszNameBuf:                     pCHAR;
	 nNameBufSize:                   cardinal;
	 pszContBuf:                     pCHAR;
	 nContBufSize:                   cardinal;
	 pHandle:                        _LPHANDLE;
	 pType:                          _LPINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlEnumGetEntry
	(hLlJob:                         HLLJOB;
	 nPos:                           HLISTPOS;
	 pszNameBuf:                     pWCHAR;
	 nNameBufSize:                   cardinal;
	 pszContBuf:                     pWCHAR;
	 nContBufSize:                   cardinal;
	 pHandle:                        _LPHANDLE;
	 pType:                          _LPINT
	): integer; stdcall;
   {$else}
    function   LlEnumGetEntryW
	(hLlJob:                         HLLJOB;
	 nPos:                           HLISTPOS;
	 pszNameBuf:                     pWCHAR;
	 nNameBufSize:                   cardinal;
	 pszContBuf:                     pWCHAR;
	 nContBufSize:                   cardinal;
	 pHandle:                        _LPHANDLE;
	 pType:                          _LPINT
	): integer; stdcall;
  {$endif}

function   LlPrintResetObjectStates
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlXSetParameterA
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlXSetParameter
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXSetParameter
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlXSetParameterW
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXGetParameterA
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXGetParameter
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXGetParameter
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXGetParameterW
	(hLlJob:                         HLLJOB;
	 nExtensionType:                 integer;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlPrintResetProjectState
	(hJob:                           HLLJOB
	): integer; stdcall;

procedure  LlDefineChartFieldStart
	(hLlJob:                         HLLJOB
	); stdcall;

  {$ifdef UNICODE}
    function   LlDefineChartFieldExtA
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 pszContents:                    pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineChartFieldExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pCHAR;
	 pszContents:                    pCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineChartFieldExt
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 pszContents:                    pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineChartFieldExtW
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR;
	 pszContents:                    pWCHAR;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

function   LlPrintDeclareChartRow
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): integer; stdcall;

function   LlPrintGetChartObjectCount
	(hLlJob:                         HLLJOB;
	 nType:                          cardinal
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlPrintIsChartFieldUsedA
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsChartFieldUsed
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintIsChartFieldUsed
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pWCHAR
	): integer; stdcall;
   {$else}
    function   LlPrintIsChartFieldUsedW
	(hLlJob:                         HLLJOB;
	 pszFieldName:                   pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetChartFieldContentsA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetChartFieldContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetChartFieldContents
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetChartFieldContentsW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlEnumGetFirstChartField
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): HLISTPOS; stdcall;

function   LlSetNotificationCallbackExt
	(hLlJob:                         HLLJOB;
	 nEvent:                         integer;
	 lpfnNotify:                     tFarProc
	): tFarProc; stdcall;

function   LlExprEvaluateVar
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pVar:                           PVARIANT;
	 nFlags:                         cardinal
	): integer; stdcall;

function   LlExprTypeVar
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlGetPrinterFromPrinterFileA
	(hJob:                           HLLJOB;
	 nObjType:                       cardinal;
	 pszObjectName:                  pCHAR;
	 nPrinter:                       integer;
	 pszPrinter:                     pCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEA;
	 pnDevModeBufSize:               LLPUINT
	): integer; stdcall;
   {$else}
    function   LlGetPrinterFromPrinterFile
	(hJob:                           HLLJOB;
	 nObjType:                       cardinal;
	 pszObjectName:                  pCHAR;
	 nPrinter:                       integer;
	 pszPrinter:                     pCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEA;
	 pnDevModeBufSize:               LLPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetPrinterFromPrinterFile
	(hJob:                           HLLJOB;
	 nObjType:                       cardinal;
	 pszObjectName:                  pWCHAR;
	 nPrinter:                       integer;
	 pszPrinter:                     pWCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEW;
	 pnDevModeBufSize:               LLPUINT
	): integer; stdcall;
   {$else}
    function   LlGetPrinterFromPrinterFileW
	(hJob:                           HLLJOB;
	 nObjType:                       cardinal;
	 pszObjectName:                  pWCHAR;
	 nPrinter:                       integer;
	 pszPrinter:                     pWCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEW;
	 pnDevModeBufSize:               LLPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetRemainingSpacePerTableA
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR;
	 nDimension:                     integer
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemainingSpacePerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pCHAR;
	 nDimension:                     integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetRemainingSpacePerTable
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR;
	 nDimension:                     integer
	): integer; stdcall;
   {$else}
    function   LlPrintGetRemainingSpacePerTableW
	(hLlJob:                         HLLJOB;
	 pszField:                       pWCHAR;
	 nDimension:                     integer
	): integer; stdcall;
  {$endif}

procedure  LlDrawToolbarBackground
	(hDC:                            HDC;
	 pRC:                            _PRECT;
	 bHorz:                          longbool;
	 nTBMode:                        integer
	); stdcall;

  {$ifdef UNICODE}
    function   LlSetDefaultProjectParameterA
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszValue:                       pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlSetDefaultProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszValue:                       pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlSetDefaultProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszValue:                       pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlSetDefaultProjectParameterW
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszValue:                       pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetDefaultProjectParameterA
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlGetDefaultProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetDefaultProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlGetDefaultProjectParameterW
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintSetProjectParameterA
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszValue:                       pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintSetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 pszValue:                       pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintSetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszValue:                       pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintSetProjectParameterW
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 pszValue:                       pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetProjectParameterA
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 bEvaluated:                     longbool;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlPrintGetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pCHAR;
	 bEvaluated:                     longbool;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintGetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 bEvaluated:                     longbool;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlPrintGetProjectParameterW
	(hLlJob:                         HLLJOB;
	 pszParameter:                   pWCHAR;
	 bEvaluated:                     longbool;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       integer;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

function   LlCreateObject
	(const pIID:                     CTL_PGUID;
	 ppI:                            PPIUNKNOWN
	): longbool; stdcall;

  {$ifdef UNICODE}
    function   LlExprContainsVariableA
	(hLlJob:                         HLLJOB;
	 hExpr:                          HLLEXPR;
	 pszVariable:                    pCHAR
	): integer; stdcall;
   {$else}
    function   LlExprContainsVariable
	(hLlJob:                         HLLJOB;
	 hExpr:                          HLLEXPR;
	 pszVariable:                    pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprContainsVariable
	(hLlJob:                         HLLJOB;
	 hExpr:                          HLLEXPR;
	 pszVariable:                    pWCHAR
	): integer; stdcall;
   {$else}
    function   LlExprContainsVariableW
	(hLlJob:                         HLLJOB;
	 hExpr:                          HLLEXPR;
	 pszVariable:                    pWCHAR
	): integer; stdcall;
  {$endif}

function   LlExprIsConstant
	(hLlJob:                         HLLJOB;
	 hExpr:                          HLLEXPR
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlProfileStartA
	(hThread:                        tHandle;
	 pszDescr:                       pCHAR;
	 pszFilename:                    pCHAR;
	 nTicksMS:                       integer
	): integer; stdcall;
   {$else}
    function   LlProfileStart
	(hThread:                        tHandle;
	 pszDescr:                       pCHAR;
	 pszFilename:                    pCHAR;
	 nTicksMS:                       integer
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProfileStart
	(hThread:                        tHandle;
	 pszDescr:                       pWCHAR;
	 pszFilename:                    pWCHAR;
	 nTicksMS:                       integer
	): integer; stdcall;
   {$else}
    function   LlProfileStartW
	(hThread:                        tHandle;
	 pszDescr:                       pWCHAR;
	 pszFilename:                    pWCHAR;
	 nTicksMS:                       integer
	): integer; stdcall;
  {$endif}

procedure  LlProfileEnd
	(hThread:                        tHandle
	); stdcall;

procedure  LlDumpMemory
	(bDumpAll:                       longbool
	); stdcall;

  {$ifdef UNICODE}
    function   LlDbAddTableA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszDisplayName:                 pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszDisplayName:                 pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszDisplayName:                 pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszDisplayName:                 pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableRelationA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszParentTableID:               pCHAR;
	 pszRelationID:                  pCHAR;
	 pszRelationDisplayName:         pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableRelation
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszParentTableID:               pCHAR;
	 pszRelationID:                  pCHAR;
	 pszRelationDisplayName:         pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableRelation
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszParentTableID:               pWCHAR;
	 pszRelationID:                  pWCHAR;
	 pszRelationDisplayName:         pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableRelationW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszParentTableID:               pWCHAR;
	 pszRelationID:                  pWCHAR;
	 pszRelationDisplayName:         pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableSortOrderA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszSortOrderID:                 pCHAR;
	 pszSortOrderDisplayName:        pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableSortOrder
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszSortOrderID:                 pCHAR;
	 pszSortOrderDisplayName:        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableSortOrder
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszSortOrderID:                 pWCHAR;
	 pszSortOrderDisplayName:        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableSortOrderW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszSortOrderID:                 pWCHAR;
	 pszSortOrderDisplayName:        pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTableA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 nTableIDLength:                 cardinal;
	 bCompletePath:                  longbool
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 nTableIDLength:                 cardinal;
	 bCompletePath:                  longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 nTableIDLength:                 cardinal;
	 bCompletePath:                  longbool
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTableW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 nTableIDLength:                 cardinal;
	 bCompletePath:                  longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTableRelationA
	(hJob:                           HLLJOB;
	 pszRelationID:                  pCHAR;
	 nRelationIDLength:              cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTableRelation
	(hJob:                           HLLJOB;
	 pszRelationID:                  pCHAR;
	 nRelationIDLength:              cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTableRelation
	(hJob:                           HLLJOB;
	 pszRelationID:                  pWCHAR;
	 nRelationIDLength:              cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTableRelationW
	(hJob:                           HLLJOB;
	 pszRelationID:                  pWCHAR;
	 nRelationIDLength:              cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTableSortOrderA
	(hJob:                           HLLJOB;
	 pszSortOrderID:                 pCHAR;
	 nSortOrderIDLength:             cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTableSortOrder
	(hJob:                           HLLJOB;
	 pszSortOrderID:                 pCHAR;
	 nSortOrderIDLength:             cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlPrintDbGetCurrentTableSortOrder
	(hJob:                           HLLJOB;
	 pszSortOrderID:                 pWCHAR;
	 nSortOrderIDLength:             cardinal
	): integer; stdcall;
   {$else}
    function   LlPrintDbGetCurrentTableSortOrderW
	(hJob:                           HLLJOB;
	 pszSortOrderID:                 pWCHAR;
	 nSortOrderIDLength:             cardinal
	): integer; stdcall;
  {$endif}

function   LlDbDumpStructure
	(hJob:                           HLLJOB
	): integer; stdcall;

function   LlPrintDbGetRootTableCount
	(hJob:                           HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDbSetMasterTableA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbSetMasterTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbSetMasterTable
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbSetMasterTableW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbGetMasterTableA
	(hJob:                           HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDbGetMasterTable
	(hJob:                           HLLJOB;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbGetMasterTable
	(hJob:                           HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDbGetMasterTableW
	(hJob:                           HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXSetExportParameterA
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlXSetExportParameter
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXSetExportParameter
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlXSetExportParameterW
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXGetExportParameterA
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXGetExportParameter
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pCHAR;
	 pszKey:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXGetExportParameter
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXGetExportParameterW
	(hLlJob:                         HLLJOB;
	 pszExtensionName:               pWCHAR;
	 pszKey:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXlatNameA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXlatName
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlXlatName
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlXlatNameW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableVarA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineVariableVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineVariableVarW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldVarA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineFieldVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineFieldVarW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineChartFieldVarA
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineChartFieldVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDefineChartFieldVar
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
   {$else}
    function   LlDefineChartFieldVarW
	(hLlJob:                         HLLJOB;
	 pszName:                        pWCHAR;
	 const pValue:                   PVARIANT;
	 lPara:                          integer;
	 lpPtr:                          pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerProhibitEditingObjectA
	(hLlJob:                         HLLJOB;
	 pszObject:                      pCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerProhibitEditingObject
	(hLlJob:                         HLLJOB;
	 pszObject:                      pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerProhibitEditingObject
	(hLlJob:                         HLLJOB;
	 pszObject:                      pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerProhibitEditingObjectW
	(hLlJob:                         HLLJOB;
	 pszObject:                      pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUsedIdentifiersA
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUsedIdentifiers
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUsedIdentifiers
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUsedIdentifiersW
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprGetUsedVarsExA
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 OrgName:                        longbool
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedVarsEx
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 OrgName:                        longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprGetUsedVarsEx
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 OrgName:                        longbool
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedVarsExW
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 OrgName:                        longbool
	): integer; stdcall;
  {$endif}

function   LlDomGetProject
	(hLlJob:                         HLLJOB;
	 phDOMObj:                       PHLLDOMOBJ
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDomGetPropertyA
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDomGetProperty
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomGetProperty
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDomGetPropertyW
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomSetPropertyA
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlDomSetProperty
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 pszValue:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomSetProperty
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDomSetPropertyW
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 pszValue:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomGetObjectA
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
   {$else}
    function   LlDomGetObject
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomGetObject
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
   {$else}
    function   LlDomGetObjectW
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
  {$endif}

function   LlDomGetSubobjectCount
	(hDOMObj:                        HLLDOMOBJ;
	 pnCount:                        _LPINTJAVADUMMY
	): integer; stdcall;

function   LlDomGetSubobject
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDomCreateSubobjectA
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 pszType:                        pCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
   {$else}
    function   LlDomCreateSubobject
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 pszType:                        pCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDomCreateSubobject
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 pszType:                        pWCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
   {$else}
    function   LlDomCreateSubobjectW
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 pszType:                        pWCHAR;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;
  {$endif}

function   LlDomDeleteSubobject
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer
	): integer; stdcall;

function   LlDomMoveSubobject
	(hDOMObj:                        HLLDOMOBJ;
	 nPosition:                      integer;
	 nDelta:                         integer
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlProjectOpenA
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nOpenMode:                      cardinal
	): integer; stdcall;
   {$else}
    function   LlProjectOpen
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pCHAR;
	 nOpenMode:                      cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProjectOpen
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nOpenMode:                      cardinal
	): integer; stdcall;
   {$else}
    function   LlProjectOpenW
	(hLlJob:                         HLLJOB;
	 nObjType:                       cardinal;
	 pszObjName:                     pWCHAR;
	 nOpenMode:                      cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProjectSaveA
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlProjectSave
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProjectSave
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlProjectSaveW
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProjectSaveCopyAsA
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR
	): integer; stdcall;
   {$else}
    function   LlProjectSaveCopyAs
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlProjectSaveCopyAs
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
   {$else}
    function   LlProjectSaveCopyAsW
	(hLlJob:                         HLLJOB;
	 pszObjName:                     pWCHAR
	): integer; stdcall;
  {$endif}

function   LlProjectClose
	(hLlJob:                         HLLJOB
	): integer; stdcall;

function   LlDomGetPropertyCount
	(hDOMObj:                        HLLDOMOBJ;
	 pnCount:                        _LPINTJAVADUMMY
	): integer; stdcall;

function   LlAssociatePreviewControl
	(hLlJob:                         HLLJOB;
	 hWndControl:                    HWND;
	 nFlags:                         cardinal
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlGetErrortextA
	(nError:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetErrortext
	(nError:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetErrortext
	(nError:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetErrortextW
	(nError:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlSetPreviewOption
	(hLlJob:                         HLLJOB;
	 nOption:                        integer;
	 nValue:                         cardinal
	): integer; stdcall;

function   LlGetPreviewOption
	(hLlJob:                         HLLJOB;
	 nOption:                        integer;
	 pnValue:                        _LPUINT
	): integer; stdcall;

function   LlDesignerInvokeAction
	(hLlJob:                         HLLJOB;
	 nMenuID:                        integer
	): integer; stdcall;

function   LlDesignerRefreshWorkspace
	(hLlJob:                         HLLJOB
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlDesignerFileOpenA
	(hLlJob:                         HLLJOB;
	 pszFilename:                    pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerFileOpen
	(hLlJob:                         HLLJOB;
	 pszFilename:                    pCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerFileOpen
	(hLlJob:                         HLLJOB;
	 pszFilename:                    pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerFileOpenW
	(hLlJob:                         HLLJOB;
	 pszFilename:                    pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerFileSaveA
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerFileSave
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerFileSave
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerFileSaveW
	(hLlJob:                         HLLJOB;
	 nFlags:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerAddActionA
	(hLlJob:                         HLLJOB;
	 nID:                            cardinal;
	 nFlags:                         cardinal;
	 pszMenuText:                    pCHAR;
	 pszMenuHierarchy:               pCHAR;
	 pszTooltipText:                 pCHAR;
	 nIcon:                          cardinal;
	 pvReserved:                     pChar
	): integer; stdcall;
   {$else}
    function   LlDesignerAddAction
	(hLlJob:                         HLLJOB;
	 nID:                            cardinal;
	 nFlags:                         cardinal;
	 pszMenuText:                    pCHAR;
	 pszMenuHierarchy:               pCHAR;
	 pszTooltipText:                 pCHAR;
	 nIcon:                          cardinal;
	 pvReserved:                     pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerAddAction
	(hLlJob:                         HLLJOB;
	 nID:                            cardinal;
	 nFlags:                         cardinal;
	 pszMenuText:                    pWCHAR;
	 pszMenuHierarchy:               pWCHAR;
	 pszTooltipText:                 pWCHAR;
	 nIcon:                          cardinal;
	 pvReserved:                     pChar
	): integer; stdcall;
   {$else}
    function   LlDesignerAddActionW
	(hLlJob:                         HLLJOB;
	 nID:                            cardinal;
	 nFlags:                         cardinal;
	 pszMenuText:                    pWCHAR;
	 pszMenuHierarchy:               pWCHAR;
	 pszTooltipText:                 pWCHAR;
	 nIcon:                          cardinal;
	 pvReserved:                     pChar
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerGetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerGetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDesignerGetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerSetOptionStringA
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDesignerSetOptionString
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDesignerSetOptionStringW
	(hLlJob:                         HLLJOB;
	 nIndex:                         integer;
	 pszBuffer:                      pWCHAR
	): integer; stdcall;
  {$endif}

function   LlJobOpenCopy
	(hJob:                           HLLJOB
	): HLLJOB; stdcall;

  {$ifdef UNICODE}
    function   LlGetProjectParameterA
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszParameter:                   pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszParameter:                   pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetProjectParameter
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszParameter:                   pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetProjectParameterW
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszParameter:                   pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlConvertBLOBToStringA
	(const pBytes:                   _PCUINT8;
	 nBytes:                         cardinal;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 bWithCompression:               longbool
	): integer; stdcall;
   {$else}
    function   LlConvertBLOBToString
	(const pBytes:                   _PCUINT8;
	 nBytes:                         cardinal;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 bWithCompression:               longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlConvertBLOBToString
	(const pBytes:                   _PCUINT8;
	 nBytes:                         cardinal;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 bWithCompression:               longbool
	): integer; stdcall;
   {$else}
    function   LlConvertBLOBToStringW
	(const pBytes:                   _PCUINT8;
	 nBytes:                         cardinal;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 bWithCompression:               longbool
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlConvertStringToBLOBA
	(pszText:                        pCHAR;
	 pBytes:                         _PUINT8;
	 nBytes:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlConvertStringToBLOB
	(pszText:                        pCHAR;
	 pBytes:                         _PUINT8;
	 nBytes:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlConvertStringToBLOB
	(pszText:                        pWCHAR;
	 pBytes:                         _PUINT8;
	 nBytes:                         cardinal
	): integer; stdcall;
   {$else}
    function   LlConvertStringToBLOBW
	(pszText:                        pWCHAR;
	 pBytes:                         _PUINT8;
	 nBytes:                         cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableRelationExA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszParentTableID:               pCHAR;
	 pszRelationID:                  pCHAR;
	 pszRelationDisplayName:         pCHAR;
	 pszKeyField:                    pCHAR;
	 pszParentKeyField:              pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableRelationEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszParentTableID:               pCHAR;
	 pszRelationID:                  pCHAR;
	 pszRelationDisplayName:         pCHAR;
	 pszKeyField:                    pCHAR;
	 pszParentKeyField:              pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableRelationEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszParentTableID:               pWCHAR;
	 pszRelationID:                  pWCHAR;
	 pszRelationDisplayName:         pWCHAR;
	 pszKeyField:                    pWCHAR;
	 pszParentKeyField:              pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableRelationExW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszParentTableID:               pWCHAR;
	 pszRelationID:                  pWCHAR;
	 pszRelationDisplayName:         pWCHAR;
	 pszKeyField:                    pWCHAR;
	 pszParentKeyField:              pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableSortOrderExA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszSortOrderID:                 pCHAR;
	 pszSortOrderDisplayName:        pCHAR;
	 pszField:                       pCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableSortOrderEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszSortOrderID:                 pCHAR;
	 pszSortOrderDisplayName:        pCHAR;
	 pszField:                       pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableSortOrderEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszSortOrderID:                 pWCHAR;
	 pszSortOrderDisplayName:        pWCHAR;
	 pszField:                       pWCHAR
	): integer; stdcall;
   {$else}
    function   LlDbAddTableSortOrderExW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszSortOrderID:                 pWCHAR;
	 pszSortOrderDisplayName:        pWCHAR;
	 pszField:                       pWCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUsedIdentifiersExA
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 nIdentifierTypes:               cardinal;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUsedIdentifiersEx
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 nIdentifierTypes:               cardinal;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetUsedIdentifiersEx
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 nIdentifierTypes:               cardinal;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetUsedIdentifiersExW
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 nIdentifierTypes:               cardinal;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetTempFileNameA
	(pszPrefix:                      pCHAR;
	 pszExt:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetTempFileName
	(pszPrefix:                      pCHAR;
	 pszExt:                         pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetTempFileName
	(pszPrefix:                      pWCHAR;
	 pszExt:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetTempFileNameW
	(pszPrefix:                      pWCHAR;
	 pszExt:                         pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlGetDebug : cardinal; stdcall;

function   LlRTFEditorGetRTFControlHandle
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ
	): HWND; stdcall;

  {$ifdef UNICODE}
    function   LlGetDefaultPrinterA
	(pszPrinter:                     pCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEA;
	 pnDevModeBufSize:               LLPUINT;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetDefaultPrinter
	(pszPrinter:                     pCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEA;
	 pnDevModeBufSize:               LLPUINT;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetDefaultPrinter
	(pszPrinter:                     pWCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEW;
	 pnDevModeBufSize:               LLPUINT;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetDefaultPrinterW
	(pszPrinter:                     pWCHAR;
	 pnPrinterBufSize:               LLPUINT;
	 pDevMode:                       _PDEVMODEW;
	 pnDevModeBufSize:               LLPUINT;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlLocAddDictionaryEntryA
	(hLlJob:                         HLLJOB;
	 nLCID:                          _LCID;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR;
	 nType:                          cardinal
	): integer; stdcall;
   {$else}
    function   LlLocAddDictionaryEntry
	(hLlJob:                         HLLJOB;
	 nLCID:                          _LCID;
	 pszKey:                         pCHAR;
	 pszValue:                       pCHAR;
	 nType:                          cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlLocAddDictionaryEntry
	(hLlJob:                         HLLJOB;
	 nLCID:                          _LCID;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR;
	 nType:                          cardinal
	): integer; stdcall;
   {$else}
    function   LlLocAddDictionaryEntryW
	(hLlJob:                         HLLJOB;
	 nLCID:                          _LCID;
	 pszKey:                         pWCHAR;
	 pszValue:                       pWCHAR;
	 nType:                          cardinal
	): integer; stdcall;
  {$endif}

function   LlLocAddDesignLCID
	(hLlJob:                         HLLJOB;
	 nLCID:                          _LCID
	): integer; stdcall;

function   LlIsUILanguageAvailable
	(nLanguage:                      integer;
	 nTypesToLookFor:                cardinal
	): cardinal; stdcall;

function   LlIsUILanguageAvailableLCID
	(nLCID:                          _LCID;
	 nTypesToLookFor:                cardinal
	): cardinal; stdcall;

  {$ifdef UNICODE}
    function   LlDbAddTableExA
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszDisplayName:                 pCHAR;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDbAddTableEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pCHAR;
	 pszDisplayName:                 pCHAR;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlDbAddTableEx
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszDisplayName:                 pWCHAR;
	 nOptions:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlDbAddTableExW
	(hJob:                           HLLJOB;
	 pszTableID:                     pWCHAR;
	 pszDisplayName:                 pWCHAR;
	 nOptions:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlRTFSetTextExA
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         cardinal;
	 pszText:                        pCHAR
	): integer; stdcall;
   {$else}
    function   LlRTFSetTextEx
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         cardinal;
	 pszText:                        pCHAR
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlRTFSetTextEx
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         cardinal;
	 pszText:                        pWCHAR
	): integer; stdcall;
   {$else}
    function   LlRTFSetTextExW
	(hLlJob:                         HLLJOB;
	 hRTF:                           HLLRTFOBJ;
	 nFlags:                         cardinal;
	 pszText:                        pWCHAR
	): integer; stdcall;
  {$endif}

function   LlInplaceDesignerInteraction
	(hLlJob:                         HLLJOB;
	 nAction:                        cardinal;
	 wParam:                         lParam;
	 lParam:                         lParam
	): integer; stdcall;

function   LlUtilsAddResourcefilesHGLOBAL
	(pszName:                        pWCHAR;
	 hData:                          tHandle;
	 bPacked:                        longbool
	): integer; stdcall;

function   LlUtilsGetResourceString
	(hLlJob:                         HLLJOB;
	 nResourceID:                    integer;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;

procedure  LlGDILockEnter; stdcall;

procedure  LlGDILockLeave; stdcall;

  {$ifdef UNICODE}
    function   LlGetProjectDescriptionA
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetProjectDescription
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pCHAR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlGetProjectDescription
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlGetProjectDescriptionW
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlPrintDbGetCurrentTableFilter
	(hJob:                           HLLJOB;
	 pvFilter:                       PVARIANT;
	 pvParams:                       PVARIANT
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlExprTranslateToHostExpressionA
	(hJob:                           HLLJOB;
	 hExpr:                          HLLEXPR;
	 pvFilter:                       PVARIANT;
	 pvParams:                       PVARIANT;
	 pszCurrentTableName:            pCHAR;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlExprTranslateToHostExpression
	(hJob:                           HLLJOB;
	 hExpr:                          HLLEXPR;
	 pvFilter:                       PVARIANT;
	 pvParams:                       PVARIANT;
	 pszCurrentTableName:            pCHAR;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprTranslateToHostExpression
	(hJob:                           HLLJOB;
	 hExpr:                          HLLEXPR;
	 pvFilter:                       PVARIANT;
	 pvParams:                       PVARIANT;
	 pszCurrentTableName:            pWCHAR;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
   {$else}
    function   LlExprTranslateToHostExpressionW
	(hJob:                           HLLJOB;
	 hExpr:                          HLLEXPR;
	 pvFilter:                       PVARIANT;
	 pvParams:                       PVARIANT;
	 pszCurrentTableName:            pWCHAR;
	 pnFlags:                        _LPUINT
	): integer; stdcall;
  {$endif}

function   LlStgTestJobCreate
	(pwszStg1:                       pWCHAR;
	 pwszStg1Title:                  pWCHAR;
	 pwszStg2:                       pWCHAR;
	 pwszStg2Title:                  pWCHAR;
	 nFlags:                         cardinal;
	 pvErrors:                       PVARIANT;
	 pvStorage:                      PVARIANT;
	 p:                              _PBOOL
	): HLLTESTJOB; stdcall;

function   LlStgTestJobCmpPage
	(hJob:                           HLLTESTJOB;
	 nPage:                          cardinal;
	 nFlags:                         cardinal;
	 pvErrors:                       PVARIANT;
	 pvStorage:                      PVARIANT
	): integer; stdcall;

function   LlStgTestJobDestroy
	(hJob:                           HLLTESTJOB
	): integer; stdcall;

function   LlStgTestStgCmp
	(pwszStg1:                       pWCHAR;
	 pwszStg1Title:                  pWCHAR;
	 pwszStg2:                       pWCHAR;
	 pwszStg2Title:                  pWCHAR;
	 nFlags:                         cardinal;
	 pvErrors:                       PVARIANT;
	 pvStorage:                      PVARIANT
	): integer; stdcall;

procedure  LlStgTestStgCmpRUNDLL32
	(hwnd:                           HWND;
	 hinst:                          tHandle;
	 lpszCmdLine:                    pCHAR;
	 nCmdShow:                       integer
	); stdcall;

function   LlStgTestStgCmp2
	(pwszStg1:                       pWCHAR;
	 pwszStg1Title:                  pWCHAR;
	 pwszStg2:                       pWCHAR;
	 pwszStg2Title:                  pWCHAR;
	 nFlags:                         cardinal;
	 pwszStorage:                    pWCHAR
	): integer; stdcall;

function   LlStgTestJobCmpEmbeddedStorages
	(hJob:                           HLLTESTJOB;
	 pvErrors:                       PVARIANT
	): integer; stdcall;

function   LlSRTriggerExport
	(hJob:                           HLLJOB;
	 hSessionJob:                    HLLJOB;
	 pszID:                          pWCHAR;
	 pszExportFormat:                pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;

function   LlUtilsGetVariantFromProfContentsInternal
	(pszText:                        pWCHAR;
	 v:                              PVARIANT
	): integer; stdcall;

function   LlUtilsGetProfContentsFromVariantInternal
	(const v:                        PCVARIANT;
	 vAsString:                      PVARIANT
	): integer; stdcall;

  {$ifdef UNICODE}
    function   LlExprGetUsedFunctionsA
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedFunctions
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

  {$ifdef UNICODE}
    function   LlExprGetUsedFunctions
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
   {$else}
    function   LlExprGetUsedFunctionsW
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;
  {$endif}

function   LlDesignerTriggerJobInUIThread
	(hLlJob:                         HLLJOB;
	 nUserData:                      lParam
	): integer; stdcall;

function   LlUtilsComparePrinterInformation
	(pszDevice1:                     pWCHAR;
	 pszDriver1:                     pWCHAR;
	 const pszDEVMODEW1:             _PCDEVMODEW;
	 pszDevice2:                     pWCHAR;
	 pszDriver2:                     pWCHAR;
	 const pszDEVMODEW2:             _PCDEVMODEW;
	 nIgnoreFlags:                   cardinal
	): integer; stdcall;

function   LlGetUsedIdentifiersExV
	(hLlJob:                         HLLJOB;
	 pszProjectName:                 pWCHAR;
	 nIdentifierTypes:               cardinal;
	 pvArray:                        PVARIANT
	): integer; stdcall;

function   LlDomGetPropertyV
	(hDOMObj:                        HLLDOMOBJ;
	 pszName:                        pWCHAR;
	 pvValue:                        PVARIANT
	): integer; stdcall;

function   LlExprGetUsedFunctionsV
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pvArray:                        PVARIANT
	): integer; stdcall;

function   LlExprGetUsedVarsExV
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR;
	 pvArray:                        PVARIANT;
	 OrgName:                        longbool
	): integer; stdcall;

function   LlGetTableRelationToActiveTable
	(hLlJob:                         HLLJOB;
	 pszTable:                       pWCHAR;
	 OrgName:                        longbool;
	 pvValue:                        PVARIANT
	): integer; stdcall;

function   LlJobOpenCopyEx
	(hJob:                           HLLJOB;
	 nFlags:                         cardinal
	): HLLJOB; stdcall;

function   LlAddDebugSinkForThread
	(pSink:                          PIUNKNOWN
	): tHandle; stdcall;

function   LlRemoveDebugSinkFromThread
	(hSink:                          tHandle
	): integer; stdcall;

function   LlGetDebugSinkProxyModule
	(pszPrefix:                      pWCHAR;
	 const pGUID:                    CTL_PGUID;
	 pvSink:                         PVARIANT
	): integer; stdcall;

function   LlGetDebugSinkProxyCategory
	(nCategory:                      integer;
	 const pGUID:                    CTL_PGUID;
	 pvSink:                         PVARIANT
	): integer; stdcall;

function   LlDlgSelectFileOpen
	(hJob:                           HLLJOB;
	 hWndParent:                     HWND;
	 pszReposType:                   pWCHAR;
	 pszTitle:                       pWCHAR;
	 bWithCreateNew:                 longbool;
	 vFilenameOrID:                  PVARIANT
	): integer; stdcall;

function   LlUtilsLcidFromLocaleName
	(pszLocaleName:                  pWCHAR
	): integer; stdcall;

function   LlDesignerShowMessage
	(hJob:                           HLLJOB;
	 pszTitle:                       pWCHAR;
	 pszMessage:                     pWCHAR;
	 nFlags:                         cardinal
	): integer; stdcall;

function   LlExprConvertGlobalToLocal
	(hJob:                           HLLJOB;
	 pvVar:                          PVARIANT
	): integer; stdcall;

function   LlExprConvertLocalToGlobal
	(hJob:                           HLLJOB;
	 pvVar:                          PVARIANT
	): integer; stdcall;

function   LlUtilsGetProjectType
	(hJob:                           HLLJOB;
	 pszProjectFilename:             pWCHAR
	): integer; stdcall;

function   LlGetLastErrorText
	(hJob:                           HLLJOB;
	 pszBuffer:                      pWCHAR;
	 nBufSize:                       cardinal
	): integer; stdcall;

function   LlDomGetCurrentObject
	(hLlJob:                         HLLJOB;
	 nLevel:                         integer;
	 phDOMSubObj:                    PHLLDOMOBJ
	): integer; stdcall;

function   LlUtilsIDFromOrgID
	(hJob:                           HLLJOB;
	 pvVar:                          PVARIANT
	): integer; stdcall;

function   LlProjectFindAndReplace
	(hJob:                           HLLJOB;
	 pszSearchText:                  pWCHAR;
	 pszReplaceText:                 pWCHAR;
	 nSARFlags:                      cardinal
	): integer; stdcall;

function   LlExprParseQueryDelayedDefine
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pWCHAR;
	 bIncludeFields:                 longbool;
	 IUnkLLExprParseQuery:           PIUNKNOWN
	): integer; stdcall;

function   LlExprTypeMask
	(hLlJob:                         HLLJOB;
	 lpExpr:                         HLLEXPR
	): integer; stdcall;

function   LlStgTestJobCmpEmbeddedStorages2
	(hJob:                           HLLTESTJOB;
	 pvErrors:                       PVARIANT;
	 pvarListOfProblematicStorages:  PVARIANT
	): integer; stdcall;

function   LlStgTestJobAddResultJobs
	(hJob:                           HLLTESTJOB;
	 const pvarListOfProblematicStorages:                               PCVARIANT
	): integer; stdcall;

function   LlStgCreateFrom
	(hJob:                           HLLJOB;
	 nLCID:                          cardinal;
	 hWndForLengthyOpDialog:         HWND;
	 pszFile:                        pWCHAR;
	 pszResultingFileNameBuffer:     pWCHAR;
	 nResultingFileNameBufferSize:   cardinal;
	 nOptions:                       cardinal
	): integer; stdcall;

function   LlRemoveIdentifier
	(hLlJob:                         HLLJOB;
	 pszVarName:                     pWCHAR
	): integer; stdcall;

function   LlExprParseEx
	(hLlJob:                         HLLJOB;
	 lpExprText:                     pWCHAR;
	 nParaTypes:                     cardinal;
	 bIncludeFields:                 longbool
	): HLLEXPR; stdcall;


implementation

  {$ifdef WIN64}
    const LibNameLL28DLL = 'CXLL28.DLL';
   {$else}
    const LibNameLL28DLL = 'CMLL28.DLL';
  {$endif}

  {$ifdef CMLL28_LINK_INDEXED}
    function   LlJobOpen;                      external LibNameLL28DLL index 10;
   {$else}
    function   LlJobOpen;                      external LibNameLL28DLL name 'LlJobOpen';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlJobOpenLCID;                  external LibNameLL28DLL index 12;
   {$else}
    function   LlJobOpenLCID;                  external LibNameLL28DLL name 'LlJobOpenLCID';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlJobClose;                     external LibNameLL28DLL index 11;
   {$else}
    procedure  LlJobClose;                     external LibNameLL28DLL name 'LlJobClose';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlSetDebug;                     external LibNameLL28DLL index 13;
   {$else}
    procedure  LlSetDebug;                     external LibNameLL28DLL name 'LlSetDebug';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetVersion;                   external LibNameLL28DLL index 14;
   {$else}
    function   LlGetVersion;                   external LibNameLL28DLL name 'LlGetVersion';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetNotificationMessage;       external LibNameLL28DLL index 15;
   {$else}
    function   LlGetNotificationMessage;       external LibNameLL28DLL name 'LlGetNotificationMessage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSetNotificationMessage;       external LibNameLL28DLL index 16;
   {$else}
    function   LlSetNotificationMessage;       external LibNameLL28DLL name 'LlSetNotificationMessage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSetNotificationCallback;      external LibNameLL28DLL index 17;
   {$else}
    function   LlSetNotificationCallback;      external LibNameLL28DLL name 'LlSetNotificationCallback';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldA;                 external LibNameLL28DLL index 18;
     {$else}
      function   LlDefineFieldA;                 external LibNameLL28DLL name 'LlDefineFieldA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineField;                  external LibNameLL28DLL index 18;
     {$else}
      function   LlDefineField;                  external LibNameLL28DLL name 'LlDefineFieldA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineField;                  external LibNameLL28DLL index 118;
     {$else}
      function   LlDefineField;                  external LibNameLL28DLL name 'LlDefineFieldW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldW;                 external LibNameLL28DLL index 118;
     {$else}
      function   LlDefineFieldW;                 external LibNameLL28DLL name 'LlDefineFieldW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtA;              external LibNameLL28DLL index 19;
     {$else}
      function   LlDefineFieldExtA;              external LibNameLL28DLL name 'LlDefineFieldExtA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExt;               external LibNameLL28DLL index 19;
     {$else}
      function   LlDefineFieldExt;               external LibNameLL28DLL name 'LlDefineFieldExtA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExt;               external LibNameLL28DLL index 119;
     {$else}
      function   LlDefineFieldExt;               external LibNameLL28DLL name 'LlDefineFieldExtW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtW;              external LibNameLL28DLL index 119;
     {$else}
      function   LlDefineFieldExtW;              external LibNameLL28DLL name 'LlDefineFieldExtW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtHandleA;        external LibNameLL28DLL index 20;
     {$else}
      function   LlDefineFieldExtHandleA;        external LibNameLL28DLL name 'LlDefineFieldExtHandleA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtHandle;         external LibNameLL28DLL index 20;
     {$else}
      function   LlDefineFieldExtHandle;         external LibNameLL28DLL name 'LlDefineFieldExtHandleA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtHandle;         external LibNameLL28DLL index 120;
     {$else}
      function   LlDefineFieldExtHandle;         external LibNameLL28DLL name 'LlDefineFieldExtHandleW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldExtHandleW;        external LibNameLL28DLL index 120;
     {$else}
      function   LlDefineFieldExtHandleW;        external LibNameLL28DLL name 'LlDefineFieldExtHandleW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlDefineFieldStart;             external LibNameLL28DLL index 21;
   {$else}
    procedure  LlDefineFieldStart;             external LibNameLL28DLL name 'LlDefineFieldStart';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableA;              external LibNameLL28DLL index 22;
     {$else}
      function   LlDefineVariableA;              external LibNameLL28DLL name 'LlDefineVariableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariable;               external LibNameLL28DLL index 22;
     {$else}
      function   LlDefineVariable;               external LibNameLL28DLL name 'LlDefineVariableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariable;               external LibNameLL28DLL index 122;
     {$else}
      function   LlDefineVariable;               external LibNameLL28DLL name 'LlDefineVariableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableW;              external LibNameLL28DLL index 122;
     {$else}
      function   LlDefineVariableW;              external LibNameLL28DLL name 'LlDefineVariableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtA;           external LibNameLL28DLL index 23;
     {$else}
      function   LlDefineVariableExtA;           external LibNameLL28DLL name 'LlDefineVariableExtA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExt;            external LibNameLL28DLL index 23;
     {$else}
      function   LlDefineVariableExt;            external LibNameLL28DLL name 'LlDefineVariableExtA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExt;            external LibNameLL28DLL index 123;
     {$else}
      function   LlDefineVariableExt;            external LibNameLL28DLL name 'LlDefineVariableExtW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtW;           external LibNameLL28DLL index 123;
     {$else}
      function   LlDefineVariableExtW;           external LibNameLL28DLL name 'LlDefineVariableExtW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtHandleA;     external LibNameLL28DLL index 24;
     {$else}
      function   LlDefineVariableExtHandleA;     external LibNameLL28DLL name 'LlDefineVariableExtHandleA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtHandle;      external LibNameLL28DLL index 24;
     {$else}
      function   LlDefineVariableExtHandle;      external LibNameLL28DLL name 'LlDefineVariableExtHandleA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtHandle;      external LibNameLL28DLL index 124;
     {$else}
      function   LlDefineVariableExtHandle;      external LibNameLL28DLL name 'LlDefineVariableExtHandleW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableExtHandleW;     external LibNameLL28DLL index 124;
     {$else}
      function   LlDefineVariableExtHandleW;     external LibNameLL28DLL name 'LlDefineVariableExtHandleW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableNameA;          external LibNameLL28DLL index 25;
     {$else}
      function   LlDefineVariableNameA;          external LibNameLL28DLL name 'LlDefineVariableNameA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableName;           external LibNameLL28DLL index 25;
     {$else}
      function   LlDefineVariableName;           external LibNameLL28DLL name 'LlDefineVariableNameA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableName;           external LibNameLL28DLL index 125;
     {$else}
      function   LlDefineVariableName;           external LibNameLL28DLL name 'LlDefineVariableNameW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableNameW;          external LibNameLL28DLL index 125;
     {$else}
      function   LlDefineVariableNameW;          external LibNameLL28DLL name 'LlDefineVariableNameW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlDefineVariableStart;          external LibNameLL28DLL index 26;
   {$else}
    procedure  LlDefineVariableStart;          external LibNameLL28DLL name 'LlDefineVariableStart';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSumVariableA;           external LibNameLL28DLL index 27;
     {$else}
      function   LlDefineSumVariableA;           external LibNameLL28DLL name 'LlDefineSumVariableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSumVariable;            external LibNameLL28DLL index 27;
     {$else}
      function   LlDefineSumVariable;            external LibNameLL28DLL name 'LlDefineSumVariableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSumVariable;            external LibNameLL28DLL index 127;
     {$else}
      function   LlDefineSumVariable;            external LibNameLL28DLL name 'LlDefineSumVariableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSumVariableW;           external LibNameLL28DLL index 127;
     {$else}
      function   LlDefineSumVariableW;           external LibNameLL28DLL name 'LlDefineSumVariableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineLayoutA;                external LibNameLL28DLL index 28;
     {$else}
      function   LlDefineLayoutA;                external LibNameLL28DLL name 'LlDefineLayoutA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineLayout;                 external LibNameLL28DLL index 28;
     {$else}
      function   LlDefineLayout;                 external LibNameLL28DLL name 'LlDefineLayoutA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineLayout;                 external LibNameLL28DLL index 128;
     {$else}
      function   LlDefineLayout;                 external LibNameLL28DLL name 'LlDefineLayoutW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineLayoutW;                external LibNameLL28DLL index 128;
     {$else}
      function   LlDefineLayoutW;                external LibNameLL28DLL name 'LlDefineLayoutW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineA;                 external LibNameLL28DLL index 29;
     {$else}
      function   LlDlgEditLineA;                 external LibNameLL28DLL name 'LlDlgEditLineA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLine;                  external LibNameLL28DLL index 29;
     {$else}
      function   LlDlgEditLine;                  external LibNameLL28DLL name 'LlDlgEditLineA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLine;                  external LibNameLL28DLL index 129;
     {$else}
      function   LlDlgEditLine;                  external LibNameLL28DLL name 'LlDlgEditLineW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineW;                 external LibNameLL28DLL index 129;
     {$else}
      function   LlDlgEditLineW;                 external LibNameLL28DLL name 'LlDlgEditLineW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineExA;               external LibNameLL28DLL index 30;
     {$else}
      function   LlDlgEditLineExA;               external LibNameLL28DLL name 'LlDlgEditLineExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineEx;                external LibNameLL28DLL index 30;
     {$else}
      function   LlDlgEditLineEx;                external LibNameLL28DLL name 'LlDlgEditLineExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineEx;                external LibNameLL28DLL index 130;
     {$else}
      function   LlDlgEditLineEx;                external LibNameLL28DLL name 'LlDlgEditLineExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDlgEditLineExW;               external LibNameLL28DLL index 130;
     {$else}
      function   LlDlgEditLineExW;               external LibNameLL28DLL name 'LlDlgEditLineExW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewSetTempPathA;          external LibNameLL28DLL index 31;
     {$else}
      function   LlPreviewSetTempPathA;          external LibNameLL28DLL name 'LlPreviewSetTempPathA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewSetTempPath;           external LibNameLL28DLL index 31;
     {$else}
      function   LlPreviewSetTempPath;           external LibNameLL28DLL name 'LlPreviewSetTempPathA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewSetTempPath;           external LibNameLL28DLL index 131;
     {$else}
      function   LlPreviewSetTempPath;           external LibNameLL28DLL name 'LlPreviewSetTempPathW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewSetTempPathW;          external LibNameLL28DLL index 131;
     {$else}
      function   LlPreviewSetTempPathW;          external LibNameLL28DLL name 'LlPreviewSetTempPathW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDeleteFilesA;          external LibNameLL28DLL index 32;
     {$else}
      function   LlPreviewDeleteFilesA;          external LibNameLL28DLL name 'LlPreviewDeleteFilesA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDeleteFiles;           external LibNameLL28DLL index 32;
     {$else}
      function   LlPreviewDeleteFiles;           external LibNameLL28DLL name 'LlPreviewDeleteFilesA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDeleteFiles;           external LibNameLL28DLL index 132;
     {$else}
      function   LlPreviewDeleteFiles;           external LibNameLL28DLL name 'LlPreviewDeleteFilesW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDeleteFilesW;          external LibNameLL28DLL index 132;
     {$else}
      function   LlPreviewDeleteFilesW;          external LibNameLL28DLL name 'LlPreviewDeleteFilesW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayA;              external LibNameLL28DLL index 33;
     {$else}
      function   LlPreviewDisplayA;              external LibNameLL28DLL name 'LlPreviewDisplayA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplay;               external LibNameLL28DLL index 33;
     {$else}
      function   LlPreviewDisplay;               external LibNameLL28DLL name 'LlPreviewDisplayA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplay;               external LibNameLL28DLL index 133;
     {$else}
      function   LlPreviewDisplay;               external LibNameLL28DLL name 'LlPreviewDisplayW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayW;              external LibNameLL28DLL index 133;
     {$else}
      function   LlPreviewDisplayW;              external LibNameLL28DLL name 'LlPreviewDisplayW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayExA;            external LibNameLL28DLL index 34;
     {$else}
      function   LlPreviewDisplayExA;            external LibNameLL28DLL name 'LlPreviewDisplayExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayEx;             external LibNameLL28DLL index 34;
     {$else}
      function   LlPreviewDisplayEx;             external LibNameLL28DLL name 'LlPreviewDisplayExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayEx;             external LibNameLL28DLL index 134;
     {$else}
      function   LlPreviewDisplayEx;             external LibNameLL28DLL name 'LlPreviewDisplayExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPreviewDisplayExW;            external LibNameLL28DLL index 134;
     {$else}
      function   LlPreviewDisplayExW;            external LibNameLL28DLL name 'LlPreviewDisplayExW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrint;                        external LibNameLL28DLL index 35;
   {$else}
    function   LlPrint;                        external LibNameLL28DLL name 'LlPrint';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintAbort;                   external LibNameLL28DLL index 36;
   {$else}
    function   LlPrintAbort;                   external LibNameLL28DLL name 'LlPrintAbort';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintCheckLineFit;            external LibNameLL28DLL index 37;
   {$else}
    function   LlPrintCheckLineFit;            external LibNameLL28DLL name 'LlPrintCheckLineFit';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintEnd;                     external LibNameLL28DLL index 38;
   {$else}
    function   LlPrintEnd;                     external LibNameLL28DLL name 'LlPrintEnd';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintFields;                  external LibNameLL28DLL index 39;
   {$else}
    function   LlPrintFields;                  external LibNameLL28DLL name 'LlPrintFields';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintFieldsEnd;               external LibNameLL28DLL index 40;
   {$else}
    function   LlPrintFieldsEnd;               external LibNameLL28DLL name 'LlPrintFieldsEnd';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGetCurrentPage;          external LibNameLL28DLL index 41;
   {$else}
    function   LlPrintGetCurrentPage;          external LibNameLL28DLL name 'LlPrintGetCurrentPage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGetItemsPerPage;         external LibNameLL28DLL index 42;
   {$else}
    function   LlPrintGetItemsPerPage;         external LibNameLL28DLL name 'LlPrintGetItemsPerPage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGetItemsPerTable;        external LibNameLL28DLL index 43;
   {$else}
    function   LlPrintGetItemsPerTable;        external LibNameLL28DLL name 'LlPrintGetItemsPerTable';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingItemsPerTableA;    external LibNameLL28DLL index 44;
     {$else}
      function   LlPrintGetRemainingItemsPerTableA;    external LibNameLL28DLL name 'LlPrintGetRemainingItemsPerTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingItemsPerTable;   external LibNameLL28DLL index 44;
     {$else}
      function   LlPrintGetRemainingItemsPerTable;   external LibNameLL28DLL name 'LlPrintGetRemainingItemsPerTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingItemsPerTable;   external LibNameLL28DLL index 144;
     {$else}
      function   LlPrintGetRemainingItemsPerTable;   external LibNameLL28DLL name 'LlPrintGetRemainingItemsPerTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingItemsPerTableW;    external LibNameLL28DLL index 144;
     {$else}
      function   LlPrintGetRemainingItemsPerTableW;    external LibNameLL28DLL name 'LlPrintGetRemainingItemsPerTableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemItemsPerTableA;    external LibNameLL28DLL index 45;
     {$else}
      function   LlPrintGetRemItemsPerTableA;    external LibNameLL28DLL name 'LlPrintGetRemItemsPerTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemItemsPerTable;     external LibNameLL28DLL index 45;
     {$else}
      function   LlPrintGetRemItemsPerTable;     external LibNameLL28DLL name 'LlPrintGetRemItemsPerTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemItemsPerTable;     external LibNameLL28DLL index 145;
     {$else}
      function   LlPrintGetRemItemsPerTable;     external LibNameLL28DLL name 'LlPrintGetRemItemsPerTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemItemsPerTableW;    external LibNameLL28DLL index 145;
     {$else}
      function   LlPrintGetRemItemsPerTableW;    external LibNameLL28DLL name 'LlPrintGetRemItemsPerTableW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGetOption;               external LibNameLL28DLL index 46;
   {$else}
    function   LlPrintGetOption;               external LibNameLL28DLL name 'LlPrintGetOption';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetPrinterInfoA;         external LibNameLL28DLL index 47;
     {$else}
      function   LlPrintGetPrinterInfoA;         external LibNameLL28DLL name 'LlPrintGetPrinterInfoA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetPrinterInfo;          external LibNameLL28DLL index 47;
     {$else}
      function   LlPrintGetPrinterInfo;          external LibNameLL28DLL name 'LlPrintGetPrinterInfoA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetPrinterInfo;          external LibNameLL28DLL index 147;
     {$else}
      function   LlPrintGetPrinterInfo;          external LibNameLL28DLL name 'LlPrintGetPrinterInfoW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetPrinterInfoW;         external LibNameLL28DLL index 147;
     {$else}
      function   LlPrintGetPrinterInfoW;         external LibNameLL28DLL name 'LlPrintGetPrinterInfoW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogA;          external LibNameLL28DLL index 48;
     {$else}
      function   LlPrintOptionsDialogA;          external LibNameLL28DLL name 'LlPrintOptionsDialogA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialog;           external LibNameLL28DLL index 48;
     {$else}
      function   LlPrintOptionsDialog;           external LibNameLL28DLL name 'LlPrintOptionsDialogA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialog;           external LibNameLL28DLL index 148;
     {$else}
      function   LlPrintOptionsDialog;           external LibNameLL28DLL name 'LlPrintOptionsDialogW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogW;          external LibNameLL28DLL index 148;
     {$else}
      function   LlPrintOptionsDialogW;          external LibNameLL28DLL name 'LlPrintOptionsDialogW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintSelectOffsetEx;          external LibNameLL28DLL index 49;
   {$else}
    function   LlPrintSelectOffsetEx;          external LibNameLL28DLL name 'LlPrintSelectOffsetEx';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetBoxTextA;             external LibNameLL28DLL index 50;
     {$else}
      function   LlPrintSetBoxTextA;             external LibNameLL28DLL name 'LlPrintSetBoxTextA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetBoxText;              external LibNameLL28DLL index 50;
     {$else}
      function   LlPrintSetBoxText;              external LibNameLL28DLL name 'LlPrintSetBoxTextA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetBoxText;              external LibNameLL28DLL index 150;
     {$else}
      function   LlPrintSetBoxText;              external LibNameLL28DLL name 'LlPrintSetBoxTextW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetBoxTextW;             external LibNameLL28DLL index 150;
     {$else}
      function   LlPrintSetBoxTextW;             external LibNameLL28DLL name 'LlPrintSetBoxTextW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintSetOption;               external LibNameLL28DLL index 51;
   {$else}
    function   LlPrintSetOption;               external LibNameLL28DLL name 'LlPrintSetOption';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintUpdateBox;               external LibNameLL28DLL index 52;
   {$else}
    function   LlPrintUpdateBox;               external LibNameLL28DLL name 'LlPrintUpdateBox';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintStartA;                  external LibNameLL28DLL index 53;
     {$else}
      function   LlPrintStartA;                  external LibNameLL28DLL name 'LlPrintStartA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintStart;                   external LibNameLL28DLL index 53;
     {$else}
      function   LlPrintStart;                   external LibNameLL28DLL name 'LlPrintStartA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintStart;                   external LibNameLL28DLL index 153;
     {$else}
      function   LlPrintStart;                   external LibNameLL28DLL name 'LlPrintStartW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintStartW;                  external LibNameLL28DLL index 153;
     {$else}
      function   LlPrintStartW;                  external LibNameLL28DLL name 'LlPrintStartW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintWithBoxStartA;           external LibNameLL28DLL index 54;
     {$else}
      function   LlPrintWithBoxStartA;           external LibNameLL28DLL name 'LlPrintWithBoxStartA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintWithBoxStart;            external LibNameLL28DLL index 54;
     {$else}
      function   LlPrintWithBoxStart;            external LibNameLL28DLL name 'LlPrintWithBoxStartA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintWithBoxStart;            external LibNameLL28DLL index 154;
     {$else}
      function   LlPrintWithBoxStart;            external LibNameLL28DLL name 'LlPrintWithBoxStartW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintWithBoxStartW;           external LibNameLL28DLL index 154;
     {$else}
      function   LlPrintWithBoxStartW;           external LibNameLL28DLL name 'LlPrintWithBoxStartW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrinterSetupA;                external LibNameLL28DLL index 55;
     {$else}
      function   LlPrinterSetupA;                external LibNameLL28DLL name 'LlPrinterSetupA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrinterSetup;                 external LibNameLL28DLL index 55;
     {$else}
      function   LlPrinterSetup;                 external LibNameLL28DLL name 'LlPrinterSetupA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrinterSetup;                 external LibNameLL28DLL index 155;
     {$else}
      function   LlPrinterSetup;                 external LibNameLL28DLL name 'LlPrinterSetupW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrinterSetupW;                external LibNameLL28DLL index 155;
     {$else}
      function   LlPrinterSetupW;                external LibNameLL28DLL name 'LlPrinterSetupW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSelectFileDlgTitleExA;        external LibNameLL28DLL index 56;
     {$else}
      function   LlSelectFileDlgTitleExA;        external LibNameLL28DLL name 'LlSelectFileDlgTitleExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSelectFileDlgTitleEx;         external LibNameLL28DLL index 56;
     {$else}
      function   LlSelectFileDlgTitleEx;         external LibNameLL28DLL name 'LlSelectFileDlgTitleExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSelectFileDlgTitleEx;         external LibNameLL28DLL index 156;
     {$else}
      function   LlSelectFileDlgTitleEx;         external LibNameLL28DLL name 'LlSelectFileDlgTitleExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSelectFileDlgTitleExW;        external LibNameLL28DLL index 156;
     {$else}
      function   LlSelectFileDlgTitleExW;        external LibNameLL28DLL name 'LlSelectFileDlgTitleExW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlSetDlgboxMode;                external LibNameLL28DLL index 57;
   {$else}
    procedure  LlSetDlgboxMode;                external LibNameLL28DLL name 'LlSetDlgboxMode';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetDlgboxMode;                external LibNameLL28DLL index 58;
   {$else}
    function   LlGetDlgboxMode;                external LibNameLL28DLL name 'LlGetDlgboxMode';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprParseA;                   external LibNameLL28DLL index 59;
     {$else}
      function   LlExprParseA;                   external LibNameLL28DLL name 'LlExprParseA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprParse;                    external LibNameLL28DLL index 59;
     {$else}
      function   LlExprParse;                    external LibNameLL28DLL name 'LlExprParseA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprParse;                    external LibNameLL28DLL index 159;
     {$else}
      function   LlExprParse;                    external LibNameLL28DLL name 'LlExprParseW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprParseW;                   external LibNameLL28DLL index 159;
     {$else}
      function   LlExprParseW;                   external LibNameLL28DLL name 'LlExprParseW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprType;                     external LibNameLL28DLL index 60;
   {$else}
    function   LlExprType;                     external LibNameLL28DLL name 'LlExprType';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlExprErrorA;                   external LibNameLL28DLL index 61;
     {$else}
      procedure  LlExprErrorA;                   external LibNameLL28DLL name 'LlExprErrorA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlExprError;                    external LibNameLL28DLL index 61;
     {$else}
      procedure  LlExprError;                    external LibNameLL28DLL name 'LlExprErrorA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlExprError;                    external LibNameLL28DLL index 161;
     {$else}
      procedure  LlExprError;                    external LibNameLL28DLL name 'LlExprErrorW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlExprErrorW;                   external LibNameLL28DLL index 161;
     {$else}
      procedure  LlExprErrorW;                   external LibNameLL28DLL name 'LlExprErrorW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlExprFree;                     external LibNameLL28DLL index 62;
   {$else}
    procedure  LlExprFree;                     external LibNameLL28DLL name 'LlExprFree';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprEvaluateA;                external LibNameLL28DLL index 63;
     {$else}
      function   LlExprEvaluateA;                external LibNameLL28DLL name 'LlExprEvaluateA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprEvaluate;                 external LibNameLL28DLL index 63;
     {$else}
      function   LlExprEvaluate;                 external LibNameLL28DLL name 'LlExprEvaluateA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprEvaluate;                 external LibNameLL28DLL index 163;
     {$else}
      function   LlExprEvaluate;                 external LibNameLL28DLL name 'LlExprEvaluateW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprEvaluateW;                external LibNameLL28DLL index 163;
     {$else}
      function   LlExprEvaluateW;                external LibNameLL28DLL name 'LlExprEvaluateW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsA;             external LibNameLL28DLL index 162;
     {$else}
      function   LlExprGetUsedVarsA;             external LibNameLL28DLL name 'LlExprGetUsedVarsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVars;              external LibNameLL28DLL index 162;
     {$else}
      function   LlExprGetUsedVars;              external LibNameLL28DLL name 'LlExprGetUsedVarsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVars;              external LibNameLL28DLL index 362;
     {$else}
      function   LlExprGetUsedVars;              external LibNameLL28DLL name 'LlExprGetUsedVarsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsW;             external LibNameLL28DLL index 362;
     {$else}
      function   LlExprGetUsedVarsW;             external LibNameLL28DLL name 'LlExprGetUsedVarsW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSetOption;                    external LibNameLL28DLL index 64;
   {$else}
    function   LlSetOption;                    external LibNameLL28DLL name 'LlSetOption';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetOption;                    external LibNameLL28DLL index 65;
   {$else}
    function   LlGetOption;                    external LibNameLL28DLL name 'LlGetOption';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetOptionStringA;             external LibNameLL28DLL index 66;
     {$else}
      function   LlSetOptionStringA;             external LibNameLL28DLL name 'LlSetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetOptionString;              external LibNameLL28DLL index 66;
     {$else}
      function   LlSetOptionString;              external LibNameLL28DLL name 'LlSetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetOptionString;              external LibNameLL28DLL index 166;
     {$else}
      function   LlSetOptionString;              external LibNameLL28DLL name 'LlSetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetOptionStringW;             external LibNameLL28DLL index 166;
     {$else}
      function   LlSetOptionStringW;             external LibNameLL28DLL name 'LlSetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetOptionStringA;             external LibNameLL28DLL index 67;
     {$else}
      function   LlGetOptionStringA;             external LibNameLL28DLL name 'LlGetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetOptionString;              external LibNameLL28DLL index 67;
     {$else}
      function   LlGetOptionString;              external LibNameLL28DLL name 'LlGetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetOptionString;              external LibNameLL28DLL index 167;
     {$else}
      function   LlGetOptionString;              external LibNameLL28DLL name 'LlGetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetOptionStringW;             external LibNameLL28DLL index 167;
     {$else}
      function   LlGetOptionStringW;             external LibNameLL28DLL name 'LlGetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetOptionStringA;        external LibNameLL28DLL index 68;
     {$else}
      function   LlPrintSetOptionStringA;        external LibNameLL28DLL name 'LlPrintSetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetOptionString;         external LibNameLL28DLL index 68;
     {$else}
      function   LlPrintSetOptionString;         external LibNameLL28DLL name 'LlPrintSetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetOptionString;         external LibNameLL28DLL index 168;
     {$else}
      function   LlPrintSetOptionString;         external LibNameLL28DLL name 'LlPrintSetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetOptionStringW;        external LibNameLL28DLL index 168;
     {$else}
      function   LlPrintSetOptionStringW;        external LibNameLL28DLL name 'LlPrintSetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetOptionStringA;        external LibNameLL28DLL index 69;
     {$else}
      function   LlPrintGetOptionStringA;        external LibNameLL28DLL name 'LlPrintGetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetOptionString;         external LibNameLL28DLL index 69;
     {$else}
      function   LlPrintGetOptionString;         external LibNameLL28DLL name 'LlPrintGetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetOptionString;         external LibNameLL28DLL index 169;
     {$else}
      function   LlPrintGetOptionString;         external LibNameLL28DLL name 'LlPrintGetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetOptionStringW;        external LibNameLL28DLL index 169;
     {$else}
      function   LlPrintGetOptionStringW;        external LibNameLL28DLL name 'LlPrintGetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerProhibitAction;       external LibNameLL28DLL index 70;
   {$else}
    function   LlDesignerProhibitAction;       external LibNameLL28DLL name 'LlDesignerProhibitAction';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitFunctionA;    external LibNameLL28DLL index 1;
     {$else}
      function   LlDesignerProhibitFunctionA;    external LibNameLL28DLL name 'LlDesignerProhibitFunctionA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitFunction;     external LibNameLL28DLL index 1;
     {$else}
      function   LlDesignerProhibitFunction;     external LibNameLL28DLL name 'LlDesignerProhibitFunctionA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitFunction;     external LibNameLL28DLL index 101;
     {$else}
      function   LlDesignerProhibitFunction;     external LibNameLL28DLL name 'LlDesignerProhibitFunctionW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitFunctionW;    external LibNameLL28DLL index 101;
     {$else}
      function   LlDesignerProhibitFunctionW;    external LibNameLL28DLL name 'LlDesignerProhibitFunctionW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerProhibitFunctionGroup;  external LibNameLL28DLL index 337;
   {$else}
    function   LlDesignerProhibitFunctionGroup;  external LibNameLL28DLL name 'LlDesignerProhibitFunctionGroup';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintEnableObjectA;           external LibNameLL28DLL index 71;
     {$else}
      function   LlPrintEnableObjectA;           external LibNameLL28DLL name 'LlPrintEnableObjectA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintEnableObject;            external LibNameLL28DLL index 71;
     {$else}
      function   LlPrintEnableObject;            external LibNameLL28DLL name 'LlPrintEnableObjectA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintEnableObject;            external LibNameLL28DLL index 171;
     {$else}
      function   LlPrintEnableObject;            external LibNameLL28DLL name 'LlPrintEnableObjectW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintEnableObjectW;           external LibNameLL28DLL index 171;
     {$else}
      function   LlPrintEnableObjectW;           external LibNameLL28DLL name 'LlPrintEnableObjectW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetFileExtensionsA;           external LibNameLL28DLL index 72;
     {$else}
      function   LlSetFileExtensionsA;           external LibNameLL28DLL name 'LlSetFileExtensionsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetFileExtensions;            external LibNameLL28DLL index 72;
     {$else}
      function   LlSetFileExtensions;            external LibNameLL28DLL name 'LlSetFileExtensionsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetFileExtensions;            external LibNameLL28DLL index 172;
     {$else}
      function   LlSetFileExtensions;            external LibNameLL28DLL name 'LlSetFileExtensionsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetFileExtensionsW;           external LibNameLL28DLL index 172;
     {$else}
      function   LlSetFileExtensionsW;           external LibNameLL28DLL name 'LlSetFileExtensionsW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetTextCharsPrintedA;    external LibNameLL28DLL index 73;
     {$else}
      function   LlPrintGetTextCharsPrintedA;    external LibNameLL28DLL name 'LlPrintGetTextCharsPrintedA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetTextCharsPrinted;     external LibNameLL28DLL index 73;
     {$else}
      function   LlPrintGetTextCharsPrinted;     external LibNameLL28DLL name 'LlPrintGetTextCharsPrintedA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetTextCharsPrinted;     external LibNameLL28DLL index 173;
     {$else}
      function   LlPrintGetTextCharsPrinted;     external LibNameLL28DLL name 'LlPrintGetTextCharsPrintedW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetTextCharsPrintedW;    external LibNameLL28DLL index 173;
     {$else}
      function   LlPrintGetTextCharsPrintedW;    external LibNameLL28DLL name 'LlPrintGetTextCharsPrintedW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFieldCharsPrintedA;   external LibNameLL28DLL index 74;
     {$else}
      function   LlPrintGetFieldCharsPrintedA;   external LibNameLL28DLL name 'LlPrintGetFieldCharsPrintedA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFieldCharsPrinted;    external LibNameLL28DLL index 74;
     {$else}
      function   LlPrintGetFieldCharsPrinted;    external LibNameLL28DLL name 'LlPrintGetFieldCharsPrintedA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFieldCharsPrinted;    external LibNameLL28DLL index 174;
     {$else}
      function   LlPrintGetFieldCharsPrinted;    external LibNameLL28DLL name 'LlPrintGetFieldCharsPrintedW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFieldCharsPrintedW;   external LibNameLL28DLL index 174;
     {$else}
      function   LlPrintGetFieldCharsPrintedW;   external LibNameLL28DLL name 'LlPrintGetFieldCharsPrintedW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsVariableUsedA;         external LibNameLL28DLL index 75;
     {$else}
      function   LlPrintIsVariableUsedA;         external LibNameLL28DLL name 'LlPrintIsVariableUsedA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsVariableUsed;          external LibNameLL28DLL index 75;
     {$else}
      function   LlPrintIsVariableUsed;          external LibNameLL28DLL name 'LlPrintIsVariableUsedA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsVariableUsed;          external LibNameLL28DLL index 175;
     {$else}
      function   LlPrintIsVariableUsed;          external LibNameLL28DLL name 'LlPrintIsVariableUsedW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsVariableUsedW;         external LibNameLL28DLL index 175;
     {$else}
      function   LlPrintIsVariableUsedW;         external LibNameLL28DLL name 'LlPrintIsVariableUsedW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsFieldUsedA;            external LibNameLL28DLL index 76;
     {$else}
      function   LlPrintIsFieldUsedA;            external LibNameLL28DLL name 'LlPrintIsFieldUsedA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsFieldUsed;             external LibNameLL28DLL index 76;
     {$else}
      function   LlPrintIsFieldUsed;             external LibNameLL28DLL name 'LlPrintIsFieldUsedA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsFieldUsed;             external LibNameLL28DLL index 176;
     {$else}
      function   LlPrintIsFieldUsed;             external LibNameLL28DLL name 'LlPrintIsFieldUsedW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsFieldUsedW;            external LibNameLL28DLL index 176;
     {$else}
      function   LlPrintIsFieldUsedW;            external LibNameLL28DLL name 'LlPrintIsFieldUsedW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogTitleA;     external LibNameLL28DLL index 77;
     {$else}
      function   LlPrintOptionsDialogTitleA;     external LibNameLL28DLL name 'LlPrintOptionsDialogTitleA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogTitle;      external LibNameLL28DLL index 77;
     {$else}
      function   LlPrintOptionsDialogTitle;      external LibNameLL28DLL name 'LlPrintOptionsDialogTitleA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogTitle;      external LibNameLL28DLL index 177;
     {$else}
      function   LlPrintOptionsDialogTitle;      external LibNameLL28DLL name 'LlPrintOptionsDialogTitleW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintOptionsDialogTitleW;     external LibNameLL28DLL index 177;
     {$else}
      function   LlPrintOptionsDialogTitleW;     external LibNameLL28DLL name 'LlPrintOptionsDialogTitleW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterToDefaultA;         external LibNameLL28DLL index 78;
     {$else}
      function   LlSetPrinterToDefaultA;         external LibNameLL28DLL name 'LlSetPrinterToDefaultA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterToDefault;          external LibNameLL28DLL index 78;
     {$else}
      function   LlSetPrinterToDefault;          external LibNameLL28DLL name 'LlSetPrinterToDefaultA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterToDefault;          external LibNameLL28DLL index 178;
     {$else}
      function   LlSetPrinterToDefault;          external LibNameLL28DLL name 'LlSetPrinterToDefaultW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterToDefaultW;         external LibNameLL28DLL index 178;
     {$else}
      function   LlSetPrinterToDefaultW;         external LibNameLL28DLL name 'LlSetPrinterToDefaultW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDefineSortOrderStart;         external LibNameLL28DLL index 79;
   {$else}
    function   LlDefineSortOrderStart;         external LibNameLL28DLL name 'LlDefineSortOrderStart';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSortOrderA;             external LibNameLL28DLL index 80;
     {$else}
      function   LlDefineSortOrderA;             external LibNameLL28DLL name 'LlDefineSortOrderA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSortOrder;              external LibNameLL28DLL index 80;
     {$else}
      function   LlDefineSortOrder;              external LibNameLL28DLL name 'LlDefineSortOrderA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSortOrder;              external LibNameLL28DLL index 180;
     {$else}
      function   LlDefineSortOrder;              external LibNameLL28DLL name 'LlDefineSortOrderW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineSortOrderW;             external LibNameLL28DLL index 180;
     {$else}
      function   LlDefineSortOrderW;             external LibNameLL28DLL name 'LlDefineSortOrderW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetSortOrderA;           external LibNameLL28DLL index 81;
     {$else}
      function   LlPrintGetSortOrderA;           external LibNameLL28DLL name 'LlPrintGetSortOrderA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetSortOrder;            external LibNameLL28DLL index 81;
     {$else}
      function   LlPrintGetSortOrder;            external LibNameLL28DLL name 'LlPrintGetSortOrderA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetSortOrder;            external LibNameLL28DLL index 181;
     {$else}
      function   LlPrintGetSortOrder;            external LibNameLL28DLL name 'LlPrintGetSortOrderW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetSortOrderW;           external LibNameLL28DLL index 181;
     {$else}
      function   LlPrintGetSortOrderW;           external LibNameLL28DLL name 'LlPrintGetSortOrderW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineGroupingA;              external LibNameLL28DLL index 82;
     {$else}
      function   LlDefineGroupingA;              external LibNameLL28DLL name 'LlDefineGroupingA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineGrouping;               external LibNameLL28DLL index 82;
     {$else}
      function   LlDefineGrouping;               external LibNameLL28DLL name 'LlDefineGroupingA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineGrouping;               external LibNameLL28DLL index 182;
     {$else}
      function   LlDefineGrouping;               external LibNameLL28DLL name 'LlDefineGroupingW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineGroupingW;              external LibNameLL28DLL index 182;
     {$else}
      function   LlDefineGroupingW;              external LibNameLL28DLL name 'LlDefineGroupingW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetGroupingA;            external LibNameLL28DLL index 83;
     {$else}
      function   LlPrintGetGroupingA;            external LibNameLL28DLL name 'LlPrintGetGroupingA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetGrouping;             external LibNameLL28DLL index 83;
     {$else}
      function   LlPrintGetGrouping;             external LibNameLL28DLL name 'LlPrintGetGroupingA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetGrouping;             external LibNameLL28DLL index 183;
     {$else}
      function   LlPrintGetGrouping;             external LibNameLL28DLL name 'LlPrintGetGroupingW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetGroupingW;            external LibNameLL28DLL index 183;
     {$else}
      function   LlPrintGetGroupingW;            external LibNameLL28DLL name 'LlPrintGetGroupingW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlAddCtlSupportA;               external LibNameLL28DLL index 84;
     {$else}
      function   LlAddCtlSupportA;               external LibNameLL28DLL name 'LlAddCtlSupportA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlAddCtlSupport;                external LibNameLL28DLL index 84;
     {$else}
      function   LlAddCtlSupport;                external LibNameLL28DLL name 'LlAddCtlSupportA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlAddCtlSupport;                external LibNameLL28DLL index 184;
     {$else}
      function   LlAddCtlSupport;                external LibNameLL28DLL name 'LlAddCtlSupportW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlAddCtlSupportW;               external LibNameLL28DLL index 184;
     {$else}
      function   LlAddCtlSupportW;               external LibNameLL28DLL name 'LlAddCtlSupportW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintBeginGroup;              external LibNameLL28DLL index 85;
   {$else}
    function   LlPrintBeginGroup;              external LibNameLL28DLL name 'LlPrintBeginGroup';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintEndGroup;                external LibNameLL28DLL index 86;
   {$else}
    function   LlPrintEndGroup;                external LibNameLL28DLL name 'LlPrintEndGroup';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGroupLine;               external LibNameLL28DLL index 87;
   {$else}
    function   LlPrintGroupLine;               external LibNameLL28DLL name 'LlPrintGroupLine';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGroupHeader;             external LibNameLL28DLL index 88;
   {$else}
    function   LlPrintGroupHeader;             external LibNameLL28DLL name 'LlPrintGroupHeader';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFilterExpressionA;    external LibNameLL28DLL index 89;
     {$else}
      function   LlPrintGetFilterExpressionA;    external LibNameLL28DLL name 'LlPrintGetFilterExpressionA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFilterExpression;     external LibNameLL28DLL index 89;
     {$else}
      function   LlPrintGetFilterExpression;     external LibNameLL28DLL name 'LlPrintGetFilterExpressionA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFilterExpression;     external LibNameLL28DLL index 189;
     {$else}
      function   LlPrintGetFilterExpression;     external LibNameLL28DLL name 'LlPrintGetFilterExpressionW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetFilterExpressionW;    external LibNameLL28DLL index 189;
     {$else}
      function   LlPrintGetFilterExpressionW;    external LibNameLL28DLL name 'LlPrintGetFilterExpressionW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintWillMatchFilter;         external LibNameLL28DLL index 90;
   {$else}
    function   LlPrintWillMatchFilter;         external LibNameLL28DLL name 'LlPrintWillMatchFilter';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintDidMatchFilter;          external LibNameLL28DLL index 91;
   {$else}
    function   LlPrintDidMatchFilter;          external LibNameLL28DLL name 'LlPrintDidMatchFilter';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldContentsA;            external LibNameLL28DLL index 93;
     {$else}
      function   LlGetFieldContentsA;            external LibNameLL28DLL name 'LlGetFieldContentsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldContents;             external LibNameLL28DLL index 93;
     {$else}
      function   LlGetFieldContents;             external LibNameLL28DLL name 'LlGetFieldContentsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldContents;             external LibNameLL28DLL index 193;
     {$else}
      function   LlGetFieldContents;             external LibNameLL28DLL name 'LlGetFieldContentsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldContentsW;            external LibNameLL28DLL index 193;
     {$else}
      function   LlGetFieldContentsW;            external LibNameLL28DLL name 'LlGetFieldContentsW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableContentsA;         external LibNameLL28DLL index 92;
     {$else}
      function   LlGetVariableContentsA;         external LibNameLL28DLL name 'LlGetVariableContentsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableContents;          external LibNameLL28DLL index 92;
     {$else}
      function   LlGetVariableContents;          external LibNameLL28DLL name 'LlGetVariableContentsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableContents;          external LibNameLL28DLL index 192;
     {$else}
      function   LlGetVariableContents;          external LibNameLL28DLL name 'LlGetVariableContentsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableContentsW;         external LibNameLL28DLL index 192;
     {$else}
      function   LlGetVariableContentsW;         external LibNameLL28DLL name 'LlGetVariableContentsW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetSumVariableContentsA;      external LibNameLL28DLL index 94;
     {$else}
      function   LlGetSumVariableContentsA;      external LibNameLL28DLL name 'LlGetSumVariableContentsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetSumVariableContents;       external LibNameLL28DLL index 94;
     {$else}
      function   LlGetSumVariableContents;       external LibNameLL28DLL name 'LlGetSumVariableContentsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetSumVariableContents;       external LibNameLL28DLL index 194;
     {$else}
      function   LlGetSumVariableContents;       external LibNameLL28DLL name 'LlGetSumVariableContentsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetSumVariableContentsW;      external LibNameLL28DLL index 194;
     {$else}
      function   LlGetSumVariableContentsW;      external LibNameLL28DLL name 'LlGetSumVariableContentsW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUserVariableContentsA;     external LibNameLL28DLL index 95;
     {$else}
      function   LlGetUserVariableContentsA;     external LibNameLL28DLL name 'LlGetUserVariableContentsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUserVariableContents;      external LibNameLL28DLL index 95;
     {$else}
      function   LlGetUserVariableContents;      external LibNameLL28DLL name 'LlGetUserVariableContentsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUserVariableContents;      external LibNameLL28DLL index 195;
     {$else}
      function   LlGetUserVariableContents;      external LibNameLL28DLL name 'LlGetUserVariableContentsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUserVariableContentsW;     external LibNameLL28DLL index 195;
     {$else}
      function   LlGetUserVariableContentsW;     external LibNameLL28DLL name 'LlGetUserVariableContentsW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableTypeA;             external LibNameLL28DLL index 96;
     {$else}
      function   LlGetVariableTypeA;             external LibNameLL28DLL name 'LlGetVariableTypeA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableType;              external LibNameLL28DLL index 96;
     {$else}
      function   LlGetVariableType;              external LibNameLL28DLL name 'LlGetVariableTypeA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableType;              external LibNameLL28DLL index 196;
     {$else}
      function   LlGetVariableType;              external LibNameLL28DLL name 'LlGetVariableTypeW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetVariableTypeW;             external LibNameLL28DLL index 196;
     {$else}
      function   LlGetVariableTypeW;             external LibNameLL28DLL name 'LlGetVariableTypeW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldTypeA;                external LibNameLL28DLL index 97;
     {$else}
      function   LlGetFieldTypeA;                external LibNameLL28DLL name 'LlGetFieldTypeA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldType;                 external LibNameLL28DLL index 97;
     {$else}
      function   LlGetFieldType;                 external LibNameLL28DLL name 'LlGetFieldTypeA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldType;                 external LibNameLL28DLL index 197;
     {$else}
      function   LlGetFieldType;                 external LibNameLL28DLL name 'LlGetFieldTypeW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetFieldTypeW;                external LibNameLL28DLL index 197;
     {$else}
      function   LlGetFieldTypeW;                external LibNameLL28DLL name 'LlGetFieldTypeW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetColumnInfoA;          external LibNameLL28DLL index 99;
     {$else}
      function   LlPrintGetColumnInfoA;          external LibNameLL28DLL name 'LlPrintGetColumnInfoA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetColumnInfo;           external LibNameLL28DLL index 99;
     {$else}
      function   LlPrintGetColumnInfo;           external LibNameLL28DLL name 'LlPrintGetColumnInfoA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetColumnInfo;           external LibNameLL28DLL index 199;
     {$else}
      function   LlPrintGetColumnInfo;           external LibNameLL28DLL name 'LlPrintGetColumnInfoW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetColumnInfoW;          external LibNameLL28DLL index 199;
     {$else}
      function   LlPrintGetColumnInfoW;          external LibNameLL28DLL name 'LlPrintGetColumnInfoW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterDefaultsDirA;       external LibNameLL28DLL index 200;
     {$else}
      function   LlSetPrinterDefaultsDirA;       external LibNameLL28DLL name 'LlSetPrinterDefaultsDirA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterDefaultsDir;        external LibNameLL28DLL index 200;
     {$else}
      function   LlSetPrinterDefaultsDir;        external LibNameLL28DLL name 'LlSetPrinterDefaultsDirA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterDefaultsDir;        external LibNameLL28DLL index 300;
     {$else}
      function   LlSetPrinterDefaultsDir;        external LibNameLL28DLL name 'LlSetPrinterDefaultsDirW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterDefaultsDirW;       external LibNameLL28DLL index 300;
     {$else}
      function   LlSetPrinterDefaultsDirW;       external LibNameLL28DLL name 'LlSetPrinterDefaultsDirW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlCreateSketchA;                external LibNameLL28DLL index 201;
     {$else}
      function   LlCreateSketchA;                external LibNameLL28DLL name 'LlCreateSketchA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlCreateSketch;                 external LibNameLL28DLL index 201;
     {$else}
      function   LlCreateSketch;                 external LibNameLL28DLL name 'LlCreateSketchA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlCreateSketch;                 external LibNameLL28DLL index 301;
     {$else}
      function   LlCreateSketch;                 external LibNameLL28DLL name 'LlCreateSketchW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlCreateSketchW;                external LibNameLL28DLL index 301;
     {$else}
      function   LlCreateSketchW;                external LibNameLL28DLL name 'LlCreateSketchW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlViewerProhibitAction;         external LibNameLL28DLL index 202;
   {$else}
    function   LlViewerProhibitAction;         external LibNameLL28DLL name 'LlViewerProhibitAction';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintCopyPrinterConfigurationA;   external LibNameLL28DLL index 203;
     {$else}
      function   LlPrintCopyPrinterConfigurationA;   external LibNameLL28DLL name 'LlPrintCopyPrinterConfigurationA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintCopyPrinterConfiguration;  external LibNameLL28DLL index 203;
     {$else}
      function   LlPrintCopyPrinterConfiguration;  external LibNameLL28DLL name 'LlPrintCopyPrinterConfigurationA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintCopyPrinterConfiguration;  external LibNameLL28DLL index 303;
     {$else}
      function   LlPrintCopyPrinterConfiguration;  external LibNameLL28DLL name 'LlPrintCopyPrinterConfigurationW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintCopyPrinterConfigurationW;   external LibNameLL28DLL index 303;
     {$else}
      function   LlPrintCopyPrinterConfigurationW;   external LibNameLL28DLL name 'LlPrintCopyPrinterConfigurationW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterInPrinterFileA;     external LibNameLL28DLL index 204;
     {$else}
      function   LlSetPrinterInPrinterFileA;     external LibNameLL28DLL name 'LlSetPrinterInPrinterFileA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterInPrinterFile;      external LibNameLL28DLL index 204;
     {$else}
      function   LlSetPrinterInPrinterFile;      external LibNameLL28DLL name 'LlSetPrinterInPrinterFileA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterInPrinterFile;      external LibNameLL28DLL index 304;
     {$else}
      function   LlSetPrinterInPrinterFile;      external LibNameLL28DLL name 'LlSetPrinterInPrinterFileW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetPrinterInPrinterFileW;     external LibNameLL28DLL index 304;
     {$else}
      function   LlSetPrinterInPrinterFileW;     external LibNameLL28DLL name 'LlSetPrinterInPrinterFileW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFCreateObject;              external LibNameLL28DLL index 228;
   {$else}
    function   LlRTFCreateObject;              external LibNameLL28DLL name 'LlRTFCreateObject';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFDeleteObject;              external LibNameLL28DLL index 229;
   {$else}
    function   LlRTFDeleteObject;              external LibNameLL28DLL name 'LlRTFDeleteObject';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextA;                  external LibNameLL28DLL index 230;
     {$else}
      function   LlRTFSetTextA;                  external LibNameLL28DLL name 'LlRTFSetTextA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetText;                   external LibNameLL28DLL index 230;
     {$else}
      function   LlRTFSetText;                   external LibNameLL28DLL name 'LlRTFSetTextA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetText;                   external LibNameLL28DLL index 330;
     {$else}
      function   LlRTFSetText;                   external LibNameLL28DLL name 'LlRTFSetTextW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextW;                  external LibNameLL28DLL index 330;
     {$else}
      function   LlRTFSetTextW;                  external LibNameLL28DLL name 'LlRTFSetTextW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFGetTextLength;             external LibNameLL28DLL index 231;
   {$else}
    function   LlRTFGetTextLength;             external LibNameLL28DLL name 'LlRTFGetTextLength';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFGetTextA;                  external LibNameLL28DLL index 232;
     {$else}
      function   LlRTFGetTextA;                  external LibNameLL28DLL name 'LlRTFGetTextA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFGetText;                   external LibNameLL28DLL index 232;
     {$else}
      function   LlRTFGetText;                   external LibNameLL28DLL name 'LlRTFGetTextA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFGetText;                   external LibNameLL28DLL index 332;
     {$else}
      function   LlRTFGetText;                   external LibNameLL28DLL name 'LlRTFGetTextW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFGetTextW;                  external LibNameLL28DLL index 332;
     {$else}
      function   LlRTFGetTextW;                  external LibNameLL28DLL name 'LlRTFGetTextW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFEditObject;                external LibNameLL28DLL index 233;
   {$else}
    function   LlRTFEditObject;                external LibNameLL28DLL name 'LlRTFEditObject';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFCopyToClipboard;           external LibNameLL28DLL index 234;
   {$else}
    function   LlRTFCopyToClipboard;           external LibNameLL28DLL name 'LlRTFCopyToClipboard';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFDisplay;                   external LibNameLL28DLL index 235;
   {$else}
    function   LlRTFDisplay;                   external LibNameLL28DLL name 'LlRTFDisplay';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFEditorProhibitAction;      external LibNameLL28DLL index 109;
   {$else}
    function   LlRTFEditorProhibitAction;      external LibNameLL28DLL name 'LlRTFEditorProhibitAction';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFEditorInvokeAction;        external LibNameLL28DLL index 117;
   {$else}
    function   LlRTFEditorInvokeAction;        external LibNameLL28DLL name 'LlRTFEditorInvokeAction';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlDebugOutputA;                 external LibNameLL28DLL index 240;
     {$else}
      procedure  LlDebugOutputA;                 external LibNameLL28DLL name 'LlDebugOutputA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlDebugOutput;                  external LibNameLL28DLL index 240;
     {$else}
      procedure  LlDebugOutput;                  external LibNameLL28DLL name 'LlDebugOutputA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlDebugOutput;                  external LibNameLL28DLL index 440;
     {$else}
      procedure  LlDebugOutput;                  external LibNameLL28DLL name 'LlDebugOutputW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      procedure  LlDebugOutputW;                 external LibNameLL28DLL index 440;
     {$else}
      procedure  LlDebugOutputW;                 external LibNameLL28DLL name 'LlDebugOutputW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlEnumGetFirstVar;              external LibNameLL28DLL index 241;
   {$else}
    function   LlEnumGetFirstVar;              external LibNameLL28DLL name 'LlEnumGetFirstVar';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlEnumGetFirstField;            external LibNameLL28DLL index 242;
   {$else}
    function   LlEnumGetFirstField;            external LibNameLL28DLL name 'LlEnumGetFirstField';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlEnumGetFirstConstant;         external LibNameLL28DLL index 493;
   {$else}
    function   LlEnumGetFirstConstant;         external LibNameLL28DLL name 'LlEnumGetFirstConstant';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlEnumGetNextEntry;             external LibNameLL28DLL index 243;
   {$else}
    function   LlEnumGetNextEntry;             external LibNameLL28DLL name 'LlEnumGetNextEntry';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlEnumGetEntryA;                external LibNameLL28DLL index 244;
     {$else}
      function   LlEnumGetEntryA;                external LibNameLL28DLL name 'LlEnumGetEntryA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlEnumGetEntry;                 external LibNameLL28DLL index 244;
     {$else}
      function   LlEnumGetEntry;                 external LibNameLL28DLL name 'LlEnumGetEntryA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlEnumGetEntry;                 external LibNameLL28DLL index 344;
     {$else}
      function   LlEnumGetEntry;                 external LibNameLL28DLL name 'LlEnumGetEntryW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlEnumGetEntryW;                external LibNameLL28DLL index 344;
     {$else}
      function   LlEnumGetEntryW;                external LibNameLL28DLL name 'LlEnumGetEntryW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintResetObjectStates;       external LibNameLL28DLL index 245;
   {$else}
    function   LlPrintResetObjectStates;       external LibNameLL28DLL name 'LlPrintResetObjectStates';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetParameterA;               external LibNameLL28DLL index 246;
     {$else}
      function   LlXSetParameterA;               external LibNameLL28DLL name 'LlXSetParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetParameter;                external LibNameLL28DLL index 246;
     {$else}
      function   LlXSetParameter;                external LibNameLL28DLL name 'LlXSetParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetParameter;                external LibNameLL28DLL index 446;
     {$else}
      function   LlXSetParameter;                external LibNameLL28DLL name 'LlXSetParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetParameterW;               external LibNameLL28DLL index 446;
     {$else}
      function   LlXSetParameterW;               external LibNameLL28DLL name 'LlXSetParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetParameterA;               external LibNameLL28DLL index 247;
     {$else}
      function   LlXGetParameterA;               external LibNameLL28DLL name 'LlXGetParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetParameter;                external LibNameLL28DLL index 247;
     {$else}
      function   LlXGetParameter;                external LibNameLL28DLL name 'LlXGetParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetParameter;                external LibNameLL28DLL index 347;
     {$else}
      function   LlXGetParameter;                external LibNameLL28DLL name 'LlXGetParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetParameterW;               external LibNameLL28DLL index 347;
     {$else}
      function   LlXGetParameterW;               external LibNameLL28DLL name 'LlXGetParameterW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintResetProjectState;       external LibNameLL28DLL index 248;
   {$else}
    function   LlPrintResetProjectState;       external LibNameLL28DLL name 'LlPrintResetProjectState';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlDefineChartFieldStart;        external LibNameLL28DLL index 2;
   {$else}
    procedure  LlDefineChartFieldStart;        external LibNameLL28DLL name 'LlDefineChartFieldStart';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldExtA;         external LibNameLL28DLL index 3;
     {$else}
      function   LlDefineChartFieldExtA;         external LibNameLL28DLL name 'LlDefineChartFieldExtA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldExt;          external LibNameLL28DLL index 3;
     {$else}
      function   LlDefineChartFieldExt;          external LibNameLL28DLL name 'LlDefineChartFieldExtA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldExt;          external LibNameLL28DLL index 103;
     {$else}
      function   LlDefineChartFieldExt;          external LibNameLL28DLL name 'LlDefineChartFieldExtW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldExtW;         external LibNameLL28DLL index 103;
     {$else}
      function   LlDefineChartFieldExtW;         external LibNameLL28DLL name 'LlDefineChartFieldExtW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintDeclareChartRow;         external LibNameLL28DLL index 4;
   {$else}
    function   LlPrintDeclareChartRow;         external LibNameLL28DLL name 'LlPrintDeclareChartRow';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintGetChartObjectCount;     external LibNameLL28DLL index 6;
   {$else}
    function   LlPrintGetChartObjectCount;     external LibNameLL28DLL name 'LlPrintGetChartObjectCount';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsChartFieldUsedA;       external LibNameLL28DLL index 5;
     {$else}
      function   LlPrintIsChartFieldUsedA;       external LibNameLL28DLL name 'LlPrintIsChartFieldUsedA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsChartFieldUsed;        external LibNameLL28DLL index 5;
     {$else}
      function   LlPrintIsChartFieldUsed;        external LibNameLL28DLL name 'LlPrintIsChartFieldUsedA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsChartFieldUsed;        external LibNameLL28DLL index 105;
     {$else}
      function   LlPrintIsChartFieldUsed;        external LibNameLL28DLL name 'LlPrintIsChartFieldUsedW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintIsChartFieldUsedW;       external LibNameLL28DLL index 105;
     {$else}
      function   LlPrintIsChartFieldUsedW;       external LibNameLL28DLL name 'LlPrintIsChartFieldUsedW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetChartFieldContentsA;       external LibNameLL28DLL index 8;
     {$else}
      function   LlGetChartFieldContentsA;       external LibNameLL28DLL name 'LlGetChartFieldContentsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetChartFieldContents;        external LibNameLL28DLL index 8;
     {$else}
      function   LlGetChartFieldContents;        external LibNameLL28DLL name 'LlGetChartFieldContentsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetChartFieldContents;        external LibNameLL28DLL index 106;
     {$else}
      function   LlGetChartFieldContents;        external LibNameLL28DLL name 'LlGetChartFieldContentsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetChartFieldContentsW;       external LibNameLL28DLL index 106;
     {$else}
      function   LlGetChartFieldContentsW;       external LibNameLL28DLL name 'LlGetChartFieldContentsW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlEnumGetFirstChartField;       external LibNameLL28DLL index 9;
   {$else}
    function   LlEnumGetFirstChartField;       external LibNameLL28DLL name 'LlEnumGetFirstChartField';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSetNotificationCallbackExt;   external LibNameLL28DLL index 100;
   {$else}
    function   LlSetNotificationCallbackExt;   external LibNameLL28DLL name 'LlSetNotificationCallbackExt';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprEvaluateVar;              external LibNameLL28DLL index 111;
   {$else}
    function   LlExprEvaluateVar;              external LibNameLL28DLL name 'LlExprEvaluateVar';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprTypeVar;                  external LibNameLL28DLL index 112;
   {$else}
    function   LlExprTypeVar;                  external LibNameLL28DLL name 'LlExprTypeVar';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetPrinterFromPrinterFileA;   external LibNameLL28DLL index 98;
     {$else}
      function   LlGetPrinterFromPrinterFileA;   external LibNameLL28DLL name 'LlGetPrinterFromPrinterFileA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetPrinterFromPrinterFile;    external LibNameLL28DLL index 98;
     {$else}
      function   LlGetPrinterFromPrinterFile;    external LibNameLL28DLL name 'LlGetPrinterFromPrinterFileA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetPrinterFromPrinterFile;    external LibNameLL28DLL index 198;
     {$else}
      function   LlGetPrinterFromPrinterFile;    external LibNameLL28DLL name 'LlGetPrinterFromPrinterFileW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetPrinterFromPrinterFileW;   external LibNameLL28DLL index 198;
     {$else}
      function   LlGetPrinterFromPrinterFileW;   external LibNameLL28DLL name 'LlGetPrinterFromPrinterFileW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingSpacePerTableA;    external LibNameLL28DLL index 102;
     {$else}
      function   LlPrintGetRemainingSpacePerTableA;    external LibNameLL28DLL name 'LlPrintGetRemainingSpacePerTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingSpacePerTable;   external LibNameLL28DLL index 102;
     {$else}
      function   LlPrintGetRemainingSpacePerTable;   external LibNameLL28DLL name 'LlPrintGetRemainingSpacePerTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingSpacePerTable;   external LibNameLL28DLL index 302;
     {$else}
      function   LlPrintGetRemainingSpacePerTable;   external LibNameLL28DLL name 'LlPrintGetRemainingSpacePerTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetRemainingSpacePerTableW;    external LibNameLL28DLL index 302;
     {$else}
      function   LlPrintGetRemainingSpacePerTableW;    external LibNameLL28DLL name 'LlPrintGetRemainingSpacePerTableW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlDrawToolbarBackground;        external LibNameLL28DLL index 104;
   {$else}
    procedure  LlDrawToolbarBackground;        external LibNameLL28DLL name 'LlDrawToolbarBackground';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetDefaultProjectParameterA;  external LibNameLL28DLL index 108;
     {$else}
      function   LlSetDefaultProjectParameterA;  external LibNameLL28DLL name 'LlSetDefaultProjectParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetDefaultProjectParameter;   external LibNameLL28DLL index 108;
     {$else}
      function   LlSetDefaultProjectParameter;   external LibNameLL28DLL name 'LlSetDefaultProjectParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetDefaultProjectParameter;   external LibNameLL28DLL index 308;
     {$else}
      function   LlSetDefaultProjectParameter;   external LibNameLL28DLL name 'LlSetDefaultProjectParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlSetDefaultProjectParameterW;  external LibNameLL28DLL index 308;
     {$else}
      function   LlSetDefaultProjectParameterW;  external LibNameLL28DLL name 'LlSetDefaultProjectParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultProjectParameterA;  external LibNameLL28DLL index 110;
     {$else}
      function   LlGetDefaultProjectParameterA;  external LibNameLL28DLL name 'LlGetDefaultProjectParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultProjectParameter;   external LibNameLL28DLL index 110;
     {$else}
      function   LlGetDefaultProjectParameter;   external LibNameLL28DLL name 'LlGetDefaultProjectParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultProjectParameter;   external LibNameLL28DLL index 310;
     {$else}
      function   LlGetDefaultProjectParameter;   external LibNameLL28DLL name 'LlGetDefaultProjectParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultProjectParameterW;  external LibNameLL28DLL index 310;
     {$else}
      function   LlGetDefaultProjectParameterW;  external LibNameLL28DLL name 'LlGetDefaultProjectParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetProjectParameterA;    external LibNameLL28DLL index 113;
     {$else}
      function   LlPrintSetProjectParameterA;    external LibNameLL28DLL name 'LlPrintSetProjectParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetProjectParameter;     external LibNameLL28DLL index 113;
     {$else}
      function   LlPrintSetProjectParameter;     external LibNameLL28DLL name 'LlPrintSetProjectParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetProjectParameter;     external LibNameLL28DLL index 313;
     {$else}
      function   LlPrintSetProjectParameter;     external LibNameLL28DLL name 'LlPrintSetProjectParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintSetProjectParameterW;    external LibNameLL28DLL index 313;
     {$else}
      function   LlPrintSetProjectParameterW;    external LibNameLL28DLL name 'LlPrintSetProjectParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetProjectParameterA;    external LibNameLL28DLL index 114;
     {$else}
      function   LlPrintGetProjectParameterA;    external LibNameLL28DLL name 'LlPrintGetProjectParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetProjectParameter;     external LibNameLL28DLL index 114;
     {$else}
      function   LlPrintGetProjectParameter;     external LibNameLL28DLL name 'LlPrintGetProjectParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetProjectParameter;     external LibNameLL28DLL index 314;
     {$else}
      function   LlPrintGetProjectParameter;     external LibNameLL28DLL name 'LlPrintGetProjectParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintGetProjectParameterW;    external LibNameLL28DLL index 314;
     {$else}
      function   LlPrintGetProjectParameterW;    external LibNameLL28DLL name 'LlPrintGetProjectParameterW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlCreateObject;                 external LibNameLL28DLL index 115;
   {$else}
    function   LlCreateObject;                 external LibNameLL28DLL name 'LlCreateObject';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprContainsVariableA;        external LibNameLL28DLL index 7;
     {$else}
      function   LlExprContainsVariableA;        external LibNameLL28DLL name 'LlExprContainsVariableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprContainsVariable;         external LibNameLL28DLL index 7;
     {$else}
      function   LlExprContainsVariable;         external LibNameLL28DLL name 'LlExprContainsVariableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprContainsVariable;         external LibNameLL28DLL index 107;
     {$else}
      function   LlExprContainsVariable;         external LibNameLL28DLL name 'LlExprContainsVariableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprContainsVariableW;        external LibNameLL28DLL index 107;
     {$else}
      function   LlExprContainsVariableW;        external LibNameLL28DLL name 'LlExprContainsVariableW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprIsConstant;               external LibNameLL28DLL index 116;
   {$else}
    function   LlExprIsConstant;               external LibNameLL28DLL name 'LlExprIsConstant';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProfileStartA;                external LibNameLL28DLL index 136;
     {$else}
      function   LlProfileStartA;                external LibNameLL28DLL name 'LlProfileStartA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProfileStart;                 external LibNameLL28DLL index 136;
     {$else}
      function   LlProfileStart;                 external LibNameLL28DLL name 'LlProfileStartA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProfileStart;                 external LibNameLL28DLL index 336;
     {$else}
      function   LlProfileStart;                 external LibNameLL28DLL name 'LlProfileStartW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProfileStartW;                external LibNameLL28DLL index 336;
     {$else}
      function   LlProfileStartW;                external LibNameLL28DLL name 'LlProfileStartW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlProfileEnd;                   external LibNameLL28DLL index 137;
   {$else}
    procedure  LlProfileEnd;                   external LibNameLL28DLL name 'LlProfileEnd';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlDumpMemory;                   external LibNameLL28DLL index 138;
   {$else}
    procedure  LlDumpMemory;                   external LibNameLL28DLL name 'LlDumpMemory';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableA;                  external LibNameLL28DLL index 139;
     {$else}
      function   LlDbAddTableA;                  external LibNameLL28DLL name 'LlDbAddTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTable;                   external LibNameLL28DLL index 139;
     {$else}
      function   LlDbAddTable;                   external LibNameLL28DLL name 'LlDbAddTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTable;                   external LibNameLL28DLL index 339;
     {$else}
      function   LlDbAddTable;                   external LibNameLL28DLL name 'LlDbAddTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableW;                  external LibNameLL28DLL index 339;
     {$else}
      function   LlDbAddTableW;                  external LibNameLL28DLL name 'LlDbAddTableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationA;          external LibNameLL28DLL index 140;
     {$else}
      function   LlDbAddTableRelationA;          external LibNameLL28DLL name 'LlDbAddTableRelationA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelation;           external LibNameLL28DLL index 140;
     {$else}
      function   LlDbAddTableRelation;           external LibNameLL28DLL name 'LlDbAddTableRelationA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelation;           external LibNameLL28DLL index 340;
     {$else}
      function   LlDbAddTableRelation;           external LibNameLL28DLL name 'LlDbAddTableRelationW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationW;          external LibNameLL28DLL index 340;
     {$else}
      function   LlDbAddTableRelationW;          external LibNameLL28DLL name 'LlDbAddTableRelationW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderA;         external LibNameLL28DLL index 141;
     {$else}
      function   LlDbAddTableSortOrderA;         external LibNameLL28DLL name 'LlDbAddTableSortOrderA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrder;          external LibNameLL28DLL index 141;
     {$else}
      function   LlDbAddTableSortOrder;          external LibNameLL28DLL name 'LlDbAddTableSortOrderA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrder;          external LibNameLL28DLL index 341;
     {$else}
      function   LlDbAddTableSortOrder;          external LibNameLL28DLL name 'LlDbAddTableSortOrderW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderW;         external LibNameLL28DLL index 341;
     {$else}
      function   LlDbAddTableSortOrderW;         external LibNameLL28DLL name 'LlDbAddTableSortOrderW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableA;      external LibNameLL28DLL index 142;
     {$else}
      function   LlPrintDbGetCurrentTableA;      external LibNameLL28DLL name 'LlPrintDbGetCurrentTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTable;       external LibNameLL28DLL index 142;
     {$else}
      function   LlPrintDbGetCurrentTable;       external LibNameLL28DLL name 'LlPrintDbGetCurrentTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTable;       external LibNameLL28DLL index 342;
     {$else}
      function   LlPrintDbGetCurrentTable;       external LibNameLL28DLL name 'LlPrintDbGetCurrentTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableW;      external LibNameLL28DLL index 342;
     {$else}
      function   LlPrintDbGetCurrentTableW;      external LibNameLL28DLL name 'LlPrintDbGetCurrentTableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableRelationA;    external LibNameLL28DLL index 143;
     {$else}
      function   LlPrintDbGetCurrentTableRelationA;    external LibNameLL28DLL name 'LlPrintDbGetCurrentTableRelationA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableRelation;   external LibNameLL28DLL index 143;
     {$else}
      function   LlPrintDbGetCurrentTableRelation;   external LibNameLL28DLL name 'LlPrintDbGetCurrentTableRelationA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableRelation;   external LibNameLL28DLL index 343;
     {$else}
      function   LlPrintDbGetCurrentTableRelation;   external LibNameLL28DLL name 'LlPrintDbGetCurrentTableRelationW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableRelationW;    external LibNameLL28DLL index 343;
     {$else}
      function   LlPrintDbGetCurrentTableRelationW;    external LibNameLL28DLL name 'LlPrintDbGetCurrentTableRelationW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableSortOrderA;     external LibNameLL28DLL index 146;
     {$else}
      function   LlPrintDbGetCurrentTableSortOrderA;     external LibNameLL28DLL name 'LlPrintDbGetCurrentTableSortOrderA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableSortOrder;    external LibNameLL28DLL index 146;
     {$else}
      function   LlPrintDbGetCurrentTableSortOrder;    external LibNameLL28DLL name 'LlPrintDbGetCurrentTableSortOrderA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableSortOrder;    external LibNameLL28DLL index 346;
     {$else}
      function   LlPrintDbGetCurrentTableSortOrder;    external LibNameLL28DLL name 'LlPrintDbGetCurrentTableSortOrderW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlPrintDbGetCurrentTableSortOrderW;     external LibNameLL28DLL index 346;
     {$else}
      function   LlPrintDbGetCurrentTableSortOrderW;     external LibNameLL28DLL name 'LlPrintDbGetCurrentTableSortOrderW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDbDumpStructure;              external LibNameLL28DLL index 149;
   {$else}
    function   LlDbDumpStructure;              external LibNameLL28DLL name 'LlDbDumpStructure';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintDbGetRootTableCount;     external LibNameLL28DLL index 151;
   {$else}
    function   LlPrintDbGetRootTableCount;     external LibNameLL28DLL name 'LlPrintDbGetRootTableCount';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbSetMasterTableA;            external LibNameLL28DLL index 152;
     {$else}
      function   LlDbSetMasterTableA;            external LibNameLL28DLL name 'LlDbSetMasterTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbSetMasterTable;             external LibNameLL28DLL index 152;
     {$else}
      function   LlDbSetMasterTable;             external LibNameLL28DLL name 'LlDbSetMasterTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbSetMasterTable;             external LibNameLL28DLL index 352;
     {$else}
      function   LlDbSetMasterTable;             external LibNameLL28DLL name 'LlDbSetMasterTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbSetMasterTableW;            external LibNameLL28DLL index 352;
     {$else}
      function   LlDbSetMasterTableW;            external LibNameLL28DLL name 'LlDbSetMasterTableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbGetMasterTableA;            external LibNameLL28DLL index 157;
     {$else}
      function   LlDbGetMasterTableA;            external LibNameLL28DLL name 'LlDbGetMasterTableA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbGetMasterTable;             external LibNameLL28DLL index 157;
     {$else}
      function   LlDbGetMasterTable;             external LibNameLL28DLL name 'LlDbGetMasterTableA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbGetMasterTable;             external LibNameLL28DLL index 357;
     {$else}
      function   LlDbGetMasterTable;             external LibNameLL28DLL name 'LlDbGetMasterTableW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbGetMasterTableW;            external LibNameLL28DLL index 357;
     {$else}
      function   LlDbGetMasterTableW;            external LibNameLL28DLL name 'LlDbGetMasterTableW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetExportParameterA;         external LibNameLL28DLL index 158;
     {$else}
      function   LlXSetExportParameterA;         external LibNameLL28DLL name 'LlXSetExportParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetExportParameter;          external LibNameLL28DLL index 158;
     {$else}
      function   LlXSetExportParameter;          external LibNameLL28DLL name 'LlXSetExportParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetExportParameter;          external LibNameLL28DLL index 358;
     {$else}
      function   LlXSetExportParameter;          external LibNameLL28DLL name 'LlXSetExportParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXSetExportParameterW;         external LibNameLL28DLL index 358;
     {$else}
      function   LlXSetExportParameterW;         external LibNameLL28DLL name 'LlXSetExportParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetExportParameterA;         external LibNameLL28DLL index 160;
     {$else}
      function   LlXGetExportParameterA;         external LibNameLL28DLL name 'LlXGetExportParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetExportParameter;          external LibNameLL28DLL index 160;
     {$else}
      function   LlXGetExportParameter;          external LibNameLL28DLL name 'LlXGetExportParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetExportParameter;          external LibNameLL28DLL index 360;
     {$else}
      function   LlXGetExportParameter;          external LibNameLL28DLL name 'LlXGetExportParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXGetExportParameterW;         external LibNameLL28DLL index 360;
     {$else}
      function   LlXGetExportParameterW;         external LibNameLL28DLL name 'LlXGetExportParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXlatNameA;                    external LibNameLL28DLL index 164;
     {$else}
      function   LlXlatNameA;                    external LibNameLL28DLL name 'LlXlatNameA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXlatName;                     external LibNameLL28DLL index 164;
     {$else}
      function   LlXlatName;                     external LibNameLL28DLL name 'LlXlatNameA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXlatName;                     external LibNameLL28DLL index 364;
     {$else}
      function   LlXlatName;                     external LibNameLL28DLL name 'LlXlatNameW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlXlatNameW;                    external LibNameLL28DLL index 364;
     {$else}
      function   LlXlatNameW;                    external LibNameLL28DLL name 'LlXlatNameW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableVarA;           external LibNameLL28DLL index 165;
     {$else}
      function   LlDefineVariableVarA;           external LibNameLL28DLL name 'LlDefineVariableVarA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableVar;            external LibNameLL28DLL index 165;
     {$else}
      function   LlDefineVariableVar;            external LibNameLL28DLL name 'LlDefineVariableVarA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableVar;            external LibNameLL28DLL index 365;
     {$else}
      function   LlDefineVariableVar;            external LibNameLL28DLL name 'LlDefineVariableVarW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineVariableVarW;           external LibNameLL28DLL index 365;
     {$else}
      function   LlDefineVariableVarW;           external LibNameLL28DLL name 'LlDefineVariableVarW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldVarA;              external LibNameLL28DLL index 170;
     {$else}
      function   LlDefineFieldVarA;              external LibNameLL28DLL name 'LlDefineFieldVarA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldVar;               external LibNameLL28DLL index 170;
     {$else}
      function   LlDefineFieldVar;               external LibNameLL28DLL name 'LlDefineFieldVarA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldVar;               external LibNameLL28DLL index 370;
     {$else}
      function   LlDefineFieldVar;               external LibNameLL28DLL name 'LlDefineFieldVarW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineFieldVarW;              external LibNameLL28DLL index 370;
     {$else}
      function   LlDefineFieldVarW;              external LibNameLL28DLL name 'LlDefineFieldVarW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldVarA;         external LibNameLL28DLL index 179;
     {$else}
      function   LlDefineChartFieldVarA;         external LibNameLL28DLL name 'LlDefineChartFieldVarA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldVar;          external LibNameLL28DLL index 179;
     {$else}
      function   LlDefineChartFieldVar;          external LibNameLL28DLL name 'LlDefineChartFieldVarA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldVar;          external LibNameLL28DLL index 379;
     {$else}
      function   LlDefineChartFieldVar;          external LibNameLL28DLL name 'LlDefineChartFieldVarW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDefineChartFieldVarW;         external LibNameLL28DLL index 379;
     {$else}
      function   LlDefineChartFieldVarW;         external LibNameLL28DLL name 'LlDefineChartFieldVarW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitEditingObjectA;   external LibNameLL28DLL index 185;
     {$else}
      function   LlDesignerProhibitEditingObjectA;   external LibNameLL28DLL name 'LlDesignerProhibitEditingObjectA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitEditingObject;  external LibNameLL28DLL index 185;
     {$else}
      function   LlDesignerProhibitEditingObject;  external LibNameLL28DLL name 'LlDesignerProhibitEditingObjectA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitEditingObject;  external LibNameLL28DLL index 385;
     {$else}
      function   LlDesignerProhibitEditingObject;  external LibNameLL28DLL name 'LlDesignerProhibitEditingObjectW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerProhibitEditingObjectW;   external LibNameLL28DLL index 385;
     {$else}
      function   LlDesignerProhibitEditingObjectW;   external LibNameLL28DLL name 'LlDesignerProhibitEditingObjectW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersA;          external LibNameLL28DLL index 186;
     {$else}
      function   LlGetUsedIdentifiersA;          external LibNameLL28DLL name 'LlGetUsedIdentifiersA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiers;           external LibNameLL28DLL index 186;
     {$else}
      function   LlGetUsedIdentifiers;           external LibNameLL28DLL name 'LlGetUsedIdentifiersA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiers;           external LibNameLL28DLL index 386;
     {$else}
      function   LlGetUsedIdentifiers;           external LibNameLL28DLL name 'LlGetUsedIdentifiersW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersW;          external LibNameLL28DLL index 386;
     {$else}
      function   LlGetUsedIdentifiersW;          external LibNameLL28DLL name 'LlGetUsedIdentifiersW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsExA;           external LibNameLL28DLL index 205;
     {$else}
      function   LlExprGetUsedVarsExA;           external LibNameLL28DLL name 'LlExprGetUsedVarsExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsEx;            external LibNameLL28DLL index 205;
     {$else}
      function   LlExprGetUsedVarsEx;            external LibNameLL28DLL name 'LlExprGetUsedVarsExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsEx;            external LibNameLL28DLL index 405;
     {$else}
      function   LlExprGetUsedVarsEx;            external LibNameLL28DLL name 'LlExprGetUsedVarsExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedVarsExW;           external LibNameLL28DLL index 405;
     {$else}
      function   LlExprGetUsedVarsExW;           external LibNameLL28DLL name 'LlExprGetUsedVarsExW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetProject;                external LibNameLL28DLL index 206;
   {$else}
    function   LlDomGetProject;                external LibNameLL28DLL name 'LlDomGetProject';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetPropertyA;              external LibNameLL28DLL index 207;
     {$else}
      function   LlDomGetPropertyA;              external LibNameLL28DLL name 'LlDomGetPropertyA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetProperty;               external LibNameLL28DLL index 207;
     {$else}
      function   LlDomGetProperty;               external LibNameLL28DLL name 'LlDomGetPropertyA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetProperty;               external LibNameLL28DLL index 407;
     {$else}
      function   LlDomGetProperty;               external LibNameLL28DLL name 'LlDomGetPropertyW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetPropertyW;              external LibNameLL28DLL index 407;
     {$else}
      function   LlDomGetPropertyW;              external LibNameLL28DLL name 'LlDomGetPropertyW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomSetPropertyA;              external LibNameLL28DLL index 208;
     {$else}
      function   LlDomSetPropertyA;              external LibNameLL28DLL name 'LlDomSetPropertyA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomSetProperty;               external LibNameLL28DLL index 208;
     {$else}
      function   LlDomSetProperty;               external LibNameLL28DLL name 'LlDomSetPropertyA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomSetProperty;               external LibNameLL28DLL index 408;
     {$else}
      function   LlDomSetProperty;               external LibNameLL28DLL name 'LlDomSetPropertyW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomSetPropertyW;              external LibNameLL28DLL index 408;
     {$else}
      function   LlDomSetPropertyW;              external LibNameLL28DLL name 'LlDomSetPropertyW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetObjectA;                external LibNameLL28DLL index 209;
     {$else}
      function   LlDomGetObjectA;                external LibNameLL28DLL name 'LlDomGetObjectA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetObject;                 external LibNameLL28DLL index 209;
     {$else}
      function   LlDomGetObject;                 external LibNameLL28DLL name 'LlDomGetObjectA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetObject;                 external LibNameLL28DLL index 409;
     {$else}
      function   LlDomGetObject;                 external LibNameLL28DLL name 'LlDomGetObjectW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomGetObjectW;                external LibNameLL28DLL index 409;
     {$else}
      function   LlDomGetObjectW;                external LibNameLL28DLL name 'LlDomGetObjectW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetSubobjectCount;         external LibNameLL28DLL index 210;
   {$else}
    function   LlDomGetSubobjectCount;         external LibNameLL28DLL name 'LlDomGetSubobjectCount';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetSubobject;              external LibNameLL28DLL index 211;
   {$else}
    function   LlDomGetSubobject;              external LibNameLL28DLL name 'LlDomGetSubobject';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomCreateSubobjectA;          external LibNameLL28DLL index 212;
     {$else}
      function   LlDomCreateSubobjectA;          external LibNameLL28DLL name 'LlDomCreateSubobjectA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomCreateSubobject;           external LibNameLL28DLL index 212;
     {$else}
      function   LlDomCreateSubobject;           external LibNameLL28DLL name 'LlDomCreateSubobjectA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomCreateSubobject;           external LibNameLL28DLL index 412;
     {$else}
      function   LlDomCreateSubobject;           external LibNameLL28DLL name 'LlDomCreateSubobjectW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDomCreateSubobjectW;          external LibNameLL28DLL index 412;
     {$else}
      function   LlDomCreateSubobjectW;          external LibNameLL28DLL name 'LlDomCreateSubobjectW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomDeleteSubobject;           external LibNameLL28DLL index 213;
   {$else}
    function   LlDomDeleteSubobject;           external LibNameLL28DLL name 'LlDomDeleteSubobject';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomMoveSubobject;             external LibNameLL28DLL index 348;
   {$else}
    function   LlDomMoveSubobject;             external LibNameLL28DLL name 'LlDomMoveSubobject';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectOpenA;                 external LibNameLL28DLL index 214;
     {$else}
      function   LlProjectOpenA;                 external LibNameLL28DLL name 'LlProjectOpenA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectOpen;                  external LibNameLL28DLL index 214;
     {$else}
      function   LlProjectOpen;                  external LibNameLL28DLL name 'LlProjectOpenA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectOpen;                  external LibNameLL28DLL index 414;
     {$else}
      function   LlProjectOpen;                  external LibNameLL28DLL name 'LlProjectOpenW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectOpenW;                 external LibNameLL28DLL index 414;
     {$else}
      function   LlProjectOpenW;                 external LibNameLL28DLL name 'LlProjectOpenW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveA;                 external LibNameLL28DLL index 215;
     {$else}
      function   LlProjectSaveA;                 external LibNameLL28DLL name 'LlProjectSaveA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSave;                  external LibNameLL28DLL index 215;
     {$else}
      function   LlProjectSave;                  external LibNameLL28DLL name 'LlProjectSaveA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSave;                  external LibNameLL28DLL index 415;
     {$else}
      function   LlProjectSave;                  external LibNameLL28DLL name 'LlProjectSaveW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveW;                 external LibNameLL28DLL index 415;
     {$else}
      function   LlProjectSaveW;                 external LibNameLL28DLL name 'LlProjectSaveW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveCopyAsA;           external LibNameLL28DLL index 361;
     {$else}
      function   LlProjectSaveCopyAsA;           external LibNameLL28DLL name 'LlProjectSaveCopyAsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveCopyAs;            external LibNameLL28DLL index 361;
     {$else}
      function   LlProjectSaveCopyAs;            external LibNameLL28DLL name 'LlProjectSaveCopyAsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveCopyAs;            external LibNameLL28DLL index 460;
     {$else}
      function   LlProjectSaveCopyAs;            external LibNameLL28DLL name 'LlProjectSaveCopyAsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlProjectSaveCopyAsW;           external LibNameLL28DLL index 460;
     {$else}
      function   LlProjectSaveCopyAsW;           external LibNameLL28DLL name 'LlProjectSaveCopyAsW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlProjectClose;                 external LibNameLL28DLL index 216;
   {$else}
    function   LlProjectClose;                 external LibNameLL28DLL name 'LlProjectClose';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetPropertyCount;          external LibNameLL28DLL index 350;
   {$else}
    function   LlDomGetPropertyCount;          external LibNameLL28DLL name 'LlDomGetPropertyCount';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlAssociatePreviewControl;      external LibNameLL28DLL index 218;
   {$else}
    function   LlAssociatePreviewControl;      external LibNameLL28DLL name 'LlAssociatePreviewControl';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetErrortextA;                external LibNameLL28DLL index 219;
     {$else}
      function   LlGetErrortextA;                external LibNameLL28DLL name 'LlGetErrortextA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetErrortext;                 external LibNameLL28DLL index 219;
     {$else}
      function   LlGetErrortext;                 external LibNameLL28DLL name 'LlGetErrortextA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetErrortext;                 external LibNameLL28DLL index 419;
     {$else}
      function   LlGetErrortext;                 external LibNameLL28DLL name 'LlGetErrortextW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetErrortextW;                external LibNameLL28DLL index 419;
     {$else}
      function   LlGetErrortextW;                external LibNameLL28DLL name 'LlGetErrortextW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSetPreviewOption;             external LibNameLL28DLL index 221;
   {$else}
    function   LlSetPreviewOption;             external LibNameLL28DLL name 'LlSetPreviewOption';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetPreviewOption;             external LibNameLL28DLL index 222;
   {$else}
    function   LlGetPreviewOption;             external LibNameLL28DLL name 'LlGetPreviewOption';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerInvokeAction;         external LibNameLL28DLL index 223;
   {$else}
    function   LlDesignerInvokeAction;         external LibNameLL28DLL name 'LlDesignerInvokeAction';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerRefreshWorkspace;     external LibNameLL28DLL index 224;
   {$else}
    function   LlDesignerRefreshWorkspace;     external LibNameLL28DLL name 'LlDesignerRefreshWorkspace';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileOpenA;            external LibNameLL28DLL index 225;
     {$else}
      function   LlDesignerFileOpenA;            external LibNameLL28DLL name 'LlDesignerFileOpenA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileOpen;             external LibNameLL28DLL index 225;
     {$else}
      function   LlDesignerFileOpen;             external LibNameLL28DLL name 'LlDesignerFileOpenA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileOpen;             external LibNameLL28DLL index 425;
     {$else}
      function   LlDesignerFileOpen;             external LibNameLL28DLL name 'LlDesignerFileOpenW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileOpenW;            external LibNameLL28DLL index 425;
     {$else}
      function   LlDesignerFileOpenW;            external LibNameLL28DLL name 'LlDesignerFileOpenW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileSaveA;            external LibNameLL28DLL index 226;
     {$else}
      function   LlDesignerFileSaveA;            external LibNameLL28DLL name 'LlDesignerFileSaveA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileSave;             external LibNameLL28DLL index 226;
     {$else}
      function   LlDesignerFileSave;             external LibNameLL28DLL name 'LlDesignerFileSaveA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileSave;             external LibNameLL28DLL index 426;
     {$else}
      function   LlDesignerFileSave;             external LibNameLL28DLL name 'LlDesignerFileSaveW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerFileSaveW;            external LibNameLL28DLL index 426;
     {$else}
      function   LlDesignerFileSaveW;            external LibNameLL28DLL name 'LlDesignerFileSaveW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerAddActionA;           external LibNameLL28DLL index 227;
     {$else}
      function   LlDesignerAddActionA;           external LibNameLL28DLL name 'LlDesignerAddActionA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerAddAction;            external LibNameLL28DLL index 227;
     {$else}
      function   LlDesignerAddAction;            external LibNameLL28DLL name 'LlDesignerAddActionA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerAddAction;            external LibNameLL28DLL index 427;
     {$else}
      function   LlDesignerAddAction;            external LibNameLL28DLL name 'LlDesignerAddActionW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerAddActionW;           external LibNameLL28DLL index 427;
     {$else}
      function   LlDesignerAddActionW;           external LibNameLL28DLL name 'LlDesignerAddActionW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerGetOptionStringA;     external LibNameLL28DLL index 236;
     {$else}
      function   LlDesignerGetOptionStringA;     external LibNameLL28DLL name 'LlDesignerGetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerGetOptionString;      external LibNameLL28DLL index 236;
     {$else}
      function   LlDesignerGetOptionString;      external LibNameLL28DLL name 'LlDesignerGetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerGetOptionString;      external LibNameLL28DLL index 436;
     {$else}
      function   LlDesignerGetOptionString;      external LibNameLL28DLL name 'LlDesignerGetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerGetOptionStringW;     external LibNameLL28DLL index 436;
     {$else}
      function   LlDesignerGetOptionStringW;     external LibNameLL28DLL name 'LlDesignerGetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerSetOptionStringA;     external LibNameLL28DLL index 237;
     {$else}
      function   LlDesignerSetOptionStringA;     external LibNameLL28DLL name 'LlDesignerSetOptionStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerSetOptionString;      external LibNameLL28DLL index 237;
     {$else}
      function   LlDesignerSetOptionString;      external LibNameLL28DLL name 'LlDesignerSetOptionStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerSetOptionString;      external LibNameLL28DLL index 437;
     {$else}
      function   LlDesignerSetOptionString;      external LibNameLL28DLL name 'LlDesignerSetOptionStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDesignerSetOptionStringW;     external LibNameLL28DLL index 437;
     {$else}
      function   LlDesignerSetOptionStringW;     external LibNameLL28DLL name 'LlDesignerSetOptionStringW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlJobOpenCopy;                  external LibNameLL28DLL index 239;
   {$else}
    function   LlJobOpenCopy;                  external LibNameLL28DLL name 'LlJobOpenCopy';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectParameterA;         external LibNameLL28DLL index 249;
     {$else}
      function   LlGetProjectParameterA;         external LibNameLL28DLL name 'LlGetProjectParameterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectParameter;          external LibNameLL28DLL index 249;
     {$else}
      function   LlGetProjectParameter;          external LibNameLL28DLL name 'LlGetProjectParameterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectParameter;          external LibNameLL28DLL index 449;
     {$else}
      function   LlGetProjectParameter;          external LibNameLL28DLL name 'LlGetProjectParameterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectParameterW;         external LibNameLL28DLL index 449;
     {$else}
      function   LlGetProjectParameterW;         external LibNameLL28DLL name 'LlGetProjectParameterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertBLOBToStringA;         external LibNameLL28DLL index 250;
     {$else}
      function   LlConvertBLOBToStringA;         external LibNameLL28DLL name 'LlConvertBLOBToStringA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertBLOBToString;          external LibNameLL28DLL index 250;
     {$else}
      function   LlConvertBLOBToString;          external LibNameLL28DLL name 'LlConvertBLOBToStringA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertBLOBToString;          external LibNameLL28DLL index 450;
     {$else}
      function   LlConvertBLOBToString;          external LibNameLL28DLL name 'LlConvertBLOBToStringW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertBLOBToStringW;         external LibNameLL28DLL index 450;
     {$else}
      function   LlConvertBLOBToStringW;         external LibNameLL28DLL name 'LlConvertBLOBToStringW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertStringToBLOBA;         external LibNameLL28DLL index 251;
     {$else}
      function   LlConvertStringToBLOBA;         external LibNameLL28DLL name 'LlConvertStringToBLOBA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertStringToBLOB;          external LibNameLL28DLL index 251;
     {$else}
      function   LlConvertStringToBLOB;          external LibNameLL28DLL name 'LlConvertStringToBLOBA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertStringToBLOB;          external LibNameLL28DLL index 451;
     {$else}
      function   LlConvertStringToBLOB;          external LibNameLL28DLL name 'LlConvertStringToBLOBW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlConvertStringToBLOBW;         external LibNameLL28DLL index 451;
     {$else}
      function   LlConvertStringToBLOBW;         external LibNameLL28DLL name 'LlConvertStringToBLOBW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationExA;        external LibNameLL28DLL index 238;
     {$else}
      function   LlDbAddTableRelationExA;        external LibNameLL28DLL name 'LlDbAddTableRelationExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationEx;         external LibNameLL28DLL index 238;
     {$else}
      function   LlDbAddTableRelationEx;         external LibNameLL28DLL name 'LlDbAddTableRelationExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationEx;         external LibNameLL28DLL index 438;
     {$else}
      function   LlDbAddTableRelationEx;         external LibNameLL28DLL name 'LlDbAddTableRelationExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableRelationExW;        external LibNameLL28DLL index 438;
     {$else}
      function   LlDbAddTableRelationExW;        external LibNameLL28DLL name 'LlDbAddTableRelationExW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderExA;       external LibNameLL28DLL index 257;
     {$else}
      function   LlDbAddTableSortOrderExA;       external LibNameLL28DLL name 'LlDbAddTableSortOrderExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderEx;        external LibNameLL28DLL index 257;
     {$else}
      function   LlDbAddTableSortOrderEx;        external LibNameLL28DLL name 'LlDbAddTableSortOrderExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderEx;        external LibNameLL28DLL index 457;
     {$else}
      function   LlDbAddTableSortOrderEx;        external LibNameLL28DLL name 'LlDbAddTableSortOrderExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableSortOrderExW;       external LibNameLL28DLL index 457;
     {$else}
      function   LlDbAddTableSortOrderExW;       external LibNameLL28DLL name 'LlDbAddTableSortOrderExW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersExA;        external LibNameLL28DLL index 258;
     {$else}
      function   LlGetUsedIdentifiersExA;        external LibNameLL28DLL name 'LlGetUsedIdentifiersExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersEx;         external LibNameLL28DLL index 258;
     {$else}
      function   LlGetUsedIdentifiersEx;         external LibNameLL28DLL name 'LlGetUsedIdentifiersExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersEx;         external LibNameLL28DLL index 458;
     {$else}
      function   LlGetUsedIdentifiersEx;         external LibNameLL28DLL name 'LlGetUsedIdentifiersExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetUsedIdentifiersExW;        external LibNameLL28DLL index 458;
     {$else}
      function   LlGetUsedIdentifiersExW;        external LibNameLL28DLL name 'LlGetUsedIdentifiersExW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetTempFileNameA;             external LibNameLL28DLL index 259;
     {$else}
      function   LlGetTempFileNameA;             external LibNameLL28DLL name 'LlGetTempFileNameA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetTempFileName;              external LibNameLL28DLL index 259;
     {$else}
      function   LlGetTempFileName;              external LibNameLL28DLL name 'LlGetTempFileNameA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetTempFileName;              external LibNameLL28DLL index 459;
     {$else}
      function   LlGetTempFileName;              external LibNameLL28DLL name 'LlGetTempFileNameW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetTempFileNameW;             external LibNameLL28DLL index 459;
     {$else}
      function   LlGetTempFileNameW;             external LibNameLL28DLL name 'LlGetTempFileNameW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetDebug;                     external LibNameLL28DLL index 260;
   {$else}
    function   LlGetDebug;                     external LibNameLL28DLL name 'LlGetDebug';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRTFEditorGetRTFControlHandle; external LibNameLL28DLL index 261;
   {$else}
    function   LlRTFEditorGetRTFControlHandle; external LibNameLL28DLL name 'LlRTFEditorGetRTFControlHandle';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultPrinterA;           external LibNameLL28DLL index 262;
     {$else}
      function   LlGetDefaultPrinterA;           external LibNameLL28DLL name 'LlGetDefaultPrinterA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultPrinter;            external LibNameLL28DLL index 262;
     {$else}
      function   LlGetDefaultPrinter;            external LibNameLL28DLL name 'LlGetDefaultPrinterA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultPrinter;            external LibNameLL28DLL index 462;
     {$else}
      function   LlGetDefaultPrinter;            external LibNameLL28DLL name 'LlGetDefaultPrinterW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetDefaultPrinterW;           external LibNameLL28DLL index 462;
     {$else}
      function   LlGetDefaultPrinterW;           external LibNameLL28DLL name 'LlGetDefaultPrinterW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlLocAddDictionaryEntryA;       external LibNameLL28DLL index 263;
     {$else}
      function   LlLocAddDictionaryEntryA;       external LibNameLL28DLL name 'LlLocAddDictionaryEntryA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlLocAddDictionaryEntry;        external LibNameLL28DLL index 263;
     {$else}
      function   LlLocAddDictionaryEntry;        external LibNameLL28DLL name 'LlLocAddDictionaryEntryA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlLocAddDictionaryEntry;        external LibNameLL28DLL index 464;
     {$else}
      function   LlLocAddDictionaryEntry;        external LibNameLL28DLL name 'LlLocAddDictionaryEntryW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlLocAddDictionaryEntryW;       external LibNameLL28DLL index 464;
     {$else}
      function   LlLocAddDictionaryEntryW;       external LibNameLL28DLL name 'LlLocAddDictionaryEntryW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlLocAddDesignLCID;             external LibNameLL28DLL index 264;
   {$else}
    function   LlLocAddDesignLCID;             external LibNameLL28DLL name 'LlLocAddDesignLCID';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlIsUILanguageAvailable;        external LibNameLL28DLL index 265;
   {$else}
    function   LlIsUILanguageAvailable;        external LibNameLL28DLL name 'LlIsUILanguageAvailable';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlIsUILanguageAvailableLCID;    external LibNameLL28DLL index 266;
   {$else}
    function   LlIsUILanguageAvailableLCID;    external LibNameLL28DLL name 'LlIsUILanguageAvailableLCID';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableExA;                external LibNameLL28DLL index 267;
     {$else}
      function   LlDbAddTableExA;                external LibNameLL28DLL name 'LlDbAddTableExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableEx;                 external LibNameLL28DLL index 267;
     {$else}
      function   LlDbAddTableEx;                 external LibNameLL28DLL name 'LlDbAddTableExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableEx;                 external LibNameLL28DLL index 465;
     {$else}
      function   LlDbAddTableEx;                 external LibNameLL28DLL name 'LlDbAddTableExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlDbAddTableExW;                external LibNameLL28DLL index 465;
     {$else}
      function   LlDbAddTableExW;                external LibNameLL28DLL name 'LlDbAddTableExW';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextExA;                external LibNameLL28DLL index 269;
     {$else}
      function   LlRTFSetTextExA;                external LibNameLL28DLL name 'LlRTFSetTextExA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextEx;                 external LibNameLL28DLL index 269;
     {$else}
      function   LlRTFSetTextEx;                 external LibNameLL28DLL name 'LlRTFSetTextExA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextEx;                 external LibNameLL28DLL index 469;
     {$else}
      function   LlRTFSetTextEx;                 external LibNameLL28DLL name 'LlRTFSetTextExW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlRTFSetTextExW;                external LibNameLL28DLL index 469;
     {$else}
      function   LlRTFSetTextExW;                external LibNameLL28DLL name 'LlRTFSetTextExW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlInplaceDesignerInteraction;   external LibNameLL28DLL index 270;
   {$else}
    function   LlInplaceDesignerInteraction;   external LibNameLL28DLL name 'LlInplaceDesignerInteraction';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsAddResourcefilesHGLOBAL; external LibNameLL28DLL index 272;
   {$else}
    function   LlUtilsAddResourcefilesHGLOBAL; external LibNameLL28DLL name 'LlUtilsAddResourcefilesHGLOBAL';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsGetResourceString;       external LibNameLL28DLL index 274;
   {$else}
    function   LlUtilsGetResourceString;       external LibNameLL28DLL name 'LlUtilsGetResourceString';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlGDILockEnter;                 external LibNameLL28DLL index 275;
   {$else}
    procedure  LlGDILockEnter;                 external LibNameLL28DLL name 'LlGDILockEnter';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlGDILockLeave;                 external LibNameLL28DLL index 276;
   {$else}
    procedure  LlGDILockLeave;                 external LibNameLL28DLL name 'LlGDILockLeave';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectDescriptionA;       external LibNameLL28DLL index 280;
     {$else}
      function   LlGetProjectDescriptionA;       external LibNameLL28DLL name 'LlGetProjectDescriptionA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectDescription;        external LibNameLL28DLL index 280;
     {$else}
      function   LlGetProjectDescription;        external LibNameLL28DLL name 'LlGetProjectDescriptionA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectDescription;        external LibNameLL28DLL index 480;
     {$else}
      function   LlGetProjectDescription;        external LibNameLL28DLL name 'LlGetProjectDescriptionW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlGetProjectDescriptionW;       external LibNameLL28DLL index 480;
     {$else}
      function   LlGetProjectDescriptionW;       external LibNameLL28DLL name 'LlGetProjectDescriptionW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlPrintDbGetCurrentTableFilter; external LibNameLL28DLL index 281;
   {$else}
    function   LlPrintDbGetCurrentTableFilter; external LibNameLL28DLL name 'LlPrintDbGetCurrentTableFilter';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprTranslateToHostExpressionA;   external LibNameLL28DLL index 282;
     {$else}
      function   LlExprTranslateToHostExpressionA;   external LibNameLL28DLL name 'LlExprTranslateToHostExpressionA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprTranslateToHostExpression;  external LibNameLL28DLL index 282;
     {$else}
      function   LlExprTranslateToHostExpression;  external LibNameLL28DLL name 'LlExprTranslateToHostExpressionA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprTranslateToHostExpression;  external LibNameLL28DLL index 482;
     {$else}
      function   LlExprTranslateToHostExpression;  external LibNameLL28DLL name 'LlExprTranslateToHostExpressionW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprTranslateToHostExpressionW;   external LibNameLL28DLL index 482;
     {$else}
      function   LlExprTranslateToHostExpressionW;   external LibNameLL28DLL name 'LlExprTranslateToHostExpressionW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobCreate;             external LibNameLL28DLL index 283;
   {$else}
    function   LlStgTestJobCreate;             external LibNameLL28DLL name 'LlStgTestJobCreate';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobCmpPage;            external LibNameLL28DLL index 284;
   {$else}
    function   LlStgTestJobCmpPage;            external LibNameLL28DLL name 'LlStgTestJobCmpPage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobDestroy;            external LibNameLL28DLL index 285;
   {$else}
    function   LlStgTestJobDestroy;            external LibNameLL28DLL name 'LlStgTestJobDestroy';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestStgCmp;                external LibNameLL28DLL index 286;
   {$else}
    function   LlStgTestStgCmp;                external LibNameLL28DLL name 'LlStgTestStgCmp';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    procedure  LlStgTestStgCmpRUNDLL32;        external LibNameLL28DLL index 287;
   {$else}
    procedure  LlStgTestStgCmpRUNDLL32;        external LibNameLL28DLL name 'LlStgTestStgCmpRUNDLL32';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestStgCmp2;               external LibNameLL28DLL index 288;
   {$else}
    function   LlStgTestStgCmp2;               external LibNameLL28DLL name 'LlStgTestStgCmp2';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobCmpEmbeddedStorages;  external LibNameLL28DLL index 311;
   {$else}
    function   LlStgTestJobCmpEmbeddedStorages;  external LibNameLL28DLL name 'LlStgTestJobCmpEmbeddedStorages';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlSRTriggerExport;              external LibNameLL28DLL index 289;
   {$else}
    function   LlSRTriggerExport;              external LibNameLL28DLL name 'LlSRTriggerExport';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsGetVariantFromProfContentsInternal;            external LibNameLL28DLL index 290;
   {$else}
    function   LlUtilsGetVariantFromProfContentsInternal;            external LibNameLL28DLL name 'LlUtilsGetVariantFromProfContentsInternal';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsGetProfContentsFromVariantInternal;            external LibNameLL28DLL index 291;
   {$else}
    function   LlUtilsGetProfContentsFromVariantInternal;            external LibNameLL28DLL name 'LlUtilsGetProfContentsFromVariantInternal';
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedFunctionsA;        external LibNameLL28DLL index 292;
     {$else}
      function   LlExprGetUsedFunctionsA;        external LibNameLL28DLL name 'LlExprGetUsedFunctionsA';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedFunctions;         external LibNameLL28DLL index 292;
     {$else}
      function   LlExprGetUsedFunctions;         external LibNameLL28DLL name 'LlExprGetUsedFunctionsA';
    {$endif}
  {$endif}
  {$ifdef UNICODE}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedFunctions;         external LibNameLL28DLL index 492;
     {$else}
      function   LlExprGetUsedFunctions;         external LibNameLL28DLL name 'LlExprGetUsedFunctionsW';
    {$endif}
  {$else}
    {$ifdef CMLL28_LINK_INDEXED}
      function   LlExprGetUsedFunctionsW;        external LibNameLL28DLL index 492;
     {$else}
      function   LlExprGetUsedFunctionsW;        external LibNameLL28DLL name 'LlExprGetUsedFunctionsW';
    {$endif}
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerTriggerJobInUIThread; external LibNameLL28DLL index 293;
   {$else}
    function   LlDesignerTriggerJobInUIThread; external LibNameLL28DLL name 'LlDesignerTriggerJobInUIThread';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsComparePrinterInformation;   external LibNameLL28DLL index 305;
   {$else}
    function   LlUtilsComparePrinterInformation;   external LibNameLL28DLL name 'LlUtilsComparePrinterInformation';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetUsedIdentifiersExV;        external LibNameLL28DLL index 294;
   {$else}
    function   LlGetUsedIdentifiersExV;        external LibNameLL28DLL name 'LlGetUsedIdentifiersExV';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetPropertyV;              external LibNameLL28DLL index 295;
   {$else}
    function   LlDomGetPropertyV;              external LibNameLL28DLL name 'LlDomGetPropertyV';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprGetUsedFunctionsV;        external LibNameLL28DLL index 296;
   {$else}
    function   LlExprGetUsedFunctionsV;        external LibNameLL28DLL name 'LlExprGetUsedFunctionsV';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprGetUsedVarsExV;           external LibNameLL28DLL index 297;
   {$else}
    function   LlExprGetUsedVarsExV;           external LibNameLL28DLL name 'LlExprGetUsedVarsExV';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetTableRelationToActiveTable;  external LibNameLL28DLL index 298;
   {$else}
    function   LlGetTableRelationToActiveTable;  external LibNameLL28DLL name 'LlGetTableRelationToActiveTable';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlJobOpenCopyEx;                external LibNameLL28DLL index 299;
   {$else}
    function   LlJobOpenCopyEx;                external LibNameLL28DLL name 'LlJobOpenCopyEx';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlAddDebugSinkForThread;        external LibNameLL28DLL index 306;
   {$else}
    function   LlAddDebugSinkForThread;        external LibNameLL28DLL name 'LlAddDebugSinkForThread';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRemoveDebugSinkFromThread;    external LibNameLL28DLL index 307;
   {$else}
    function   LlRemoveDebugSinkFromThread;    external LibNameLL28DLL name 'LlRemoveDebugSinkFromThread';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetDebugSinkProxyModule;      external LibNameLL28DLL index 309;
   {$else}
    function   LlGetDebugSinkProxyModule;      external LibNameLL28DLL name 'LlGetDebugSinkProxyModule';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetDebugSinkProxyCategory;    external LibNameLL28DLL index 315;
   {$else}
    function   LlGetDebugSinkProxyCategory;    external LibNameLL28DLL name 'LlGetDebugSinkProxyCategory';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDlgSelectFileOpen;            external LibNameLL28DLL index 318;
   {$else}
    function   LlDlgSelectFileOpen;            external LibNameLL28DLL name 'LlDlgSelectFileOpen';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsLcidFromLocaleName;      external LibNameLL28DLL index 319;
   {$else}
    function   LlUtilsLcidFromLocaleName;      external LibNameLL28DLL name 'LlUtilsLcidFromLocaleName';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDesignerShowMessage;          external LibNameLL28DLL index 320;
   {$else}
    function   LlDesignerShowMessage;          external LibNameLL28DLL name 'LlDesignerShowMessage';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprConvertGlobalToLocal;     external LibNameLL28DLL index 323;
   {$else}
    function   LlExprConvertGlobalToLocal;     external LibNameLL28DLL name 'LlExprConvertGlobalToLocal';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprConvertLocalToGlobal;     external LibNameLL28DLL index 324;
   {$else}
    function   LlExprConvertLocalToGlobal;     external LibNameLL28DLL name 'LlExprConvertLocalToGlobal';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsGetProjectType;          external LibNameLL28DLL index 325;
   {$else}
    function   LlUtilsGetProjectType;          external LibNameLL28DLL name 'LlUtilsGetProjectType';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlGetLastErrorText;             external LibNameLL28DLL index 327;
   {$else}
    function   LlGetLastErrorText;             external LibNameLL28DLL name 'LlGetLastErrorText';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlDomGetCurrentObject;          external LibNameLL28DLL index 333;
   {$else}
    function   LlDomGetCurrentObject;          external LibNameLL28DLL name 'LlDomGetCurrentObject';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlUtilsIDFromOrgID;             external LibNameLL28DLL index 334;
   {$else}
    function   LlUtilsIDFromOrgID;             external LibNameLL28DLL name 'LlUtilsIDFromOrgID';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlProjectFindAndReplace;        external LibNameLL28DLL index 312;
   {$else}
    function   LlProjectFindAndReplace;        external LibNameLL28DLL name 'LlProjectFindAndReplace';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprParseQueryDelayedDefine;  external LibNameLL28DLL index 338;
   {$else}
    function   LlExprParseQueryDelayedDefine;  external LibNameLL28DLL name 'LlExprParseQueryDelayedDefine';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprTypeMask;                 external LibNameLL28DLL index 345;
   {$else}
    function   LlExprTypeMask;                 external LibNameLL28DLL name 'LlExprTypeMask';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobCmpEmbeddedStorages2;   external LibNameLL28DLL index 367;
   {$else}
    function   LlStgTestJobCmpEmbeddedStorages2;   external LibNameLL28DLL name 'LlStgTestJobCmpEmbeddedStorages2';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgTestJobAddResultJobs;      external LibNameLL28DLL index 349;
   {$else}
    function   LlStgTestJobAddResultJobs;      external LibNameLL28DLL name 'LlStgTestJobAddResultJobs';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlStgCreateFrom;                external LibNameLL28DLL index 391;
   {$else}
    function   LlStgCreateFrom;                external LibNameLL28DLL name 'LlStgCreateFrom';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlRemoveIdentifier;             external LibNameLL28DLL index 392;
   {$else}
    function   LlRemoveIdentifier;             external LibNameLL28DLL name 'LlRemoveIdentifier';
  {$endif}
  {$ifdef CMLL28_LINK_INDEXED}
    function   LlExprParseEx;                  external LibNameLL28DLL index 393;
   {$else}
    function   LlExprParseEx;                  external LibNameLL28DLL name 'LlExprParseEx';
  {$endif}

begin
end.
