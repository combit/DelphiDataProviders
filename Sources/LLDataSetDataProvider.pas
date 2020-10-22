{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLDataSetDataProvider.pas
 Module : List & Label 26
 Descr. : Implementation file for the List & Label 26 VCL-Component
 Version: 26.000
==================================================================================
}

unit LLDataSetDataProvider;

interface
{$WEAKPACKAGEUNIT ON}
uses LLDataProvider,
     Vcl.StdCtrls, Data.DB, Classes,
     system.Generics.Collections,
     FireDac.Comp.DataSet,FireDac.Comp.Client,
     FireDac.Stan.Intf, LLReport_Types;

type

  PFilterDescription = ^TFilterDescription;
  TFilterDescription = Record
     ParentTable   : String;
     ParentKeyField: String;
     ChildTable    : String;
     ChildKeyField : String;
     KeyValue      : STring;
  End;


  TDataSetDescription = Class (TObject)
     FKeyField       : String;
     FDataSet        : TDataSet;
     FFilter         : String;
     FSortDescription: String;
  Public
     Constructor Create(ADataset: TDataSet; AKeyField: String;ASortDescription: String; AFilter: String);
     Destructor  Destroy; Override;
     Property KeyField: String read FKeyField write FKeyField;
     Property DataSet : TDataSet read FDataSet write FDataSet;
     Property SortDescription: String read FSortDescription write FSortDescription;
     Property Filter  : String read FFilter write FFilter;
  End;



  TDataSetTableRelation = Class(TListLabelTableRelation)
     FRelationName   : STring;
     FChildTable     : String;
     FParentTable    : String;
     FParentKeyField : String;
     FChildKeyField  : STring;
     function RelationName: String; Override;
     function ParentColumnName: String; Override;
     function ChildColumnName: String; Override;
     function ParentTableName: String; Override;
     function ChildTableName: String; Override;
   public
     Constructor Create(ARelationName,AParentTable, AChildTable, AParentKeyField, AChildKeyField: STring);
  end;

  TDataSetDataProvider = class(TListLabelDataProvider)
  private
    FDataSets      : TStrings;
    FRelations     : TStrings;
    FImageStorage  : TImageStorage;
  public
    constructor Create;
    destructor  Destroy; override;
    function    Tables: TObjectList<TListLabelTable>; override;
    function    Relations: TObjectList<TListLabelTableRelation>; override;
    function    GetTable(TableName: string): TListLabelTable; override;
    function    GetRelation(RelationName: string) : TListLabelTableRelation; override;
    procedure   AddDataSet(TableName: String; ADataSet: TDataSet; AKeyField: String; ASortDescription: String; AFilter: String );
    Procedure   AddRelation (ARelationName,AParentTable, AChildTable, AParentKeyField, AChildKeyField: String);
    Function    GetDataSetInf(ATableName: String): TDataSetDescription;
    Function    HasChildTable(ATableName: String): Boolean;
    Function    SyncDataSet(ATableName: String; KeyField: STring; KeyValues: Variant): Boolean;
    Function    ApplySorting(ATableName: String; ASortDescription: String): Boolean;
    Function    ApplyFiltering(ATableName: String; AFilter: String):Boolean;

    Procedure   Clear;
  end;

  TDataSetTable = class(TListLabelTable)
  private
    FTableName: String;
    FProvider : TDataSetDataProvider;
    FDataSet  : TDataSet;
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
    constructor Create(AProvider: TDataSetDataProvider; TableName: String; ADataSet: TDataSet);
 end;

  TDataSetTableRow = class(TListLabelTableRow)
  private
    FTable   : TDataSetTable;
    FProvider: TDataSetDataProvider;
    FDataSet : TDataSet;
  public
    function SupportsGetParentRow: Boolean; override;
    function TableName: String; override;
    function Columns: TObjectList<TListLabelTableColumn>; override;
    function GetChildTable(Relation: TListLabelTableRelation): TListLabelTable; override;
    function GetParentRow(Relation: TListLabelTableRelation): TListLabelTableRow; override;
    constructor Create(AProvider: TDataSetDataProvider;Table: TDataSetTable; ADataSet : TDataSet);
  end;

  TDataSetTableRowEnumerable = class(TEnumerable<TListLabelTableRow>)
  private
    FTableName: String;
    FProvider : TDataSetDataProvider;
  protected
    function DoGetEnumerator: TEnumerator<TListLabelTableRow>; override;
  public
    constructor Create(AProvider:TDataSetDataProvider; TableName: string);
  end;

  TDataSetTableRowEnumerator = class(TEnumerator<TListLabelTableRow>)
  private
    FTableName     : String;
    FProvider      : TDataSetDataProvider;
    FMemDataSet    : TFDMemTable;
    FNeedSyncMaster: Boolean;
    FKeyField      : STring;
    FDataSetInf    : TDataSetDescription;
  protected
    function  DoGetCurrent: TListLabelTableRow; override;
    function  DoMoveNext: Boolean; override;
    Procedure ApplySorting;
    Procedure ApplyFiltering;
  public
    constructor Create(AProvider:TDataSetDataProvider; TableName: string);
    Destructor  Destroy; override;
  end;

  TTFieldsTableRow = class(TListLabelTableRow)
  private
    FTableName: String;
    FProvider : TDataSetDataProvider;
    FDataSet  : TDataSet;
  public
    function SupportsGetParentRow: Boolean; override;
    function TableName: String; override;
    function Columns: TObjectList<TListLabelTableColumn>; override;
    function GetChildTable(Relation: TListLabelTableRelation): TListLabelTable; override;
    function GetParentRow(Relation: TListLabelTableRelation): TListLabelTableRow; override;
    constructor Create(AProvider: TDataSetDataProvider; TableName: String; ADataSet: TDataSet);
  end;

  TTFieldTableColumn = class(TListLabelTableColumn)
  private
    FFieldName: String;
    FFieldContent: String;
    FFieldType: Integer;
    FHandle   : Cardinal;
    FProvider : TDataSetDataProvider;
  public
    function ColumnName: String; override;
    function Content: String; override;
    function ImgHandle: Cardinal; override;
    function FieldType: Integer; override;
    constructor Create(AProvider: TDataSetDataProvider; Field: TField);
  end;

