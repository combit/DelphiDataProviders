# Project Description
This project is a community effort to write TListLabelDataProvider implementations for usage with reporting tool combit List & Label. While the support for .NET has been around a long time, we're trying to build a similar ecosystem for Delphi through this project. Any help is greatly appreciated.

Currently, we're looking at building up a team. The files included are mere prototypes and require List & Label 22 to run. Contact the project admin if you're interested and we'll get together the bits to get you started.

For a fully functional free 30-day trial version and further information about reporting tool List & Label 
please visit: https://www.combit.net/en/reporting-tool/

# What's available so far
The abstract base class for TListLabelDataProvider mimics exactly what's available on the .NET end. A very simple prototype allows to add TFDQuery elements as separate tables.

# What's required
Do you know your way through FireDAC? Can you provide code for sorting or filtering? Then you're the guy we're looking for.

# Why bother?
If you're using List & Label with Delphi, you'll have encountered a set of restrictions this project is aiming to remove:
Multiple report containers
Support for FireDAC instead of BDE
Nested tables
Keep blocks together

Any feedback as well as additional contributions are very welcome, just contact the project's administrator.

# Example
To give you an impression: the usage of the very raw prototype for a designer call and following print would be:

  // Pass the data structure
  for table in Tables do
  begin
    // Pass table
    LL.LlDbAddTable(Table.TableName, Table.TableName);
    Rows := table.Rows;
    RowEnumerator := Rows.GetEnumerator;
    RowEnumerator.MoveNext;

    // Pass columns
    Row := RowEnumerator.Current;
    Columns := Row.Columns;
    for Column in Columns do
    begin
      LL.LlDefineFieldExt(table.TableName+'.'+Column.ColumnName, Column.Content, Column.FieldType);
    end;
    Columns.Free;
    Row.Free;
    RowEnumerator.Free;
    Rows.Free;

    // Pass sortings
    if table.SupportsSorting or table.SupportsAdvancedSorting then
    begin
      SortDescriptions := table.SortDescriptions;
      for SortOrder in SortDescriptions do
      begin
        LL.LlDbAddTableSortOrder(table.TableName, SortOrder, SortOrder);
      end;
      SortDescriptions.Free;
    end;

    // pass relations
    Relations := provider.Relations;
    if (Relations <> nil) then
    begin
    for Relation in Relations do
      begin
        LL.LlDbAddTableRelationEx(Relation.ChildTableName,
                                  Relation.ParentTableName,
                                  Relation.RelationName,
                                  Relation.RelationName,
                                  Relation.ChildColumnName,
                                  Relation.ParentColumnName);
      end;
      Relations.Free;
    end;
  end;

  Tables.Free;
  // Prepare COM interface wrapper
  dataProvider := TDataProviderInterfaceProxyRoot.Create(LL, provider);

  // Pass to LL
  LL.LlSetOption(253, lParam(ILlDataProvider(dataProvider)));

  LL.LlDefineLayout(Handle, '', LL_PROJECT_LIST, 'c:\temp\test.lst');

  LL.LlPrintWithBoxStart(LL_PROJECT_LIST, 'c:\temp\test.lst', LL_PRINT_PREVIEW, LL_BOXTYPE_NONE, Handle, 'Printing');

  while LL.LlPrint = LL_WRN_REPEAT_DATA do
  begin
  end;

  LL.LlPrintEnd(0);
  provider.Free;
