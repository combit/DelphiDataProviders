{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : ObjTree.pas
 Module : List & Label 30
 Descr. : Implementation file for the List & Label 30 VCL-Component
 Version: 30.001
==================================================================================
}

unit ObjTree;

interface

uses Classes, Controls, Windows, ActiveX, SysUtils, Dialogs;

type
  TObjTreeNode = class;
  TObjTree     = class;

  //Enable access to protected functions
  TOwnedCollectionAccess = class(TOwnedCollection);

  TObjSelectionProc = procedure(Item: TObjTreeNode) of object;

  //TObjTreeNodeList is no longer needed
  TObjTreeNodeList = Class(TStringList)
  Private
    Function  GetNode(Index: Integer) :TObjTreeNode;
    Procedure SetNode(Index: Integer; Value: TObjTreeNode);
  Public
    Constructor Create;
    function AddNode(ANode: TObjTreeNode): Integer;
    function DeleteNode(ANode: TObjTreeNode): Boolean;
    function DeleteNodeNr(index: Integer): Boolean;
    property Nodes[Index: Integer]: TObjTreeNode read GetNode write SetNode;
  End deprecated;

  //TObjTreeNode is both data holder in derived classes, and root node for
  //child nodes of the same type
  TObjTreeNode = class(TCollectionItem)
  private
    FSelectionProc: TObjSelectionProc;
    FTag          : Integer;
    FRootTree: TObjTree;
    FOwnItems: TOwnedCollection;
    FParentNode: TObjTreeNode; //only related for AsPlainList

    function GetCount: Integer; inline;
    Procedure SetInternParentNode(AValue: TObjTreeNode);

  protected
    procedure DoOnItemSelected(Value: TObjSelectionProc); virtual;

    { TPersistent }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadOwnItemsProperty(Reader: TReader); virtual;
    procedure WriteOwnItemsProperty(Writer: TWriter); virtual;

    function GetRootTree: TObjTree;
    Procedure SetRootTree(Value: TObjTree);
    function GetItem(Index: Integer): TObjTreeNode;
    procedure SetItem(Index: Integer; Value: TObjTreeNode);
    function GetParentNode: TObjTreeNode;

    procedure SetCollection(Value: TCollection); override;
  public
    constructor Create(Collection: TCollection); override;
    Destructor Destroy; Override;
    function  GetInstance(const PropertyName: string): TPersistent; virtual;
    procedure UpdateEditorDisplay(Sender: TObject);

    property OwnCollection: TOwnedCollection read FOwnItems;
    function Add: TObjTreeNode; virtual; //Add subnode
    Function AddChildNode: TObjTreeNode; virtual; //Alias for Add for compatibility reasons
    Procedure Delete(Index: Integer); virtual;
    function IndexOf(Objekt: TObjTreeNode): Integer; virtual;
    Function IsRootNode: Boolean; //Returns True for root nodes (TObjTree Items) otherwise False
    Procedure AsPlainList(var ACollection: TCollection); //Returns ALL subnodes from here on as a flat list in a copy

    property Count: Integer read GetCount; //Number of own subnodes
    property  OnItemSelected: TObjSelectionProc read FSelectionProc write DoOnItemSelected;
    Property ParentNode: TObjTreeNode read GetParentNode; //Pointer to the parent TObjTreeNode or Nil at root node.
    property Tag: Integer read FTag write FTag default 0;
    property Items[Index: Integer]: TObjTreeNode read GetItem write SetItem; default; //List of own subnodes
    property RootTree: TObjTree read GetRootTree write SetRootTree; //Pointer to the TObjTree structure
  end;

  //Root node for all child TObjTreeNode types.
  //The tree structure is stored in the DFM, including all properties of derived classes if Published
  TObjTree = class(TOwnedCollection)
  private
    FDesigner: TControl;
  protected
    procedure SetDesigner(Value: TControl); virtual;
    function GetItem(Index: Integer): TObjTreeNode;
    procedure SetItem(Index: Integer; Value: TObjTreeNode);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor  Destroy; override;
    function AddItem: TObjTreeNode; virtual; //Alias for Add for compatibility reasons
    function Add: TObjTreeNode; //Add subnode
    Procedure AsPlainList(var ACollection: TCollection); //Returns ALL subnodes from here on as a flat list in a copy

    property    Designer: TControl read FDesigner write SetDesigner;
    property Items[Index: Integer]: TObjTreeNode read GetItem write SetItem; //List of own subnodes
  end;

implementation
//=====================================================================================================================
// TObjTreeNodeList
//=====================================================================================================================
Constructor TObjTreeNodeList.Create;
Begin
  inherited Create;
  Self.OwnsObjects := True;