{ --------------------------------------------------------------------------- }

const
  dummy_rtf = '{\rtf1\ansi\ansicpg1252\deff0\deflang1031{\fonttbl' +
    '{\f0\fswiss\fcharset0 Arial;}}\viewkind4\uc1\pard\f0\fs20\par}';

implementation
uses Sysutils, cmbtll26x, Windows, dialogs, vcl.graphics, vcl.imaging.jpeg;

Constructor TDataSetDescription.Create(ADataset: TDataSet; AKeyField: String; ASortDescription: String; AFilter: String  );
Begin
  inherited Create;
  FKeyField        := AKeyField;
  FDataSet         := ADataSet;
  FSortDescription := ASortDescription;
  FFilter          := AFilter;
End;

Destructor  TDataSetDescription.Destroy;
Begin
   FDataSet:=Nil;
   inherited Destroy;
End;

{=== TDataSetDataProvider =====================================================}
Constructor TDataSetTableRelation.Create( ARelationName,
                                          AParentTable,
                                          AChildTable,
                                          AParentKeyField,
                                          AChildKeyField  : STring);
Begin
   inherited Create;
   FRelationName   := ARelationName;
   FParentTable    := AParentTable;
   FChildTable     := AChildTable;
   FParentKeyField := AParentKeyField;
   FChildKeyField  := AChildKeyField;
End;

function TDataSetTableRelation.RelationName: String;
Begin
   result:=FRelationName;
End;

function TDataSetTableRelation.ParentColumnName: String;
Begin
   result:=FParentKeyField;
End;

function TDataSetTableRelation.ChildColumnName: String;
Begin
   result:=FChildKeyField;
End;

function TDataSetTableRelation.ParentTableName: String;
Begin
   Result:=FParentTable;
End;

function TDataSetTableRelation.ChildTableName: String;
Begin
   result:=FChildTable
End;


{ ====== TDataSetDataProvider =================================================}

procedure TDataSetDataProvider.AddDataSet( TableName : String;
                                           ADataSet  : TDataSet;
                                           AKeyField : String;
                                           ASortDescription: String;
                                           AFilter   : String  );
begin
  FDataSets.AddObject(TableName, TDataSetDescription.Create(ADataSet,AKeyField, ASortDescription,AFilter));
end;

