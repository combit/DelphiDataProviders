{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : ListLabelDataProviderInterface.pas
 Module : List & Label 30
 Descr. : Implementation file for the List & Label 30 VCL-Component
 Version: 30.001
==================================================================================
}

unit ListLabelDataProviderInterface;

interface

Type
  DefineDelayedInfoType = (diSortOrdersDesigning = 0, diSortOrdersPrinting = 1);

Type
    ILlDataProvider=Interface
      ['{3cbae450-8880-11d2-96a3-0060086fefff}']
      function OpenTable(const pszTableName: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
      function OpenChildTable(const pszRelation: PWideChar; out ppUnkOfNewDataProvider: ILlDataProvider): HResult; stdcall;
      function GetRowCount(var pnRows: integer): HResult; stdcall;
      function DefineDelayedInfo(nInfo: integer): HResult; stdcall;
      function MoveNext(): HResult; stdcall;
      function DefineRow(diDefineDelayInfoType: DefineDelayedInfoType; const arvRelations: Variant): HResult; stdcall;
      function Dispose(): HResult; stdcall;
      function SetUsedIdentifiers(const arvVieldRestriction: Variant): HResult; stdcall;
      function ApplySortOrder(const pszSortOrder: PWideChar): HResult; stdcall;
      function ApplyFilter(const arvFields: Variant; const arvValues: Variant): HResult; stdcall;
      function ApplyAdvancedFilter(const pszFilter: PWideChar; const arvValues: Variant): HResult; stdcall;
      function SetOption(nIndex: integer; const pvValue: Variant): HResult; stdcall;
      function GetOption(nIndex: integer; var pvValue: Variant): HResult; stdcall;
    End;

implementation

end.
