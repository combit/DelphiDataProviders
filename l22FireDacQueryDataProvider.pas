unit l22FireDacQueryDataProvider;


interface
uses l22DataProvider,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, l22, cmbtll22,l22interf,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, system.Generics.Collections;

type
  TFDQuerySetDataProvider = class(TListLabelDataProvider)
  private
    FQueries: TDictionary<String, TFDQuery>;
  public
    constructor Create;
    destructor Destroy; override;
    function Tables: TObjectList<TListLabelTable>; override;
    function Relations: TObjectList<TListLabelTableRelation>; override;
    function GetTable(TableName: string): TListLabelTable; override;
    function GetRelation(RelationName: string) : TListLabelTableRelation; override;
    procedure AddQuery(Query: TFDQuery; TableName: String);
  end;

  TFDQueryTable = class(TListLabelTable)
  private
    FQuery: TFDQuery;
    FTableName: String;
  public
    function SupportsCount: Boolean; override;
    function SupportsSorting: Boolean; override;
    function SupportsAdvancedSorting: Boolean; override;
    function SupportsFiltering: Boolean; override;
    procedure ApplySort(SortDescription: String); override;
    procedure ApplyFilter(Filter: String); override;
    function Count: Integer; override;
    function TableName: String; override;
    function Rows: TEnumerable<TListLabelTableRow>; override;
    function SortDescriptions: TList<String>; override;
    function SchemaRow: TListLabelTableRow; override;
    constructor Create(Query: TFDQuery; TableName: String);
    destructor Destroy; override;
  end;

  TFDQueryTableRow = class(TListLabelTableRow)
  private
    FTable: TFDQueryTable;
    FQuery: TFDQuery;
  public
    function SupportsGetParentRow: Boolean; override;
    function TableName: String; override;
    function Columns: TObjectList<TListLabelTableColumn>; override;
    function GetChildTable(Relation: TListLabelTableRelation): TListLabelTable; override;
    function GetParentRow(Relation: TListLabelTableRelation): TListLabelTableRow; override;
    constructor Create(Table: TFDQueryTable; Query: TFDQuery);
  end;

  TFDQueryTableRowEnumerable = class(TEnumerable<TListLabelTableRow>)
  private
    FQuery: TFDQuery;
    FTableName: String;
  protected
    function DoGetEnumerator: TEnumerator<TListLabelTableRow>; override;
  public
    constructor Create(Query: TFDQuery; TableName: string);
  end;

  TFDQueryTableRowEnumerator = class(TEnumerator<TListLabelTableRow>)
  private
    FQuery: TFDQuery;
    FTableName: String;
  protected
    function DoGetCurrent: TListLabelTableRow; override;
    function DoMoveNext: Boolean; override;
  public
    constructor Create(Query: TFDQuery; TableName: string);
  end;

  TTFieldsTableRow = class(TListLabelTableRow)
  private
    FFields: TFields;
    FTableName: String;
  public
    function SupportsGetParentRow: Boolean; override;
    function TableName: String; override;
    function Columns: TObjectList<TListLabelTableColumn>; override;
    function GetChildTable(Relation: TListLabelTableRelation): TListLabelTable; override;
    function GetParentRow(Relation: TListLabelTableRelation): TListLabelTableRow; override;
    constructor Create(Fields: TFields; TableName: String);
  end;

  TTFieldTableColumn = class(TListLabelTableColumn)
  private
    FFieldName: String;
    FFieldContent: String;
    FFieldType: Integer;
  public
    function ColumnName: String; override;
    function Content: String; override;
    function FieldType: Integer; override;
    constructor Create(Field: TField);
  end;

implementation
uses Sysutils;
{ TFDQueryDataProvider }

procedure TFDQuerySetDataProvider.AddQuery(Query: TFDQuery; TableName: String);
begin
  FQueries.Add(TableName, Query);
end;

constructor TFDQuerySetDataProvider.Create;
begin
  inherited Create;
  FQueries:=TDictionary<String, TFDQuery>.Create();
