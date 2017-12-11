unit l22DataProvider;

interface
  uses l22interf,db,system.Generics.Collections,l22;
type
  TListLabelDataProvider = class;
  TListLabelTable = class;
  TListLabelTableRow = class;

  TDataProviderInterfaceProxyBase = class(TInterfacedObject)
  private
    FDataProvider: TListLabelDataProvider;
    FTable: TListLabelTable;
    FSortDescription: String;
    FParent: TL22_;
    FFilter: String;
    FAdvancedFilter: String;
    procedure SetDataProvider(const Value: TListLabelDataProvider);
    procedure SetAdvancedFilter(const Value: String);
    procedure SetFilter(const Value: String);
    procedure SetParent(const Value: TL22_);
    procedure SetSortDescription(const Value: String);
    procedure SetTable(const Value: TListLabelTable);
    procedure DefineData(Row: TListLabelTableRow; Level: Integer);

  protected
    property Provider: TListLabelDataProvider read FDataProvider write SetDataProvider;
    property Parent: TL22_ read FParent write SetParent;
    property Table: TListLabelTable read FTable write SetTable;
    property SortDescription: String read FSortDescription write SetSortDescription;
    property Filter: String read FFilter write SetFilter;
    property AdvancedFilter: String read FAdvancedFilter write SetAdvancedFilter;
    function ApplySortOrder(const pszSortOrder: PWideChar): HResult; stdcall;
    function ApplyFilter(arvFields: Variant; arvValues: Variant): HResult; stdcall;
    function ApplyAdvancedFilter(const pszFilter: PWideChar; arvValues: Variant): HResult; stdcall;
    function SetUsedIdentifiers(var arvVieldRestriction: Variant): HResult; stdcall;
  end;

  TDataProviderInterfaceProxyRoot = class(TDataProviderInterfaceProxyBase, ILlDataProvider)
  private
    function OpenTable(const pszTableName: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function GetRowCount(var pnRows: integer): HResult; stdcall;
    function MoveNext(): HResult; stdcall;
    function DefineRow(): HResult; stdcall;
    function Dispose(): HResult; stdcall;
  public
    constructor Create(ListLabel: TL22_; Provider: TListLabelDataProvider);
    destructor Destroy; override;
  end;

  TDataProviderInterfaceProxyNode = class(TDataProviderInterfaceProxyBase, ILlDataProvider)
  private
    FEnumerator: TEnumerator<TListLabelTableRow>;
    function OpenTable(const pszTableName: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
    function GetRowCount(var pnRows: integer): HResult; stdcall;
    function MoveNext(): HResult; stdcall;
    function DefineRow(): HResult; stdcall;
    function Dispose(): HResult; stdcall;
    procedure PrepareTable;
    procedure SetEnumerator(const Value: TEnumerator<TListLabelTableRow>);
    property Enumerator: TEnumerator<TListLabelTableRow> read FEnumerator write SetEnumerator;
  public
    constructor Create(ListLabel: TL22_; Table: TListLabelTable);
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
  uses classes, cmbtll22, sysutils;
{ TDataProviderRoot }

constructor TDataProviderInterfaceProxyRoot.Create(ListLabel: TL22_; Provider: TListLabelDataProvider);
begin
  inherited create;
  self.Provider := Provider;
  Parent := ListLabel;
  Table := nil;
end;

destructor TDataProviderInterfaceProxyRoot.Destroy;
begin
  inherited;
end;

function TDataProviderInterfaceProxyRoot.Dispose: HResult;
begin
  Result := S_OK;
end;

function TDataProviderInterfaceProxyRoot.DefineRow: HResult;
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
    TableInterface := ILlDataProvider(TDataProviderInterfaceProxyNode.Create(Parent, Table));
    ppUnkOfNewDataProvider := TableInterface;
  end;
  Result := S_OK;
end;

{ TDataProviderNode }

constructor TDataProviderInterfaceProxyNode.Create(ListLabel: TL22_; Table: TListLabelTable);
begin
  inherited create;
  self.Provider := Provider;
  Parent := ListLabel;
  self.Table := Table;
  Enumerator := nil;
end;


function TDataProviderInterfaceProxyNode.DefineRow: HResult;
var Row: TListLabelTableRow;
begin
    Row:= Enumerator.Current;
    DefineData(Row, 1);
    Row.Free;
    result:=S_OK;
end;

destructor TDataProviderInterfaceProxyNode.Destroy;
begin
  inherited;
end;

function TDataProviderInterfaceProxyNode.Dispose: HResult;
begin
  Enumerator.Free;
  Table.Free;
  Result := E_NOTIMPL;
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
begin
  if Enumerator = nil then
  begin
    PrepareTable;
  end;

  if Enumerator = nil then
  begin
    result := S_FALSE;
    exit;
  end;

  if (not Enumerator.MoveNext) then
  begin
    Dispose();
    result := S_FALSE;
    exit;
  end;

  result := S_OK;
end;

function TDataProviderInterfaceProxyNode.OpenChildTable(const pszRelation: PWideChar;
  out ppUnkOfNewDataProvider: ILlDataProvider): HResult;
var ChildTable: TListLabelTable;
    ChildProvider: ILlDataProvider;
begin
  ChildTable := Enumerator.Current.GetChildTable(Provider.GetRelation(pszRelation));
  ChildProvider := ILlDataProvider(TDataProviderInterfaceProxyNode.Create(Parent, ChildTable));
  ppUnkOfNewDataProvider := ChildProvider;
  Result := S_OK;
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
    Enumerable.Free;

  end;
end;

procedure TDataProviderInterfaceProxyNode.SetEnumerator(
  const Value: TEnumerator<TListLabelTableRow>);
begin
  FEnumerator := Value;
end;

{ TDataProviderInterfaceProxyBase }

function TDataProviderInterfaceProxyBase.ApplyAdvancedFilter(
  const pszFilter: PWideChar; arvValues: Variant): HResult;
begin
  AdvancedFilter := pszFilter;
  result := S_OK;
end;

function TDataProviderInterfaceProxyBase.ApplyFilter(arvFields,
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
begin
  ColumnList := Row.Columns;
  for Column in ColumnList do
  begin
    Parent.LlDefineFieldExt(Row.TableName+'.'+Column.ColumnName, Column.Content, Column.FieldType);
  end;
  ColumnList.Clear;
  ColumnList.Free;
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

procedure TDataProviderInterfaceProxyBase.SetParent(const Value: TL22_);
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
  var arvVieldRestriction: Variant): HResult;
begin
  result := S_OK;
end;

end.
