{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : LLPrintPreviewThread.pas
 Module : List & Label 24
 Descr. : Implementation file for the List & Label 24 VCL-Component
 Version: 24.000
==================================================================================
}

unit LLPrintPreviewThread;

interface

uses
  Classes, SysUtils, Windows, ListLabel24;

type

  TPrintPreviewThread = class(TThread)
  private
    procedure DesignerPrintPreview();
  protected
    procedure Execute; override;
  public
    printInstance: TListLabel24;
    ProjectFile: string;
    OriginalProjectFile: string;
    exportFormat: String;
    ControlHandle: Cardinal;
    eventHandle: Cardinal;
    pageCount: integer;
    doExport: boolean;

    FCount: integer;
    Terminated: boolean;

    IsPrinting: boolean;

    procedure FinalizePrinting();
    procedure Abort();

  end;

implementation

uses cmbtls24x;

procedure TPrintPreviewThread.Abort;
begin
  Terminated := True;
end;

procedure TPrintPreviewThread.DesignerPrintPreview;
begin

  Try
    PostMessage(ControlHandle, LS_VIEWERCONTROL_UPDATE_TOOLBAR, 0, 0);
    printInstance.DoPreviewAndDrilldown(ControlHandle, False, ProjectFile, '', pageCount, '', Nil, 0);
  Finally
    Terminated := True;
  End;

end;

procedure TPrintPreviewThread.Execute;
begin
  IsPrinting := false;
  Synchronize(DesignerPrintPreview);
end;

procedure TPrintPreviewThread.FinalizePrinting();
begin
  Abort();
end;

end.
