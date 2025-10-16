unit LlRepository;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections,
  Winapi.Windows, Winapi.ActiveX,
  Data.DB;

type
  ILlRepositoryItem = interface
    ['{9FD3B4AA-3B08-4D96-8FC5-F827AA84B393}']
    function getInternalID: String;
    function getType: String;
    function getFolderId: String;
    function getDescriptor: String;
    function getLastModification: TDateTime;
    function getStream: TStream;

    procedure saveToIStream(dest: IStream);
    procedure loadFromIStream(source: IStream);
    procedure UpdateFrom(source: ILlRepositoryItem);

    property InternalID: String read getInternalID;
    property AType: String read getType;
    property FolderId: String read getFolderId;
    property Descriptor: String read getDescriptor;
    property LastModification: TDateTime read getLastModification;
    property Stream: TStream read getStream;
  end;

  TLlRepositoryAttributes = set of (raSingleThreadedAttribute, raNoHierarchyAttribute);

  ILlBaseRepository = interface
    ['{7814C978-3341-46B7-BA18-3610D3510B25}']
    function getAllItems(): TDictionary<String, ILlRepositoryItem>.TValueCollection;
    function getItem(id: String): ILlRepositoryItem;
    procedure DeleteItem(id: String);
    function ContainsItem(id: String): Boolean;
    function LockItem(id: String): Boolean;
    procedure UnlockItem(id: String);
    function getAttributes: TLlRepositoryAttributes;
    procedure setAttributes(value: TLlRepositoryAttributes);
    procedure CreateOrUpdateItem(item: ILlRepositoryItem);
//    LoadItem(id, destinationStream, _loadItemCancelTokenSource.Token);
    property Attributes: TLlRepositoryAttributes read getAttributes write setAttributes;
  end;

  ILlDBBaseRepositry = interface(ILlBaseRepository)
    ['{5DAF1512-96EA-47E2-A4ED-3ADF0DF16F19}']
    procedure LoadAll;
    function getDataSource: TDataSource;
    procedure setDataSource(value: TDataSource);
    function getFieldNameId: String;
    procedure setFieldNameId(value: String);
    function getFieldNameType: String;
    procedure setFieldNameType(value: String);
    function getFieldNameDescriptor: String;
    procedure setFieldNameDescriptor(value: String);
    function getFieldNameLastModification: String;
    procedure setFieldNameLastModification(value: String);
    function getFieldNameStream: String;
    procedure setFieldNameStream(value: String);
    property FieldNameId: String read getFieldNameId write setFieldNameId;
    property FieldNameType: String read getFieldNameType write setFieldNameType;
    property FieldNameDescriptor: String read getFieldNameDescriptor write setFieldNameDescriptor;
    property FieldNameLastModification: String read getFieldNameLastModification write setFieldNameLastModification;
    property FieldNameStream: String read getFieldNameStream write setFieldNameStream;
    property DataSource: TDataSource read getDataSource write setDataSource;
  end;

  TLlRepositoryItem = class(TInterfacedObject, ILlRepositoryItem)
  private
    FFolderId: String;
    FInternalId: String;
    FDescriptor: String;
    FType: String;
    FStream: TMemoryStream;
    FLastModification: TDateTime;
  public
    constructor Create(AId, AItemDescriptor, AType: String; ADate: TDateTime); overload;
    constructor Create(AId, AItemDescriptor, AType: String; ADate: TDateTime; AIStream: IStream); overload;
    constructor Create(AId, AItemDescriptor, AType: String; ADate: TDateTime; AStream: TStream); overload;
    destructor Destroy; override;
    function getFolderId: String;
    function getInternalID: String;
    function getDescriptor: String;
    function getType: String;
    function getLastModification: TDateTime;
    function getStream: TStream;
    procedure setStream(value: TStream);

    procedure saveToIStream(dest: IStream);
    procedure loadFromIStream(source: IStream);

    procedure UpdateFrom(source: ILlRepositoryItem);

    property InternalID: String read getInternalID;
    property AType: String read getType;
    property FolderId: String read getFolderId;
    property Descriptor: String read getDescriptor;
    property LastModification: TDateTime read getLastModification;
    property Stream: TStream read getStream;
  end;

  TLlBaseRepository = class(TInterfacedObject, ILlBaseRepository)
  protected
    FItems: TDictionary<String, ILlRepositoryItem>;
    FAttributes: TLlRepositoryAttributes;
    procedure AfterCreateOrUpdateItem(item: ILlRepositoryItem); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function getAllItems(): TDictionary<String, ILlRepositoryItem>.TValueCollection;
    function getItem(id: String): ILlRepositoryItem;
    procedure DeleteItem(id: String); virtual;
    function ContainsItem(id: String): Boolean;
    function LockItem(id: String): Boolean;
    procedure UnlockItem(id: String);
    function getAttributes: TLlRepositoryAttributes;
    procedure setAttributes(value: TLlRepositoryAttributes);
    procedure CreateOrUpdateItem(item: ILlRepositoryItem);
    property Attributes: TLlRepositoryAttributes read getAttributes write setAttributes;
  end;

  TLlDBBaseRepository = class(TLlBaseRepository, ILlDBBaseRepositry)
  private
  protected
    FDataSource: TDataSource;
    FFieldNameId: String;
    FFieldNameType: String;
    FFieldNameDescriptor: String;
    FFieldNameLastModification: String;
    FFieldNameStream: String;

    procedure AfterCreateOrUpdateItem(item: ILlRepositoryItem); override;
    procedure AddItem(ADataSet: TDataSet);
  public
    constructor Create; override;

    function getDataSource: TDataSource;
    procedure setDataSource(value: TDataSource);
    function getFieldNameId: String;
    procedure setFieldNameId(value: String);
    function getFieldNameType: String;
    procedure setFieldNameType(value: String);
    function getFieldNameDescriptor: String;
    procedure setFieldNameDescriptor(value: String);
    function getFieldNameLastModification: String;
    procedure setFieldNameLastModification(value: String);
    function getFieldNameStream: String;
    procedure setFieldNameStream(value: String);

    procedure LoadAll;
    procedure DeleteItem(id: String); override;

    property FieldNameId: String read getFieldNameId write setFieldNameId;
    property FieldNameType: String read getFieldNameType write setFieldNameType;
    property FieldNameDescriptor: String read getFieldNameDescriptor write setFieldNameDescriptor;
    property FieldNameLastModification: String read getFieldNameLastModification write setFieldNameLastModification;
    property FieldNameStream: String read getFieldNameStream write setFieldNameStream;
    property DataSource: TDataSource read getDataSource write setDataSource;
  end;

