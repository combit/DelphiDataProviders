unit LlCoreRepository;

interface
uses
  System.SysUtils, System.Classes, System.Variants,
  Winapi.Windows, Winapi.ActiveX,
  LlRepository;

type
  // Repository Item Info Enumeration
  TRepositoryItemInfo = (
    riTimestamp = 1,
    riReadOnly = 2,
    riBLOBData = 3,
    riThreadedAccess = 4,
    riSupportsHierarchy = 5
  );

  // ILlRepositoryItemSink Definition
  ILlRepositoryItemSink = interface(IUnknown)
    ['{0B14D53F-8907-41D6-A0E6-95C1E812E31A}']
    function DefineItem(const id, itemDescriptor: WideString): HRESULT; stdcall;
  end;

  // Interface Definition for ILlRepository
  ILlRepository = interface(IUnknown)
    ['{46433E33-1C0D-4D46-AC44-F72F87870C55}']
    function DefineItems(debugSink: Pointer; folderId: PWideChar; itemsList: ILlRepositoryItemSink): HRESULT; stdcall;
    function Load(debugSink: Pointer; id: PWideChar; destinationStream: Pointer): HRESULT; stdcall;
    function Save(debugSink: Pointer; id, itemType, userDefinedID: PWideChar; nativeStream: Pointer; itemDescriptor: PWideChar): HRESULT; stdcall;
    function Delete(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function GetInfo(debugSink: Pointer; id: PWideChar; infoType: Integer; var info: OleVariant): HRESULT; stdcall;
    function AbortLoad(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function Lock(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function Unlock(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
  end;

  // Logger Interface
  ILlLogger = interface
    ['{27936F33-EA8C-4C5D-AE08-E083B8F572F3}']
    procedure Error(const category, message: WideString; params: array of const); stdcall;
  end;

  // Main LlCoreRepository Class
  TLlCoreRepository = class(TInterfacedObject, ILlRepository)
  private
    FRepository: ILlBaseRepository;
    FExternalLogger: ILlLogger;
  public
    constructor Create(repository: ILlBaseRepository);
    //constructor Create();
    destructor Destroy; override;
    // ILlRepository Implementation
    function DefineItems(debugSink: Pointer; folderId: PWideChar; itemsList: ILlRepositoryItemSink): HRESULT; stdcall;
    function Load(debugSink: Pointer; id: PWideChar; destinationStream: Pointer): HRESULT; stdcall;
    function Save(debugSink: Pointer; id, itemType, userDefinedID: PWideChar; nativeStream: Pointer; itemDescriptor: PWideChar): HRESULT; stdcall;
    function Delete(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function GetInfo(debugSink: Pointer; id: PWideChar; infoType: Integer; var info: OleVariant): HRESULT; stdcall;
    function AbortLoad(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function Lock(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    function Unlock(debugSink: Pointer; id: PWideChar): HRESULT; stdcall;
    procedure SetLogger(logger: ILlLogger; overrideExisting: Boolean); stdcall;
  end;
implementation

uses System.Win.ComObj;

{ TLlCoreRepository }
constructor TLlCoreRepository.Create(repository: ILlBaseRepository);
begin
  if repository = nil then
  begin
    raise Exception.Create('Repository cannot be nil!');
  end;
  FRepository := repository;
end;

destructor TLlCoreRepository.Destroy;
begin
  FRepository := nil;
  inherited Destroy;
end;

function TLlCoreRepository.DefineItems(debugSink: Pointer; folderId: PWideChar; itemsList: ILlRepositoryItemSink): HRESULT;
var
  lastItem: String;
  item: ILlRepositoryItem;
  hr: HRESULT;
begin
  try
    try
      lastItem := '(unknown)';
      for item in FRepository.getAllItems do
      begin
        if item.FolderId = folderId then
        begin
          lastItem := item.InternalID;
          hr := itemsList.DefineItem(item.InternalID, item.Descriptor);
          OleCheck(hr);
        end;
      end;
      Result := S_OK;
    except
      on E: Exception do
      begin
        if Assigned(FExternalLogger) then
          FExternalLogger.Error('Net', Format('Error while defining items: %s', [E.Message]), []);
        Result := E_FAIL;
      end;
    end;
  finally
    itemsList := nil;
    // https://msdn.microsoft.com/en-us/library/ff647812.aspx#scalenetchapt07%20_topic9
    // in c#  Marshal.ReleaseComObject(itemsList);
  end;
end;

function TLlCoreRepository.Load(debugSink: Pointer; id: PWideChar; destinationStream: Pointer): HRESULT;
var
  repositoryItem: ILlRepositoryItem;
begin
  try
    if destinationStream = nil then
    begin
      if FRepository.ContainsItem(id) then
        Result := S_OK
      else
        Result := S_FALSE;
      Exit;
    end;
    repositoryItem := FRepository.getItem(id);
    repositoryItem.saveToIStream(IStream(destinationStream));
    // TODO implement cancel loading
    // code from LlCoreRepository.cs
    (*
      if (nativeStreamPtr == IntPtr.Zero) // When nativeStream is null, we just want to know if the item is available or not
      {
          return _wrappedRepository.ContainsItem(id) ? (int)HResult.S_OK : (int)HResult.S_FALSE;
      }

      // Create a cancellation token that may be triggered in AbortOpen().
      if (_loadItemCancelTokenSource != null)
      {
          _loadItemCancelTokenSource.Dispose();
      }
      _loadItemCancelTokenSource = new CancellationTokenSource();

      using (var destinationStream = new ComStreamWrapper(nativeStreamPtr))
      {
          _wrappedRepository.LoadItem(id, destinationStream, _loadItemCancelTokenSource.Token);
      }

      return (int)HResult.S_OK;
*)
    Result := S_OK;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while loading item: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.Save(debugSink: Pointer; id, itemType, userDefinedID: PWideChar; nativeStream: Pointer; itemDescriptor: PWideChar): HRESULT;
var
  repositoryItem: ILlRepositoryItem;
begin
  try
    repositoryItem := TLlRepositoryItem.Create(id, itemDescriptor, itemType, Now(), IStream(nativeStream));
    FRepository.CreateOrUpdateItem(repositoryItem);

    Result := S_OK;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while saving item: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.Delete(debugSink: Pointer; id: PWideChar): HRESULT;
begin
  try
    FRepository.DeleteItem(id);
    Result := S_OK;
  except
    on E: Exception do
    begin
      // TODO
      // code from LlCoreRepository.cs
      // using (var nativeLogger = new LoggingHelper.FixedDebugSink2LoggerAdapter(debugSink))
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while deleting item: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.GetInfo(debugSink: Pointer; id: PWideChar; infoType: Integer; var info: OleVariant): HRESULT;
var
  aInfoType: TRepositoryItemInfo;
  repositoryItem: ILlRepositoryItem;
begin
  try
    aInfoType := TRepositoryItemInfo(infoType);
    if id = nil then
    begin
      case aInfoType of
        riThreadedAccess:
          begin
            // code from LlCoreRepository.cs
            // info = (Attribute.GetCustomAttribute(_wrappedRepository.GetType(), typeof(SingleThreadedAttribute)) == null);
            info := not (raSingleThreadedAttribute in FRepository.getAttributes);
            Result := S_OK;
          end;
        riSupportsHierarchy:
          begin
            // code from LlCoreRepository.cs
            // info = (Attribute.GetCustomAttribute(_wrappedRepository.GetType(), typeof(NoHierarchyAttribute)) == null);
            info := not (raNoHierarchyAttribute in FRepository.getAttributes);
            Result := S_OK;
          end;
      else
        Result := E_INVALIDARG;
      end;
    end else
    begin
      repositoryItem := FRepository.getItem(id);
      if repositoryItem = nil then
      begin
        Result := E_FAIL;
      end else
      begin
        case aInfoType of
          riTimestamp:
            begin
(*            code from LlCoreRepository.cs
              if (item.IsEmpty) {  // LL Core uses an empty timestamp to check if it is an empty/new item
                  info = null; }
              else {
                  DateTime dt = item.LastModificationUTC.ToLocalTime();
                  info = dt; }
*)

              if repositoryItem.LastModification = 0.0 then
                info := Null
              else
                info := repositoryItem.LastModification;
              Result := S_OK;
            end;
          riReadOnly:
            begin
              info := false; // for now...
              Result := S_OK;
            end;
          riBLOBData:
            begin
              info := repositoryItem.Descriptor;
              Result := S_OK;
            end;
        else
          Result := E_INVALIDARG;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while getting info: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.AbortLoad(debugSink: Pointer; id: PWideChar): HRESULT;
begin
  try
  // TODO
(*  code from LlCoreRepository.cs
    try
    {
        if (_loadItemCancelTokenSource != null)
        {
            _loadItemCancelTokenSource.Cancel();
        }
        return (int)HResult.S_OK;
    }
    catch (Exception e)
    {
        using (var nativeLogger = new LoggingHelper.FixedDebugSink2LoggerAdapter(debugSink))
        {
            (_externalLogger ?? nativeLogger).Error(LogCategory.Net, "Error while aborting repository load of '{0}': {1}", id, e);
        }
        return (int)HResult.E_FAIL;
    }
*)
    Result := S_OK;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while aborting load: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.Lock(debugSink: Pointer; id: PWideChar): HRESULT;
begin
  try
    if FRepository.LockItem(id) then
      Result := S_OK
    else
      Result := S_FALSE;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while locking item: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

function TLlCoreRepository.Unlock(debugSink: Pointer; id: PWideChar): HRESULT;
begin
  try
    FRepository.UnlockItem(id);
    Result := S_OK;
  except
    on E: Exception do
    begin
      if Assigned(FExternalLogger) then
        FExternalLogger.Error('Net', Format('Error while unlocking item: %s', [E.Message]), []);
      Result := E_FAIL;
    end;
  end;
end;

procedure TLlCoreRepository.SetLogger(logger: ILlLogger; overrideExisting: Boolean);
begin
  if (FExternalLogger = nil) or overrideExisting then
    FExternalLogger := logger;
end;
end.
