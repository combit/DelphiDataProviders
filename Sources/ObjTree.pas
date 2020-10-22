{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : ObjTree.pas
 Module : List & Label 26
 Descr. : Implementation file for the List & Label 26 VCL-Component
 Version: 26.000
==================================================================================
}

unit ObjTree;

interface
{$WEAKPACKAGEUNIT ON}
uses Classes, Controls, Windows, ActiveX, SysUtils, Dialogs;

type
  TObjTreeNode = class;
  TObjTree     = class;

  TObjSelectionProc = procedure(Item: TObjTreeNode) of object;

  TObjTreeNodeList = Class(TStringList)
  Private
    Function  GetNode(Index: Integer) :TObjTreeNode;
    Procedure SetNode(Index: Integer; Value: TObjTreeNode);
  Public
    function AddNode(ANode: TObjTreeNode): Integer;
    function DeleteNode(ANode: TObjTreeNode): Boolean;
    function DeleteNodeNr(index: Integer): Boolean;
    property Nodes[Index: Integer]: TObjTreeNode read GetNode write SetNode;
  End;

  TObjTreeNode = class(TCollectionItem)
  private
    FSelectionProc: TObjSelectionProc;
    FTag          : Integer;
    FChildNodes   : TObjTreeNodeList;
    FParentNode   : TObjTreeNode;
  protected
    procedure DoOnItemSelected(Value: TObjSelectionProc); virtual;
    Procedure MakeNodeToChild(ANode:TObjTreeNode); virtual;
  public
    constructor Create(Collection: TCollection); override;
    Destructor Destroy; Override;
    function  GetInstance(const PropertyName: string): TPersistent; virtual;
    procedure UpdateEditorDisplay(Sender: TObject);

    Function  AddChildNode: TObjTreeNode; virtual;

    property  OnItemSelected: TObjSelectionProc read FSelectionProc write DoOnItemSelected;
    property  ChildNodes : TObjTreeNodeList read FChildNodes write FChildNodes;
    Property  ParentNode : TObjTreeNode read FParentNode write FParentNode;
    property  Tag: Integer read FTag write FTag;
  end;

  TObjTree = class(TOwnedCollection)
  private
    FDesigner: TControl;
    function GetItems(Index: Integer): TObjTreeNode;
  protected
    procedure SetDesigner(Value: TControl); virtual;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor  Destroy; override;
    function    AddItem: TObjTreeNode; virtual;
    property    Designer: TControl read FDesigner write SetDesigner;
    property    Items[Index: Integer]: TObjTreeNode read GetItems;
  end;

implementation
//=====================================================================================================================
// TObjTreeNodeList
//=====================================================================================================================
function TObjTreeNodeList.AddNode(ANode: TObjTreeNode): Integer;
Begin
   result:=AddObject('',ANode);
End;

function TObjTreeNodeList.DeleteNode(ANode: TObjTreeNode): Boolean;
var i : Integer;
Begin
   for i := 0 to Count-1 do
   Begin
       if Objects[i] = ANode  then
       Begin
          Delete(i);
          Break;
       End;
   End;
   Result := true;
End;

function TObjTreeNodeList.DeleteNodeNr(index: Integer): Boolean;
Begin
   Objects[index].Free;
   Delete(index);
   Result := true;
End;

Function  TObjTreeNodeList.GetNode(Index: Integer) :TObjTreeNode;
Begin
  result:= TObjTreeNode(Objects[Index]);
End;

Procedure TObjTreeNodeList.SetNode(Index: Integer; Value: TObjTreeNode);
Begin
   Objects[Index]:=Value;
End;

//=====================================================================================================================
// TObjTreeNode
//=====================================================================================================================

constructor TObjTreeNode.Create(Collection: TCollection);
Begin
  inherited Create(Collection);
  FParentNode := Nil;
  FChildNodes := TObjTreeNodeList.Create;

End;

Destructor TObjTreeNode.Destroy;
Begin
   if ParentNode<>nil  then
   Begin
      ParentNode.ChildNodes.DeleteNode(self);
      ParentNode:=nil;
   End;

   While ChildNodes.Count > 0 do
   Begin
      ChildNodes.DeleteNodeNr(ChildNodes.Count-1);
   End;

   FChildNodes.Free;
   FChildNodes := nil;
   inherited Destroy;
End;

function TObjTreeNode.GetInstance(const PropertyName: string): TPersistent;
begin
  result := self;
end;

procedure TObjTreeNode.DoOnItemSelected(Value: TObjSelectionProc);
begin
end;

procedure TObjTreeNode.UpdateEditorDisplay(Sender: TObject);
begin
  with (Collection as TObjTree) do
    if Designer <> nil then Designer.Update;
end;


Procedure TObjTreeNode.MakeNodeToChild(ANode:TObjTreeNode);
Begin
  ANode.ParentNode:=Self;
  ChildNodes.AddNode(ANode);
End;

Function  TObjTreeNode.AddChildNode: TObjTreeNode;
Var node: TObjTreeNode;
Begin
  node   := Collection.Add as TObjTreeNode;
  MakeNodeToChild(node);
  result := node;
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
  if Designer <> nil then Designer.Free;
  inherited;
end;

function TObjTree.AddItem: TObjTreeNode;
begin
  result := Add as TObjTreeNode;
end;

function TObjTree.GetItems(Index: Integer): TObjTreeNode;
begin
  result := TObjTreeNode(inherited Items[Index]);
end;

procedure TObjTree.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

end.