Procedure  TDataSetDataProvider.AddRelation ( ARelationName,
                                              AParentTable,
                                              AChildTable,
                                              AParentKeyField,
                                              AChildKeyField: String);
Begin
   FRelations.AddObject(ARelationName,
                        TDataSetTableRelation.Create(ARelationName,
                                                     AParentTable,
                                                     AChildTable,
                                                     AParentKeyField,
                                                     AChildKeyField));
End;

Function  TDataSetDataProvider.GetDataSetInf(ATableName: String): TDataSetDescription;
Var i : INteger;
Begin

  i:=FDataSets.IndexOf(ATableName);
  if i>-1 then
    result:=TDataSetDescription(FDataSets.Objects[i])
  else
    result:=nil;

End;

Function  TDataSetDataProvider.HasChildTable(ATableName: String): Boolean;
Var i: Integer;
Begin
  for i:=0 to FRelations.Count-1 do
  Begin
     if TDataSetTableRelation(FRelations.Objects[i]).ParentTableName=ATableName then Exit(True);
  End;
  result:=False;
End;

Function  TDataSetDataProvider.SyncDataSet(ATableName: String; KeyField: STring; KeyValues: Variant): Boolean;
Var i: Integer;
Begin
  i:=FDataSets.IndexOf(ATableName);
  if i>-1 then
     result:=TDataSetDescription(FDataSets.Objects[i]).DataSet.Locate(KeyField,KeyValues,[])
  else
     result:=False;
End;

Function  TDataSetDataProvider.ApplyFiltering(ATableName: String; AFilter: String):Boolean;
Var p : TDataSetDescription;
Begin
   p:=GetDataSetInf(ATableName);
   With p do
   Begin
      Filter:=AFilter;
      result:=True;
   End;
End;

Function  TDataSetDataProvider.ApplySorting(ATableName: String; ASortDescription: STring): Boolean;
Begin
   With GetDataSetInf(ATableName) do
   Begin
      SortDescription:=ASortDescription;
      result:=True;
   End;
End;

Procedure TDataSetDataProvider.Clear;
Begin
  FRelations.Clear;
  FDataSets.Clear;
End;

constructor TDataSetDataProvider.Create;
begin
  inherited Create;
  FDataSets      := TStringlist.Create(True);
  FRelations     := TStringlist.Create(True);
  FImageStorage  := TImageStorage.Create;
  FImageStorage.OwnsObjects:=True;
end;

destructor TDataSetDataProvider.Destroy;
begin
  FDataSets.Free;
  FRelations.Free;
  FImageStorage.Free;
  inherited Destroy;
end;

function TDataSetDataProvider.GetRelation(RelationName: string): TListLabelTableRelation;
Var i : Integer;
begin
  result := nil;
  i:=FRelations.IndexOf(RelationName);
  if i>-1 then
     result:=TDataSetTableRelation(FRelations.Objects[i]);
end;

function TDataSetDataProvider.GetTable(TableName: string): TListLabelTable;
Var i : Integer;
begin
  result := nil;
  i:=FDataSets.IndexOf(TableName);
  if i>-1 then
  Begin
     result:=TDataSetTable.Create(self,TableName, TDataSetDescription(FDataSets.Objects[i]).DataSet);
  End;
end;

function TDataSetDataProvider.Relations: TObjectList<TListLabelTableRelation>;
Var RelationList: TObjectList<TListLabelTableRelation>;
    ARelation   : TDataSetTableRelation;
    i : Integer;
begin
  RelationList:=TObjectList<TListLabelTableRelation>.Create(True);
  for I := 0 to FRelations.Count-1 do
  Begin
     ARelation:=TDataSetTableRelation(FRelations.Objects[i]);
     RelationList.Add(TDataSetTableRelation.Create( ARelation.RelationName,
                                                    ARelation.ParentTableName,
                                                    ARelation.ChildTableName,
                                                    ARelation.ParentColumnName,
                                                    ARelation.ChildColumnName));
  End;
  result:=RelationList;
end;

function TDataSetDataProvider.Tables: TObjectList<TListLabelTable>;
var TableList : TObjectList<TListLabelTable>;
    i         : INteger;
begin
  TableList:=TObjectList<TListLabelTable>.Create(True);
  for i:=0 to FDataSets.Count-1  do
  Begin
     TableList.Add( TDataSetTable.Create(self,
                    FDataSets[i], TDataSetDescription(FDataSets.Objects[i]).DataSet));
  end;
  result:=TableList;
