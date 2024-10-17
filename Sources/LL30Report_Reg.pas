{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LL30Report_Reg.pas
 Module : List & Label 30
 Descr. : Implementation file for the List & Label 30 VCL-Component
 Version: 30.000
==================================================================================
}

unit LL30Report_Reg;
{$define UNICODE}

interface

uses Forms, Dialogs, Classes, DesignIntf, DesignEditors;
type
  TListLabel30Loader = class(TComponentEditor)
  public
    procedure Edit; override;
    function  GetVerbCount: Integer; Override;
    function  GetVerb(Index: Integer): string; Override;
    procedure ExecuteVerb(Index: Integer); Override;
  end;

  TDetailsSourcesPropertyEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TDetailsSourcesKeyFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetDataSourcePropName: string; virtual;
  end;

  procedure Register;

implementation
uses StrEdit, ListLabel30, LLReport_Types, LLObjectEditor, Typinfo, DB, LLPreview;

procedure Register;
begin

  RegisterComponentEditor(TListLabel30, TListLabel30Loader);
  RegisterComponents('combit', [TListLabel30, TLlPreviewControl30, TLlDesignerObject30, TLlDesignerFunction30, TLDesignerAction30, TLlRTFControl30]);
  RegisterPropertyEditor(TypeInfo(TDetailSourceList),TListLabel30, 'DetailSources',        TDetailsSourcesPropertyEditor);
  RegisterPropertyEditor(TypeInfo(TDetailSourceList),TLLDataController, 'DetailSources',TDetailsSourcesPropertyEditor);

end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{                         TLLDesignerLoader                         }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
procedure TListLabel30Loader.Edit;
begin
    ExecuteDetailSourcesEditor( TListLabel30(Component).Name + '.DetailSources',
                                Designer,
                                'DetailSources',
                                TListLabel30(Component).DataController.DetailSources);
end;


function  TListLabel30Loader.GetVerbCount: Integer;
begin
   GetVerbCount:=inherited GetVerbCount+1;
end;

function  TListLabel30Loader.GetVerb(Index: Integer): string;
begin
   Case Index of
      0: GetVerb:='Edit data structure...';
      else GetVerb:=inherited GetVerb(index-1);
   end;
end;

procedure TListLabel30Loader.ExecuteVerb(Index: Integer);
begin
   Case Index of
      0: self.Edit;
      else inherited ExecuteVerb(index-1);
   end;
end;


function TDetailsSourcesPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paDialog, paReadOnly];
end;

function TDetailsSourcesPropertyEditor.GetValue: string;
begin
 result := '(TDetailSourceList)';
end;

procedure TDetailsSourcesPropertyEditor.Edit;
begin
   if GetComponent(0) is TLLDataController then
   Begin
      ExecuteDetailSourcesEditor( TLLDataController(GetComponent(0)).Owner.Name + '.DetailSources',
                                  Designer,
                                  'DetailSources',
                                  TLLDataController(GetComponent(0)).DetailSources);
   end;
end;



function GetPropertyValue(Instance: TPersistent; const PropName: string): TPersistent;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Instance, PropInfo)) as TPersistent;
end;

function TDetailsSourcesKeyFieldProperty.GetAttributes: TPropertyAttributes;
Begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDetailsSourcesKeyFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetPropertyValue(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;

procedure TDetailsSourcesKeyFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;


End;

function TDetailsSourcesKeyFieldProperty.GetDataSourcePropName: string;
Begin
   if GetPropInfo.Name = 'DetailKeyField'  then  Exit('DataSource');
   if GetPropInfo.Name = 'PrimaryKeyField' then  Exit('DataSource');
   Result := 'MasterSource';
End;

end.
