{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : L28FireDACInterfaces.pas
 Module : List & Label 28 FireDAC Interface definitions
 Descr. : Implementation file for the List & Label 28 VCL-Component
 Version: 28.000
==================================================================================
}

unit l28FireDACInterfaces;


interface
{$WEAKPACKAGEUNIT ON}

uses
	windows,
    activex,
    graphics,
    classes
    ,cmbtll28x;


const
  LLXOBJECT_OPTION_LANGUAGE			=1; // r/w, if call fails with E_FAIL, LL does not load this Function
  LLXOBJECT_OPTION_DEBUG				=2; // w/o, at startup
  LLXOBJECT_OPTION_CATCHWIDTH			=3; // w/o
  LLXOBJECT_OPTION_USABLE_IN_CELL		=4; // r/o
  LLXOBJECT_OPTION_USABLE_AS_OBJECT	=5; // r/o
  LLXOBJECT_OPTION_PLACEMENT			=6;
  LLXOBJECT_OPTION_HLIBRARY			=7;
  LLXOBJECT_OPTION_SUPPORTS_VARSIZE   =18;
  LLXFUNCTION_OPTION_LANGUAGE         =1;
  LLX_OBJECTNOTIFYSINK_UPDATEVIEWFLAG_OBJECTCHANGED =	2;
  LLXFUNCTION_OPTION_HLIBRARY         =3;
  LLXOBJECT_DESTINATION_WORKSPACE=	0;
  LLXOBJECT_DESTINATION_PREVIEW =	1;
  LLXOBJECT_DESTINATION_PRINTER =	2;
  LLXOBJECT_OPTION_USABLE_IN_STATIC_CELL	=26; // r/o
  LLXOBJECT_OPTION_BITMAP_SMALL = 38;
  LLXOBJECT_OPTION_BITMAP_LARGE= 39;