end;


{ ====== TDataSetTable =======================================================================}

procedure TDataSetTable.ApplyFilter(Filter: String);
begin
  inherited;
end;

procedure TDataSetTable.ApplySort(SortDescription: String);
begin
  inherited;
  FProvider.ApplySorting(FTableName,SortDescription);
end;

function TDataSetTable.Count: Integer;
begin
   result:=FDataSet.RecordCount;
end;

constructor TDataSetTable.Create(AProvider: TDataSetDataProvider; TableName: String; ADataSet: TDataSet);
begin
  inherited Create;
  FProvider := AProvider;
  FTableName := TableName;
  FDataSet   := ADataSet;
end;

function TDataSetTable.Rows: TEnumerable<TListLabelTableRow>;
begin
  result:=TDataSetTableRowEnumerable.Create(FProvider, TableName);
end;

function TDataSetTable.SchemaRow: TListLabelTableRow;
begin
  result := nil;
end;

function TDataSetTable.SortDescriptions: TList<String>;
begin
  result := nil;
end;

function TDataSetTable.SupportsAdvancedSorting: Boolean;
begin
  result := true;
end;

function TDataSetTable.SupportsCount: Boolean;
begin
  result := True;
end;

function TDataSetTable.SupportsFiltering: Boolean;
begin
  result := True;
end;

function TDataSetTable.SupportsSorting: Boolean;
begin
  result := True;
end;

function TDataSetTable.TableName: String;
begin
  result := FTableName;
end;

{=== TDataSetTableRow ========================================================================}

function TDataSetTableRow.Columns: TObjectList<TListLabelTableColumn>;
begin
  result:=TTFieldsTableRow.Create(FProvider,TableName, FDataSet).Columns;
  result.OwnsObjects:=True;
end;

constructor TDataSetTableRow.Create(AProvider: TDataSetDataProvider; Table: TDataSetTable; ADataSet : TDataSet);
begin
  FProvider:= AProvider;
  FTable   := Table;
  FDataSet := ADataSet;
end;

function TDataSetTableRow.GetChildTable(  Relation: TListLabelTableRelation): TListLabelTable;
var Table: TListLabelTable;
    TableList: TObjectList<TListLabelTable>;
begin
  result := nil;
  TableList := FProvider.Tables;
  for Table in TableList do
  begin
    if Table.TableName = Relation.ChildTableName then
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

function TDataSetTableRow.GetParentRow(
  Relation: TListLabelTableRelation): TListLabelTableRow;
begin
  result := nil;
end;

function TDataSetTableRow.SupportsGetParentRow: Boolean;
begin
  result := False;
end;

function TDataSetTableRow.TableName: String;
begin
  result:=FTable.TableName;
end;


{=== TDataSetTableRowEnumerable ===============================================}
constructor TDataSetTableRowEnumerable.Create(AProvider:TDataSetDataProvider; TableName: string);
begin
  FTableName := TableName;
  FProvider  := AProvider;
end;

function TDataSetTableRowEnumerable.DoGetEnumerator: TEnumerator<TListLabelTableRow>;
begin
  result:=TDataSetTableRowEnumerator.Create(FProvider, FTableName);
end;

{=== TDataSetTableRowEnumerator ================================================}

constructor TDataSetTableRowEnumerator.Create(AProvider:TDataSetDataProvider;TableName: String);
Var i : Integer;
begin
  FProvider      := AProvider;
  FTableName     := TableName;

  FDataSetInf := FProvider.GetDataSetInf(TableName);

  FKeyField       := FDataSetInf.KeyField;
  FNeedSyncMaster := FProvider.HasChildTable(TableName);

  FMemDataSet:=TFDMemTable.Create(nil);
  Try
     FDataSetInf.DataSet.Active:=True;
     FMemDataSet.CopyDataSet(FDataSetInf.DataSet,[coStructure,coRestart, coAppend]);
  Except
     Exception.Create('Cannot open dataset '+TableName);
  End;

  // CopyDataSet ignores Blobfield Subtypes
  for i:=0 to  FMemDataSet.Fields.Count-1 do
  Begin
     if FMemDataSet.Fields[i].IsBlob then
     Begin
        TBlobField( FMemDataSet.Fields[i]).BlobType :=
           TBlobField(FDataSetInf.DataSet.FieldByName(FMemDataSet.Fields[i].FieldName)).BlobType;
     end
  End;

  if FDataSetInf.SortDescription<>'' then ApplySorting;
  if FDataSetInf.Filter<>''          then ApplyFiltering;

  if not(FMemDataSet.Active) Then FMemDataSet.Active:=True;
  FMemDataSet.First;

  if FNeedSyncMaster then
     FProvider.SyncDataSet(FTableName,FKeyField,FMemDataSet.FieldByName(FKeyfield).Value);