implementation

{ TLlRepositoryItem }

constructor TLlRepositoryItem.Create(AId, AItemDescriptor, AType: String;
  ADate: TDateTime; AIStream: IStream);
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FInternalId := AId;
  FDescriptor := AItemDescriptor;
  FType := AType;
  FLastModification := ADate;
  loadFromIStream(AIStream);
end;

constructor TLlRepositoryItem.Create(AId, AItemDescriptor, AType: String;
  ADate: TDateTime; AStream: TStream);
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FInternalId := AId;
  FDescriptor := AItemDescriptor;
  FType := AType;
  FLastModification := ADate;
  setStream(AStream);
end;

constructor TLlRepositoryItem.Create(AId, AItemDescriptor, AType: String;
  ADate: TDateTime);
begin
  inherited Create;
  FStream := TMemoryStream.Create;
  FInternalId := AId;
  FDescriptor := AItemDescriptor;
  FType := AType;
  FLastModification := ADate;
end;

destructor TLlRepositoryItem.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

function TLlRepositoryItem.getDescriptor: String;
begin
  Result := FDescriptor;
end;

function TLlRepositoryItem.getFolderId: String;
begin
  Result := FFolderId;
end;

function TLlRepositoryItem.getInternalID: String;
begin
  Result := FInternalId;
end;

function TLlRepositoryItem.getLastModification: TDateTime;
begin
  Result := FLastModification;
end;

function TLlRepositoryItem.getStream: TStream;
begin
  Result := FStream;
end;

function TLlRepositoryItem.getType: String;
begin
  Result := FType;
end;

procedure TLlRepositoryItem.loadFromIStream(source: IStream);
const
  BufferSize = 4096;
var
  Buffer: array[0..BufferSize - 1] of Byte;
  BytesRead: LongInt;
