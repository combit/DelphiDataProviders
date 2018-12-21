unit Unit1;

interface

uses
  Registry, LlReport_Types,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client,  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, ListLabel24, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef;

type
  TForm1 = class(TForm)
    lblGermanDescription: TLabel;
    lblEnglishDescription: TLabel;
    lblGerman: TLabel;
    lblEnglish: TLabel;
    groupInvoiceAndItemsList: TGroupBox;
    groupInvoiceMerge: TGroupBox;
    btnDesignInvoiceAndItemsList: TButton;
    btnPrintInvoiceAndItemsList: TButton;
    btnDesignInvoiceMerge: TButton;
    btnPrintInvoiceMerge: TButton;
    FDConnectionNorthwind: TFDConnection;
    FDQueryOrders: TFDQuery;
    DataSourceOrders: TDataSource;
    FDQueryOrderDetails: TFDQuery;
    DataSourceOrderDetails: TDataSource;
    ListLabel: TListLabel24;
    procedure FormCreate(Sender: TObject);
    procedure btnDesignInvoiceAndItemsListClick(Sender: TObject);
    procedure btnPrintInvoiceAndItemsListClick(Sender: TObject);
    procedure btnDesignInvoiceMergeClick(Sender: TObject);
    procedure btnPrintInvoiceMergeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses system.Generics.Collections;

procedure TForm1.btnDesignInvoiceAndItemsListClick(Sender: TObject);
begin

  ListLabel.DataController.AutoMasterMode := TLlAutoMasterMode.mmAsFields;
  ListLabel.DataController.DataMember := '';
  ListLabel.AutoProjectFile := 'inv_lst.lst';
  ListLabel.Design;

end;

procedure TForm1.btnDesignInvoiceMergeClick(Sender: TObject);
begin

  ListLabel.DataController.AutoMasterMode := TLlAutoMasterMode.mmAsVariables;
  ListLabel.DataController.DataMember := 'Orders';
  ListLabel.AutoProjectFile := 'inv_merg.lst';
  ListLabel.Design;

end;

procedure TForm1.btnPrintInvoiceAndItemsListClick(Sender: TObject);
begin

  ListLabel.DataController.AutoMasterMode := TLlAutoMasterMode.mmAsFields;
  ListLabel.DataController.DataMember := '';
  ListLabel.AutoProjectFile := 'inv_lst.lst';
  ListLabel.Print;

end;

procedure TForm1.btnPrintInvoiceMergeClick(Sender: TObject);
begin

  ListLabel.DataController.AutoMasterMode := TLlAutoMasterMode.mmAsVariables;
  ListLabel.DataController.DataMember := 'Orders';
  ListLabel.AutoProjectFile := 'inv_merg.lst';
  ListLabel.Print;

end;

procedure TForm1.FormCreate(Sender: TObject);
Var NWindDatabasePath: String;
Registry: TRegistry;
Error: Boolean;
ErrorMessage: String;
begin

   Error := False;
   ErrorMessage := 'Unable to find sample database. Make sure List & Label is installed correctly.';

   Registry := TRegistry.Create(KEY_READ);
   if (Registry.OpenKeyReadOnly('Software\combit\cmbtll')) then
   begin

      NWindDatabasePath := Registry.ReadString('NWINDPath');
      if (FileExists(NWindDatabasePath)) then
      begin

        try

          FDConnectionNorthwind.Connected := False;
          FDConnectionNorthwind.Params.Database := NWindDatabasePath;
          FDConnectionNorthwind.Connected := True;

        Except

            on Ecx: Exception do
            begin

              Error := True;
              ErrorMessage := 'Unable to find sample database. Make sure List & Label is installed correctly.' + #13#10#13#10 + Ecx.ClassName + ' error raised, with message: ' + Ecx.Message;

            end;

        end;

      end
      else
      begin

        Error := True;

      end;

      Registry.CloseKey;

   end
   else
   begin

    Error := True;

   end;

   Registry.Free;

   if (Error) then
   begin

      MessageBox(self.Handle, PWideChar(ErrorMessage), 'List & Label', MB_OK);

      btnDesignInvoiceMerge.Enabled := False;
      btnPrintInvoiceMerge.Enabled := False;
      btnDesignInvoiceAndItemsList.Enabled := False;
      btnPrintInvoiceAndItemsList.Enabled := False;

   end;

end;

end.
