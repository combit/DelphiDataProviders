{=================================================================================
	Product:    : combit List & Label
	File        : combit.ListLabel32.DataProviderInterface.pas
	Version     : 32.0
	------------------------------------------------------------------------------
	Copyright © combit GmbH
	www.combit.net
==================================================================================}

unit combit.ListLabel32.DataProviderInterface;

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