begin
  FStream.Clear;
  if source <> nil then
  begin
    repeat
      Source.Read(@Buffer, BufferSize, @BytesRead);
      if BytesRead > 0 then
        FStream.Write(Buffer, BytesRead);
    until BytesRead < BufferSize;
  end;
  FStream.Position := 0;
end;

procedure TLlRepositoryItem.saveToIStream(dest: IStream);
var
  Buffer: array[0..4095] of Byte;
  BytesRead: Integer;
  BytesWritten: LongInt;
begin
  FStream.Position := 0; // Ensure the source stream is at the beginning
  repeat
    BytesRead := FStream.Read(Buffer, SizeOf(Buffer));
    if BytesRead > 0 then
    begin
      dest.Write(@Buffer, BytesRead, @BytesWritten);
      if BytesRead <> BytesWritten then
        raise Exception.Create('Error writing to IStream');
    end;
  until BytesRead = 0;
end;

procedure TLlRepositoryItem.setStream(value: TStream);
begin
  if value = nil then
  begin
    (FStream as TMemoryStream).Clear;
  end else
  begin
    (FStream as TMemoryStream).LoadFromStream(value);
  end;
end;

procedure TLlRepositoryItem.UpdateFrom(source: ILlRepositoryItem);
begin
  if SameText(FInternalId, source.InternalID) then
  begin
    FLastModification := source.LastModification;
    FDescriptor := source.Descriptor;
    FFolderId := source.FolderId;
    FType := source.AType;
    setStream(source.getStream);
  end;
end;

{ TLlBaseRepository }

procedure TLlBaseRepository.AfterCreateOrUpdateItem(item: ILlRepositoryItem);
begin
  // use in derivation
end;

function TLlBaseRepository.ContainsItem(id: String): Boolean;
begin
  Result := FItems.ContainsKey(id);
end;

constructor TLlBaseRepository.Create;
begin
  FItems := TDictionary<String, ILlRepositoryItem>.Create;
  FAttributes := [];
end;

procedure TLlBaseRepository.CreateOrUpdateItem(item: ILlRepositoryItem);
var
  repositoryItem: ILlRepositoryItem;
begin
  if FItems.ContainsKey(item.InternalID) then
  begin
    if FItems.TryGetValue(item.InternalID, repositoryItem) then
    begin
      repositoryItem.UpdateFrom(item);
      AfterCreateOrUpdateItem(repositoryItem);
    end;
  end else
  begin
    FItems.AddOrSetValue(item.InternalID, item);
    AfterCreateOrUpdateItem(item);
  end;
end;

procedure TLlBaseRepository.DeleteItem(id: String);
begin
  FItems.Remove(id);
end;

destructor TLlBaseRepository.Destroy;
begin
  FItems.Free;
end;

function TLlBaseRepository.getAllItems: TDictionary<String, ILlRepositoryItem>.TValueCollection;
begin
  Result := FItems.Values;
end;

function TLlBaseRepository.getAttributes: TLlRepositoryAttributes;
begin
  Result := FAttributes;
end;

function TLlBaseRepository.getItem(id: String): ILlRepositoryItem;
var
  repositoryItem: ILlRepositoryItem;
begin
  Result := nil;
  if FItems.TryGetValue(id, repositoryItem) then
  begin
    Result := repositoryItem;
  end;
end;

function TLlBaseRepository.LockItem(id: String): Boolean;
begin
  //TODO
  // to be implemented
  Result := True;
end;

procedure TLlBaseRepository.setAttributes(value: TLlRepositoryAttributes);
begin
  FAttributes := value;
end;

procedure TLlBaseRepository.UnlockItem(id: String);
begin
  //TODO
  // to be implemented
end;

{ TLlDBBaseRepository }

procedure TLlDBBaseRepository.AddItem(ADataSet: TDataSet);
var
  item: ILlRepositoryItem;
  ms: TStream;
begin
  if ADataSet.FieldByName(FFieldNameStream).IsNull then
  begin
    item := TLlRepositoryItem.Create(
          ADataSet.FieldByName(FFieldNameId).AsString,
          ADataSet.FieldByName(FFieldNameDescriptor).AsString,
          ADataSet.FieldByName(FFieldNameType).AsString,
          ADataSet.FieldByName(FFieldNameLastModification).AsDateTime );
  end else
  begin
    ms := TMemoryStream.Create;
    try
      (ADataSet.FieldByName(FFieldNameStream)as TBlobField).SaveToStream(ms);
        item := TLlRepositoryItem.Create(
            ADataSet.FieldByName(FFieldNameId).AsString,
            ADataSet.FieldByName(FFieldNameDescriptor).AsString,
            ADataSet.FieldByName(FFieldNameType).AsString,
            ADataSet.FieldByName(FFieldNameLastModification).AsDateTime,
            ms);
    finally
      ms.Free;
    end;
  end;

  FItems.Add(ADataSet.FieldByName(FFieldNameId).AsString, item);
