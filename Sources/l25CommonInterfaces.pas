{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : l25CommonInterfaces.pas
 Module : List & Label 25 Interface definitions
 Descr. : Implementation file for the List & Label 25 VCL-Component
 Version: 25.000
==================================================================================
}
unit l25CommonInterfaces;

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