end;

Procedure TDataSetTableRowEnumerator.ApplyFiltering;
Begin
   if FDataSetInf.Filter='' then Exit;
   with FMemDataSet do
   Begin
      Filter    := FDataSetInf.Filter;
      Filtered := True;
      if FNeedSyncMaster then
         FProvider.SyncDataSet(FTableName,FKeyField,FMemDataSet.FieldByName(FKeyfield).Value);
   End;
End;

Procedure TDataSetTableRowEnumerator.ApplySorting;
Begin
   if FDataSetInf.SortDescription='' then Exit;

   with FMemDataSet.Indexes.Add do
   Begin
      Name   := 'IDX_Main';
      Fields := StringReplace(FDataSetInf.SortDescription, chr(9), ';', [rfReplaceAll, rfIgnoreCase]);
      Active := True;
      FMemDataSet.IndexName := Name;
   End;
End;

Destructor  TDataSetTableRowEnumerator.Destroy;
Begin
   inherited Destroy;
   FreeAndNil(FMemDataSet);
End;

function TDataSetTableRowEnumerator.DoGetCurrent: TListLabelTableRow;
begin
  result:=TTFieldsTableRow.Create(FProvider,FTableName, FMemDataSet);
end;

function TDataSetTableRowEnumerator.DoMoveNext: Boolean;
begin
  result:=False;
  if not FMemDataSet.Eof then
  begin
    FMemDataSet.Next;
    if FNeedSyncMaster then
       FProvider.SyncDataSet(FTableName,FKeyField,FMemDataSet.FieldByName(FKeyfield).Value);

    if FMemDataSet.Eof then Exit(False);
    result := True;
  end;
end;

{=== TTFieldsTableRow ========================================================================}
constructor TTFieldsTableRow.Create(AProvider: TDataSetDataProvider;TableName: String; ADataSet: TDataSet);
begin
  FTableName:=TableName;
  FProvider := AProvider;
  FDataSet  := ADataSet;
end;

function TTFieldsTableRow.GetChildTable( Relation: TListLabelTableRelation): TListLabelTable;
var Table: TListLabelTable;
    TableList: TObjectList<TListLabelTable>;
begin
  result := nil;
  try
     TableList := FProvider.Tables;
     for Table in TableList do
     begin
       if Table.TableName = Relation.ChildTableName then
       begin
         result:= FProvider.GetTable(Table.TableName);
         break;
       end;
     end;
  finally
    FreeandNil(TableList);
  end;
end;

function TTFieldsTableRow.Columns: TObjectList<TListLabelTableColumn>;
var
  ResultList: TObjectList<TListLabelTableColumn>;
  Field: TField;
  Fields: TFields;
begin
  Fields:=FDataSet.Fields;
  ResultList:=TObjectList<TListLabelTableColumn>.Create(True);
  for Field in Fields do
  begin
    ResultList.Add(TTFieldTableColumn.Create(FProvider, Field));
  end;
  result:=ResultList;
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

{=== TTFieldTableColumn =======================================================}
function TTFieldTableColumn.ColumnName: String;
begin
  result:=FFieldName;
end;

function TTFieldTableColumn.Content: String;
begin
  result:=FFieldContent;
end;

function TTFieldTableColumn.ImgHandle: Cardinal;
begin
  result:=FHandle;
end;

constructor TTFieldTableColumn.Create(AProvider: TDataSetDataProvider; Field: TField);
Var BufferStream : TMemoryStream;
    BlobStream   : TStream;
    dummy        : TStrings;
    PictureStream : TStream;
    PicContainer  : TPicture;
    wic           : TWICImage;
    const DigitBool: array[Boolean] of string = ('0', '1');

