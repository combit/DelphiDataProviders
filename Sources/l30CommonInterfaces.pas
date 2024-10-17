{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : l30CommonInterfaces.pas
 Module : List & Label 30 Interface definitions
 Descr. : Implementation file for the List & Label 30 VCL-Component
 Version: 30.000
==================================================================================
}
unit l30CommonInterfaces;

interface
{$WEAKPACKAGEUNIT ON}

uses
	windows,
    activex,
    graphics,
    classes;

type
 {$if CompilerVersion > 19}
 {$define UNICODE}
 {$define USE_UNICODE_DLL}
 {$define UNICODESTRING_AWARE}
 {$ifend}

 {$ifdef UNICODE}
  {$ifdef UNICODESTRING_AWARE}
  TString = UnicodeString;
  {$else}
  TString = WideString;
  {$endif}
  {$else}
  TString = String;
  {$endif}

  {$ifdef UNICODESTRING_AWARE}
  PXChar = PWideChar;
  XChar  = WideChar;
  {$else}
  PXChar = PChar;
  XChar = Char;
  {$endif}

ILlDomParent = interface
  procedure InitDataSource(projectFile: TString);
  procedure DeclareLlXObjectsToLL;
  function GetJobHandle: Integer;
end;
implementation
end.