end;

destructor TFDQuerySetDataProvider.Destroy;
begin
  FQueries.Free;
  inherited Destroy;
end;

function TFDQuerySetDataProvider.GetRelation(
  RelationName: string): TListLabelTableRelation;
begin
  result:=nil;
end;

function TFDQuerySetDataProvider.GetTable(TableName: string): TListLabelTable;
var Table: TListLabelTable;
var TableList: TObjectList<TListLabelTable>;
begin
  result := nil;
  TableList := Tables;
  for Table in TableList do
  begin
    if Table.TableName = TableName then
    begin
      TableList.OwnsObjects := false;
      result := Table;
      TableList.Remove(result);
      TableList.OwnsObjects := true;
      break;
    end;
  end;
  TableList.Free;
end;

function TFDQuerySetDataProvider.Relations: TObjectList<TListLabelTableRelation>;
begin
  result:=nil;
end;

function TFDQuerySetDataProvider.Tables: TObjectList<TListLabelTable>;
var Tables: TObjectList<TListLabelTable>;
    TableName: String;
begin
  Tables:=TObjectList<TListLabelTable>.Create;
  for TableName in FQueries.Keys do
  begin
    Tables.Add(TFDQueryTable.Create(FQueries[TableName], TableName))
  end;
  result:=Tables;
end;

{ TFDQueryTable }

procedure TFDQueryTable.ApplyFilter(Filter: String);
begin
  inherited;
end;

procedure TFDQueryTable.ApplySort(SortDescription: String);
begin
  inherited;
end;

function TFDQueryTable.Count: Integer;
begin
  result:=-1;
end;

constructor TFDQueryTable.Create(Query: TFDQuery; TableName: String);
begin
  inherited Create;
  FQuery := Query;
  FTableName := TableName;
end;

destructor TFDQueryTable.Destroy;
begin
  inherited Destroy;
end;

function TFDQueryTable.Rows: TEnumerable<TListLabelTableRow>;
begin
  result:=TFDQueryTableRowEnumerable.Create(FQuery, TableName);
end;

function TFDQueryTable.SchemaRow: TListLabelTableRow;
begin
  result := nil;
end;

function TFDQueryTable.SortDescriptions: TList<String>;
begin
  result := nil;
end;

function TFDQueryTable.SupportsAdvancedSorting: Boolean;
begin
  result := false;
end;

function TFDQueryTable.SupportsCount: Boolean;
begin
  result := false;
end;

function TFDQueryTable.SupportsFiltering: Boolean;
begin
  result := false;
end;

function TFDQueryTable.SupportsSorting: Boolean;
begin
  result := false;
end;

function TFDQueryTable.TableName: String;
begin
  result := FTableName;
end;

{ TFDQueryTableRow }

function TFDQueryTableRow.Columns: TObjectList<TListLabelTableColumn>;
begin
  result:=TTFieldsTableRow.Create(FQuery.Fields, TableName).Columns;
end;

constructor TFDQueryTableRow.Create(Table: TFDQueryTable; Query: TFDQuery);
begin
  FTable:=Table;
  FQuery:=Query;
end;

function TFDQueryTableRow.GetChildTable(
  Relation: TListLabelTableRelation): TListLabelTable;
begin
  result := nil;
end;

function TFDQueryTableRow.GetParentRow(
  Relation: TListLabelTableRelation): TListLabelTableRow;
begin
  result := nil;
end;

function TFDQueryTableRow.SupportsGetParentRow: Boolean;
begin
  result := false;
end;

function TFDQueryTableRow.TableName: String;
begin
  result:=FTable.TableName;
end;

{ TFDQueryTableRowEnumerator }

constructor TFDQueryTableRowEnumerator.Create(Query: TFDQuery; TableName: String);
begin
  FQuery := Query;
  FQuery.First;
  FTableName := TableName;
end;

function TFDQueryTableRowEnumerator.DoGetCurrent: TListLabelTableRow;
begin
  result:=TTFieldsTableRow.Create(FQuery.Fields, FTableName);