begin
    BufferStream:=nil;
    BlobStream:=nil;
    wic := nil;
    FProvider:= AProvider;
    FFieldName    := Field.FieldName;
    FFieldContent := '(NULL)';

    case Field.DataType of
      ftInteger, ftsmallint, ftAutoInc,
      ftWord, ftLargeint:
        Begin
          FFieldType := LL_NUMERIC_INTEGER;
          if not(Field.IsNull)then FFieldContent := Field.AsString;
        End;
      ftFloat,
      ftCurrency:
        begin
          FFieldType := LL_NUMERIC;
          if not(Field.IsNull)then FFieldContent := Field.AsString;
        end;
      ftDate, ftDateTime, ftTimeStamp:         {date}
        begin
          FFieldType := LL_DATE_DELPHI;
          if not(Field.IsNull)then FFieldContent := FloatToStr(StrToDateTime(Field.AsString));
        end;
      ftBoolean:                  {boolean}
        begin
          FFieldType := LL_BOOLEAN;
          if not(Field.IsNull)then FFieldContent := DigitBool[Field.AsBoolean];
        end;
      ftBCD,
      ftfmtBCD:
        begin
          FFieldType := LL_NUMERIC;
          if not(Field.IsNull)then FFieldContent := Field.AsString
        end;
      ftWideString:
        begin
           FFieldType:=LL_TEXT;
          if not(Field.IsNull)then FFieldContent:=TWideStringField(Field).Value;
        end;
      ftGraphic, ftBlob:
            Begin
              Try
                PictureStream := Field.DataSet.CreateBlobStream(Field, bmRead);
                if PictureStream <> Nil then
                Begin
                  PictureStream.Seek(0, soBeginning);
                  if PictureStream.Size > 0 then
                    begin
                      wic := TWICImage.Create;
                      try
                      wic.LoadFromStream(PictureStream);
                      except on e: EInvalidGraphic do
                        begin
                        try
                        //special handling for northwind pictures
                          PictureStream.Position:= 78;
                          wic.LoadFromStream(PictureStream);
                          //if the blobcontent is not a image we create one empty
                             except on e: EInvalidGraphic do
                             begin
                              FFieldType:=LL_DRAWING_HBITMAP;
                              FHandle:= 0; exit;
                             end;
                        end;
                      end;
                    end;
                    PicContainer := FProvider.FImageStorage.AddItem;
                    PicContainer.Bitmap.Assign(wic);
                    if PicContainer.Graphic is TMetafile then
                    begin
                      FFieldType:=LL_DRAWING_HMETA;
                      FHandle:=PicContainer.Metafile.Handle;
                    end
                    else if PicContainer.Graphic is TBitmap then begin
                      FFieldType:=LL_DRAWING_HBITMAP;
                      FHandle:=PicContainer.Bitmap.Handle;
                    end
                    else if PicContainer.Graphic is TIcon then begin
                      FFieldType:=LL_DRAWING_HICON;
                      FHandle:=PicContainer.Icon.Handle;
                    end;
                  end;
                end;
              finally
                if Assigned(wic) then
                begin
                  FreeAndNil(wic);
                end
                else
                begin
                  FFieldType := LL_TEXT;
                  if not(Field.IsNull)then FFieldContent := Field.AsString;
                end;
                if Assigned(PictureStream) then FreeAndNil(PictureStream);

              end;
            End;

      ftFmtMemo:
            Begin
              FFieldType := LL_RTF;
              Try
                BlobStream := Field.DataSet.CreateBlobStream(Field, bmRead);
                BlobStream.Seek(0,0);
                BufferStream := TMemoryStream.Create;
                BufferStream.LoadFromStream(BlobStream);
                if BufferStream.Size = 0 then
                begin
                  dummy := TStringList.Create;
                  dummy.Text := dummy_rtf;
                  dummy.SaveToStream(BufferStream);
                  dummy.Free;
                end;

                FFieldContent := StrPas(PWideChar(BufferStream.Memory));
              finally
                BufferStream.Free;
                BlobStream.Free;
              end;
              if not(Field.IsNull)then FFieldContent := PWideChar(Field.AsString);
            end;
      else
          begin { Rest wird als Text exportiert }
            FFieldType := LL_TEXT;
            if not(Field.IsNull)then FFieldContent := Field.AsString;
          end;
    end;
end;

function TTFieldTableColumn.FieldType: Integer;
begin
  result:=FFieldType;
end;

end.