End;

function TObjTreeNodeList.AddNode(ANode: TObjTreeNode): Integer;
Begin
   result:=AddObject('',ANode);
End;

function TObjTreeNodeList.DeleteNode(ANode: TObjTreeNode): Boolean;
var
  i: Integer;
Begin
  Result := False;
   for i := 0 to Count-1 do
   Begin
       if Objects[i] = ANode  then
       Begin
          Delete(i);
      Result := True;
          Break;
       End;
   End;
End;

function TObjTreeNodeList.DeleteNodeNr(index: Integer): Boolean;
var
  MaxCount: Integer;
Begin
  MaxCount := Count - 1;
  if (Index < 0) or (Index > (MaxCount)) then
    ERangeError.Create('Index ['+Index.ToString+'] out of range (0..'+MaxCount.ToString+')');

   Delete(index);
   Result := true;
End;

Function  TObjTreeNodeList.GetNode(Index: Integer) :TObjTreeNode;
var
  MaxCount: Integer;
Begin
  MaxCount := Count - 1;
  if (Index < 0) or (Index > (MaxCount)) then
    ERangeError.Create('Index ['+Index.ToString+'] out of range (0..'+MaxCount.ToString+')');
    
  result:= TObjTreeNode(Objects[Index]);
End;

Procedure TObjTreeNodeList.SetNode(Index: Integer; Value: TObjTreeNode);
var
  MaxCount: Integer;
Begin
  MaxCount := Count - 1;
  if (Index < 0) or (Index > (MaxCount)) then
    ERangeError.Create('Index ['+Index.ToString+'] out of range (0..'+MaxCount.ToString+')');
    
   Objects[Index]:=Value;
End;

//=====================================================================================================================
// TObjTreeNode
//=====================================================================================================================

constructor TObjTreeNode.Create(Collection: TCollection);
Begin
  inherited Create(Collection);
  FRootTree := Nil;
  FOwnItems := TOwnedCollection.Create(Self, Collection.ItemClass);
End;

Destructor TObjTreeNode.Destroy;
Begin
  FRootTree := Nil;
  FParentNode := Nil;
  FOwnItems.Clear;
  FOwnItems.Free;

  inherited Destroy;
End;

function TObjTreeNode.GetInstance(const PropertyName: string): TPersistent;
begin
  result := self;
end;

function TObjTreeNode.GetCount: Integer;
Begin
  result := FOwnItems.Count;
end;

Procedure TObjTreeNode.SetInternParentNode(AValue: TObjTreeNode);
   Begin
  FParentNode := AValue;
   End;

procedure TObjTreeNode.DefineProperties(Filer: TFiler);
   Begin
  inherited;
  Filer.DefineProperty('InternalOwnItems', ReadOwnItemsProperty, WriteOwnItemsProperty,
    (FOwnItems.Count > 0));
   End;

procedure TObjTreeNode.ReadOwnItemsProperty(Reader: TReader);
var
  Val: TValueType;
begin
  Val := Reader.ReadValue;
  if Val = vaCollection then
  begin
    Reader.ReadCollection(Self.FOwnItems);
  end;
End;

procedure TObjTreeNode.WriteOwnItemsProperty(Writer: TWriter);
begin
  Writer.WriteCollection(Self.FOwnItems);
end;

procedure TObjTreeNode.DoOnItemSelected(Value: TObjSelectionProc);
begin
end;

procedure TObjTreeNode.UpdateEditorDisplay(Sender: TObject);
begin
  if FRootTree <> Nil then
  Begin
    if FRootTree.Designer <> Nil then
      FRootTree.Designer.Update;
  End;
end;

function TObjTreeNode.GetRootTree: TObjTree;
  function GetRootNode(ANode: TObjTreeNode): TObjTreeNode;
  begin
    if ANode.ParentNode <> Nil then
      Result := GetRootNode(ANode.ParentNode)
    else begin
      Result := ANode;
    end;
  end;
var
  Temp: TObjTreeNode;
begin
  //Returns the original TObjTree type, no matter from which TObjTreeNode node.
  //once determined, the pointer is stored in FRootTree and returned
  Result := Nil;

  if FRootTree <> Nil then
    Result := FRootTree
  else begin
    if Self.ParentNode = Nil then
    begin
      if Self.GetOwner is TObjTree then
      begin
        FRootTree := Self.GetOwner as TObjTree;
        Result := FRootTree;
      end;
    end
    else begin
      Temp := GetRootNode(Self);
      if Temp <> Nil then
      begin
        if Temp.GetOwner is TObjTree then
        begin
          FRootTree := Temp.GetOwner as TObjTree;
          Result := FRootTree;
        end;
      end;
    end;
  end;
