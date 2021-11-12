{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : l27CommonInterfaces.pas
 Module : List & Label 27 Interface definitions
 Descr. : Implementation file for the List & Label 27 VCL-Component
 Version: 27.000
==================================================================================
}
unit l27CommonInterfaces;

interface
{$WEAKPACKAGEUNIT ON} 

uses
	windows,
    activex,
    graphics,
    classes
    ;

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