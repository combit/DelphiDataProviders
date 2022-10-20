{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : l28CommonInterfaces.pas
 Module : List & Label 28 Interface definitions
 Descr. : Implementation file for the List & Label 28 VCL-Component
 Version: 28.000
==================================================================================
}
unit l28CommonInterfaces;

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