var
	CLSID_LLX:TGUID =                     (D1:$3cbae4e0;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
	IID_LLX_IBASE:TGUID =                 (D1:$3cbae4e1;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
	IID_LLX_IENUMOBJECTS:TGUID =          (D1:$3cbae4e8;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
	IID_LLX_IOBJECT:TGUID =               (D1:$3cbae4e9;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_ILLFONT:TGUID =               (D1:$3cbae4f2;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_ILLCOORDINATEPACKAGE: TGUID = (D1:$3cbae4f0;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_ILLNTFYSINK: TGUID =          (D1:$3cbae4f4;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_ILLAPIWRAPPER:TGUID =         (D1:$3cbae4f3;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_IENUMFUNCTIONS:TGUID=         (D1:$3cbae4e6;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_IFUNCTION:TGUID=              (D1:$3cbae4e7;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_LLX_ILLAUTORELEASEHANDLE:TGUID=   (D1:$3cbae4f1;D2:$8880;D3:$11d2;D4:($96,$a3,$00,$60,$08,$6f,$ef,$d5));
  IID_IUnknown: TGUID =                 (D1:$00000000;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
  g_nObjects: integer;

type
  TIID      = TGUID;
	TCLSID    = TGUID;
  OLEString = WideString;
  HLLJob    = integer;
  HPROFJOB  = longint;
  HPROFLIST = pChar;
  cmbtHWND  = DWORD_PTR;


ILlXInterface = interface(IUnknown)
    end;

ILlBase = interface(IUnknown)
  end;
pILlBase =Array[0..0] of ILlBase;


ILlXObjectNtfySink = interface(IUnknown)
  function UpdateView(const nFlags: cardinal; const bImmediate: boolean): HResult; stdcall;
      function SetActive(bLock: boolean): HResult; stdcall;
  end;
pILlXObjectNtfySink =Array[0..0] of ILlXObjectNtfySink;


ILlXObject = interface(IUnknown)
  function SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult;  stdcall;
  function GetName(var pbsName: OLEString): HResult;  stdcall;   // get name.
  function GetDescr(var pbsDescr: OLEString):HResult;  stdcall;  // get description
  function GetIcon(var phIcon: HIcon):HResult;  stdcall; // get icon (must be released by LLX Object)
  function IsProjectSupported(const nProjType: integer; var pbSupported: boolean): HResult; stdcall;  // is project type (LL_PROJECT_xxx) supported
  function SetOption (const nOption: integer; nValue: lParam): HResult;  stdcall;
  function GetOption (const nOption: integer; var pnValue: lParam): HResult; stdcall;
  function SetOptionString(const sOption: OLEString; sValue:OLEString): HResult; stdcall;
  function GetOptionString(const sOption: OLEString; var psValue:OLEString): HResult; stdcall;
  function SetParameters(pIStream: IStream): HResult; stdcall;
  function GetParameters(pIStream: IStream ): HResult;  stdcall;
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
  function GetVarSizeInfo(const hDC: HDC; const prcSpaceAvailable: pTRect; var pnMinHeight,pnIdealHeight: integer): HRESULT; stdcall;
  end;

  pILlXObject = Array[0..0] of ILlXObject;


//EnumObjects-Interface
ILlXEnumObjects = interface(IUnknown)
  function Next(nCount: cardinal; var Obj: pILlXObject; pnDone: PLongint): HResult;  stdcall;
  function Skip(nCount: cardinal): HResult;  stdcall;
  function Reset: HResult;  stdcall;
  function Clone(var Obj): HResult;  stdcall;
end;

ILlXFunction=Interface(IUnknown)
  function SetLLJob(hLLJob: HLLJob; pInfo: pILlBase): HResult;  stdcall;
  function SetOption (const nOption: integer; nValue: lParam): HResult;  stdcall;
  function GetOption (const nOption: integer; var pnValue: lParam): HResult; stdcall;
  function GetName(var pbsName: OLEString): HResult;  stdcall;   // get name.
  function GetDescr(var pbsDescr: OLEString):HResult;  stdcall;  // get description
  function GetGroups(var pbsDescr: OLEString):HResult;  stdcall;
  function GetGroupDescr(const bsGroup:OLEString; var pbsDescr:OLEString): HResult; stdcall;
  function GetParaCount(var pnMinParas,pnMaxParas: integer): HResult; stdcall;
  function GetParaTypes(var pnTypeRes, pnTypeArg1, pnTypeArg2, pnTypeArg3, pnTypeArg4: integer): HResult; stdcall;
  function CheckSyntax(var pbsError: OLEString; var pnTypeRes: integer; var pnTypeResLL: cardinal; var pnDecs: cardinal; const nArgs: cardinal; VarArg1,VarArg2,VarArg3,VarArg4: OleVariant): HResult; stdcall;
  function Execute(var pVarRes: OleVariant; var pnTypeRes: integer; var pnTypeResLL: cardinal; var pnDecs: cardinal; const nArgs: cardinal; VarArg1,VarArg2,VarArg3,VarArg4: OleVariant) : HResult; stdcall;
  function GetVisibleFlag(var pbVisible: boolean) : HResult; stdcall;
  function GetParaValueHint(const nPara: integer; var pbsHint,pbsTabbedList: OLEString): HResult; stdcall;// nPara = 0..3
end;
pILlXFunction = Array[0..0] of ILlXFunction;

ILlXEnumFunctions=Interface(IUnknown)
  function Next(nCount: cardinal; var Obj: pILlXFunction; pnDone: PLongint): HResult;  stdcall;
  function Skip(nCount: cardinal): HResult;  stdcall;
  function Reset: HResult;  stdcall;
  function Clone(var Obj): HResult;  stdcall;
end;

LlXInterface = class(TObject,IUnknown,ILlXInterface)
protected
  m_nRef: Integer;
  FObjList: TList;
  FFctList: TList;
public
  constructor Create(ObjList: TList; FctList: TList);
  destructor Destroy; override;
  function QueryInterface(const IID: TGUID; out Obj): HResult;  stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
end;


LlXEnumObjects=class(TObject,IUnknown,ILlXEnumObjects)
protected
  m_nRef: Integer;
  m_nIndex: Integer;
  FObjList: TList;
public
  constructor Create(ObjList: TList);
  destructor Destroy; override;
  function QueryInterface(const IID: TGUID; out Obj): HResult;  stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
  function Next(nCount: cardinal; var Obj: pILlXObject; pnDone: PLongint): HResult; stdcall;
  function Skip(nCount: cardinal): HResult; stdcall;
  function Reset: HResult; stdcall;
  function Clone(var Obj): HResult;  stdcall;
end;

LlXEnumFunctions = class(TObject,IUnknown,ILlXEnumFunctions)
protected
  m_nRef: Integer;
  m_nIndex: Integer;
  FFctList: TList;
public
  constructor Create(FctList: TList);
  destructor Destroy; override;
  function QueryInterface(const IID: TGUID; out Obj): HResult;  stdcall;
  function _AddRef: Integer; stdcall;
  function _Release: Integer; stdcall;
  function Next(nCount: cardinal; var Obj: pILlXFunction; pnDone: PLongint): HResult; stdcall;
  function Skip(nCount: cardinal): HResult; stdcall;
  function Reset: HResult;       stdcall;
  function Clone(var Obj): HResult;  stdcall;
end;


implementation

uses ListLabel28;
constructor LlXInterface.Create(ObjList: TList; FctList: TList);
begin
    inherited create;
    m_nRef := 0;
    FObjList:=ObjList;
    FFctList:=FctList;
end;

function LlXInterface._AddRef: Integer;
begin
      Result := InterlockedIncrement(m_nRef);
      InterlockedIncrement(g_nObjects);
end;

function LlXInterface._Release: Integer;
begin
      InterlockedDecrement(g_nObjects);
      Result := InterlockedDecrement(m_nRef);
      if Result = 0 then
      begin
          self.Destroy;
      end;
end;

function LlXInterface.QueryInterface(const IID: TGUID; out Obj): HResult;
var
    pEnumObj: LlXEnumObjects;
    pEnumFct: LlXEnumFunctions;
    pObj: IUnknown;
begin

    Result := S_OK;
    pointer(obj) := NIL;
    pointer(pObj):=nil;


    if IsEqualGuid(iid,IID_IUnknown) or IsEqualGuid(iid,IID_LLX_IBASE) then
    begin
      if IsEqualGuid(iid,IID_IUnknown) then
        IUnknown(Obj) := IUnknown(self)
      else
        ILlXInterface(Obj) := ILlXInterface(self);
      exit;
    end;

    if IsEqualGuid(iid,IID_LLX_IENUMOBJECTS) then
    begin
      pEnumObj := LlXEnumObjects.Create(FObjList);
      if pEnumObj = NIL then
          begin
            Result := E_OUTOFMEMORY;
            exit;
          end;
      Result := pEnumObj.QueryInterface(iid,pObj);
      if FAILED(Result) then
          begin
            pEnumObj.Free;
            Result := E_NOINTERFACE;
            exit;
          end
      else
        ILlXEnumObjects(obj) :=ILlXEnumObjects(pObj);
    end;

    if IsEqualGuid(iid,IID_LLX_IENUMFUNCTIONS) then
    begin
      pEnumFct := LlXEnumFunctions.Create(FFctList);
      if pEnumFct = NIL then
          begin
            Result := E_OUTOFMEMORY;
            exit;
          end;
      Result := pEnumFct.QueryInterface(iid,pObj);
      if FAILED(Result) then
          begin
            pEnumFct.Free;
            Result := E_NOINTERFACE;
            exit;
          end
      else
        ILlXEnumFunctions(obj) :=ILlXEnumFunctions(pObj);
    end;

    if pointer(obj) = NIL then result:=E_NOINTERFACE;
end;

destructor LlXInterface.Destroy;
begin
    inherited destroy;
end;

constructor LlXEnumObjects.Create(ObjList: TList);
begin
  inherited create;
	m_nIndex := 0;
  m_nRef := 0;
  FObjList:=ObjList;
end;



function LlXEnumObjects._AddRef: Integer;
begin
	Result := InterlockedIncrement(m_nRef);
  InterlockedIncrement(g_nObjects);
end;

function LlXEnumObjects._Release: Integer;
begin
  InterlockedDecrement(g_nObjects);
	Result := InterlockedDecrement(m_nRef);
	if Result = 0 then
    self.Destroy;
end;

function LlXEnumObjects.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
	Result := S_OK;
	pointer(obj) := NIL;

    if  IsEqualGuid(iid,IID_IUnknown) then
          IUnknown(obj) := IUnknown(self);
    if IsEqualGuid(iid,IID_LLX_IENUMOBJECTS) then
          ILlxEnumObjects(obj) := ILlxEnumObjects(self);

    if pointer(obj) = NIL then
        Result := E_NOINTERFACE;

end;

function LlXEnumObjects.Next(nCount: cardinal; var Obj: pILlXObject; pnDone: PLongint): HResult;
var
    pObject: TLlDesignerObject28;
    pObj: ILlXObject;
begin
    Obj[0] := NIL;
    pObj := NIL;
    pnDone^:=0;
    if m_nIndex <= FObjList.Count-1 then
    	begin
          pObject := TLlDesignerObject28(FObjList[m_nIndex]);
          if FAILED(pObject.QueryInterface(IID_LLX_IOBJECT,pObj)) then
              begin
              pObject.Free;
              Result := E_FAIL;
              exit;
              end;
          Obj[0] := pObj;
          pObj:=nil;

        inc(m_nIndex);
        inc(pnDone^);
        end;
    Result := S_OK;
end;

function LlXEnumObjects.Skip(nCount: cardinal): HResult;
begin
	inc(m_nIndex,nCount);
	if m_nIndex < 0 then
		begin
		m_nIndex := 0;
		Result := E_FAIL;
        exit;
        end;
	if m_nIndex > FObjList.Count then
		begin
		m_nIndex := FObjList.Count;
		Result := E_FAIL;
        exit;
        end;
	Result := S_OK;
end;

function LlXEnumObjects.Reset: HResult;
begin
	m_nIndex := 0;
	Result := S_OK;
end;

function LlXEnumObjects.Clone(var Obj): HResult;
begin
	Result := E_NOTIMPL;
end;

destructor LlXEnumObjects.Destroy;
begin
    inherited destroy;
end;


constructor LlXEnumFunctions.Create(FctList: TList);
begin
    inherited create;
	m_nIndex := 0;
    m_nRef := 0;
    FFctList:=FctList;
end;

function LlXEnumFunctions._AddRef: Integer;
begin
  	Result := InterlockedIncrement(m_nRef);
    InterlockedIncrement(g_nObjects);
end;

function LlXEnumFunctions._Release: Integer;
begin
    InterlockedDecrement(g_nObjects);
	Result := InterlockedDecrement(m_nRef);
  	if Result = 0 then
        self.Destroy;
end;

function LlXEnumFunctions.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
	Result := S_OK;
	pointer(obj) := NIL;

    if  IsEqualGuid(iid,IID_IUnknown) then
          IUnknown(obj) := IUnknown(self);
    if IsEqualGuid(iid,IID_LLX_IENUMFUNCTIONS) then
          ILlXEnumFunctions(obj) := ILlXEnumFunctions(self);

    if pointer(obj) = NIL then
        Result := E_NOINTERFACE;

end;

function LlXEnumFunctions.Next(nCount: cardinal; var Obj: pILlXFunction; pnDone: PLongint): HResult;
var
    pFunction: TLlDesignerFunction28;
    pObj: ILlXFunction;
begin
    Obj[0] := NIL;
    pObj := NIL;
    pnDone^:=0;
    if m_nIndex <= FFctList.Count-1 then
    	begin
          pFunction := TLlDesignerFunction28(FFctList[m_nIndex]);
          if FAILED(pFunction.QueryInterface(IID_LLX_IFUNCTION,pObj)) then
              begin
              pFunction.Free;
              Result := E_FAIL;
              exit;
              end;
          Obj[0] := pObj;
          pObj:=nil;

        inc(m_nIndex);
        inc(pnDone^);
        end;
    Result := S_OK;
end;

function LlXEnumFunctions.Skip(nCount: cardinal): HResult;
begin
	inc(m_nIndex,nCount);
	if m_nIndex < 0 then
		begin
		m_nIndex := 0;
		Result := E_FAIL;
        exit;
        end;
	if m_nIndex > FFctList.Count then
		begin
		m_nIndex := FFctList.Count;
		Result := E_FAIL;
        exit;
        end;
	Result := S_OK;
end;

function LlXEnumFunctions.Reset: HResult;
begin
	m_nIndex := 0;
	Result := S_OK;
end;

function LlXEnumFunctions.Clone(var Obj): HResult;
begin
	Result := E_NOTIMPL;
end;

destructor LlXEnumFunctions.Destroy;
begin
    inherited destroy;
end;


end.

