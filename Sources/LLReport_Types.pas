{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLReport_Types.pas
 Module : LLReport_Types.pas
 Descr. : Implementation file for the List & Label 25 VCL-Component
 Version: 25.000
==================================================================================
}

unit LLReport_Types;

interface
{$WEAKPACKAGEUNIT ON}
Uses
  Windows, Classes, DB, Graphics, ObjTree, System.Contnrs, cmbtll25x;

Type

  cmbtHWND = DWORD_PTR; // needed for C++Builder compatibility

  // initialized enum values need to be continued - otherwise they cannot be used directly
  // as designer property, because it will disapear in the designer!
  // Please also see class TEnumTranslater with static translation functions

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

 TllDictionaryType = (dtStatic, dtIdentifier, dtTable, dtRelation, dtSortorder);

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
      class function TranslateDictionryType(DictionaryType: TllDictionaryType): Integer; static;
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

    procedure SetName(const Value: string);
    function  GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function  GetMasterSource: TDataSource;
    Procedure SetParentName(Avlue: String);
    Function  GetParentName : String;
    procedure LoadCompProperty(Reader: TReader);
    procedure StoreCompProperty(Writer: TWriter);
  protected
    function GetOwnerComponent: TComponent; virtual;
    function GenerateName: string; virtual;
    function GetDisplayName: string; override;
    Procedure MakeNodeToChild(ANode:TObjTreeNode); override;

    procedure DefineProperties(Filer: TFiler); Override;
  Public
    property    Owner: TComponent read GetOwnerComponent;
    property    OnSetName: TNotifyEvent read FOnSetName write FOnSetName;
    constructor Create(Collection: TCollection); override;
    Destructor  Destroy; Override;
    Function    AddChildNode: TObjTreeNode; Override;
    Property    ParentName:  String read GetParentName write SetParentName Stored True;
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
    FOwner: TComponent;
    function GetItem(Index: Integer): TDetailSourceItem;
    procedure SetItem(Index: Integer; Value: TDetailSourceItem);
  protected
    property OwnerComponent: TComponent read FOwner;
  public
    constructor Create(AOwner: TComponent; ADetailSourceItemClass: TDetailSourceItemClass);
    Destructor Destroy ; override;
    function Add: TDetailSourceItem;
    function ItemByName(AName: String): TDetailSourceItem;
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

class function TEnumTranslator.TranslateDictionryType(
  DictionaryType: TllDictionaryType): Integer;
begin
  //pre-define with default value in LL
  Result := LL_DICTIONARY_TYPE_STATIC;

  case DictionaryType of
    TllDictionaryType.dtStatic: Result := LL_DICTIONARY_TYPE_STATIC;
    TllDictionaryType.dtIdentifier: Result := LL_DICTIONARY_TYPE_IDENTIFIER;
    TllDictionaryType.dtTable: Result := LL_DICTIONARY_TYPE_TABLE;
    TllDictionaryType.dtRelation: Result := LL_DICTIONARY_TYPE_RELATION;
    TllDictionaryType.dtSortorder: Result := LL_DICTIONARY_TYPE_SORTORDER;
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
var
  I: Integer;
Begin
  for I := FDetailSources.Count-1 downto 0 do FDetailSources[i].Free;

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
  Collection.BeginUpdate;
  inherited Create(Collection);
  FName := GenerateName;

  OnSetName := UpdateEditorDisplay;

  FDataLink := TLLDataLink.Create;

  Collection.EndUpdate;
End;

destructor TDetailSourceItem.Destroy;
Begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
End;

Function  TDetailSourceItem.AddChildNode: TObjTreeNode;
Var node:TObjTreeNode;
Begin
  node:=TObjTreeNode(Collection.Add);
  MakeNodeToChild(node);
  result:=node;
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

Procedure TDetailSourceItem.MakeNodeToChild(ANode:TObjTreeNode);
Begin
  inherited MakeNodeToChild(ANode);
End;

procedure TDetailSourceItem.LoadCompProperty(Reader: TReader);
Var s : STring;
begin
   s:=Reader.ReadString;
   if s<>'' then ParentName := s;
end;

procedure TDetailSourceItem.StoreCompProperty(Writer: TWriter);
begin
   if ParentName<>'' then Writer.WriteString(ParentName);
end;

procedure TDetailSourceItem.DefineProperties(Filer: TFiler);
   function DoWrite: Boolean;
   begin
      Result := self.ParentNode <> nil;
   end;
begin
   inherited; { allow base classes to define properties }
   Filer.DefineProperty('ParentName', LoadCompProperty, StoreCompProperty, DoWrite);
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

function TDetailSourceItem.GetOwnerComponent: TComponent;
begin
  try
    Result := TDetailSourceList(Collection).OwnerComponent;
  except
    Result := nil;
  end;
end;

procedure TDetailSourceItem.SetName(const Value: string);
Begin
  if FName <> Value then
  begin
    if (TDetailSourceList(Collection).ItemByName(Value) <> nil) then
      raise EInvalidOperation.CreateFmt('Eine Detail-Source mit dem Namen %s existiert bereits.', [Value]);
    FName := Value;
    Changed(False);
    if Assigned(FOnSetName) then
      FOnSetName(self);
  end;
end;

Function TDetailSourceItem.GetDataSource: TDataSource;
begin
  Result := FDataLink.Datasource;
end;

Procedure TDetailSourceItem.SetDataSource(Value: TDataSource);
Begin
  if not((csLoading in Owner.ComponentState) and FDataLink.DataSourceFixed) then
  Begin
    if (Value<>nil) and (FDataLink.DataSource<>Value) then
    Begin
       FDataLink.Datasource := Value;
       Value.FreeNotification(Owner);
    End;
    if Assigned(FOnSetName) then FOnSetName(self);
  End;
end;

function TDetailSourceItem.GetMasterSource: TDataSource;
Begin
   if ParentNode<>nil then
      result:=TDetailSourceItem(ParentNode).Datasource
   else
      result:=nil;
End;

Procedure TDetailSourceItem.SetParentName(Avlue: String);
Var node : TDetailSourceItem;
Begin
   node:= TDetailSourceList(Collection).ItemByName(Avlue);
   if node<>nil then node.MakeNodeToChild(self);
End;

Function  TDetailSourceItem.GetParentName : String;
Begin
   if ParentNode<>nil then
      result:=TDetailSourceItem(ParentNode).Name
   else
      result:='';
End;

// =====================================================================
// TDetailSourcesList
// =====================================================================

constructor TDetailSourceList.Create(AOwner: TComponent; ADetailSourceItemClass: TDetailSourceItemClass);
Begin
  inherited Create(AOwner, ADetailSourceItemClass);
  FOwner := AOwner;
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

function TDetailSourceList.Add: TDetailSourceItem;
begin
  Result := TDetailSourceItem(inherited Add);
end;

function TDetailSourceList.ItemByName(AName: String): TDetailSourceItem;
var
  i: Integer;
begin

  Result := nil;
  for i := 0 to Count - 1 do
  Begin
    if AnsiCompareText(Items[i].Name, AName) = 0 then
    Begin
      Result := Items[i];
      Break;
    End;
  End;
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