end;

procedure TLlDBBaseRepository.AfterCreateOrUpdateItem(item: ILlRepositoryItem);
var
  ds: TDataSet;
begin
  inherited;
  if FDataSource <> nil then
  begin
    if FDataSource.DataSet <> nil then
    begin
      ds := FDataSource.DataSet;
      if ds.Locate(FFieldNameId, item.InternalID, [loCaseInsensitive]) then
      begin
        ds.Edit;
      end else
      begin
        ds.Insert;
        ds.FieldByName(FFieldNameId).AsString := item.InternalID;
      end;
      ds.FieldByName(FFieldNameType).AsString := item.AType;
      ds.FieldByName(FFieldNameDescriptor).AsString := item.Descriptor;
      ds.FieldByName(FFieldNameLastModification).AsDateTime := item.LastModification;
      (ds.FieldByName(FFieldNameStream) as TBlobField).LoadFromStream(item.getStream);
      ds.Post;
    end else
    begin
      raise Exception.Create('Dataset is nil');
    end;
  end else
  begin
    raise Exception.Create('Datasource is nil');
  end;
end;

constructor TLlDBBaseRepository.Create;
begin
  inherited;

  FFieldNameId := 'InternalId';
  FFieldNameType := 'AType';
  FFieldNameDescriptor := 'ItemDescriptor';
  FFieldNameLastModification := 'LastModification';
  FFieldNameStream := 'Stream';
end;

procedure TLlDBBaseRepository.DeleteItem(id: String);
var
  ds: TDataSet;
begin
  inherited;
  if FDataSource <> nil then
  begin
    if FDataSource.DataSet <> nil then
    begin
      ds := FDataSource.DataSet;
      if ds.Locate(FFieldNameId, id, [loCaseInsensitive]) then
      begin
        ds.Delete;
      end;
    end;
  end;
end;

function TLlDBBaseRepository.getDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TLlDBBaseRepository.getFieldNameDescriptor: String;
begin
  Result := FFieldNameDescriptor;
end;

function TLlDBBaseRepository.getFieldNameId: String;
begin
  Result := FFieldNameId;
end;

function TLlDBBaseRepository.getFieldNameLastModification: String;
begin
  Result := FFieldNameLastModification;
end;

function TLlDBBaseRepository.getFieldNameStream: String;
begin
  Result := FFieldNameStream;
end;

function TLlDBBaseRepository.getFieldNameType: String;
begin
  Result := FFieldNameType;
end;

procedure TLlDBBaseRepository.LoadAll;
begin
  if FDataSource <> nil then
  begin
    if FDataSource.DataSet <> nil then
    begin
      FDataSource.DataSet.Close;
      FDataSource.DataSet.Open;
      FItems.Clear;
      while not FDataSource.DataSet.Eof do
      begin
        AddItem(FDataSource.DataSet);
        FDataSource.DataSet.Next;
      end;
    end else
    begin
      raise Exception.Create('Dataset is nil');
    end;
  end else
  begin
    raise Exception.Create('Datasource is nil');
  end;
end;

procedure TLlDBBaseRepository.setDataSource(value: TDataSource);
begin
  FDataSource := value;
end;

procedure TLlDBBaseRepository.setFieldNameDescriptor(value: String);
begin
  FFieldNameDescriptor := value;
end;

procedure TLlDBBaseRepository.setFieldNameId(value: String);
begin
  FFieldNameId := value;
end;

procedure TLlDBBaseRepository.setFieldNameLastModification(value: String);
begin
  FFieldNameLastModification := value;
end;

procedure TLlDBBaseRepository.setFieldNameStream(value: String);
begin
  FFieldNameStream := value;
end;

procedure TLlDBBaseRepository.setFieldNameType(value: String);
begin
  FFieldNameType := value;
end;

end.
