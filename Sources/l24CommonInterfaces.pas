{=================================================================================

 Copyright © combit GmbH, Konstanz

----------------------------------------------------------------------------------
 File   : l24CommonInterfaces.pas
 Module : List & Label 24 Interface definitions
 Descr. : Implementation file for the List & Label 24 VCL-Component
 Version: 24.000
==================================================================================
}
unit l24CommonInterfaces;

interface

uses
	windows,
    activex,
    graphics,
    classes
    ;

type
  {$ifndef VER90}
  {$ifndef VER100}
  {$ifndef VER110}
  {$ifndef VER120}
  {$ifndef VER125}
  {$ifndef VER130}
  {$ifndef VER135}
  {$ifndef VER140}
  {$ifndef VER150}
  {$ifndef VER160}
  {$ifndef VER170}
  {$ifndef VER180}
  {$ifndef VER185}
  {$ifndef VER190}
  {$define UNICODE}
  {$define USE_UNICODE_DLL}
  {$define UNICODESTRING_AWARE}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}
  {$endif}

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