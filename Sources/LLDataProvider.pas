{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLDataProvider.pas
 Module : List & Label 29
 Descr. : Implementation file for the List & Label 29 VCL-Component
 Version: 29.001
==================================================================================
}

unit LLDataProvider;

interface
{$WEAKPACKAGEUNIT ON}
  uses ListLabelDataProviderInterface, system.Generics.Collections, Classes, windows, llreport_types;

type
  TListLabelDataProvider = class;
  TListLabelTable = class;
  TListLabelTableRow = class;

  TDataProviderInterfaceProxyBase = class(TInterfacedObject)
  private
    FDataProvider: TListLabelDataProvider;
    FTable: TListLabelTable;
    FSortDescription: String;
    FParent: TComponent;
    FFilter: String;
    FAdvancedFilter: String;
    procedure SetDataProvider(const Value: TListLabelDataProvider);
    procedure SetAdvancedFilter(const Value: String);
    procedure SetFilter(const Value: String);
    procedure SetParent(const Value: TComponent);
    procedure SetSortDescription(const Value: String);
    procedure SetTable(const Value: TListLabelTable);
    procedure DefineData(Row: TListLabelTableRow; Level: Integer);

  protected
    property Provider: TListLabelDataProvider read FDataProvider write SetDataProvider;
    property Parent: TComponent read FParent write SetParent;
    property Table: TListLabelTable read FTable write SetTable;
    property SortDescription: String read FSortDescription write SetSortDescription;
    property Filter: String read FFilter write SetFilter;
    property AdvancedFilter: String read FAdvancedFilter write SetAdvancedFilter;
    function ApplySortOrder(const pszSortOrder: PWideChar): HResult; stdcall;
    function ApplyFilter(const arvFields: Variant; const arvValues: Variant): HResult; stdcall;
    function ApplyAdvancedFilter(const pszFilter: PWideChar; const arvValues: Variant): HResult; stdcall;
    function SetUsedIdentifiers(const arvVieldRestriction: Variant): HResult; stdcall;
    function SetOption(nIndex: integer; const pvValue: Variant): HResult; stdcall;
    function GetOption(nIndex: integer; var pvValue: Variant): HResult; stdcall;
    function DefineDelayedInfo(nInfo: integer): HResult; stdcall;
  end;

  TDataProviderInterfaceProxyRoot = class(TDataProviderInterfaceProxyBase, ILlDataProvider)
  private
    function OpenTable(const pszTableName: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function GetRowCount(var pnRows: integer): HResult; stdcall;
    function MoveNext(): HResult; stdcall;
    function DefineRow(enDefineRowMode: DefineDelayedInfoType; const arvRelations: Variant): HResult; stdcall;
    function Dispose(): HResult; stdcall;
  public
    constructor Create(ListLabel: TComponent; AProvider: TListLabelDataProvider);
    destructor Destroy; override;
  end;

  TDataProviderInterfaceProxyNode = class(TDataProviderInterfaceProxyBase, ILlDataProvider)
  private
    FEnumerator: TEnumerator<TListLabelTableRow>;
    function OpenTable(const pszTableName: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function GetRowCount(var pnRows: integer): HResult; stdcall;
    function MoveNext(): HResult; stdcall;
    function DefineRow(enDefineRowMode: DefineDelayedInfoType; const arvRelations: Variant): HResult; stdcall;
    function Dispose(): HResult; stdcall;
    procedure PrepareTable;
    procedure SetEnumerator(const Value: TEnumerator<TListLabelTableRow>);
    property Enumerator: TEnumerator<TListLabelTableRow> read FEnumerator write SetEnumerator;
  public
    constructor Create(AProvider: TListLabelDataProvider; ListLabel: TComponent; ATable: TListLabelTable);
    destructor Destroy; override;
  end;

  TListLabelTableRelation = class;
  TListLabelDataProvider = class
  public
    function Tables: TObjectList<TListLabelTable>; virtual; abstract;
    function Relations: TObjectList<TListLabelTableRelation>; virtual; abstract;
    function GetTable(TableName: string): TListLabelTable; virtual; abstract;
    function GetRelation(RelationName: string) : TListLabelTableRelation; virtual; abstract;
  end;

  TListLabelTableRelation = class
    function RelationName: String; virtual; abstract;
    function ParentColumnName: String; virtual; abstract;
    function ChildColumnName: String; virtual; abstract;
    function ParentTableName: String; virtual; abstract;
    function ChildTableName: String; virtual; abstract;
  end;

  TListLabelTable = class
    function SupportsCount: Boolean; virtual; abstract;
    function SupportsSorting: Boolean; virtual; abstract;
    function SupportsAdvancedSorting: Boolean; virtual; abstract;
    function SupportsFiltering: Boolean; virtual; abstract;
    procedure ApplySort(SortDescription: String); virtual; abstract;
    procedure ApplyFilter(Filter: String); virtual; abstract;
    function Count: Integer; virtual; abstract;
    function TableName: String; virtual; abstract;
    function Rows: TEnumerable<TListLabelTableRow>; virtual; abstract;
    function SortDescriptions: TList<String>; virtual; abstract;
    function SchemaRow: TListLabelTableRow; virtual; abstract;
  end;

  TListLabelTableColumn = class
    function ColumnName: String; virtual; abstract;
    function Content: String; virtual; abstract;
    function ImgHandle: Cardinal; virtual; abstract;
    function FieldType: Integer; virtual; abstract;
  end;

  TListLabelTableRow = class
    function SupportsGetParentRow: Boolean; virtual; abstract;
    function TableName: String; virtual; abstract;
    function Columns: TObjectList<TListLabelTableColumn>; virtual; abstract;
    function GetChildTable(Relation: TListLabelTableRelation): TListLabelTable; virtual; abstract;
    function GetParentRow(Relation: TListLabelTableRelation): TListLabelTableRow; virtual; abstract;
  end;

implementation
  uses  sysutils, ListLabel29;
{ TDataProviderRoot }

constructor TDataProviderInterfaceProxyRoot.Create(ListLabel: TComponent; AProvider: TListLabelDataProvider);
begin
  inherited create;
  Provider := AProvider;
  Parent   := ListLabel;
  Table    := nil;
end;

destructor TDataProviderInterfaceProxyRoot.Destroy;
begin
  inherited;
end;

function TDataProviderInterfaceProxyRoot.Dispose: HResult;
begin
  Result := S_OK;
end;

function TDataProviderInterfaceProxyRoot.DefineRow(enDefineRowMode: DefineDelayedInfoType; const arvRelations: Variant): HResult;
begin
  Result := E_NOTIMPL;
end;


function TDataProviderInterfaceProxyRoot.GetRowCount(var pnRows: integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDataProviderInterfaceProxyRoot.MoveNext: HResult;
begin
  Result := E_NOTIMPL;
end;

function TDataProviderInterfaceProxyRoot.OpenChildTable(const pszRelation: PWideChar;
  out ppUnkOfNewDataProvider: ILlDataProvider): HResult;
begin
  ppUnkOfNewDataProvider:=nil;
  Result := E_NOTIMPL;
end;

function TDataProviderInterfaceProxyRoot.OpenTable(const pszTableName: PWideChar;
  out ppUnkOfNewDataProvider: ILlDataProvider): HResult;
  var Table: TListLabelTable;
  TableInterface: ILlDataProvider;
begin
  Table := Provider.GetTable(pszTableName);

  if (Table <> nil) then
  begin
    TableInterface := ILlDataProvider(TDataProviderInterfaceProxyNode.Create(FDataProvider, Parent, Table));
    ppUnkOfNewDataProvider := TableInterface;
  end;
  Result := S_OK;
end;

{ TDataProviderNode }

constructor TDataProviderInterfaceProxyNode.Create(AProvider: TListLabelDataProvider;ListLabel: TComponent; ATable: TListLabelTable);
begin
  inherited create;
  Provider      := AProvider;
  Parent        := ListLabel;
  Table         := ATable;
  Enumerator    := nil;
end;


function TDataProviderInterfaceProxyNode.DefineRow(enDefineRowMode: DefineDelayedInfoType; const arvRelations: Variant): HResult;
var Row: TListLabelTableRow;
begin

    if (Enumerator = nil)
      Or (enDefineRowMode = DefineDelayedInfoType.diSortOrdersDesigning)
    then
    begin
      result := S_FALSE;
      exit;
    end;

    Row:= Enumerator.Current;
    DefineData(Row, 1);
    Row.Free;
    result:=S_OK;
end;

destructor TDataProviderInterfaceProxyNode.Destroy;
begin
  inherited;
  Dispose;
end;

function TDataProviderInterfaceProxyNode.Dispose: HResult;
begin
  if Assigned(Enumerator) then FreeAndNil(FEnumerator);
  if  Assigned(FTable) then FreeAndNil(FTable);
  Result := S_OK;
end;

function TDataProviderInterfaceProxyNode.GetRowCount(var pnRows: integer): HResult;
begin
  if Table.SupportsCount then
  begin
    pnRows := Table.Count;
    Result := S_OK;
  end
  else
    Result := S_FALSE;
end;

function TDataProviderInterfaceProxyNode.MoveNext: HResult;
var bInitFirstTime: boolean;
begin
  bInitFirstTime := False;
  if Enumerator = nil then
  begin
    bInitFirstTime := True;
    PrepareTable;
  end;

  if Enumerator = nil then
  begin
    result := S_FALSE;
    exit;
  end;

  if (not bInitFirstTime) and (not Enumerator.MoveNext) then
  begin
    Dispose();
    result := S_FALSE;
    exit;
  end;

  result := S_OK;

end;

function TDataProviderInterfaceProxyNode.OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult;
var
  TableRelation: TListLabelTableRelation;
  TableRow: TListLabelTableRow;
  ChildTable: TListLabelTable;
  ChildProvider: ILlDataProvider;
begin
  ppUnkOfNewDataProvider:= nil;
  Result := E_NOTIMPL;

  TableRelation := Provider.GetRelation(pszRelation);
  if(Assigned(TableRelation))then
  begin
    TableRow := Enumerator.Current;
    ChildTable := TableRow.GetChildTable(TableRelation);
    ChildProvider := ILlDataProvider(TDataProviderInterfaceProxyNode.Create(FDataProvider, Parent, ChildTable));
    ppUnkOfNewDataProvider := ChildProvider;
    TableRow.Free;
    Result := S_OK;
  end;
end;


function TDataProviderInterfaceProxyNode.OpenTable(const pszTableName: PWideChar;
  out ppUnkOfNewDataProvider: ILlDataProvider): HResult;
begin
  ppUnkOfNewDataProvider:= nil;
  Result := E_NOTIMPL;
end;


procedure TDataProviderInterfaceProxyNode.PrepareTable;
var Enumerable : TEnumerable<TListLabelTableRow>;
begin
  if (Table <> nil) then
  begin
    Table.ApplyFilter(Filter);

    if (SortDescription <> '') and (Table.SupportsSorting or Table.SupportsAdvancedSorting) then
      Table.ApplySort(SortDescription);
    Enumerable := Table.Rows;
    Enumerator := Enumerable.GetEnumerator();
    FreeAndNil(Enumerable);
  end;
end;

procedure TDataProviderInterfaceProxyNode.SetEnumerator(
  const Value: TEnumerator<TListLabelTableRow>);
begin
  FEnumerator := Value;
end;

{ TDataProviderInterfaceProxyBase }

function TDataProviderInterfaceProxyBase.ApplyAdvancedFilter(
  const pszFilter: PWideChar; const arvValues: Variant): HResult;
begin
  AdvancedFilter := pszFilter;
  result := S_OK;
end;

function TDataProviderInterfaceProxyBase.ApplyFilter(const arvFields,
  arvValues: Variant): HResult;
begin
  result := S_OK;
end;

function TDataProviderInterfaceProxyBase.ApplySortOrder(
  const pszSortOrder: PWideChar): HResult;
begin
  SortDescription:=pszSortOrder;
  result := S_OK;
end;

procedure TDataProviderInterfaceProxyBase.DefineData(Row: TListLabelTableRow;
  Level: Integer);
var Column: TListLabelTableColumn;
    ColumnList: TObjectList<TListLabelTableColumn>;
    AsVariables: Boolean;
begin
  ColumnList := Row.Columns;
  ColumnList.OwnsObjects := True;
  AsVariables:= (TListLabel29(Parent).DataController.DataMember = Row.TableName) and (TListLabel29(Parent).DataController.AutoMasterMode = TLlAutoMasterMode.mmAsVariables);

   if ((TListLabel29(Parent).AutoProjectType) <> TLlProject.ptList) then
    begin
    if Assigned(TListLabel29(Parent).OnAutoDefineNewPage) then
      TListLabel29(Parent).OnAutoDefineNewPage(self, false);
    end;


  for Column in ColumnList do
  begin
     if Column.ImgHandle > 0 Then
     begin
      if AsVariables then
          TListLabel29(Parent).Core.LlDefineVariableExtHandle(Row.TableName+'.'+Column.ColumnName, Column.ImgHandle, Column.FieldType)
        else
          TListLabel29(Parent).Core.LlDefineFieldExtHandle(Row.TableName+'.'+Column.ColumnName, Column.ImgHandle, Column.FieldType)
     end
     else
     begin
      if AsVariables then
        TListLabel29(Parent).Core.LlDefineVariableExt(Row.TableName+'.'+Column.ColumnName, Column.Content, Column.FieldType)
      else
        TListLabel29(Parent).Core.LlDefineFieldExt(Row.TableName+'.'+Column.ColumnName, Column.Content, Column.FieldType);
     end;
   end;
  ColumnList.Clear;
  ColumnList.Free;
end;

function TDataProviderInterfaceProxyBase.DefineDelayedInfo(
  nInfo: integer): HResult;
begin
result := S_OK;
end;

function TDataProviderInterfaceProxyBase.GetOption(nIndex: integer;
  var pvValue: Variant): HResult;
begin
   result := S_FALSE;
end;

procedure TDataProviderInterfaceProxyBase.SetAdvancedFilter(
  const Value: String);
begin
  FAdvancedFilter := Value;
end;

procedure TDataProviderInterfaceProxyBase.SetDataProvider(
  const Value: TListLabelDataProvider);
begin
  FDataProvider := Value;
end;

procedure TDataProviderInterfaceProxyBase.SetFilter(const Value: String);
begin
  FFilter := Value;
end;

function TDataProviderInterfaceProxyBase.SetOption(nIndex: integer;
  const pvValue: Variant): HResult;
begin
  result := S_OK;
end;

procedure TDataProviderInterfaceProxyBase.SetParent(const Value: TComponent);
begin
  FParent := Value;
end;

procedure TDataProviderInterfaceProxyBase.SetSortDescription(
  const Value: String);
begin
  FSortDescription := Value;
end;

procedure TDataProviderInterfaceProxyBase.SetTable(
  const Value: TListLabelTable);
begin
  FTable := Value;
end;

function TDataProviderInterfaceProxyBase.SetUsedIdentifiers(
  const arvVieldRestriction: Variant): HResult;
begin
  result := S_OK;
end;

end.
