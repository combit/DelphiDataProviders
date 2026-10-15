{=================================================================================
	Product:    : combit List & Label
	File        : combit.ListLabel32.CommonInterfaces.pas
	Version     : 32.0
	------------------------------------------------------------------------------
	Copyright © combit GmbH
	www.combit.net
==================================================================================}

unit combit.ListLabel32.CommonInterfaces;

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
