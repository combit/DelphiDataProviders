{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLObjectEditor.pas
 Module : List & Label 25
 Descr. : Implementation file for the List & Label 25 VCL-Component
 Version: 25.000
==================================================================================
}

unit LLObjectEditor;

interface
{$WEAKPACKAGEUNIT ON}
uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Dialogs, Forms, DesignIntf, ObjTree, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList,
  Vcl.ImgList, Vcl.ToolWin, System.ImageList, System.Actions ;


const
  sInvalidParameter = 'Parameter %s von %s darf nicht %s';

type
  TDetailSourcesEditor = class(TForm)
    ObjectTree: TTreeView;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Actions: TActionList;
    TB_Images: TImageList;
    AC_New_Child: TAction;
    ToolButton3: TToolButton;
    AC_Delete: TAction;
    AC_New_Root: TAction;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure ObjectTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DeleteButtonClick(Sender: TObject);
    procedure AC_New_RootExecute(Sender: TObject);
    procedure AC_DeleteExecute(Sender: TObject);
    procedure AC_New_ChildExecute(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    OldSelection : IDesignerSelections;
  protected
    IgnoreChange: Boolean;
    function  GetSelectedComponent(ASelectedNode: TTreeNode): TObjTreeNode;
    function  GetItemText(Item:  TObjTreeNode): string;
    procedure ItemSelectionChanged(Item:  TObjTreeNode);
    procedure ItemRefreshDesign(Sender: TObject);
    procedure ResetForm;
  public
    { Public-Deklarationen }
    Collection: TObjTree;
    Designer  : IDesigner;
    PropertyName: string;  // Name of property being edited
    Component: TComponent; // Handle to component being edited
    procedure  Reload;
    procedure  SetSelection(Instance: TPersistent; Selected: Boolean); virtual;
    procedure  Update; override;
    destructor Destroy; override;
  end;


  procedure ExecuteDetailSourcesEditor(
            ACaption     : string;
            ADesigner    : IDesigner;
            APropertyName: string;
            ACollection  : TObjTree);


var
  DetailSourcesEditor: TDetailSourcesEditor;

implementation
{$R *.dfm}

 procedure ExecuteDetailSourcesEditor(
            ACaption     : string;
            ADesigner    : IDesigner;
            APropertyName: string;
            ACollection  : TObjTree);
Begin
  if ACollection = nil then raise EInvalidOperation.Create(Format(sInvalidParameter, ['ACollection', 'fcExecuteCollectionEditor', 'nil']));

  if DetailSourcesEditor = nil then
     DetailSourcesEditor := TDetailSourcesEditor.Create(Application)
  else
     DetailSourcesEditor.ResetForm;



  with DetailSourcesEditor do
  begin
    PropertyName := APropertyName;
    ACollection.Designer := DetailSourcesEditor;
    Designer := ADesigner;

    if (ACollection<>Collection) and (Collection<>nil) then  Collection.Designer:= nil; { Detach previous collection }

    Collection := ACollection;
    Reload;
    Caption := ACaption;
    Show;
  end
End;

// ===============================================================================================================
//   TDetailSourcesEditor
// ===============================================================================================================

function TDetailSourcesEditor.GetSelectedComponent(ASelectedNode: TTreeNode): TObjTreeNode;
begin
  result := TObjTreeNode(ASelectedNode.Data);
  if result = nil then raise EInvalidOperation.Create('GetSelectedComponent lieferte Nil-Pointer');
end;

function TDetailSourcesEditor.GetItemText(Item: TObjTreeNode): string;
var DisplayName: string;
begin
  DisplayName := Item.DisplayName;
  if (DisplayName = '') and (Item.GetInstance(PropertyName) is TComponent) then
     DisplayName := (Item.GetInstance(PropertyName) as TComponent).Name;
  result := DisplayName;
end;

procedure TDetailSourcesEditor.ItemSelectionChanged(Item: TObjTreeNode);
Var i : Integer;
begin
   i:=0;
   while i<ObjectTree.Items.Count do
   Begin
      if ObjectTree.Items[i].Data = item then
      Begin
         ObjectTree.Selected:=ObjectTree.Items[i];
      end;
      inc(i);
   End;
end;

procedure TDetailSourcesEditor.ObjectTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
Var Selections: IDesignerSelections;
    i         : Integer;
begin
  if (csDestroying in ComponentState) then Exit;

  AC_Delete.Enabled := ObjectTree.Selected <> nil;


  if (Designer = nil) or IgnoreChange then Exit;

  Selections := CreateSelectionList;

  for i:= 0 to ObjectTree.Items.Count - 1 do
    if ObjectTree.Items[i].Selected then
          Selections.Add(GetSelectedComponent(ObjectTree.Items[i]).GetInstance(PropertyName));
  if Selections.Count > 0 then
    Designer.SetSelections(Selections);
end;


procedure TDetailSourcesEditor.Reload;
 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Procedure LoadSubtree(ParentNode:TTreeNode; AChildList:TObjTreeNodeList);
    Var i    : Integer;
        node : TTreeNode;
    Begin
       for i:= 0 to AChildList.Count - 1 do
       begin
          node:=ObjectTree.Items.AddChildObject(ParentNode,GetItemText(AChildList.Nodes[i]),AChildList.Nodes[i]);
          AChildList.Nodes[i].OnItemSelected  := ItemSelectionChanged;
          if AChildList.Nodes[i].ChildNodes.Count>0 then LoadSubtree(node,AChildList.Nodes[i].ChildNodes);
       end
    end;
 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Var i  : Integer;
    tn : TTreeNode;
begin
  ObjectTree.Items.BeginUpdate;
  ObjectTree.Items.Clear;
  for I := 0 to Collection.Count-1 do
  Begin
     if Collection.Items[i].ParentNode = Nil then
     Begin
       tn:=ObjectTree.Items.AddObject(nil,GetItemText(Collection.Items[i]),Collection.Items[i]);
       if Collection.Items[i].ChildNodes.Count>0 then LoadSubtree(tn,Collection.Items[i].ChildNodes);
     end
  End;
  ObjectTree.FullExpand;
  if True then

  ObjectTree.Items.EndUpdate;
end;

procedure TDetailSourcesEditor.ResetForm;
begin
  IgnoreChange := True;
  ObjectTree.Items.Clear;
  IgnoreChange := False;
end;

procedure TDetailSourcesEditor.ItemRefreshDesign(Sender: TObject);
begin
  Reload;
end;

procedure TDetailSourcesEditor.SetSelection(Instance: TPersistent; Selected: Boolean);
var i: Integer;
begin
  IgnoreChange := True;
  for i := 0 to ObjectTree.Items.Count - 1 do
    if ObjectTree.Items[i].Data = Instance then
    Begin
       if Selected then ObjectTree.Selected:=ObjectTree.Items[i];
       Break;
    end;
  IgnoreChange := False;
end;

procedure TDetailSourcesEditor.Update;
begin
  inherited Update;
  Reload;
end;

procedure TDetailSourcesEditor.AC_DeleteExecute(Sender: TObject);
var i: integer;
    Selections, NoSel: IDesignerSelections;
begin
  // Prevent OnChange event from firing.
  IgnoreChange := True;

  if ObjectTree.Selected = nil then Exit;

  Selections := CreateSelectionList;

  if Designer <> nil then
  begin
    Designer.GetSelections(Selections);
    NoSel := CreateSelectionList;
    Designer.SetSelections(NoSel);
  end;

  for i := 0 to Selections.Count - 1 do Selections[i].Free;

  Reload;

  // Allow OnChange event to fire.
  IgnoreChange := False;

  // Set the currently selected ListView item to be selected
  ObjectTreeMouseUp(ObjectTree, mbLeft, [], 0, 0);

  if Designer <> nil then Designer.Modified;
end;

procedure TDetailSourcesEditor.AC_New_ChildExecute(Sender: TObject);
Var Node: TObjTreeNode;
begin
  // Prevent OnChange event from firing.

  IgnoreChange := True;

  if ObjectTree.Selected = nil then Exit;

  node:= GetSelectedComponent(ObjectTree.Selected);

  node.AddChildNode;
  IgnoreChange := False;
  Reload;
  if Designer <> nil then Designer.Modified;
end;

procedure TDetailSourcesEditor.AC_New_RootExecute(Sender: TObject);
begin
  Collection.AddItem;
  Reload;
  if Designer <> nil then Designer.Modified;
end;

procedure TDetailSourcesEditor.DeleteButtonClick(Sender: TObject);
var i: integer;
    Selections, NoSel: IDesignerSelections;
begin
  // Prevent OnChange event from firing.
  IgnoreChange := True;

  if ObjectTree.Selected = nil then Exit;

  if Designer <> nil then
  begin
    Selections := CreateSelectionList;
    Designer.GetSelections(Selections);
    NoSel := CreateSelectionList;
    Designer.SetSelections(NoSel);
    for i := 0 to Selections.Count - 1 do Selections[i].Free;
  end;
  Reload;

  // Allow OnChange event to fire.
  IgnoreChange := False;

  // Set the currently selected ListView item to be selected
  ObjectTreeMouseUp(ObjectTree, mbLeft, [], 0, 0);

  if Designer <> nil then Designer.Modified;

end;

destructor TDetailSourcesEditor.Destroy;
begin
  Collection.Designer := nil;
  DetailSourcesEditor := nil;
  inherited Destroy;
end;

procedure TDetailSourcesEditor.FormHide(Sender: TObject);
begin
  if Designer <> nil then
  Begin
     Designer.SetSelections(OldSelection);
     Designer.Modified;
     Designer.SelectItemName('DataController');
     Designer.SelectItemName('DetailSources');
  End;
end;

procedure TDetailSourcesEditor.FormShow(Sender: TObject);
begin
  if Designer <> nil then
  begin
    OldSelection := CreateSelectionList;
    Designer.GetSelections(OldSelection);
  end;
end;

initialization
  // nix zu tun
finalization
  DetailSourcesEditor.Free;
  DetailSourcesEditor:= nil;

end.
