(* Pascal/Delphi runtime linkage constants and function definitions for LS28.DLL *)
(*  (c) combit GmbH *)
(*  [build of 2023-01-09 20:01:16] *)

unit cmbtLS28x;

(* --- remarks: -----------------------------------------------------
- define USE_UNICODE_DLL to use the Unicode version of the DLL
- define UNICODE to use the Unicode functions by default
- define CMLS28_LINK_INDEXED to use the indexed import (faster)
*)

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

  _PCRECT                        = ^tRect;
  _PRECT                         = ^tRect;
  HLLSTG                         = lParam;
  HSTG                           = lParam;
  HLSJOB                         = lParam;
  PHGLOBAL                       = ^tHandle;
  HLSCNVJOB                      = lParam;
  HLSMAILJOB                     = lParam;
  _LPCWORD                       = ^word;
  PINT_PTR                       = ^integer;
  PVARIANT                       = ^VARIANT;
  PCVARIANT                      = ^VARIANT;
  PSTREAM                        = ^IStream;
  _PCENHMETARECORD               = ^ENHMETARECORD;
  PPSTREAM                       = ^PSTREAM;


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
  LL_STGSYS_VERSION_LL18         = 2;
                    (* Internal use only *)
  LL_ERR_STG_NOSTORAGE           = -1000;
  LL_ERR_STG_BADVERSION          = -1001;
  LL_ERR_STG_READ                = -1002;
  LL_ERR_STG_WRITE               = -1003;
  LL_ERR_STG_UNKNOWNSYSTEM       = -1004;
  LL_ERR_STG_BADHANDLE           = -1005;
  LL_ERR_STG_ENDOFLIST           = -1006;
  LL_ERR_STG_BADJOB              = -1007;
  LL_ERR_STG_ACCESSDENIED        = -1008;
  LL_ERR_STG_BADSTORAGE          = -1009;
  LL_ERR_STG_CANNOTGETMETAFILE   = -1010;
  LL_ERR_STG_OUTOFMEMORY         = -1011;
  LL_ERR_STG_SEND_FAILED         = -1012;
  LL_ERR_STG_DOWNLOAD_PENDING    = -1013;
  LL_ERR_STG_DOWNLOAD_FAILED     = -1014;
  LL_ERR_STG_WRITE_FAILED        = -1015;
  LL_ERR_STG_UNEXPECTED          = -1016;
  LL_ERR_STG_CANNOTCREATEFILE    = -1017;
  LL_ERR_STG_UNKNOWN_CONVERTER   = -1018;
  LL_ERR_STG_INET_ERROR          = -1019;
  LL_ERR_STG_NOTFOUND            = -1020;
  LL_ERR_STG_SEND_FAILED_NEED_OAUTH2_TOKEN = -1021;
  LL_WRN_STG_UNFAXED_PAGES       = -1100;
  LS_OPTION_HAS16BITPAGES        = 200;
                    (* has job 16 bit pages? *)
  LS_OPTION_BOXTYPE              = 201;
                    (* wait meter box type *)
  LS_OPTION_UNITS                = 203;
                    (* LL_UNITS_INCH_DIV_100 or LL_UNITS_MM_DIV_10 *)
  LS_OPTION_PRINTERCOUNT         = 204;
                    (* number of printers (1 or 2) *)
  LS_OPTION_ISSTORAGE            = 205;
                    (* returns whether file is STORAGE or COMPAT4 *)
  LS_OPTION_EMFRESOLUTION        = 206;
                    (* EMFRESOLUTION used to print the file *)
  LS_OPTION_JOB                  = 207;
                    (* returns current job number *)
  LS_OPTION_TOTALPAGES           = 208;
                    (* differs from GetPageCount() if print range in effect *)
  LS_OPTION_PAGESWITHFAXNUMBER   = 209;
  LS_OPTION_HASINPUTOBJECTS      = 210;
  LS_OPTION_HASFORCEDINPUTOBJECTS = 211;
  LS_OPTION_INPUTOBJECTSFINISHED = 212;
  LS_OPTION_HASHYPERLINKS        = 213;
  LS_OPTION_USED_PRINTERCOUNT    = 214;
                    (* count of printers actually used (compares DEVMODEs etc) *)
  LS_OPTION_JOB_GTC_COUNT        = 215;
                    (* returns number of GTC pages, use this for each job, not with bOneJobTranslation *)
  LS_OPTION_PRINT_OPTIMIZE_PRINTERS = 216;
                    (* need to be in job 0, r/o *)
  LS_OPTION_PAGENUMBER           = 0;
                    (* page number of current page *)
  LS_OPTION_COPIES               = 1;
                    (* number of copies (same for all pages at the moment) *)
  LS_OPTION_PRN_ORIENTATION      = 2;
                    (* orientation (DMORIENT_LANDSCAPE, DMORIENT_PORTRAIT) *)
  LS_OPTION_PHYSPAGE             = 3;
                    (* is page "physical page" oriented? *)
  LS_OPTION_PRN_PIXELSOFFSET_X   = 4;
                    (* this and the following values are *)
  LS_OPTION_PRN_PIXELSOFFSET_Y   = 5;
                    (* values of the printer that the preview was *)
  LS_OPTION_PRN_PIXELS_X         = 6;
                    (* created on! *)
  LS_OPTION_PRN_PIXELS_Y         = 7;
  LS_OPTION_PRN_PIXELSPHYSICAL_X = 8;
  LS_OPTION_PRN_PIXELSPHYSICAL_Y = 9;
  LS_OPTION_PRN_PIXELSPERINCH_X  = 10;
  LS_OPTION_PRN_PIXELSPERINCH_Y  = 11;
  LS_OPTION_PRN_INDEX            = 12;
                    (* printer index of the page (0/1) *)
  LS_OPTION_PRN_PAPERTYPE        = 13;
  LS_OPTION_PRN_PAPERSIZE_X      = 14;
  LS_OPTION_PRN_PAPERSIZE_Y      = 15;
  LS_OPTION_PRN_FORCE_PAPERSIZE  = 16;
  LS_OPTION_STARTNEWSHEET        = 17;
  LS_OPTION_ISSUEINDEX           = 18;
  LS_OPTION_STARTNEWJOB          = 19;
  LS_OPTION_PAGETYPE             = 20;
                    (* 0=normal, 1=GTC *)
  LS_OPTION_CONBINATIONPRINT_INDEX = 21;
                    (* r/o *)
  LS_OPTION_CONBINATIONPRINT_COUNT = 22;
                    (* r/o *)
  LS_OPTION_PROJECTNAME          = 100;
                    (* name of the original project (not page dependent) *)
  LS_OPTION_JOBNAME              = 101;
                    (* name of the job (WindowTitle of LlPrintWithBoxStart()) (not page dependent) *)
  LS_OPTION_PRTNAME              = 102;
                    (* deprecated! *)
  LS_OPTION_PRTDEVICE            = 103;
                    (* printer device ("HP Laserjet 4L") *)
  LS_OPTION_PRTPORT              = 104;
                    (* deprecated! *)
  LS_OPTION_USER                 = 105;
                    (* user string (not page dependent) *)
  LS_OPTION_CREATION             = 106;
                    (* creation date (not page dependent) *)
  LS_OPTION_CREATIONAPP          = 107;
                    (* creation application (not page dependent) *)
  LS_OPTION_CREATIONDLL          = 108;
                    (* creation DLL (not page dependent) *)
  LS_OPTION_CREATIONUSER         = 109;
                    (* creation user and computer name (not page dependent) *)
  LS_OPTION_FAXPARA_QUEUE        = 110;
                    (* NYI *)
  LS_OPTION_FAXPARA_RECIPNAME    = 111;
                    (* NYI *)
  LS_OPTION_FAXPARA_RECIPNUMBER  = 112;
                    (* NYI *)
  LS_OPTION_FAXPARA_SENDERNAME   = 113;
                    (* NYI *)
  LS_OPTION_FAXPARA_SENDERCOMPANY = 114;
                    (* NYI *)
  LS_OPTION_FAXPARA_SENDERDEPT   = 115;
                    (* NYI *)
  LS_OPTION_FAXPARA_SENDERBILLINGCODE = 116;
                    (* NYI *)
  LS_OPTION_FAX_AVAILABLEQUEUES  = 118;
                    (* NYI, nPageIndex=1 *)
  LS_OPTION_PRINTERALIASLIST     = 119;
                    (* alternative printer list (taken from project) *)
  LS_OPTION_PRTDEVMODE           = 120;
                    (* r/o, DEVMODEW structure, to be used with the LlConvertXxxx API *)
  LS_OPTION_USED_PRTDEVICE       = 121;
                    (* r/o, printer name that would actually be used *)
  LS_OPTION_USED_PRTDEVMODE      = 122;
                    (* r/o, DEVMODEW structure, to be used with the LlConvertXxxx API *)
  LS_OPTION_REGIONNAME           = 123;
                    (* r/o *)
  LS_OPTION_CONBINATIONPRINT_PROJECT = 126;
                    (* r/o *)
  LS_OPTION_CONBINATIONPRINT_DESCRIPTION = 127;
                    (* r/o *)
  LS_PRINTFLAG_FIT               = $00000001;
  LS_PRINTFLAG_STACKEDCOPIES     = $00000002;
                    (* n times page1, n times page2, ... (else n times (page 1...x)) *)
  LS_PRINTFLAG_TRYPRINTERCOPIES  = $00000004;
                    (* first try printer copies, then simulated ones... *)
  LS_PRINTFLAG_SHOWDIALOG        = $00000008;
  LS_PRINTFLAG_METER             = $00000010;
  LS_PRINTFLAG_ABORTABLEMETER    = $00000020;
  LS_PRINTFLAG_METERMASK         = $00000070;
                    (* allows 7 styles of abort boxes... *)
  LS_PRINTFLAG_USEDEFPRINTERIFNULL = $00000080;
  LS_PRINTFLAG_FAX               = $00000100;
  LS_PRINTFLAG_OVERRIDEPROJECTCOPYCOUNT = $00000200;
  LS_PRINTFLAG_IGNORE_PROJECT_TRAY = $00010000;
  LS_PRINTFLAG_IGNORE_PROJECT_DUPLEX = $00020000;
  LS_PRINTFLAG_IGNORE_PROJECT_COLLATION = $00040000;
  LS_PRINTFLAG_IGNORE_PROJECT_EXTRADATA = $00080000;
  LS_PRINTFLAG_IGNORE_JOBMARKER  = $00100000;
  LS_VIEWERCONTROL_QUERY_CHARWIDTH = 1;
                    (* sent in wParam using LsGetViewerControlDefaultMessage() (return: 1 for SBCS, 2 for Unicode) *)
  LS_VIEWERCONTROL_CLEAR         = WM_USER+1;
  LS_VIEWERCONTROL_SET_HANDLE_EX = WM_USER+2;
                    (* wParam = HANDLE (NULL for RELEASE), lParam = internal struct handle; *)
  LS_VIEWERCONTROL_SET_HANDLE    = WM_USER+3;
                    (* wParam = HANDLE (NULL for RELEASE) *)
  LS_VIEWERCONTROLSETHANDLEFLAG_ADD = $0100;
  LS_VIEWERCONTROLSETHANDLEFLAG_DELETE_ON_CLOSE = $0200;
  LS_VIEWERCONTROL_GET_HANDLE    = WM_USER+4;
                    (* lParam = HANDLE (NULL for none) *)
  LS_VIEWERCONTROL_SET_FILENAME  = WM_USER+5;
                    (* lParam = LPCTSTR pszFilename (NULL for RELEASE), wParam = options *)
  LS_STGFILEOPEN_READONLY        = $00000000;
  LS_STGFILEOPEN_READWRITE       = $00000001;
  LS_STGFILEOPEN_FORCE_NO_READWRITE = $00000002;
                    (* never open read-write, even if formula elements are present! *)
  LS_STGFILEOPEN_DELETE_ON_CLOSE = $00000004;
  LS_STGFILEOPENFLAG_ADD         = $00000100;
  LS_VIEWERCONTROL_SET_OPTION    = WM_USER+6;
  LS_OPTION_MESSAGE              = 0;
                    (* communication message *)
  LS_OPTION_PRINTERASSIGNMENT    = 1;
                    (* set BEFORE setting the storage handle/filename! *)
  LS_PRNASSIGNMENT_USEDEFAULT    = $00000000;
  LS_PRNASSIGNMENT_ASKPRINTERIFNEEDED = $00000001;
  LS_PRNASSIGNMENT_ASKPRINTERALWAYS = $00000002;
  LS_PRNASSIGNMENT_ALWAYSUSEDEFAULT = $00000003;
                    (* default *)
  LS_OPTION_TOOLBAR              = 2;
                    (* TRUE to force viewer control to display a toolbar, FALSE otherwise (def: FALSE) *)
  LS_OPTION_SKETCHBAR            = 3;
                    (* TRUE to force viewer control to display a sketch bar (def: TRUE) *)
  LS_OPTION_SKETCHBARWIDTH       = 4;
                    (* TRUE to force viewer control to display a sketch bar (def: 50) *)
  LS_OPTION_TOOLBARSTYLE         = 5;
                    (* default: LS_OPTION_TOOLBARSTYLE_STANDARD, set BEFORE LS_OPTION_TOOLBAR to TRUE! *)
  LS_OPTION_TOOLBARSTYLE_STANDARD = 0;
                    (* OFFICE97 alike style *)
  LS_OPTION_TOOLBARSTYLE_OFFICEXP = 1;
                    (* DOTNET/OFFICE_XP alike style *)
  LS_OPTION_TOOLBARSTYLE_OFFICE2003 = 2;
  LS_OPTION_TOOLBARSTYLEMASK     = $0f;
  LS_OPTION_TOOLBARSTYLEFLAG_GRADIENT = $80;
                    (* starting with XP, use gradient style *)
  LS_OPTION_CODEPAGE             = 7;
                    (* lParam = codepage for MBCS aware string operations - set it if the system default is not applicable *)
  LS_OPTION_SAVEASFILEPATH       = 8;
                    (* w/o, lParam = "SaveAs" default filename (LPCTSTR!) *)
  LS_OPTION_USERDATA             = 9;
                    (* for LS_VIEWERCONTROL_SET_NTFYCALLBACK *)
  LS_OPTION_BGCOLOR              = 10;
                    (* background color *)
  LS_OPTION_ASYNC_DOWNLOAD       = 11;
                    (* download is ASYNC (def: TRUE) *)
  LS_OPTION_LANGUAGE             = 12;
                    (* CMBTLANG_xxx or -1 for ThreadLocale *)
  LS_OPTION_ASSUME_TEMPFILE      = 13;
                    (* viewer assumes that the LL file is a temp file, so data can not be saved into it *)
  LS_OPTION_IOLECLIENTSITE       = 14;
                    (* internal use *)
  LS_OPTION_TOOLTIPS             = 15;
                    (* lParam = flag value *)
  LS_OPTION_AUTOSAVE             = 16;
                    (* lParam = (BOOL)bAutoSave *)
  LS_OPTION_CHANGEDFLAG          = 17;
                    (* lParam = flag value *)
  LS_OPTION_SHOW_UNPRINTABLE_AREA = 18;
                    (* lParam = flags, default: FALSE *)
  LS_OPTION_NOUIRESET            = 19;
                    (* lParam = flags, default: TRUE *)
  LS_OPTION_NAVIGATIONBAR        = 20;
                    (* TRUE to force viewer control to display a sketch bar (def: TRUE) *)
  LS_OPTION_NAVIGATIONBARWIDTH   = 21;
                    (* TRUE to force viewer control to display a sketch bar (def: 50) *)
  LS_OPTION_IN_PREVIEWPANE       = 22;
                    (* TRUE to disable unneeded message boxes *)
  LS_OPTION_IN_LLVIEWER          = 23;
                    (* internal *)
  LS_OPTION_TABBARSTYLE          = 24;
  LS_OPTION_TABBARSTYLE_STANDARD = 0;
  LS_OPTION_TABBARSTYLE_OFFICEXP = 1;
  LS_OPTION_TABBARSTYLE_OFFICE2003 = 2;
  LS_OPTION_DESIGNERPREVIEW      = 25;
  LS_OPTION_MOUSEMODE            = 26;
  LS_OPTION_MOUSEMODE_MOVE       = 1;
  LS_OPTION_MOUSEMODE_ZOOM       = 2;
  LS_OPTION_MOUSEMODE_SELECT     = 3;
  LS_OPTION_MOUSEMODE_WAIT       = 4;
  LS_OPTION_ALLOW_RBUTTONUSAGE   = 27;
                    (* default: true *)
  LS_OPTION_TOOLBGCOLOR          = 28;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE = 29;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE_AREAFILL_SYSTEM = 0;
                    (* system theming (fixed colors, fixed rounding) *)
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE_AREAFILL_WIN7ALIKE = 1;
                    (* like Windows 7 theming (fixed colors, fixed rounding) *)
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE_AREAFILL = 2;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_TYPE_FRAME = 3;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_HEIGHT_PX = 30;
                    (* default: 5 *)
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_WIDTH_PX = 31;
                    (* default: 5 *)
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FILLCOLOR_ARGB = 32;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FILLCOLORHIGHLIGHTED_ARGB = 33;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FRAMECOLOR_ARGB = 34;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_FRAMECOLORHIGHLIGHTED_ARGB = 35;
  LS_OPTION_PAGEITEM_SELECTED_ITEM_FRAME_ROUNDED_CORNER_PX = 36;
                    (* default: 5 *)
  LS_OPTION_PAGEITEM_DROPSHADOW  = 37;
  LS_OPTION_PAGEITEM_DROPSHADOW_NONE = 0;
  LS_OPTION_PAGEITEM_DROPSHADOW_ONLY_NONSELECTED = 1;
  LS_OPTION_PAGEITEM_PAGENUMBER  = 38;
                    (* default: true (>=LS24) *)
  LS_OPTION_SKETCHBAR_BGCOLOR    = 39;
                    (* default: ::GetSysColor(COLOR_WINDOW) *)
  LS_VIEWERCONTROL_GET_OPTION    = WM_USER+7;
  LS_VIEWERCONTROL_QUERY_ENDSESSION = WM_USER+8;
  LS_VIEWERCONTROL_GET_ZOOM      = WM_USER+9;
  LS_VIEWERCONTROL_SET_ZOOM      = WM_USER+10;
                    (* wParam = factor (lParam = 1 if in percent) *)
  LS_VIEWERCONTROL_GET_ZOOMED    = WM_USER+11;
                    (* TRUE if zoomed *)
  LS_VIEWERCONTROL_POP_ZOOM      = WM_USER+12;
  LS_VIEWERCONTROL_RESET_ZOOM    = WM_USER+13;
  LS_VIEWERCONTROL_SET_ZOOM_TWICE = WM_USER+14;
  LS_VIEWERCONTROL_SET_PAGE      = WM_USER+20;
                    (* wParam = page# (0..n-1) *)
  LS_VIEWERCONTROL_GET_PAGE      = WM_USER+21;
                    (* wParam = 0: currently selected page, wParam = 1: currently viewed top page in right pane *)
  LS_VIEWERCONTROL_GET_PAGECOUNT = WM_USER+22;
  LS_VIEWERCONTROL_GET_PAGECOUNT_FAXPAGES = WM_USER+23;
  LS_VIEWERCONTROL_GET_JOB       = WM_USER+24;
  LS_VIEWERCONTROL_GET_JOBPAGEINDEX = WM_USER+25;
  LS_VIEWERCONTROL_GET_METAFILE  = WM_USER+26;
                    (* wParam = page#, for IMMEDIATE use (will be released by LS DLL at some undefined time!) *)
  LS_VIEWERCONTROL_GET_ENABLED   = WM_USER+27;
                    (* wParam = ID *)
  LS_VCITEM_SEARCH_FIRST         = 0;
  LS_VCITEM_SEARCH_NEXT          = 1;
  LS_VCITEM_SEARCH_OPTS          = 2;
  LS_VCITEM_SEARCHACTIONMASK     = $00000fff;
  LS_VCITEM_SEARCHFLAG_CASEINSENSITIVE = $00008000;
  LS_VCITEM_SEARCHFLAG_UTF16     = $00004000;
  LS_VCITEM_SEARCHFLAGMASK       = $fffff000;
  LS_VCITEM_SAVE_AS_FILE         = 3;
  LS_VCITEM_SEND_AS_MAIL         = 4;
  LS_VCITEM_SEND_AS_FAX          = 5;
  LS_VCITEM_PRINT_ONE            = 6;
  LS_VCITEM_PRINT_ALL            = 7;
  LS_VCITEM_PAGENUMBER           = 8;
  LS_VCITEM_ZOOM                 = 9;
  LS_VCITEM_THEATERMODE          = 10;
  LS_VCITEM_PREVSTG              = 11;
  LS_VCITEM_NEXTSTG              = 12;
  LS_VCITEM_SEARCH_DONE          = 13;
  LS_VCITEM_FIRSTPAGE            = 14;
  LS_VCITEM_NEXTPAGE             = 15;
  LS_VCITEM_PREVIOUSPAGE         = 16;
  LS_VCITEM_LASTPAGE             = 17;
  LS_VCITEM_MOUSEMODE_MOVE       = 18;
  LS_VCITEM_MOUSEMODE_ZOOM       = 19;
  LS_VCITEM_MOUSEMODE_SELECT     = 20;
  LS_VIEWERCONTROL_GET_SEARCHSTATE = WM_USER+28;
                    (* returns TRUE if search in progress *)
  LS_VIEWERCONTROL_SEARCH        = WM_USER+29;
                    (* wParam = LS_VCITEM_SEARCH_Xxxx enum, OR'ed optionally with LS_VCITEM_SEARCHFLAG_CASEINSENSITIVE, lParam=SearchText in control's charset flavour (ANSI/UNICODE) (NULL or empty to stop) *)
  LS_VIEWERCONTROL_SEARCHDLGACTIVE = WM_USER+30;
                    (* returns HANDLE to common search dialog if it is currently being shown, otherwise NULL *)
  LS_VIEWERCONTROL_PRINT_CURRENT = WM_USER+31;
                    (* wParam = 0 (default printer), 1 (with printer selection) *)
  LS_VIEWERCONTROL_PRINT_ALL     = WM_USER+32;
                    (* wParam = 0 (default printer), 1 (with printer selection) *)
  LS_VIEWERCONTROL_PRINT_TO_FAX  = WM_USER+33;
  LS_VIEWERCONTROL_UPDATE_TOOLBAR = WM_USER+35;
                    (* if LS_OPTION_TOOLBAR is TRUE *)
  LS_VIEWERCONTROL_GET_TOOLBAR   = WM_USER+36;
                    (* if LS_OPTION_TOOLBAR is TRUE, returns window handle of toolbar *)
  LS_VIEWERCONTROL_SAVE_TO_FILE  = WM_USER+37;
                    (* if lParam is non-NULL, it is the export type ID *)
  LS_VIEWERCONTROL_SEND_AS_MAIL  = WM_USER+39;
  LS_VIEWERCONTROL_SET_OPTIONSTR = WM_USER+40;
                    (* see docs, wParam = (LPCTSTR)key, lParam = (LPCTSTR)value *)
  LS_VIEWERCONTROL_GET_OPTIONSTR = WM_USER+41;
                    (* see docs, wParam = (LPCTSTR)key, lParam = (LPCTSTR)value *)
  LS_VIEWERCONTROL_GET_OPTIONSTRLEN = WM_USER+42;
                    (* see docs, wParam = (LPCTSTR)key (returns size in TCHARs) *)
  LS_VIEWERCONTROL_SET_NTFYCALLBACK = WM_USER+43;
                    (* lParam = LRESULT ( WINAPI fn* )(UINT nMsg, LPARAM lParam, UINT nUserParameter); *)
  LS_VIEWERCONTROL_GET_NTFYCALLBACK = WM_USER+44;
                    (* LRESULT ( WINAPI fn* )(UINT nMsg, LPARAM lParam, UINT nUserParameter); *)
  LS_VIEWERCONTROL_GET_TOOLBARBUTTONSTATE = WM_USER+45;
                    (* wParam=nID -> -1=hidden, 1=enabled, 2=disabled (only when toobar present, to sync menu state) *)
  LS_VIEWERCONTROL_SET_FOCUS     = WM_USER+46;
  LS_VCSF_PREVIEW                = 1;
  LS_VCSF_SKETCHLIST             = 2;
  LS_VCSF_TOC                    = 3;
  LS_VIEWERCONTROL_ADDTOOLBARITEM = WM_USER+47;
  LS_VIEWERCONTROL_INTERNAL_CHECKERRORLIST = WM_USER+48;
  LS_VIEWERCONTROL_SET_THEATERMODE = WM_USER+49;
                    (* 0=non-theater, 1=with frame, 2=without frame *)
  LS_VIEWERCONTROL_SET_THEATERFLIPDELAY = WM_USER+50;
                    (* ms for each page *)
  LS_VIEWERCONTROL_SET_THEATERFLIPMODE = WM_USER+51;
                    (* wParam = mode *)
  LS_VCTFM_NONE                  = 0;
  LS_VCTFM_LINEAR                = 1;
                    (* lParam = (LPCTSTR)ProgID *)
  LS_VCTFM_FADE                  = 2;
  LS_VCTFM_WHEEL                 = 3;
  LS_VIEWERCONTROL_SELECT_THEATERXFORM = WM_USER+52;
  LS_VIEWERCONTROL_NTFY_PRVFSCHANGED = WM_USER+53;
                    (* wParam = ILLPreviewFileSystemChangeNotifier::enPrvFSChange.. *)
  LS_VIEWERCONTROL_SET_PROGRESSINFO = WM_USER+54;
                    (* wParam = nPercentage (-1=finished...) *)
  LS_VIEWERCONTROL_GET_FILENAME  = WM_USER+55;
                    (* lParam = LPTSTR pszFilename, wParam = sizeofTSTR(pszBuffer). Returns size needed if NULL filename *)
  LS_VIEWERCONTROL_QUERY_PRVFS_COMPLETE = WM_USER+56;
                    (* indicates whether the STGSYS file is complete (1=complete, 2=finished, but incomplete) *)
  LS_VIEWERCONTROL_ONSIZEMOVE    = WM_USER+57;
                    (* wParam = 0 (ENTER), 1 (EXIT) *)
  LS_VIEWERCONTROL_NTFY_SHOW     = WM_USER+58;
                    (* internal use *)
  LS_VIEWERCONTROL_GET_IDEVICEINFO = WM_USER+59;
                    (* internal use *)
  LS_VIEWERCONTROL_REMOVEFAILURETOOLTIPS = WM_USER+60;
                    (* internal use *)
  LS_VIEWERCONTROL_SET_LLNTFYSINK = WM_USER+61;
                    (* internal use *)
  LS_VIEWERCONTROL_OPEN_PREVSTG  = WM_USER+62;
  LS_VIEWERCONTROL_OPEN_NEXTSTG  = WM_USER+63;
  LS_VIEWERCONTROL_GET_THEATERSTATE = WM_USER+64;
                    (* returns TRUE if in theater mode *)
  LS_VIEWERCONTROL_SET_PROGRESSINFO_INTERNAL = WM_USER+65;
  LS_VIEWERCONTROL_GET_THIS      = WM_USER+67;
                    (* internal *)
  LS_VIEWERCONTROL_SEARCH_LINK   = WM_USER+68;
                    (* wParam = LS_VCITEM_GOTO_LINK_ enum, lParam=SearchText in control's charset flavour (ANSI/UNICODE) (NULL or empty to stop) *)
  LS_SEARCH_LINK_HYPERLINK       = 0;
  LS_VIEWERCONTROL_QUERY_DRILLDOWN_ACTIVE = WM_USER+69;
                    (* count of active drilldown jobs of visible storage - negative if error *)
  LS_VIEWERCONTROL_CMND_ABORT_DRILLDOWN_JOBS = WM_USER+70;
  LS_VIEWERCONTROL_STORAGE_CONTAINS_EXPORTFILE = WM_USER+71;
                    (* lParam = (LPCTSTR)format, returns 1 if yes, 0 if no, negative if error *)
  LS_VIEWERCONTROL_SELECTION_COPY = WM_USER+72;
                    (* lParam == &scLSSelectionOptions (null, or _pvText == null -> to clipboard) *)
  LS_VIEWERCONTROL_GET_HAS_SELECTION = WM_USER+73;
  LS_VIEWERCONTROL_SELECTION_SELECT = WM_USER+74;
                    (* wParam = page index#, -1 for all; lParam = 0 (select only this), 1 (add to selection) *)
  LS_VIEWERCONTROL_GET_HASUNSAVEDINPUTOBJECTS = WM_USER+75;
                    (* reserved, internal *)
  LS_VIEWERCONTROL_NTFY_PAGELOADED = 1;
                    (* lParam = page# *)
  LS_VIEWERCONTROL_NTFY_UPDATETOOLBAR = 2;
                    (* called when control does NOT have an own toolbar. lParam points to an ILSViewerToolbarInfoProxy interface *)
  LS_VIEWERCONTROL_NTFY_PRINT_START = 3;
                    (* lParam = &scViewerControlPrintData, return 1 to abort print *)
  LS_VIEWERCONTROL_NTFY_PRINT_PAGE = 4;
                    (* lParam = &scViewerControlPrintData, return 1 to abort loop *)
  LS_VIEWERCONTROL_NTFY_PRINT_END = 5;
                    (* lParam = &scViewerControlPrintData *)
  LS_VIEWERCONTROL_NTFY_TOOLBARUPDATE = 6;
                    (* lParam = toolbar handle, called when control has an own toolbar *)
  LS_VIEWERCONTROL_NTFY_EXITBTNPRESSED = 7;
  LS_VIEWERCONTROL_NTFY_BTNPRESSED = 8;
                    (* lParam = control ID *)
  LS_VIEWERCONTROL_QUEST_BTNSTATE = 9;
                    (* lParam = control ID, -1 to hide, 1 to show, 2 to disable (0 to use default) *)
  LS_VIEWERCONTROL_NTFY_ERROR    = 10;
                    (* lParam = &scVCError. Return != 0 to suppress error mbox from control. *)
  LS_VIEWERCONTROL_NTFY_MAIL_SENT = 11;
                    (* lParam = Stream* of EML mail contents *)
  LS_VIEWERCONTROL_NTFY_DOWNLOADFINISHED = 12;
                    (* lParam = 0 (failed), 1 (ok) *)
  LS_VIEWERCONTROL_NTFY_KEYBOARDMESSAGE = 13;
                    (* lParam = const MSG*. Return TRUE if message should be taken out of the input queue *)
  LS_VIEWERCONTROL_NTFY_VIEWCHANGED = 14;
  LS_VIEWERCONTROL_CMND_SAVEDATA = 15;
                    (* return: 0 = OK, -1 = failure, 1 = save in LL file too [event used only if AUTOSAVE is TRUE] *)
  LS_VIEWERCONTROL_NTFY_DATACHANGED = 16;
  LS_VIEWERCONTROL_NTFY_PROGRESS = 17;
                    (* lParam = percentage (-1=finished). return: 1 if internal progress bar shall be suppressed *)
  LS_VIEWERCONTROL_QUEST_SUPPORTCONTINUATION = 18;
                    (* return: 1 if continuation button () should be displayed *)
  LS_VIEWERCONTROL_CMND_CONTINUE = 19;
                    (* continue report! *)
  LS_VIEWERCONTROL_NTFY_VIEWERDRILLDOWN = 20;
  LS_VIEWERCONTROL_QUEST_DRILLDOWNSUPPORT = 21;
                    (* 1 to allow (default), 0 to deny (if provider cannot handle multiple threads or so) *)
  LS_VIEWERCONTROL_QUEST_HOST_WANTS_KEY = 22;
                    (* lParam: MSG-structure (message = WM_KEYDOWN, WM_KEYUP, WM_SYSKEYDOWN, WM_SYSKEYUP, WM_CHAR), wParam = key code, lParam = snoop (0), action (1) *)
  LS_VIEWERCONTROL_INTERNALSYNC  = 23;
                    (* reserved, internal *)
  LS_VIEWERCONTROL_NTFY_RP_REALDATAJOB = 24;
  LS_VIEWERCONTROL_QUEST_RP_REALDATAJOBSUPPORT = 25;
                    (* 1 to allow (default), 0 to deny (if provider cannot handle multiple threads or so) *)
  LS_VIEWERCONTROL_QUEST_PROJECTFILENAME = 26;
                    (* reserved, internal *)
  LS_VIEWERCONTROL_QUEST_ORGPROJECTFILENAME = 27;
                    (* reserved, internal *)
  LS_VIEWERCONTROL_NTFY_EXPANDABLEREGIONSJOB = 28;
  LS_VIEWERCONTROL_NTFY_INTERACTIVESORTINGJOB = 30;
  LS_VIEWERCONTROL_QUEST_ANYREALDATAJOBSUPPORT = 32;
                    (* 1 to allow (default), 0 to deny (if provider cannot handle multiple threads or so) *)
  LS_VIEWERCONTROL_NTFY_HYPERLINK = 33;
                    (* 1 to tell viewer it has been processed *)
  LS_VIEWERCONTROL_NTFY_ZOOMCHANGED = 34;
                    (* triggered whenever the zoom factor was updated *)
  LS_VIEWERCONTROL_NTFY_ACTIONRESULT = 35;
                    (* lParam = &scLSNtfyActionResult *)
  LS_VIEWERCONTROL_NTFY_RESETSEARCHSTATE = 36;
                    (* reserved, internal *)
  LS_VIEWERCONTROL_NTFY_SELECTION_CHANGED = 37;
  LS_VIEWERCONTROL_QUEST_DYNAMICREPORTPARAMETERS = 38;
  LS_MAILCONFIG_GLOBAL           = $0001;
  LS_MAILCONFIG_USER             = $0002;
  LS_MAILCONFIG_PROVIDER         = $0004;
  LS_DIO_CHECKBOX                = 0;
  LS_DIO_PUSHBUTTON              = 1;
  LS_DIO_FLAG_READONLY           = $0001;
  LS_DIO_FLAG_SUPPRESS_THEMING   = $0002;
  LS_GOTFG_FLAG_REORDER          = $00000001;
  LSMAILVIEW_HTMLRIGHT_ALLOW_NONE = $0000;
  LSMAILVIEW_HTMLRIGHT_ALLOW_NEW_WINDOW = $0001;
  LSMAILVIEW_HTMLRIGHT_ALLOW_NAVIGATION = $0002;
  LSMAILVIEW_HTMLRIGHT_ALLOW_JAVA = $0004;
  LSMAILVIEW_HTMLRIGHT_ALLOW_SCRIPTING = $0008;
  LSMAILVIEW_HTMLRIGHT_ALLOW_ACTIVEX = $0010;
  LSMAILVIEW_HTMLRIGHT_ALLOW_ONLINE = $0020;
  LSMAILVIEW_HTMLRIGHT_ALLOW_BROWSERCONTEXTMENU = $0040;
  LSMAILVIEW_HTMLRIGHT_ALLOW_PRINT = $0080;
  LS_CONVERT_IS_TO_JPEGFILE      = 0;
  LS_CONVERT_IS_TO_DIBFILE       = 1;
  LS_CONVERT_IS_TO_EMRSTRETCHDIBITS = 2;
  LS_CONVERT_IS_TO_PNGFILE       = 3;
  LS_CONVERT_IS_TO_PNG_OR_JPEG_FILE = 4;
  LS_CONVERT_IS_TO_EMRSTRETCHDIBITS_OPTIMIZED = 5;
  LS_CONVERT_IS_TYPEMASK         = $0000000f;
  LS_CONVERT_IS_NOPERPIXELALPHA  = $00000010;
  LS_CONVERT_IS_SRCCOPY          = $00000020;
  LS_CONVERT_IS_NO_JPEGCONVERSION = $00000040;
                    (* for PDF Conversion (PDF export handles these itself) *)
  LS_CONVERT_IS_QUALITY_MASK     = $ff000000;
                    (* 75 if not given *)
  LS_CONVERT_IS_QUALITY_SHIFT    = 24;
  LS_STGPRINTEX_OPTION_FORCE_SIMPLEX = $00000001;
  LS_STGPRINTEX_OPTION_FORCE_DUPLEX_VERT = $00000002;
  LS_STGPRINTEX_OPTION_FORCE_DUPLEX_HORZ = $00000003;
  LS_STGPRINTEX_OPTIONMASK_DUPLEX = $00000003;
  LS_STGPRINTEX_OPTION_FORCE_PHYSPAGE = $00000004;
  LS_STGPRINTEX_OPTION_FORCE_LOGPAGE = $00000008;
  LS_STGPRINTEX_OPTIONMASK_PAGEAREA = $0000000C;

type
  pfnLlStgsysStorageOpenA= function  
	(_lpszFilename:    pCHAR;
	 _pszTempPath:     pCHAR;
	 _bReadOnly:       longbool;
	 _bOneJobTranslation:                longbool
	): HLLSTG; stdcall;
  pfnLlStgsysStorageOpenW= function  
	(_lpszFilename:    pWCHAR;
	 _pszTempPath:     pWCHAR;
	 _bReadOnly:       longbool;
	 _bOneJobTranslation:                longbool
	): HLLSTG; stdcall;
  pfnLlStgsysStorageClose= procedure 
	(_hStg:            HLLSTG
	); stdcall;
  pfnLlStgsysGetAPIVersion= function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysGetFileVersion= function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysGetFilenameA= function  
	(_hStg:            HLLSTG;
	 _nJob:            integer;
	 _nFile:           integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysGetFilenameW= function  
	(_hStg:            HLLSTG;
	 _nJob:            integer;
	 _nFile:           integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysGetJobCount = function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysSetJob      = function  
	(_hStg:            HLLSTG;
	 _nJob:            integer
	): integer; stdcall;
  pfnLlStgsysGetJob      = function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysGetPageCount= function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysGetJobOptionValue= function  
	(_hStg:            HLLSTG;
	 _nOption:         integer
	): integer; stdcall;
  pfnLlStgsysGetPageOptionValue= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer
	): integer; stdcall;
  pfnLlStgsysGetPageOptionStringA= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysGetPageOptionStringW= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysSetPageOptionStringA= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer;
	 _pszBuffer:       pCHAR
	): integer; stdcall;
  pfnLlStgsysSetPageOptionStringW= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer;
	 _pszBuffer:       pWCHAR
	): integer; stdcall;
  pfnLlStgsysGetPageOptionV= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _nOption:         integer;
	 _pvValue:         PVARIANT
	): integer; stdcall;
  pfnLlStgsysAppend      = function  
	(_hStg:            HLLSTG;
	 _hStgToAppend:    HLLSTG
	): integer; stdcall;
  pfnLlStgsysDeleteJob   = function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer
	): integer; stdcall;
  pfnLlStgsysDeletePage  = function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer
	): integer; stdcall;
  pfnLlStgsysGetPageMetafile= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer
	): tHandle; stdcall;
  pfnLlStgsysDestroyMetafile= function  
	(_hMF:             tHandle
	): integer; stdcall;
  pfnLlStgsysDrawPage    = function  
	(_hStg:            HLLSTG;
	 _hDC:             HDC;
	 _hPrnDC:          HDC;
	 _bAskPrinter:     longbool;
	 _pRC:             _PCRECT;
	 _nPageIndex:      integer;
	 _bFit:            longbool;
	 _pReserved:       pChar
	): integer; stdcall;
  pfnLlStgsysGetLastError= function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysDeleteFiles = function  
	(_hStg:            HLLSTG
	): integer; stdcall;
  pfnLlStgsysPrintA      = function  
	(_hStg:            HLLSTG;
	 _pszPrinterName1: pCHAR;
	 _pszPrinterName2: pCHAR;
	 _nStartPageIndex: integer;
	 _nEndPageIndex:   integer;
	 _nCopies:         integer;
	 _nFlags:          cardinal;
	 _pszMessage:      pCHAR;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLlStgsysPrintW      = function  
	(_hStg:            HLLSTG;
	 _pszPrinterName1: pWCHAR;
	 _pszPrinterName2: pWCHAR;
	 _nStartPageIndex: integer;
	 _nEndPageIndex:   integer;
	 _nCopies:         integer;
	 _nFlags:          cardinal;
	 _pszMessage:      pWCHAR;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLlStgsysStoragePrintA= function  
	(_lpszFilename:    pCHAR;
	 _pszTempPath:     pCHAR;
	 _pszPrinterName1: pCHAR;
	 _pszPrinterName2: pCHAR;
	 _nStartPageIndex: integer;
	 _nEndPageIndex:   integer;
	 _nCopies:         integer;
	 _nFlags:          cardinal;
	 _pszMessage:      pCHAR;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLlStgsysStoragePrintW= function  
	(_lpszFilename:    pWCHAR;
	 _pszTempPath:     pWCHAR;
	 _pszPrinterName1: pWCHAR;
	 _pszPrinterName2: pWCHAR;
	 _nStartPageIndex: integer;
	 _nEndPageIndex:   integer;
	 _nCopies:         integer;
	 _nFlags:          cardinal;
	 _pszMessage:      pWCHAR;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLlStgsysGetPagePrinterA= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _pszDeviceName:   pCHAR;
	 _nDeviceNameSize: cardinal;
	 _phDevMode:       PHGLOBAL
	): integer; stdcall;
  pfnLlStgsysGetPagePrinterW= function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _pszDeviceName:   pWCHAR;
	 _nDeviceNameSize: cardinal;
	 _phDevMode:       PHGLOBAL
	): integer; stdcall;
  pfnLsSetDebug          = procedure 
	(_bOn:             longbool
	); stdcall;
  pfnLsGetViewerControlClassNameA= function   : pCHAR; stdcall;
  pfnLsGetViewerControlClassNameW= function   : pWCHAR; stdcall;
  pfnLsGetViewerControlDefaultMessage= function   : cardinal; stdcall;
  pfnLsCreateViewerControlOverParent= function  
	(_hStg:            HSTG;
	 _hParentControl:  HWND
	): integer; stdcall;
  pfnLlStgsysGetJobOptionStringExA= function  
	(_hStg:            HLLSTG;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysGetJobOptionStringExW= function  
	(_hStg:            HLLSTG;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLlStgsysSetJobOptionStringExA= function  
	(_hStg:            HLLSTG;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR
	): integer; stdcall;
  pfnLlStgsysSetJobOptionStringExW= function  
	(_hStg:            HLLSTG;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR
	): integer; stdcall;
  pfnLlStgsysGetJobOptionV= function  
	(_hStg:            HLLSTG;
	 _pszKey:          pWCHAR;
	 _pvValue:         PVARIANT
	): integer; stdcall;
  pfnLsConversionJobOpenA= function  
	(_hWndParent:      HWND;
	 _nLanguage:       integer;
	 _pszFormat:       pCHAR
	): HLSCNVJOB; stdcall;
  pfnLsConversionJobOpenW= function  
	(_hWndParent:      HWND;
	 _nLanguage:       integer;
	 _pszFormat:       pWCHAR
	): HLSCNVJOB; stdcall;
  pfnLsConversionJobClose= function  
	(_hCnvJob:         HLSCNVJOB
	): integer; stdcall;
  pfnLsConversionConvertEMFToStream= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hEMF:            HENHMETAFILE;
	 _pStream:         PSTREAM
	): integer; stdcall;
  pfnLsConversionConvertStgToStream= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hStg:            HLLSTG;
	 _pStream:         PSTREAM
	): integer; stdcall;
  pfnLsConversionPrintA  = function  
	(_hCnvJob:         HLSCNVJOB;
	 _pStream:         PSTREAM;
	 _pszBufFilename:  pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsConversionPrintW  = function  
	(_hCnvJob:         HLSCNVJOB;
	 _pStream:         PSTREAM;
	 _pszBufFilename:  pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsConversionConfigurationDlg= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLsConversionSetOptionStringA= function  
	(_hCnvJob:         HLSCNVJOB;
	 _pszKey:          pCHAR;
	 _pszData:         pCHAR
	): integer; stdcall;
  pfnLsConversionSetOptionStringW= function  
	(_hCnvJob:         HLSCNVJOB;
	 _pszKey:          pWCHAR;
	 _pszData:         pWCHAR
	): integer; stdcall;
  pfnLsConversionGetOptionStringA= function  
	(_hCnvJob:         HLSCNVJOB;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsConversionGetOptionStringW= function  
	(_hCnvJob:         HLSCNVJOB;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsConversionConvertEMFToFileA= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hEMF:            HENHMETAFILE;
	 _pszFilename:     pCHAR
	): integer; stdcall;
  pfnLsConversionConvertEMFToFileW= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hEMF:            HENHMETAFILE;
	 _pszFilename:     pWCHAR
	): integer; stdcall;
  pfnLsConversionConvertStgToFileA= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hStg:            HLLSTG;
	 _pszFilename:     pCHAR
	): integer; stdcall;
  pfnLsConversionConvertStgToFileW= function  
	(_hCnvJob:         HLSCNVJOB;
	 _hStg:            HLLSTG;
	 _pszFilename:     pWCHAR
	): integer; stdcall;
  pfnLlStgsysStorageConvertA= function  
	(_pszStgFilename:  pCHAR;
	 _pszDstFilename:  pCHAR;
	 _pszFormat:       pCHAR
	): integer; stdcall;
  pfnLlStgsysStorageConvertW= function  
	(_pszStgFilename:  pWCHAR;
	 _pszDstFilename:  pWCHAR;
	 _pszFormat:       pWCHAR
	): integer; stdcall;
  pfnLlStgsysConvertA    = function  
	(_hStg:            HLLSTG;
	 _pszDstFilename:  pCHAR;
	 _pszFormat:       pCHAR
	): integer; stdcall;
  pfnLlStgsysConvertW    = function  
	(_hStg:            HLLSTG;
	 _pszDstFilename:  pWCHAR;
	 _pszFormat:       pWCHAR
	): integer; stdcall;
  pfnLsMailConfigurationDialogA= function  
	(_hWndParent:      HWND;
	 _pszSubkey:       pCHAR;
	 _nFlags:          cardinal;
	 _nLanguage:       integer
	): integer; stdcall;
  pfnLsMailConfigurationDialogW= function  
	(_hWndParent:      HWND;
	 _pszSubkey:       pWCHAR;
	 _nFlags:          cardinal;
	 _nLanguage:       integer
	): integer; stdcall;
  pfnLsMailJobOpen       = function  
	(_nLanguage:       integer
	): HLSMAILJOB; stdcall;
  pfnLsMailJobClose      = function  
	(_hJob:            HLSMAILJOB
	): integer; stdcall;
  pfnLsMailSetOptionStringA= function  
	(_hJob:            HLSMAILJOB;
	 _pszKey:          pCHAR;
	 _pszValue:        pCHAR
	): integer; stdcall;
  pfnLsMailSetOptionStringW= function  
	(_hJob:            HLSMAILJOB;
	 _pszKey:          pWCHAR;
	 _pszValue:        pWCHAR
	): integer; stdcall;
  pfnLsMailGetOptionStringA= function  
	(_hJob:            HLSMAILJOB;
	 _pszKey:          pCHAR;
	 _pszBuffer:       pCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsMailGetOptionStringW= function  
	(_hJob:            HLSMAILJOB;
	 _pszKey:          pWCHAR;
	 _pszBuffer:       pWCHAR;
	 _nBufSize:        cardinal
	): integer; stdcall;
  pfnLsMailSendFile      = function  
	(_hJob:            HLSMAILJOB;
	 _hWndParent:      HWND
	): integer; stdcall;
  pfnLlStgsysStorageCreateA= function  
	(_lpszFilename:    pCHAR;
	 _pszTempPath:     pCHAR;
	 _hRefDC:          HDC;
	 _prcArea:         _PCRECT;
	 _bPhysicalPage:   longbool
	): HLLSTG; stdcall;
  pfnLlStgsysStorageCreateW= function  
	(_lpszFilename:    pWCHAR;
	 _pszTempPath:     pWCHAR;
	 _hRefDC:          HDC;
	 _prcArea:         _PCRECT;
	 _bPhysicalPage:   longbool
	): HLLSTG; stdcall;
  pfnLlStgsysAppendEMF   = function  
	(_hStg:            HLLSTG;
	 _hEMFToAppend:    HENHMETAFILE;
	 _hRefDC:          HDC;
	 _prcArea:         _PCRECT;
	 _bPhysicalPage:   longbool
	): integer; stdcall;
  pfnLsProfileStartA     = function  
	(_hThread:         tHandle;
	 _pszDescr:        pCHAR;
	 _pszFilename:     pCHAR;
	 _nTicksMS:        integer
	): integer; stdcall;
  pfnLsProfileStartW     = function  
	(_hThread:         tHandle;
	 _pszDescr:        pWCHAR;
	 _pszFilename:     pWCHAR;
	 _nTicksMS:        integer
	): integer; stdcall;
  pfnLsProfileEnd        = procedure 
	(_hThread:         tHandle
	); stdcall;
  pfnLsGetOrgTextFromGlyphsW= function  
	(_hDC:             HDC;
	 _pszGlyphs:       _LPCWORD;
	 _nGlyphs:         integer;
	 _pszOrgTextBuffer:                pWCHAR;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLsMailViewA         = function  
	(_hWndParent:      HWND;
	 _pszMailFile:     pCHAR;
	 _nRights:         cardinal;
	 _nLanguage:       integer
	): integer; stdcall;
  pfnLsMailViewW         = function  
	(_hWndParent:      HWND;
	 _pszMailFile:     pWCHAR;
	 _nRights:         cardinal;
	 _nLanguage:       integer
	): integer; stdcall;
  pfnLsInternalCreateViewerControlOverParent13= function  
	(_hParentControl:  HWND;
	 _nFlags:          cardinal
	): integer; stdcall;
  pfnLsInternalGetViewerControlFromParent13= function  
	(_hParentControl:  HWND
	): HWND; stdcall;
  pfnLsSetDlgboxMode     = procedure 
	(_nMode:           cardinal
	); stdcall;
  pfnLsGetDlgboxMode     = function   : cardinal; stdcall;
  pfnLsGetViewerControlClassNameEx= function   : pWCHAR; stdcall;
  pfnLsGetDebug          = function   : longbool; stdcall;
  pfnLsConvertImageStream= function  
	(_pGDICommentData: pChar;
	 _hGlobal:         PHGLOBAL;
	 _nOptions:        cardinal
	): integer; stdcall;
  pfnLlStgsysStoragePrintExW= function  
	(_pszStgFileName:  pWCHAR;
	 _pszPrinter:      pWCHAR;
	 _nOptions:        cardinal;
	 _nUserParam:      lParam;
	 _pfnCallback:     pChar
	): integer; stdcall;
  pfnLsProcessEnhMetaFileRecord= function  
	(_hDC:             HDC;
	 _pEMR:            _PCENHMETARECORD
	): longbool; stdcall;
  pfnLlStgsysGetPageData = function  
	(_hStg:            HLLSTG;
	 _nPageIndex:      integer;
	 _ppStream:        PPSTREAM;
	 _ppStreamTOC:     PPSTREAM;
	 _ppStreamIDX:     PPSTREAM
	): longbool; stdcall;
  pfnLlStgsysSetUILanguage= function  
	(_hStg:            HLLSTG;
	 _nCMBTLanguage:   integer
	): longbool; stdcall;

const
  {$ifdef UNICODE}
      LlStgsysStorageOpenO: pfnLlStgsysStorageOpenA = NIL;
     {$else}
      LlStgsysStorageOpen: pfnLlStgsysStorageOpenA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStorageOpen: pfnLlStgsysStorageOpenW = NIL;
     {$else}
      LlStgsysStorageOpenO: pfnLlStgsysStorageOpenW = NIL;
  {$endif}
   LlStgsysStorageClose: pfnLlStgsysStorageClose = NIL;
   LlStgsysGetAPIVersion: pfnLlStgsysGetAPIVersion = NIL;
   LlStgsysGetFileVersion: pfnLlStgsysGetFileVersion = NIL;
  {$ifdef UNICODE}
      LlStgsysGetFilenameO: pfnLlStgsysGetFilenameA = NIL;
     {$else}
      LlStgsysGetFilename: pfnLlStgsysGetFilenameA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysGetFilename: pfnLlStgsysGetFilenameW = NIL;
     {$else}
      LlStgsysGetFilenameO: pfnLlStgsysGetFilenameW = NIL;
  {$endif}
   LlStgsysGetJobCount: pfnLlStgsysGetJobCount = NIL;
   LlStgsysSetJob: pfnLlStgsysSetJob = NIL;
   LlStgsysGetJob: pfnLlStgsysGetJob = NIL;
   LlStgsysGetPageCount: pfnLlStgsysGetPageCount = NIL;
   LlStgsysGetJobOptionValue: pfnLlStgsysGetJobOptionValue = NIL;
   LlStgsysGetPageOptionValue: pfnLlStgsysGetPageOptionValue = NIL;
  {$ifdef UNICODE}
      LlStgsysGetPageOptionStringO: pfnLlStgsysGetPageOptionStringA = NIL;
     {$else}
      LlStgsysGetPageOptionString: pfnLlStgsysGetPageOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysGetPageOptionString: pfnLlStgsysGetPageOptionStringW = NIL;
     {$else}
      LlStgsysGetPageOptionStringO: pfnLlStgsysGetPageOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysSetPageOptionStringO: pfnLlStgsysSetPageOptionStringA = NIL;
     {$else}
      LlStgsysSetPageOptionString: pfnLlStgsysSetPageOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysSetPageOptionString: pfnLlStgsysSetPageOptionStringW = NIL;
     {$else}
      LlStgsysSetPageOptionStringO: pfnLlStgsysSetPageOptionStringW = NIL;
  {$endif}
   LlStgsysGetPageOptionV: pfnLlStgsysGetPageOptionV = NIL;
   LlStgsysAppend: pfnLlStgsysAppend = NIL;
   LlStgsysDeleteJob: pfnLlStgsysDeleteJob = NIL;
   LlStgsysDeletePage: pfnLlStgsysDeletePage = NIL;
   LlStgsysGetPageMetafile: pfnLlStgsysGetPageMetafile = NIL;
   LlStgsysDestroyMetafile: pfnLlStgsysDestroyMetafile = NIL;
   LlStgsysDrawPage: pfnLlStgsysDrawPage = NIL;
   LlStgsysGetLastError: pfnLlStgsysGetLastError = NIL;
   LlStgsysDeleteFiles: pfnLlStgsysDeleteFiles = NIL;
  {$ifdef UNICODE}
      LlStgsysPrintO: pfnLlStgsysPrintA = NIL;
     {$else}
      LlStgsysPrint: pfnLlStgsysPrintA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysPrint: pfnLlStgsysPrintW = NIL;
     {$else}
      LlStgsysPrintO: pfnLlStgsysPrintW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStoragePrintO: pfnLlStgsysStoragePrintA = NIL;
     {$else}
      LlStgsysStoragePrint: pfnLlStgsysStoragePrintA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStoragePrint: pfnLlStgsysStoragePrintW = NIL;
     {$else}
      LlStgsysStoragePrintO: pfnLlStgsysStoragePrintW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysGetPagePrinterO: pfnLlStgsysGetPagePrinterA = NIL;
     {$else}
      LlStgsysGetPagePrinter: pfnLlStgsysGetPagePrinterA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysGetPagePrinter: pfnLlStgsysGetPagePrinterW = NIL;
     {$else}
      LlStgsysGetPagePrinterO: pfnLlStgsysGetPagePrinterW = NIL;
  {$endif}
   LsSetDebug: pfnLsSetDebug = NIL;
  {$ifdef UNICODE}
      LsGetViewerControlClassNameO: pfnLsGetViewerControlClassNameA = NIL;
     {$else}
      LsGetViewerControlClassName: pfnLsGetViewerControlClassNameA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsGetViewerControlClassName: pfnLsGetViewerControlClassNameW = NIL;
     {$else}
      LsGetViewerControlClassNameO: pfnLsGetViewerControlClassNameW = NIL;
  {$endif}
   LsGetViewerControlDefaultMessage: pfnLsGetViewerControlDefaultMessage = NIL;
   LsCreateViewerControlOverParent: pfnLsCreateViewerControlOverParent = NIL;
  {$ifdef UNICODE}
      LlStgsysGetJobOptionStringExO: pfnLlStgsysGetJobOptionStringExA = NIL;
     {$else}
      LlStgsysGetJobOptionStringEx: pfnLlStgsysGetJobOptionStringExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysGetJobOptionStringEx: pfnLlStgsysGetJobOptionStringExW = NIL;
     {$else}
      LlStgsysGetJobOptionStringExO: pfnLlStgsysGetJobOptionStringExW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysSetJobOptionStringExO: pfnLlStgsysSetJobOptionStringExA = NIL;
     {$else}
      LlStgsysSetJobOptionStringEx: pfnLlStgsysSetJobOptionStringExA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysSetJobOptionStringEx: pfnLlStgsysSetJobOptionStringExW = NIL;
     {$else}
      LlStgsysSetJobOptionStringExO: pfnLlStgsysSetJobOptionStringExW = NIL;
  {$endif}
   LlStgsysGetJobOptionV: pfnLlStgsysGetJobOptionV = NIL;
  {$ifdef UNICODE}
      LsConversionJobOpenO: pfnLsConversionJobOpenA = NIL;
     {$else}
      LsConversionJobOpen: pfnLsConversionJobOpenA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionJobOpen: pfnLsConversionJobOpenW = NIL;
     {$else}
      LsConversionJobOpenO: pfnLsConversionJobOpenW = NIL;
  {$endif}
   LsConversionJobClose: pfnLsConversionJobClose = NIL;
   LsConversionConvertEMFToStream: pfnLsConversionConvertEMFToStream = NIL;
   LsConversionConvertStgToStream: pfnLsConversionConvertStgToStream = NIL;
  {$ifdef UNICODE}
      LsConversionPrintO: pfnLsConversionPrintA = NIL;
     {$else}
      LsConversionPrint: pfnLsConversionPrintA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionPrint: pfnLsConversionPrintW = NIL;
     {$else}
      LsConversionPrintO: pfnLsConversionPrintW = NIL;
  {$endif}
   LsConversionConfigurationDlg: pfnLsConversionConfigurationDlg = NIL;
  {$ifdef UNICODE}
      LsConversionSetOptionStringO: pfnLsConversionSetOptionStringA = NIL;
     {$else}
      LsConversionSetOptionString: pfnLsConversionSetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionSetOptionString: pfnLsConversionSetOptionStringW = NIL;
     {$else}
      LsConversionSetOptionStringO: pfnLsConversionSetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionGetOptionStringO: pfnLsConversionGetOptionStringA = NIL;
     {$else}
      LsConversionGetOptionString: pfnLsConversionGetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionGetOptionString: pfnLsConversionGetOptionStringW = NIL;
     {$else}
      LsConversionGetOptionStringO: pfnLsConversionGetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionConvertEMFToFileO: pfnLsConversionConvertEMFToFileA = NIL;
     {$else}
      LsConversionConvertEMFToFile: pfnLsConversionConvertEMFToFileA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionConvertEMFToFile: pfnLsConversionConvertEMFToFileW = NIL;
     {$else}
      LsConversionConvertEMFToFileO: pfnLsConversionConvertEMFToFileW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionConvertStgToFileO: pfnLsConversionConvertStgToFileA = NIL;
     {$else}
      LsConversionConvertStgToFile: pfnLsConversionConvertStgToFileA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsConversionConvertStgToFile: pfnLsConversionConvertStgToFileW = NIL;
     {$else}
      LsConversionConvertStgToFileO: pfnLsConversionConvertStgToFileW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStorageConvertO: pfnLlStgsysStorageConvertA = NIL;
     {$else}
      LlStgsysStorageConvert: pfnLlStgsysStorageConvertA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStorageConvert: pfnLlStgsysStorageConvertW = NIL;
     {$else}
      LlStgsysStorageConvertO: pfnLlStgsysStorageConvertW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysConvertO: pfnLlStgsysConvertA = NIL;
     {$else}
      LlStgsysConvert: pfnLlStgsysConvertA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysConvert: pfnLlStgsysConvertW = NIL;
     {$else}
      LlStgsysConvertO: pfnLlStgsysConvertW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailConfigurationDialogO: pfnLsMailConfigurationDialogA = NIL;
     {$else}
      LsMailConfigurationDialog: pfnLsMailConfigurationDialogA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailConfigurationDialog: pfnLsMailConfigurationDialogW = NIL;
     {$else}
      LsMailConfigurationDialogO: pfnLsMailConfigurationDialogW = NIL;
  {$endif}
   LsMailJobOpen: pfnLsMailJobOpen = NIL;
   LsMailJobClose: pfnLsMailJobClose = NIL;
  {$ifdef UNICODE}
      LsMailSetOptionStringO: pfnLsMailSetOptionStringA = NIL;
     {$else}
      LsMailSetOptionString: pfnLsMailSetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailSetOptionString: pfnLsMailSetOptionStringW = NIL;
     {$else}
      LsMailSetOptionStringO: pfnLsMailSetOptionStringW = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailGetOptionStringO: pfnLsMailGetOptionStringA = NIL;
     {$else}
      LsMailGetOptionString: pfnLsMailGetOptionStringA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailGetOptionString: pfnLsMailGetOptionStringW = NIL;
     {$else}
      LsMailGetOptionStringO: pfnLsMailGetOptionStringW = NIL;
  {$endif}
   LsMailSendFile: pfnLsMailSendFile = NIL;
  {$ifdef UNICODE}
      LlStgsysStorageCreateO: pfnLlStgsysStorageCreateA = NIL;
     {$else}
      LlStgsysStorageCreate: pfnLlStgsysStorageCreateA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LlStgsysStorageCreate: pfnLlStgsysStorageCreateW = NIL;
     {$else}
      LlStgsysStorageCreateO: pfnLlStgsysStorageCreateW = NIL;
  {$endif}
   LlStgsysAppendEMF: pfnLlStgsysAppendEMF = NIL;
  {$ifdef UNICODE}
      LsProfileStartO: pfnLsProfileStartA = NIL;
     {$else}
      LsProfileStart: pfnLsProfileStartA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsProfileStart: pfnLsProfileStartW = NIL;
     {$else}
      LsProfileStartO: pfnLsProfileStartW = NIL;
  {$endif}
   LsProfileEnd: pfnLsProfileEnd = NIL;
   LsGetOrgTextFromGlyphsW: pfnLsGetOrgTextFromGlyphsW = NIL;
  {$ifdef UNICODE}
      LsMailViewO: pfnLsMailViewA = NIL;
     {$else}
      LsMailView: pfnLsMailViewA = NIL;
  {$endif}
  {$ifdef UNICODE}
      LsMailView: pfnLsMailViewW = NIL;
     {$else}
      LsMailViewO: pfnLsMailViewW = NIL;
  {$endif}
   LsInternalCreateViewerControlOverParent13: pfnLsInternalCreateViewerControlOverParent13 = NIL;
   LsInternalGetViewerControlFromParent13: pfnLsInternalGetViewerControlFromParent13 = NIL;
   LsSetDlgboxMode: pfnLsSetDlgboxMode = NIL;
   LsGetDlgboxMode: pfnLsGetDlgboxMode = NIL;
   LsGetViewerControlClassNameEx: pfnLsGetViewerControlClassNameEx = NIL;
   LsGetDebug: pfnLsGetDebug = NIL;
   LsConvertImageStream: pfnLsConvertImageStream = NIL;
   LlStgsysStoragePrintExW: pfnLlStgsysStoragePrintExW = NIL;
   LsProcessEnhMetaFileRecord: pfnLsProcessEnhMetaFileRecord = NIL;
   LlStgsysGetPageData: pfnLlStgsysGetPageData = NIL;
   LlStgsysSetUILanguage: pfnLlStgsysSetUILanguage = NIL;

function  LS28xModuleName: String;
function  LS28xLoad: integer;
procedure LS28xUnload;

implementation

var hDLLLS28: HMODULE = 0;
var nDLLLS28Usage: longint = 0;

{$ifdef WIN64}
  const LibNameLS28DLL = 'CXLS28.DLL';
 {$else}
  const LibNameLS28DLL = 'CMLS28.DLL';
{$endif}

function  LS28xModuleName: String;
begin
  Result := LibNameLS28DLL;
end;

function  LS28xLoad: integer;
var nError: integer;
begin
  Result := 0;
  inc(nDLLLS28Usage);
  if (nDLLLS28Usage = 1) then
    begin
    nError := SetErrorMode($8000); { SEM_NOOPENFILEERRORBOX }
    {$ifdef UNICODESTRING_AWARE}
      hDLLLS28 := LoadLibrary(pWideChar(LS28xModuleName()));
     {$else}
      hDLLLS28 := LoadLibrary(pChar(LS28xModuleName()));
    {$endif}
    SetErrorMode(nError);

    if (hDLLLS28 = 0) then
      begin
      Result := -1;
      dec(nDLLLS28Usage);
      end
     else
      begin
      {$ifdef UNICODE}
          @LlStgsysStorageOpenO := GetProcAddress(hDLLLS28,'LlStgsysStorageOpenA');
        {$else}
          @LlStgsysStorageOpen := GetProcAddress(hDLLLS28,'LlStgsysStorageOpenA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStorageOpen := GetProcAddress(hDLLLS28,'LlStgsysStorageOpenW');
        {$else}
          @LlStgsysStorageOpenO := GetProcAddress(hDLLLS28,'LlStgsysStorageOpenW');
      {$endif}
      @LlStgsysStorageClose := GetProcAddress(hDLLLS28,'LlStgsysStorageClose');
      @LlStgsysGetAPIVersion := GetProcAddress(hDLLLS28,'LlStgsysGetAPIVersion');
      @LlStgsysGetFileVersion := GetProcAddress(hDLLLS28,'LlStgsysGetFileVersion');
      {$ifdef UNICODE}
          @LlStgsysGetFilenameO := GetProcAddress(hDLLLS28,'LlStgsysGetFilenameA');
        {$else}
          @LlStgsysGetFilename := GetProcAddress(hDLLLS28,'LlStgsysGetFilenameA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysGetFilename := GetProcAddress(hDLLLS28,'LlStgsysGetFilenameW');
        {$else}
          @LlStgsysGetFilenameO := GetProcAddress(hDLLLS28,'LlStgsysGetFilenameW');
      {$endif}
      @LlStgsysGetJobCount  := GetProcAddress(hDLLLS28,'LlStgsysGetJobCount');
      @LlStgsysSetJob       := GetProcAddress(hDLLLS28,'LlStgsysSetJob');
      @LlStgsysGetJob       := GetProcAddress(hDLLLS28,'LlStgsysGetJob');
      @LlStgsysGetPageCount := GetProcAddress(hDLLLS28,'LlStgsysGetPageCount');
      @LlStgsysGetJobOptionValue := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionValue');
      @LlStgsysGetPageOptionValue := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionValue');
      {$ifdef UNICODE}
          @LlStgsysGetPageOptionStringO := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionStringA');
        {$else}
          @LlStgsysGetPageOptionString := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysGetPageOptionString := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionStringW');
        {$else}
          @LlStgsysGetPageOptionStringO := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysSetPageOptionStringO := GetProcAddress(hDLLLS28,'LlStgsysSetPageOptionStringA');
        {$else}
          @LlStgsysSetPageOptionString := GetProcAddress(hDLLLS28,'LlStgsysSetPageOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysSetPageOptionString := GetProcAddress(hDLLLS28,'LlStgsysSetPageOptionStringW');
        {$else}
          @LlStgsysSetPageOptionStringO := GetProcAddress(hDLLLS28,'LlStgsysSetPageOptionStringW');
      {$endif}
      @LlStgsysGetPageOptionV := GetProcAddress(hDLLLS28,'LlStgsysGetPageOptionV');
      @LlStgsysAppend       := GetProcAddress(hDLLLS28,'LlStgsysAppend');
      @LlStgsysDeleteJob    := GetProcAddress(hDLLLS28,'LlStgsysDeleteJob');
      @LlStgsysDeletePage   := GetProcAddress(hDLLLS28,'LlStgsysDeletePage');
      @LlStgsysGetPageMetafile := GetProcAddress(hDLLLS28,'LlStgsysGetPageMetafile');
      @LlStgsysDestroyMetafile := GetProcAddress(hDLLLS28,'LlStgsysDestroyMetafile');
      @LlStgsysDrawPage     := GetProcAddress(hDLLLS28,'LlStgsysDrawPage');
      @LlStgsysGetLastError := GetProcAddress(hDLLLS28,'LlStgsysGetLastError');
      @LlStgsysDeleteFiles  := GetProcAddress(hDLLLS28,'LlStgsysDeleteFiles');
      {$ifdef UNICODE}
          @LlStgsysPrintO := GetProcAddress(hDLLLS28,'LlStgsysPrintA');
        {$else}
          @LlStgsysPrint := GetProcAddress(hDLLLS28,'LlStgsysPrintA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysPrint := GetProcAddress(hDLLLS28,'LlStgsysPrintW');
        {$else}
          @LlStgsysPrintO := GetProcAddress(hDLLLS28,'LlStgsysPrintW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStoragePrintO := GetProcAddress(hDLLLS28,'LlStgsysStoragePrintA');
        {$else}
          @LlStgsysStoragePrint := GetProcAddress(hDLLLS28,'LlStgsysStoragePrintA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStoragePrint := GetProcAddress(hDLLLS28,'LlStgsysStoragePrintW');
        {$else}
          @LlStgsysStoragePrintO := GetProcAddress(hDLLLS28,'LlStgsysStoragePrintW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysGetPagePrinterO := GetProcAddress(hDLLLS28,'LlStgsysGetPagePrinterA');
        {$else}
          @LlStgsysGetPagePrinter := GetProcAddress(hDLLLS28,'LlStgsysGetPagePrinterA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysGetPagePrinter := GetProcAddress(hDLLLS28,'LlStgsysGetPagePrinterW');
        {$else}
          @LlStgsysGetPagePrinterO := GetProcAddress(hDLLLS28,'LlStgsysGetPagePrinterW');
      {$endif}
      @LsSetDebug           := GetProcAddress(hDLLLS28,'LsSetDebug');
      {$ifdef UNICODE}
          @LsGetViewerControlClassNameO := GetProcAddress(hDLLLS28,'LsGetViewerControlClassNameA');
        {$else}
          @LsGetViewerControlClassName := GetProcAddress(hDLLLS28,'LsGetViewerControlClassNameA');
      {$endif}
      {$ifdef UNICODE}
          @LsGetViewerControlClassName := GetProcAddress(hDLLLS28,'LsGetViewerControlClassNameW');
        {$else}
          @LsGetViewerControlClassNameO := GetProcAddress(hDLLLS28,'LsGetViewerControlClassNameW');
      {$endif}
      @LsGetViewerControlDefaultMessage := GetProcAddress(hDLLLS28,'LsGetViewerControlDefaultMessage');
      @LsCreateViewerControlOverParent := GetProcAddress(hDLLLS28,'LsCreateViewerControlOverParent');
      {$ifdef UNICODE}
          @LlStgsysGetJobOptionStringExO := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionStringExA');
        {$else}
          @LlStgsysGetJobOptionStringEx := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionStringExA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysGetJobOptionStringEx := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionStringExW');
        {$else}
          @LlStgsysGetJobOptionStringExO := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionStringExW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysSetJobOptionStringExO := GetProcAddress(hDLLLS28,'LlStgsysSetJobOptionStringExA');
        {$else}
          @LlStgsysSetJobOptionStringEx := GetProcAddress(hDLLLS28,'LlStgsysSetJobOptionStringExA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysSetJobOptionStringEx := GetProcAddress(hDLLLS28,'LlStgsysSetJobOptionStringExW');
        {$else}
          @LlStgsysSetJobOptionStringExO := GetProcAddress(hDLLLS28,'LlStgsysSetJobOptionStringExW');
      {$endif}
      @LlStgsysGetJobOptionV := GetProcAddress(hDLLLS28,'LlStgsysGetJobOptionV');
      {$ifdef UNICODE}
          @LsConversionJobOpenO := GetProcAddress(hDLLLS28,'LsConversionJobOpenA');
        {$else}
          @LsConversionJobOpen := GetProcAddress(hDLLLS28,'LsConversionJobOpenA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionJobOpen := GetProcAddress(hDLLLS28,'LsConversionJobOpenW');
        {$else}
          @LsConversionJobOpenO := GetProcAddress(hDLLLS28,'LsConversionJobOpenW');
      {$endif}
      @LsConversionJobClose := GetProcAddress(hDLLLS28,'LsConversionJobClose');
      @LsConversionConvertEMFToStream := GetProcAddress(hDLLLS28,'LsConversionConvertEMFToStream');
      @LsConversionConvertStgToStream := GetProcAddress(hDLLLS28,'LsConversionConvertStgToStream');
      {$ifdef UNICODE}
          @LsConversionPrintO := GetProcAddress(hDLLLS28,'LsConversionPrintA');
        {$else}
          @LsConversionPrint := GetProcAddress(hDLLLS28,'LsConversionPrintA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionPrint := GetProcAddress(hDLLLS28,'LsConversionPrintW');
        {$else}
          @LsConversionPrintO := GetProcAddress(hDLLLS28,'LsConversionPrintW');
      {$endif}
      @LsConversionConfigurationDlg := GetProcAddress(hDLLLS28,'LsConversionConfigurationDlg');
      {$ifdef UNICODE}
          @LsConversionSetOptionStringO := GetProcAddress(hDLLLS28,'LsConversionSetOptionStringA');
        {$else}
          @LsConversionSetOptionString := GetProcAddress(hDLLLS28,'LsConversionSetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionSetOptionString := GetProcAddress(hDLLLS28,'LsConversionSetOptionStringW');
        {$else}
          @LsConversionSetOptionStringO := GetProcAddress(hDLLLS28,'LsConversionSetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionGetOptionStringO := GetProcAddress(hDLLLS28,'LsConversionGetOptionStringA');
        {$else}
          @LsConversionGetOptionString := GetProcAddress(hDLLLS28,'LsConversionGetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionGetOptionString := GetProcAddress(hDLLLS28,'LsConversionGetOptionStringW');
        {$else}
          @LsConversionGetOptionStringO := GetProcAddress(hDLLLS28,'LsConversionGetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionConvertEMFToFileO := GetProcAddress(hDLLLS28,'LsConversionConvertEMFToFileA');
        {$else}
          @LsConversionConvertEMFToFile := GetProcAddress(hDLLLS28,'LsConversionConvertEMFToFileA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionConvertEMFToFile := GetProcAddress(hDLLLS28,'LsConversionConvertEMFToFileW');
        {$else}
          @LsConversionConvertEMFToFileO := GetProcAddress(hDLLLS28,'LsConversionConvertEMFToFileW');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionConvertStgToFileO := GetProcAddress(hDLLLS28,'LsConversionConvertStgToFileA');
        {$else}
          @LsConversionConvertStgToFile := GetProcAddress(hDLLLS28,'LsConversionConvertStgToFileA');
      {$endif}
      {$ifdef UNICODE}
          @LsConversionConvertStgToFile := GetProcAddress(hDLLLS28,'LsConversionConvertStgToFileW');
        {$else}
          @LsConversionConvertStgToFileO := GetProcAddress(hDLLLS28,'LsConversionConvertStgToFileW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStorageConvertO := GetProcAddress(hDLLLS28,'LlStgsysStorageConvertA');
        {$else}
          @LlStgsysStorageConvert := GetProcAddress(hDLLLS28,'LlStgsysStorageConvertA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStorageConvert := GetProcAddress(hDLLLS28,'LlStgsysStorageConvertW');
        {$else}
          @LlStgsysStorageConvertO := GetProcAddress(hDLLLS28,'LlStgsysStorageConvertW');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysConvertO := GetProcAddress(hDLLLS28,'LlStgsysConvertA');
        {$else}
          @LlStgsysConvert := GetProcAddress(hDLLLS28,'LlStgsysConvertA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysConvert := GetProcAddress(hDLLLS28,'LlStgsysConvertW');
        {$else}
          @LlStgsysConvertO := GetProcAddress(hDLLLS28,'LlStgsysConvertW');
      {$endif}
      {$ifdef UNICODE}
          @LsMailConfigurationDialogO := GetProcAddress(hDLLLS28,'LsMailConfigurationDialogA');
        {$else}
          @LsMailConfigurationDialog := GetProcAddress(hDLLLS28,'LsMailConfigurationDialogA');
      {$endif}
      {$ifdef UNICODE}
          @LsMailConfigurationDialog := GetProcAddress(hDLLLS28,'LsMailConfigurationDialogW');
        {$else}
          @LsMailConfigurationDialogO := GetProcAddress(hDLLLS28,'LsMailConfigurationDialogW');
      {$endif}
      @LsMailJobOpen        := GetProcAddress(hDLLLS28,'LsMailJobOpen');
      @LsMailJobClose       := GetProcAddress(hDLLLS28,'LsMailJobClose');
      {$ifdef UNICODE}
          @LsMailSetOptionStringO := GetProcAddress(hDLLLS28,'LsMailSetOptionStringA');
        {$else}
          @LsMailSetOptionString := GetProcAddress(hDLLLS28,'LsMailSetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LsMailSetOptionString := GetProcAddress(hDLLLS28,'LsMailSetOptionStringW');
        {$else}
          @LsMailSetOptionStringO := GetProcAddress(hDLLLS28,'LsMailSetOptionStringW');
      {$endif}
      {$ifdef UNICODE}
          @LsMailGetOptionStringO := GetProcAddress(hDLLLS28,'LsMailGetOptionStringA');
        {$else}
          @LsMailGetOptionString := GetProcAddress(hDLLLS28,'LsMailGetOptionStringA');
      {$endif}
      {$ifdef UNICODE}
          @LsMailGetOptionString := GetProcAddress(hDLLLS28,'LsMailGetOptionStringW');
        {$else}
          @LsMailGetOptionStringO := GetProcAddress(hDLLLS28,'LsMailGetOptionStringW');
      {$endif}
      @LsMailSendFile       := GetProcAddress(hDLLLS28,'LsMailSendFile');
      {$ifdef UNICODE}
          @LlStgsysStorageCreateO := GetProcAddress(hDLLLS28,'LlStgsysStorageCreateA');
        {$else}
          @LlStgsysStorageCreate := GetProcAddress(hDLLLS28,'LlStgsysStorageCreateA');
      {$endif}
      {$ifdef UNICODE}
          @LlStgsysStorageCreate := GetProcAddress(hDLLLS28,'LlStgsysStorageCreateW');
        {$else}
          @LlStgsysStorageCreateO := GetProcAddress(hDLLLS28,'LlStgsysStorageCreateW');
      {$endif}
      @LlStgsysAppendEMF    := GetProcAddress(hDLLLS28,'LlStgsysAppendEMF');
      {$ifdef UNICODE}
          @LsProfileStartO := GetProcAddress(hDLLLS28,'LsProfileStartA');
        {$else}
          @LsProfileStart := GetProcAddress(hDLLLS28,'LsProfileStartA');
      {$endif}
      {$ifdef UNICODE}
          @LsProfileStart := GetProcAddress(hDLLLS28,'LsProfileStartW');
        {$else}
          @LsProfileStartO := GetProcAddress(hDLLLS28,'LsProfileStartW');
      {$endif}
      @LsProfileEnd         := GetProcAddress(hDLLLS28,'LsProfileEnd');
      @LsGetOrgTextFromGlyphsW := GetProcAddress(hDLLLS28,'LsGetOrgTextFromGlyphsW');
      {$ifdef UNICODE}
          @LsMailViewO := GetProcAddress(hDLLLS28,'LsMailViewA');
        {$else}
          @LsMailView := GetProcAddress(hDLLLS28,'LsMailViewA');
      {$endif}
      {$ifdef UNICODE}
          @LsMailView := GetProcAddress(hDLLLS28,'LsMailViewW');
        {$else}
          @LsMailViewO := GetProcAddress(hDLLLS28,'LsMailViewW');
      {$endif}
      @LsInternalCreateViewerControlOverParent13 := GetProcAddress(hDLLLS28,'LsInternalCreateViewerControlOverParent13');
      @LsInternalGetViewerControlFromParent13 := GetProcAddress(hDLLLS28,'LsInternalGetViewerControlFromParent13');
      @LsSetDlgboxMode      := GetProcAddress(hDLLLS28,'LsSetDlgboxMode');
      @LsGetDlgboxMode      := GetProcAddress(hDLLLS28,'LsGetDlgboxMode');
      @LsGetViewerControlClassNameEx := GetProcAddress(hDLLLS28,'LsGetViewerControlClassNameEx');
      @LsGetDebug           := GetProcAddress(hDLLLS28,'LsGetDebug');
      @LsConvertImageStream := GetProcAddress(hDLLLS28,'LsConvertImageStream');
      @LlStgsysStoragePrintExW := GetProcAddress(hDLLLS28,'LlStgsysStoragePrintExW');
      @LsProcessEnhMetaFileRecord := GetProcAddress(hDLLLS28,'LsProcessEnhMetaFileRecord');
      @LlStgsysGetPageData  := GetProcAddress(hDLLLS28,'LlStgsysGetPageData');
      @LlStgsysSetUILanguage := GetProcAddress(hDLLLS28,'LlStgsysSetUILanguage');
      end;
    end;
end;

procedure LS28xUnload;
begin
  dec(nDLLLS28Usage);
  if (nDLLLS28Usage = 0) then
    begin
    if hDLLLS28 <> 0 then
      begin
      FreeLibrary(hDLLLS28);
      hDLLLS28 := 0;
      LlStgsysStorageOpen := NIL;
      LlStgsysStorageOpenO := NIL;
      LlStgsysStorageOpen := NIL;
      LlStgsysStorageOpenO := NIL;
      LlStgsysStorageClose := NIL;
      LlStgsysGetAPIVersion := NIL;
      LlStgsysGetFileVersion := NIL;
      LlStgsysGetFilename := NIL;
      LlStgsysGetFilenameO := NIL;
      LlStgsysGetFilename := NIL;
      LlStgsysGetFilenameO := NIL;
      LlStgsysGetJobCount := NIL;
      LlStgsysSetJob := NIL;
      LlStgsysGetJob := NIL;
      LlStgsysGetPageCount := NIL;
      LlStgsysGetJobOptionValue := NIL;
      LlStgsysGetPageOptionValue := NIL;
      LlStgsysGetPageOptionString := NIL;
      LlStgsysGetPageOptionStringO := NIL;
      LlStgsysGetPageOptionString := NIL;
      LlStgsysGetPageOptionStringO := NIL;
      LlStgsysSetPageOptionString := NIL;
      LlStgsysSetPageOptionStringO := NIL;
      LlStgsysSetPageOptionString := NIL;
      LlStgsysSetPageOptionStringO := NIL;
      LlStgsysGetPageOptionV := NIL;
      LlStgsysAppend := NIL;
      LlStgsysDeleteJob := NIL;
      LlStgsysDeletePage := NIL;
      LlStgsysGetPageMetafile := NIL;
      LlStgsysDestroyMetafile := NIL;
      LlStgsysDrawPage := NIL;
      LlStgsysGetLastError := NIL;
      LlStgsysDeleteFiles := NIL;
      LlStgsysPrint := NIL;
      LlStgsysPrintO := NIL;
      LlStgsysPrint := NIL;
      LlStgsysPrintO := NIL;
      LlStgsysStoragePrint := NIL;
      LlStgsysStoragePrintO := NIL;
      LlStgsysStoragePrint := NIL;
      LlStgsysStoragePrintO := NIL;
      LlStgsysGetPagePrinter := NIL;
      LlStgsysGetPagePrinterO := NIL;
      LlStgsysGetPagePrinter := NIL;
      LlStgsysGetPagePrinterO := NIL;
      LsSetDebug := NIL;
      LsGetViewerControlClassName := NIL;
      LsGetViewerControlClassNameO := NIL;
      LsGetViewerControlClassName := NIL;
      LsGetViewerControlClassNameO := NIL;
      LsGetViewerControlDefaultMessage := NIL;
      LsCreateViewerControlOverParent := NIL;
      LlStgsysGetJobOptionStringEx := NIL;
      LlStgsysGetJobOptionStringExO := NIL;
      LlStgsysGetJobOptionStringEx := NIL;
      LlStgsysGetJobOptionStringExO := NIL;
      LlStgsysSetJobOptionStringEx := NIL;
      LlStgsysSetJobOptionStringExO := NIL;
      LlStgsysSetJobOptionStringEx := NIL;
      LlStgsysSetJobOptionStringExO := NIL;
      LlStgsysGetJobOptionV := NIL;
      LsConversionJobOpen := NIL;
      LsConversionJobOpenO := NIL;
      LsConversionJobOpen := NIL;
      LsConversionJobOpenO := NIL;
      LsConversionJobClose := NIL;
      LsConversionConvertEMFToStream := NIL;
      LsConversionConvertStgToStream := NIL;
      LsConversionPrint := NIL;
      LsConversionPrintO := NIL;
      LsConversionPrint := NIL;
      LsConversionPrintO := NIL;
      LsConversionConfigurationDlg := NIL;
      LsConversionSetOptionString := NIL;
      LsConversionSetOptionStringO := NIL;
      LsConversionSetOptionString := NIL;
      LsConversionSetOptionStringO := NIL;
      LsConversionGetOptionString := NIL;
      LsConversionGetOptionStringO := NIL;
      LsConversionGetOptionString := NIL;
      LsConversionGetOptionStringO := NIL;
      LsConversionConvertEMFToFile := NIL;
      LsConversionConvertEMFToFileO := NIL;
      LsConversionConvertEMFToFile := NIL;
      LsConversionConvertEMFToFileO := NIL;
      LsConversionConvertStgToFile := NIL;
      LsConversionConvertStgToFileO := NIL;
      LsConversionConvertStgToFile := NIL;
      LsConversionConvertStgToFileO := NIL;
      LlStgsysStorageConvert := NIL;
      LlStgsysStorageConvertO := NIL;
      LlStgsysStorageConvert := NIL;
      LlStgsysStorageConvertO := NIL;
      LlStgsysConvert := NIL;
      LlStgsysConvertO := NIL;
      LlStgsysConvert := NIL;
      LlStgsysConvertO := NIL;
      LsMailConfigurationDialog := NIL;
      LsMailConfigurationDialogO := NIL;
      LsMailConfigurationDialog := NIL;
      LsMailConfigurationDialogO := NIL;
      LsMailJobOpen := NIL;
      LsMailJobClose := NIL;
      LsMailSetOptionString := NIL;
      LsMailSetOptionStringO := NIL;
      LsMailSetOptionString := NIL;
      LsMailSetOptionStringO := NIL;
      LsMailGetOptionString := NIL;
      LsMailGetOptionStringO := NIL;
      LsMailGetOptionString := NIL;
      LsMailGetOptionStringO := NIL;
      LsMailSendFile := NIL;
      LlStgsysStorageCreate := NIL;
      LlStgsysStorageCreateO := NIL;
      LlStgsysStorageCreate := NIL;
      LlStgsysStorageCreateO := NIL;
      LlStgsysAppendEMF := NIL;
      LsProfileStart := NIL;
      LsProfileStartO := NIL;
      LsProfileStart := NIL;
      LsProfileStartO := NIL;
      LsProfileEnd := NIL;
      LsGetOrgTextFromGlyphsW := NIL;
      LsMailView := NIL;
      LsMailViewO := NIL;
      LsMailView := NIL;
      LsMailViewO := NIL;
      LsInternalCreateViewerControlOverParent13 := NIL;
      LsInternalGetViewerControlFromParent13 := NIL;
      LsSetDlgboxMode := NIL;
      LsGetDlgboxMode := NIL;
      LsGetViewerControlClassNameEx := NIL;
      LsGetDebug := NIL;
      LsConvertImageStream := NIL;
      LlStgsysStoragePrintExW := NIL;
      LsProcessEnhMetaFileRecord := NIL;
      LlStgsysGetPageData := NIL;
      LlStgsysSetUILanguage := NIL;
      end;
    end;
end;

begin
end.