end;

function TFDQueryTableRowEnumerator.DoMoveNext: Boolean;
begin
  if FQuery.Eof then
    result:=false
  else
  begin
    FQuery.Next;
    result:=true;
  end;

end;

{ TTFieldsTableRow }

function TTFieldsTableRow.Columns: TObjectList<TListLabelTableColumn>;
var
  ResultList: TObjectList<TListLabelTableColumn>;
  Field: TField;
begin
  ResultList:=TObjectList<TListLabelTableColumn>.Create();
  for Field in FFields do
  begin
    ResultList.Add(TTFieldTableColumn.Create(Field));
  end;
  result:=ResultList;
end;

constructor TTFieldsTableRow.Create(Fields: TFields; TableName: String);
begin
  FFields:=Fields;
  FTableName:=TableName;
end;

function TTFieldsTableRow.GetChildTable(
  Relation: TListLabelTableRelation): TListLabelTable;
begin
  result := nil;
end;

function TTFieldsTableRow.GetParentRow(
  Relation: TListLabelTableRelation): TListLabelTableRow;
begin
  result := nil;
end;

function TTFieldsTableRow.SupportsGetParentRow: Boolean;
begin
  result := false;
end;

function TTFieldsTableRow.TableName: String;
begin
  result := FTableName;
end;

{ TTFieldTableColumn }

function TTFieldTableColumn.ColumnName: String;
begin
  result:=FFieldName;
end;

function TTFieldTableColumn.Content: String;
begin
  result:=FFieldContent;
end;

constructor TTFieldTableColumn.Create(Field: TField);
  const DigitBool: array[Boolean] of string = ('0', '1');
  begin
    FFieldName:=Field.FieldName;
{$ifdef  ADOAVAILABLE}
    case Field.DataType of
      ftInteger, ftsmallint, ftAutoInc,
      ftFloat, ftWord, ftLargeint:           {numeric}
{$else}
    case Field.DataType of
      ftInteger, ftsmallint, ftAutoInc,
      ftFloat, ftWord:           {numeric}
{$endif}
        begin
          FFieldType := LL_NUMERIC;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
          FFieldContent := Field.AsString;
        end;
      ftDate, ftDateTime, ftTimeStamp:         {date}
        begin
          FFieldType := LL_DATE_DELPHI;
          {Flag invalid date or null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
            FFieldContent := FloatToStr(StrToDateTime(Field.AsString));
        end;
      ftBoolean:                  {boolean}
        begin
          FFieldType := LL_BOOLEAN;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
          FFieldContent := DigitBool[Field.AsBoolean];
        end;
      ftCurrency:
        begin
          FFieldType := LL_NUMERIC;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
          FFieldContent := Field.AsString;
        end;
      ftBCD
      {$ifdef ADOAVAILABLE}
      , ftfmtBCD
      {$endif}
      :
        begin
          FFieldType := LL_NUMERIC;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
          FFieldContent := Field.AsString
        end;
      {$ifdef UNICODE}
      {$ifdef ADOAVAILABLE}
      ftWideString:
        begin
            FFieldType:=LL_TEXT;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
            FFieldContent:=TWideStringField(Field).Value;
        end
      {$endif}
       {$endif}
        else
          begin        {text variables}
            FFieldType := LL_TEXT;
          {Flag null value}
          if Field.IsNull then
            FFieldContent := '(NULL)'
          else
            FFieldContent := Field.AsString;
          end;
    end;
  end;

function TTFieldTableColumn.FieldType: Integer;
begin
  result:=FFieldType;
end;

{ TFDQueryTableRowEnumerable }

constructor TFDQueryTableRowEnumerable.Create(Query: TFDQuery;
  TableName: string);
begin
  FQuery := Query;
  FTableName := TableName;
end;

function TFDQueryTableRowEnumerable.DoGetEnumerator: TEnumerator<TListLabelTableRow>;
begin
  result:=TFDQueryTableRowEnumerator.Create(FQuery, FTableName);
end;

end.
