{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLObjectEditor.pas
 Module : List & Label 27
 Descr. : Implementation file for the List & Label 27 VCL-Component
 Version: 27.000
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
    DisplayTree: TTreeView;
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
    procedure DisplayTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);    
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
    function GetSelectedObject(ASelectedNode: TTreeNode): TObjTreeNode;
    function  GetItemText(Item:  TObjTreeNode): string;
    procedure ItemSelectionChanged(Item:  TObjTreeNode);
    procedure ItemRefreshDesign(Sender: TObject);
    procedure ResetForm;
  public
    { Public-Deklarationen }
    RootNodes: TObjTree;
    Designer  : IDesigner;
    PropertyName: string;  // Name of property being edited
    Component: TComponent; // Handle to component being edited
    procedure  Reload;
    procedure  SetSelection(Instance: TPersistent; Selected: Boolean); virtual;
    procedure  Update; override;
    destructor Destroy; override;
  end;

procedure ExecuteDetailSourcesEditor(ACaption: string; ADesigner: IDesigner; APropertyName: string;
            ACollection  : TObjTree);


var
  DetailSourcesEditor: TDetailSourcesEditor;

implementation
{$R *.dfm}

procedure ExecuteDetailSourcesEditor(ACaption: string; ADesigner: IDesigner; APropertyName: string;
            ACollection  : TObjTree);
Begin
  if ACollection = nil then
    raise EInvalidOperation.Create(Format(sInvalidParameter, ['ACollection', 'fcExecuteCollectionEditor', 'nil']));

  if DetailSourcesEditor = nil then
     DetailSourcesEditor := TDetailSourcesEditor.Create(Application)
  else
     DetailSourcesEditor.ResetForm;



  with DetailSourcesEditor do
  begin
    PropertyName := APropertyName;
    ACollection.Designer := DetailSourcesEditor;
    Designer := ADesigner;

    if (ACollection <> RootNodes) and (RootNodes <> nil) then
      RootNodes.Designer := nil; { Detach previous collection }

    RootNodes := ACollection;
    Reload;
    Caption := ACaption;
    Show;
  end
End;

// ===============================================================================================================
//   TDetailSourcesEditor
// ===============================================================================================================

function TDetailSourcesEditor.GetSelectedObject(ASelectedNode: TTreeNode): TObjTreeNode;
begin
  result := TObjTreeNode(ASelectedNode.Data);
  if result = nil then
    raise EInvalidOperation.Create('GetSelectedComponent lieferte Nil-Pointer');
end;

function TDetailSourcesEditor.GetItemText(Item: TObjTreeNode): string;
var
  DisplayName: string;
begin
  DisplayName := Item.DisplayName;
  if (DisplayName = '') and (Item.GetInstance(PropertyName) is TComponent) then
     DisplayName := (Item.GetInstance(PropertyName) as TComponent).Name;
  result := DisplayName;
end;

procedure TDetailSourcesEditor.ItemSelectionChanged(Item: TObjTreeNode);
Var
  i: Integer;
begin
   i:=0;
  while i < DisplayTree.Items.Count do
   Begin
    if DisplayTree.Items[i].Data = Item then
      Begin
      DisplayTree.Selected := DisplayTree.Items[i];
      end;
      inc(i);
   End;
end;

procedure TDetailSourcesEditor.DisplayTreeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
Var
  Selections: IDesignerSelections;
    i         : Integer;
begin
  if (csDestroying in ComponentState) then
    Exit;

  AC_Delete.Enabled := DisplayTree.Selected <> nil;

  if (Designer = nil) or IgnoreChange then
    Exit;

  Selections := CreateSelectionList;

  for i := 0 to DisplayTree.Items.Count - 1 do
    if DisplayTree.Items[i].Selected then
      Selections.Add(GetSelectedObject(DisplayTree.Items[i]).GetInstance(PropertyName));
  if Selections.Count > 0 then
    Designer.SetSelections(Selections);

  { if ObjectTree.SelectionCount = 1 then
    GetSelectedComponent(ObjectTree.Selected).GotSelected; }
end;


procedure TDetailSourcesEditor.Reload;
 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Procedure LoadSubtree(ParentNode: TTreeNode; AChildList: TObjTreeNode);
  Var
    i: Integer;
        node : TTreeNode;
    Begin
       for i:= 0 to AChildList.Count - 1 do
       begin
      node := DisplayTree.Items.AddChildObject(ParentNode, GetItemText(AChildList[i]), AChildList[i]);
      AChildList[i].OnItemSelected := ItemSelectionChanged;
      if AChildList[i].Count > 0 then
        LoadSubtree(node, AChildList[i]);
       end
    end;
 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Var
  i: Integer;
    tn : TTreeNode;
begin
  DisplayTree.Items.BeginUpdate;
  DisplayTree.Items.Clear;
  for i := 0 to RootNodes.Count - 1 do
  Begin
      tn := DisplayTree.Items.AddObject(nil, GetItemText(RootNodes.Items[i]), RootNodes.Items[i]);
      if RootNodes.Items[i].Count > 0 then
        LoadSubtree(tn, RootNodes.Items[i]);
  End;
  DisplayTree.FullExpand;
  DisplayTree.Items.EndUpdate;
end;

procedure TDetailSourcesEditor.ResetForm;
begin
  IgnoreChange := True;
  DisplayTree.Items.Clear;
  IgnoreChange := False;
end;

procedure TDetailSourcesEditor.ItemRefreshDesign(Sender: TObject);
begin
  Reload;
end;

procedure TDetailSourcesEditor.SetSelection(Instance: TPersistent; Selected: Boolean);
var
  i: Integer;
begin
  IgnoreChange := True;
  for i := 0 to DisplayTree.Items.Count - 1 do
    if DisplayTree.Items[i].Data = Instance then
    Begin
      if Selected then
        DisplayTree.Selected := DisplayTree.Items[i];
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
var
  OldItemIndex: Integer;
  node: TObjTreeNode;
begin
  // Prevent OnChange event from firing.
  IgnoreChange := True;

  if DisplayTree.Selected = nil then
    Exit;

  node := GetSelectedObject(DisplayTree.Selected);

  OldItemIndex := Node.Index;

  if node.ParentNode <> Nil then
    node.ParentNode.Delete(OldItemIndex)
  Else
    Node.RootTree.Delete(OldItemIndex);


  Self.Reload;

  // Allow OnChange event to fire.
  IgnoreChange := False;

  // Set the currently selected ListView item to be selected
  DisplayTreeMouseUp(DisplayTree, mbLeft, [], 0, 0);

  if Designer <> nil then
    Designer.Modified;
end;

procedure TDetailSourcesEditor.AC_New_ChildExecute(Sender: TObject);
Var
  node: TObjTreeNode;
begin
  // Prevent OnChange event from firing.

  IgnoreChange := True;

  if DisplayTree.Selected = nil then
    Exit;

  node := GetSelectedObject(DisplayTree.Selected);

  node.AddChildNode;
  IgnoreChange := False;
  Reload;

  if Designer <> nil then
    Designer.Modified;
end;

procedure TDetailSourcesEditor.AC_New_RootExecute(Sender: TObject);
begin
  RootNodes.Add;

  Reload;

  if Designer <> nil then
    Designer.Modified;
end;

destructor TDetailSourcesEditor.Destroy;
begin
  RootNodes.Designer := nil;
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