end;

Procedure TObjTreeNode.SetRootTree(Value: TObjTree);
Begin
  //Will be used for the Add routine to pass the TObjTree object to its own child nodes.
  if FRootTree <> Value then
    FRootTree := Value;
End;

function TObjTreeNode.GetItem(Index: Integer): TObjTreeNode;
begin
  Result := TObjTreeNode(FOwnItems.Items[Index]);
end;

procedure TObjTreeNode.SetItem(Index: Integer; Value: TObjTreeNode);
begin
  TObjTreeNode(FOwnItems.Items[Index]).Assign(Value);
end;

function TObjTreeNode.GetParentNode: TObjTreeNode;
begin
  //Returns the parent node, if present.
  Result := Nil;

  //FParentNode is assigned only in the function AsPlainList
  if FParentNode <> Nil then
    Exit(FParentNode);

  if Self.GetOwner <> Nil then
  begin
    if Self.GetOwner is TOwnedCollection then
    begin
      if TOwnedCollectionAccess(Self.GetOwner).GetOwner <> Nil then
      begin
        if TOwnedCollectionAccess(Self.GetOwner).GetOwner is TObjTreeNode then
          Result := TOwnedCollectionAccess(Self.GetOwner).GetOwner as TObjTreeNode;
      end;
    end;
  end;
end;

procedure TObjTreeNode.SetCollection(Value: TCollection);
begin
  inherited SetCollection(Value);
end;

function TObjTreeNode.Add: TObjTreeNode;
Begin
  result := FOwnItems.Add as TObjTreeNode;
  result.RootTree := Self.FRootTree;
End;

Function  TObjTreeNode.AddChildNode: TObjTreeNode;
Begin
  result := Self.Add;
End;

Procedure TObjTreeNode.Delete(Index: Integer);
Begin
  FOwnItems.Delete(Index);
End;

function TObjTreeNode.IndexOf(Objekt: TObjTreeNode): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FOwnItems.Count-1 do
  begin
    if FOwnItems.Items[i] = Objekt then
    Begin
      Result := FOwnItems.Items[i].Index;
      Break;
    End;
  end;
end;

function TObjTreeNode.IsRootNode: Boolean;
begin
  Result := Self.ParentNode = Nil;
end;

Procedure TObjTreeNode.AsPlainList(var ACollection: TCollection);
var
  I: Integer;
  Item: TObjTreeNode;
begin
  //Flat list of ALL child nodes with parent relationship, in copy.
  //ACollection must be created and released beforehand
  if ACollection = Nil then
    Exit;

  for I := 0 to FOwnItems.Count - 1 do
  Begin
    Item := ACollection.Add as TObjTreeNode;
    Item.Assign(FOwnItems.Items[i]);
    Item.SetInternParentNode(Self);

    if TObjTreeNode(FOwnItems.Items[i]).Count > 0 then
      TObjTreeNode(FOwnItems.Items[i]).AsPlainList(ACollection);
  End;
End;

//=====================================================================================================================
// TObjTree
//=====================================================================================================================
constructor TObjTree.Create(AOwner: TPersistent;ItemClass: TCollectionItemClass);
Begin
   Inherited Create(AOwner, ItemClass);
end;

destructor TObjTree.Destroy;
begin
  if Designer <> nil then
    Designer.Free;

  inherited;
end;

function TObjTree.AddItem: TObjTreeNode;
begin
  result := Self.Add;
end;

function TObjTree.Add: TObjTreeNode;
begin
  result := inherited Add as TObjTreeNode;
  result.RootTree := Self;
end;

Procedure TObjTree.AsPlainList(var ACollection: TCollection);
var
  i: Integer;
begin
  //Flat list of ALL child nodes with parent relationship, in copy.
  //ACollection must be created and released beforehand

  if ACollection = Nil then
    Exit;

  for I := 0 to Self.Count-1 do
  begin
    ACollection.Add.Assign(Self.Items[I]);
    //Jetzt auf Unterknoten prüfen
    if TObjTreeNode(Self.Items[I]).Count > 0 then
      TObjTreeNode(Self.Items[I]).AsPlainList(ACollection);
  end;
end;

function TObjTree.GetItem(Index: Integer): TObjTreeNode;
begin
  result := TObjTreeNode(inherited Items[Index]);
end;

procedure TObjTree.SetItem(Index: Integer; Value: TObjTreeNode);
begin
  TObjTreeNode(Items[Index]).Assign(Value);
end;

procedure TObjTree.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

end.
