{ =================================================================================

  Copyright © combit GmbH, Konstanz

  ----------------------------------------------------------------------------------
  File   : l28dom.pas
  Module : List & Label 28 DOM
  Descr. : Implementation file for the List & Label 28 DOM
  Version: 28.000
  ==================================================================================
}

unit l28dom;
{$if CompilerVersion > 10}
{$DEFINE USELLXOBJECTS}
{$ifend}


{$if CompilerVersion > 19}
{$define UNICODE}
{$define USE_UNICODE_DLL}
{$define UNICODESTRING_AWARE}
{$ifend}


interface

uses
  classes, Dialogs, SysUtils, graphics, Windows, System.Variants,l28CommonInterfaces,cmbtll28x
  {$if CompilerVersion > 27} // XE7 and newer
  , System.UITypes
  {$ifend}
  {$ifdef VER90}
  ,ole2
  {$else}
  ,activex
  {$endif}

  ;

type
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

  {$if CompilerVersion<=18.5}
     NativeInt = Integer;
     NativeUInt = Cardinal;
     DWORD_PTR = DWORD;
  {$ifend}

  cmbtHWND = DWORD_PTR; // needed for C++Builder compatibility
  TLlDOMPropertyTableFieldBarCodeSource = class;
  TLlDOMTableFieldBarcode = class;
  TLlDOMPropertyBarcodeSource =class;
  TLlDOMPropertyVisual = class;
  TLlDOMPropertyLineSmoothing = class;
  TLlDOMPropertyInputButtonActionPdfSig = class;
  TLlDOMPropertyInputButtonActionSendTo = class;
  TLlDOMPropertyInputButtonActionSaveAs = class;
  TLlDOMPropertyInputButtonActionHttpPost = class;
  TLlDOMPropertyInputButtonActionLink = class;
  TLlDOMPropertyInputButtonActionBase = class;
  TLlDOMTableInputFieldButton = class;
  TLlDOMTableInputFieldComboBox = class;
  TLlDOMTableInputFieldCheckbox = class;
  TLlDOMTableInputFieldEdit = class;
  TLlDOMPropertyFillingExt = class;
  TLlDOMPropertyFillingWithBitmap = class;
  TLlDOMTableField = class;
  TLlDOMTableInputFieldBase = class;
  TLlDOMPropertyDefaultFontExt = class;
  TLlDOMPropertyFrameExt = class;
  TLlDOMPropertyRScriptCommonVarExport = class;
  TLlDOMPropertyRScriptDataEntryItem = class;
  TLlDOMRScriptEntryItemsList = class;
  TLlDOMPropertyRScriptData = class;
  TLlDOMPropertyRScriptOutputExtension = class;
  TLlDOMPropertyChartEngineRscript = class;
  TLlDOMPropertyValueAxisBaseMinimal = class;
  TLlDOMPropertyConditionalFormatterItem = class;
  TLlDOMPropertyChartEngineTreeMapClustered = class;
  TLlDOMPropertyValueAxisTreeMap = class;
  TLlDOMPropertyValueAxisArrayTreeMap = class;
  TLlDOMPropertyChartEngineTreeMapSingle = class;
  TLlDOMPropertyChartEngineTreeMapBase = class;
  TLlDOMPropertyCategoryAxisXTreeMap = class;
  TLlDOMPropertyChartEngineRadarBase = class;
  TLlDOMPropertyChartEngineRadar = class;
  TLlDOMPropertyChartEngineRadarSimple = class;
  TLlDOMPropertyChartEngineRadarStacked = class;
  TLlDOMPropertyChartEngineRadarStackedRelative = class;
  TLlDOMPropertyChartEngineRadarClustered = class;
  TLlDOMPropertyCategoryAxisXRadar = class;
  TLlDOMPropertyCategoryAxisYRadar = class;
  TLlDOMPropertyCategoryAxisX = class;
  TLlDOMPropertyCategoryAxisY = class;
  TLlDOMPropertyCategoryAxisBase = class;
  TLlDOMPropertyGridMode = class;
  TLlDomPropertyGridLineStyle = class;
  TLlDOMPropertyAnimation = class;
  TLlDOMPropertyXhtmlAnimation = class;
  TLlDOMPropertyAnimationTrigger = class;
  TLlDOMPropertyPageBreakOptions = class;
  TLlDOMPropertyAutoFill = class;
  TLlDOMPropertySortOrderAscending = class;
  TLlDOMPropertyMaxEntryCount = class;
  TLlDOMPropertyMatchDevicePixel = class;
  TLlDOMPropertyDrawingContents = class;
  TLlDOMTableFieldCheckbox = class;
  TLlDOMPropertyCheckboxItemFor = class;
  TLlDOMPropertyCheckboxDesign = class;
  TLlDOMPropertyCheckboxDefinition = class;
  TLlDOMPropertyFrameCheckBox = class;
  TLlDOMObjectCheckbox = class;
  TLlDOMObjectBase = class;
  TLlDOMDrillDownLinkBase = class;
  TLlDOMPropertyChartEngineBase = class;
  TLlDOMDrillDownLink = class;
  TLlDOMDrillDownLinkForParameterizedSubreport = class;
  TLlDOMDrillDownReportParameterListItem = class;
  TLlDOMDrillDownReportParameterList = class;
  TLlDOMPropertyChartEngineDonut = class;
  TLlDOMPPropertyRectBase = class;
  TLlDOMPropertyShapeBoundarySelection = class;
  TLlDOMPropertyRectangleFrame = class;
  TLlDOMListCollectionVariables = class;
  TLlDOMCollectionVariable = class;
  TLlDOMListCollectionVariablesListItems = class;
  TLlDOMCollectionVariableListItem = class;
  TLlDOMListCollectionVariableColumns = class;
  TLlDOMCollectionVariableColumn = class;
  TLlDOMPropertyShapeBackground = class;
  TLlDOMPropertyShapeItemBase = class;
  TLlDOMPropertyShapeDefinition = class;
  TLlDOMPropertyShapeDefinitionData = class;
  TLlDOMPropertyForegroundShapesItem = class;
  TLlDOMPropertyBackgroundShapesItem = class;
  TLlDOMPropertyManualLegendItem = class;
  TLlDOMPropertyManualLegendsList = class;
  TLlDOMPropertyShapeAxisArray = class;
  TLlDOMPropertyValueAxisArrayLine = class;
  TLlDOMPropertyShapeYAxis = class;
  TLlDOMPropertyShapeXAxis = class;
  TLlDOMForegroundShapesList = class;
  TLlDOMBackgroundShapesList = class;
  TLlDOMPropertyChartEngineShapeFile = class;
  TLlDOMPropertyChartEngineDonut2D = class;
  TLlDOMPropertyChartEnginePie3D = class;
  TLlDOMPropertyDrawing = class;
  TLlDOMSumVariableList = class;
  TLlDOMUserVariableList = class;
  TLlDOMObjectList = class;
  TLlDOMParagraphList = class;
  TLLDOMSubItemCore = class;
  TLlDOMSubItemSubReport = class;
  TLlDOMSubItemCoreList = class;
  TLlDOMTableLineBaseList = class;
  TLlDOMTableLineDataList = class;
  TLlDOMTableLineFooterList = class;
  TLlDOMTableLineHeaderList = class;
  TLlDOMTableLineGroupHeaderList = class;
  TLlDOMTableLineGroupFooterList = class;
  TLlDOMPropertyKeepTogether = class;
  TLlDOMTableLineFieldList = class;
  TLlDOMCrosstabCellSumLabelList = class;
  TLlDOMCrosstabCellGroupLabelList = class;
  TLlDOMCrosstabFormulaList = class;
  TLlDOMCrosstabCellsList = class;
  TLlDOMPropertyLayoutList = class;
  TLlDOMPropertyLayoutLabel = class;
  TLlDOMPropertyLayoutCard = class;
  TLlDOMPropertyProjectParameterList = class;
  TLlDOMPropertyChartDefinition = class;
  TLlDOMPropertyBitmap = class;
  TLlDOMPropertyValueAxisBase = class;
  TLlDOMPropertyCoordinateLabelPlacement = class;
  TLlDOMPropertyValueAxisFunnel = class;
  TLlDOMPropertyChartLabelCoordinateOnObject = class;
  TLlDOMReportParameter = class;
  TLlDOMReportParameterList = class;
  TLlDOMDrillDownLinkList = class;
  TLlDOMLayerList = class;
  TLlDOMChartRowList = class;
  TLlDOMRegionList = class;
  TLlDOMProjectTemplateList = class;
  TLlDOMPropertySettings = class;
  TLlDOMRulerGuideList = class;
  TLlDOMChartConditionalColorsList = class;
  TLlDOMPropertyChartTitle = class;
  TLlDOMPropertyOutputFormatterBase = class;
  TLlDOMPropertyOutputFormatterNone = class;
  TLlDOMPropertyChartFilling = class;
  TLlDOMPropertyChartColorArray = class;
  TLlDOMPropertyChartConditionalColor = class;
  TLlDOMPropertyChartLabelCoordinate = class;
  TLlDOMPropertyChartLabel = class;
  TLlDOMPropertyDevice = class;
  TLlDOMPropertyPaper = class;
  TLlDOMPropertyLayout = class;
  TLlDOMPropertySortOrders = class;
  TLlDOMPropertyStartValue = class;
  TLlDOMPropertySignalRanges = class;
  TLlDOMSignalItemList = class;
  TLlDOMPropertySignalItem = class;
  TLlDOMPropertyTextItemBackground = class;
  TLlDOMTextItemList = class;
  TLlDOMPropertyTextItem = class;
  TLlDOMPropertyLabels = class;
  TLlDOMPropertyDistance = class;
  TLlDOMPropertyDisplayRange = class;
  TLlDOMPropertyTickmarks = class;
  TLlDOMPropertyScaleLabels = class;
  TLlDOMPropertyScaleLimits = class;
  TLlDOMPropertyPointer = class;
  TLlDOMPropertyAlphaBlendableItem = class;
  TLlDOMPropertyGaugeDefinition = class;
  TLlDOMPropertyPDFDefinition = class;
  TLlDOMPropertyAnchor = class;
  TLlDOMReportParameterSource = class;
  TLlDOMPropertyDataGraphicDefinition = class;
  TLlDomPropertyGanttChartDefinition = class;
  TLlDomAccessMode = (amReadOnly, amReadWrite);
  TLlDOMFileMode = (fmOpen, fmCreate, fmCreateNew, fmOpenOrCreate);
  TLlDOMIgnoreErrors = (ieYes, ieNo);

  TLLDOMButtonActionType = (atSendTo, atSaveAs, atHttpPost, atActionLink, atPdfSig);
  TLlDOMChartType = (ctRScript, ctBar2D, ctBar2DClustered, ctBar2DStacked,
    ctBar2DStackedRelative, ctBar3D, ctBar3DClustered, ctBar3DStacked,
    ctBar3DStackedRelative, ctBar3DMultiRow, ctLineMultiRow, ctLineSimple,
    ctLineStacked, ctLineStackedRelative, ctPie2D, ctPie3D, ctAreaSimple,
    ctAreaStacked, ctAreaStackedRelative, ctBubbleSorted, ctBubbleScattered,
    ctFunnelVertical, ctFunnelHorizontal, ctDonut2D, ctDonut3D, ctShapeFile,
    ctRadarSimple, ctRadarClustered, ctRadarStacked, ctRadarStackedRelative, ctTreeMapSingle, ctTreeMapClustered);
  TLlDOMGaugeType = (gtRound, gtLinear, gtLinearHorizontal);
  TLlDOMSourceContentsType = (sctText, sctBoolean, sctNumeric, sctDate);
  TLlDOMControlType = (ctrlText, ctrlDate, ctrlBoolYesNo, ctrlBoolTrueFalse);
  TLlDOMSourceType = (stChoice, stDatabase, stText);
  TLlDOMReportParameterValueType = (vtDouble = 1, vtDate = 2, vtString = 4, vtBool = 8, vtDrawing = 10, vtBarcode = 20 );


  TLlDOMHorizontalLinkType = class(TObject)
  public
    class function None: integer;
    class function RelativeToStart: integer;
    class function RelativeToEnd: integer;
    class function AtEnd: integer;
    class function AtEndKeepSize: integer;
  end;

  TLlDOMVerticalLinkType = class(TObject)
  public
    class function None: integer;
    class function RelativeToStart: integer;
    class function RelativeToEnd: integer;
    class function AtEnd: integer;
    class function AtEndKeepSize: integer;
  end;

  TLlDOMHorizontalSizeAdaptionType = class(TObject)
  public
    class function None: integer;
    class function Propertional: integer;
    class function Inverse: integer;
  end;

  TLlDOMVerticalSizeAdaptionType = class(TLlDOMHorizontalSizeAdaptionType)
    class function None: integer;
    class function Propertional: integer;
    class function Inverse: integer;
  end;

  TLlDOMHelper = class(TObject)
  private
    class function SafeChartEngineCast(input: TLlDOMPropertyChartEngineBase)
      : TLlDOMPropertyChartEngineBase;
    class function SafeFormatterCast(input: TLlDOMPropertyOutputFormatterBase)
      : TLlDOMPropertyOutputFormatterBase;
    class function SafeValueAxisCast(input: TLlDOMPropertyValueAxisBase)
      : TLlDOMPropertyValueAxisBase;
    class function SafeInputButtonActionCast(input: TLlDOMPropertyInputButtonActionBase)
      : TLlDOMPropertyInputButtonActionBase;
    class function SafeBarcodeSourceCast(input: TLlDOMPropertyBarcodeSource)
      : TLlDOMPropertyBarcodeSource;
    class function SafeTableFielBarcodeSourceCast(source: TLlDOMPropertyTableFieldBarCodeSource; input: TLlDOMTableFieldBarcode)
      :TLlDOMPropertyTableFieldBarCodeSource;
  end;

  TLlDOMItem = class(TObject)
  private
    fDomHandle: HLLDOMOBJ;
  protected
    constructor Create; overload;
    constructor Create(hDom: HLLDOMOBJ); overload; virtual;
    constructor Create(oDom: TLlDOMItem); overload; virtual;
  public
    function GetHandle(objectName: TString): HLLDOMOBJ;
    function GetProperty(propName: TString): TString;
    procedure SetProperty(propName, value: TString);
    function GetSubObjectCount: integer;
    function GetSubObject(index: integer): TLlDOMItem;
    function GetObject(objectName: TString): TLlDOMItem;
    function CreateSubObject(index: integer; domItemSubObjectName: TString)
      : HLLDOMOBJ;
  end;

  TLlDOMProjectBase = class(TLlDOMItem)
  private
    fCollectionVariableList: TLlDOMListCollectionVariables;
    projectLoaded: boolean;
    projectType: Cardinal;
    fSumVariableList: TLlDOMSumVariableList;
    fUserVariableList: TLlDOMUserVariableList;
    fObjectList: TLlDOMObjectList;
    fSettings: TLlDOMPropertySettings;
    fProjectParameterList: TLlDOMPropertyProjectParameterList;
    fLayerList: TLlDOMLayerList;
    fRegionList: TLlDOMRegionList;
    fReportParameterList: TLlDOMReportParameterList;
    fProjectTemplateList: TLlDOMProjectTemplateList;
    fhParentComponent: ILlDomParent;
    function GetCollectionVariablesList: TLlDOMListCollectionVariables;
    function GetSumVariableList: TLlDOMSumVariableList;
    function GetUserVariableList: TLlDOMUserVariableList;
    function GetObjectList: TLlDOMObjectList;
    function GetProjectParameterList: TLlDOMPropertyProjectParameterList;
    function GetSettings: TLlDOMPropertySettings;
    function GetLayerList: TLlDOMLayerList;
    function GetRegionList: TLlDOMRegionList;
    function GetReportParameterList: TLlDOMReportParameterList;
    function GetProjectTemplateList: TLlDOMProjectTemplateList;
    function GetPageRanges: TString;
    procedure SetPageRanges(const value: TString);
    procedure SetDesignerRedraw(const value: TString);
    function GetChanged: TString;
  public
    property CollectionVariables: TLlDOMListCollectionVariables read GetCollectionVariablesList;
    property UserVariableList: TLlDOMUserVariableList read GetUserVariableList;
    property SumVariableList: TLlDOMSumVariableList read GetSumVariableList;
    property ObjectList: TLlDOMObjectList read GetObjectList;
    property ProjectParameterList: TLlDOMPropertyProjectParameterList
      read GetProjectParameterList;
    property Settings: TLlDOMPropertySettings read GetSettings;
    property Layers: TLlDOMLayerList read GetLayerList;
    property Regions: TLlDOMRegionList read GetRegionList;
    property ReportParameters: TLlDOMReportParameterList
      read GetReportParameterList;
    property ProjectTemplates: TLlDOMProjectTemplateList
      read GetProjectTemplateList;
    property PageRanges: TString read GetPageRanges write SetPageRanges;
    property DesignerRedraw: TString write SetDesignerRedraw;
    property Changed: TString read GetChanged;

    constructor Create(hTheParentComponent: ILlDomParent);
    procedure GetFromParent;
    procedure ResetInformation;
    destructor Destroy; override;
    procedure Save(projectFile: TString);
	procedure SaveCopyAs(projectFile: TString);
    function Open(projectFile: TString; fileMode: TLlDOMFileMode;
      readOnly: TLlDomAccessMode; LlDomSettings: longint): integer; overload;
    function Open(projectFile: TString; fileMode: TLlDOMFileMode;
      readOnly: TLlDomAccessMode; ignoreErrors: TLlDOMIgnoreErrors)
      : integer; overload;
    function Open(projectFile: TString; fileMode: TLlDOMFileMode;
      readOnly: TLlDomAccessMode): integer; overload;
    function Open(projectFile: TString; fileMode: TLlDOMFileMode)
      : integer; overload;
    procedure Close; virtual;
  end;

  TLlDOMProjectList = class(TLlDOMProjectBase)
  private
    fLayout: TLlDOMPropertyLayoutList;
    function GetLayout: TLlDOMPropertyLayoutList;
  public
    property Layout: TLlDOMPropertyLayoutList read GetLayout;
    procedure Close; override;

    constructor Create(hTheParentComponent: ILlDomParent); overload;
  end;

  TLlDOMProjectLabel = class(TLlDOMProjectBase)
  private
    fLayout: TLlDOMPropertyLayoutLabel;
    function GetLayout: TLlDOMPropertyLayoutLabel;
  public
    property Layout: TLlDOMPropertyLayoutLabel read GetLayout;
    procedure Close; override;

    constructor Create(hTheParentComponent: ILlDomParent); overload;
  end;

  TLlDOMProjectCard = class(TLlDOMProjectBase)
  private
    fLayout: TLlDOMPropertyLayoutCard;
    function GetLayout: TLlDOMPropertyLayoutCard;
  public
    property Layout: TLlDOMPropertyLayoutCard read GetLayout;
    procedure Close; override;
    constructor Create(hTheParentComponent: ILlDomParent); overload;
  end;

  TLlDOMList = class(TList)
  private
    fDOMObj: TLlDOMItem;
    procedure Initialize; virtual;
  public
    procedure DeleteSubobject(index: integer); virtual;
  end;

  TLlDOMProjectTemplate = class(TLlDOMItem)
  private
	function GetUUID: TString;
    function GetDescription: TString;
    procedure SetDescription(const value: TString);
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetFileName: TString;
    procedure SetFileName(const value: TString);
  public
	property UUID: TString read GetUUID;
    property Condition: TString read GetCondition write SetCondition;
    property Description: TString read GetDescription write SetDescription;
    property FileName: TString read GetFileName write SetFileName;
    property Visible: TString read GetVisible write SetVisible;

    constructor Create(list: TLlDOMProjectTemplateList); overload;
  end;

  TLlDOMProjectTemplateList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMProjectTemplate;
    procedure SetItems(index: integer; const value: TLlDOMProjectTemplate);
    function Add(domObj: TLlDOMProjectTemplate): integer;
  public
    property Items[index: integer]: TLlDOMProjectTemplate read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMLayer = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetFromTemplate: TString;
    procedure SetFromTemplate(const value: TString);
    function GetLayerID: TString;
    procedure SetLayerID(const value: TString);
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property Condition: TString read GetCondition write SetCondition;
    property FromTemplate: TString read GetFromTemplate write SetFromTemplate;
    property LayerID: TString read GetLayerID write SetLayerID;
    property Name: TString read GetName write SetName;
    property Visible: TString read GetVisible write SetVisible;

    constructor Create(list: TLlDOMLayerList); overload;
  end;

  TLlDOMLayerList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMLayer;
    procedure SetItems(index: integer; const value: TLlDOMLayer);
    function Add(domObj: TLlDOMLayer): integer;
  public
    property Items[index: integer]: TLlDOMLayer read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMDrillDownLinkBase = class(TLlDOMItem)
  private
    function GetMenuText: TString;
    procedure SetMenuText(const value: TString);
    procedure SetDrillDownType(const value: TString);
	  function GetDrillDownType: TString;
    function GetProjectFileName: TString;
    procedure SetProjectFileName(const value: TString);
  protected
  	property DrillDownType: TString read GetDrillDownType write SetDrillDownType;
  public
    property MenuText: TString read GetMenuText write SetMenuText;
    property ProjectFileName: TString read GetProjectFileName
      write SetProjectFileName;
    constructor Create(list: TLlDOMDrillDownLinkList; drillDownType: TString; index: integer); overload;
    constructor Create(newItem: TLlDOMItem);  overload; override;
  end;

  TLlDOMDrillDownLink = class (TLlDOMDrillDownLinkBase)
  private
    function GetParentKeyField: TString;
    procedure SetParentKeyField(const value: TString);
    function GetParentTableID: TString;
    procedure SetParentTableID(const value: TString);
    function GetRelationID: TString;
    procedure SetRelationID(const value: TString);
    function GetChildKeyField: TString;
    procedure SetChildKeyField(const value: TString);
    function GetChildTableID: TString;
    procedure SetChildTableID(const value: TString);
  public
    property ParentKeyField: TString read GetParentKeyField
      write SetParentKeyField;
    property ParentTableID: TString read GetParentTableID
      write SetParentTableID;
    property RelationID: TString read GetRelationID write SetRelationID;
    property ChildKeyField: TString read GetChildKeyField
      write SetChildKeyField;
    property ChildTableID: TString read GetChildTableID write SetChildTableID;
    constructor Create(newItem: TLlDOMItem); overload;  override;
  end;

  TLlDOMDrillDownLinkForParameterizedSubreport = class (TLlDOMDrillDownLinkBase)
  private
    fReportParameterList: TLlDOMDrillDownReportParameterList;
    function GetShowReportParameterPreviewPane: TString;
    procedure SetShowReportParameterPreviewPane(const value: TString);
	  function GetSubReportDescription: TString;
	  procedure SetSubReportDescription(const value: TString);
    function GetReportParameterList: TLlDOMDrillDownReportParameterList;
  public
    property ShowReportParameterPreviewPane: TString read GetShowReportParameterPreviewPane
		write SetShowReportParameterPreviewPane;
	property SubReportDescription: TString read GetSubReportDescription write SetSubReportDescription;
  property ReportParameterList: TLlDOMDrillDownReportParameterList
	read GetReportParameterList;
	constructor Create(newItem: TLlDOMItem); overload; override;
  end;

  TLlDOMDrillDownReportParameterListItem = class(TLlDOMItem)
  private
    function GetName: TString;
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetContentType: TLlDOMReportParameterValueType;
    procedure SetContentType(const value: TLlDOMReportParameterValueType);
    function GetAllowMultipleValues: TString;
    procedure SetAllowMultipleValues(const value: TString);
  public
    property Name: TString read GetName;
    property ContentType: TLlDOMReportParameterValueType read GetContentType;
    property AllowMultipleValues: TString read GetAllowMultipleValues
              write SetAllowMultipleValues;
    property Value: TString read GetValue;
    constructor Create(list: TLlDOMDrillDownReportParameterList; name: TString; value: TString; valueType: TLlDOMReportParameterValueType); overload;
  end;

  TLlDOMDrillDownReportParameterList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMDrillDownReportParameterListItem;
    procedure SetItems(index: integer;
      const value: TLlDOMDrillDownReportParameterListItem);
    function Add(domObj: TLlDOMDrillDownReportParameterListItem):integer;
  public
    property Items[index: integer]: TLlDOMDrillDownReportParameterListItem
      read GetItems write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    function NewItem(index: integer;name: TString; value: TString; valueType: TLlDOMReportParameterValueType):
          TLlDOMDrillDownReportParameterListItem;

  end;

  TLlDOMDrillDownLinkList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMDrillDownLinkBase;
    procedure SetItems(index: integer; const value: TLlDOMDrillDownLinkBase);
    function Add(domObj: TLlDOMItem): integer;
  protected
    procedure Initialize; override;
  public
    property Items[index: integer]: TLlDOMDrillDownLinkBase read GetItems
      write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function AddNewDrillDownLink(index: integer) :TLlDOMDrillDownLink;
    function AddNewDrillDownLinkForParameterizedSubreport(index: integer)
        :TLlDOMDrillDownLinkForParameterizedSubreport;
  end;

  TLlDOMRegion = class(TLlDOMItem)
  private
    fDevice: TLlDOMPropertyDevice;
    fPaper: TLlDOMPropertyPaper;
    fLayout: TLlDOMPropertyLayout;

    function GetCollate: TString;
    procedure SetCollate(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetCopies: TString;
    procedure SetCopies(const value: TString);
	function GetIsStandardRegion: TString;
	function GetUseForOutput: TString;
    function GetDevice: TLlDOMPropertyDevice;
    function GetPaper: TLlDOMPropertyPaper;
    function GetLayout: TLlDOMPropertyLayout;
    function GetDuplex: TString;
    function GetFitPage: TString;
    function GetForcePaperFormat: TString;
    function GetName: TString;
    function GetSourceTray: TString;
    function GetUsePhysicalPaper: TString;
    function GetShowInPrintDialog: TString;
    procedure SetDuplex(const value: TString);
    procedure SetFitPage(const value: TString);
    procedure SetForcePaperFormat(const value: TString);
    procedure SetName(const value: TString);
    procedure SetSourceTray(const value: TString);
    procedure SetUsePhysicalPaper(const value: TString);
    procedure SetShowInPrintDialog(const value: TString);

  public
	property IsStandardRegion: TString read GetIsStandardRegion;
	property UseForOutput: TString read GetUseForOutput;
    property Collate: TString read GetCollate write SetCollate;
    property Condition: TString read GetCondition write SetCondition;
    property Copies: TString read GetCopies write SetCopies;
    property Device: TLlDOMPropertyDevice read GetDevice;
    property Paper: TLlDOMPropertyPaper read GetPaper;
    property Layout: TLlDOMPropertyLayout read GetLayout;

    property Duplex: TString read GetDuplex write SetDuplex;
    property FitPage: TString read GetFitPage write SetFitPage;
    property ForcePaperFormat: TString read GetForcePaperFormat
      write SetForcePaperFormat;
    property Name: TString read GetName write SetName;
    property SourceTray: TString read GetSourceTray write SetSourceTray;
    property UsePhysicalPaper: TString read GetUsePhysicalPaper
      write SetUsePhysicalPaper;
    property ShowInPrintDialog: TString read GetShowInPrintDialog
      write SetShowInPrintDialog;
    procedure SetDevMode({$IFDEF UNICODE} DevMode: PDeviceModeW
{$ELSE} DevMode: PDeviceModeA {$ENDIF}); overload;
    procedure SetDevMode({$IFDEF UNICODE} DevMode: PDeviceModeW
{$ELSE} DevMode: PDeviceModeA {$ENDIF}; DeviceName: string); overload;
    constructor Create(list: TLlDOMRegionList); overload;
    destructor Destroy; override;
  end;

  TLlDOMRegionList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMRegion;
    procedure SetItems(index: integer; const value: TLlDOMRegion);
    function Add(domObj: TLlDOMRegion): integer;
  public
    property Items[index: integer]: TLlDOMRegion read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMReportParameterList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMReportParameter;
    procedure SetItems(index: integer; const value: TLlDOMReportParameter);
    function Add(domObj: TLlDOMReportParameter): integer;
  public
    property Items[index: integer]: TLlDOMReportParameter read GetItems
      write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMPropertyProjectParameterBase = class(TLlDOMItem)
  private
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetParameterType: TString;
    procedure SetParameterType(const value: TString);
  public
    property Name: TString read GetName write SetName;
    property Contents: TString read GetContents write SetContents;
    property ParameterType: TString read GetParameterType
      write SetParameterType;

    constructor Create(list: TLlDOMPropertyProjectParameterList); overload;
  end;

  TLlDOMPropertyProjectParameterList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertyProjectParameterBase;
    procedure SetItems(index: integer;
      value: TLlDOMPropertyProjectParameterBase);
    function Add(domObj: TLlDOMPropertyProjectParameterBase): integer;
    function GetItemName(Name: TString): TLlDOMPropertyProjectParameterBase;
    procedure SetItemName(Name: TString;
      const value: TLlDOMPropertyProjectParameterBase);
  public
    property Items[Index: integer]: TLlDOMPropertyProjectParameterBase
      read GetItems write SetItems;
    property ItemName[Name: TString]: TLlDOMPropertyProjectParameterBase
      read GetItemName write SetItemName;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

    TLlDOMPropertyLineSmoothing = class(TLlDOMItem)
    private
      function GetSmoothingType: TString;
      procedure SetSmoothingType(const value: TString);
      function GetMaximumSupportPoints: TString;
      procedure SetMaximumSupportPoints(const value: TString);
    public
      property SmoothingType:TString read GetSmoothingType write SetSmoothingType;
      property MaximumSupportPoints:TString read GetMaximumSupportPoints write SetMaximumSupportPoints;

  end;


    TLlDOMPropertyVisual = class(TLlDOMItem)
    private
      fLineSmoothing: TLlDOMPropertyLineSmoothing;
      function GetLineSmoothing: TLlDOMPropertyLineSmoothing;
      function GetContents: TString;
      procedure SetContents(const value: TString);
      function GetLineTypeOverride: TString;
      procedure SetLineTypeOverride(const value: TString);

    public
      property Contents:TString read GetContents write SetContents;
      property LineTypeOverride: TString read GetLineTypeOverride write SetLineTypeOverride;
      property LineSmoothing: TLlDOMPropertyLineSmoothing read GetLineSmoothing;
      destructor Destroy; override;
  end;


  TLlDOMChartRow = class(TLlDOMItem)
  private
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject;
    fVisual: TLlDOMPropertyVisual;
    function GetVisual: TLlDOMPropertyVisual;
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetCoordinateLabel: TString;
    procedure SetCoordinateLabel(const value: TString);
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObject;
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetValueAxisAssignment: TString;
    procedure SetValueAxisAssignment(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetVisualSymbol: TString;
    procedure SetVisualSymbol(const value: TString);
  public
    property VisualSymbol: TString read GetVisualSymbol write SetVisualSymbol;
    property Color: TString read GetColor write SetColor;
    property CoordinateLabel: TString read GetCoordinateLabel
      write SetCoordinateLabel;
    property CoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject
      read GetCoordinateLabelOnObject;
    property Name: TString read GetName write SetName;
    property value: TString read GetValue write SetValue;
    property ValueAxisAssignment: TString read GetValueAxisAssignment
      write SetValueAxisAssignment;
    property Visual: TLlDOMPropertyVisual read GetVisual;
    property Width: TString read GetWidth write SetWidth;
    destructor Destroy; override;
    constructor Create(list: TLlDOMChartRowList); overload;
  end;

  TLlDOMChartRowList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMChartRow;
    procedure SetItems(index: integer; const value: TLlDOMChartRow);
    function Add(domObj: TLlDOMChartRow): integer;
  public
    property Items[index: integer]: TLlDOMChartRow read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMSumVariable = class(TLlDOMItem)
  private
    var ParentList : TLlDOMSumVariableList;
    procedure SetContent(const value: TString);
    function GetContent: TString;
    function GetIsPageSum: TString;
    procedure SetIsPageSum(const value: TString);
    procedure SetName(const value: TString);
    function GetName: TString;
  public
    property Name: TString read GetName write SetName;
    property Content: TString read GetContent write SetContent;
    property IsPageSum: TString read GetIsPageSum write SetIsPageSum;

    constructor Create(list: TLlDOMSumVariableList); overload;
  end;

  TLlDOMSumVariableList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMSumVariable;
    procedure SetItems(index: integer; value: TLlDOMSumVariable);
    function Add(domObj: TLlDOMSumVariable): integer;
  public
    property Items[Index: integer]
      : TLlDOMSumVariable read GetItems write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
    procedure DeleteSubobject(index: integer); override;
  end;

  TLlDOMUserVariable = class(TLlDOMItem)
  private
    var ParentList : TLlDOMUserVariableList;
    procedure SetContent(const value: TString);
    function GetContent: TString;
    procedure SetName(const value: TString);
    function GetName: TString;
  public
    property Name: TString read GetName write SetName;
    property Content: TString read GetContent write SetContent;

    constructor Create(list: TLlDOMUserVariableList); overload;
  end;

  TLlDOMUserVariableList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMUserVariable;
    procedure SetItems(index: integer; const value: TLlDOMUserVariable);
    function Add(domObj: TLlDOMUserVariable): integer;
  public
    property Items[Index: integer]: TLlDOMUserVariable read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
    procedure DeleteSubobject(index: integer); override;
  end;

  TLlDOMPropertyExtent = class(TLlDOMItem)
  private
    function GetHorizontal: TString;
    procedure SetHorizontal(const value: TString);
    function GetVertical: TString;
    procedure SetVertical(const value: TString);
  public
    property Horizontal: TString read GetHorizontal write SetHorizontal;
    property Vertical: TString read GetVertical write SetVertical;
  end;

  TLlDOMPropertyOffset = class(TLlDOMItem)
  private
    function GetHorizontal: TString;
    procedure SetHorizontal(const value: TString);
    function GetVertical: TString;
    procedure SetVertical(const value: TString);
  public
    property Horizontal: TString read GetHorizontal write SetHorizontal;
    property Vertical: TString read GetVertical write SetVertical;
  end;

  TllDomPropertyPrintableArea = class(TLlDOMItem)
  private
    fExtent: TLlDOMPropertyExtent;
    fOffset: TLlDOMPropertyOffset;
    function GetExtent: TLlDOMPropertyExtent;
    function GetOffset: TLlDOMPropertyOffset;
  public
    property Extent: TLlDOMPropertyExtent read GetExtent;
    property Offset: TLlDOMPropertyOffset read GetOffset;
    destructor Destroy; override;
  end;

  TLlDOMPropertySpacing = class(TLlDOMItem)
  private
    function GetHorizontal: TString;
    procedure SetHorizontal(const value: TString);
    function GetVertical: TString;
    procedure SetVertical(const value: TString);
  public
    property Horizontal: TString read GetHorizontal write SetHorizontal;
    property Vertical: TString read GetVertical write SetVertical;
  end;

  TLlDOMPropertyLayoutPagesBase = class(TLlDOMItem)
  private
    function GetForcePaperFormat: TString;
    procedure SetForcePaperFormat(const value: TString);
    function GetUsePhysicalPage: TString;
    procedure SetUsePhysicalPage(const value: TString);
  public
    property ForcePaperFormat: TString read GetForcePaperFormat
      write SetForcePaperFormat;
    property UsePhysicalPage: TString read GetUsePhysicalPage
      write SetUsePhysicalPage;
  end;

  TllDomPropertySize = class(TLlDOMItem)
  private
    function GetHorizontal: TString;
    procedure SetHorizontal(const value: TString);
    function GetVertical: TString;
    procedure SetVertical(const value: TString);
  public
    property Horizontal: TString read GetHorizontal write SetHorizontal;
    property Vertical: TString read GetVertical write SetVertical;
  end;

  TLlDOMPropertyLayoutPagesCard = class(TLlDOMPropertyLayoutPagesBase)
  private
    fColumns: TllDomPropertySize;
    fDistance: TllDomPropertySize;
    fExtent: TllDomPropertySize;
    fOffset: TllDomPropertySize;
    function GetColumns: TllDomPropertySize;
    function GetDistance: TllDomPropertySize;
    function GetExtent: TllDomPropertySize;
    function GetOffset: TllDomPropertySize;
    function GetPrintOrder: TString;
    procedure SetPrintOrder(const value: TString);
  public
    property Columns: TllDomPropertySize read GetColumns;
    property Distance: TllDomPropertySize read GetDistance;
    property Extent: TllDomPropertySize read GetExtent;
    property Offset: TllDomPropertySize read GetOffset;
    property PrintOrder: TString read GetPrintOrder write SetPrintOrder;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutPagesLabel = class(TLlDOMPropertyLayoutPagesBase)
  private
    fColumns: TllDomPropertySize;
    fDistance: TllDomPropertySize;
    fExtent: TllDomPropertySize;
    fOffset: TllDomPropertySize;
    function GetPrintOrder: TString;
    procedure SetPrintOrder(const value: TString);
    function GetColumns: TllDomPropertySize;
    function GetDistance: TllDomPropertySize;
    function GetExtent: TllDomPropertySize;
    function GetOffset: TllDomPropertySize;
  public
    property Columns: TllDomPropertySize read GetColumns;
    property Distance: TllDomPropertySize read GetDistance;
    property Extent: TllDomPropertySize read GetExtent;
    property Offset: TllDomPropertySize read GetOffset;
    property PrintOrder: TString read GetPrintOrder write SetPrintOrder;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutCardPages = class(TLlDOMItem)
  private
    fFirst: TLlDOMPropertyLayoutPagesCard;
    fFollowing: TLlDOMPropertyLayoutPagesCard;
    function GetFirst: TLlDOMPropertyLayoutPagesCard;
    function GetFollowing: TLlDOMPropertyLayoutPagesCard;
  public
    property First: TLlDOMPropertyLayoutPagesCard read GetFirst;
    property Following: TLlDOMPropertyLayoutPagesCard read GetFollowing;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutLabelPages = class(TLlDOMItem)
  private
    fFirst: TLlDOMPropertyLayoutPagesLabel;
    fFollowing: TLlDOMPropertyLayoutPagesLabel;
    function GetFirst: TLlDOMPropertyLayoutPagesLabel;
    function GetFollowing: TLlDOMPropertyLayoutPagesLabel;
  public
    property First: TLlDOMPropertyLayoutPagesLabel read GetFirst;
    property Following: TLlDOMPropertyLayoutPagesLabel read GetFollowing;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutListPages = class(TLlDOMItem)
  private
    fFirst: TLlDOMPropertyLayoutPagesBase;
    fFollowing: TLlDOMPropertyLayoutPagesBase;
    function GetFirst: TLlDOMPropertyLayoutPagesBase;
    function GetFollowing: TLlDOMPropertyLayoutPagesBase;
  public
    property First: TLlDOMPropertyLayoutPagesBase read GetFirst;
    property Following: TLlDOMPropertyLayoutPagesBase read GetFollowing;
    destructor Destroy; override;
  end;

  TLlDOMPropertyGrid = class(TLlDOMItem)
  private
    fSpacing: TLlDOMPropertySpacing;
    function GetShow: TString;
    procedure SetShow(const value: TString);
    function GetSnap: TString;
    procedure SetSnap(const value: TString);
    function GetSpacing: TLlDOMPropertySpacing;
  public
    property Spacing: TLlDOMPropertySpacing read GetSpacing;
    property Show: TString read GetShow write SetShow;
    property Snap: TString read GetSnap write SetSnap;
    destructor Destroy; override;
  end;

  TLlDOMPropertyDevice = class(TLlDOMItem)
  private
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetDEVMODE: TString;
    procedure SetDevMode(const value: TString);
    function GetExtraData: TString;
    procedure SetExtraData(const value: TString);
  public
    property Name: TString read GetName write SetName;
    property DevMode: TString read GetDEVMODE write SetDevMode;
    property ExtraData: TString read GetExtraData write SetExtraData;
  end;

  TLlDOMPropertyPaper = class(TLlDOMItem)
  private
    fExtent: TllDomPropertySize;
    fPrintableArea: TllDomPropertyPrintableArea;

    function GetFormat: TString;
    procedure SetFormat(const value: TString);
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetExtent: TllDomPropertySize;
    function GetPrintableArea: TllDomPropertyPrintableArea;
  public
    property Format: TString read GetFormat write SetFormat;
    property Orientation: TString read GetOrientation write SetOrientation;
    property Extent: TllDomPropertySize read GetExtent;

    property PrintableArea: TllDomPropertyPrintableArea read GetPrintableArea;

    destructor Destroy; override;
  end;

  TLlDOMPropertyLayout = class(TLlDOMItem)
  private
    function GetPrintOrder: TString;
    procedure SetPrintOrder(const value: TString);
    function GetXCount: TString;
    procedure SetXCount(const value: TString);
    function GetXDistance: TString;
    procedure SetXDistance(const value: TString);
    function GetXOffset: TString;
    procedure SetXOffset(const value: TString);
    function GetXSize: TString;
    procedure SetXSize(const value: TString);
    function GetYCount: TString;
    procedure SetYCount(const value: TString);
    function GetYDistance: TString;
    procedure SetYDistance(const value: TString);
    function GetYOffset: TString;
    procedure SetYOffset(const value: TString);
    function GetYSize: TString;
    procedure SetYSize(const value: TString);
  public
    property PrintOrder: TString read GetPrintOrder write SetPrintOrder;
    property XCount: TString read GetXCount write SetXCount;
    property XDistance: TString read GetXDistance write SetXDistance;
    property XOffset: TString read GetXOffset write SetXOffset;
    property XSize: TString read GetXSize write SetXSize;
    property YCount: TString read GetYCount write SetYCount;
    property YDistance: TString read GetYDistance write SetYDistance;
    property YOffset: TString read GetYOffset write SetYOffset;
    property YSize: TString read GetYSize write SetYSize;
  end;

  TLlDOMRulerGuide = class(TLlDOMItem)
  private
    function GetCatchRangePixels: TString;
    procedure SetCatchRangePixels(const value: TString);
    function GetLocked: TString;
    procedure SetLocked(const value: TString);
    function GetPosition: TString;
    procedure SetPosition(const value: TString);
  public
    property CatchRangePixels: TString read GetCatchRangePixels
      write SetCatchRangePixels;
    property Locked: TString read GetLocked write SetLocked;
    property Position: TString read GetPosition write SetPosition;
    constructor Create(list: TLlDOMRulerGuideList); overload;
  end;

  TLlDOMRulerGuideList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMRulerGuide;
    procedure SetItems(index: integer; const value: TLlDOMRulerGuide);
    function Add(domObj: TLlDOMRulerGuide): integer;
  public
    property Items[Index: integer]: TLlDOMRulerGuide read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMPropertyRulerGuides = class(TLlDOMItem)
  private
    fHorizontal: TLlDOMRulerGuideList;
    fVertical: TLlDOMRulerGuideList;
    function GetVerticalList: TLlDOMRulerGuideList;
    function GetHorizontalList: TLlDOMRulerGuideList;
  public
    property Horizontal: TLlDOMRulerGuideList read GetHorizontalList;
    property Vertical: TLlDOMRulerGuideList read GetVerticalList;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutBase = class(TLlDOMItem)
  private
    fGrid: TLlDOMPropertyGrid;
    fRulerGuides: TLlDOMPropertyRulerGuides;
    function GetGrid: TLlDOMPropertyGrid;
    function GetRulerGuides: TLlDOMPropertyRulerGuides;
  public
    property Grid: TLlDOMPropertyGrid read GetGrid;
    property RulerGuides: TLlDOMPropertyRulerGuides read GetRulerGuides;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutList = class(TLlDOMPropertyLayoutBase)
  private
    fPages: TLlDOMPropertyLayoutListPages;
    function GetPages: TLlDOMPropertyLayoutListPages;
  public
    property Pages: TLlDOMPropertyLayoutListPages read GetPages;
    destructor Destroy; override;
  end;

  TLlDOMPropertyReportSection = class(TLlDOMItem)
  private
    function GetFileName: TString;
    function GetCondition: TString;
    procedure SetFileName(const value: TString);
	procedure SetCondition(const value: TString);
  public
    property FileName: TString read GetFileName write SetFileName;
    property Condition: TString read GetCondition write SetCondition;
  end;

  TLlDOMPropertyReportSectionReverseSide = class(TLlDOMPropertyReportSection)
  private
    function GetDuplexReverseSideMode: TString;
    procedure SetDuplexReverseSideMode(const value: TString);
    function GetIssueCondition: TString;
    procedure SetIssueCondition(const value: TString);
    function GetSimplexReverseSideMode: TString;
    procedure SetSimplexReverseSideMode(const value: TString);
  public
    property DuplexReverseSideMode: TString read GetDuplexReverseSideMode
      write SetDuplexReverseSideMode;
    property IssueCondition: TString read GetIssueCondition
      write SetIssueCondition;
    property SimplexReverseSideMode: TString read GetSimplexReverseSideMode
      write SetSimplexReverseSideMode;
  end;

  TLlDOMPropertyReportSections = class(TLlDOMItem)
  private
    FIndex: TLlDOMPropertyReportSection;
    FTableOfContents: TLlDOMPropertyReportSection;
    FReverseSide: TLlDOMPropertyReportSectionReverseSide;
    function GetIndex: TLlDOMPropertyReportSection;
    function GetTableOfContents: TLlDOMPropertyReportSection;
    function GetReverseSide: TLlDOMPropertyReportSectionReverseSide;
  public
    property Index: TLlDOMPropertyReportSection read GetIndex;
    property TableOfContents: TLlDOMPropertyReportSection
      read GetTableOfContents;
    property ReverseSide: TLlDOMPropertyReportSectionReverseSide
      read GetReverseSide;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutLabel = class(TLlDOMPropertyLayoutBase)
  private
    fPages: TLlDOMPropertyLayoutLabelPages;
    function GetPages: TLlDOMPropertyLayoutLabelPages;
  public
    property Pages: TLlDOMPropertyLayoutLabelPages read GetPages;
    destructor Destroy; override;
  end;

  TLlDOMPropertyLayoutCard = class(TLlDOMPropertyLayoutBase)
  private
    fPages: TLlDOMPropertyLayoutCardPages;
    function GetPages: TLlDOMPropertyLayoutCardPages;
  public
    property Pages: TLlDOMPropertyLayoutCardPages read GetPages;
    destructor Destroy; override;
  end;

  TLlDOMPropertyConditionalFormatterModifiers = class(TLlDOMItem)
  private
    fFrame: TLlDOMPropertyFrameExt;
    fFont: TLlDOMPropertyDefaultFontExt;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetFont: TLlDOMPropertyDefaultFontExt;
    function GetFrame: TLlDOMPropertyFrameExt;
    function GetColor : TString;
    procedure SetColor(const value: TString);

  public
     property Color: TString read GetColor write SetColor;
     property Font: TLlDOMPropertyDefaultFontExt read GetFont;
     property Frame: TLlDOMPropertyFrameExt read GetFrame;
     property OutputFormatter: TLlDOMPropertyOutputFormatterBase
              read GetOutputFormatter;
    destructor Destroy; override;
  end;

  TLlDOMConditionalFormatterItemList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertyConditionalFormatterItem;
    procedure SetItems(index: integer; const value: TLlDOMPropertyConditionalFormatterItem);
    function Add(domObj: TLlDOMPropertyConditionalFormatterItem): integer;
  public
    property Items[Index: integer]: TLlDOMPropertyConditionalFormatterItem read GetItems
      write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMPropertyConditionalFormatterItem = class(TLlDOMItem)
    private
      fModifiers: TLlDOMPropertyConditionalFormatterModifiers;
      function GetModifiers: TLlDOMPropertyConditionalFormatterModifiers;
      function GetStopIteration: TString;
      procedure SetStopIteration(const value: TString);
      function GetCondition: TString;
      procedure SetCondition(const value: TString);

    public
      property Modifiers: TLlDOMPropertyConditionalFormatterModifiers
                read GetModifiers;
      property StopIteration: TString read GetStopIteration write SetStopIteration;
      property Condition: TString read GetCondition write SetCondition;
      constructor Create(list: TLlDOMConditionalFormatterItemList); overload;
      destructor Destroy; override;

  end;

  TLlDOMPropertyDefaultFont = class(TLlDOMItem)
  private
    function GetBold: TString;
    procedure SetBold(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetFaceName: TString;
    procedure SetFaceName(const value: TString);
    function GetGdiCharSet: TString;
    procedure SetGdiCharSet(const value: TString);
    function GetItalic: TString;
    procedure SetItalic(const value: TString);
    function GetSize: TString;
    procedure SetSize(const value: TString);
    function GetStrikeout: TString;
    procedure SetStrikeout(const value: TString);
    function GetUnderline: TString;
    procedure SetUnderline(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Bold: TString read GetBold write SetBold;
    property Color: TString read GetColor write SetColor;
    property FaceName: TString read GetFaceName write SetFaceName;
    property GdiCharSet: TString read GetGdiCharSet write SetGdiCharSet;
    property Italic: TString read GetItalic write SetItalic;
    property Size: TString read GetSize write SetSize;
    property Strikeout: TString read GetStrikeout write SetStrikeout;
    property Underline: TString read GetUnderline write SetUnderline;
    property Width: TString read GetWidth write SetWidth;

    procedure SetFont(nFont: TFont);
  end;

  TLlDOMPropertyDefaultFontExt = class(TLlDOMPropertyDefaultFont)
  private
    function GetDefault : TString;
    procedure SetDefault(const value: TString);
  public
    property DefaultF : TString read GetDefault write SetDefault;
  end;

  TLlDOMPropertyTextQuoteCodes = class(TLlDOMItem)
  private
    function GetEndCode: TString;
    procedure SetEndCode(const value: TString);
    function GetStartCode: TString;
    procedure SetStartCode(const value: TString);
  public
    property EndCode: TString read GetEndCode write SetEndCode;
    property StartCode: TString read GetStartCode write SetStartCode;
  end;

  TLlDOMPropertyRange = class(TLlDOMItem)
  private
    function GetAutomatic: TString;
    procedure SetAutomatic(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property value: TString read GetValue write SetValue;
  end;

  TLlDOMPropertyRepresentationCodes = class(TLlDOMItem)
  private
    function GetCondEnd: TString;
    procedure SetCondEnd(const value: TString);
    function GetCondSep: TString;
    procedure SetCondSep(const value: TString);
    function GetCondStart: TString;
    procedure SetCondStart(const value: TString);
    function GetExprSep: TString;
    procedure SetExprSep(const value: TString);
    function GetLockNextChar: TString;
    procedure SetLockNextChar(const value: TString);
    function GetPhantomSpace: TString;
    procedure SetPhantomSpace(const value: TString);
    function GetRet: TString;
    procedure SetRet(const value: TString);
    function GetTab: TString;
    procedure SetTab(const value: TString);
  public
    property CondEnd: TString read GetCondEnd write SetCondEnd;
    property CondSep: TString read GetCondSep write SetCondSep;
    property CondStart: TString read GetCondStart write SetCondStart;
    property ExprSep: TString read GetExprSep write SetExprSep;
    property LockNextChar: TString read GetLockNextChar write SetLockNextChar;
    property PhantomSpace: TString read GetPhantomSpace write SetPhantomSpace;
    property Ret: TString read GetRet write SetRet;
    property Tab: TString read GetTab write SetTab;
  end;

  TLlDOMPropertySettings = class(TLlDOMItem)
  private
    fDefaultFont: TLlDOMPropertyDefaultFont;
    fDefaultDefaultFont: TLlDOMPropertyDefaultFont;
    fRepresentationCodes: TLlDOMPropertyRepresentationCodes;
    fTextQuoteCodes: TLlDOMPropertyTextQuoteCodes;
    function GetCreated: TString;
    procedure SetCreated(const value: TString);
    function GetDecimals: TString;
    procedure SetDecimals(const value: TString);
    function GetDefaultDestination: TString;
    procedure SetDefaultDestination(const value: TString);
    function GetFileVersion: TString;
    procedure SetFileVersion(const value: TString);
    function GetLCID: TString;
    function GetMaxPDFOutlineDepth: TString;
    procedure SetMaxPDFOutlineDepth(const value: TString);
    function GetMetrics: TString;
    procedure SetMetrics(const value: TString);
    function GetDefaultFont: TLlDOMPropertyDefaultFont;
    function GetDefaultDefaultFont: TLlDOMPropertyDefaultFont;
    function GetRepresentationCodes: TLlDOMPropertyRepresentationCodes;
    function GetTextQuoteCodes: TLlDOMPropertyTextQuoteCodes;
    procedure SetMaxPDFIndexDepth(const value: TString);
    function GetMaxPDFIndexDepth: TString;
  public
    property DefaultFont: TLlDOMPropertyDefaultFont read GetDefaultFont;
    property DefaultDefaultFont: TLlDOMPropertyDefaultFont
      read GetDefaultDefaultFont;
    property RepresentationCodes: TLlDOMPropertyRepresentationCodes
      read GetRepresentationCodes;
    property TextQuoteCodes: TLlDOMPropertyTextQuoteCodes
      read GetTextQuoteCodes;
    property Created: TString read GetCreated write SetCreated;
    property Decimals: TString read GetDecimals write SetDecimals;
    property DefaultDestination: TString read GetDefaultDestination
      write SetDefaultDestination;
    property FileVersion: TString read GetFileVersion write SetFileVersion;
    property LCID: TString read GetLCID;
    property MaxPDFOutlineDepth: TString read GetMaxPDFOutlineDepth
      write SetMaxPDFOutlineDepth;
    property MaxPDFIndexDepth: TString read GetMaxPDFIndexDepth
      write SetMaxPDFIndexDepth;

    property Metrics: TString read GetMetrics write SetMetrics;
    destructor Destroy; override;
  end;

  TLlDOMPropertyFixedSize = class(TLlDOMItem)
  private
    function GetFillGap: TString;
    procedure SetFillGap(const value: TString);
    function GetEnabled: TString;
    procedure SetEnabled(const value: TString);
  public
    property Enabled: TString read GetEnabled write SetEnabled;
    property FillGap: TString read GetFillGap write SetFillGap;
  end;

  TLlDOMPropertyLine = class(TLlDOMItem)
  private
    function GetLineType: TString;
    procedure SetLineType(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
  public
    property LineType: TString read GetLineType write SetLineType;
    property Width: TString read GetWidth write SetWidth;
    property Color: TString read GetColor write SetColor;
    property Visible: TString read GetVisible write SetVisible;
  end;

  TLlDOMPropertyFrameItem = class(TLlDOMItem)
  private
    fLine: TLlDOMPropertyLine;
    function GetSpace: TString;
    procedure SetSpace(const value: TString);
    function GetLine: TLlDOMPropertyLine;
  public
    property Line: TLlDOMPropertyLine read GetLine;
    property Space: TString read GetSpace write SetSpace;
    destructor Destroy; override;
  end;

  TLlDOMPropertyBottom = class(TLlDOMPropertyFrameItem)
  end;

  TLlDOMPropertyLeft = class(TLlDOMPropertyFrameItem)
  end;

  TLlDOMPropertyRight = class(TLlDOMPropertyFrameItem)
  end;

  TLlDOMPropertyTop = class(TLlDOMPropertyFrameItem)
  end;

  TLlDOMPropertyGetSignalRanges = class(TLlDOMItem)
  private
    function GetAutomatic: TString;
    procedure SetAutomatic(const value: TString);
    function GetDistance: TString;
    procedure SetDistance(const value: TString);
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property Distance: TString read GetDistance write SetDistance;
  end;

  TLlDOMPropertyFrame = class(TLlDOMItem)
  private
    fBottom: TLlDOMPropertyBottom;
    fLeft: TLlDOMPropertyLeft;
    fRight: TLlDOMPropertyRight;
    fTop: TLlDOMPropertyTop;
    function GetLayout: TString;
    procedure SetLayout(const value: TString);
    function GetBottom: TLlDOMPropertyBottom;
    function GetLeft: TLlDOMPropertyLeft;
    function GetRight: TLlDOMPropertyRight;
    function GetTop: TLlDOMPropertyTop;
    function GetDefault: TString;
    procedure SetDefault(const value: TString);
  public
    property Layout: TString read GetLayout write SetLayout;
    property Bottom: TLlDOMPropertyBottom read GetBottom;
    property Left: TLlDOMPropertyLeft read GetLeft;
    property Right: TLlDOMPropertyRight read GetRight;
    property Top: TLlDOMPropertyTop read GetTop;
    property Default: TString read GetDefault write SetDefault;

    destructor Destroy; override;
  end;

  TLlDOMPropertyFrameCheckBox = class(TLlDOMPropertyFrame)
  end;

  TLlDOMPropertyDefaultColumns = class(TLlDOMItem)
  private
    function GetCount: TString;
    procedure SetCount(const value: TString);
    function GetDistance: TString;
    procedure SetDistance(const value: TString);
  public
    property Count: TString read GetCount write SetCount;
    property Distance: TString read GetDistance write SetDistance;
  end;

  TLlDOMPropertyColumns = class(TLlDOMItem)
  private
    function GetCount: TString;
    procedure SetCount(const value: TString);
    function GetDistance: TString;
    procedure SetDistance(const value: TString);
    function GetColumnBreakCondition: TString;
    procedure SetColumnBreakCondition(const value: TString);
    function GetColumnBreakBefore: TString;
    procedure SetColumnBreakBefore(const value: TString);
  public
    property Count: TString read GetCount write SetCount;
    property ColumnBreakBefore: TString read GetColumnBreakBefore
      write SetColumnBreakBefore;
    property ColumnBreakCondition: TString read GetColumnBreakCondition
      write SetColumnBreakCondition;
    property Distance: TString read GetDistance write SetDistance;
  end;

  TLlDOMPropertyFixedBarOptions = class(TLlDOMItem)
  private
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Width: TString read GetWidth write SetWidth;
    property Alignment: TString read GetAlignment write SetAlignment;
  end;

  TLlDOMPropertyFont = class(TLlDOMItem)
  private
    function GetDefault: TString;
    procedure SetDefault(const value: TString);
    function GetBold: TString;
    procedure SetBold(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetFaceName: TString;
    procedure SetFaceName(const value: TString);
    function GetGdiCharSet: TString;
    procedure SetGdiCharSet(const value: TString);
    function GetItalic: TString;
    procedure SetItalic(const value: TString);
    function GetSize: TString;
    procedure SetSize(const value: TString);
    function GetStrikeout: TString;
    procedure SetStrikeout(const value: TString);
    function GetUnderline: TString;
    procedure SetUnderline(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Default: TString read GetDefault write SetDefault;
    property Bold: TString read GetBold write SetBold;
    property Color: TString read GetColor write SetColor;
    property FaceName: TString read GetFaceName write SetFaceName;
    property GdiCharSet: TString read GetGdiCharSet write SetGdiCharSet;
    property Italic: TString read GetItalic write SetItalic;
    property Size: TString read GetSize write SetSize;
    property Strikeout: TString read GetStrikeout write SetStrikeout;
    property Underline: TString read GetUnderline write SetUnderline;
    property Width: TString read GetWidth write SetWidth;
  end;

  TLlDOMPropertyBookmark = class(TLlDOMItem)
  private
    function GetLevel: TString;
    procedure SetLevel(const value: TString);
    function GetText: TString;
    procedure SetText(const value: TString);
  public
    property Level: TString read GetLevel write SetLevel;
    property Text: TString read GetText write SetText;
  end;

  TLlDOMPropertyReservedSpace = class(TLlDOMItem)
  private
    function GetBottom: TString;
    procedure SetBottom(const value: TString);
    function GetLeft: TString;
    procedure SetLeft(const value: TString);
    function GetRight: TString;
    procedure SetRight(const value: TString);
    function GetTop: TString;
    procedure SetTop(const value: TString);
  public
    property Bottom: TString read GetBottom write SetBottom;
    property Left: TString read GetLeft write SetLeft;
    property Right: TString read GetRight write SetRight;
    property Top: TString read GetTop write SetTop;

    procedure Define(nLeft, nTop, nRight, nBottom: integer);
  end;

  TLlDOMPropertyAlignmentHorizontal = class(TLlDOMItem)
  private
    function GetDecimalPosition: TString;
    procedure SetDecimalPosition(const value: TString);
    function GetAlignmentType: TString;
    procedure SetAlignmentType(const value: TString);
  public
    property AlignmentType: TString read GetAlignmentType
      write SetAlignmentType;
    property DecimalPosition: TString read GetDecimalPosition
      write SetDecimalPosition;
  end;

  TLlDOMPropertyAnchor = class(TLlDOMItem)
  private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetToTop: TString;
    procedure SetToTop(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property ToTop: TString read GetToTop write SetToTop;
  end;

  TLlDOMPropertyVerification = class(TLlDOMItem)
  private
    function GetMatchPattern: TString;
    procedure SetMatchPattern(const value: TString);
    function GetValidationFailedHint: TString;
    procedure SetValidationFailedHint(const value: TString);
  public
    property MatchPattern: TString read GetMatchPattern write SetMatchPattern;
    property ValidationFailedHint: TString read GetValidationFailedHint
      write SetValidationFailedHint;
  end;

  TLlDOMPropertyFieldWrapping = class(TLlDOMItem)
  private
    function GetLine: TString;
    procedure SetLine(const value: TString);
    function GetForce: TString;
    procedure SetForce(const value: TString);
    function GetFlowControl: TString;
    procedure SetFlowControl(const value: TString);
  public
    property FlowControl: TString read GetFlowControl write SetFlowControl;
    property Force: TString read GetForce write SetForce;
    property Line: TString read GetLine write SetLine;
  end;

  TLlDOMPropertyWrapping = class(TLlDOMItem)
  private
    function GetLine: TString;
    procedure SetLine(const value: TString);
    function GetForce: TString;
    procedure SetForce(const value: TString);
  public
    property Line: TString read GetLine write SetLine;
    property Force: TString read GetForce write SetForce;
  end;

  TLlDOMPropertyWrappingExt = class(TLlDOMPropertyWrapping)
  private
    function GetPage: TString;
    procedure SetPage(const value: TString);
  public
    property Page: TString read GetPage write SetPage;
  end;

  TLlDOMPropertyGridLines = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
	function GetLineType: TString;
    procedure SetLineType(const value: TString);

  public
    property Color: TString read GetColor write SetColor;
    property Visible: TString read GetVisible write SetVisible;
	property LineType: TString read GetLineType write SetLineType;
  end;

  TLlDOMPropertyFileInfo = class(TLlDOMItem)
  private
    function GetFileName: TString;
    procedure SetFileName(const value: TString);
    function GetFileNameIsRelative: TString;
    procedure SetFileNameIsRelative(const value: TString);
  public
    property FileName: TString read GetFileName write SetFileName;
    property FileNameIsRelative: TString read GetFileNameIsRelative
      write SetFileNameIsRelative;
  end;

  TLlDOMPropertyRTFSource = class(TLlDOMItem)
  private
    function GetIsVariable: TString;
    procedure SetIsVariable(const value: TString);
    function GetText: TString;
    procedure SetText(const value: TString);
  public
    property IsVariable: TString read GetIsVariable write SetIsVariable;
    property Text: TString read GetText write SetText;
  end;

  TLlDOMPropertyPostalData = class(TLlDOMItem)
  private
    function GetContens: TString;
    procedure SetContents(const value: TString);
    function GetPremiumAddressId: TString;
    procedure SetPremiumAddressId(const value: TString);
  public
    property Contents: TString read GetContens write SetContents;
    property PremiumAddressId: TString read GetPremiumAddressId
      write SetPremiumAddressId;
  end;

  TLlDOMPropertyPremiumAdress = class(TLlDOMItem)
  private
    fPostalData: TLlDOMPropertyPostalData;
    function GetCustomerInfos: TString;
    procedure SetCustomerInfos(const value: TString);
    function GetCustomerNo: TString;
    procedure SetCustomerNo(const value: TString);
    function GetEDSNumber: TString;
    procedure SetEDSNumber(const value: TString);
    function GetFee: TString;
    procedure SetFee(const value: TString);
    function GetPostalData: TLlDOMPropertyPostalData;
    function GetProcessingData: TString;
    procedure SetProcessingData(const value: TString);
    function GetProductKey: TString;
    procedure SetProductKey(const value: TString);
    function GetRecipientLine1: TString;
    procedure SetRecipientLine1(const value: TString);
    function GetRecipientLine2: TString;
    procedure SetRecipientLine2(const value: TString);
    function GetRecipientLine3: TString;
    procedure SetRecipientLine3(const value: TString);
    function GetRecipientLine4: TString;
    procedure SetRecipientLine4(const value: TString);
    function GetRecipientLine5: TString;
    procedure SetRecipientLine5(const value: TString);
    function GetRecipientLine6: TString;
    procedure SetRecipientLine6(const value: TString);
    function GetSenderAddress: TString;
    procedure SetSenderAddress(const value: TString);
    function GetTrackingNumber: TString;
    procedure SetTrackingNumber(const value: TString);
  public
    property CustomerInfos: TString read GetCustomerInfos
      write SetCustomerInfos;
    property CustomerNo: TString read GetCustomerNo write SetCustomerNo;
    property EDSNumber: TString read GetEDSNumber write SetEDSNumber;
    property Fee: TString read GetFee write SetFee;
    property PostalData: TLlDOMPropertyPostalData read GetPostalData;
    property ProcessingData: TString read GetProcessingData
      write SetProcessingData;
    property ProductKey: TString read GetProductKey write SetProductKey;
    property RecipientLine1: TString read GetRecipientLine1
      write SetRecipientLine1;
    property RecipientLine2: TString read GetRecipientLine2
      write SetRecipientLine2;
    property RecipientLine3: TString read GetRecipientLine3
      write SetRecipientLine3;
    property RecipientLine4: TString read GetRecipientLine4
      write SetRecipientLine4;
    property RecipientLine5: TString read GetRecipientLine5
      write SetRecipientLine5;
    property RecipientLine6: TString read GetRecipientLine6
      write SetRecipientLine6;
    property SenderAddress: TString read GetSenderAddress
      write SetSenderAddress;
    property TrackingNumber: TString read GetTrackingNumber
      write SetTrackingNumber;
    destructor Destroy; override;
  end;

  TLlDOMPropertyBarcodeSource = class(TLlDOMItem)
  private
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetText: TString;
    procedure SetText(const value: TString);
    function GetBarcodeType: TString;
    procedure SetBarcodeType(const value: TString);
    function GetVariable: TString;
    procedure SetVariable(const value: TString);
  public
    property Formula: TString read GetFormula write SetFormula;
    property Mode: TString read GetMode write SetMode;
    property Text: TString read GetText write SetText;
    property BarcodeType: TString read GetBarcodeType write SetBarcodeType;
    property Variable: TString read GetVariable write SetVariable;
  end;

TLlDOMPropertyPremiumAddressBarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  fPremiumAdress: TLlDOMPropertyPremiumAdress;
  function GetPremiumAdress: TLlDOMPropertyPremiumAdress;
public
  property PremiumAdress: TLlDOMPropertyPremiumAdress read GetPremiumAdress;
  destructor Destroy; override;
end;

TLlDOMPropertyPDF417BarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetColumnCount: TString;
  function GetErrorCorrection: TString;
  function GetTruncated: TString;
  function GetYToXRatio: TString;
  procedure SetColumnCount(const value: TString);
  procedure SetErrorCorrection(const value: TString);
  procedure SetTruncated(const value: TString);
  procedure SetYToXRatio(const value: TString);
public
  property ColumnCount: TString read GetColumnCount write SetColumnCount;
  property ErrorCorrection: TString read GetErrorCorrection write SetErrorCorrection;
  property Truncated: TString read GetTruncated write SetTruncated;
  property YToXRatio: TString read GetYToXRatio write SetYToXRatio;
end;


TLlDOMPropertyMicroPDF417BarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetEncoding: TString;
  function GetFormat: TString;
  function GetYToXRatio: TString;
  procedure SetEncoding(const value: TString);
  procedure SetFormat(const value: TString);
  procedure SetYToXRatio(const value: TString);
public
  property Encoding: TString read GetEncoding write SetEncoding;
  property Format: TString read GetFormat write SetFormat;
  property YToXRatio: TString read GetYToXRatio write SetYToXRatio;
end;

TLlDOMPropertyMaxicodeBarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetPolygonFillRate: TString;
  function GetMaxicodeMode: TString;
  procedure SetPolygonFillRate(const value: TString);
  procedure SetMaxicodeMode(const value: TString);
public
  property PolygonFillRate: TString read GetPolygonFillRate write SetPolygonFillRate;
  property MaxicodeMode: TString read GetMaxicodeMode write SetMaxicodeMode;
end;

TLlDOMPropertyDatamatrixBarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetEncoding: TString;
  function GetPreferredFormat: TString;
  procedure SetEncoding(const value: TString);
  procedure SetPreferredFormat(const value: TString);
  public
  property Encoding: TString read GetEncoding write SetEncoding;
  property PreferredFormat: TString read GetPreferredFormat write SetPreferredFormat;
end;

TLlDOMPropertyAztecBarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetDataLayer: TString;
  procedure SetDataLayer(const value: TString);
public
  property DataLayer: TString read GetDataLayer write SetDataLayer;
end;

TLlDOMPropertyQRBarcodeSource = class(TLlDOMPropertyBarcodeSource)
private
  function GetEncoding: TString;
  function GetPreferredFormat: TString;
  function GetCorrectionLevel: TString;
  function GetFNC1Mode: TString;
  procedure SetEncoding(const value: TString);
  procedure SetPreferredFormat(const value: TString);
  procedure SetCorrectionLevel(const value: TString);
  procedure SetFNC1Mode(const value: TString);
public
  property Encoding: TString read GetEncoding write SetEncoding;
  property PreferredFormat: TString read GetPreferredFormat write SetPreferredFormat;
  property CorrectionLevel: TString read GetCorrectionLevel write SetCorrectionLevel;
  property FNC1Mode: TString read GetFNC1Mode write SetFNC1Mode;
end;




TLlDOMPropertyInputButtonActionBase = class(TLlDOMItem)
private
  function GetActionType: TString;
  procedure SetActionType(const value: TString);
public
   property Actiontype : TString read GetActionType write SetActionType;
end;

  TLlDOMPropertyInputButtonActionHttpPost = class (TLlDOMPropertyInputButtonActionBase)
  private
    function GetExtraFields: TString;
    procedure SetExtraFields(const value: TString);
    function GetUrl: TString;
    procedure SetUrl(const value: TString);
  public
    property ExtraFields: TString read GetExtraFields write SetExtraFields;
    property Url: TString read GetUrl write SetUrl;
  end;

  TLlDOMPropertyInputButtonActionLink = class(TLlDOMPropertyInputButtonActionBase)
    private
      function GetUrl: TString;
      procedure SetUrl(const value: TString);
    public
      property Url: TString read GetUrl write SetUrl;
  end;

  TLlDOMPropertyInputButtonActionSaveAs = class(TLlDOMPropertyInputButtonActionBase)
  private
    function GetFileName :TString;
    procedure SetFileName (const value: TString);
    function GetFormat :TString;
    procedure SetFormat(const value: TString);
    function GetShowDialog: TString;
    procedure SetShowDialog(const value: TString);
  public
    property FileName: TString read GetFileName write SetFileName;
    property Format: TString read GetFormat write SetFormat;
    property ShowDialog: TString read GetShowDialog write SetShowDialog;
  end;

  TLlDOMPropertyInputButtonActionSendTo = class(TLlDOMPropertyInputButtonActionBase)
  private
    function GetFormat: TString;
    procedure SetFormat(const value: TString);
    function GetBCC: TString;
    procedure SetBCC(const value: TString);
    function GetBody: TString;
    procedure SetBody(const value: TString);
    function GetCC: TString;
    procedure SetCC(const value: TString);
    function GetShowDialog: TString;
    procedure SetShowDialog(const value: TString);
    function GetSubject: TString;
    procedure SetSubject(const value: TString);
    function GetMailTo: TString;
    procedure SetMailTo(const value: TString);
  public
    property Format: TString read GetFormat write SetFormat;
    property BCC: TString read GetBCC write SetBCC;
    property Body: TString read GetBody write SetBody;
    property CC: TString read GetCC write SetCC;
    property ShowDialog: TString read GetShowDialog write SetShowDialog;
    property Subject: TString read GetSubject write SetSubject;
    property MailTo: TString read GetMailTo write SetMailTo;
  end;

  TLlDOMPropertyInputButtonActionPdfSig = class(TLlDOMPropertyInputButtonActionBase)

  end;

  TLlDOMPropertySource = class(TLlDOMItem)
  private
    fFileinfo: TLlDOMPropertyFileInfo;
    fVerification: TLlDOMPropertyVerification;
    function GetFileinfo: TLlDOMPropertyFileInfo;
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetVariable: TString;
    procedure SetVariable(const value: TString);
    function GetVerification: TLlDOMPropertyVerification;
  public
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    property Formula: TString read GetFormula write SetFormula;
    property Mode: TString read GetMode write SetMode;
    property Variable: TString read GetVariable write SetVariable;
    property Verification: TLlDOMPropertyVerification read GetVerification;
    destructor Destroy; override;
  end;

  TLlDOMPropertyFrameExt = class(TLlDOMItem)
  private
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property Style: TString read GetStyle write SetStyle;
    property Width: TString read GetWidth write SetWidth;
  end;


  TLlDOMPropertyShadow = class(TLlDOMItem)
  private
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetPattern: TString;
    procedure SetPattern(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property Pattern: TString read GetPattern write SetPattern;
    property Style: TString read GetStyle write SetStyle;
    property Width: TString read GetWidth write SetWidth;
  end;

  TLlDOMPropertyTextFilling = class(TLlDOMItem)
  private
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
  public
    property Style: TString read GetStyle write SetStyle;
    property Color: TString read GetColor write SetColor;
  end;

  TLlDOMPropertyFilling = class(TLlDOMItem)
  private
    function GetPattern: TString;
    procedure SetPattern(const value: TString);
    function GetAlpha: TString;
    procedure SetAlpha(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetColor2: TString;
    procedure SetColor2(const value: TString);
    function GetColor3: TString;
    procedure SetColor3(const value: TString);
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
  public
    property Alpha: TString read GetAlpha write SetAlpha;
    property Color: TString read GetColor write SetColor;
    property Color2: TString read GetColor2 write SetColor2;
    property Color3: TString read GetColor3 write SetColor3;
    property Pattern: TString read GetPattern write SetPattern;
    property Style: TString read GetStyle write SetStyle;
  end;


  TLlDOMPropertyFillingExt = class(TLlDOMPropertyFilling)
  private
    function GetPattern: TString;
    procedure SetPattern(const value: TString);
    function GetColor2: TString;
    procedure SetColor2(const value: TString);
    function GetColor3: TString;
    procedure SetColor3(const value: TString);
    function GetAlpha: TString;
    procedure SetAlpha(const value: TString);
  public
    property Pattern: TString read GetPattern write SetPattern;
    property Color2: TString read GetColor2 write SetColor2;
    property Color3: TString read GetColor3 write SetColor3;
    property Alpha: TString read GetAlpha write SetAlpha;
  end;

  TLlDOMPropertyFillingWithBitmap = class(TLlDOMPropertyFillingExt)
  private
    fBitmap: TLlDOMPropertyDrawingContents;
    function GetBitmap: TLlDOMPropertyDrawingContents;
  public
    property Bitmap: TLlDOMPropertyDrawingContents read GetBitmap;
  end;

  TLlDOMPropertyPosition = class(TLlDOMItem)
  private
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetLeft: TString;
    procedure SetLeft(const value: TString);
    function GetTop: TString;
    procedure SetTop(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Height: TString read GetHeight write SetHeight;
    property Left: TString read GetLeft write SetLeft;
    property Top: TString read GetTop write SetTop;
    property Width: TString read GetWidth write SetWidth;

    procedure Define(nLeft, nTop, nWidht, nHeight: integer);
  end;

  TLlDOMPropertyCrosstabPageBreakPreferences = class(TLlDOMItem)
  private
    function GetForce: TString;
    procedure SetForce(const value: TString);
    function GetLevel: TString;
    procedure SetLevel(const value: TString);
  public
    property Force: TString read GetForce write SetForce;
    property Level: TString read GetLevel write SetLevel;
  end;

  TLlDOMPropertyCrosstabShadowBase = class(TLlDOMItem)
  private
    function GetActive: TString;
    procedure SetActive(const value: TString);
  public
    property Active: TString read GetActive write SetActive;
  end;

  TLlDOMPropertyCrosstabShadowPages = class(TLlDOMPropertyCrosstabShadowBase)
  private
    function GetDistanceTop: TString;
    procedure SetDistanceTop(const value: TString);
  public
    property DistanceTop: TString read GetDistanceTop write SetDistanceTop;
  end;

  TLlDOMPropertyGanttShadowPages = class(TLlDOMPropertyCrosstabShadowBase)
  private
    function GetRepeatLabels: TString;
    procedure SetRepeatLabels(const value: TString);
  public
    property RepeatLabels: TString read GetRepeatLabels write SetRepeatLabels;
  end;

  TLlDOMPropertyCrosstabWrapping = class(TLlDOMItem)
  private
    fPageBreakPreferences: TLlDOMPropertyCrosstabPageBreakPreferences;
    function GetRepeatLabels: TString;
    procedure SetRepeatLabels(const value: TString);
    function GetPageBreakPreferences
      : TLlDOMPropertyCrosstabPageBreakPreferences;
  public
    property PageBreakPreferences: TLlDOMPropertyCrosstabPageBreakPreferences
      read GetPageBreakPreferences;
    property RepeatLabels: TString read GetRepeatLabels write SetRepeatLabels;

    destructor Destroy; override;
  end;

  TLlDOMPropertyCrosstabRowWrapping = class(TLlDOMPropertyCrosstabWrapping)
  end;

  TLlDOMPropertyCrosstabColumnWrapping = class(TLlDOMPropertyCrosstabWrapping)
  private
    fShadowPages: TLlDOMPropertyCrosstabShadowPages;
    function GetShadowPages: TLlDOMPropertyCrosstabShadowPages;
  public
    property ShadowPages: TLlDOMPropertyCrosstabShadowPages read GetShadowPages;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCrosstabSummary = class(TLlDOMItem)
  private
    function GetBeforeEntries: TString;
    procedure SetBeforeEntries(const value: TString);
    function GetShow: TString;
    procedure SetShow(const value: TString);
  public
    property BeforeEntries: TString read GetBeforeEntries
      write SetBeforeEntries;
    property Show: TString read GetShow write SetShow;
  end;

  TLlDOMPropertyCrosstabDimensionCellBase = class(TLlDOMItem)
  private
    fAlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal;
    fFilling: TLlDOMPropertyFilling;
    fFont: TLlDOMPropertyFont;
    fFrame: TLlDOMPropertyFrame;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetAlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal;
    function GetAlignmentVertical: TString;
    procedure SetAlignmentVertical(const value: TString);
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetFont: TLlDOMPropertyFont;
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetLinkURL: TString;
    procedure SetLinkURL(const value: TString);
    function GetOutputFormatterBase: TLlDOMPropertyOutputFormatterBase;
  public
    property AlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal
      read GetAlignmentHorizontal;
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property Direction: TString read GetDirection write SetDirection;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Font: TLlDOMPropertyFont read GetFont;
    property Formula: TString read GetFormula write SetFormula;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property LinkURL: TString read GetLinkURL write SetLinkURL;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatterBase;

    destructor Destroy; override;
  end;

  TLlDOMPropertyMaxEntryCount = class(TLlDOMItem)
    private
      function GetMaxEntries: TString;
      procedure SetMaxEntries(const value: TString);
      function GetLabel: TString;
      procedure SetLabel(const value: TString);
      function GetWithOthers: TString;
      procedure SetWithOthers(const value: TString);
    public
      property MaxEntries: TString read GetMaxEntries write SetMaxEntries;
      {correct prop name is Label but cannot used (reserved word)}
      property LabelText: TString read GetLabel write Setlabel;
      property WithOthers: TString read GetWithOthers write SetWithOthers;
  end;


  TLlDOMPropertySortOrderAscending = class(TLlDOMItem)
    private
      function GetSortOrder: TString;
      procedure SetSortOrder(const value: TString);
      function GetSubCellIndex: TString;
      procedure SetSubCellIndex(const value: TString);
    public
      property SubCellIndex: TString read GetSubCellIndex write SetSubCellIndex;
      {correct prop name is Label but cannot used (reserved word)}
      property SortOrder: TString read GetSortOrder write SetSortOrder;

  end;


  TLlDOMPropertyAutoFill = class(TLlDOMItem)
  private
    function GetContent: TString;
    procedure SetContent(const value: TString);
    function GetStartValue: TString;
    procedure SetStartValue(const value: TString);
    function GetIncrement: TString;
    procedure SetIncrement(const value: TString);
    function GetLabel: TString;
    procedure SetLabel(const value: TString);
    function GetEndValue: TString;
    procedure SetEndValue(const value: TString);
  public
     property Content: TString read GetContent write SetContent;
     property StartValue: TString read GetStartValue write SetStartValue;
     property Increment: TString read GetIncrement write SetIncrement;
     property LabelText: TString read GetLabel write SetLabel;
     property EndValue: TString read GetEndValue write SetEndValue;

  end;

  TLlDOMPropertyCrosstabDimensionGroupLabelCell = class
    (TLlDOMPropertyCrosstabDimensionCellBase)
  private
    fDrawing: TLlDOMPropertyDrawing;
    fMaxEntryCount: TLlDOMPropertyMaxEntryCount;
    fSortOrderAscending: TLlDOMPropertySortOrderAscending;
    fAutoFill: TLlDOMPropertyAutoFill;
    function GetDrawing: TLlDOMPropertyDrawing;
    function GetAutoFill: TLlDOMPropertyAutoFill;
    function GetMaxEntryCount: TLlDOMPropertyMaxEntryCount;
    function GetSortOrderAscending: TLlDOMPropertySortOrderAscending;
    function GetShowSpanLabel: TString;
    procedure SetShowSpanLabel(const value: TString);
    function GetExpandable: TString;
    procedure SetExpandable(const value: TString);
  public
    property Expandable: TString read GetExpandable write SetExpandable;
    property ShowSpanLabel: TString read GetShowSpanLabel
      write SetShowSpanLabel;
    property AutoFill: TLlDOMPropertyAutoFill read GetAutoFill;
    property SortOrderAscending: TLlDOMPropertySortOrderAscending read GetSortOrderAscending;
    property MaxEntryCount: TLlDOMPropertyMaxEntryCount read GetMaxEntryCount;
    property Drawing: TLlDOMPropertyDrawing read GetDrawing;
    destructor Destroy; override;
  end;


  TLlDOMPropertyCrosstabDimensionSumLabelCell = class
    (TLlDOMPropertyCrosstabDimensionCellBase)
  private
    fSummary: TLlDOMPropertyCrosstabSummary;
    function GetSummary: TLlDOMPropertyCrosstabSummary;
  public
    property Summary: TLlDOMPropertyCrosstabSummary read GetSummary;

    destructor Destroy; override;
  end;

  TLlDOMPropertyCrosstabCells = class(TLlDOMPropertyCrosstabDimensionCellBase)
  private
    function GetMinHeight: TString;
    procedure SetMinHeight(const value: TString);
	function GetSubCellLabel: TString;
	procedure SetSubCellLabel(const value: TString);
    function GetMinWidth: TString;
    procedure SetMinWidth(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
	property SubCellLabel: TString read GetSubCellLabel write SetSubCellLabel;
    property MinHeight: TString read GetMinHeight write SetMinHeight;
    property MinWidth: TString read GetMinWidth write SetMinWidth;
    property value: TString read GetValue write SetValue;
  end;

  TLlDOMPropertyCrosstabDimensionGrouping = class(TLlDOMItem)
  private
    function GetGrouping: TString;
    procedure SetGrouping(const value: TString);
  public
    property Grouping: TString read GetGrouping write SetGrouping;

    constructor Create(list: TLlDOMCrosstabFormulaList); overload;
  end;

  TLlDOMPropertyCrosstabDimension = class(TLlDOMItem)
  private
    fGroupLabel: TLlDOMCrosstabCellGroupLabelList;
    fSumLabel: TLlDOMCrosstabCellSumLabelList;
    fGroupingList: TLlDOMCrosstabFormulaList;
    function GetSumLabelList: TLlDOMCrosstabCellSumLabelList;
    function GetGroupLabelList: TLlDOMCrosstabCellGroupLabelList;
    function GetGroupingList: TLlDOMCrosstabFormulaList;
  public
    property Groupings: TLlDOMCrosstabFormulaList read GetGroupingList;
    property GroupLabel: TLlDOMCrosstabCellGroupLabelList
      read GetGroupLabelList;
    property SumLabel: TLlDOMCrosstabCellSumLabelList read GetSumLabelList;

    destructor Destroy; override;
  end;

  TLlDOMPropertyCrosstabDefinition = class(TLlDOMItem)
  private
    fBookmark: TLlDOMPropertyBookmark;
    fFilling: TLlDOMPropertyFilling;
    fDefaultFrame: TLlDOMPropertyFrame;
    fDefaultFont: TLlDOMPropertyFont;
    fColumnWrapping: TLlDOMPropertyCrosstabColumnWrapping;
    fRowWrapping: TLlDOMPropertyCrosstabRowWrapping;
    fRows: TLlDOMPropertyCrosstabDimension;
    fColumns: TLlDOMPropertyCrosstabDimension;
    fCells: TLlDOMCrosstabCellsList;
    function GetLinkURL: TString;
    procedure SetLinkURL(const value: TString);
	  function GetHarmonicLineHeights: TString;
	  procedure SetHarmonicLineHeights(const value: TString);
	  function GetSubCellCount: TString;
	  procedure SetSubCellCount(const value: TString);
    function GetMinHeight: TString;
    procedure SetMinHeight(const value: TString);
    function GetWrapPercentage: TString;
    procedure SetWrapPercentage(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetFrame: TLlDOMPropertyFrame;
    function GetFont: TLlDOMPropertyFont;
    function GetColumnWrapping: TLlDOMPropertyCrosstabColumnWrapping;
    function GetRowWrapping: TLlDOMPropertyCrosstabRowWrapping;
    function GetRows: TLlDOMPropertyCrosstabDimension;
    function GetColumns: TLlDOMPropertyCrosstabDimension;
    function GetCells: TLlDOMCrosstabCellsList;
    function GetBookmark: TLlDOMPropertyBookmark;
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
  public
	property HarmonicLineHeights: TString read GetHarmonicLineHeights write SetHarmonicLineHeights;
	property SubCellCount: TString read GetSubCellCount write SetSubCellCount;
    property Filter: TString read GetFilter write SetFilter;
    property Bookmark: TLlDOMPropertyBookmark read GetBookmark;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property DefaultFrame: TLlDOMPropertyFrame read GetFrame;
    property DefaultFont: TLlDOMPropertyFont read GetFont;
    property ColumnWrapping: TLlDOMPropertyCrosstabColumnWrapping
      read GetColumnWrapping;
    property RowWrapping: TLlDOMPropertyCrosstabRowWrapping read GetRowWrapping;
    property Rows: TLlDOMPropertyCrosstabDimension read GetRows;
    property Columns: TLlDOMPropertyCrosstabDimension read GetColumns;
    property Cells: TLlDOMCrosstabCellsList read GetCells;
    property LinkURL: TString read GetLinkURL write SetLinkURL;
    property MinHeight: TString read GetMinHeight write SetMinHeight;
    property WrapPercentage: TString read GetWrapPercentage
      write SetWrapPercentage;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartSecondaryValueAxis = class(TLlDOMItem)
  private
    function GetEnabled: TString;
    procedure SetEnabled(const value: TString);
    function GetAssignment: TString;
    procedure SetAssignment(const value: TString);
  public
    property Assignment: TString read GetAssignment write SetAssignment;
    property Enabled: TString read GetEnabled write SetEnabled;
  end;

  TLlDOMPropertyBackground = class(TLlDOMItem)
  private
    fFilling: TLlDOMPropertyChartFilling;
    fFrame: TLlDOMPropertyFrameExt;
    fShadow: TLlDOMPropertyShadow;
    function GetRounding: TString;
    procedure SetRounding(const value: TString);
    function GetShadow: TLlDOMPropertyShadow;
    function GetFrame: TLlDOMPropertyFrameExt;
    function GetFilling: TLlDOMPropertyChartFilling;
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
  public
    property Filling: TLlDOMPropertyChartFilling read GetFilling;
    property Frame: TLlDOMPropertyFrameExt read GetFrame;
    property Rounding: TString read GetRounding write SetRounding;
    property Shadow: TLlDOMPropertyShadow read GetShadow;
    property Visible: TString read GetVisible write SetVisible;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartDefinition = class(TLlDOMItem)
  private
    fBackground: TLlDOMPropertyBackground;
    fChartColor: TLlDOMPropertyChartColorArray;
    fChartEngine: TLlDOMPropertyChartEngineBase;
    fConditionalColors: TLlDOMChartConditionalColorsList;
    fTitle: TLlDOMPropertyChartTitle;
    fBookmark: TLlDOMPropertyBookmark;
    fManualLegends: TLlDOMPropertyManualLegendsList;
    function GetBackground: TLlDOMPropertyBackground;
    function GetTitlePosition: TString;
    function GetManualLegends: TLlDOMPropertyManualLegendsList;
    procedure SetTitlePosition(const value: TString);
    function GetTitle: TLlDOMPropertyChartTitle;
    function GetChartEngine: TLlDOMPropertyChartEngineBase;
    function GetChartColorArray: TLlDOMPropertyChartColorArray;
    function GetConditionalColors: TLlDOMChartConditionalColorsList;
    function GetBookmark: TLlDOMPropertyBookmark;

  public
    property ManualLegends: TLlDOMPropertyManualLegendsList read GetManualLegends;
    property Background: TLlDOMPropertyBackground read GetBackground;
    property ChartEngine: TLlDOMPropertyChartEngineBase read GetChartEngine;
    property Colors: TLlDOMPropertyChartColorArray read GetChartColorArray;
    property ConditionalColors: TLlDOMChartConditionalColorsList
      read GetConditionalColors;
    property Title: TLlDOMPropertyChartTitle read GetTitle;
    property TitlePosition: TString read GetTitlePosition
      write SetTitlePosition;
    property Bookmark: TLlDOMPropertyBookmark read GetBookmark;

    destructor Destroy; override;
  end;

  TLlDOMPropertyDisplay = class(TLlDOMItem)
  private
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetOriginalSize: TString;
    procedure SetOriginalSize(const value: TString);
  public
    property Alignment: TString read GetAlignment write SetAlignment;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property OriginalSize: TString read GetOriginalSize write SetOriginalSize;
  end;

  TLlDOMPropertyPDFSource = class(TLlDOMItem)
  private
    fDisplay: TLlDOMPropertyDisplay;
    fFileinfo: TLlDOMPropertyFileInfo;
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetPageRange: TString;
    procedure SetPageRange(const value: TString);
    function GetPassword: TString;
    procedure SetPassword(const value: TString);
    function GetEmbedded: TString;
    procedure SetEmbedded(const value: TString);
    function GetPagebreak: TString;
    procedure SetPagebreak(const value: TString);
    function GetFontMode: TString;
    procedure SetFontMode(const value: TString);
    function GetDisplay: TLlDOMPropertyDisplay;
    function GetFileinfo: TLlDOMPropertyFileInfo;
  public
    property Mode: TString read GetMode write SetMode;
    property Formula: TString read GetFormula write SetFormula;
    property PageRange: TString read GetPageRange write SetPageRange;
    property Password: TString read GetPassword write SetPassword;
    property Embedded: TString read GetEmbedded write SetEmbedded;
    property Pagebreak: TString read GetPagebreak write SetPagebreak;
    property FontMode: TString read GetFontMode
      write SetFontMode;
    property Display: TLlDOMPropertyDisplay read GetDisplay;
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    destructor Destroy; override;
  end;

  TLlDOMPropertyPDFDefinition = class(TLlDOMItem)
  private
    fPDFSource: TLlDOMPropertyPDFSource;
    function GetPDFSource: TLlDOMPropertyPDFSource;
  public
    property PDFSource: TLlDOMPropertyPDFSource read GetPDFSource;
    destructor Destroy; override;
  end;

  TLlDOMPropertyGaugeDefinition = class(TLlDOMItem)
  private
    fAlphaBlendableItemFrame: TLlDOMPropertyAlphaBlendableItem;
    fAlphaBlendableItemGlass: TLlDOMPropertyAlphaBlendableItem;
    fMinimumValue: TLlDOMPropertyScaleLimits;
    fMaximumValue: TLlDOMPropertyScaleLimits;
    fPointer: TLlDOMPropertyPointer;
    fScaleLabels: TLlDOMPropertyScaleLabels;
    fTickmarks: TLlDOMPropertyTickmarks;
    fLabels: TLlDOMPropertyLabels;
    fSignalRanges: TLlDOMPropertySignalRanges;
    fStartValue: TLlDOMPropertyStartValue;
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetWhiteSpaceBeforeScaleRange: TString;
    procedure SetWhiteSpaceBeforeScaleRange(const value: TString);
    function GetWhiteSpaceAfterScaleRange: TString;
    procedure SetWhiteSpaceAfterScaleRange(const value: TString);
    function GetPropertyAlphaBlendableItemFrame
      : TLlDOMPropertyAlphaBlendableItem;
    function GetPropertyAlphaBlendableItemGlass
      : TLlDOMPropertyAlphaBlendableItem;
    function GetPropertyPointer: TLlDOMPropertyPointer;
    function GetPropertyMinimumValue: TLlDOMPropertyScaleLimits;
    function GetPropertyMaximumValue: TLlDOMPropertyScaleLimits;
    function GetScaleLabels: TLlDOMPropertyScaleLabels;
    function GetTickmarks: TLlDOMPropertyTickmarks;
    function GetLabels: TLlDOMPropertyLabels;
    function GetSignalRanges: TLlDOMPropertySignalRanges;
    function GetStartValue: TLlDOMPropertyStartValue;
    function GetScaleRangeRotationAngle: TString;
    procedure SetScaleRangeRotationAngle(const value: TString);
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetWidthHeightRelation: TString;
    procedure SetWidthHeightRelation(const value: TString);
  public
    property value: TString read GetValue write SetValue;
    property ScalePercentageMinimum: TString read GetWhiteSpaceBeforeScaleRange
      write SetWhiteSpaceBeforeScaleRange;
    property ScalePercentageMaximum: TString read GetWhiteSpaceAfterScaleRange
      write SetWhiteSpaceAfterScaleRange;
    property Frame: TLlDOMPropertyAlphaBlendableItem
      read GetPropertyAlphaBlendableItemFrame;
    property Glass: TLlDOMPropertyAlphaBlendableItem
      read GetPropertyAlphaBlendableItemGlass;
    property Pointer: TLlDOMPropertyPointer read GetPropertyPointer;
    property MinimumValue: TLlDOMPropertyScaleLimits
      read GetPropertyMinimumValue;
    property MaximumValue: TLlDOMPropertyScaleLimits
      read GetPropertyMaximumValue;
    property ScaleLabels: TLlDOMPropertyScaleLabels read GetScaleLabels;
    property Tickmarks: TLlDOMPropertyTickmarks read GetTickmarks;
    property Labels: TLlDOMPropertyLabels read GetLabels;
    property SignalRanges: TLlDOMPropertySignalRanges read GetSignalRanges;
    property StartValue: TLlDOMPropertyStartValue read GetStartValue;
    property ScaleRangeRotationAngle: TString read GetScaleRangeRotationAngle
      write SetScaleRangeRotationAngle;
    property Style: TString read GetStyle write SetStyle;
    property WidthHeightRelation: TString read GetWidthHeightRelation
      write SetWidthHeightRelation;
    destructor Destroy; override;
  end;

  TLlDOMPropertyHighlightRange = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetEndDate: TString;
    procedure SetEndDate(const value: TString);
    function GetStartDate: TString;
    procedure SetStartDate(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property EndDate: TString read GetEndDate write SetEndDate;
    property StartDate: TString read GetStartDate write SetStartDate;
  end;

  TLlDOMPropertyOuterInterval = class(TLlDOMItem)
  private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetFormat: TString;
    procedure SetFormat(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property Format: TString read GetFormat write SetFormat;
  end;

  TLlDOMPropertyInnerInterval = class(TLlDOMItem)
  private
    fOuterInterval: TLlDOMPropertyOuterInterval;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetMarkedDays: TString;
    procedure SetMarkedDays(const value: TString);
    function GetFormat: TString;
    procedure SetFormat(const value: TString);
    function GetOuterInterval: TLlDOMPropertyOuterInterval;
  public
    property Contents: TString read GetContents write SetContents;
    property Format: TString read GetFormat write SetFormat;
    property MarkedDays: TString read GetMarkedDays write SetMarkedDays;
    property OuterInterval: TLlDOMPropertyOuterInterval read GetOuterInterval;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartArea = class(TLlDOMItem)
  private
    fInnerInterval: TLlDOMPropertyInnerInterval;
    function GetInnerInterval: TLlDOMPropertyInnerInterval;
    function GetStartDate: TString;
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    procedure SetStartDate(const value: TString);
    function GetEndDate: TString;
    procedure SetEndDate(const value: TString);
  public
    property EndDate: TString read GetEndDate write SetEndDate;
    property InnerInterval: TLlDOMPropertyInnerInterval read GetInnerInterval;
    property StartDate: TString read GetStartDate write SetStartDate;
    property Width: TString read GetWidth write SetWidth;
    destructor Destroy; override;
  end;

  TLlDOMPropertyTitleRow = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyDefaultFont;
    fBackgournd: TLlDOMPropertyBackground;

    function GetBackground: TLlDOMPropertyBackground;
    function GetFont: TLlDOMPropertyDefaultFont;
  public
    property Background: TLlDOMPropertyBackground read GetBackground;
    property Font: TLlDOMPropertyDefaultFont read GetFont;
    destructor Destroy; override;
  end;

  TLlDOMPropertyBar = class(TLlDOMItem)
  private
    fFillingFinished: TLlDOMPropertyChartFilling;
    fFillingUnfinished: TLlDOMPropertyChartFilling;
    function GetEndTicks: TString;
    procedure SetEndTicks(const value: TString);
    function GetHeightFinished: TString;
    procedure SetHeightFinished(const value: TString);
    function GetHeightUnfinished: TString;
    procedure SetHeightUnfinished(const value: TString);
    function GetRounding: TString;
    procedure SetRounding(const value: TString);

    function GetFinishedFilling: TLlDOMPropertyChartFilling;
    function GetUnfinishedFilling: TLlDOMPropertyChartFilling;
  public
    property EndTicks: TString read GetEndTicks write SetEndTicks;
    property FillingFinished: TLlDOMPropertyChartFilling
      read GetFinishedFilling;
    property HeightFinished: TString read GetHeightFinished
      write SetHeightFinished;
    property HeightUnfinished: TString read GetHeightUnfinished
      write SetHeightUnfinished;
    property Rounding: TString read GetRounding write SetRounding;
    property FillingUnfinished: TLlDOMPropertyChartFilling
      read GetUnfinishedFilling;
    destructor Destroy; override;
  end;

  TLlDOMPropertyTaskRows = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyDefaultFont;
    fBackgournd: TLlDOMPropertyBackground;
    fBar: TLlDOMPropertyBar;

    function GetBackground: TLlDOMPropertyBackground;
    function GetFont: TLlDOMPropertyDefaultFont;
    function GetBar: TLlDOMPropertyBar;
  public
    property Background: TLlDOMPropertyBackground read GetBackground;
    property Font: TLlDOMPropertyDefaultFont read GetFont;
    property Bar: TLlDOMPropertyBar read GetBar;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCell = class(TLlDOMItem)
  private
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;

    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetMaxWidth: TString;
    procedure SetMaxWidth(const value: TString);
    function GetMinWidth: TString;
    procedure SetMinWidth(const value: TString);
    function GetTitle: TString;
    procedure SetTitle(const value: TString);
    function GetOuputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property Visible: TString read GetVisible write SetVisible;
    property MaxWidth: TString read GetMaxWidth write SetMaxWidth;
    property MinWidth: TString read GetMinWidth write SetMinWidth;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOuputFormatter;
    property Title: TString read GetTitle write SetTitle;
    destructor Destroy; override;
  end;

  TLlDOMPropertyIndexCell = class(TLlDOMItem)
  private
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetMaxWidth: TString;
    procedure SetMaxWidth(const value: TString);
    function GetTitle: TString;
    procedure SetTitle(const value: TString);
  public
    property Visible: TString read GetVisible write SetVisible;
    property MaxWidth: TString read GetMaxWidth write SetMaxWidth;
    property Title: TString read GetTitle write SetTitle;
  end;

  TLlDOMPropertyLabelCell = class(TLlDOMItem)
  private
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetIndentation: TString;
    procedure SetIndentation(const value: TString);
    function GetMaxWidth: TString;
    procedure SetMaxWidth(const value: TString);
    function GetTitle: TString;
    procedure SetTitle(const value: TString);
  public
    property Visible: TString read GetVisible write SetVisible;
    property Indentation: TString read GetIndentation write SetIndentation;
    property MaxWidth: TString read GetMaxWidth write SetMaxWidth;
    property Title: TString read GetTitle write SetTitle;
  end;

  TLlDOMPropertyTableArea = class(TLlDOMItem)
  private
    fDurationCell: TLlDOMPropertyCell;
    fEndDateCell: TLlDOMPropertyCell;
    fIndexCell: TLlDOMPropertyIndexCell;
    fLabelCell: TLlDOMPropertyLabelCell;
    fPercentageCompleteCell: TLlDOMPropertyCell;
    fStartDateCell: TLlDOMPropertyCell;

    function GetDurationCell: TLlDOMPropertyCell;
    function GetEndDateCell: TLlDOMPropertyCell;
    function GetIndexCell: TLlDOMPropertyIndexCell;
    function GetLabelCell: TLlDOMPropertyLabelCell;
    function GetPercentageCompleteCell: TLlDOMPropertyCell;
    function GetStartDateCell: TLlDOMPropertyCell;
  public
    property DurationCell: TLlDOMPropertyCell read GetDurationCell;
    property EndDateCell: TLlDOMPropertyCell read GetEndDateCell;
    property IndexCell: TLlDOMPropertyIndexCell read GetIndexCell;
    property LabelCell: TLlDOMPropertyLabelCell read GetLabelCell;
    property PercentageCompleteCell: TLlDOMPropertyCell
      read GetPercentageCompleteCell;
    property StartDateCell: TLlDOMPropertyCell read GetStartDateCell;
    destructor Destroy; override;
  end;

  TLlDomPropertyGridLineStyle = class (TLlDOMItem)
  private
    function GetGridLineStyleColor: TString;
    procedure SetGridLineStyleColor(const value: TString);
    function GetLineWidth : TString;
    procedure SetLineWidth (const value: TString);
  public
     property GridLineStyleColor: TString read GetGridLineStyleColor write SetGridLineStyleColor;
     property LineWidth : TString read GetLineWidth write SetLineWidth;

  end;


  TLlDomPropertyGridMode = class (TLlDOMItem)
  private
    fGridLineStyleDiagram: TLlDomPropertyGridLineStyle;
    fGridLineStyleTable: TLlDomPropertyGridLineStyle;
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetGridLineStyleDiagram: TLlDomPropertyGridLineStyle;
    function GetGridLineStyleTable: TLlDomPropertyGridLineStyle;

  public
    property Mode: TString read GetMode write SetMode;
    property GridLineStyleDiagram: TLlDomPropertyGridLineStyle read GetGridLineStyleDiagram;
    property GridLineStyleTable: TLlDomPropertyGridLineStyle read GetGridLineStyleTable;
    destructor Destroy; override;
  end;

  TLlDomPropertyGanttChartDefinition = class(TLlDOMItem)
  private
    fChartArea: TLlDOMPropertyChartArea;
    fFont: TLlDOMPropertyDefaultFont;
    fHighlightRange: TLlDOMPropertyHighlightRange;
    fTitleRow: TLlDOMPropertyTitleRow;
    fSummaryTaskRows: TLlDOMPropertyTaskRows;
    fTableArea: TLlDOMPropertyTableArea;
    fTaskRows: TLlDOMPropertyTaskRows;
    fFilling: TLlDOMPropertyChartFilling;

    function GetBarLabel: TString;
    procedure SetBarLabel(const value: TString);
    function GetAssumeDayResolution: TString;
    procedure SetAssumeDayResolution(const value: TString);
    function GetDistanceTop: TString;
    procedure SetDistanceTop(const value: TString);
    function GetDuration: TString;
    procedure SetDuration(const value: TString);
    function GetEndDate: TString;
    procedure SetEndDate(const value: TString);
    function GetStartDate: TString;
    procedure SetStartDate(const value: TString);
    function GetGridMode: TString;
    procedure SetGridMode(const value: TString);
    function GetLinkURL: TString;
    procedure SetLinkURL(const value: TString);
    function GetMinHeight: TString;
    procedure SetMinHeight(const value: TString);
    function GetPercentageComplete: TString;
    procedure SetPercentageComplete(const value: TString);
    function GetSummaryTaskDescription: TString;
    procedure SetSummaryTaskDescription(const value: TString);
    function GetTaskDescription: TString;
    procedure SetTaskDescription(const value: TString);
    function GetWrapGrouped: TString;
    procedure SetWrapGrouped(const value: TString);

    function GetChartArea: TLlDOMPropertyChartArea;
    function GetFont: TLlDOMPropertyDefaultFont;
    function GetHighlightRange: TLlDOMPropertyHighlightRange;
    function GetTitleRow: TLlDOMPropertyTitleRow;
    function GetTaskRows: TLlDOMPropertyTaskRows;
    function GetTableArea: TLlDOMPropertyTableArea;
    function GetSummaryTaskRows: TLlDOMPropertyTaskRows;
    function GetFilling: TLlDOMPropertyChartFilling;
  public
    property BarLabel: TString read GetBarLabel write SetBarLabel;
    property AssumeDayResolution: TString read GetAssumeDayResolution
      write SetAssumeDayResolution;
    property ChartArea: TLlDOMPropertyChartArea read GetChartArea;
    property DistanceTop: TString read GetDistanceTop write SetDistanceTop;
    property Duration: TString read GetDuration write SetDuration;
    property EndDate: TString read GetEndDate write SetEndDate;
    property Filling: TLlDOMPropertyChartFilling read GetFilling;
    property Font: TLlDOMPropertyDefaultFont read GetFont;
    property GridMode: TString read GetGridMode write SetGridMode;
    property HighlightRange: TLlDOMPropertyHighlightRange
      read GetHighlightRange;
    property LinkURL: TString read GetLinkURL write SetLinkURL;
    property MinHeight: TString read GetMinHeight write SetMinHeight;
    property PercentageComplete: TString read GetPercentageComplete
      write SetPercentageComplete;
    property StartDate: TString read GetStartDate write SetStartDate;
    property SummaryTaskDescription: TString read GetSummaryTaskDescription
      write SetSummaryTaskDescription;
    property SummaryTaskRows: TLlDOMPropertyTaskRows read GetSummaryTaskRows;
    property TaskDescription: TString read GetTaskDescription
      write SetTaskDescription;
    property TaskRows: TLlDOMPropertyTaskRows read GetTaskRows;
    property TableArea: TLlDOMPropertyTableArea read GetTableArea;
    property TitleRow: TLlDOMPropertyTitleRow read GetTitleRow;
    property WrapGrouped: TString read GetWrapGrouped write SetWrapGrouped;
    destructor Destroy; override;
  end;

  TLlDOMColorRangeItemList = class;

  TLlDOMColorRangeItem = class(TLlDOMItem)
  private
    FPropertyFilling: TLlDOMPropertyChartFilling;
    function GetFilling: TLlDOMPropertyChartFilling;
    function GetMax: TString;
    function GetMin: TString;
    procedure SetMax(const value: TString);
    procedure SetMin(const value: TString);
  public
    property Max: TString read GetMax write SetMax;
    property Min: TString read GetMin write SetMin;
    property Filling: TLlDOMPropertyChartFilling read GetFilling;
    constructor Create(list: TLlDOMColorRangeItemList); overload;
    destructor Destroy; override;
  end;

  TLlDOMColorRangeItemList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMColorRangeItem;
    procedure SetItems(index: integer; const value: TLlDOMColorRangeItem);
    function AddColorRangeItem(domObj: TLlDOMColorRangeItem): integer;
  public
    function Add(domObj: TLlDOMColorRangeItem): integer;
    property Items[index: integer]: TLlDOMColorRangeItem read GetItems
      write SetItems;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMPropertyColorRanges = class(TLlDOMItem)
  private
    FPropertyAutomaticFilling: TLlDOMPropertyChartFilling;
    FColorRangeItemList: TLlDOMColorRangeItemList;
    function GetAbsoluteValues: TString;
    function GetAutomatic: TString;
    function GetAutomaticFilling: TLlDOMPropertyChartFilling;
    procedure SetAbsoluteValues(const value: TString);
    procedure SetAutomatic(const value: TString);
    function GetColorRangeItemList: TLlDOMColorRangeItemList;
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property AbsoluteValues: TString read GetAbsoluteValues
      write SetAbsoluteValues;
    property AutomaticFilling: TLlDOMPropertyChartFilling
      read GetAutomaticFilling;
    property list: TLlDOMColorRangeItemList read GetColorRangeItemList;
    destructor Destroy; override;
  End;

  TLlDOMPropertyAlignment = class(TLlDOMItem)
  private
    FPropertyBaseLine: TLlDOMPropertyLine;
    function GetBaseValue: TString;
    function GetBaseLine: TLlDOMPropertyLine;
    function GetContents: TString;
    procedure SetBaseValue(const value: TString);
    procedure SetContents(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property BaseValue: TString read GetBaseValue write SetBaseValue;
    property BaseLine: TLlDOMPropertyLine read GetBaseLine;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDataGraphicBar = class(TLlDOMItem)
  private
    FPropertyAlignment: TLlDOMPropertyAlignment;
    FPropertyColorRanges: TLlDOMPropertyColorRanges;
    function GetAlignment: TLlDOMPropertyAlignment;
    function GetAlignmentVertical: TString;
    function GetColorRanges: TLlDOMPropertyColorRanges;
    function GetCondition: TString;
    function GetHeight: TString;
    function GetRounding: TString;
    procedure SetAlignmentVertical(const value: TString);
    procedure SetCondition(const value: TString);
    procedure SetHeight(const value: TString);
    procedure SetRounding(const value: TString);
  public
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property Condition: TString read GetCondition write SetCondition;
    property Height: TString read GetHeight write SetHeight;
    property Rounding: TString read GetRounding write SetRounding;
    property Alignment: TLlDOMPropertyAlignment read GetAlignment;
    property ColorRanges: TLlDOMPropertyColorRanges read GetColorRanges;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDataGraphicDisplay = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetAlignment: TString;
    function GetCondition: TString;
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatterBase: TLlDOMPropertyOutputFormatterBase;
    procedure SetAlignment(const value: TString);
    procedure SetCondition(const value: TString);
  public
    property Condition: TString read GetCondition write SetCondition;
    property Alignment: TString read GetAlignment write SetAlignment;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatterBase;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDataGraphicData = class(TLlDOMItem)
  private
    FPropertyDisplay: TLlDOMPropertyDataGraphicDisplay;
    function GetDisplay: TLlDOMPropertyDataGraphicDisplay;
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property value: TString read GetValue write SetValue;
    property Display: TLlDOMPropertyDataGraphicDisplay read GetDisplay;
    destructor Destroy; override;
  End;

  TLlDOMIconRangeItemList = class;

  TLlDOMIconRangeItem = class(TLlDOMItem)
  private
    function GetIndex: TString;
    function GetMax: TString;
    function GetMin: TString;
    procedure SetIndex(const value: TString);
    procedure SetMax(const value: TString);
    procedure SetMin(const value: TString);
  public
    property Index: TString read GetIndex write SetIndex;
    property Max: TString read GetMax write SetMax;
    property Min: TString read GetMin write SetMin;
    constructor Create(list: TLlDOMIconRangeItemList); overload;
  end;

  TLlDOMIconRangeItemList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMIconRangeItem;
    procedure SetItems(index: integer; const value: TLlDOMIconRangeItem);
    function AddIconRangeItem(domObj: TLlDOMIconRangeItem): integer;
  public
    function Add(domObj: TLlDOMIconRangeItem): integer;
    property Items[index: integer]: TLlDOMIconRangeItem read GetItems
      write SetItems;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMPropertyIconRanges = class(TLlDOMItem)
  private
    FIconRangeItemList: TLlDOMIconRangeItemList;
    function GetAbsoluteValues: TString;
    function GetAutomatic: TString;
    function GetIconRangeItemList: TLlDOMIconRangeItemList;
    procedure SetAbsoluteValues(const value: TString);
    procedure SetAutomatic(const value: TString);
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property AbsoluteValues: TString read GetAbsoluteValues
      write SetAbsoluteValues;
    property list: TLlDOMIconRangeItemList read GetIconRangeItemList;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDataGraphicIcon = class(TLlDOMItem)
  private
    FPropertyIconRanges: TLlDOMPropertyIconRanges;
    function GetAlignment: TString;
    function GetAlignmentVertical: TString;
    function GetCondition: TString;
    function GetHeight: TString;
    function GetIcon: TString;
    procedure SetAlignment(const value: TString);
    procedure SetAlignmentVertical(const value: TString);
    procedure SetCondition(const value: TString);
    procedure SetHeight(const value: TString);
    procedure SetIcon(const value: TString);
    function GetIconRanges: TLlDOMPropertyIconRanges;
  public
    property Alignment: TString read GetAlignment write SetAlignment;
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property Condition: TString read GetCondition write SetCondition;
    property Height: TString read GetHeight write SetHeight;
    property Icon: TString read GetIcon write SetIcon;
    property IconRanges: TLlDOMPropertyIconRanges read GetIconRanges;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDataGraphicDefinition = class(TLlDOMItem)
  private
    FPropertyBar: TLlDOMPropertyDataGraphicBar;
    FPropertyData: TLlDOMPropertyDataGraphicData;
    FPropertyIcon: TLlDOMPropertyDataGraphicIcon;
    function GetMaximumValue: TString;
    function GetMinimumValue: TString;
    function GetPropertyBar: TLlDOMPropertyDataGraphicBar;
    function GetPropertyData: TLlDOMPropertyDataGraphicData;
    function GetPropertyIcon: TLlDOMPropertyDataGraphicIcon;
    procedure SetMaximumValue(const value: TString);
    procedure SetMinimumValue(const value: TString);
  public
    property MaximumValue: TString read GetMaximumValue write SetMaximumValue;
    property MinimumValue: TString read GetMinimumValue write SetMinimumValue;
    property Bar: TLlDOMPropertyDataGraphicBar read GetPropertyBar;
    property Data: TLlDOMPropertyDataGraphicData read GetPropertyData;
    property Icon: TLlDOMPropertyDataGraphicIcon read GetPropertyIcon;
    destructor Destroy; override;
  End;

  TLlDOMPropertyAlphaBlendableItem = class(TLlDOMItem)
  private
    function GetAlpha: TString;
    procedure SetAlpha(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
  public
    property Alpha: TString read GetAlpha write SetAlpha;
    property Color: TString read GetColor write SetColor;
    property Style: TString read GetStyle write SetStyle;
  End;

  TLlDOMPropertyPointer = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetSize: TString;
    procedure SetSize(const value: TString);
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
  public
    property Size: TString read GetSize write SetSize;
    property Color: TString read GetColor write SetColor;
    property Style: TString read GetStyle write SetStyle;
  End;

  TLlDOMPropertyScaleLimits = class(TLlDOMItem)
  private
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetFitToDistance: TString;
    procedure SetFitToDistance(const value: TString);
  public
    property value: TString read GetValue write SetValue;
    property FitToDistance: TString read GetFitToDistance
      write SetFitToDistance;
  End;

  TLlDOMPropertyScaleLabels = class(TLlDOMItem)
  private
    fDisplayRange: TLlDOMPropertyDisplayRange;
    fFont: TLlDOMPropertyDefaultFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetRotated: TString;
    procedure SetRotated(const value: TString);
    function GetSizeAdjustment: TString;
    procedure SetSizeAdjustment(const value: TString);
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetDisplayRange: TLlDOMPropertyDisplayRange;
    function GetFont: TLlDOMPropertyDefaultFont;
  public
    property Visible: TString read GetVisible write SetVisible;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Rotated: TString read GetRotated write SetRotated;
    property SizeAdjustment: TString read GetSizeAdjustment
      write SetSizeAdjustment;
    property Alignment: TString read GetAlignment write SetAlignment;
    property DisplayRange: TLlDOMPropertyDisplayRange read GetDisplayRange;
    property Font: TLlDOMPropertyDefaultFont read GetFont;
    destructor Destroy; override;
  End;

  TLlDOMPropertyTickmarks = class(TLlDOMItem)
  private
    fDisplayRange: TLlDOMPropertyDisplayRange;
    fDistance: TLlDOMPropertyDistance;
    fFilling: TLlDOMPropertyFilling;
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetDetailLevel: TString;
    procedure SetDetailLevel(const value: TString);
    function GetSubTickPosition: TString;
    procedure SetSubTickPosition(const value: TString);
    function GetTickWidth: TString;
    procedure SetTickWidth(const value: TString);
    function GetDisplayRange: TLlDOMPropertyDisplayRange;
    function GetDistance: TLlDOMPropertyDistance;
    function GetFilling: TLlDOMPropertyFilling;
  public
    property Visible: TString read GetVisible write SetVisible;
    property Color: TString read GetColor write SetColor;
    property DetailLevel: TString read GetDetailLevel write SetDetailLevel;
    property SubTickPosition: TString read GetSubTickPosition
      write SetSubTickPosition;
    property TickWidth: TString read GetTickWidth write SetTickWidth;
    property DisplayRange: TLlDOMPropertyDisplayRange read GetDisplayRange;
    property Distance: TLlDOMPropertyDistance read GetDistance;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    destructor Destroy; override;
  End;

  TLlDOMPropertyDisplayRange = class(TLlDOMItem)
  private
    function GetMax: TString;
    procedure SetMax(const value: TString);
    function GetMin: TString;
    procedure SetMin(const value: TString);
  public
    property Max: TString read GetMax write SetMax;
    property Min: TString read GetMin write SetMin;
  End;

  TLlDOMPropertyDistance = class(TLlDOMItem)
  private
    function GetAutomatic: TString;
    procedure SetAutomatic(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property value: TString read GetValue write SetValue;
  End;

  TLlDOMPropertyLabels = class(TLlDOMItem)
  private
    fTextItemList: TLlDOMTextItemList;
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetTextItemList: TLlDOMTextItemList;
  public
    property Visible: TString read GetVisible write SetVisible;
    property list: TLlDOMTextItemList read GetTextItemList;
    destructor Destroy; override;
  End;

  TLlDOMPropertyTextItemBackground = class(TLlDOMItem)
  private
    fBitmap: TLlDOMPropertyBitmap;
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetColor2: TString;
    procedure SetColor2(const value: TString);
    function GetColor3: TString;
    procedure SetColor3(const value: TString);
    function GetPattern: TString;
    procedure SetPattern(const value: TString);
    function GetBitmap: TLlDOMPropertyBitmap;
  public
    property Style: TString read GetStyle write SetStyle;
    property Color: TString read GetColor write SetColor;
    property Color2: TString read GetColor2 write SetColor2;
    property Color3: TString read GetColor3 write SetColor3;
    property Pattern: TString read GetPattern write SetPattern;
    property Bitmap: TLlDOMPropertyBitmap read GetBitmap;
    destructor Destroy; override;
  end;

  TLlDOMPropertySignalItem = class(TLlDOMItem)
  private
    function GetMax: TString;
    procedure SetMax(const value: TString);
    function GetMaxColor: TString;
    procedure SetMaxColor(const value: TString);
    function GetMin: TString;
    procedure SetMin(const value: TString);
    function GetMinColor: TString;
    procedure SetMinColor(const value: TString);
  public
    property Max: TString read GetMax write SetMax;
    property MaxColor: TString read GetMaxColor write SetMaxColor;
    property Min: TString read GetMin write SetMin;
    property MinColor: TString read GetMinColor write SetMinColor;
  end;

  TLlDOMPropertyTextItem = class(TLlDOMItem)
  private
    fBackground: TLlDOMPropertyTextItemBackground;
    fFont: TLlDOMPropertyFont;
    fPosition: TLlDOMPropertyPosition;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetBackground: TLlDOMPropertyTextItemBackground;
    function GetFont: TLlDOMPropertyFont;
    function GetPosition: TLlDOMPropertyPosition;
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetRotation: TString;
    procedure SetRotation(const value: TString);
    function GetSize: TString;
    procedure SetSize(const value: TString);
  public
    property Background: TLlDOMPropertyTextItemBackground read GetBackground;
    property Condition: TString read GetCondition write SetCondition;
    property Contents: TString read GetContents write SetContents;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Position: TLlDOMPropertyPosition read GetPosition;
    property Rotation: TString read GetRotation write SetRotation;
    property Size: TString read GetSize write SetSize;
    constructor Create(list: TLlDOMTextItemList); overload;
    destructor Destroy; override;
  End;

  TLlDOMSignalItemList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertySignalItem;
    procedure SetItems(index: integer; const value: TLlDOMPropertySignalItem);
    function AddSignalItem(domObj: TLlDOMPropertySignalItem): integer;
  public
    function Add(domObj: TLlDOMPropertySignalItem): integer;
    property Items[index: integer]: TLlDOMPropertySignalItem read GetItems
      write SetItems;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMPropertyStartValue = class(TLlDOMItem)
  private
    function GetAutomatic: TString;
    procedure SetAutomatic(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property Automatic: TString read GetAutomatic write SetAutomatic;
    property value: TString read GetValue write SetValue;
  end;

  TLlDOMPropertySignalRanges = class(TLlDOMItem)
  private
    fSignalItemList: TLlDOMSignalItemList;
    fDisplayRange: TLlDOMPropertyDisplayRange;
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetDisplayRange: TLlDOMPropertyDisplayRange;
    function GetSignalItemList: TLlDOMSignalItemList;
  public
    property Visible: TString read GetVisible write SetVisible;
    property DisplayRange: TLlDOMPropertyDisplayRange read GetDisplayRange;
    property list: TLlDOMSignalItemList read GetSignalItemList;
    destructor Destroy; override;
  end;

  TLlDOMTextItemList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertyTextItem;
    procedure SetItems(index: integer; const value: TLlDOMPropertyTextItem);
    function AddTextItem(domObj: TLlDOMPropertyTextItem): integer;
  public
    function Add(domObj: TLlDOMPropertyTextItem): integer;
    property Items[index: integer]: TLlDOMPropertyTextItem read GetItems
      write SetItems;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartConditionalColor = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property Formula: TString read GetFormula write SetFormula;
  end;

  TLlDOMPropertyGradient = class(TLlDOMItem)
  private
    function GetIntensity: TString;
    procedure SetIntensity(const value: TString);
    function GetElevatedBorder: TString;
    procedure SetElevatedBorder(const value: TString);
  public
    property ElevatedBorder: TString read GetElevatedBorder
      write SetElevatedBorder;
    property Intensity: TString read GetIntensity write SetIntensity;
  end;

  TLlDOMPropertyChartLabelCoordinateOnObject = class(TLlDOMItem)
  private
    fFilling: TLlDOMPropertyFilling;
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetPlacement: TString;
    procedure SetPlacement(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
  public
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Font: TLlDOMPropertyFont read GetFont;
    property Formula: TString read GetFormula write SetFormula;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Placement: TString read GetPlacement write SetPlacement;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartLabelCoordinateOnObjectPie = class(TLlDOMItem)
  private
    fFilling: TLlDOMPropertyFilling;
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetPlacement: TString;
    procedure SetPlacement(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Font: TLlDOMPropertyFont read GetFont;
    property Formula: TString read GetFormula write SetFormula;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Placement: TString read GetPlacement write SetPlacement;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisPie3D = class(TLlDOMItem)
  private
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObjectPie;
    function GetAggregateType: TString;
    procedure SetAggregateType(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetExplosionPercentage: TString;
    procedure SetExplosionPercentage(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
  public
    property AggregateType: TString read GetAggregateType
      write SetAggregateType;
    property CoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie
      read GetCoordinateLabelOnObject;
    property ExplosionPercentage: TString read GetExplosionPercentage
      write SetExplosionPercentage;
    property value: TString read GetValue write SetValue;
    property Width: TString read GetWidth write SetWidth;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisPie3DArray = class(TLlDOMItem)
  private
    fValueAxisPie3D: TLlDOMPropertyValueAxisPie3D;
    function GetValueAxisPie3D(index: integer): TLlDOMPropertyValueAxisPie3D;
  public
    property ValueAxisPie3D[index: integer]: TLlDOMPropertyValueAxisPie3D
      read GetValueAxisPie3D; default;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisBaseMinimal  = class(TLlDOMItem)
    private
      function GetValue: TString;
      procedure SetValue(const value: TString);
      function GetSourceMode: TString;
      procedure SetSourceMode(const value: TString);
    public
      property Value: TString read GetValue write SetValue;
      property SourceMode: TString read GetSourceMode write SetSourceMode;
  end;

  TLlDOMPropertyValueAxisBase = class(TLlDOMPropertyValueAxisBaseMinimal)
  private
    fZebraPattern: TLlDOMPropertyFilling;
    fCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject;
    fGridLines: TLlDOMPropertyGridLines;
    fAxisLabel: TLlDOMPropertyChartLabel;
    fGetSignalRanges: TLlDOMPropertyGetSignalRanges;
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;

    function GetIntermediateTickCount: TString;
    procedure SetIntermediateTickCount(const value: TString);
    function GetCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObject;
    function GetGridLines: TLlDOMPropertyGridLines;
    function GetAxisLabel: TLlDOMPropertyChartLabel;
    function GetZebraPattern: TLlDOMPropertyFilling;

    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetGetSignalRanges: TLlDOMPropertyGetSignalRanges;
    function GetBubbleChartMode: TString;
    procedure SetBubbleChartMode(const value: TString);
    function GetTickmarkColor: TString;
    procedure SetTickmarkColor(const value: TString);
    function GetFilterZeroes: TString;
    function GetNullValueHandling: TString;
    procedure SetFilterZeroes(const Value: TString);
    procedure SetNullValueHandling(const Value: TString);

  public
    property BubbleChartMode: TString read GetBubbleChartMode
      write SetBubbleChartMode;
    property CoordinateLabel: TLlDOMPropertyChartLabelCoordinate
      read GetCoordinateLabel;
    property CoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject
      read GetCoordinateLabelOnObject;
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;
    property GridLines: TLlDOMPropertyGridLines read GetGridLines;
    property AxisLabel: TLlDOMPropertyChartLabel read GetAxisLabel;
    property IntermediateTickCount: TString read GetIntermediateTickCount
      write SetIntermediateTickCount;
    property ZebraPattern: TLlDOMPropertyFilling read GetZebraPattern;
    property GetSignalRanges: TLlDOMPropertyGetSignalRanges
      read GetGetSignalRanges;
    property TickmarkColor: TString read GetTickmarkColor
      write SetTickmarkColor;
    property NullValueHandling: TString read GetNullValueHandling
      write SetNullValueHandling;
    property FilterZeroes: TString read GetFilterZeroes
      write SetFilterZeroes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxis = class(TLlDOMPropertyValueAxisBase)
  private
    fMax: TLlDOMPropertyRange;
    fMin: TLlDOMPropertyRange;
    fSignalRanges: TLlDOMPropertySignalRanges;
    fVisual: TLlDOMPropertyVisual;
    function GetSignalRanges: TLlDOMPropertySignalRanges;
    function GetAggregateType: TString;
    procedure SetAggregateType(const value: TString);
    function GetAxisScale: TString;
    procedure SetAxisScale(const value: TString);
    function GetVisual: TLlDOMPropertyVisual;
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetMax: TLlDOMPropertyRange;
    function GetMin: TLlDOMPropertyRange;
    function GetVisualSym: TString;
    procedure SetVisualSym(const value: TString);
  public
  property SignalRanges: TLlDOMPropertySignalRanges read GetSignalRanges;
    property VisualSym: TString read GetVisualSym write SetVisualSym;
    property AxisScale: TString read GetAxisScale write SetAxisScale;
    property AggregateType: TString read GetAggregateType
      write SetAggregateType;
    property Max: TLlDOMPropertyRange read GetMax;
    property Min: TLlDOMPropertyRange read GetMin;

    property Visual: TLlDOMPropertyVisual read GetVisual;
    property Width: TString read GetWidth write SetWidth;

    destructor Destroy; override;
  end;

  TLlDOMPropertyBubbleDesign = class(TLlDOMItem)
  private
    fFileinfo: TLlDOMPropertyFileInfo;

    function GetDesignMode: TString;
    procedure SetDesignMode(const value: TString);
    function GetFileinfo: TLlDOMPropertyFileInfo;
    function GetSizeFactor: TString;
    procedure SetSizeFactor(const value: TString);
  public
    property DesignMode: TString read GetDesignMode write SetDesignMode;
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    property SizeFactor: TString read GetSizeFactor write SetSizeFactor;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisBubbleChartSorted = class(TLlDOMPropertyValueAxisBase)
  private
    fBubbleDesign: TLlDOMPropertyBubbleDesign;
    function GetBubbleSize: TString;
    procedure SetBubbleSize(const value: TString);
    function GetBubbleDesign: TLlDOMPropertyBubbleDesign;
  public
    property BubbleSize: TString read GetBubbleSize write SetBubbleSize;
    property BubbleDesign: TLlDOMPropertyBubbleDesign read GetBubbleDesign;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisBubbleChartScattered = class
    (TLlDOMPropertyValueAxisBase)
  private
    fMax: TLlDOMPropertyRange;
    fMin: TLlDOMPropertyRange;
    fBubbleDesign: TLlDOMPropertyBubbleDesign;
    function GetBubbleDesign: TLlDOMPropertyBubbleDesign;
    function GetBubbleSize: TString;
    procedure SetBubbleSize(const value: TString);
    function GetMax: TLlDOMPropertyRange;
    function GetMin: TLlDOMPropertyRange;
    function GetAxisScale: TString;
    procedure SetAxisScale(const value: TString);
  public
    destructor Destroy; override;
    property BubbleSize: TString read GetBubbleSize write SetBubbleSize;
    property BubbleDesign: TLlDOMPropertyBubbleDesign read GetBubbleDesign;
    property Max: TLlDOMPropertyRange read GetMax;
    property Min: TLlDOMPropertyRange read GetMin;
    property AxisScale: TString read GetAxisScale write SetAxisScale;
  end;

  TLlDOMPropertyValueAxisArrayLine = class(TLlDOMItem)
  private
  fValueAxis: array [0 .. 1] of TLlDOMPropertyValueAxis;
    function GetValueAxis(index: integer): TLlDOMPropertyValueAxis;
  public
    property ValueAxis[index: integer]: TLlDOMPropertyValueAxis
      read GetValueAxis; default;

    destructor Destroy; override;

  end;

  TLlDOMPropertyValueAxisArray = class(TLlDOMItem)
  private
    fValueAxis: array [0 .. 1] of TLlDOMPropertyValueAxisBase;
    function GetValueAxis(index: integer): TLlDOMPropertyValueAxisBase;
  public
    property ValueAxis[index: integer]: TLlDOMPropertyValueAxisBase
      read GetValueAxis; default;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisPie2D = class(TLlDOMItem)
  private
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObjectPie;
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
    function GetAggregateType: TString;
    procedure SetAggregateType(const value: TString);
    function GetExplosionPercentage: TString;
    procedure SetExplosionPercentage(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property AggregateType: TString read GetAggregateType
      write SetAggregateType;
    property CoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie
      read GetCoordinateLabelOnObject;
    property ExplosionPercentage: TString read GetExplosionPercentage
      write SetExplosionPercentage;
    property value: TString read GetValue write SetValue;

    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisPie2DArray = class(TLlDOMItem)
  private
    fValueAxisPie2D: TLlDOMPropertyValueAxisPie2D;
    function GetValueAxisPie2D(index: integer): TLlDOMPropertyValueAxisPie2D;
  public
    property ValueAxisPie2D[index: integer]: TLlDOMPropertyValueAxisPie2D
      read GetValueAxisPie2D; default;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartColor = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
  end;

  TLlDOMPropertyChartColorArray = class(TLlDOMItem)
  private
    fColors: array [0 .. 11] of TLlDOMPropertyChartColor;
    function GetColors(index: integer): TLlDOMPropertyChartColor;
    function GetEnhancedColorContrast: TString;
    procedure SetEnhancedColorContrast(const value: TString);
  public
    property Colors[index: integer]: TLlDOMPropertyChartColor read GetColors;
    property EnhancedColorContrast: TString read GetEnhancedColorContrast
      write SetEnhancedColorContrast;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCoordinateLabelPlacement = class(TLlDOMItem)
  private
    fFrame: TLlDOMPropertyFrame;
    function GetPlacement: TString;
    procedure SetPlacement(const value: TString);
    function GetEquidistant: TString;
    procedure SetEquidistant(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;

  public
    property Placement: TString read GetPlacement write SetPlacement;
    property Equidistant: TString read GetEquidistant write SetEquidistant;
    property Frame: TLlDOMPropertyFrame read GetFrame;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartLabelCoordinateOthers = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;
    procedure SetContent(const value: TString);
    function GetContent: TString;
    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Contents: TString read GetContent write SetContent;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartLabelPie = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetFixedFontSize: TString;
    procedure SetFixedFontSize(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property FixedFontSize: TString read GetFixedFontSize
      write SetFixedFontSize;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartLabel = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetRotation: TString;
    procedure SetRotation(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property Contents: TString read GetContents write SetContents;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Rotation: TString read GetRotation write SetRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartLabelCoordinate = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetFixedFontSize: TString;
    procedure SetFixedFontSize(const value: TString);
    function GetRotation: TString;
    procedure SetRotation(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property Contents: TString read GetContents write SetContents;
    property FixedFontSize: TString read GetFixedFontSize
      write SetFixedFontSize;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
    property Rotation: TString read GetRotation write SetRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisBase = class(TLlDOMItem)
  private
    fCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    fChartRowList: TLlDOMChartRowList;
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;
    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetSamplesForDesigner: TString;
    procedure SetSamplesForDesigner(const value: TString);
    function GetCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;

    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
    function GetChartRowList: TLlDOMChartRowList;
    function GetSourceMode: TString;
    procedure SetSourceMode(const value: TString);
  public
    property SourceMode: TString read GetSourceMode write SetSourceMode;
    property CoordinateLabel: TLlDOMPropertyChartLabelCoordinate
      read GetCoordinateLabel;
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;

    property Filter: TString read GetFilter write SetFilter;
    property SamplesForDesigner: TString read GetSamplesForDesigner
      write SetSamplesForDesigner;
    property value: TString read GetValue write SetValue;
    property Rows: TLlDOMChartRowList read GetChartRowList;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBase = class(TLlDOMItem)
  private
    function GetLabelAlignment: TString;
    procedure SetLabelAlignment(const value: TString);
    function GetChartType: TString;
    procedure SetChartType(const value: TString);
    function GetDataMode: TString;
    procedure SetDataMode(const value: TString);
    function GetFlat: TString;
    procedure SetFlat(const value: TString);
    function GetFrameColor: TString;
    procedure SetFrameColor(const value: TString);
    function GetSubTypeIndex: TString;
    procedure SetSubTypeIndex(const value: TString);
    property SubTypeIndex: TString read GetSubTypeIndex write SetSubTypeIndex;
  public
    property LabelAlignment: TString read GetLabelAlignment write SetLabelAlignment;
    property ChartType: TString read GetChartType write SetChartType;
    property DataMode: TString read GetDataMode write SetDataMode;
    property Flat: TString read GetFlat write SetFlat;
    property FrameColor: TString read GetFrameColor write SetFrameColor;

  end;

  TLlDOMPropertyValueAxisTreeMap = class (TLlDOMPropertyValueAxisBaseMinimal)
  private
    fDrillDownLinks: TLlDOMDrillDownLinkList;
    fGridLines: TLlDOMPropertyGridLines;
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject;
    fVisual: TLlDOMPropertyVisual;
    function GetDrillDownLinks: TLlDOMDrillDownLinkList;
    function GetCoordinateLabelOnObject : TLlDOMPropertyChartLabelCoordinateOnObject;
    function GetGridLines: TLlDOMPropertyGridLines;
    function GetFixedColorGroup : TString;
    function GetVisual : TLlDOMPropertyVisual;
    procedure SetFixedColorGroup(const value: TString);

	public
    property DrillDownLinks: TLlDOMDrillDownLinkList read GetDrillDownLinks;
    property GridLines: TLlDOMPropertyGridLines read GetGridLines;
    property CoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject
      read GetCoordinateLabelOnObject;
    property FixedColorGroup : TString read GetFixedColorGroup write SetFixedColorGroup;
    property Visual : TLlDOMPropertyVisual read GetVisual;
    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisArrayTreeMap = class (TLlDOMItem)
  private
    fValueAxis: TLlDOMPropertyValueAxisTreeMap;
    function GetValueAxis(index: integer): TLlDOMPropertyValueAxisTreeMap;
  public
    property ValueAxis[index: integer]: TLlDOMPropertyValueAxisTreeMap
      read GetValueAxis; default;

    destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisYTreeMap = class (TLlDOMPropertyCategoryAxisBase)
    private
      fGridLines: TLlDOMPropertyGridLines;
      fMaxEntryCount: TLlDOMPropertyMaxEntryCount;
      fChartRowList: TLlDOMChartRowList;
      function GetChartRowList: TLlDOMChartRowList;
	    function GetMaxEntryCount: TLlDOMPropertyMaxEntryCount;
      function GetGridLines: TLlDOMPropertyGridLines;
    public
      property GridLines: TLlDOMPropertyGridLines read GetGridLines;
      property MaxEntryCount: TLlDOMPropertyMaxEntryCount read GetMaxEntryCount;
      property Rows: TLlDOMChartRowList read GetChartRowList;
      destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisXTreeMap = class (TLlDOMPropertyCategoryAxisBase)
  private
    fMaxEntryCount: TLlDOMPropertyMaxEntryCount;
    function GetMaxEntryCount : TLlDOMPropertyMaxEntryCount;
    function GetRoundLimits: TString;
    //hidden property
{$Hints Off}
    property RoundLimits: TString read GetRoundLimits;
{$Hints On}
    function GetFixedColorGroup: TString;
    procedure SetFixedColorGroup(const value: TString);

  public
     property MaxEntryCount: TLlDOMPropertyMaxEntryCount read GetMaxEntryCount;
     property FixedColorGroup: TString read GetFixedColorGroup write SetFixedColorGroup;
     destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineTreeMapBase  = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling:  TLlDOMPropertyFilling;
    fXAxis:    TLlDOMPropertyCategoryAxisXTreeMap;
    function   GetFilling: TLlDOMPropertyFilling;
    function   GetXAxis: TLlDOMPropertyCategoryAxisXTreeMap;
    function   GetTreemapAlgorithm: TString;
    function   GetTreemapLightFactor: TString;
    procedure  SetTreemapAlgorithm(const value: TString);
    procedure  SetTreemapLightFactor(const value: TString);
  public
    property TreemapAlgorithm: TString read GetTreemapAlgorithm write SetTreemapAlgorithm;
    property TreemapLightFactor: TString read GetTreemapLightFactor write SetTreemapLightFactor;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property XAxis: TLlDOMPropertyCategoryAxisXTreeMap read GetXAxis;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineTreeMapSingle = class(TLlDOMPropertyChartEngineTreeMapBase)
  private
    fYAxes: TLlDOMPropertyValueAxisArrayTreeMap;
    function GetYAxes: TLlDOMPropertyValueAxisArrayTreeMap;
  public
    property YAxes: TLlDOMPropertyValueAxisArrayTreeMap read GetYAxes;
     destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineTreeMapClustered = class (TLlDOMPropertyChartEngineTreeMapBase)
  private
    fYAxis:    TLlDOMPropertyCategoryAxisYTreeMap;
    fZAxes: TLlDOMPropertyValueAxisArrayTreeMap;
    function GetZAxes: TLlDOMPropertyValueAxisArrayTreeMap;
    function   GetYAxis: TLlDOMPropertyCategoryAxisYTreeMap;
  public
    property YAxis: TLlDOMPropertyCategoryAxisYTreeMap read GetYAxis;
    property ZAxis: TLlDOMPropertyValueAxisArrayTreeMap read GetZAxes;
    destructor Destroy; override;
  end;

    TLlDOMPropertyChartEngineRadarBase = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling:  TLlDOMPropertyFilling;
    fXAxis:    TLlDOMPropertyCategoryAxisXRadar;
    function   GetRadarCenterMinimumValue: TString;
    procedure  SetRadarCenterMinimumValue(const value: TString);
    function   GetRadarCircularMode: TString;
    procedure  SetRadarCircularMode(const value: TString);
    function   GetRadarForceAutoZeroValues: TString;
    procedure  SetRadarForceAutoZeroValues(const value: TString);
    function   GetRadarForceCentered: TString;
    procedure  SetRadarForceCentered(const value: TString);
    function   GetRadarRotateClockwise: TString;
    procedure  SetRadarRotateClockwise(const value: TString);
    function   GetRadarRotationDelta: TString;
    procedure  SetRadarRotationDelta(const value: TString);
    function   GetFilling: TLlDOMPropertyFilling;
    function   GetXAxis: TLlDOMPropertyCategoryAxisXRadar;

  public
    property RadarCenterMinimumValue: TString read GetRadarCenterMinimumValue
        write SetRadarCenterMinimumValue;
    property RadarCircularMode: TString read GetRadarCircularMode write SetRadarCircularMode;
    property RadarForceAutoZeroValues: TString read GetRadarForceAutoZeroValues
        write SetRadarForceAutoZeroValues;
    property RadarForceCentered: TString read GetRadarForceCentered write SetRadarForceCentered;
    property RadarRotateClockwise: TString read GetRadarRotateClockwise write SetRadarRotateClockwise;
    property RadarRotationDelta: TString read GetRadarRotationDelta write SetRadarRotationDelta;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property XAxis: TLlDOMPropertyCategoryAxisXRadar read GetXAxis;
     destructor Destroy; override;

  end;
  {/RScript Chart}
  TLlDOMPropertyRScriptCommonVarExport = class(TLlDOMItem)
  private
    function GetRScriptCommonChartColors: TString;
    function GetRScriptCommonExtents: TString;
    function GetRScriptCommonNamedColors: TString;
    function GetRScriptCommonSchemeColors: TString;
    procedure SetRScriptCommonChartColors(const value: TString);
    procedure SetRScriptCommonExtents(const value: TString);
    procedure SetRScriptCommonNamedColors(const value: TString);
    procedure SetRScriptCommonSchemeColors(const value: TString);
  public
    property RScriptCommonChartColors: TString read GetRScriptCommonChartColors write SetRScriptCommonChartColors;
    property RScriptCommonExtents: TString read GetRScriptCommonExtents write SetRScriptCommonExtents;
    property RScriptCommonNamedColors: TString read GetRScriptCommonNamedColors write SetRScriptCommonNamedColors;
    property RScriptCommonSchemeColors: TString read GetRScriptCommonSchemeColors write SetRScriptCommonSchemeColors;
  end;


  TLlDOMPropertyRScriptDataEntryItem = class(TLlDOMItem)
  private
    function GetEnabled: TString;
    function GetFormula: TString;
    function GetPrefix: TString;
    function GetPrefixType: TString;
    function GetVarName: TString;
    procedure SetEnabled(const value: TString);
    procedure SetFormula(const value: TString);
    procedure SetPrefix(const value: TString);
    procedure SetPrefixType(const value: TString);
    procedure SetVarname(const value: TString);

  public
    property Enabled: TString read GetEnabled write SetEnabled;
    property Formula: TString read GetFormula write SetFormula;
    property Prefix: TString read GetPrefix write SetPrefix;
    property PrefixType: TString read GetPrefixType write SetPrefixType;
    property VarName: TString read GetVarName write SetVarname;

  end;
  TLlDOMRScriptEntryItemsList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMPropertyRScriptDataEntryItem;
		procedure SetItems(index: integer; const value: TLlDOMPropertyRScriptDataEntryItem);
		function Add(domObj: TLlDOMPropertyRScriptDataEntryItem): integer;
  public
    property Items[Index: integer]: TLlDOMPropertyRScriptDataEntryItem read GetItems write SetItems; default;
		constructor Create(hDomObj: TLlDOMItem);
		destructor Destroy; override;
		function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMPropertyRScriptData = class(TLlDOMItem)
  private
    fRScriptEntryItems: TLlDOMRScriptEntryItemsList;
    function GetRScriptEntryItemsList : TLlDOMRScriptEntryItemsList;
    function GetRSCode: TString;
    procedure SetRSCode(const value: TString);
  public
    property RSCode: TString read GetRSCode write SetRSCode;
    property Entries: TLlDOMRScriptEntryItemsList read GetRScriptEntryItemsList;
    destructor Destroy; override;
  end;

  TLlDOMPropertyRScriptOutputExtension = class(TLlDOMItem)
  private
    function GetContents: TString;
    function GetRScriptOOPointsize: TString;
    function GetRScrptOORes: TString;
    procedure SetContents(const value: TString);
    procedure SetRScriptOOPointsize(const value: TString);
    procedure SetRscriptOORes(const value: TString);

  public
    property Contents: TString read GetContents write SetContents;
    property RScriptOOPointsize: TString read GetRScriptOOPointsize write SetRScriptOOPointsize;
    property RscriptOORes: TString read GetRScrptOORes write SetRscriptOORes;

  end;

  TLlDOMPropertyChartEngineRscript = class(TLlDOMPropertyChartEngineBase)
  private
    fRScriptData: TLlDOMPropertyRScriptData;
    fRScriptOutputExtension: TLlDOMPropertyRScriptOutputExtension;
    fRScriptCommonVarExport: TLlDOMPropertyRScriptCommonVarExport;
    function GetDataSamplesForDesigner: TString;
    function GetRScriptTimeoutMS: TString;
    function GetRScriptEnableRealtimePreview: TString;
    function GetRScriptData: TLlDOMPropertyRScriptData;
    function GetRScriptOutputExtension: TLlDOMPropertyRScriptOutputExtension;
    function GetRScriptCommonVarExport: TLlDOMPropertyRScriptCommonVarExport;
    procedure SetDataSamplesForDesigner(const value: TString);
    procedure SetRScriptTimeoutMS(const value: TString);
    procedure SetRScriptEnableRealtimePreview(const value: TString);
  public
    property DataSamplesForDesigner: TString read GetDataSamplesForDesigner write SetDataSamplesForDesigner;
    property RScriptTimeoutMS: TString read GetRScriptTimeoutMS write SetRScriptTimeoutMS;
    property RScriptEnableRealtimePreview: TString read GetRScriptEnableRealtimePreview write SetRScriptEnableRealtimePreview;
    property RScriptData: TLlDOMPropertyRScriptData read GetRScriptData;
    property RScriptOutputExtension: TLlDOMPropertyRScriptOutputExtension read GetRScriptOutputExtension;
    property RScriptCommonVarExport: TLlDOMPropertyRScriptCommonVarExport read GetRScriptCommonVarExport;
     destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineRadar = class(TLlDOMPropertyChartEngineRadarBase)
  private
    fYAxis: TLlDOMPropertyCategoryAxisYRadar;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetYAxis: TLlDOMPropertyCategoryAxisYRadar;
    function GetZAxes: TLlDOMPropertyValueAxisArray;

  public
    property YAxis:   TLlDOMPropertyCategoryAxisYRadar read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;
     destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineRadarSimple = class(TLlDOMPropertyChartEngineRadarBase)
  private
    fYAxes: TLlDOMPropertyValueAxisArray;
    function GetYAxes: TLlDOMPropertyValueAxisArray;
  public
    property YAxes: TLlDOMPropertyValueAxisArray read GetYAxes;
     destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineRadarStacked = class(TLlDOMPropertyChartEngineRadar)

  end;

  TLlDOMPropertyChartEngineRadarStackedRelative = class(TLlDOMPropertyChartEngineRadar)

  end;

  TLlDOMPropertyChartEngineRadarClustered = class(TLlDOMPropertyChartEngineRadar)

  end;


  TLlDOMPropertyCategoryAxis = class(TLlDOMPropertyCategoryAxisBase)
  private
    fGridLines: TLlDOMPropertyGridLines;
    fAxisLabel: TLlDOMPropertyChartLabel;
    function GetAxisLabel: TLlDOMPropertyChartLabel;
    function GetGridLines: TLlDOMPropertyGridLines;
    function GetSorted: TString;
    procedure SetSorted(const value: TString);
    function GetIntermediateTickCount: TString;
    procedure SetIntermediateTickCount(const value: TString);
    function GetTickmarkColor: TString;
    procedure SetTickmarkColor(const value: TString);

  public
    property TickmarkColor: TString read GetTickmarkColor write SetTickmarkColor;
    property AxisLabel: TLlDOMPropertyChartLabel read GetAxisLabel;
    property Sorted: TString read GetSorted write SetSorted;
    property IntermediateTickCount: TString read GetIntermediateTickCount
      write SetIntermediateTickCount;
    property GridLines: TLlDOMPropertyGridLines read GetGridLines;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisX = class(TLlDOMPropertyCategoryAxis)

  end;

  TLlDOMPropertyCategoryAxisY = class(TLlDOMPropertyCategoryAxis)

  end;

  TLlDOMPropertyCategoryAxisXRadar = class(TLlDOMPropertyCategoryAxisBase)
  private
   fGridLines: TLlDOMPropertyGridLines;
    function GetTickmarkColor: TString;
    procedure SetTickmarkColor(const value: TString);
    function GetGridLines: TLlDOMPropertyGridLines;
  public
    property TickmarkColor: TString read GetTickmarkColor write SetTickmarkColor;
    property GridLines: TLlDOMPropertyGridLines read GetGridLines;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisYRadar = class(TLlDOMPropertyCategoryAxisBase)
    private
      function GetSorted: TString;
      procedure SetSorted(const value: TString);
    public
      property Sorted: TString read GetSorted write SetSorted;

  end;


  TLlDOMPropertyCategoryAxisPie = class(TLlDOMItem)
  private
    fCoordinateLabelOthers: TLlDOMPropertyChartLabelCoordinateOthers;
    fCoordinateLabelPie: TLlDOMPropertyChartLabelPie;
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;
    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetMinimumPercentage: TString;
    procedure SetMinimumPercentage(const value: TString);
	function GetMaxEntriesForArcs: TString;
    procedure SetMaxEntriesForArcs(const value: TString);
    function GetSamplesForDesigner: TString;
    procedure SetSamplesForDesigner(const value: TString);
    function GetSorted: TString;
    procedure SetSorted(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetCoordinateLabelOthers: TLlDOMPropertyChartLabelCoordinateOthers;
    function GetCoordinateLabelPie: TLlDOMPropertyChartLabelPie;
  public
	property MaxEntriesForArcs: TString read GetMaxEntriesForArcs write SetMaxEntriesForArcs;
    property CoordinateLabelOthers: TLlDOMPropertyChartLabelCoordinateOthers
      read GetCoordinateLabelOthers;
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;
    property CoordinateLabelPie: TLlDOMPropertyChartLabelPie
      read GetCoordinateLabelPie;
    property MinimumPercentage: TString read GetMinimumPercentage
      write SetMinimumPercentage;
    property SamplesForDesigner: TString read GetSamplesForDesigner
      write SetSamplesForDesigner;
    property Sorted: TString read GetSorted write SetSorted;
    property value: TString read GetValue write SetValue;
    destructor Destroy; override;
  end;

  { Funnel Property classes }
  TLlDOMPropertyRelativeRadiusOfParallelPart = class(TLlDOMItem)
  private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetPercentageOfParallelPart: TString;
    procedure SetPercentageOfParallelPart(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property PercentageOfParallelPart: TString read GetPercentageOfParallelPart
      write SetPercentageOfParallelPart;
  end;

  TLlDOMPropertyValueAxisFunnelArray = class(TLlDOMItem)
  private
    fValueAxisFunnel: TLlDOMPropertyValueAxisFunnel;
    function GetValueAxisFunnel(index: integer): TLlDOMPropertyValueAxisFunnel;
  public
    property ValueAxisFunnel[index: integer]: TLlDOMPropertyValueAxisFunnel
      read GetValueAxisFunnel; default;
    destructor Destroy; override;
  end;

  TLlDOMPropertyValueAxisFunnel = class(TLlDOMItem)
  private
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObjectPie;
    procedure SetExplosionPercentage(const value: TString);
    function GetExplosionPercentage: TString;
    procedure SetValue(const value: TString);
    function GetValue: TString;
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
  public
    property CoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObjectPie
      read GetCoordinateLabelOnObject;
    property ExplosionPercentage: TString read GetExplosionPercentage
      write SetExplosionPercentage;
    property value: TString read GetValue write SetValue;
    destructor Destroy; override;
  end;

  TLlDOMPropertyCategoryAxisFunnel = class(TLlDOMItem)
  private
    fCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    fAxisLabel: TLlDOMPropertyChartLabel;
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;
    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    function GetAxisLabel: TLlDOMPropertyChartLabel;
    function GetValue: TString;
    procedure SetValue(const value: TString);
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
  public
    property CoordinateLabel: TLlDOMPropertyChartLabelCoordinate
      read GetCoordinateLabel;
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;
    property AxisLabel: TLlDOMPropertyChartLabel read GetAxisLabel;
    property Filter: TString read GetFilter write SetFilter;
    property value: TString read GetValue write SetValue;
    destructor Destroy; override;
  end;

  { /Funnel Property classes }

  { Collection Variables classes}
  TLlDOMListCollectionVariables = class(TlLDOMList)
	private
		function GetItems(index: integer): TLlDOMCollectionVariable;
		procedure SetItems(index: integer; const value: TLlDOMCollectionVariable);
		function Add(domObj: TLlDOMCollectionVariable): integer;

	public
		property Items[Index: integer]: TLlDOMCollectionVariable read GetItems write SetItems; default;
		constructor Create(hDomObj: TLlDOMItem);
		destructor Destroy; override;
		function NewItem(index: integer): TLlDOMItem;
		procedure DeleteSubobject(index: integer); override;
  end;

  TLlDOMCollectionVariable = class(TlLDOMItem)
	private
    fItems: TLlDOMListCollectionVariablesListItems;
    function GetItems: TLlDOMListCollectionVariablesListItems;
		function GetNamePrefix: TString;
		procedure SetNamePrefix(const value: TString);

	public
    property Items: TLlDOMListCollectionVariablesListItems read GetItems;
		property NamePrefix: TString read GetNamePrefix write SetNamePrefix;
    constructor Create(list: TLlDOMListCollectionVariables); overload;
    destructor Destroy; override;
  end;

  TLlDOMListCollectionVariablesListItems = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMCollectionVariableListItem;
    procedure SetItems(index: integer; const value: TLlDOMCollectionVariableListItem);
    function Add(domObj: TLlDOMCollectionVariableListItem): integer;
  public
    property Items[Index: integer]: TLlDOMCollectionVariableListItem
      read GetItems  write SetItems; default;
     constructor Create(hDomObj: TLlDOMItem);
     destructor Destroy; override;
     function NewItem(index: integer): TLlDOMItem;
     procedure DeleteSubobject(index: integer); override;
  end;

  TLlDOMCollectionVariableListItem = class(TLlDOMItem)
  private
    fItems: TLlDOMListCollectionVariableColumns;
    function GetItems: TLlDOMListCollectionVariableColumns;
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
  public
    property Condition: TString read GetCondition write SetCondition;
    property Items: TLlDOMListCollectionVariableColumns read GetItems;
    constructor Create(list: TLlDOMListCollectionVariablesListItems); overload;
    destructor Destroy; override;
  end;

  TLlDOMListCollectionVariableColumns = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDomCollectionVariableColumn;
    procedure SetItems(index: integer; const value: TLlDomCollectionVariableColumn);
    function Add(domObj: TLlDomCollectionVariableColumn): integer;
  public
    property Items[Index: integer]: TLlDomCollectionVariableColumn
      read GetItems  write SetItems; default;
     constructor Create(hDomObj: TLlDOMItem);
     destructor Destroy; override;
     function NewItem(index: integer): TLlDOMItem;
     procedure DeleteSubobject(index: integer); override;
  end;

  TLlDomCollectionVariableColumn = class(TLlDOMItem)
    private
      function GetNamePostfix: TString;
      procedure SetNamePostfix(const value: TString);
      function GetResult: TString;
      procedure SetResult(const value: TString);
    public
      property NamePostfix: TString read GetNamePostfix write SetNamePostfix;
      property Result: TString  read GetResult write SetResult;
      constructor Create(list: TLlDOMListCollectionVariableColumns); overload;
  end;

  {/ Collection Variables classes}

  { Shape chart classes }

  TLlDOMPropertyChartEngineShapeFile = class(TLlDOMPropertyChartEngineBase)
  private
    fXaxis: TLlDOMPropertyShapeXAxis;
    fYaxes: TLlDOMPropertyShapeAxisArray;
    fDefinition: TLlDOMPropertyShapeDefinition;
    function GetDefinition: TLlDOMPropertyShapeDefinition;
    function GetYAxes: TLlDOMPropertyShapeAxisArray;
    function GetXAxis: TLlDOMPropertyShapeXAxis;

  public
    property XAxis: TLlDOMPropertyShapeXAxis read GetXAxis;
    property Definition: TLlDOMPropertyShapeDefinition read GetDefinition;
    property YAxes: TLlDOMPropertyShapeAxisArray read GetYAxes;
    destructor Destroy; override;
  End;

  TLlDOMPropertyManualLegendItem = class(TLlDOMItem)
  private
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetText: TString;
    procedure SetText(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property Formula: TString read GetFormula write SetFormula;
    property Text: TString read GetText write SetText;
    constructor Create(list: TLlDOMPropertyManualLegendsList); overload;
  end;

  TLlDOMPropertyManualLegendsList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMPropertyManualLegendItem;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyManualLegendItem);
    function Add(domObj: TLlDOMPropertyManualLegendItem): integer;
  public
    property Items[index: integer]: TLlDOMPropertyManualLegendItem
      read GetItems write SetItems; default;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMPropertyShapeItemBase = class(TLlDOMItem)
  private
    fBackground: TLlDOMPropertyShapeBackground;
    fFrame: TLlDOMPropertyRectangleFrame;
    function GetRectangleFrame: TLlDOMPropertyRectangleFrame;
    function GetBackground: TLlDOMPropertyShapeBackground;
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetFileName: TString;
    procedure SetFileName(const value: TString);
    function GetName: TString;
    procedure SetName(const value: TString);

  public
    property Condition: TString read GetCondition write SetCondition;
    property FileName: TString read GetFileName write SetFileName;
    property Name: TString read GetName write SetName;
    property Background: TLlDOMPropertyShapeBackground read GetBackground;
    property Frame: TLlDOMPropertyRectangleFrame read GetRectangleFrame;
    destructor Destroy; override;
  End;

  TLlDOMPropertyShapeDefinition = class(TLlDOMItem)
  private
    fData: TLlDOMPropertyShapeDefinitionData;
    fForegroundShapes: TLlDOMForegroundShapesList;
    fBackgroundShapes: TLlDOMBackgroundShapesList;
    function GetBackgroundShapesList: TLlDOMBackgroundShapesList;
    function GetForegroundShapesList: TLlDOMForegroundShapesList;
    function GetData: TLlDOMPropertyShapeDefinitionData;
    function GetProjection: TString;
    procedure SetProjection(const value: TString);

  public
    property Projection: TString read GetProjection write SetProjection;
    property Data: TLlDOMPropertyShapeDefinitionData read GetData;
    property ForegroundShapes: TLlDOMForegroundShapesList
      read GetForegroundShapesList;
    property BackgroundShapes: TLlDOMBackgroundShapesList
      read GetBackgroundShapesList;
    destructor Destroy; override;
  End;

  TLlDOMPropertyShapeDefinitionData = class(TLlDOMPropertyShapeItemBase)
  private
    fBoundarySelection: TLlDOMPropertyShapeBoundarySelection;
    function GetBoundarySelection: TLlDOMPropertyShapeBoundarySelection;
    function GetCentered: TString;
    procedure SetCentered(const value: TString);
  public
    property Centered: TString read GetCentered write SetCentered;
    property BoundarySelection: TLlDOMPropertyShapeBoundarySelection
      read GetBoundarySelection;
    destructor Destroy; override;

  End;

  TLlDOMPropertyForegroundShapesItem = class(TLlDOMPropertyShapeItemBase)
  private
    function GetRestrictToDataRegion: TString;
    procedure SetRestrictToDataRegion(const value: TString);
  public
    property RestrictToDataRegion: TString read GetRestrictToDataRegion
      write SetRestrictToDataRegion;
    constructor Create(list: TLlDOMForegroundShapesList); overload;
  End;

  TLlDOMPropertyBackgroundShapesItem = class(TLlDOMPropertyShapeItemBase)
  private
    function GetOffset: TString;
    procedure SetOffset(const value: TString);
  public
    property Offset: TString read GetOffset write SetOffset;
    constructor Create(list: TLlDOMBackgroundShapesList); overload;
  End;

  TLlDOMForegroundShapesList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMPropertyForegroundShapesItem;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyForegroundShapesItem);
    function Add(domObj: TLlDOMPropertyForegroundShapesItem): integer;
  public
    property Items[index: integer]: TLlDOMPropertyForegroundShapesItem
      read GetItems write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  End;

  TLlDOMBackgroundShapesList = class(TLlDOMList)
  private
    procedure Initialize; override;
    function GetItems(index: integer): TLlDOMPropertyBackgroundShapesItem;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyBackgroundShapesItem);
    function Add(domObj: TLlDOMPropertyBackgroundShapesItem): integer;
  public
    property Items[index: integer]: TLlDOMPropertyBackgroundShapesItem
      read GetItems write SetItems; default;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  End;

  TLlDOMPropertyShapeBackground = class(TLlDOMItem)
  private
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
  public
    property Visible: TString read GetVisible write SetVisible;
    property Color: TString read GetColor write SetColor;
  End;

  TLlDOMPropertyRectangleFrame = class(TLlDOMItem)
  private
    function GetStyle: TString;
    procedure SetStyle(const value: TString);
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
  public
    property Style: TString read GetStyle write SetStyle;
    property Color: TString read GetColor write SetColor;
    property Width: TString read GetWidth write SetWidth;

  End;

  TLlDOMPropertyShapeBoundarySelection = class(TLlDOMItem)
  private
    fRect: TLlDOMPPropertyRectBase;
    function GetRect: TLlDOMPPropertyRectBase;
    function GetIsFormula: TString;
    procedure SetIsFormula(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);

  public
    property IsFormula: TString read GetIsFormula write SetIsFormula;
    property Formula: TString read GetFormula write SetFormula;
    property Rect: TLlDOMPPropertyRectBase read GetRect;
    destructor Destroy; override;
  End;

  TLlDOMPPropertyRectBase = class(TLlDOMItem)
  private
    function GetBottom: TString;
    procedure SetBottom(const value: TString);
    function GetLeft: TString;
    procedure SetLeft(const value: TString);
    function GetRight: TString;
    procedure SetRight(const value: TString);
    function GetTop: TString;
    procedure SetTop(const value: TString);

  public
    property Bottom: TString read GetBottom write SetBottom;
    property Left: TString read GetLeft write SetLeft;
    property Right: TString read GetRight write SetRight;
    property Top: TString read GetTop write SetTop;
  End;

  TLlDOMPropertyShapeXAxis = class(TLlDOMItem)
  private
    fLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement;
    fAxisLabel: TLlDOMPropertyChartLabel;
    fCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    function GetCoordinateLabel: TLlDOMPropertyChartLabelCoordinate;
    function GetCoordinateLabelPlacement
      : TLlDOMPropertyCoordinateLabelPlacement;
    function GetAxisLabel: TLlDOMPropertyChartLabel;
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
    function GetShapeAttribute: TString;
    procedure SetShapeAttribute(const value: TString);
    function GetValue: TString;
    procedure SetValue(const value: TString);

  public
    property CoordinateLabelPlacement: TLlDOMPropertyCoordinateLabelPlacement
      read GetCoordinateLabelPlacement;
    property AxisLabel: TLlDOMPropertyChartLabel read GetAxisLabel;
    property CoordinateLabel: TLlDOMPropertyChartLabelCoordinate
      read GetCoordinateLabel;
    property Filter: TString read GetFilter write SetFilter;
    property ShapeAttribute: TString read GetShapeAttribute
      write SetShapeAttribute;
    property value: TString read GetValue write SetValue;
    destructor Destroy; override;
  End;

  TLlDOMPropertyShapeYAxis = class(TLlDOMItem)
  private
    fCoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject;
    function GetCoordinateLabelOnObject
      : TLlDOMPropertyChartLabelCoordinateOnObject;
    function GetValue: TString;
    procedure SetValue(const value: TString);
  public
    property CoordinateLabelOnObject: TLlDOMPropertyChartLabelCoordinateOnObject
      read GetCoordinateLabelOnObject;
    property value: TString read GetValue write SetValue;
    destructor Destroy; override;
  End;

  TLlDOMPropertyShapeAxisArray = class(TLlDOMItem)
  private
    fValueAxis: TLlDOMPropertyShapeYAxis;
    function GetValueAxis(index: integer): TLlDOMPropertyShapeYAxis;
  public
    property ValueAxis[index: integer]: TLlDOMPropertyShapeYAxis
      read GetValueAxis; default;
    destructor Destroy; override;
  end;

  { /Shape chart classes }
  { Donut chart classes }
  TLlDOMPropertyChartEngineDonut = class(TLlDOMPropertyChartEngineBase)
  private
    fXaxis: TLlDOMPropertyCategoryAxisPie;
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetShowSeparatorLines: TString;
    procedure SetShowSeparatorLines(const value: TString);
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
    function GetCategoryAxisPie: TLlDOMPropertyCategoryAxisPie;
  public
    property Color: TString read GetColor write SetColor;
    property ShowSeparatorLines: TString read GetShowSeparatorLines
      write SetShowSeparatorLines;
    property ZRotation: TString read GetZRotation write SetZRotation;
    property XAxis: TLlDOMPropertyCategoryAxisPie read GetCategoryAxisPie;
    destructor Destroy; override;
  End;

  TLlDOMPropertyChartEngineDonut2D = class(TLlDOMPropertyChartEngineDonut)
  private
    fYAxis: TLlDOMPropertyValueAxisPie2DArray;
    function GetInnerRadiusPercentage: TString;
    procedure SetInnerRadiusPercentage(const value: TString);
    function GetValueAxisPie2DArray: TLlDOMPropertyValueAxisPie2DArray;
  public
    property InnerRadiusPercentage: TString read GetInnerRadiusPercentage
      write SetInnerRadiusPercentage;
    property YAxis: TLlDOMPropertyValueAxisPie2DArray
      read GetValueAxisPie2DArray;
    destructor Destroy; override;
  End;

  TLlDOMPropertyChartEngineDonut3D = class(TLlDOMPropertyChartEngineDonut)
  private
    fYAxis: TLlDOMPropertyValueAxisPie3DArray;
    function GetInnerRadiusPercentage: TString;
    procedure SetInnerRadiusPercentage(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetValueAxisPie3DArray: TLlDOMPropertyValueAxisPie3DArray;
  public
    property InnerRadiusPercentage: TString read GetInnerRadiusPercentage
      write SetInnerRadiusPercentage;
    property XRotation: TString read GetXRotation write SetXRotation;
    property YAxis: TLlDOMPropertyValueAxisPie3DArray
      read GetValueAxisPie3DArray;
    destructor Destroy; override;
  End;

  { /Donut chart classes }
  TLlDOMPropertyChartEnginePie2D = class(TLlDOMPropertyChartEngineBase)
  private
    fGradient: TLlDOMPropertyGradient;
    fYAxis: TLlDOMPropertyValueAxisPie2DArray;
    fXaxis: TLlDOMPropertyCategoryAxisPie;
    function GetGradient: TLlDOMPropertyGradient;
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
    function GetShowSeparatorLines: TString;
    procedure SetShowSeparatorLines(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetCategoryAxisPie: TLlDOMPropertyCategoryAxisPie;
    function GetValueAxisPie2DArray: TLlDOMPropertyValueAxisPie2DArray;
    function GetColorMode: TString;
    procedure SetColorMode(const value: TString);
  public
    property ColorMode: TString read GetColorMode write SetColorMode;
    property Gradient: TLlDOMPropertyGradient read GetGradient;
    property ShowSeparatorLines: TString read GetShowSeparatorLines
      write SetShowSeparatorLines;
    property XRotation: TString read GetXRotation write SetXRotation;
    property XAxis: TLlDOMPropertyCategoryAxisPie read GetCategoryAxisPie;
    property YAxis: TLlDOMPropertyValueAxisPie2DArray
      read GetValueAxisPie2DArray;
    property ZRotation: TString read GetZRotation write SetZRotation;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEnginePie3D = class(TLlDOMPropertyChartEngineBase)
  private
    fGradient: TLlDOMPropertyGradient;
    fYAxis: TLlDOMPropertyValueAxisPie3DArray;
    fXaxis: TLlDOMPropertyCategoryAxisPie;
    function GetGradient: TLlDOMPropertyGradient;
    function GetShowSeparatorLines: TString;
    procedure SetShowSeparatorLines(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
    function GetCategoryAxisPie: TLlDOMPropertyCategoryAxisPie;
    function GetValueAxisPie3DArray: TLlDOMPropertyValueAxisPie3DArray;
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetColorMode: TString;
    procedure SetColorMode(const value: TString);
  public
    property ColorMode: TString read GetColorMode write SetColorMode;
    property Gradient: TLlDOMPropertyGradient read GetGradient;
    property Perspective: TString read GetPerspective write SetPerspective;
    property ShowSeparatorLines: TString read GetShowSeparatorLines
      write SetShowSeparatorLines;
    property XRotation: TString read GetXRotation write SetXRotation;
    property XAxis: TLlDOMPropertyCategoryAxisPie read GetCategoryAxisPie;
    property YAxis: TLlDOMPropertyValueAxisPie3DArray
      read GetValueAxisPie3DArray;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineLineStackedRelative = class
    (TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineLineStacked = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineLineSimple = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYaxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxes: TLlDOMPropertyValueAxisArray;
    function GetLinearAxis: TString;
    procedure SetLinearAxis(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property LinearAxis: TString read GetLinearAxis write SetLinearAxis;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxes: TLlDOMPropertyValueAxisArray read GetYAxes;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineAreaSimple = class
    (TLlDOMPropertyChartEngineLineSimple)
  end;

  TLlDOMPropertyChartEngineAreaStacked = class
    (TLlDOMPropertyChartEngineLineStacked)
  end;

  TLlDOMPropertyChartEngineAreaStackedRelative = class
    (TLlDOMPropertyChartEngineLineStackedRelative)
  end;

  TLlDOMPropertyChartEngineBubbleSorted = class
    (TLlDOMPropertyChartEngineLineStackedRelative)
  end;

  TLlDOMPropertyChartEngineBubbleScattered = class
    (TLlDOMPropertyChartEngineLineStackedRelative)
  end;

  TLlDOMPropertyChartEngineLineMultiRow = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArrayLine;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArrayLine;
    function GetLinearAxis: TString;
    procedure SetLinearAxis(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property LinearAxis: TString read GetLinearAxis write SetLinearAxis;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArrayLine read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar3DStackedRelative = class
    (TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property Perspective: TString read GetPerspective write SetPerspective;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XRotation: TString read GetXRotation write SetXRotation;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar3DStacked = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property Perspective: TString read GetPerspective write SetPerspective;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XRotation: TString read GetXRotation write SetXRotation;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar3DMultiRow = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property Orientation: TString read GetOrientation write SetOrientation;
    property Perspective: TString read GetPerspective write SetPerspective;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XRotation: TString read GetXRotation write SetXRotation;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar3DClustered = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetColorMode: TString;
    procedure SetColorMode(const value: TString);
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
  public
    property ColorMode: TString read GetColorMode write SetColorMode;
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property Orientation: TString read GetOrientation write SetOrientation;
    property Perspective: TString read GetPerspective write SetPerspective;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XRotation: TString read GetXRotation write SetXRotation;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar3D = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYaxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetPerspective: TString;
    procedure SetPerspective(const value: TString);
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetXRotation: TString;
    procedure SetXRotation(const value: TString);
    function GetYAxes: TLlDOMPropertyValueAxisArray;
    function GetZRotation: TString;
    procedure SetZRotation(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property Orientation: TString read GetOrientation write SetOrientation;
    property Perspective: TString read GetPerspective write SetPerspective;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property XRotation: TString read GetXRotation write SetXRotation;
    property YAxes: TLlDOMPropertyValueAxisArray read GetYAxes;
    property ZRotation: TString read GetZRotation write SetZRotation;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar2DStackedRelative = class
    (TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Orientation: TString read GetOrientation write SetOrientation;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar2DStacked = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Orientation: TString read GetOrientation write SetOrientation;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar2DClustered = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYAxis: TLlDOMPropertyCategoryAxis;
    fZAxes: TLlDOMPropertyValueAxisArray;
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxis: TLlDOMPropertyCategoryAxis;
    function GetZAxes: TLlDOMPropertyValueAxisArray;
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Orientation: TString read GetOrientation write SetOrientation;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxis: TLlDOMPropertyCategoryAxis read GetYAxis;
    property ZAxes: TLlDOMPropertyValueAxisArray read GetZAxes;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineBar2D = class(TLlDOMPropertyChartEngineBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    fXaxis: TLlDOMPropertyCategoryAxis;
    fYaxes: TLlDOMPropertyValueAxisArray;
    function GetOrientation: TString;
    procedure SetOrientation(const value: TString);
    function GetUseLightEffect: TString;
    procedure SetUseLightEffect(const value: TString);
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetSecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis;
    function GetXAxis: TLlDOMPropertyCategoryAxis;
    function GetYAxes: TLlDOMPropertyValueAxisArray;
  public
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property Orientation: TString read GetOrientation write SetOrientation;
    property SecondaryValueAxis: TLlDOMPropertyChartSecondaryValueAxis
      read GetSecondaryValueAxis;
    property UseLightEffect: TString read GetUseLightEffect
      write SetUseLightEffect;
    property XAxis: TLlDOMPropertyCategoryAxis read GetXAxis;
    property YAxes: TLlDOMPropertyValueAxisArray read GetYAxes;

    destructor Destroy; override;
  end;

  { Funnelchart class }
  TLlDOMPropertyChartEngineFunnelVertical = class(TLlDOMPropertyChartEngineBase)
  private
    fYAxis: TLlDOMPropertyValueAxisFunnelArray;
    fRelativeRadiusOfParallelPart: TLlDOMPropertyRelativeRadiusOfParallelPart;
    fXaxis: TLlDOMPropertyCategoryAxisFunnel;
    function GetColorMode: TString;
    procedure SetColorMode(const value: TString);
    function GetRelativeRadiusOfParallelPart
      : TLlDOMPropertyRelativeRadiusOfParallelPart;
    function GetValueAxisFunnelArray: TLlDOMPropertyValueAxisFunnelArray;
    function GetShowSeparatorLines: TString;
    procedure SetShowSeparatorLines(const value: TString);
    function GetRelativeRadiusOfStart: TString;
    procedure SetRelativeRadiusOfStart(const value: TString);
    function GetCategoryAxisFunnel: TLlDOMPropertyCategoryAxisFunnel;
  public
    property ColorMode: TString read GetColorMode write SetColorMode;
    property ShowSeparatorLines: TString read GetShowSeparatorLines
      write SetShowSeparatorLines;
    property RelativeRadiusOfStart: TString read GetRelativeRadiusOfStart
      write SetRelativeRadiusOfStart;
    property YAxis: TLlDOMPropertyValueAxisFunnelArray
      read GetValueAxisFunnelArray;
    property RelativeRadiusOfParallelPart
      : TLlDOMPropertyRelativeRadiusOfParallelPart
      read GetRelativeRadiusOfParallelPart;
    property XAxis: TLlDOMPropertyCategoryAxisFunnel read GetCategoryAxisFunnel;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartEngineFunnelHorizontal = class
    (TLlDOMPropertyChartEngineFunnelVertical);
  { /Funnelchart class }

  { ReportParameter class }
  TLlDOMReportParameter = class(TLlDOMItem)
  private
    fSource: TLlDOMReportParameterSource;
    function GetCurrentContentsAsObject: OleVariant;
	  procedure SetCurrentContentsAsObject(const value: OleVariant);
    procedure SetCurrentContents(const value: TString);
    function GetCurrentContents: TString;
    function GetAllowBlank: TString;
    procedure SetAllowBlank(const value: TString);
    function GetAllowMultipleValues: TString;
    procedure SetAllowMultipleValues(const value: TString);
    function GetAllowNull: TString;
    procedure SetAllowNull(const value: TString);
    function GetDefaultValue: TString;
    procedure SetDefaultValue(const value: TString);
    function GetId: TString;
    function GetIdentifier: TString;
    procedure SetIdentifier(const value: TString);
    function GetParentId: TString;
    procedure SetParentId(const value: TString);
    function GetPrompt: TString;
    procedure SetPrompt(const value: TString);
    function GetTooltip: TString;
    procedure SetTooltip(const value: TString);
    function GetVisible: TString;
    procedure SetVisible(const value: TString);
    function GetSource: TLlDOMReportParameterSource;
    function GetControlType: TLlDOMControlType;
    procedure SetControlType(const value: TLlDOMControlType);
  public
    property CurrentContents: TString read GetCurrentContents write SetCurrentContents;
    property CurrentContentsAsObject:OleVariant read GetCurrentContentsAsObject  write SetCurrentContentsAsObject;
    property AllowBlank: TString read GetAllowBlank write SetAllowBlank;
    property AllowMultipleValues: TString read GetAllowMultipleValues
      write SetAllowMultipleValues;
    property AllowNull: TString read GetAllowNull write SetAllowNull;
    property DefaultValue: TString read GetDefaultValue write SetDefaultValue;
    property Id: TString read GetId; // readOnly
    property ParentId: TString read GetParentId write SetParentId;
    property Identifier: TString read GetIdentifier write SetIdentifier;
    property Prompt: TString read GetPrompt write SetPrompt;
    property Tooltip: TString read GetTooltip write SetTooltip;
    property Visible: TString read GetVisible write SetVisible;
    property Source: TLlDOMReportParameterSource read GetSource;
    property ControlType: TLlDOMControlType read GetControlType
      write SetControlType;
    constructor Create(list: TLlDOMReportParameterList); overload;
    destructor Destroy; override;
  end;

  TLlDOMReportParameterSource = class(TLlDOMItem)
  private
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetDisplayFormula: TString;
    procedure SetDisplayFormula(const value: TString);
    function GetField: TString;
    procedure SetField(const value: TString);
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
    function GetSortOrderId: TString;
    procedure SetSortOrderId(const value: TString);
    function GetTableId: TString;
    procedure SetTableId(const value: TString);
    function GetManualItems: TString;
    procedure SetManualItems(const value: TString);
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetSourceType: TLlDOMSourceType;
    procedure SetSourceType(const value: TLlDOMSourceType);
    function GetSourceContentsType: TLlDOMSourceContentsType;
    procedure SetSourceContentsType(const value: TLlDOMSourceContentsType);
  public
    property TableId: TString read GetTableId write SetTableId;
    property DisplayFormula: TString read GetDisplayFormula
      write SetDisplayFormula;
    property Field: TString read GetField write SetField;
    property Filter: TString read GetFilter write SetFilter;
    property SortOrderId: TString read GetSortOrderId write SetSortOrderId;
    property SourceType: TLlDOMSourceType read GetSourceType
      write SetSourceType;
    property SourceContentsType: TLlDOMSourceContentsType
      read GetSourceContentsType write SetSourceContentsType;
    property ManualItems: TString read GetManualItems write SetManualItems;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;
  end;

  { /ReportParameter class }
  TLlDOMPropertyVariable = class(TLlDOMItem)
  private
    function GetUserVarOptions: TString;
    procedure SetUserVarOptions(const value: TString);
  public
    property UserVarOptions: TString read GetUserVarOptions
      write SetUserVarOptions;
  end;

  TLlDOMPropertyDrawing = class(TLlDOMItem)
  private
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetPosition: TString;
    procedure SetPosition(const value: TString);
  public
    property Formula: TString read GetFormula write SetFormula;
    property Height: TString read GetHeight write SetHeight;
    property Width: TString read GetWidth write SetWidth;
    property Position: TString read GetPosition write SetPosition;
  end;

  TLlDOMPropertyBitmap = class(TLlDOMItem)
  private
    fDisplay: TLlDOMPropertyDisplay;
    fFileinfo: TLlDOMPropertyFileInfo;
    fVariable: TLlDOMPropertyVariable;
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetDisplay: TLlDOMPropertyDisplay;
    function GetFileinfo: TLlDOMPropertyFileInfo;
    function GetVariable: TLlDOMPropertyVariable;
  public
    property Display: TLlDOMPropertyDisplay read GetDisplay;
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    property Formula: TString read GetFormula write SetFormula;
    property Mode: TString read GetMode write SetMode;
    property Variable: TLlDOMPropertyVariable read GetVariable;
    destructor Destroy; override;
  end;

  TLlDOMPropertyChartFilling = class(TLlDOMPropertyFilling)
  private
    fBitmap: TLlDOMPropertyBitmap;
    function GetBitmap: TLlDOMPropertyBitmap;
  public
    property Bitmap: TLlDOMPropertyBitmap read GetBitmap;

    destructor Destroy; override;
  end;

  TLlDOMPropertyChartTitle = class(TLlDOMItem)
  private
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetOutputFormatter: TLlDOMPropertyOutputFormatterBase;
  public
    property Contents: TString read GetContents write SetContents;
    property Font: TLlDOMPropertyFont read GetFont;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatter;

    destructor Destroy; override;
  end;

  TLlDOMPropertyDrawingContents = class(TLlDOMItem)
  private
    fDisplay: TLlDOMPropertyDisplay;
    fFileinfo: TLlDOMPropertyFileInfo;
    function GetMode: TString;
    procedure SetMode(const value: TString);
    function GetFormula: TString;
    procedure SetFormula(const value: TString);
    function GetVariable: TString;
    procedure SetVariable(const value: TString);
    function GetFileinfo: TLlDOMPropertyFileInfo;
    function GetDisplay: TLlDOMPropertyDisplay;
    function GetEmbedded: TString;
    procedure SetEmbedded(const value: TString);
    function GetEmbeddedContents: TString;
    procedure SetEmbeddedContents(const value: TString);
  public
    property EmbeddedContents: TString read GetEmbeddedContents write SetEmbeddedContents;
    property Embedded: TString read GetEmbedded write SetEmbedded;
    property Display: TLlDOMPropertyDisplay read GetDisplay;
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    property Formula: TString read GetFormula write SetFormula;
    property Mode: TString read GetMode write SetMode;
    property Variable: TString read GetVariable write SetVariable;

    destructor Destroy; override;
  end;

  TLlDOMPropertyDateTimeFormat = class(TLlDOMItem)
  private
    function GetFormatTemplate: TString;
    procedure SetFormatTemplate(const value: TString);
    function GetFormatType: TString;
    procedure SetFormatType(const value: TString);
  public
    property FormatTemplate: TString read GetFormatTemplate
      write SetFormatTemplate;
    property FormatType: TString read GetFormatType write SetFormatType;
  end;

  TLlDOMPropertyOutputFormatterBase = class(TLlDOMItem)
  private
    function GetFormatterType: TString;
    procedure SetFormatterType(const value: TString);
  public
    property FormatterType: TString read GetFormatterType
      write SetFormatterType;

    constructor Create(item: TLlDOMItem); overload; override;
    constructor Create(FormatterType: TString;
      item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterNone = class(TLlDOMPropertyOutputFormatterBase)
	public
	constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;
  TLlDOMPropertyOutputFormatterDouble = class(TLlDOMPropertyOutputFormatterBase)
  private
    function GetCountOfDecimals: TString;
    procedure SetCountOfDecimals(const value: TString);
    function GetDecimalSeparatorCharType: TString;
    procedure SetDecimalSeparatorCharType(const value: TString);
    function GetEmptyStringIfZero: TString;
    procedure SetEmptyStringIfZero(const value: TString);
    function GetForceZeroBeforeDecimalSeparator: TString;
    procedure SetForceZeroBeforeDecimalSeparator(const value: TString);
    function GetNegativeFormatType: TString;
    procedure SetNegativeFormatType(const value: TString);
    function GetThousandsSeparatorCharType: TString;
    procedure SetThousandsSeparatorCharType(const value: TString);
    function GetExponentialFormat: TString;
    procedure SetExponentialFormat(const value: TString);
    function GetUnits: TString;
    procedure SetUnits(const value: TString);
    function GetRemoveTrailingZeroes: TString;
    procedure SetRemoveTrailingZeroes(const value: TString);
	function GetForceSign: TString;
    procedure SetForceSign(const value: TString);
  public
	property ForceSign: TString read GetForceSign write SetForceSign;
    property CountOfDecimals: TString read GetCountOfDecimals
      write SetCountOfDecimals;
    property DecimalSeparatorCharType: TString read GetDecimalSeparatorCharType
      write SetDecimalSeparatorCharType;
    property EmptyStringIfZero: TString read GetEmptyStringIfZero
      write SetEmptyStringIfZero;
    property ForceZeroBeforeDecimalSeparator: TString
      read GetForceZeroBeforeDecimalSeparator
      write SetForceZeroBeforeDecimalSeparator;
    property NegativeFormatType: TString read GetNegativeFormatType
      write SetNegativeFormatType;
    property ThousandsSeparatorCharType: TString
      read GetThousandsSeparatorCharType write SetThousandsSeparatorCharType;
    property ExponentialFormat: TString read GetExponentialFormat
      write SetExponentialFormat;
    property Units: TString read GetUnits write SetUnits;
    property RemoveTrailingZeroes: TString read GetRemoveTrailingZeroes
      write SetRemoveTrailingZeroes;
    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterCurrency = class
    (TLlDOMPropertyOutputFormatterDouble)
  private
    function GetCurrencySymbol: TString;
    procedure SetCurrencySymbol(const value: TString);
    function GetPositiveFormatType: TString;
    procedure SetPositiveFormatType(const value: TString);
    function GetExponentialFormat: TString;
    procedure SetExponentialFormat(const value: TString);
  public
    property CurrencySymbol: TString read GetCurrencySymbol
      write SetCurrencySymbol;
    property PositiveFormatType: TString read GetPositiveFormatType
      write SetPositiveFormatType;
    property ExponentialFormat: TString read GetExponentialFormat
      write SetExponentialFormat;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterDate = class(TLlDOMPropertyOutputFormatterBase)
  private
    function GetFormatTemplate: TString;
    procedure SetFormatTemplate(const value: TString);
    function GetFormatType: TString;
    procedure SetFormatType(const value: TString);
  public
    property FormatTemplate: TString read GetFormatTemplate
      write SetFormatTemplate;
    property FormatType: TString read GetFormatType write SetFormatType;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterTime = class(TLlDOMPropertyOutputFormatterBase)
  private
    function GetFormatTemplate: TString;
    procedure SetFormatTemplate(const value: TString);
    function GetFormatType: TString;
    procedure SetFormatType(const value: TString);
  public
    property FormatTemplate: TString read GetFormatTemplate
      write SetFormatTemplate;
    property FormatType: TString read GetFormatType write SetFormatType;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterDateTime = class
    (TLlDOMPropertyOutputFormatterBase)
  private
    fDate: TLlDOMPropertyDateTimeFormat;
    fTime: TLlDOMPropertyDateTimeFormat;
    function GetSeparator: TString;
    procedure SetSeparator(const value: TString);
    function GetTimeAtLeft: TString;
    procedure SetTimeAtLeft(const value: TString);
    function GetDate: TLlDOMPropertyDateTimeFormat;
    function GetTime: TLlDOMPropertyDateTimeFormat;
  public
    property Date: TLlDOMPropertyDateTimeFormat read GetDate;
    property Time: TLlDOMPropertyDateTimeFormat read GetTime;
    property Separator: TString read GetSeparator write SetSeparator;
    property TimeAtLeft: TString read GetTimeAtLeft write SetTimeAtLeft;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterPercentage = class
    (TLlDOMPropertyOutputFormatterBase)
  private
    function GetCountOfDecimals: TString;
    procedure SetCountOfDecimals(const value: TString);
    function GetDecimalSeparatorCharType: TString;
    procedure SetDecimalSeparatorCharType(const value: TString);
    function GetEmptyStringIfZero: TString;
    procedure SetEmptyStringIfZero(const value: TString);
    function GetForceZeroBeforeDecimalSeparator: TString;
    procedure SetForceZeroBeforeDecimalSeparator(const value: TString);
    function GetNegativeFormatType: TString;
    procedure SetNegativeFormatType(const value: TString);
    function GetThousandsSeparatorCharType: TString;
    procedure SetThousandsSeparatorCharType(const value: TString);
	function GetMultiplyBy100: TString;
    procedure SetMultiplyBy100(const value: TString);
	function GetForceSign: TString;
    procedure SetForceSign(const value: TString);
  public
  property ForceSign: TString read GetForceSign write SetForceSign;
  property MultiplyBy100: TString read GetMultiplyBy100 write SetMultiplyBy100;
    property CountOfDecimals: TString read GetCountOfDecimals
      write SetCountOfDecimals;
    property DecimalSeparatorCharType: TString read GetDecimalSeparatorCharType
      write SetDecimalSeparatorCharType;
    property EmptyStringIfZero: TString read GetEmptyStringIfZero
      write SetEmptyStringIfZero;
    property ForceZeroBeforeDecimalSeparator: TString
      read GetForceZeroBeforeDecimalSeparator
      write SetForceZeroBeforeDecimalSeparator;
    property NegativeFormatType: TString read GetNegativeFormatType
      write SetNegativeFormatType;
    property ThousandsSeparatorCharType: TString
      read GetThousandsSeparatorCharType write SetThousandsSeparatorCharType;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyOutputFormatterDegree = class(TLlDOMPropertyOutputFormatterBase)
  private
    function GetCountOfDecimals: TString;
    procedure SetCountOfDecimals(const value: TString);
    function GetDecimalSeparatorCharType: TString;
    procedure SetDecimalSeparatorCharType(const value: TString);
    function GetEmptyStringIfZero: TString;
    procedure SetEmptyStringIfZero(const value: TString);
    function GetFormatType: TString;
    procedure SetFormatType(const value: TString);
    function GetInputDataType: TString;
    procedure SetInputDataType(const value: TString);
    function GetOmitEmptyParts: TString;
    procedure SetOmitEmptyParts(const value: TString);
  public
    property CountOfDecimals: TString read GetCountOfDecimals
      write SetCountOfDecimals;
    property DecimalSeparatorCharType: TString read GetDecimalSeparatorCharType
      write SetDecimalSeparatorCharType;
    property EmptyStringIfZero: TString read GetEmptyStringIfZero
      write SetEmptyStringIfZero;
    property FormatType: TString read GetFormatType write SetFormatType;
    property InputDataType: TString read GetInputDataType
      write SetInputDataType;
    property OmitEmptyParts: TString read GetOmitEmptyParts
      write SetOmitEmptyParts;

    constructor Create(item: TLlDOMPropertyOutputFormatterBase); overload;
  end;

  TLlDOMPropertyKeepTogether = class(TLlDOMItem)
    private
    function GetDataLineDefinitions: TString;
    procedure SetDataLineDefinitions(const value: TString);
    function GetIndexedGroups: TString;
    procedure SetIndexedGroups(const value: TString);
    public
    property DataLineDefinitions: TString read GetDataLineDefinitions write SetDataLineDefinitions;
    property IndexedGroups: TString read GetIndexedGroups write SetIndexedGroups;
  end;

  TLlDOMPropertyFooterLinesOptions = class(TLlDOMItem)
  private
    fKeepTogether: TLlDOMPropertyKeepTogether;
    function GetKeepTogether: TLlDOMPropertyKeepTogether;
  public
    property KeepTogether: TLlDOMPropertyKeepTogether read GetKeepTogether;
    destructor Destroy; override;
  end;

  TLlDOMPropertyGroupFooterLinesOptions = class(TLlDOMItem)
  private
    function GetAlsoOnEmptyGroup: TString;
    procedure SetAlsoOnEmptyGroup(const value: TString);
    function GetKeepTogether: TString;
    procedure SetKeepTogether(const value: TString);
  public
    property AlsoOnEmptyGroup: TString read GetAlsoOnEmptyGroup
      write SetAlsoOnEmptyGroup;
    property KeepTogether: TString read GetKeepTogether write SetKeepTogether;
  end;

  TLlDOMPropertyGroupHeaderLinesOptions = class(TLlDOMItem)
  private
    function GetConcatNextDataLine: TString;
    procedure SetConcatNextDataLine(const value: TString);
    function GetKeepTogether: TString;
    procedure SetKeepTogether(const value: TString);
  public
    property ConcatNextDataLine: TString read GetConcatNextDataLine
      write SetConcatNextDataLine;
    property KeepTogether: TString read GetKeepTogether write SetKeepTogether;
  end;

  TLlDOMPropertyDataLinesOptions = class(TLlDOMItem)
  private
    fZebraPattern: TLlDOMPropertyFilling;
    fKeepTogether: TLlDOMPropertyKeepTogether;
    function GetForceSumCalculation: TString;
    procedure SetForceSumCalculation(const value: TString);
    function GetKeepTogether: TLlDOMPropertyKeepTogether;
    function GetSuppress: TString;
    procedure SetSuppress(const value: TString);
    function GetLineOtpionDataZebraPattern: TLlDOMPropertyFilling;
    function GetKeepTogetherDataLine: TString;
    procedure SetKeepTogetherDataLine(const value: TString);

  public
    property KeepTogetherDataLine: TString read GetKeepTogetherDataLine
      write SetKeepTogetherDataLine;
    property ZebraPattern: TLlDOMPropertyFilling
      read GetLineOtpionDataZebraPattern;
    property ForceSumCalculation: TString read GetForceSumCalculation
      write SetForceSumCalculation;
    property KeepTogether: TLlDOMPropertyKeepTogether read GetKeepTogether;
    property Suppress: TString read GetSuppress write SetSuppress;
    destructor Destroy; override;
  end;

  TLlDOMPropertyDataLinesOptionsStaticTable = class(TLlDOMItem)
  private

    function GetKeepTogether: TString;
    procedure SetKeepTogether(const value: TString);

  public

    property KeepTogether: TString read GetKeepTogether write SetKeepTogether;

  end;

  TLlDOMPropertyStaticTableLines = class(TLlDOMItem)
  private

    fData: TLlDOMPropertyDataLinesOptionsStaticTable;
    function GetLineOptionData: TLlDOMPropertyDataLinesOptionsStaticTable;

  public

    property Data: TLlDOMPropertyDataLinesOptionsStaticTable
      read GetLineOptionData;

    destructor Destroy; override;

  end;

  TLlDOMPropertyTableLines = class(TLlDOMItem)
  private
    fData: TLlDOMPropertyDataLinesOptions;
    fFooter: TLlDOMPropertyFooterLinesOptions;
    fGroupHeader: TLlDOMPropertyGroupHeaderLinesOptions;
    fGroupFooter: TLlDOMPropertyGroupFooterLinesOptions;
    function GetLineOptionData: TLlDOMPropertyDataLinesOptions;
    function GetLineOptionFooter: TLlDOMPropertyFooterLinesOptions;
    function GetLineOptionGroupFooter: TLlDOMPropertyGroupFooterLinesOptions;
    function GetLineOptionGroupHeader: TLlDOMPropertyGroupHeaderLinesOptions;
  public
    property Data: TLlDOMPropertyDataLinesOptions read GetLineOptionData;
    property Footer: TLlDOMPropertyFooterLinesOptions read GetLineOptionFooter;
    property GroupHeader: TLlDOMPropertyGroupHeaderLinesOptions
      read GetLineOptionGroupHeader;
    property GroupFooter: TLlDOMPropertyGroupFooterLinesOptions
      read GetLineOptionGroupFooter;
    destructor Destroy; override;
  end;

  TLlDOMPropertySortOrders = class(TLlDOMItem)
  private
    function GetAscending: TString;
    procedure SetAscending(const value: TString);
    function GetDescending: TString;
    procedure SetDescending(const value: TString);
  public
    property Ascending: TString read GetAscending write SetAscending;
    property Descending: TString read GetDescending write SetDescending;
  end;

  TLlDOMTableField = class(TLlDOMItem)
  private
    fFilling: TLlDOMPropertyChartFilling;
    fFrame: TLlDOMPropertyFrame;
    fWrapping: TLlDOMPropertyFieldWrapping;
    fDrillDownLinks: TLlDOMDrillDownLinkList;
    fSortOrders: TLlDOMPropertySortOrders;
    procedure SetCondition(const value: TString);
    function GetFilling: TLlDOMPropertyChartFilling;
    function GetFrame: TLlDOMPropertyFrame;
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    procedure SetObjectType(const value: TString);
    function GetObjectType: TString;
    function GetObjectTypeLLX: TString;
    procedure SetObjectTypeLLX(const value: TString);
    function GetWrapping: TLlDOMPropertyFieldWrapping;
    function GetDrillDownLinks: TLlDOMDrillDownLinkList;
    function GetCondition: TString;
  public
    property Filling: TLlDOMPropertyChartFilling read GetFilling;
    property Condition: TString read GetCondition write SetCondition;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Name: TString read GetName write SetName;
    property ObjectType: TString read GetObjectType write SetObjectType;
    property ObjectTypeLLX: TString read GetObjectTypeLLX
      write SetObjectTypeLLX;
    property Width: TString read GetWidth write SetWidth;
    property Wrapping: TLlDOMPropertyFieldWrapping read GetWrapping;
    property DrillDownLinks: TLlDOMDrillDownLinkList read GetDrillDownLinks;
    constructor Create(list: TLlDOMTableLineFieldList; objType: TString;
      index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldBase = class(TLlDOMTableField)
  private
    fAnimation: TLlDOMPropertyAnimation;
    fXhtmlAnimation: TLlDomPropertyXhtmlAnimation;
    function GetAnimation: TLlDOMPropertyAnimation;
    function GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
    function GetLinkURL: TString;
    procedure SetLinkURL(const value: TString);
    function GetSortOrders: TLlDOMPropertySortOrders;

  public

    property Animation: TLlDOMPropertyAnimation read GetAnimation;
    property XhtmlAnimation: TLlDOMPropertyXhtmlAnimation read GetXhtmlAnimation;
    property LinkURL: TString read GetLinkURL write SetLinkURL;
    property SortOrders: TLlDOMPropertySortOrders read GetSortOrders;
    constructor Create(list: TLlDOMTableLineFieldList; objType: TString;
      index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldText = class(TLlDOMTableField)
  private
    fAlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal;
    fFont: TLlDOMPropertyFont;
    fWrapping: TLlDOMPropertyWrapping;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetAdjusted: TString;
    procedure SetAdjusted(const value: TString);
    function GetAlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal;
    function GetAlignmentVertical: TString;
    procedure SetAlignmentVertical(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFixedHeight: TString;
    procedure SetFixedHeight(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetWrapping: TLlDOMPropertyWrapping;
    function GetOptimizeSpaces: TString;
    procedure SetOptimizeSpaces(const value: TString);
    function GetPlainTextFormat: TString;
    procedure SetPlainTextFormat(const value: TString);
    function GetOutputFormatterBase: TLlDOMPropertyOutputFormatterBase;
    function GetLineSpacing: TString;
    procedure SetLineSpacing(const value: TString);
  public
    property Adjusted: TString read GetAdjusted write SetAdjusted;
    property AlignmentHorizontal: TLlDOMPropertyAlignmentHorizontal
      read GetAlignmentHorizontal;
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property Contents: TString read GetContents write SetContents;
    property Direction: TString read GetDirection write SetDirection;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property FixedHeight: TString read GetFixedHeight write SetFixedHeight;
    property Font: TLlDOMPropertyFont read GetFont;
    property LineSpacing: TString read GetLineSpacing write SetLineSpacing;
    property OptimizeSpaces: TString read GetOptimizeSpaces
      write SetOptimizeSpaces;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatterBase;
    property PlainTextFormat: TString read GetPlainTextFormat
      write SetPlainTextFormat;
    property Wrapping: TLlDOMPropertyWrapping read GetWrapping;

    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldChart = class(TLlDOMTableField)
  private
    fDefinition: TLlDOMPropertyChartDefinition;
    function GetDefinition: TLlDOMPropertyChartDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetSourceTablePath: TString;
    procedure SetSourceTablePath(const value: TString);
  public
    property Definition: TLlDOMPropertyChartDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Height: TString read GetHeight write SetHeight;
    property SourceTablePath: TString read GetSourceTablePath
      write SetSourceTablePath;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  { PDF }
  TLlDOMTableFieldPDF = class(TLlDOMTableField)
  private
    fDefinition: TLlDOMPropertyPDFDefinition;
    function GetDefinition: TLlDOMPropertyPDFDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
  public
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;

    property Definition: TLlDOMPropertyPDFDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Height: TString read GetHeight write SetHeight;
  end;

  TLlDOMTableFieldGauge = class(TLlDOMTableField)
  private
    fDefinition: TLlDOMPropertyGaugeDefinition;
    function GetDefinition: TLlDOMPropertyGaugeDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
  public
    property Definition: TLlDOMPropertyGaugeDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Height: TString read GetHeight write SetHeight;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldDataGraphic = class(TLlDOMTableField)
  private
    fDefinition: TLlDOMPropertyDataGraphicDefinition;
    function GetDefinition: TLlDOMPropertyDataGraphicDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
  public
    property Definition: TLlDOMPropertyDataGraphicDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Height: TString read GetHeight write SetHeight;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldDrawing = class(TLlDOMTableField)
  private
    function GetAlignmentVertical: TString;
    procedure SetAlignmentVertical(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
  public
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property Contents: TString read GetContents write SetContents;
    property Height: TString read GetHeight write SetHeight;
    property Isotropic: TString read GetIsotropic write SetIsotropic;

    constructor Create(list: TLlDOMTableLineFieldList); overload;
  end;

  TLlDOMTableFieldRTF = class(TLlDOMTableField)
  private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFixedHeight: TString;
    procedure SetFixedHeight(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property FixedHeight: TString read GetFixedHeight write SetFixedHeight;

    constructor Create(list: TLlDOMTableLineFieldList); overload;
  end;

  TLlDOMTableFieldBarcode = class(TLlDOMTableField)
  private
    fFont: TLlDOMPropertyFont;
    fMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
    fSource: TLlDOMPropertyTableFieldBarCodeSource;
    function GetBarcodeType: TString;
    procedure SetBarcodeType(const value: TString);
    function GetBarcodeSource: TLlDOMPropertyTableFieldBarCodeSource;
    function GetAlignmentVertical: TString;
    procedure SetAlignmentVertical(const value: TString);
    function GetBarColor: TString;
    procedure SetBarColor(const value: TString);
    function GetBarRatio: TString;
    procedure SetBarRatio(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFixedBarOptions: TString;
    procedure SetFixedBarOptions(const value: TString);
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetWithText: TString;
    procedure SetWithText(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
  public
    property Source: TLlDOMPropertyTableFieldBarCodeSource read GetBarcodeSource;
    property BarcodeType: TString read GetBarcodeType write SetBarcodeType;
    property AlignmentVertical: TString read GetAlignmentVertical
      write SetAlignmentVertical;
    property BarColor: TString read GetBarColor write SetBarColor;
    property BarRatio: TString read GetBarRatio write SetBarRatio;
    property Contents: TString read GetContents write SetContents;
    property Direction: TString read GetDirection write SetDirection;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Font: TLlDOMPropertyFont read GetFont;
    property FixedBarOptions: TString read GetFixedBarOptions
      write SetFixedBarOptions;
    property Height: TString read GetHeight write SetHeight;
    property WithText: TString read GetWithText write SetWithText;
    property MatchDevicePixel: TLlDOMPropertyMatchDevicePixel read GetMatchDevicePixel;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableFieldDesignerObject = class(TLlDOMTableField)
  private
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
  public
    property Height: TString read GetHeight write SetHeight;

    constructor Create(objectName: TString;
      list: TLlDOMTableLineFieldList); overload;
  end;

  TLlDOMTableFieldHTML = class(TLlDOMTableField)
  private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetContentType: TString;
    procedure SetContentType(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFitToObject: TString;
    procedure SetFitToObject(const value: TString);
  public
    property Contents: TString read GetContents write SetContents;
    property ContentType: TString read GetContentType write SetContentType;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property FitToObject: TString read GetFitToObject write SetFitToObject;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
  end;

  TLlDOMTableFieldTable = class(TLlDOMTableField)

  private
    fSubItems: TLlDOMSubItemCoreList;
    function GetReservedMinHeight: string;
    function GetSubItems: TLlDOMSubItemCoreList;
    procedure SetReservedMinHeight(const Value: string);
  public
    constructor Create(list: TLlDOMTableLineFieldList);
    destructor Destroy; override;
    property ReservedMinHeight: string read GetReservedMinHeight write SetReservedMinHeight;
    property SubItems: TLlDOMSubItemCoreList read GetSubItems;
  end;

  TLlDOMTableInputFieldBase = class(TLlDOMTableField)
  private
    fConditionalFormatters: TLlDOMConditionalFormatterItemList;
    fFont: TLlDOMPropertyDefaultFontExt;
    fFilling: TLlDOMPropertyFillingWithBitmap;
    function GetConditionalFormatterItems: TLlDOMConditionalFormatterItemList;
    function GetFont: TLlDOMPropertyDefaultFontExt;
    function GetFilling: TLlDOMPropertyFillingWithBitmap;
    function GetFixedHeight: TString;
    procedure SetFixedHeight(const value: TString);
    function GetToolTip: TString;
    procedure SetToolTip(const value: TString);
    function GetUneditable: TString;
    procedure SetUneditable(const Value: TString);

  public
    property ConditionalFormatters: TLlDOMConditionalFormatterItemList
                read GetConditionalFormatterItems;
    property Font: TLlDOMPropertyDefaultFontExt read GetFont;
    property Filling: TLlDOMPropertyFillingWithBitmap read GetFilling;
    property FixedHeight: TString read GetFixedHeight write SetFixedHeight;
    property Uneditable: TString read GetUneditable write SetUneditable;
    property ToolTip: TString read GetToolTip write SetToolTip;
    destructor Destroy; Override;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
  end;

TLlDOMTableInputFieldEdit  = class(TLlDOMTableInputFieldBase)
private
		fVerification: TLlDOMPropertyVerification;
		function GetAlignment: TString;
		procedure SetAlignment(const value: TString);

		function GetDefaultValueText: TString;
		procedure SetDefaultValueText(const value: TString);

		function GetFieldName: TString;
		procedure SetFieldName(const value: TString);

		function GetMultiline: TString;
		procedure SetMultiline(const value: TString);

		function GetNeedInput: TString;
		procedure SetNeedInput(const value: TString);

		function GetVerification: TLlDOMPropertyVerification;
public
		property Alignment: TString read GetAlignment write SetAlignment;
		property FieldName: TString read GetFieldName write SetFieldName;
		property DefaultValueText: TString read GetDefaultValueText write SetDefaultValueText;
		property Multiline: TString read GetMultiline write SetMultiline;
		property NeedInput: TString read GetNeedInput write SetNeedInput;
		property Verification: TLlDOMPropertyVerification read GetVerification;
		destructor Destroy; override;
		constructor Create(list: TLlDOMTableLineFieldList); overload;
end;

TLlDOMTableInputFieldCheckbox = class(TLlDOMTableInputFieldBase)
private
		function GetFieldName: TString;
		procedure SetFieldName(const value: TString);
    function GetCheckboxType: TString;
    procedure SetCheckboxType(const value: TString);
    function GetDefaultValueBool: TString;
    procedure SetDefaultValueBool(const value: TString);
public
		property FieldName: TString read GetFieldName write SetFieldName;
    property CheckBoxType: TString read GetCheckboxType write SetCheckboxType;
    property DevaultValueBool: TString read GetDefaultValueBool write SetDefaultValueBool;
		constructor Create(list: TLlDOMTableLineFieldList); overload;
end;

TLlDOMTableInputFieldComboBox = class(TLlDOMTableInputFieldBase)
private
		fVerification: TLlDOMPropertyVerification;
		function GetAlignment: TString;
		procedure SetAlignment(const value: TString);
    function GetEditable: TString;
    procedure SetEditable(const value: TString);
    function GetChoices: TString;
    procedure SetChoices(const value: TString);
    function GetFieldName: TString;
    procedure SetFieldName(const value: TString);
    function GetNeedInput: TString;
    procedure SetNeedInput(const value: TString);
 		function GetVerification: TLlDOMPropertyVerification;
public
		property Alignment: TString read GetAlignment write SetAlignment;
		property FieldName: TString read GetFieldName write SetFieldName;
		property NeedInput: TString read GetNeedInput write SetNeedInput;
		property Verification: TLlDOMPropertyVerification read GetVerification;
    property Choices: TString read GetChoices write SetChoices;
    property Editable: TString read GetEditable write SetEditable;
		destructor Destroy; override;
		constructor Create(list: TLlDOMTableLineFieldList); overload;
end;

TLlDOMTableInputFieldButton = class(TLlDOMTableInputFieldBase)
private
    fAction: TLlDOMPropertyInputButtonActionBase;
    function GetAction: TLlDOMPropertyInputButtonActionBase;
    function GetText: TString;
    procedure SetText(const value: TString);
public
    property Text: TString read GetText write SetText;
    property Action: TLlDOMPropertyInputButtonActionBase read GetAction;
    destructor Destroy; override;
		constructor Create(list: TLlDOMTableLineFieldList); overload;
end;

{TLlDOMPropertyTableFieldBarCodeSource}
TLlDOMPropertyTableFieldBarCodeSource = class(TLlDOMItem)
end;
{/TLlDOMPropertyTableFieldBarCodeSource}

{TLDOMPropertyTableFieldQRBarcodeSource}
TLDOMPropertyTableFieldQRBarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetEncoding: TString;
  function GetPreferredFormat: TString;
  function GetCorrectionLevel: TString;
  function GetFNC1Mode: TString;
  procedure SetEncoding(const value: TString);
  procedure SetPreferredFormat(const value: TString);
  procedure SetCorrectionLevel(const value: TString);
  procedure SetFNC1Mode(const value: TString);
public
  property Encoding: TString read GetEncoding write SetEncoding;
  property PreferredFormat: TString read GetPreferredFormat write SetPreferredFormat;
  property CorrectionLevel: TString read GetCorrectionLevel write SetCorrectionLevel;
  property FNC1Mode: TString read GetFNC1Mode write SetFNC1Mode;
end;
{/TLDOMPropertyTableFieldQRBarcodeSource}

{TLlDOMPropertyTableFieldAztecBarcodeSource}
TLlDOMPropertyTableFieldAztecBarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetDataLayer: TString;
  procedure SetDataLayer(const value: TString);
public
  property DataLayer: TString read GetDataLayer write SetDataLayer;
end;
{/TLlDOMPropertyTableFieldAztecBarcodeSource}

{PropertyTableFieldDatamatrixBarcodeSource}
TLlDOMPropertyTableFieldDatamatrixBarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetEncoding: TString;
  function GetPreferredFormat: TString;
  procedure SetEncoding(const value: TString);
  procedure SetPreferredFormat(const value: TString);
public
  property Encoding: TString read GetEncoding write SetEncoding;
  property PreferredFormat: TString read GetPreferredFormat write SetPreferredFormat;
end;
{/PropertyTableFieldDatamatrixBarcodeSource}

{TLlDOMPropertyTableFieldMaxicodeBarcodeSource}
TLlDOMPropertyTableFieldMaxicodeBarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetPolygonFillRate: TString;
  function GetMaxicodeMode: TString;
  procedure SetPolygonFillRate(const value: TString);
  procedure SetMaxicodeMode(const value: TString);
public
  property PolygonFillRate: TString read GetPolygonFillRate write SetPolygonFillRate;
  property MaxicodeMode: TString read GetMaxicodeMode write SetMaxicodeMode;
end;
{/TLlDOMPropertyTableFieldMaxicodeBarcodeSource}

{TLlDOMPropertyTableFieldMicroPDF417BarcodeSource}
TLlDOMPropertyTableFieldMicroPDF417BarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetEncoding: TString;
  function GetFormat: TString;
  function GetYToXRatio: TString;
  procedure SetEncoding(const value: TString);
  procedure SetFormat(const value: TString);
  procedure SetYToXRatio(const value: TString);
public
  property Encoding: TString read GetEncoding write SetEncoding;
  property Format: TString read GetFormat write SetFormat;
  property YToXRatio: TString read GetYToXRatio write SetYToXRatio;
end;

{/TLlDOMPropertyTableFieldMicroPDF417BarcodeSource}

{TLlDOMPropertyTableFieldPDF417BarcodeSource}
TLlDOMPropertyTableFieldPDF417BarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  function GetColumnCount: TString;
  function GetErrorCorrection: TString;
  function GetTruncated: TString;
  function GetYToXRatio: TString;
  procedure SetColumnCount(const value: TString);
  procedure SetErrorCorrection(const value: TString);
  procedure SetTruncated(const value: TString);
  procedure SetYToXRatio(const value: TString);
public
  property ColumnCount: TString read GetColumnCount write SetColumnCount;
  property ErrorCorrection: TString read GetErrorCorrection write SetErrorCorrection;
  property Truncated: TString read GetTruncated write SetTruncated;
  property YToXRatio: TString read GetYToXRatio write SetYToXRatio;
end;
{/TLlDOMPropertyTableFieldPDF417BarcodeSource}

{TLlDOMPropertyTableFieldPremiumAddressBarcodeSource}
TLlDOMPropertyTableFieldPremiumAddressBarcodeSource = class(TLlDOMPropertyTableFieldBarCodeSource)
private
  fPremiumAdress: TLlDOMPropertyPremiumAdress;
  function GetPremiumAdress: TLlDOMPropertyPremiumAdress;
public
  property PremiumAdress: TLlDOMPropertyPremiumAdress read GetPremiumAdress;
  destructor Destroy; override;
end;
{/TLlDOMPropertyTableFieldPremiumAddressBarcodeSource}


  TLlDOMTableLineBase = class(TLlDOMItem)
  private
    fBookmark: TLlDOMPropertyBookmark;
    fDefaultFont: TLlDOMPropertyDefaultFont;
    fReservedSpace: TLlDOMPropertyReservedSpace;
    fFields: TLlDOMTableLineFieldList;
    fAnchor: TLlDOMPropertyAnchor;
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetDisplayInDesigner: TString;
    procedure SetDisplayInDesigner(const value: TString);
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetDefaultFont: TLlDOMPropertyDefaultFont;
    function GetReservedSpace: TLlDOMPropertyReservedSpace;
    function GetFields: TLlDOMTableLineFieldList;
    function GetBookmark: TLlDOMPropertyBookmark;
    function GetAnchor: TLlDOMPropertyAnchor;
  public
    property DefaultFont: TLlDOMPropertyDefaultFont read GetDefaultFont;
    property ReservedSpace: TLlDOMPropertyReservedSpace read GetReservedSpace;
    property Fields: TLlDOMTableLineFieldList read GetFields;
    property Condition: TString read GetCondition write SetCondition;
    property DisplayInDesigner: TString read GetDisplayInDesigner
      write SetDisplayInDesigner;
    property Name: TString read GetName write SetName;
    property Bookmark: TLlDOMPropertyBookmark read GetBookmark;
    property Anchor: TLlDOMPropertyAnchor read GetAnchor;

    destructor Destroy; override;
    constructor Create(list: TLlDOMTableLineBaseList; objType: TString;
      index: integer); overload;
  end;

  TLlDOMTableLineData = class(TLlDOMTableLineBase)
  private
    fDrillDownLinkList: TLlDOMDrillDownLinkList ;
    function GetDrillDownLinks: TLlDOMDrillDownLinkList;
    function GetIndexedGroups: TString;
    procedure SetIndexedGroups(const value: TString);
  public
    constructor Create(list: TLlDOMTableLineDataList); overload;
    property IndexedGroups: TString read GetIndexedGroups write SetIndexedGroups;
    destructor Destroy; override;
    property DrillDownLinks: TLlDOMDrillDownLinkList read GetDrillDownLinks;
  end;

  TLlDOMTableLineFooter = class(TLlDOMTableLineBase)
private
    function GetIndexedGroups: TString;
    procedure SetIndexedGroups(const value: TString);
  public
    property IndexedGroups: TString read GetIndexedGroups write SetIndexedGroups;
    constructor Create(list: TLlDOMTableLineFooterList); overload;
  end;

  TLlDOMTableLineHeader = class(TLlDOMTableLineBase)
  public

    constructor Create(list: TLlDOMTableLineHeaderList); overload;
  end;

  TLlDOMTableLineGroupHeader = class(TLlDOMTableLineBase)
  private
    fBreakBefore: TLlDOMPropertyPageBreakOptions;
    function GetBreakBefore: TLlDOMPropertyPageBreakOptions;
    function GetGroupBy: TString;
    procedure SetGroupBy(const value: TString);
    function GetGroupSums: TString;
    procedure SetGroupSums(const value: TString);
    function GetRepeatAsHeader: TString;
    procedure SetRepeatAsHeader(const value: TString);
    function GetExpandable: TString;
    procedure SetExpandable(const value: TString);
    function GetKeepGroupTogether: TString;
    procedure SetKeepGroupTogether(const value: TString);
  public
    property KeepGroupTogether: TString read GetKeepGroupTogether write SetKeepGroupTogether;
    property BreakBefore: TLlDOMPropertyPageBreakOptions read GetBreakBefore;
    property GroupBy: TString read GetGroupBy write SetGroupBy;
    property GroupSums: TString read GetGroupSums write SetGroupSums;
    property RepeatAsHeader: TString read GetRepeatAsHeader write SetRepeatAsHeader;
    property Expandable: TString read GetExpandable write SetExpandable;
    destructor Destroy; override;
    constructor Create(list: TLlDOMTableLineGroupHeaderList); overload;
  end;

  TLlDOMTableLineGroupFooter = class(TLlDOMTableLineBase)
  private
    function GetGroupBy: TString;
    procedure SetGroupBy(const value: TString);
    function GetGroupSums: TString;
    procedure SetGroupSums(const value: TString);
    function GetTriggerNewPage: TString;
    procedure SetTriggerNewPage(const value: TString);
  public
    property GroupBy: TString read GetGroupBy write SetGroupBy;
    property GroupSums: TString read GetGroupSums write SetGroupSums;
    property TriggerNewPage: TString read GetTriggerNewPage
      write SetTriggerNewPage;

    constructor Create(list: TLlDOMTableLineGroupFooterList); overload;
  end;

  TLlDOMTableLines = class(TLlDOMItem)
  private
    fData: TLlDOMTableLineDataList;
    fFooter: TLlDOMTableLineFooterList;
    fHeader: TLlDOMTableLineHeaderList;
    fGroupFooter: TLlDOMTableLineGroupFooterList;
    fGroupHeader: TLlDOMTableLineGroupHeaderList;
    function GetData: TLlDOMTableLineDataList;
    function GetFooter: TLlDOMTableLineFooterList;
    function GetHeader: TLlDOMTableLineHeaderList;
    function GetGroupFooter: TLlDOMTableLineGroupFooterList;
    function GetGroupHeader: TLlDOMTableLineGroupHeaderList;
  public
    property Data: TLlDOMTableLineDataList read GetData;
    property Footer: TLlDOMTableLineFooterList read GetFooter;
    property Header: TLlDOMTableLineHeaderList read GetHeader;
    property GroupFooter: TLlDOMTableLineGroupFooterList read GetGroupFooter;
    property GroupHeader: TLlDOMTableLineGroupHeaderList read GetGroupHeader;
    destructor Destroy; override;
  end;

  TLlDOMTableLinesStaticTable = class(TLlDOMItem)
  private

    fDataLineList: TLlDOMTableLineDataList;
    function GetData: TLlDOMTableLineDataList;

  public

    property Data: TLlDOMTableLineDataList read GetData;

    destructor Destroy; override;

  end;


  TLlDOMPropertyAnimation = class(TLlDOMItem)
    private
    fAnimationTrigger: TLlDOMPropertyAnimationTrigger;
    function GetAnimation: TString;
    function GetAnimationTime: TString;
    function GetColor: TString;
    function GetPartialAreaOnly: TString;
    function GetAnimationTrigger: TLlDOMPropertyAnimationTrigger;

    procedure SetAnimation(const value: TString);
    procedure SetAnimationTime(const value: TString);
    procedure SetColor(const value: TString);
    procedure SetPartialAreaOnly(const value: TString);

    public
    property Animation: TString read GetAnimation write SetAnimation;
    property AnimationTime: TString read GetAnimationTime write SetAnimationTime;
    property Color: TString read GetColor write SetColor;
    property PartialAreaOnly: TString read GetPartialAreaOnly
              write SetPartialAreaOnly;
    property AnimationTrigger:  TLlDOMPropertyAnimationTrigger
        read GetAnimationTrigger;
    destructor Destroy; override;
  end;

  TLlDOMPropertyAnimationTrigger = class(TLlDOMItem)
  private
    function GetTrigger: TString;
    function GetTriggerDelay: TString;
    procedure SetTrigger(const value: TString);
    procedure SetTriggerDelay(const value: TString);

  public
    property Trigger: TString read GetTrigger write SetTrigger;
    property TriggerDelay: TString read GetTriggerDelay write SetTriggerDelay;

  end;

  TLlDOMPropertyXhtmlAnimation = class(TLlDOMItem)
    private
    function GetAnimation: TString;
    function GetAnimationTime: TString;
    function GetTriggerDelay: TString;
    procedure SetAnimation(const value: TString);
    procedure SetAnimationTime(const value: TString);
    procedure SetTriggerDelay(const value: TString);
    public
    property Animation: TString read GetAnimation write SetAnimation;
    property AnimationTime: TString read GetAnimationTime write SetAnimationTime;
    property TriggerDelay: TString read GetTriggerDelay write SetTriggerDelay;
    destructor Destroy; override;
  end;



  TLlDOMObjectBase = class(TLlDOMItem)
  private
    fAnimation: TLlDOMPropertyAnimation;
    fXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
    fPosition: TLlDOMPropertyPosition;
    fBookmark: TLlDOMPropertyBookmark;
    function GetAnimation: TLlDOMPropertyAnimation;
    function GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
    function GetTemplateUUID: TString;
    function GetUUID: TString;
    function GetLinkUUID: TString;
    procedure SetLinkUUID(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetLocked: TString;
    procedure SetLocked(const value: TString);
    procedure SetContent(const value: TString);
    function GetContent: TString;
    procedure SetName(const value: TString);
    function GetName: TString;
    function GetObjectType: TString;
    function GetPosition: TLlDOMPropertyPosition;
    constructor Create(list: TLlDOMObjectList; ObjectType: TString;
      index: integer); overload; virtual;
    function GetLayerID: TString;
    procedure SetLayerID(const value: TString);
    function GetReadOnly: TString;
    procedure SetReadOnly(const value: TString);
    function GetId: TString;
    function GetLinkID: TString;
    procedure SetLinkID(const value: TString);
    function GetLinkMode: TString;
    procedure SetLinkMode(const value: TString);
    function GetBreakBefore: TString;
    procedure SetBreakBefore(const value: TString);
    function GetSelected: TString;
    procedure SetSelected(const value: TString);
    function GetGroupID: TString;
    procedure SetGroupID(const value: TString);
    function GetBookmark: TLlDOMPropertyBookmark;
    procedure SetIssueCondition(const value: TString);
    function GetIssueCondition: TString;
  public
    property Animation: TLlDOMPropertyAnimation read GetAnimation;
    property XhtmlAnimation: TLlDOMPropertyXhtmlAnimation read GetXhtmlAnimation;
    property UUID: TString read GetUUID;
    property TemplateUUID: TString read GetTemplateUUID;
    property LinkUUID: TString read GetLinkUUID write SetLinkUUID;

    property Name: TString read GetName write SetName;
    property Content: TString read GetContent write SetContent;

    property Condition: TString read GetCondition write SetCondition;
    property Locked: TString read GetLocked write SetLocked;
    property BreakBefore: TString read GetBreakBefore write SetBreakBefore;

    property LayerID: TString read GetLayerID write SetLayerID;
    property ReadOnly: TString read GetReadOnly write SetReadOnly;

    property Id: TString read GetId; // (r/o)
    property LinkID: TString read GetLinkID write SetLinkID;
    property LinkMode: TString read GetLinkMode write SetLinkMode;
    property GroupID: TString read GetGroupID write SetGroupID;

    property Bookmark: TLlDOMPropertyBookmark read GetBookmark;
    property ObjectType: TString read GetObjectType; // (r/o)
    property Position: TLlDOMPropertyPosition read GetPosition;
    property Selected: TString read GetSelected write SetSelected;

    property IssueCondition: TString read GetIssueCondition
      write SetIssueCondition;

    procedure LinkTo(parentObject: TLlDOMObjectBase); overload;
    procedure LinkTo(parentObject: TLlDOMObjectBase; verticalLinkType: integer;
      verticalSizeAdaptionType: integer); overload;
    procedure LinkTo(parentObject: TLlDOMObjectBase; verticalLinkType: integer;
      verticalSizeAdaptionType: integer; horizontalLinkType: integer;
      horizontalSizeAdaptionType: integer); overload;
    destructor Destroy; override;
  end;
   {CheckBoxObject}
  TLlDOMPropertyCheckboxItemForResource = class(TLlDOMItem)
    private
      function GetContents: TString;
      procedure SetContents(const value: TString);
      function GetFrameColor: TString;
      procedure SetFrameColor(const value: TString);
      function GetIconColor: TString;
      procedure SetIconColor(const value: TString);
    public
      property Contents: TString read GetContents write SetContents;
      property FrameColor: TString read GetFrameColor write SetFrameColor;
      property IconColor: TString read GetIconColor write SetIconColor;
  end;

  TLlDOMPropertyCheckboxItemFor = class(TLlDOMItem)
    private
      fExternal: TLlDOMPropertyDrawingContents;
      fResource: TLlDOMPropertyCheckboxItemForResource;
      procedure SetContents(const value: TString);
      function GetContents: TString;
      function GetExternal: TLlDOMPropertyDrawingContents;
      function GetResource: TLlDOMPropertyCheckboxItemForResource;
    public
      property Externa: TLlDOMPropertyDrawingContents read GetExternal;
      property Contents: TString read GetContents write SetContents;
      property Resource: TLlDOMPropertyCheckboxItemForResource read GetResource;
      destructor Destroy; override;
  end;

  TLlDOMPropertyCheckboxDesign = class(TLlDOMItem)
    private
      fItemForFalse: TLlDOMPropertyCheckboxItemFor;
      fItemForNULL: TLlDOMPropertyCheckboxItemFor;
      fItemForTrue: TLlDOMPropertyCheckboxItemFor;
      function GetItemForFalse: TLlDOMPropertyCheckboxItemFor;
      function GetItemForNULL: TLlDOMPropertyCheckboxItemFor;
      function GetItemForTrue: TLlDOMPropertyCheckboxItemFor;
    public
      property ItemForFalse: TLlDOMPropertyCheckboxItemFor read GetItemForFalse;
      property ItemForNULL: TLlDOMPropertyCheckboxItemFor read GetItemForNULL;
      property ItemForTrue: TLlDOMPropertyCheckboxItemFor read GetItemForTrue;
      destructor Destroy; override;
  end;

  TLlDOMPropertyCheckboxDefinition = class(TLlDOMItem)
    private
      fDesign: TLlDOMPropertyCheckboxDesign;
      function GetDesign:  TLlDOMPropertyCheckboxDesign;
      function GetAligment: TString;
      procedure SetAligment(const value: TString);
      function GetContents: TString;
      procedure SetContents(const value: TString);
      function GetSize: TString;
      procedure SetSize(const value: TString);
    public
      property Design: TLlDOMPropertyCheckboxDesign read GetDesign;
      property Aligment: TString read GetAligment write SetAligment;
      property Contents: TString read GetContents write SetContents;
      property Size: TString read GetSize write SetSize;
      destructor Destroy; override;
  end;

  TLlDOMObjectCheckbox = class(TLlDOMObjectBase)
    private
      fFrame: TLlDOMPropertyFrameCheckBox;
      fDefinition: TLlDOMPropertyCheckboxDefinition;
      function GetFrame: TLlDOMPropertyFrameCheckBox;
      function GetDefinition: TLlDOMPropertyCheckboxDefinition;
      function GetExportAsPicture: TString;
      procedure SetExportAsPicture(const value: TString);
    //hide not needed property from baseclass
     function GetContent: TString;
{$Hints Off}
     property Content: TString read GetContent;
{$Hints On}
    public
     property Frame: TLlDOMPropertyFrameCheckBox read GetFrame;
     property Definition: TLlDOMPropertyCheckboxDefinition read GetDefinition;
     property ExportAsPicture: TString read GetExportAsPicture write SetExportAsPicture;
     constructor Create(list: TLlDOMObjectList); overload;
     constructor Create(list: TLlDOMObjectList; index: integer); overload;
     destructor Destroy; override;
  end;

  TLlDOMTableFieldCheckbox = class(TLlDOMTableField)
    private
     fDefinition: TLlDOMPropertyCheckboxDefinition;
     function GetDefinition: TLlDOMPropertyCheckboxDefinition;
     function GetExportAsPicture: TString;
     procedure SetExportAsPicture(const value: TString);
    public
    property Definition: TLlDOMPropertyCheckboxDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture write SetExportAsPicture;
    constructor Create(list: TLlDOMTableLineFieldList); overload;
    destructor Destroy; override;
  end;

  TLlDOMParagraph = class(TLlDOMItem)
  private
    fWrapping: TLlDOMPropertyWrappingExt;
    fFont: TLlDOMPropertyFont;
    fOutputFormatter: TLlDOMPropertyOutputFormatterBase;
    function GetWrapping: TLlDOMPropertyWrappingExt;
    function GetFont: TLlDOMPropertyFont;
    function GetAdjusted: TString;
    procedure SetAdjusted(const value: TString);
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetLineSpacing: TString;
    procedure SetLineSpacing(const value: TString);
    function GetOptimizeSpaces: TString;
    procedure SetOptimizeSpaces(const value: TString);
    function GetParagraphSpacing: TString;
    procedure SetParagraphSpacing(const value: TString);
    function GetUnerasable: TString;
    procedure SetUnerasable(const value: TString);
    function GetOutputFormatterBase: TLlDOMPropertyOutputFormatterBase;

    function GetTabPosition: TString;
    procedure SetTabPosition(const value: TString);
    function GetTabAlignment: TString;
    procedure SetTabAlignment(const value: TString);

  public
    property Wrapping: TLlDOMPropertyWrappingExt read GetWrapping;
    property Font: TLlDOMPropertyFont read GetFont;
    property Adjusted: TString read GetAdjusted write SetAdjusted;
    property Alignment: TString read GetAlignment write SetAlignment;
    property Condition: TString read GetCondition write SetCondition;
    property Contents: TString read GetContents write SetContents;
    property LineSpacing: TString read GetLineSpacing write SetLineSpacing;
    property OutputFormatter: TLlDOMPropertyOutputFormatterBase
      read GetOutputFormatterBase;
    property OptimizeSpaces: TString read GetOptimizeSpaces
      write SetOptimizeSpaces;
    property ParagraphSpacing: TString read GetParagraphSpacing
      write SetParagraphSpacing;
    property Unerasable: TString read GetUnerasable write SetUnerasable;

    property TabPosition: TString read GetTabPosition write SetTabPosition;
    property TabAlignment: TString read GetTabAlignment write SetTabAlignment;

    constructor Create(list: TLlDOMParagraphList); overload;
    destructor Destroy; override;
  end;

  TLlDOMPropertyPageBreakOptions = class(TLlDOMItem)
    private
      function GetBreak: TString;
      procedure SetBreak(const value: TString);
      function GetResetPageNumberOption: TString;
      procedure SetResetPageNumberOption(const value: TString);
    public
      property Break: TString read GetBreak write SetBreak;
      property ResetPageNumberOption: TString read GetResetPageNumberOption
        write SetResetPageNumberOption;
  end;


  TLlDOMSubItemCore = class(TLlDOMItem)
  private    
    fBreakBefore: TLlDOMPropertyPageBreakOptions;    
    function GetFilter: TString;
    procedure SetFilter(const value: TString);
    function GetDistanceBottom: TString;
    procedure SetDistanceBottom(const value: TString);
    function GetCondition: TString;
    procedure SetCondition(const value: TString);
    function GetDistanceTop: TString;
    procedure SetDistanceTop(const value: TString);
    function GetName: TString;
    procedure SetName(const value: TString);
    function GetObjectType: TString;
    function GetBreakBefore: TLlDOMPropertyPageBreakOptions;

  public
    property DistanceBottom: TString read GetDistanceBottom write SetDistanceBottom;    
    property Filter: TString read GetFilter write SetFilter;
    property Condition: TString read GetCondition write SetCondition;
    property DistanceTop: TString read GetDistanceTop write SetDistanceTop;
    property Name: TString read GetName write SetName;
    property ObjectType: TString read GetObjectType;
    property BreakBefore: TLlDOMPropertyPageBreakOptions read GetBreakBefore;
    
    constructor Create(list: TLlDOMSubItemCoreList; objType: TString;
      index: integer); overload;
    destructor Destroy; override;

  end;


  TLlDOMSubItemBase = class(TLlDOMSubItemCore)
  private
	fColumns: TLlDOMPropertyColumns;
	fAnimation: TLlDomPropertyAnimation;
  fXhtmlAnimation: TLlDomPropertyXhtmlAnimation;
	function GetTableID: TString;
  procedure SetTableID(const value: TString);
	function GetColumns: TLlDOMPropertyColumns;
  function GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
	function GetAnimation: TLlDOMPropertyAnimation;

  public
  property TableId: TString read GetTableId write SetTableID;
	property Columns: TLlDOMPropertyColumns read GetColumns;
	property Animation: TLlDOMPropertyAnimation read GetAnimation;
  property XhtmlAnimation: TLlDOMPropertyXhtmlAnimation read GetXhtmlAnimation;
      constructor Create(list: TLlDOMSubItemCoreList; objType: TString;
      index: integer); overload;
    destructor Destroy; override;
  end;
  
  TLlDOMSubItemSubReport = class(TLLDOMSubItemCore)
  private
    function GetScaling: TString;
    procedure SetScaling(const value: TString);
	function GetLinked: TString;
    procedure SetLinked(const value: TString);
	function GetLinkUUID: TString;
    procedure SetLinkUUID(const value: TString);
	function GetRelation: TString;
    procedure SetRelation(const value: TString);
	function GetSource: TString;
    procedure SetSource(const value: TString);	
    function GetExpandable: TString;
    procedure SetExpandable(const value: TString);
	
	
  public
	property Scaling : TString read GetScaling write SetScaling;
	property Linked: TString read GetLinked write SetLinked;
	property LinkUUID: TString read GetLinkUUID write SetLinkUUID;
	property Relation: TString read GetRelation write SetRelation;
	property Source: TString read GetSource write SetSource;
    property Expandable: TString read GetExpandable write SetExpandable;	
    constructor Create(list: TLlDOMSubItemCoreList); overload;

  end;
  
  TLlDOMSubItemCrosstab = class(TLlDOMSubItemBase)
  private
    fDefinition: TLlDOMPropertyCrosstabDefinition;
    fBorderDistance: TLlDOMPropertyReservedSpace;
    function GetSourceTablePath: TString;
    procedure SetSourceTablePath(const value: TString);
    function GetDefinition: TLlDOMPropertyCrosstabDefinition;
    function GetBorderDistance: TLlDOMPropertyReservedSpace;
  public
    property Definition: TLlDOMPropertyCrosstabDefinition read GetDefinition;
    property BorderDistance: TLlDOMPropertyReservedSpace read GetBorderDistance;
    property SourceTablePath: TString read GetSourceTablePath
      write SetSourceTablePath;

    destructor Destroy; override;
    constructor Create(list: TLlDOMSubItemCoreList); overload;
  end;

  TLlDOMSubItemTableBase = class(TLlDOMSubItemBase)
  private

    fDefaultFrame: TLlDOMPropertyFrame;
    fFixedSize: TLlDOMPropertyFixedSize;

    function GetExpandable: TString;
    procedure SetExpandable(const value: TString);

    function GetPageBreakCondition: TString;
    procedure SetPageBreakCondition(const value: TString);

    function GetDefaultFrame: TLlDOMPropertyFrame;

    function GetFixedSize: TLlDOMPropertyFixedSize;

    function GetShowSeparatorTickmarks: TString;
    procedure SetShowSeparatorTickmarks(const value: TString);

    function GetTableId: TString;
    procedure SetTableId(const value: TString);

    function GetSortOrderId: TString;
    procedure SetSortOrderId(const value: TString);

  public

    property PageBreakCondition: TString read GetPageBreakCondition
      write SetPageBreakCondition;
    property DefaultFrame: TLlDOMPropertyFrame read GetDefaultFrame;
    property FixedSize: TLlDOMPropertyFixedSize read GetFixedSize;
    property ShowSeparatorTickmarks: TString read GetShowSeparatorTickmarks
      write SetShowSeparatorTickmarks;
    property TableId: TString read GetTableId write SetTableId;
    property SortOrderId: TString read GetSortOrderId write SetSortOrderId;
    property Expandable: TString read GetExpandable write SetExpandable;
    constructor Create(list: TLlDOMSubItemCoreList); overload;
    destructor Destroy; override;

  end;

  TLlDOMSubItemStaticTable = class(TLlDOMSubItemTableBase)
  private

    fLines: TLlDOMTableLinesStaticTable;
    fLineOptions: TLlDOMPropertyStaticTableLines;

    function GetLineOptions: TLlDOMPropertyStaticTableLines;
    function GetLines: TLlDOMTableLinesStaticTable;

  public

    property LineOptions: TLlDOMPropertyStaticTableLines read GetLineOptions;
    property Lines: TLlDOMTableLinesStaticTable read GetLines;

    constructor Create(list: TLlDOMSubItemCoreList); overload;
    destructor Destroy; override;

  end;

  TLlDOMSubItemTable = class(TLlDOMSubItemTableBase)
  private

    fLineOptions: TLlDOMPropertyTableLines;
    fLines: TLlDOMTableLines;
    fSubItems: TLlDOMSubItemCoreList;

    function GetSubItems: TLlDOMSubItemCoreList;

    function GetLineOptions: TLlDOMPropertyTableLines;

    function GetLines: TLlDOMTableLines;

    function GetRelationID: TString;
    procedure SetRelationID(const value: TString);

  public

    property SubItems: TLlDOMSubItemCoreList read GetSubItems;
    property Lines: TLlDOMTableLines read GetLines;
    property LineOptions: TLlDOMPropertyTableLines read GetLineOptions;
    property RelationID: TString read GetRelationID write SetRelationID;

    constructor Create(list: TLlDOMSubItemCoreList); overload;
    destructor Destroy; override;

  end;

  TLlDOMSubItemChart = class(TLlDOMSubItemBase)
  private
    fBorderDistance: TLlDOMPropertyReservedSpace;
    fDefinition: TLlDOMPropertyChartDefinition;
    function GetHeight: TString;
    procedure SetHeight(const value: TString);
    function GetSortOrderId: TString;
    procedure SetSortOrderId(const value: TString);
    function GetSourceTablePath: TString;
    procedure SetSourceTablePath(const value: TString);
    function GetBorderDistance: TLlDOMPropertyReservedSpace;
    function GetDefinition: TLlDOMPropertyChartDefinition;
    function GetReserveSpaceForSubtitle: TString;
    procedure SetReserveSpaceForSubtitle(const value: TString);
  public
    property BorderDistance: TLlDOMPropertyReservedSpace read GetBorderDistance;
    property Definition: TLlDOMPropertyChartDefinition read GetDefinition;
    property Height: TString read GetHeight write SetHeight;
    property ReserveSpaceForSubtitle: TString read GetReserveSpaceForSubtitle
      write SetReserveSpaceForSubtitle;
    property SortOrderId: TString read GetSortOrderId write SetSortOrderId;
    property SourceTablePath: TString read GetSourceTablePath
      write SetSourceTablePath;

    destructor Destroy; override;
    constructor Create(ChartType: TLlDOMChartType;
      list: TLlDOMSubItemCoreList); overload;
  end;

  TLlDOMSubItemGanttChart = class(TLlDOMSubItemBase)
  private
    fBookmark: TLlDOMPropertyBookmark;
    fIndexBookmark: TLlDOMPropertyBookmark;
    fBorderDistance: TLlDOMPropertyReservedSpace;
    fDefinition: TLlDomPropertyGanttChartDefinition;

    function GetSourceTablePath: TString;
    procedure SetSourceTablePath(const value: TString);

    function GetBorderDistance: TLlDOMPropertyReservedSpace;
    function GetBookmark: TLlDOMPropertyBookmark;
    function GetIndexBookmark: TLlDOMPropertyBookmark;
    function GetDefinition: TLlDomPropertyGanttChartDefinition;
  public
    constructor Create(list: TLlDOMSubItemCoreList); overload;
    destructor Destroy; override;

    property Definition: TLlDomPropertyGanttChartDefinition read GetDefinition;
    property SourceTablePath: TString read GetSourceTablePath
      write SetSourceTablePath;
    property BorderDistance: TLlDOMPropertyReservedSpace read GetBorderDistance;
    property Bookmark: TLlDOMPropertyBookmark read GetBookmark;
    property IndexBookmark: TLlDOMPropertyBookmark read GetIndexBookmark;
  end;

  TLlDOMObjectInputBase = class(TLlDOMObjectBase)
  private
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetInputObjectType: TString;
    procedure SetInputObjectType(const value: TString);
    function GetTooltip: TString;
    procedure SetTooltip(const value: TString);
    //hide not needed property from baseclass
    function GetAnimation: TLlDOMPropertyAnimation;
{$Hints Off}
    property Animation read GetAnimation;
{$Hints On}
    function GetUneditable: TString;
    procedure SetUneditable(const value: TString);


  public
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property InputObjectType: TString read GetInputObjectType
      write SetInputObjectType;
    property Tooltip: TString read GetTooltip write SetTooltip;
    property Uneditable: TString read GetUneditable write SetUneditable;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
  end;

  TLlDOMObjectInputEdit = class(TLlDOMObjectInputBase)
  private
    fFrame: TLlDOMPropertyFrameExt;
    fFilling: TLlDOMPropertyTextFilling;
    fFont: TLlDOMPropertyFont;
    fVerification: TLlDOMPropertyVerification;
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetFrameExt: TLlDOMPropertyFrameExt;
    function GetTextFilling: TLlDOMPropertyTextFilling;
    function GetDefaultValue: TString;
    procedure SetDefaultValue(const value: TString);
    function GetFieldName: TString;
    procedure SetFieldName(const value: TString);
    function GetFont: TLlDOMPropertyFont;
    function GetMultiline: TString;
    procedure SetMultiline(const value: TString);
    function GetNeedInput: TString;
    procedure SetNeedInput(const value: TString);
    function GetVerification: TLlDOMPropertyVerification;
  public
    property Frame: TLlDOMPropertyFrameExt read GetFrameExt;
    property Font: TLlDOMPropertyFont read GetFont;
    property Verification: TLlDOMPropertyVerification read GetVerification;
    property Filling: TLlDOMPropertyTextFilling read GetTextFilling;
    property Alignment: TString read GetAlignment write SetAlignment;
    property DefaultValue: TString read GetDefaultValue write SetDefaultValue;
    property FieldName: TString read GetFieldName write SetFieldName;
    property Multiline: TString read GetMultiline write SetMultiline;
    property NeedInput: TString read GetNeedInput write SetNeedInput;
    destructor Destroy; override;
  end;

  TLlDOMObjectInputCheckbox = class(TLlDOMObjectInputBase)
  private
    fFrame: TLlDOMPropertyFrameExt;
    fFilling: TLlDOMPropertyTextFilling;
    function GetCheckboxType: TString;
    procedure SetCheckboxType(const value: TString);
    function GetDefaultValue: TString;
    procedure SetDefaultValue(const value: TString);
    function GetFieldName: TString;
    procedure SetFieldName(const value: TString);
    function GetTextFilling: TLlDOMPropertyTextFilling;
    function GetFrameExt: TLlDOMPropertyFrameExt;
  public
    property Filling: TLlDOMPropertyTextFilling read GetTextFilling;
    property Frame: TLlDOMPropertyFrameExt read GetFrameExt;
    property CheckboxType: TString read GetCheckboxType write SetCheckboxType;
    property DefaultValue: TString read GetDefaultValue write SetDefaultValue;
    property FieldName: TString read GetFieldName write SetFieldName;
    destructor Destroy; override;
  end;

  TLlDOMObjectInputCombobox = class(TLlDOMObjectInputBase)
  private
    fFilling: TLlDOMPropertyTextFilling;
    fFont: TLlDOMPropertyFont;
    fFrame: TLlDOMPropertyFrameExt;
    function GetTextFilling: TLlDOMPropertyTextFilling;
    function GetFont: TLlDOMPropertyFont;
    function GetFrameExt: TLlDOMPropertyFrameExt;
    function GetAlignment: TString;
    procedure SetAlignment(const value: TString);
    function GetChoices: TString;
    procedure SetChoices(const value: TString);
    function GetDefaultValue: TString;
    procedure SetDefaultValue(const value: TString);
    function GetEditable: TString;
    procedure SetEditable(const value: TString);
    function GetFieldName: TString;
    procedure SetFieldName(const value: TString);
    function GetNeedInput: TString;
    procedure SetNeedInput(const value: TString);
  public
    property Filling: TLlDOMPropertyTextFilling read GetTextFilling;
    property Font: TLlDOMPropertyFont read GetFont;
    property Frame: TLlDOMPropertyFrameExt read GetFrameExt;
    property Alignment: TString read GetAlignment write SetAlignment;
    property Choices: TString read GetChoices write SetChoices;
    property DefaultValue: TString read GetDefaultValue write SetDefaultValue;
    property Editable: TString read GetEditable write SetEditable;
    property FieldName: TString read GetFieldName write SetFieldName;
    property NeedInput: TString read GetNeedInput write SetNeedInput;

    destructor Destroy; override;
  end;

  TLlDOMObjectInputButton = class(TLlDOMObjectInputBase)
  private
    fFont: TLlDOMPropertyFont;
    fAction: TLlDOMPropertyInputButtonActionBase;
    function GetFont: TLlDOMPropertyFont;
    function GetAction: TLlDOMPropertyInputButtonActionBase;
    function GetText: TString;
    procedure SetText(const value: TString);
  public
    property Font: TLlDOMPropertyFont read GetFont;
    property Action: TLlDOMPropertyInputButtonActionBase read GetAction;
    property Text: TString read GetText write SetText;
    constructor Create (actionType: TLLDOMButtonActionType; list: TLlDOMObjectList); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectTemplate = class(TLlDOMObjectBase)
  private
    fFileinfo: TLlDOMPropertyFileInfo;
    function GetColorFade: TString;
    procedure SetColorFade(const value: TString);
    function GetFileinfo: TLlDOMPropertyFileInfo;
    function GetIsotropic: TString;
    procedure SetIsotropic(const value: TString);
    function GetShowOnPreview: TString;
    procedure SetShowOnPreview(const value: TString);
  public
    property ColorFade: TString read GetColorFade write SetColorFade;
    property Fileinfo: TLlDOMPropertyFileInfo read GetFileinfo;
    property Isotropic: TString read GetIsotropic write SetIsotropic;
    property ShowOnPreview: TString read GetShowOnPreview
      write SetShowOnPreview;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectDesignerObject = class(TLlDOMObjectBase)
  public
    constructor Create(objectName: TString; list: TLlDOMObjectList); overload;
    constructor Create(objectName: TString; list: TLlDOMObjectList;
      index: integer); overload;
  end;

  TLlDOMObjectLine = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    function GetColor: TString;
    procedure SetColor(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetLineDirection: TString;
    procedure SetLineDirection(const value: TString);
    function GetLineType: TString;
    procedure SetLineType(const value: TString);
    function GetWidth: TString;
    procedure SetWidth(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
  public
    property Color: TString read GetColor write SetColor;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property LineDirection: TString read GetLineDirection
      write SetLineDirection;
    property LineType: TString read GetLineType write SetLineType;
    property Width: TString read GetWidth write SetWidth;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectHTML = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
	function GetAllowPageBreak: TString;
    procedure SetAllowPageBreak(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetContentType: TString;
    procedure SetContentType(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFitToObject: TString;
    procedure SetFitToObject(const value: TString);
  public
  	property AllowPageBreak: TString read GetAllowPageBreak
      write SetAllowPageBreak;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Contents: TString read GetContents write SetContents;
    property ContentType: TString read GetContentType write SetContentType;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property FitToObject: TString read GetFitToObject write SetFitToObject;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectRectangle = class(TLlDOMObjectBase)
  private
    fFilling: TLlDOMPropertyFilling;
    fShadow: TLlDOMPropertyShadow;
    fFrame: TLlDOMPropertyFrameExt;
    function GetRounding: TString;
    procedure SetRounding(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetShadow: TLlDOMPropertyShadow;
    function GetFrame: TLlDOMPropertyFrameExt;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
  public
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Frame: TLlDOMPropertyFrameExt read GetFrame;
    property Rounding: TString read GetRounding write SetRounding;
    property Shadow: TLlDOMPropertyShadow read GetShadow;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectEllipse = class(TLlDOMObjectBase)
  private
    fFilling: TLlDOMPropertyFilling;
    fFrame: TLlDOMPropertyFrameExt;
    function GetCircle: TString;
    procedure SetCircle(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFilling: TLlDOMPropertyFilling;
    function GetFrame: TLlDOMPropertyFrameExt;
  public
    property Circle: TString read GetCircle write SetCircle;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Frame: TLlDOMPropertyFrameExt read GetFrame;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectDrawing = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fSource: TLlDOMPropertyDrawingContents;
    function GetFrame: TLlDOMPropertyFrame;
    function GetSource: TLlDOMPropertyDrawingContents;
  public
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Source: TLlDOMPropertyDrawingContents read GetSource;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectRTF = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fSource: TLlDOMPropertyRTFSource;
    function GetAllowPageBreak: TString;
    procedure SetAllowPageBreak(const value: TString);
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetSourceLinkID: TString;
    procedure SetSourceLinkID(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetRTFSource: TLlDOMPropertyRTFSource;
    //function GetSourceLinkUUID: TString;
    //procedure SetSourceLinkUUID(const value: TString);
    // property SourceLinkUUID: TString read GetSourceLinkUUID write SetSourceLinkUUID;
    property SourceLinkID: TString read GetSourceLinkID write SetSourceLinkID;
  public
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Source: TLlDOMPropertyRTFSource read GetRTFSource;
    property AllowPageBreak: TString read GetAllowPageBreak
      write SetAllowPageBreak;
    property Direction: TString read GetDirection write SetDirection;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;

    procedure SourceUnlink;
    procedure SourceLinkTo(parentObject: TLlDOMObjectRTF);
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

TLlDOMPropertyMatchDevicePixel = class(TLlDOMItem)
 private
    function GetContents: TString;
    procedure SetContents(const value: TString);
    function GetDotSizeReduction: TString;
    procedure SetDotSizeReduction(const value: TString);

 public
    property Contents: TString read GetContents write SetContents;
    property DotSizeReduction: TString read GetDotSizeReduction write SetDotSizeReduction;
  end;

  TLlDOMObjectBarcode = class(TLlDOMObjectBase)
  private
    fFixedBarOptions: TLlDOMPropertyFixedBarOptions;
    fFont: TLlDOMPropertyFont;
    fFrame: TLlDOMPropertyFrame;
    fSource: TLlDOMPropertyBarcodeSource;
    fMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
    function GetBarRatio: TString;
    procedure SetBarRatio(const value: TString);
    function GetBarColor: TString;
    procedure SetBarColor(const value: TString);
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetUseDefSize: TString;
    procedure SetUseDefSize(const value: TString);
    function GetWithText: TString;
    procedure SetWithText(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFixedBarOptions: TLlDOMPropertyFixedBarOptions;
    function GetFont: TLlDOMPropertyFont;
    function GetFrame: TLlDOMPropertyFrame;
    function GetBarcodeSource: TLlDOMPropertyBarcodeSource;
    function GetMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
  public
    property FixedBarOptions: TLlDOMPropertyFixedBarOptions
      read GetFixedBarOptions;
    property Font: TLlDOMPropertyFont read GetFont;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Source: TLlDOMPropertyBarcodeSource read GetBarcodeSource;
    property BarRatio: TString read GetBarRatio write SetBarRatio;
    property BarColor: TString read GetBarColor write SetBarColor;
    property Direction: TString read GetDirection write SetDirection;
    property UseDefSize: TString read GetUseDefSize write SetUseDefSize;
    property WithText: TString read GetWithText write SetWithText;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property MatchDevicePixel: TLlDOMPropertyMatchDevicePixel read GetMatchDevicePixel;
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;


  TLlDOMObjectText = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fFilling: TLlDOMPropertyTextFilling;
    fParagraphList: TLlDOMParagraphList;
    function GetFrame: TLlDOMPropertyFrame;
    function GetFilling: TLlDOMPropertyTextFilling;
    function GetAllowPageBreak: TString;
    procedure SetAllowPageBreak(const value: TString);
    function GetBottomAligned: TString;
    procedure SetBottomAligned(const value: TString);
    function GetDirection: TString;
    procedure SetDirection(const value: TString);
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetParagraphList: TLlDOMParagraphList;
  public
    property Paragraphs: TLlDOMParagraphList read GetParagraphList;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Filling: TLlDOMPropertyTextFilling read GetFilling;
    property AllowPageBreak: TString read GetAllowPageBreak
      write SetAllowPageBreak;
    property BottomAligned: TString read GetBottomAligned
      write SetBottomAligned;
    property Direction: TString read GetDirection write SetDirection;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectReportContainer = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fDefaultColumns: TLlDOMPropertyDefaultColumns;
    fDefaultFont: TLlDOMPropertyDefaultFont;
    fFilling: TLlDOMPropertyFilling;
    fSubItemList: TLlDOMSubItemCoreList;
    function GetFrame: TLlDOMPropertyFrame;
    function GetDefaultFont: TLlDOMPropertyDefaultFont;
    function GetFilling: TLlDOMPropertyFilling;
    function GetSubItemList: TLlDOMSubItemCoreList;
    function GetDefaultColumns: TLlDOMPropertyDefaultColumns;
  public
    property DefaultColumns: TLlDOMPropertyDefaultColumns
      read GetDefaultColumns;
    property SubItems: TLlDOMSubItemCoreList read GetSubItemList;
    property DefaultFont: TLlDOMPropertyDefaultFont read GetDefaultFont;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Frame: TLlDOMPropertyFrame read GetFrame;
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectChart = class(TLlDOMObjectBase)
  private
    fFilling: TLlDOMPropertyFilling;
    fDefinition: TLlDOMPropertyChartDefinition;
    fFrame: TLlDOMPropertyFrame;
    function GetDefinition: TLlDOMPropertyChartDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetFilling: TLlDOMPropertyFilling;
  public
    property Definition: TLlDOMPropertyChartDefinition read GetDefinition;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Filling: TLlDOMPropertyFilling read GetFilling;
    property Frame: TLlDOMPropertyFrame read GetFrame;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    constructor Create(ChartType: TLlDOMChartType; list: TLlDOMObjectList;
      index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMObjectDataGraphic = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fDefinition: TLlDOMPropertyDataGraphicDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetDefinition: TLlDOMPropertyDataGraphicDefinition;
  public
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;

    property Frame: TLlDOMPropertyFrame read GetFrame;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Definition: TLlDOMPropertyDataGraphicDefinition read GetDefinition;
  end;

  { PDF }
  TLlDOMObjectPDF = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fDefinition: TLlDOMPropertyPDFDefinition;
    function GetFrame: TLlDOMPropertyFrame;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetDefinition: TLlDOMPropertyPDFDefinition;
  public
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;

    property Frame: TLlDOMPropertyFrame read GetFrame;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Definition: TLlDOMPropertyPDFDefinition read GetDefinition;

  end;

  { GAUGE }
  TLlDOMObjectGauge = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fDefinition: TLlDOMPropertyGaugeDefinition;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetFrame: TLlDOMPropertyFrame;
    function GetDefinition: TLlDOMPropertyGaugeDefinition;
  public
    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    constructor Create(GaugeType: TLlDOMGaugeType; list: TLlDOMObjectList;
      index: integer); overload;
    destructor Destroy; override;

    property Frame: TLlDOMPropertyFrame read GetFrame;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;
    property Definition: TLlDOMPropertyGaugeDefinition read GetDefinition;
  end;

  TLlDOMObjectCrosstab = class(TLlDOMObjectBase)
  private
    fFrame: TLlDOMPropertyFrame;
    fDefinition: TLlDOMPropertyCrosstabDefinition;
    function GetFrame: TLlDOMPropertyFrame;
    function GetExportAsPicture: TString;
    procedure SetExportAsPicture(const value: TString);
    function GetDefintion: TLlDOMPropertyCrosstabDefinition;
  public
    property Frame: TLlDOMPropertyFrame read GetFrame;
    property Defintion: TLlDOMPropertyCrosstabDefinition read GetDefintion;
    property ExportAsPicture: TString read GetExportAsPicture
      write SetExportAsPicture;

    constructor Create(list: TLlDOMObjectList); overload;
    constructor Create(list: TLlDOMObjectList; index: integer); overload;
    destructor Destroy; override;
  end;

  TLlDOMTableLineBaseList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMTableLineBase;
    procedure SetItems(index: integer; const value: TLlDOMTableLineBase);
    function Add(domObj: TLlDOMTableLineBase): integer;
  public
    property Items[index: integer]: TLlDOMTableLineBase read GetItems
      write SetItems;

    function NewItem(index: integer; ObjectType: TString): TLlDOMItem;
  end;

  TLlDOMTableLineFooterList = class(TLlDOMTableLineBaseList)
  private
    procedure Initialize; override;
  public
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMTableLineGroupFooterList = class(TLlDOMTableLineBaseList)
  private
    procedure Initialize; override;
  public
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMTableLineGroupHeaderList = class(TLlDOMTableLineBaseList)
  private
    procedure Initialize; override;
  public
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMTableLineDataList = class(TLlDOMTableLineBaseList)
  private
    procedure Initialize; override;
  public
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMTableLineHeaderList = class(TLlDOMTableLineBaseList)
  private
    procedure Initialize; override;
  public
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMTableLineFieldList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMTableField;
    procedure SetItems(index: integer; const value: TLlDOMTableField);
    function Add(domObj: TLlDOMTableField): integer;
    procedure Initialize; override;
  public
    property Items[index: integer]: TLlDOMTableField read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer; ObjectType: TString): TLlDOMItem;
  end;

  TLlDOMCrosstabCellBaseList = class(TLlDOMList)
  private
    function Add(domObj: TLlDOMPropertyCrosstabDimensionCellBase): integer;
  public
    constructor Create(hDomObj: TLlDOMItem);
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMCrosstabCellSumLabelList = class(TLlDOMCrosstabCellBaseList)
  private
    procedure Initialize; override;
    function GetItems(index: integer)
      : TLlDOMPropertyCrosstabDimensionSumLabelCell;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyCrosstabDimensionSumLabelCell);
  public
    property Items[index: integer]: TLlDOMPropertyCrosstabDimensionSumLabelCell
      read GetItems write SetItems; default;
    destructor Destroy; override;
  end;

  TLlDOMCrosstabCellGroupLabelList = class(TLlDOMCrosstabCellBaseList)
  private
      procedure Initialize; override;
    function GetItems(index: integer)
      : TLlDOMPropertyCrosstabDimensionGroupLabelCell;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyCrosstabDimensionGroupLabelCell);
  public
    property Items[index: integer]
      : TLlDOMPropertyCrosstabDimensionGroupLabelCell read GetItems
      write SetItems; default;

    destructor Destroy; override;
  end;

  TLlDOMCrosstabFormulaList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertyCrosstabDimensionGrouping;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyCrosstabDimensionGrouping);
    procedure Initialize; override;
  public
    property Items[index: integer]: TLlDOMPropertyCrosstabDimensionGrouping
      read GetItems write SetItems; default;

    function Add(value: TString): integer;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMCrosstabCellsList = class(TLlDOMList)
  private
    fCrosstabCells: TList;
    function GetItems(index: integer): TLlDOMPropertyCrosstabCells;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyCrosstabCells);
    function Add(domObj: TLlDOMPropertyCrosstabCells): integer;
    procedure Initialize; override;
    function GetAll: TLlDOMPropertyCrosstabCells;

  public
    property Items[index: integer]: TLlDOMPropertyCrosstabCells read GetItems
      write SetItems; default;
    function GetSubCell(cellLevel, rowLevel, subCellLevel: integer): TLlDOMPropertyCrosstabCells;
    property All: TLlDOMPropertyCrosstabCells read GetAll;
    function NewItem(index: integer): TLlDOMItem;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
  end;

  TLlDOMSubItemCoreList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMSubItemCore;
    procedure SetItems(index: integer; const value: TLlDOMSubItemCore);
    function Add(domObj: TLlDOMSubItemCore): integer;
    procedure Initialize; override;
  public
    property Items[index: integer]: TLlDOMSubItemCore read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer; ObjectType: TString): TLlDOMItem;
  end;

  TLlDOMParagraphList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMParagraph;
    procedure SetItems(index: integer; const value: TLlDOMParagraph);
    function Add(domObj: TLlDOMParagraph): integer;
    procedure Initialize; override;
  public
    property Items[Index: integer]: TLlDOMParagraph read GetItems
      write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMChartConditionalColorsList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMPropertyChartConditionalColor;
    procedure SetItems(index: integer;
      const value: TLlDOMPropertyChartConditionalColor);
    function Add(domObj: TLlDOMPropertyChartConditionalColor): integer;
    procedure Initialize; override;
  public
    property Items[index: integer]: TLlDOMPropertyChartConditionalColor
      read GetItems write SetItems; default;

    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer): TLlDOMItem;
  end;

  TLlDOMObjectList = class(TLlDOMList)
  private
    function GetItems(index: integer): TLlDOMObjectBase;
    procedure SetItems(index: integer; const value: TLlDOMObjectBase);
    procedure Initialize; override;
    function Add(domObj: TLlDOMObjectBase): integer;
    function GetItemName(Name: TString): TLlDOMObjectBase;
    procedure SetItemName(Name: TString; const value: TLlDOMObjectBase);
  public
    property Items[Index: integer]: TLlDOMObjectBase read GetItems
      write SetItems; default;
    property ItemName[Name: TString]: TLlDOMObjectBase read GetItemName
      write SetItemName;
    constructor Create(hDomObj: TLlDOMItem);
    destructor Destroy; override;
    function NewItem(index: integer; ObjectType: TString): TLlDOMItem;
  end;

  function GetProfContentsFromVariant(input: PCVARIANT) :TString;
  function GetVariantFromProfContents(text: PWideChar): OleVariant;

implementation

{ TDomProcect }

procedure TLlDOMProjectBase.Close;
begin
  fDomHandle := nil;
  if projectLoaded then
  begin
    if Assigned(fSumVariableList) then
    begin
      SumVariableList.Free;
      fSumVariableList := nil;
    end;
    if Assigned(fUserVariableList) then
    begin
      UserVariableList.Free;
      fUserVariableList := nil;
    end;
    if Assigned(fObjectList) then
    begin
      ObjectList.Free;
      fObjectList := nil;
    end;

    if Assigned(fSettings) then
    begin
      Settings.Free;
      fSettings := nil;
    end;

    if Assigned(fProjectParameterList) then
    begin
      ProjectParameterList.Free;
      fProjectParameterList := nil;
    end;

    if Assigned(fLayerList) then
    begin
      Layers.Free;
      fLayerList := nil;
    end;

    if Assigned(fRegionList) then
    begin
      Regions.Free;
      fRegionList := nil;
    end;

    if Assigned(fProjectTemplateList) then
    begin
      ProjectTemplates.Free;
      fProjectTemplateList := nil;
    end;
{$IFDEF USELLXOBJECTS}
    LlSetOption(fhParentComponent.GetJobHandle, 53, 0);
{$ENDIF}
    LlProjectClose(fhParentComponent.GetJobHandle);
    projectLoaded := False;
  end;
end;

constructor TLlDOMProjectBase.Create(hTheParentComponent: ILlDomParent);
begin
  inherited Create();
  fhParentComponent := hTheParentComponent;
  projectLoaded := False;
end;

destructor TLlDOMProjectBase.Destroy;
begin
  if Assigned(fSumVariableList) then
    fSumVariableList.Free;
  if Assigned(fUserVariableList) then
    fUserVariableList.Free;
  if Assigned(fObjectList) then
    fObjectList.Free;
  if Assigned(fSettings) then
    fSettings.Free;
  if Assigned(fProjectParameterList) then
    fProjectParameterList.Free;
  if Assigned(fLayerList) then
    fLayerList.Free;
  if Assigned(fRegionList) then
    fRegionList.Free;
  if Assigned(fProjectTemplateList) then
    fProjectTemplateList.Free;
  inherited;
end;

procedure TLlDOMProjectBase.ResetInformation;
begin
  if Assigned(fSumVariableList) then
  begin
    fSumVariableList.Free;
    fSumVariableList := nil;
  end;
  if Assigned(fUserVariableList) then
  begin
    fUserVariableList.Free;
    fUserVariableList := nil;
  end;
  if Assigned(fObjectList) then
  begin
    fObjectList.Free;
    fObjectList := nil;
  end;
  if Assigned(fSettings) then
  begin
    fSettings.Free;
    fSettings := nil;
  end;
  if Assigned(fProjectParameterList) then
  begin
    fProjectParameterList.Free;
    fProjectParameterList := nil;
  end;
  if Assigned(fLayerList) then
  begin
    fLayerList.Free;
    fLayerList := nil;
  end;
  if Assigned(fRegionList) then
  begin
    fRegionList.Free;
    fRegionList := nil;
  end;
  if Assigned(fProjectTemplateList) then
  begin
    fProjectTemplateList.Free;
    fProjectTemplateList := nil;
  end;
end;

function TLlDOMProjectBase.GetChanged: TString;
begin
  result := GetProperty('Changed');
end;

procedure TLlDOMProjectBase.GetFromParent;
begin
  Close();
  LlDomGetProject(fhParentComponent.GetJobHandle, @fDomHandle);
end;

function TLlDOMProjectBase.GetLayerList: TLlDOMLayerList;
begin
  if fLayerList = nil then
  begin
    fLayerList := TLlDOMLayerList.Create(GetObject('Layers'));
  end;
  result := fLayerList;
end;

function TLlDOMProjectBase.GetRegionList: TLlDOMRegionList;
begin
  if fRegionList = nil then
  begin
    fRegionList := TLlDOMRegionList.Create(GetObject('Regions'));
  end;
  result := fRegionList;
end;

function TLlDOMProjectBase.GetReportParameterList: TLlDOMReportParameterList;
begin
  if fReportParameterList = nil then
  begin
    fReportParameterList := TLlDOMReportParameterList.Create
      (GetObject('ReportParameters'));
  end;
  result := fReportParameterList;
end;

function TLlDOMProjectBase.GetObjectList: TLlDOMObjectList;
begin
  if fObjectList = nil then
  begin
    fObjectList := TLlDOMObjectList.Create(GetObject('Objects'));
  end;
  result := fObjectList;
end;

function TLlDOMProjectBase.GetPageRanges: TString;
begin
  result := GetProperty('PageRanges');
end;

function TLlDOMProjectBase.GetProjectParameterList
  : TLlDOMPropertyProjectParameterList;
begin
  if fProjectParameterList = nil then
  begin
    fProjectParameterList := TLlDOMPropertyProjectParameterList.Create
      (GetObject('ProjectParameters'));
  end;
  result := fProjectParameterList;
end;

function TLlDOMProjectBase.GetSettings: TLlDOMPropertySettings;
var
  baseObj: TLlDOMItem;
begin
  if (fSettings <> nil) then
  begin
    result := fSettings
  end
  else
  begin
    baseObj := GetObject('Settings');
    fSettings := TLlDOMPropertySettings.Create(baseObj);
    baseObj.Free;
    result := fSettings;
  end;
end;

function TLlDOMProjectBase.GetSumVariableList: TLlDOMSumVariableList;
begin
  if fSumVariableList = nil then
  begin
    fSumVariableList := TLlDOMSumVariableList.Create(GetObject('SumVars'));
  end;
  result := fSumVariableList;
end;

function TLlDOMProjectBase.GetProjectTemplateList: TLlDOMProjectTemplateList;
begin
  if fProjectTemplateList = nil then
  begin
    fProjectTemplateList := TLlDOMProjectTemplateList.Create
      (GetObject('ProjectTemplates'));
  end;
  result := fProjectTemplateList;
end;

function TLlDOMProjectBase.GetUserVariableList: TLlDOMUserVariableList;
begin
  if fUserVariableList = nil then
  begin
    fUserVariableList := TLlDOMUserVariableList.Create(GetObject('UserVars'));
  end;
  result := fUserVariableList;
end;



function TLlDOMProjectBase.GetCollectionVariablesList: TLlDOMListCollectionVariables;
begin
  if fCollectionVariableList = nil then
  begin
    fCollectionVariableList := TLlDOMListCollectionVariables.Create(GetObject('CollectionVariables'));
  end;
  result := fCollectionVariableList;
end;


function TLlDOMProjectBase.Open(projectFile: TString; fileMode: TLlDOMFileMode;
  readOnly: TLlDomAccessMode; LlDomSettings: longint): integer;
var
  nOpenMode: longint;
begin
  nOpenMode := 0;
  LlProjectClose(fhParentComponent.GetJobHandle);
  fhParentComponent.InitDataSource(projectFile);

  case readOnly of
    amReadOnly:
      nOpenMode := nOpenMode + LL_PRJOPEN_AM_READONLY;
    amReadWrite:
      nOpenMode := nOpenMode + LL_PRJOPEN_AM_READWRITE;
  end;
  case fileMode of
    fmOpen:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_OPEN_EXISTING;
    fmCreate:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_CREATE_ALWAYS;
    fmCreateNew:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_CREATE_NEW;
    fmOpenOrCreate:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_OPEN_ALWAYS;
  end;

  nOpenMode := nOpenMode + LlDomSettings;
{$IFDEF USELLXOBJECTS}
  fhParentComponent.DeclareLlXObjectsToLL;
{$ENDIF}
  result := LlProjectOpen(fhParentComponent.GetJobHandle, projectType,
    PTChar(projectFile), nOpenMode);
  if result = 0 then
  begin
    result := LlDomGetProject(fhParentComponent.GetJobHandle, @fDomHandle);
    projectLoaded := True;
  end;
end;

function TLlDOMProjectBase.Open(projectFile: TString; fileMode: TLlDOMFileMode;
  readOnly: TLlDomAccessMode; ignoreErrors: TLlDOMIgnoreErrors): integer;
var
  nOpenMode: integer;
begin
  nOpenMode := 0;
  LlProjectClose(fhParentComponent.GetJobHandle);
  fhParentComponent.InitDataSource(projectFile);

  case readOnly of
    amReadOnly:
      nOpenMode := nOpenMode + LL_PRJOPEN_AM_READONLY;
    amReadWrite:
      nOpenMode := nOpenMode + LL_PRJOPEN_AM_READWRITE;
  end;
  case fileMode of
    fmOpen:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_OPEN_EXISTING;
    fmCreate:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_CREATE_ALWAYS;
    fmCreateNew:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_CREATE_NEW;
    fmOpenOrCreate:
      nOpenMode := nOpenMode + LL_PRJOPEN_CD_OPEN_ALWAYS;
  end;
  case ignoreErrors of
    ieYes:
      nOpenMode := nOpenMode + longint(LL_PRJOPEN_EM_IGNORE_FORMULAERRORS);
    ieNo:
      nOpenMode := nOpenMode + 0;
  end;
{$IFDEF USELLXOBJECTS}
  fhParentComponent.DeclareLlXObjectsToLL;
{$ENDIF}
  result := LlProjectOpen(fhParentComponent.GetJobHandle, projectType,
    PTChar(projectFile), nOpenMode);
  if result = 0 then
  begin
    result := LlDomGetProject(fhParentComponent.GetJobHandle, @fDomHandle);
    projectLoaded := True;
  end;
end;

function TLlDOMProjectBase.Open(projectFile: TString;
  fileMode: TLlDOMFileMode): integer;
begin
  result := Open(projectFile, fileMode, amReadWrite, ieNo);
end;

function TLlDOMProjectBase.Open(projectFile: TString; fileMode: TLlDOMFileMode;
  readOnly: TLlDomAccessMode): integer;
begin
  result := Open(projectFile, fileMode, readOnly, ieNo);
end;

procedure TLlDOMProjectBase.Save(projectFile: TString);
begin
  if projectLoaded then
  begin
    LlProjectSave(fhParentComponent.GetJobHandle, PTChar(projectFile));
  end;
end;

procedure TLlDOMProjectBase.SaveCopyAs(projectFile: TString);
begin
  if projectLoaded then
  begin
    LlProjectSaveCopyAs(fhParentComponent.GetJobHandle, PTChar(projectFile));
  end;
end;


procedure TLlDOMProjectBase.SetDesignerRedraw(const value: TString);
begin
  SetProperty('DesignerRedraw', value);
end;

procedure TLlDOMProjectBase.SetPageRanges(const value: TString);
begin
  SetProperty('PageRanges', value);
end;
{TLlDOMObjectCheckbox}

constructor TLlDOMObjectCheckbox.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'LLX:LLCheckbox', list.Count);
end;

constructor TLlDOMObjectCheckbox.Create(list: TLlDOMObjectList;
  index: integer);
begin
  inherited Create(list, 'LLX:LLCheckbox', index);
end;

function TLlDOMObjectCheckbox.GetFrame: TLlDOMPropertyFrameCheckBox;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameCheckBox.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectCheckbox.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

function TLlDOMObjectCheckbox.GetExportAsPicture: TString;
begin
  GetProperty('ExportAsPicture')
end;

function TLlDOMObjectCheckbox.GetContent: TString;
begin
  raise Exception.Create('NotImplemented');
end;



function TLlDOMObjectCheckbox.GetDefinition: TLlDOMPropertyCheckboxDefinition;
var
  baseObj: TLlDOMItem;
begin
  if (fDefinition <> nil) then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyCheckboxDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

destructor TLlDOMObjectCheckbox.Destroy;
begin
  fFrame.Free;
  fDefinition.Free;
  inherited;
end;

procedure TLlDOMPropertyCheckboxDefinition.SetAligment(const value: TString);
begin
  SetProperty('Aligment', value);
end;

function  TLlDOMPropertyCheckboxDefinition.GetAligment :TString;
begin
   result := GetProperty('Aligment');
end;


procedure TLlDOMPropertyCheckboxDefinition.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

function  TLlDOMPropertyCheckboxDefinition.GetContents :TString;
begin
   result := GetProperty('Contents');
end;

procedure TLlDOMPropertyCheckboxDefinition.SetSize(const value: TString);
begin
  SetProperty('Size', value);
end;

function  TLlDOMPropertyCheckboxDefinition.GetSize :TString;
begin
   result := GetProperty('Size');
end;

function TLlDOMPropertyCheckboxDefinition.GetDesign: TLlDOMPropertyCheckboxDesign;
var
  baseObj: TLlDOMItem;
begin
  if (fDesign <> nil) then
  begin
    result := fDesign
  end
  else
  begin
    baseObj := GetObject('Design');
    fDesign := TLlDOMPropertyCheckboxDesign.Create(baseObj);
    baseObj.Free;
    result := fDesign;
  end;
end;

destructor TLlDOMPropertyCheckboxDefinition.Destroy;
begin
  fDesign.Free;
end;

procedure TLlDOMPropertyCheckboxItemForResource.SetContents(const value: TString);
begin
   SetProperty('Contents', value);
end;

function TLlDOMPropertyCheckboxItemForResource.GetContents: TString;
begin
   result := GetProperty('Contents');
end;

procedure TLlDOMPropertyCheckboxItemForResource.SetFrameColor(const value: TString);
begin
  SetProperty('FrameColor', value);
end;

function TLlDOMPropertyCheckboxItemForResource.GetFrameColor: TString;
begin
     result := GetProperty('FrameColor');
end;

procedure TLlDOMPropertyCheckboxItemForResource.SetIconColor(const value: TString);
begin
  SetProperty('IconColor', value);
end;

function TLlDOMPropertyCheckboxItemForResource.GetIconColor: TString;
begin
  result := GetProperty('IconColor');
end;

procedure TLlDOMPropertyCheckboxItemFor.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

function  TLlDOMPropertyCheckboxItemFor.GetContents;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyCheckboxItemFor.GetExternal: TLlDOMPropertyDrawingContents;
var
  baseObj: TLlDOMItem;
begin
  if fExternal <> nil then
  begin
    result := fExternal
  end
  else
  begin
    baseObj := GetObject('External');
    fExternal := TLlDOMPropertyDrawingContents.Create(baseObj);
    baseObj.Free;
    result := fExternal;
  end;
end;

function TLlDOMPropertyCheckboxItemFor.GetResource: TLlDOMPropertyCheckboxItemForResource;
var
  baseObj: TLlDOMItem;
begin
  if fResource <> nil then
  begin
    result := fResource
  end
  else
  begin
    baseObj := GetObject('Resource');
    fResource := TLlDOMPropertyCheckboxItemForResource.Create(baseObj);
    baseObj.Free;
    result := fResource;
  end;
end;

destructor TLlDOMPropertyCheckboxItemFor.Destroy;
begin
  fExternal.Free;
  fResource.Free;
  inherited;
end;

function TLlDOMPropertyCheckboxDesign.GetItemForFalse : TLlDOMPropertyCheckboxItemFor;
var
  baseObj: TLlDOMItem;
begin
  if fItemForFalse <> nil then
  begin
    result := fItemForFalse
  end
  else
  begin
    baseObj := GetObject('ItemForFalse');
    fItemForFalse := TLlDOMPropertyCheckboxItemFor.Create(baseObj);
    baseObj.Free;
    result := fItemForFalse;
  end;
end;

function TLlDOMPropertyCheckboxDesign.GetItemForNULL : TLlDOMPropertyCheckboxItemFor;
var
  baseObj: TLlDOMItem;
begin
  if fItemForNULL <> nil then
  begin
    result := fItemForNULL
  end
  else
  begin
    baseObj := GetObject('ItemForNULL');
    fItemForNULL := TLlDOMPropertyCheckboxItemFor.Create(baseObj);
    baseObj.Free;
    result := fItemForNULL;
  end;
end;

function TLlDOMPropertyCheckboxDesign.GetItemForTrue : TLlDOMPropertyCheckboxItemFor;
var
  baseObj: TLlDOMItem;
begin
  if fItemForTrue <> nil then
  begin
    result := fItemForTrue
  end
  else
  begin
    baseObj := GetObject('ItemForTrue');
    fItemForTrue := TLlDOMPropertyCheckboxItemFor.Create(baseObj);
    baseObj.Free;
    result := fItemForTrue;
  end;
end;
destructor TLlDOMPropertyCheckboxDesign.Destroy;
begin
  fItemForFalse.Free;
  fItemForNULL.Free;
  fItemForTrue.Free;
  inherited;
end;

function TLlDOMTableFieldCheckbox.GetDefinition: TLlDOMPropertyCheckboxDefinition;
var
  baseObj: TLlDOMItem;
begin
  if (fDefinition <> nil) then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyCheckboxDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMTableFieldCheckbox.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

procedure TLlDOMTableFieldCheckbox.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

constructor TLlDOMTableFieldCheckbox.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'LLX:LLCheckbox', list.Count);
end;

destructor TLlDOMTableFieldCheckbox.Destroy;
begin
  fDefinition.Free;
  Inherited;
end;

{/TLlDOMObjectCheckbox}
{ TLLDOMObject }
constructor TLlDOMItem.Create(hDom: HLLDOMOBJ);
begin
  inherited Create();
  fDomHandle := hDom;
end;

constructor TLlDOMItem.Create;
begin
  inherited Create();
end;

constructor TLlDOMItem.Create(oDom: TLlDOMItem);
begin
  inherited Create();
  fDomHandle := oDom.fDomHandle;
end;

function TLlDOMItem.CreateSubObject(index: integer;
  domItemSubObjectName: TString): HLLDOMOBJ;
var
  hNewDomObj: HLLDOMOBJ;
begin
  LlDomCreateSubobject(fDomHandle, index, PTChar(domItemSubObjectName),
    @hNewDomObj);
  result := hNewDomObj;
end;

function TLlDOMItem.GetHandle(objectName: TString): HLLDOMOBJ;
var
  hObj: HLLDOMOBJ;
begin
  LlDomGetObject(fDomHandle, PTChar(objectName), @hObj);
  result := hObj;
end;

function TLlDOMItem.GetObject(objectName: TString): TLlDOMItem;
var
  hObj: HLLDOMOBJ;
begin
  LlDomGetObject(fDomHandle, PTChar(objectName), @hObj);
  result := TLlDOMItem.Create(hObj);
end;

function TLlDOMItem.GetProperty(propName: TString): TString;
var
  nBufSize: integer;
  value: PTChar;
  pchr: PTChar;
begin
  pchr := PTChar(propName);
  nBufSize := LlDomGetProperty(fDomHandle, pchr, nil, 0);
  if (nBufSize > 0) then
  begin
    GetMem(value, nBufSize * sizeof(TChar));
    LlDomGetProperty(fDomHandle, pchr, value, nBufSize);
    result := value;
    FreeMem(value);
  end;
end;

function TLlDOMItem.GetSubObject(index: integer): TLlDOMItem;
var
  hSubObj: HLLDOMOBJ;
  nRes: integer;
begin
  nRes := LlDomGetSubobject(fDomHandle, index, @hSubObj);
  if nRes >= 0 then
    result := TLlDOMItem.Create(hSubObj)
  else
    result := nil;
end;

function TLlDOMItem.GetSubObjectCount(): integer;
var
  nCount: integer;
begin
  LlDomGetSubobjectCount(fDomHandle, @nCount);
  result := nCount;
end;

procedure TLlDOMItem.SetProperty(propName, value: TString);
begin
    LlDomSetProperty(fDomHandle, PTChar(propName), PTChar(value));
end;

procedure TLlDOMSumVariable.SetIsPageSum(const value: TString);
begin
  SetProperty('IsPageSum', value);
end;

constructor TLlDOMSumVariable.Create(list: TLlDOMSumVariableList);
var
  newSumVar: TLlDOMItem;
begin
  ParentList := list;
  newSumVar := ParentList.NewItem(list.Count);
  inherited Create(newSumVar.fDomHandle);
  ParentList.Add(self);
  newSumVar.Free;
end;

function TLlDOMSumVariable.GetContent: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMSumVariable.GetIsPageSum: TString;
begin
  result := GetProperty('IsPageSum');
end;

function TLlDOMSumVariable.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMSumVariable.SetContent(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMSumVariable.SetName(const value: TString);
begin
  SetProperty('Name', value);
  ParentList.Initialize();
end;

function TLlDOMSumVariableList.Add(domObj: TLlDOMSumVariable): integer;
begin
  result := inherited Add(domObj);
  Initialize();
end;

constructor TLlDOMSumVariableList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMSumVariableList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMSumVariableList.GetItems(index: integer): TLlDOMSumVariable;
begin
  result := TLlDOMSumVariable( inherited Items[index]);
end;

function TLlDOMSumVariableList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMSumVariable;
begin
  newDomObj := TLlDOMSumVariable.Create;
  newDomObj.ParentList := self;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'SumVariable');
  result := newDomObj;
  Initialize();
end;

procedure TLlDOMSumVariableList.SetItems(index: integer;
  value: TLlDOMSumVariable);
begin
  inherited Items[index] := value;
end;

procedure TLlDOMSumVariableList.DeleteSubobject(index: integer);
begin
  inherited DeleteSubobject(index);
  Initialize();
end;

{ TLlDOMList }

procedure TLlDOMList.DeleteSubobject(index: integer);
begin
  LlDomDeleteSubobject(fDOMObj.fDomHandle, index);
  TLlDOMItem(Items[index]).Free;
  Delete(index);
end;

procedure TLlDOMList.Initialize;
var
  nObjCount: integer;
  newDomObj: TLlDOMItem;
  i: integer;
begin
  Clear();
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    newDomObj := fDOMObj.GetSubObject(i);
    Add(newDomObj);
  end;
end;

{ TLlDOMUserVariable }

constructor TLlDOMUserVariable.Create(list: TLlDOMUserVariableList);
var
  newUserVar: TLlDOMItem;
begin
  ParentList := list;
  newUserVar := ParentList.NewItem(list.Count);
  inherited Create(newUserVar.fDomHandle);
  ParentList.Add(self);
  newUserVar.Free;
end;

function TLlDOMUserVariable.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMUserVariable.SetName(const value: TString);
begin
  SetProperty('Name', value);
  ParentList.Initialize();
end;

function TLlDOMUserVariable.GetContent: TString;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMUserVariable.SetContent(const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMUserVariableList }
function TLlDOMUserVariableList.GetItems(index: integer): TLlDOMUserVariable;
begin
  result := TLlDOMUserVariable(inherited Items[index]);
end;

procedure TLlDOMUserVariableList.SetItems(index: integer;
  const value: TLlDOMUserVariable);
begin
  inherited Items[index] := value;
end;

function TLlDOMUserVariableList.Add(domObj: TLlDOMUserVariable): integer;
begin
  result := inherited Add(domObj);
  Initialize();
end;

constructor TLlDOMUserVariableList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMUserVariableList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMUserVariableList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMUserVariable;
begin
  newDomObj := TLlDOMUserVariable.Create;
  newDomObj.ParentList := self;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'UserVariable');
  result := newDomObj;
  Initialize();
end;
procedure TLlDOMUserVariableList.DeleteSubobject(index: integer);
begin
  inherited DeleteSubobject(index);
  Initialize();
end;

{ TLlDOMObjectBase }

constructor TLlDOMObjectBase.Create(list: TLlDOMObjectList; ObjectType: TString;
  index: integer);
var
  newDomObj: TLlDOMItem;
begin
  inherited Create();
  newDomObj := list.NewItem(index, ObjectType);
  fDomHandle := newDomObj.fDomHandle;
  list.Add(self);
  newDomObj.Free;
end;

function TLlDOMObjectBase.GetUUID: TString;
begin
  result := GetProperty('UUID');
end;

function TLlDOMObjectBase.GetTemplateUUID: TString;
begin
  result := GetProperty('TemplateUUID');
end;


function TLlDOMObjectBase.GetLinkUUID: TString;
begin
  result := GetProperty('LinkUUID');
end;

procedure TLlDOMObjectBase.SetLinkUUID(const value: TString);
begin
  SetProperty('LinkUUID', value);
end;

function TLlDOMObjectBase.GetObjectType: TString;
begin
  result := GetProperty('ObjectType');
end;

function TLlDOMObjectBase.GetPosition: TLlDOMPropertyPosition;
var
  baseObj: TLlDOMItem;
begin
  if (fPosition <> nil) then
  begin
    result := fPosition
  end
  else
  begin
    baseObj := GetObject('Position');
    fPosition := TLlDOMPropertyPosition.Create(baseObj);
    baseObj.Free;
    result := fPosition;
  end;
end;


function TLlDOMObjectBase.GetAnimation: TLlDOMPropertyAnimation;
var
  baseObj: TLlDOMItem;
begin
  if (fAnimation <> nil) then
  begin
    result := fAnimation
  end
  else
  begin
    baseObj := GetObject('Animation');
    fAnimation := TLlDOMPropertyAnimation.Create(baseObj);
    baseObj.Free;
    result := fAnimation;
  end;
end;

function TLlDOMObjectBase.GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
var
  baseObj: TLlDOMItem;
begin
  if (fXhtmlAnimation <> nil) then
  begin
    result := fXhtmlAnimation
  end
  else
  begin
    baseObj := GetObject('HTMLAnimation');
    fXhtmlAnimation := TLlDOMPropertyXhtmlAnimation.Create(baseObj);
    baseObj.Free;
    result := fXhtmlAnimation;
  end;
end;

function TLlDOMObjectBase.GetReadOnly: TString;
begin
  result := GetProperty('ReadOnly');
end;

function TLlDOMObjectBase.GetSelected: TString;
begin
  result := GetProperty('Selected');
end;

procedure TLlDOMObjectBase.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

function TLlDOMObjectBase.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMObjectBase.SetReadOnly(const value: TString);
begin
  SetProperty('ReadOnly', value);
end;

procedure TLlDOMObjectBase.SetSelected(const value: TString);
begin
  SetProperty('Selected', value);
end;

destructor TLlDOMObjectBase.Destroy;
begin
  fAnimation.free;
  fXhtmlAnimation.Free;
  fBookmark.Free;
  fPosition.Free;
  inherited;
end;

function TLlDOMObjectBase.GetContent: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMObjectBase.GetGroupID: TString;
begin
  result := GetProperty('GroupID');
end;

function TLlDOMObjectBase.GetId: TString;
begin
  result := GetProperty('ID');
end;

function TLlDOMObjectBase.GetLayerID: TString;
begin
  result := GetProperty('LayerID');
end;

function TLlDOMObjectBase.GetLinkID: TString;
begin
  result := GetProperty('LinkID');
end;

function TLlDOMObjectBase.GetLinkMode: TString;
begin
  result := GetProperty('LinkMode');
end;

function TLlDOMObjectBase.GetIssueCondition: TString;
begin
  result := GetProperty('IssueCondition');
end;

procedure TLlDOMObjectBase.SetContent(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMObjectBase.SetGroupID(const value: TString);
begin
  SetProperty('GroupID', value);
end;

procedure TLlDOMObjectBase.SetLayerID(const value: TString);
begin
  SetProperty('LayerID', value);
end;

procedure TLlDOMObjectBase.SetLinkID(const value: TString);
begin
  SetProperty('LinkID', value);
end;

procedure TLlDOMObjectBase.SetLinkMode(const value: TString);
begin
  SetProperty('LinkMode', value);
end;

function TLlDOMObjectBase.GetBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if (fBookmark <> nil) then
  begin
    result := fBookmark
  end
  else
  begin
    baseObj := GetObject('Bookmark');
    fBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fBookmark;
  end;
end;

function TLlDOMObjectBase.GetBreakBefore: TString;
begin
  result := GetProperty('BreakBefore');
end;

function TLlDOMObjectBase.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

procedure TLlDOMObjectBase.SetBreakBefore(const value: TString);
begin
  SetProperty('BreakBefore', value);
end;

procedure TLlDOMObjectBase.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

function TLlDOMObjectBase.GetLocked: TString;
begin
  result := GetProperty('Locked');
end;

procedure TLlDOMObjectBase.SetLocked(const value: TString);
begin
  SetProperty('Locked', value);
end;

procedure TLlDOMObjectBase.SetIssueCondition(const value: TString);
begin
  SetProperty('IssueCondition', value);
end;

procedure TLlDOMObjectBase.LinkTo(parentObject: TLlDOMObjectBase);
begin
  LinkID := parentObject.Id;
  LinkMode := IntToStr(0);
end;

procedure TLlDOMObjectBase.LinkTo(parentObject: TLlDOMObjectBase;
  verticalLinkType: integer; verticalSizeAdaptionType: integer;
  horizontalLinkType: integer; horizontalSizeAdaptionType: integer);
begin
  LinkID := parentObject.Id;
  LinkMode := IntToStr(verticalLinkType + verticalSizeAdaptionType +
    horizontalLinkType + horizontalSizeAdaptionType);
end;

procedure TLlDOMObjectBase.LinkTo(parentObject: TLlDOMObjectBase;
  verticalLinkType: integer; verticalSizeAdaptionType: integer);
begin
  LinkTo(parentObject, verticalLinkType, verticalSizeAdaptionType,
    TLlDOMHorizontalLinkType.None, TLlDOMHorizontalSizeAdaptionType.None);
end;

{ TLlDOMObjectList }

function TLlDOMObjectList.Add(domObj: TLlDOMObjectBase): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMObjectList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMObjectList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Free;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMObjectList.GetItemName(Name: TString): TLlDOMObjectBase;
var
  i: integer;
begin
  result := nil;
  for i := 0 to self.Count - 1 do
    if self.Items[i].Name = Name then
    begin
      result := self.Items[i];
      exit;
    end;
end;

function TLlDOMObjectList.GetItems(index: integer): TLlDOMObjectBase;
begin
  result := TLlDOMObjectBase(inherited Items[index]);
end;

procedure TLlDOMObjectList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMObjectBase;
  i: integer;
  ObjectType, InputObjectType: TString;
begin
  newDomObj := nil;
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    ObjectType := baseObj.GetProperty('ObjectType');

    if (ObjectType = 'Line') then
    begin
      newDomObj := TLlDOMObjectLine.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Rectangle') then
    begin
      newDomObj := TLlDOMObjectRectangle.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Ellipse') then
    begin
      newDomObj := TLlDOMObjectEllipse.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Drawing') then
    begin
      newDomObj := TLlDOMObjectDrawing.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Text') then
    begin
      newDomObj := TLlDOMObjectText.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Barcode') then
    begin
      newDomObj := TLlDOMObjectBarcode.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'RTFText') then
    begin
      newDomObj := TLlDOMObjectRTF.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Input') then
    begin
      InputObjectType := baseObj.GetProperty('InputObjectType');
      if InputObjectType = '0' then
      begin
        newDomObj := TLlDOMObjectInputEdit.Create(baseObj);
        TLlDOMObjectInputEdit(newDomObj).InputObjectType := '0';
      end;
      if InputObjectType = '1' then
      begin
        newDomObj := TLlDOMObjectInputCheckbox.Create(baseObj);
        TLlDOMObjectInputCheckbox(newDomObj).InputObjectType := '1';
      end;
      if InputObjectType = '2' then
      begin
        newDomObj := TLlDOMObjectInputCombobox.Create(baseObj);
        TLlDOMObjectInputCombobox(newDomObj).InputObjectType := '2';
      end;
      if InputObjectType = '3' then
      begin
        newDomObj := TLlDOMObjectInputButton.Create(baseObj);
        TLlDOMObjectInputButton(newDomObj).InputObjectType := '3';
      end;
      baseObj.Free;
    end;

    if (ObjectType = 'LLX') then
    begin
      newDomObj := TLlDOMObjectHTML.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'ReportContainer') then
    begin
      newDomObj := TLlDOMObjectReportContainer.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Crosstab') then
    begin
      newDomObj := TLlDOMObjectCrosstab.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Template') then
    begin
      newDomObj := TLlDOMObjectTemplate.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Chart') then
    begin
      newDomObj := TLlDOMObjectChart.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Gauge') then
    begin
      newDomObj := TLlDOMObjectGauge.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'PDF') then
    begin
      newDomObj := TLlDOMObjectPDF.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'DataGraphic') then
    begin
      newDomObj := TLlDOMObjectDataGraphic.Create(baseObj);
      baseObj.Free;
    end;

    Add(newDomObj);
  end;
end;

function TLlDOMObjectList.NewItem(index: integer; ObjectType: TString)
  : TLlDOMItem;
var
  newDomObj: TLlDOMObjectBase;
begin
  newDomObj := TLlDOMObjectBase.Create(fDOMObj.CreateSubObject(index,
    ObjectType));
  result := newDomObj;
end;

procedure TLlDOMObjectList.SetItemName(Name: TString;
  const value: TLlDOMObjectBase);
var
  i: integer;
begin
  for i := 0 to self.Count - 1 do
    if self.Items[i].Name = Name then
    begin
      self.Items[i] := value;
      exit;
    end;
end;

procedure TLlDOMObjectList.SetItems(index: integer;
  const value: TLlDOMObjectBase);
begin
  inherited Items[index] := value;
end;

{ TLlDOMObjectLine }

constructor TLlDOMObjectLine.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Line', list.Count);
end;

constructor TLlDOMObjectLine.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Line', index);
end;

destructor TLlDOMObjectLine.Destroy;
begin
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectLine.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMObjectLine.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectLine.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectLine.GetLineDirection: TString;
begin
  result := GetProperty('LineDirection');
end;

function TLlDOMObjectLine.GetLineType: TString;
begin
  result := GetProperty('LineType');
end;

function TLlDOMObjectLine.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMObjectLine.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMObjectLine.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectLine.SetLineDirection(const value: TString);
begin
  SetProperty('LineDirection', value);
end;

procedure TLlDOMObjectLine.SetLineType(const value: TString);
begin
  SetProperty('LineType', value);
end;

procedure TLlDOMObjectLine.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TLlDOMObjectRectangle }

constructor TLlDOMObjectRectangle.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Rectangle', list.Count);
end;

constructor TLlDOMObjectRectangle.Create(list: TLlDOMObjectList;
  index: integer);
begin
  inherited Create(list, 'Rectangle', index);
end;

destructor TLlDOMObjectRectangle.Destroy;
begin
  fFilling.Free;
  fShadow.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectRectangle.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectRectangle.GetFilling: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectRectangle.GetFrame: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectRectangle.GetRounding: TString;
begin
  result := GetProperty('Rounding');
end;

function TLlDOMObjectRectangle.GetShadow: TLlDOMPropertyShadow;
var
  baseObj: TLlDOMItem;
begin
  if fShadow <> nil then
  begin
    result := fShadow
  end
  else
  begin
    baseObj := GetObject('Shadow');
    fShadow := TLlDOMPropertyShadow.Create(baseObj);
    baseObj.Free;
    result := fShadow;
  end;
end;

procedure TLlDOMObjectRectangle.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectRectangle.SetRounding(const value: TString);
begin
  SetProperty('Rounding', value);
end;

{ TPosition }

procedure TLlDOMPropertyPosition.Define(nLeft, nTop, nWidht, nHeight: integer);
begin
  Left := IntToStr(nLeft);
  Top := IntToStr(nTop);
  Width := IntToStr(nWidht);
  Height := IntToStr(nHeight);
end;

function TLlDOMPropertyPosition.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMPropertyPosition.GetLeft: TString;
begin
  result := GetProperty('Left');
end;

function TLlDOMPropertyPosition.GetTop: TString;
begin
  result := GetProperty('Top');
end;

function TLlDOMPropertyPosition.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyPosition.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMPropertyPosition.SetLeft(const value: TString);
begin
  SetProperty('Left', value);
end;

procedure TLlDOMPropertyPosition.SetTop(const value: TString);
begin
  SetProperty('Top', value);
end;

procedure TLlDOMPropertyPosition.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TFrame }

destructor TLlDOMPropertyFrame.Destroy;
begin
  fBottom.Free;
  fLeft.Free;
  fRight.Free;
  fTop.Free;
  inherited;
end;

function TLlDOMPropertyFrame.GetBottom: TLlDOMPropertyBottom;
var
  baseObj: TLlDOMItem;
begin
  if (fBottom <> nil) then
  begin
    result := fBottom
  end
  else
  begin
    baseObj := GetObject('Bottom');
    fBottom := TLlDOMPropertyBottom.Create(baseObj);
    baseObj.Free;
    result := fBottom;
  end;
end;

function TLlDOMPropertyFrame.GetDefault: TString;
begin
  result := GetProperty('Default');
end;

function TLlDOMPropertyFrame.GetLayout: TString;
begin
  result := GetProperty('Layout');
end;

function TLlDOMPropertyFrame.GetLeft: TLlDOMPropertyLeft;
var
  baseObj: TLlDOMItem;
begin
  if (fLeft <> nil) then
  begin
    result := fLeft
  end
  else
  begin
    baseObj := GetObject('Left');
    fLeft := TLlDOMPropertyLeft.Create(baseObj);
    baseObj.Free;
    result := fLeft;
  end;
end;

function TLlDOMPropertyFrame.GetRight: TLlDOMPropertyRight;
var
  baseObj: TLlDOMItem;
begin
  if (fRight <> nil) then
  begin
    result := fRight
  end
  else
  begin
    baseObj := GetObject('Right');
    fRight := TLlDOMPropertyRight.Create(baseObj);
    baseObj.Free;
    result := fRight;
  end;
end;

function TLlDOMPropertyFrame.GetTop: TLlDOMPropertyTop;
var
  baseObj: TLlDOMItem;
begin
  if (fTop <> nil) then
  begin
    result := fTop
  end
  else
  begin
    baseObj := GetObject('Top');
    fTop := TLlDOMPropertyTop.Create(baseObj);
    baseObj.Free;
    result := fTop;
  end;
end;

procedure TLlDOMPropertyFrame.SetDefault(const value: TString);
begin
  SetProperty('Default', value);
end;

procedure TLlDOMPropertyFrame.SetLayout(const value: TString);
begin
  SetProperty('Layout', value);
end;

{ TBottom }

destructor TLlDOMPropertyFrameItem.Destroy;
begin
  fLine.Free;
  inherited;
end;

function TLlDOMPropertyFrameItem.GetLine: TLlDOMPropertyLine;
var
  baseObj: TLlDOMItem;
begin
  if (fLine <> nil) then
  begin
    result := fLine
  end
  else
  begin
    baseObj := GetObject('Line');
    fLine := TLlDOMPropertyLine.Create(baseObj);
    baseObj.Free;
    result := fLine;
  end;
end;

function TLlDOMPropertyFrameItem.GetSpace: TString;
begin
  result := GetProperty('Space');
end;

procedure TLlDOMPropertyFrameItem.SetSpace(const value: TString);
begin
  SetProperty('Space', value);
end;

{ TLine }

function TLlDOMPropertyLine.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyLine.GetLineType: TString;
begin
  result := GetProperty('LineType');
end;

function TLlDOMPropertyLine.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

function TLlDOMPropertyLine.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyLine.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyLine.SetLineType(const value: TString);
begin
  SetProperty('LineType', value);
end;

procedure TLlDOMPropertyLine.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

procedure TLlDOMPropertyLine.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TFilling }

function TLlDOMPropertyFilling.GetAlpha: TString;
begin
  result := GetProperty('Alpha');
end;

function TLlDOMPropertyFilling.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyFilling.GetColor2: TString;
begin
  result := GetProperty('Color2');
end;

function TLlDOMPropertyFilling.GetColor3: TString;
begin
  result := GetProperty('Color3');
end;

function TLlDOMPropertyFilling.GetPattern: TString;
begin
  result := GetProperty('Pattern');
end;

function TLlDOMPropertyFilling.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyFilling.SetAlpha(const value: TString);
begin
  SetProperty('Alpha', value);
end;

procedure TLlDOMPropertyFilling.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyFilling.SetColor2(const value: TString);
begin
  SetProperty('Color2', value);
end;

procedure TLlDOMPropertyFilling.SetColor3(const value: TString);
begin
  SetProperty('Color3', value);
end;

procedure TLlDOMPropertyFilling.SetPattern(const value: TString);
begin
  SetProperty('Pattern', value);
end;

procedure TLlDOMPropertyFilling.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;


//ext
function TLlDOMPropertyFillingExt.GetPattern: TString;
begin
  result := GetProperty('Pattern');
end;

function TLlDOMPropertyFillingExt.GetColor2: TString;
begin
  result := GetProperty('Color2');
end;

function TLlDOMPropertyFillingExt.GetColor3: TString;
begin
  result := GetProperty('Color3');
end;

function TLlDOMPropertyFillingExt.GetAlpha: TString;
begin
  result := GetProperty('Alpha');
end;


procedure TLlDOMPropertyFillingExt.SetPattern(const value: TString);
begin
  SetProperty('Pattern', value);
end;

procedure TLlDOMPropertyFillingExt.SetColor2(const value: TString);
begin
  SetProperty('Color2', value);
end;

procedure TLlDOMPropertyFillingExt.SetColor3(const value: TString);
begin
  SetProperty('Color3', value);
end;

procedure TLlDOMPropertyFillingExt.SetAlpha(const value: TString);
begin
  SetProperty('Alpha', value);
end;

function TLlDOMPropertyFillingWithBitmap.GetBitmap: TLlDOMPropertyDrawingContents;
var
  baseObj: TLlDOMItem;
begin
  if fBitmap <> nil then
  begin
    result := fBitmap
  end
  else
  begin
    baseObj := GetObject('External');
    fBitmap := TLlDOMPropertyDrawingContents.Create(baseObj);
    baseObj.Free;
    result := fBitmap;
  end;
end;
{ TShadow }

function TLlDOMPropertyShadow.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyShadow.GetPattern: TString;
begin
  result := GetProperty('Pattern');
end;

function TLlDOMPropertyShadow.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

function TLlDOMPropertyShadow.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyShadow.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyShadow.SetPattern(const value: TString);
begin
  SetProperty('Pattern', value);
end;

procedure TLlDOMPropertyShadow.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

procedure TLlDOMPropertyShadow.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TFrameExt }

function TLlDOMPropertyFrameExt.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyFrameExt.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

function TLlDOMPropertyFrameExt.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyFrameExt.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyFrameExt.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

procedure TLlDOMPropertyFrameExt.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TLlDOMObjectEllipse }

constructor TLlDOMObjectEllipse.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Ellipse', list.Count);
end;

constructor TLlDOMObjectEllipse.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Ellipse', index);
end;

destructor TLlDOMObjectEllipse.Destroy;
begin
  fFilling.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectEllipse.GetCircle: TString;
begin
  result := GetProperty('Circle');
end;

function TLlDOMObjectEllipse.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectEllipse.GetFilling: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectEllipse.GetFrame: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectEllipse.SetCircle(const value: TString);
begin
  SetProperty('Circle', value);
end;

procedure TLlDOMObjectEllipse.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

{ TLlDOMObjectDrawing }

constructor TLlDOMObjectDrawing.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Drawing', list.Count);
end;

constructor TLlDOMObjectDrawing.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Drawing', index);
end;

destructor TLlDOMObjectDrawing.Destroy;
begin
  fSource.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectDrawing.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectDrawing.GetSource: TLlDOMPropertyDrawingContents;
var
  baseObj: TLlDOMItem;
begin
  if fSource <> nil then
  begin
    result := fSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fSource := TLlDOMPropertyDrawingContents.Create(baseObj);
    baseObj.Free;
    result := fSource;
  end;
end;

{ TSource }

destructor TLlDOMPropertySource.Destroy;
begin
  fFileinfo.Free;
  inherited;
end;

function TLlDOMPropertySource.GetFileinfo: TLlDOMPropertyFileInfo;
var
  baseObj: TLlDOMItem;
begin
  if (fFileinfo <> nil) then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

function TLlDOMPropertySource.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertySource.GetMode: TString;
begin
  result := GetProperty('Mode');
end;

function TLlDOMPropertySource.GetVariable: TString;
begin
  result := GetProperty('Variable');
end;

procedure TLlDOMPropertySource.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertySource.SetMode(const value: TString);
begin
  SetProperty('Mode', value);
end;

procedure TLlDOMPropertySource.SetVariable(const value: TString);
begin
  SetProperty('Variable', value);
end;

function TLlDOMPropertySource.GetVerification: TLlDOMPropertyVerification;
var
  baseObj: TLlDOMItem;
begin
  if fVerification <> nil then
  begin
    result := fVerification
  end
  else
  begin
    baseObj := GetObject('Verification');
    fVerification := TLlDOMPropertyVerification.Create(baseObj);
    baseObj.Free;
    result := fVerification;
  end;
end;

{ TFile }

function TLlDOMPropertyFileInfo.GetFileName: TString;
begin
  result := GetProperty('FileName');
end;

function TLlDOMPropertyFileInfo.GetFileNameIsRelative: TString;
begin
  result := GetProperty('FileNameIsRelative');
end;

procedure TLlDOMPropertyFileInfo.SetFileName(const value: TString);
begin
  SetProperty('FileName', value);
end;

procedure TLlDOMPropertyFileInfo.SetFileNameIsRelative(const value: TString);
begin
  SetProperty('FileNameIsRelative', value);
end;

{ TLlDOMObjectText }

constructor TLlDOMObjectText.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Text', list.Count);
end;

constructor TLlDOMObjectText.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Text', index);
end;

destructor TLlDOMObjectText.Destroy;
begin
  fFrame.Free;
  fFilling.Free;
  fParagraphList.Free;
  fFrame := nil;
  fFilling := nil;
  fParagraphList := nil;
  inherited;
end;

function TLlDOMObjectText.GetAllowPageBreak: TString;
begin
  result := GetProperty('AllowPageBreak');
end;

function TLlDOMObjectText.GetBottomAligned: TString;
begin
  result := GetProperty('BottomAligned');
end;

function TLlDOMObjectText.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMObjectText.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectText.GetFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectText.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectText.GetParagraphList: TLlDOMParagraphList;
begin
  if fParagraphList = nil then
  begin
    fParagraphList := TLlDOMParagraphList.Create(GetObject('Paragraphs'));
  end;
  result := fParagraphList;
end;

procedure TLlDOMObjectText.SetAllowPageBreak(const value: TString);
begin
  SetProperty('AllowPageBreak', value);
end;

procedure TLlDOMObjectText.SetBottomAligned(const value: TString);
begin
  SetProperty('BottomAligned', value);
end;

procedure TLlDOMObjectText.SetDirection(const value: TString);
begin
  SetProperty('Direction', value);
end;

procedure TLlDOMObjectText.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

{ TLlDOMParagraphList }

function TLlDOMParagraphList.Add(domObj: TLlDOMParagraph): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMParagraphList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMParagraphList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMParagraphList.GetItems(index: integer): TLlDOMParagraph;
begin
  result := TLlDOMParagraph(inherited Items[index]);
end;

procedure TLlDOMParagraphList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMParagraph;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMParagraph.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

function TLlDOMParagraphList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMParagraph;
begin
  newDomObj := TLlDOMParagraph.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'Paragraph');
  result := newDomObj;
end;

procedure TLlDOMParagraphList.SetItems(index: integer;
  const value: TLlDOMParagraph);
begin
  inherited Items[index] := value;
end;

{ TLlDOMObjectParagraph }

constructor TLlDOMParagraph.Create(list: TLlDOMParagraphList);
var
  newParagraph: TLlDOMItem;
begin
  newParagraph := list.NewItem(list.Count);
  inherited Create(newParagraph.fDomHandle);
  list.Add(self);
  newParagraph.Free;
end;

destructor TLlDOMParagraph.Destroy;
begin
  fWrapping.Free;
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMParagraph.GetAdjusted: TString;
begin
  result := GetProperty('Adjusted');
end;

function TLlDOMParagraph.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMParagraph.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMParagraph.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMParagraph.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMParagraph.GetLineSpacing: TString;
begin
  result := GetProperty('LineSpacing');
end;

function TLlDOMParagraph.GetOptimizeSpaces: TString;
begin
  result := GetProperty('OptimizeSpaces');
end;

function TLlDOMParagraph.GetOutputFormatterBase
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter = nil then
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    fOutputFormatter := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
  result := fOutputFormatter
end;

function TLlDOMParagraph.GetParagraphSpacing: TString;
begin
  result := GetProperty('ParagraphSpacing');
end;

function TLlDOMParagraph.GetTabAlignment: TString;
begin
  result := GetProperty('TabAlignment');
end;

function TLlDOMParagraph.GetTabPosition: TString;
begin
  result := GetProperty('TabPosition');
end;

function TLlDOMParagraph.GetUnerasable: TString;
begin
  result := GetProperty('Unerasable');
end;

function TLlDOMParagraph.GetWrapping: TLlDOMPropertyWrappingExt;
var
  baseObj: TLlDOMItem;
begin
  if (fWrapping <> nil) then
  begin
    result := fWrapping
  end
  else
  begin
    baseObj := GetObject('Wrapping');
    fWrapping := TLlDOMPropertyWrappingExt.Create(baseObj);
    baseObj.Free;
    result := fWrapping;
  end;
end;

procedure TLlDOMParagraph.SetAdjusted(const value: TString);
begin
  SetProperty('Adjusted', value);
end;

procedure TLlDOMParagraph.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMParagraph.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMParagraph.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMParagraph.SetLineSpacing(const value: TString);
begin
  SetProperty('LineSpacing', value);
end;

procedure TLlDOMParagraph.SetOptimizeSpaces(const value: TString);
begin
  SetProperty('OptimizeSpaces', value);
end;

procedure TLlDOMParagraph.SetParagraphSpacing(const value: TString);
begin
  SetProperty('ParagraphSpacing', value);
end;

procedure TLlDOMParagraph.SetTabAlignment(const value: TString);
begin
  SetProperty('TabAlignment', value);
end;

procedure TLlDOMParagraph.SetTabPosition(const value: TString);
begin
  SetProperty('TabPosition', value);
end;

procedure TLlDOMParagraph.SetUnerasable(const value: TString);
begin
  SetProperty('Unerasable', value);
end;

{ Animation }
destructor  TLlDOMPropertyAnimation.Destroy;
begin
  fAnimationTrigger.Free;
  inherited;
end;

function TLlDOMPropertyAnimation.GetAnimation: TString;
begin
  result:= GetProperty('Animation');
end;

function TLlDOMPropertyAnimation.GetAnimationTime: TString;
begin
  result:= GetProperty('AnimationTime');
end;

function TLlDOMPropertyAnimation.GetColor: TString;
begin
  result:= GetProperty('Color');
end;

function TLlDOMPropertyAnimation.GetPartialAreaOnly: TString;
begin
  result:= GetProperty('PartialAreaOnly');
end;

function TLlDOMPropertyAnimation.GetAnimationTrigger: TLlDOMPropertyAnimationTrigger;
var
  baseObj: TLlDOMItem;
begin
  if fAnimationTrigger <> nil then
  begin
    result := fAnimationTrigger
  end
  else
  begin
    baseObj := GetObject('Trigger');
    fAnimationTrigger := TLlDOMPropertyAnimationTrigger.Create(baseObj);
    baseObj.Free;
    result := fAnimationTrigger;
  end;

end;

procedure TLlDOMPropertyAnimation.SetAnimation(const value: TString);
begin
  SetProperty('Animation', value);
end;

procedure TLlDOMPropertyAnimation.SetAnimationTime(const value: TString);
begin
  SetProperty('AnimationTime', value);
end;

procedure TLlDOMPropertyAnimation.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyAnimation.SetPartialAreaOnly(const value: TString);
begin
  SetProperty('PartialAreaOnly', value);
end;

function TLlDOMPropertyAnimationTrigger.GetTrigger: TString;
begin
  result:= GetProperty('Trigger');
end;

function TLlDOMPropertyAnimationTrigger.GetTriggerDelay: TString;
begin
  result:= GetProperty('TriggerDelay');
end;

procedure TLlDOMPropertyAnimationTrigger.SetTrigger(const value: TString);
begin
  SetProperty('Trigger', value);
end;

procedure TLlDOMPropertyAnimationTrigger.SetTriggerDelay(const value: TString);
begin
  SetProperty('TriggerDelay', value);
end;
{ /Animation }


{ TTextFilling }

function TLlDOMPropertyTextFilling.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyTextFilling.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyTextFilling.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyTextFilling.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

{ TLlDOMPropertyWrappingExt }

function TLlDOMPropertyWrapping.GetForce: TString;
begin
  result := GetProperty('Force');
end;

function TLlDOMPropertyWrapping.GetLine: TString;
begin
  result := GetProperty('Line');
end;

procedure TLlDOMPropertyWrapping.SetForce(const value: TString);
begin
  SetProperty('Force', value);
end;

procedure TLlDOMPropertyWrapping.SetLine(const value: TString);
begin
  SetProperty('Line', value);
end;

{ TLlDOMPropertyWrappingExt }

function TLlDOMPropertyWrappingExt.GetPage: TString;
begin
  result := GetProperty('Page');
end;

procedure TLlDOMPropertyWrappingExt.SetPage(const value: TString);
begin
  SetProperty('Page', value);
end;

{ TFont }

function TLlDOMPropertyFont.GetBold: TString;
begin
  result := GetProperty('Bold');
end;

function TLlDOMPropertyFont.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyFont.GetDefault: TString;
begin
  result := GetProperty('Default');
end;

function TLlDOMPropertyFont.GetFaceName: TString;
begin
  result := GetProperty('FaceName');
end;

function TLlDOMPropertyFont.GetGdiCharSet: TString;
begin
  result := GetProperty('GdiCharSet');
end;

function TLlDOMPropertyFont.GetItalic: TString;
begin
  result := GetProperty('Italic');
end;

function TLlDOMPropertyFont.GetSize: TString;
begin
  result := GetProperty('Size');
end;

function TLlDOMPropertyFont.GetStrikeout: TString;
begin
  result := GetProperty('Strikeout');
end;

function TLlDOMPropertyFont.GetUnderline: TString;
begin
  result := GetProperty('Underline');
end;

function TLlDOMPropertyFont.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyFont.SetBold(const value: TString);
begin
  SetProperty('Bold', value);
end;

procedure TLlDOMPropertyFont.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyFont.SetDefault(const value: TString);
begin
  SetProperty('Default', value);
end;

procedure TLlDOMPropertyFont.SetFaceName(const value: TString);
begin
  SetProperty('FaceName', value);
end;

procedure TLlDOMPropertyFont.SetGdiCharSet(const value: TString);
begin
  SetProperty('GdiCharSet', value);
end;

procedure TLlDOMPropertyFont.SetItalic(const value: TString);
begin
  SetProperty('Italic', value);
end;

procedure TLlDOMPropertyFont.SetSize(const value: TString);
begin
  SetProperty('Size', value);
end;

procedure TLlDOMPropertyFont.SetStrikeout(const value: TString);
begin
  SetProperty('Strikeout', value);
end;

procedure TLlDOMPropertyFont.SetUnderline(const value: TString);
begin
  SetProperty('Underline', value);
end;

procedure TLlDOMPropertyFont.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TLlDOMObjectBarcode }

constructor TLlDOMObjectBarcode.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Barcode', list.Count);
end;

constructor TLlDOMObjectBarcode.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Barcode', index);
end;

destructor TLlDOMObjectBarcode.Destroy;
begin
  fFixedBarOptions.Free;
  fFont.Free;
  fFrame.Free;
  fSource.Free;
  fMatchDevicePixel.Free;
  inherited;
end;
function TLlDOMObjectBarcode.GetMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
var
  baseObj: TLlDOMItem;
begin
  if fMatchDevicePixel <> nil then
  begin
    result := fMatchDevicePixel
  end
  else
  begin
    baseObj := GetObject('MatchDevicePixel');
    fMatchDevicePixel := TLlDOMPropertyMatchDevicePixel.Create(baseObj);
    baseObj.Free;
    result := fMatchDevicePixel;
  end;
end;

function TLlDOMObjectBarcode.GetBarcodeSource: TLlDOMPropertyBarcodeSource;
var
  baseObj: TLlDOMItem;
begin
  if fSource <> nil then
  begin
    result := fSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fSource := TLlDOMPropertyBarcodeSource.Create(baseObj);
    baseObj.Free;
	  fSource :=TLlDOMHelper.SafeBarcodeSourceCast(fSource);
    result := fSource;
  end;
end;



function TLlDOMObjectBarcode.GetBarColor: TString;
begin
  result := GetProperty('BarColor');
end;

function TLlDOMObjectBarcode.GetBarRatio: TString;
begin
  result := GetProperty('BarRatio');
end;

function TLlDOMObjectBarcode.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMObjectBarcode.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectBarcode.GetFixedBarOptions: TLlDOMPropertyFixedBarOptions;
var
  baseObj: TLlDOMItem;
begin
  if fFixedBarOptions <> nil then
  begin
    result := fFixedBarOptions
  end
  else
  begin
    baseObj := GetObject('FixedBarOptions');
    fFixedBarOptions := TLlDOMPropertyFixedBarOptions.Create(baseObj);
    baseObj.Free;
    result := fFixedBarOptions;
  end;
end;

function TLlDOMObjectBarcode.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMObjectBarcode.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectBarcode.GetUseDefSize: TString;
begin
  result := GetProperty('UseDefSize');
end;

function TLlDOMObjectBarcode.GetWithText: TString;
begin
  result := GetProperty('WithText');
end;

procedure TLlDOMObjectBarcode.SetBarColor(const value: TString);
begin
  SetProperty('BarColor', value);
end;

procedure TLlDOMObjectBarcode.SetBarRatio(const value: TString);
begin
  SetProperty('BarRatio', value);
end;

procedure TLlDOMObjectBarcode.SetDirection(const value: TString);
begin
  SetProperty('Direction', value);

end;

procedure TLlDOMObjectBarcode.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectBarcode.SetUseDefSize(const value: TString);
begin
  SetProperty('UseDefSize', value);
end;

procedure TLlDOMObjectBarcode.SetWithText(const value: TString);
begin
  SetProperty('WithText', value);
end;

{ TFixedBarOptions }

function TLlDOMPropertyFixedBarOptions.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMPropertyFixedBarOptions.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyFixedBarOptions.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMPropertyFixedBarOptions.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

procedure TLlDOMPropertyMatchDevicePixel.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure  TLlDOMPropertyMatchDevicePixel.SetDotSizeReduction(const value: TString);
begin
  SetProperty('DotSizeReduction', value);
end;

function TLlDOMPropertyMatchDevicePixel.GetContents: TString;
begin
  GetProperty('Contents');
end;

function TLlDOMPropertyMatchDevicePixel.GetDotSizeReduction: TString;
begin
  GetProperty('DotSizeReduction');
end;

{ TBarcodeSource }

function TLlDOMPropertyBarcodeSource.GetBarcodeType: TString;
begin
  result := GetProperty('BarcodeType');
end;

function TLlDOMPropertyBarcodeSource.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyBarcodeSource.GetMode: TString;
begin
  result := GetProperty('Mode');
end;


function TLlDOMPropertyBarcodeSource.GetText: TString;
begin
  result := GetProperty('Text');
end;

function TLlDOMPropertyBarcodeSource.GetVariable: TString;
begin
  result := GetProperty('Variable');
end;

procedure TLlDOMPropertyBarcodeSource.SetBarcodeType(const value: TString);
begin
  SetProperty('BarcodeType', value);
end;

procedure TLlDOMPropertyBarcodeSource.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyBarcodeSource.SetMode(const value: TString);
begin
  SetProperty('Mode', value);
end;

procedure TLlDOMPropertyBarcodeSource.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;

procedure TLlDOMPropertyBarcodeSource.SetVariable(const value: TString);
begin
  SetProperty('Variable', value);
end;

{TLlDOMPropertyPremiumAddressBarcodeSource}
function TLlDOMPropertyPremiumAddressBarcodeSource.GetPremiumAdress
  : TLlDOMPropertyPremiumAdress;
var
  baseObj: TLlDOMItem;
begin
  if fPremiumAdress <> nil then
  begin
    result := fPremiumAdress
  end
  else
  begin
    baseObj := GetObject('PremiumAdress');
    fPremiumAdress := TLlDOMPropertyPremiumAdress.Create(baseObj);
    baseObj.Free;
    result := fPremiumAdress;
  end;
end;

destructor TLlDOMPropertyPremiumAddressBarcodeSource.Destroy;
begin
  fPremiumAdress.Free;
  inherited;
end;

{/TLlDOMPropertyPremiumAddressBarcodeSource}

{TLlDOMPropertyPDF417BarcodeSource}

function TLlDOMPropertyPDF417BarcodeSource.GetColumnCount: TString;
begin
  result:= GetProperty('ColumnCount');
end;

function TLlDOMPropertyPDF417BarcodeSource.GetErrorCorrection: TString;
begin
  result:= GetProperty('ErrorCorrection');
end;

function TLlDOMPropertyPDF417BarcodeSource.GetTruncated: TString;
begin
  result:= GetProperty('Truncated');
end;

function TLlDOMPropertyPDF417BarcodeSource.GetYToXRatio: TString;
begin
  result:= GetProperty('YToXRatio');
end;

procedure TLlDOMPropertyPDF417BarcodeSource.SetColumnCount(const value: TString);
begin
  SetProperty('ColumnCount', value);
end;
procedure TLlDOMPropertyPDF417BarcodeSource.SetErrorCorrection(const value: TString);
begin
  SetProperty('ErrorCorrection', value);
end;
procedure TLlDOMPropertyPDF417BarcodeSource.SetTruncated(const value: TString);
begin
  SetProperty('Truncated', value);
end;
procedure TLlDOMPropertyPDF417BarcodeSource.SetYToXRatio(const value: TString);
begin
  SetProperty('YToXRatio', value);
end;
{/TLlDOMPropertyPDF417BarcodeSource}

{TLlDOMPropertyMicroPDF417BarcodeSource}

function TLlDOMPropertyMicroPDF417BarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLlDOMPropertyMicroPDF417BarcodeSource.GetFormat: TString;
begin
  result:= GetProperty('Format');
end;

function TLlDOMPropertyMicroPDF417BarcodeSource.GetYToXRatio: TString;
begin
  result:= GetProperty('YToXRatio');
end;

procedure TLlDOMPropertyMicroPDF417BarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

procedure TLlDOMPropertyMicroPDF417BarcodeSource.SetFormat(const value: TString);
begin
  SetProperty('Fortmat', value);
end;

procedure TLlDOMPropertyMicroPDF417BarcodeSource.SetYToXRatio(const value: TString);
begin
  SetProperty('YToXRatio', value);
end;

{/TLlDOMPropertyMicroPDF417BarcodeSource}

{TLlDOMPropertyMaxicodeBarcodeSource}
function TLlDOMPropertyMaxicodeBarcodeSource.GetPolygonFillRate: TString;
begin
  GetProperty('PolygonFillRate');
end;

function TLlDOMPropertyMaxicodeBarcodeSource.GetMaxicodeMode: TString;
begin
  GetProperty('MaxicodeMode');
end;

procedure TLlDOMPropertyMaxicodeBarcodeSource.SetPolygonFillRate(const value: TString);
begin
    SetProperty('PolygonFillRate', value);
end;

procedure TLlDOMPropertyMaxicodeBarcodeSource.SetMaxicodeMode(const value: TString);
begin
    SetProperty('MaxicodeMode', value);
end;

{/TLlDOMPropertyMaxicodeBarcodeSource}


{TLlDOMPropertyDatamatrixBarcodeSource}
function TLlDOMPropertyDatamatrixBarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLlDOMPropertyDatamatrixBarcodeSource.GetPreferredFormat: TString;
begin
  result:= GetProperty('PreferredFormat');
end;

procedure TLlDOMPropertyDatamatrixBarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

procedure TLlDOMPropertyDatamatrixBarcodeSource.SetPreferredFormat(const value: TString);
begin
  SetProperty('PreferredFormat', value);
end;
{/TLlDOMPropertyDatamatrixBarcodeSource}

{TLlDOMPropertyAztecBarcodeSource}

function TLlDOMPropertyAztecBarcodeSource.GetDataLayer: TString;
begin
  result:= GetProperty('DataLayer');
end;

procedure TLlDOMPropertyAztecBarcodeSource.SetDataLayer(const value: TString);
begin
  SetProperty('DataLayer', value);
end;
{/TLlDOMPropertyAztecBarcodeSource}

{TLlDOMPropertyQRBarcodeSource}
function TLlDOMPropertyQRBarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLlDOMPropertyQRBarcodeSource.GetPreferredFormat: TString;
begin
  result:= GetProperty('PreferredFormat');
end;


procedure TLlDOMPropertyQRBarcodeSource.SetPreferredFormat(const value: TString);
begin
  SetProperty('PreferredFormat', value);
end;


procedure TLlDOMPropertyQRBarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

function TLlDOMPropertyQRBarcodeSource.GetCorrectionLevel: TString;
begin
  result:= GetProperty('CorrectionLevel');
end;

function TLlDOMPropertyQRBarcodeSource.GetFNC1Mode: TString;
begin
  result:= GetProperty('FNC1Mode');
end;

procedure TLlDOMPropertyQRBarcodeSource.SetCorrectionLevel(const value: TString);
begin
  SetProperty('CorrectionLevel', value);
end;

procedure TLlDOMPropertyQRBarcodeSource.SetFNC1Mode(const value: TString);
begin
  SetProperty('FNC1Mode', value);
end;

{/TLlDOMPropertyQRBarcodeSource}

{ TLlDOMObjectRTF }

constructor TLlDOMObjectRTF.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'RTFText', list.Count);
end;

constructor TLlDOMObjectRTF.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'RTF-Text', index);
end;

destructor TLlDOMObjectRTF.Destroy;
begin
  fSource.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectRTF.GetAllowPageBreak: TString;
begin
  result := GetProperty('AllowPageBreak');
end;

function TLlDOMObjectRTF.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMObjectRTF.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectRTF.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectRTF.GetRTFSource: TLlDOMPropertyRTFSource;
var
  baseObj: TLlDOMItem;
begin
  if fSource <> nil then
  begin
    result := fSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fSource := TLlDOMPropertyRTFSource.Create(baseObj);
    baseObj.Free;
    result := fSource;
  end;
end;

function TLlDOMObjectRTF.GetSourceLinkID: TString;
begin
  result := GetProperty('SourceLinkID');
end;

procedure TLlDOMObjectRTF.SetAllowPageBreak(const value: TString);
begin
  SetProperty('AllowPageBreak', value);
end;

procedure TLlDOMObjectRTF.SetDirection(const value: TString);
begin
  SetProperty('Direction', value);
end;

procedure TLlDOMObjectRTF.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectRTF.SetSourceLinkID(const value: TString);
begin
  SetProperty('SourceLinkID', value);
end;

(*function TLlDOMObjectRTF.GetSourceLinkUUID: TString;
begin
  result := GetProperty('SourceLinkUUID');
end;

procedure TLlDOMObjectRTF.SetSourceLinkUUID(const value: TString);
begin
  SetProperty('SourceLinkUUID', value);
end;*)

procedure TLlDOMObjectRTF.SourceLinkTo(parentObject: TLlDOMObjectRTF);
begin
  SourceLinkID := parentObject.Id;
end;

procedure TLlDOMObjectRTF.SourceUnlink;
begin
  SourceLinkID := '0';
end;

{ TRTFSource }

function TLlDOMPropertyRTFSource.GetIsVariable: TString;
begin
  result := GetProperty('IsVariable');
end;

function TLlDOMPropertyRTFSource.GetText: TString;
begin
  result := GetProperty('Text');
end;

procedure TLlDOMPropertyRTFSource.SetIsVariable(const value: TString);
begin
  SetProperty('IsVariable', value);
end;

procedure TLlDOMPropertyRTFSource.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;

{ TLlDOMObjectInputBase }

constructor TLlDOMObjectInputBase.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Input', list.Count);
end;

constructor TLlDOMObjectInputBase.Create(list: TLlDOMObjectList;
  index: integer);
begin
  inherited Create(list, 'Input', index);
end;

function TLlDOMObjectInputBase.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectInputBase.GetAnimation: TLlDOMPropertyAnimation;
begin
  raise Exception.Create('NotImplemented');
end;

function TLlDOMObjectInputBase.GetInputObjectType: TString;
begin
  result := GetProperty('InputObjectType');
end;

function TLlDOMObjectInputBase.GetTooltip: TString;
begin
  result := GetProperty('Tooltip');
end;

function TLlDOMObjectInputBase.GetUneditable: TString;
begin
  result := GetProperty('Uneditable');
end;

procedure TLlDOMObjectInputBase.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectInputBase.SetInputObjectType(const value: TString);
begin
  SetProperty('InputObjectType', value);
end;

procedure TLlDOMObjectInputBase.SetTooltip(const value: TString);
begin
  SetProperty('Tooltip', value);
end;

procedure TLlDOMObjectInputBase.SetUneditable(const value: TString);
begin
  SetProperty('Uneditable', value);
end;

{ TLlDOMObjetInputEdit }

destructor TLlDOMObjectInputEdit.Destroy;
begin
  fFrame.Free;
  fFilling.Free;
  fFont.Free;
  fVerification.Free;
  inherited;
end;

function TLlDOMObjectInputEdit.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMObjectInputEdit.GetDefaultValue: TString;
begin
  result := GetProperty('DefaultValueText');
end;

function TLlDOMObjectInputEdit.GetFieldName: TString;
begin
  result := GetProperty('FieldName');
end;

function TLlDOMObjectInputEdit.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMObjectInputEdit.GetTextFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectInputEdit.GetVerification: TLlDOMPropertyVerification;
var
  baseObj: TLlDOMItem;
begin
  if fVerification <> nil then
  begin
    result := fVerification
  end
  else
  begin
    baseObj := GetObject('Verification');
    fVerification := TLlDOMPropertyVerification.Create(baseObj);
    baseObj.Free;
    result := fVerification;
  end;
end;

function TLlDOMObjectInputEdit.GetFrameExt: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectInputEdit.GetMultiline: TString;
begin
  result := GetProperty('Multiline');
end;

function TLlDOMObjectInputEdit.GetNeedInput: TString;
begin
  result := GetProperty('NeedInput');
end;

procedure TLlDOMObjectInputEdit.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMObjectInputEdit.SetDefaultValue(const value: TString);
begin
  SetProperty('DefaultValueText', value);
end;

procedure TLlDOMObjectInputEdit.SetFieldName(const value: TString);
begin
  SetProperty('FieldName', value);
end;

procedure TLlDOMObjectInputEdit.SetMultiline(const value: TString);
begin
  SetProperty('Multiline', value);
end;

procedure TLlDOMObjectInputEdit.SetNeedInput(const value: TString);
begin
  SetProperty('NeedInput', value);
end;

{ TVerification }

function TLlDOMPropertyVerification.GetMatchPattern: TString;
begin
  result := GetProperty('MatchPattern');
end;

function TLlDOMPropertyVerification.GetValidationFailedHint: TString;
begin
  result := GetProperty('ValidationFailedHint');
end;

procedure TLlDOMPropertyVerification.SetMatchPattern(const value: TString);
begin
  SetProperty('MatchPattern', value);
end;

procedure TLlDOMPropertyVerification.SetValidationFailedHint
  (const value: TString);
begin
  SetProperty('ValidationFailedHint', value);
end;

{ TLlDOMObjetInputCheckbox }

destructor TLlDOMObjectInputCheckbox.Destroy;
begin
  fFrame.Free;
  fFilling.Free;
  inherited;
end;

function TLlDOMObjectInputCheckbox.GetCheckboxType: TString;
begin
  result := GetProperty('CheckboxType');
end;

function TLlDOMObjectInputCheckbox.GetDefaultValue: TString;
begin
  result := GetProperty('DefaultValueBool');
end;

function TLlDOMObjectInputCheckbox.GetFieldName: TString;
begin
  result := GetProperty('FieldName');
end;

function TLlDOMObjectInputCheckbox.GetTextFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectInputCheckbox.GetFrameExt: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectInputCheckbox.SetCheckboxType(const value: TString);
begin
  SetProperty('CheckboxType', value);
end;

procedure TLlDOMObjectInputCheckbox.SetDefaultValue(const value: TString);
begin
  SetProperty('DefaultValueBool', value);
end;

procedure TLlDOMObjectInputCheckbox.SetFieldName(const value: TString);
begin
  SetProperty('FieldName', value);
end;

{ TLlDOMObjetInputCombobox }

destructor TLlDOMObjectInputCombobox.Destroy;
begin
  fFilling.Free;
  fFont.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectInputCombobox.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMObjectInputCombobox.GetChoices: TString;
begin
  result := GetProperty('Choices');
end;

function TLlDOMObjectInputCombobox.GetDefaultValue: TString;
begin
  result := GetProperty('DefaultValueText');
end;

function TLlDOMObjectInputCombobox.GetEditable: TString;
begin
  result := GetProperty('Editable');
end;

function TLlDOMObjectInputCombobox.GetFieldName: TString;
begin
  result := GetProperty('FieldName');
end;

function TLlDOMObjectInputCombobox.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMObjectInputCombobox.GetFrameExt: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectInputCombobox.GetNeedInput: TString;
begin
  result := GetProperty('NeedInput');
end;

function TLlDOMObjectInputCombobox.GetTextFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

procedure TLlDOMObjectInputCombobox.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMObjectInputCombobox.SetChoices(const value: TString);
begin
  SetProperty('Choices', value);
end;

procedure TLlDOMObjectInputCombobox.SetDefaultValue(const value: TString);
begin
  SetProperty('DefaultValueText', value);
end;

procedure TLlDOMObjectInputCombobox.SetEditable(const value: TString);
begin
  SetProperty('Editable', value);
end;

procedure TLlDOMObjectInputCombobox.SetFieldName(const value: TString);
begin
  SetProperty('FieldName', value);
end;

procedure TLlDOMObjectInputCombobox.SetNeedInput(const value: TString);
begin
  SetProperty('NeedInput', value);
end;

{ TLlDOMObjetInputButton }

constructor TLlDOMObjectInputButton.Create(actionType: TLLDOMButtonActionType; list: TLlDOMObjectList);
begin
inherited Create(list, 'Input', list.Count);
  SetProperty ('InputObjectType', '3');

  case actionType of
    atSendTo:
    begin
      Action.Actiontype := '0';
    end;
    atSaveAs:
    begin
      Action.Actiontype := '1';
    end;
    atHttpPost:
    begin
      Action.Actiontype := '2';
    end;
    atActionLink:
    begin
      Action.Actiontype := '3';
    end;
      atPdfSig:
    begin
      Action.Actiontype := '4';
    end;
  end;

end;

destructor TLlDOMObjectInputButton.Destroy;
begin
  fFont.Free;
  fAction.Free;
  inherited;
end;

function TLlDOMObjectInputButton.GetAction: TLlDOMPropertyInputButtonActionBase;
var
  baseObj: TLlDOMItem;
begin
  if fAction <> nil then
    fAction.Free;

    baseObj := GetObject('Button');
  fAction := TLlDOMPropertyInputButtonActionBase.Create(baseObj);
    baseObj.Free;
  fAction:= TLlDOMHelper.SafeInputButtonActionCast(fAction);
    result := fAction;

end;

function TLlDOMObjectInputButton.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMObjectInputButton.GetText: TString;
begin
  result := GetProperty('Text');
end;

procedure TLlDOMObjectInputButton.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;

{ TAction }

function TLlDOMPropertyInputButtonActionLink.GetUrl: TString;
begin
  result:= GetProperty('Link.URL');
end;
procedure TLlDOMPropertyInputButtonActionLink.SetUrl(const value: TString);
begin
  SetProperty('Link.URL', value);
end;

function TLlDOMPropertyInputButtonActionHttpPost.GetExtraFields: TString;
begin
  result:= GetProperty('ExtraFields');
end;

function TLlDOMPropertyInputButtonActionHttpPost.GetUrl: TString;
begin
  result:= GetProperty('HTTPPostURL');
end;

procedure TLlDOMPropertyInputButtonActionHttpPost.SetExtraFields(const value: TString);
begin
  SetProperty('ExtraFields', value);
end;

procedure TLlDOMPropertyInputButtonActionHttpPost.SetUrl(const value: TString);
begin
  SetProperty('HTTPPostURL', value);
end;

function TLlDOMPropertyInputButtonActionSaveAs.GetFileName: TString;
begin
  result := GetProperty('FileName');
end;

function TLlDOMPropertyInputButtonActionSaveAs.GetFormat: TString;
begin
  result := GetProperty('Format');
end;

function TLlDOMPropertyInputButtonActionSaveAs.GetShowDialog: TString;
begin
  result := GetProperty('ShowDialog');
end;

procedure TLlDOMPropertyInputButtonActionSaveAs.SetFileName(const value: TString);
begin
  SetProperty('FileName', value);
end;

procedure TLlDOMPropertyInputButtonActionSaveAs.SetFormat(const value: TString);
begin
  SetProperty('Format', value);
end;

procedure TLlDOMPropertyInputButtonActionSaveAs.SetShowDialog(const value: TString);
begin
  SetProperty('ShowDialog', value);
end;

function TLlDOMPropertyInputButtonActionBase.GetActionType : TString;
begin
  result := GetProperty('Action');
end;

procedure TLlDOMPropertyInputButtonActionBase.SetActionType(const value: TString);
begin
  SetProperty('Action', value);
end;

function TLlDOMPropertyInputButtonActionSendTo.GetBCC: TString;
begin
  result := GetProperty('SendToBCC');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetBody: TString;
begin
  result := GetProperty('SendToBody');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetCC: TString;
begin
  result := GetProperty('SendToCC');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetFormat: TString;
begin
  result := GetProperty('SendToFormat');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetMailTo: TString;
begin
  result := GetProperty('SendToTo');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetShowDialog: TString;
begin
  result := GetProperty('SendToShowDialog');
end;

function TLlDOMPropertyInputButtonActionSendTo.GetSubject: TString;
begin
  result := GetProperty('SendToSubject');
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetBCC(const value: TString);
begin
  SetProperty('SendToBCC', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetBody(const value: TString);
begin
  SetProperty('SendToBody', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetCC(const value: TString);
begin
  SetProperty('CC', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetFormat(const value: TString);
begin
  SetProperty('SendToFormat', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetMailTo(const value: TString);
begin
  SetProperty('SendToTo', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetShowDialog(const value: TString);
begin
  SetProperty('ShowDialog', value);
end;

procedure TLlDOMPropertyInputButtonActionSendTo.SetSubject(const value: TString);
begin
  SetProperty('Subject', value);
end;

{ TLlDOMObjectHTML }

constructor TLlDOMObjectHTML.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'LLX', list.Count);
end;

constructor TLlDOMObjectHTML.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'LLX', index);
end;

destructor TLlDOMObjectHTML.Destroy;
begin
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectHTML.GetAllowPageBreak: TString;
begin
  result := GetProperty('AllowPageBreak');
end;

procedure TLlDOMObjectHTML.SetAllowPageBreak(const value: TString);
begin
  SetProperty('AllowPageBreak', value);
end;

function TLlDOMObjectHTML.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMObjectHTML.GetContentType: TString;
begin
  result := GetProperty('ContentType');
end;

function TLlDOMObjectHTML.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectHTML.GetFitToObject: TString;
begin
  result := GetProperty('FitToObject');
end;

function TLlDOMObjectHTML.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectHTML.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMObjectHTML.SetContentType(const value: TString);
begin
  SetProperty('ContentType', value);
end;

procedure TLlDOMObjectHTML.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMObjectHTML.SetFitToObject(const value: TString);
begin
  SetProperty('FitToObject', value);
end;

{ TllDomPropertyPrintableArea }

destructor TllDomPropertyPrintableArea.Destroy;
begin
  if Assigned(fExtent) then
    fExtent.Free;
  if Assigned(fOffset) then
    fOffset.Free;
  inherited;
end;

function TllDomPropertyPrintableArea.GetExtent: TLlDOMPropertyExtent;
var
  baseObj: TLlDOMItem;
begin
  if (fExtent <> nil) then
  begin
    result := fExtent
  end
  else
  begin
    baseObj := GetObject('Extent');
    fExtent := TLlDOMPropertyExtent.Create(baseObj);
    baseObj.Free;
    result := fExtent;
  end;
end;

function TllDomPropertyPrintableArea.GetOffset: TLlDOMPropertyOffset;
var
  baseObj: TLlDOMItem;
begin
  if (fOffset <> nil) then
  begin
    result := fOffset
  end
  else
  begin
    baseObj := GetObject('Offset');
    fOffset := TLlDOMPropertyOffset.Create(baseObj);
    baseObj.Free;
    result := fOffset;
  end;
end;

{ TExtent }

function TLlDOMPropertyExtent.GetHorizontal: TString;
begin
  result := GetProperty('Horizontal');
end;

function TLlDOMPropertyExtent.GetVertical: TString;
begin
  result := GetProperty('Vertical');
end;

procedure TLlDOMPropertyExtent.SetHorizontal(const value: TString);
begin
  SetProperty('Horizontal', value);
end;

procedure TLlDOMPropertyExtent.SetVertical(const value: TString);
begin
  SetProperty('Vertical', value);
end;

{ TOffset }

function TLlDOMPropertyOffset.GetHorizontal: TString;
begin
  result := GetProperty('Horizontal');
end;

function TLlDOMPropertyOffset.GetVertical: TString;
begin
  result := GetProperty('Vertical');
end;

procedure TLlDOMPropertyOffset.SetHorizontal(const value: TString);
begin
  SetProperty('Horizontal', value);
end;

procedure TLlDOMPropertyOffset.SetVertical(const value: TString);
begin
  SetProperty('Vertical', value);
end;

{ TLlDOMPropertyProjectParameterList }

function TLlDOMPropertyProjectParameterList.Add
  (domObj: TLlDOMPropertyProjectParameterBase): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMPropertyProjectParameterList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

{ TLlDOMPropertyProjectParameter }

constructor TLlDOMPropertyProjectParameterBase.Create
  (list: TLlDOMPropertyProjectParameterList);
var
  newProjectParameter: TLlDOMItem;
begin
  newProjectParameter := list.NewItem(list.Count);
  inherited Create(newProjectParameter.fDomHandle);
  list.Add(self);
  newProjectParameter.Free;
end;

function TLlDOMPropertyProjectParameterBase.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyProjectParameterBase.GetName: TString;
begin
  result := GetProperty('Name');
end;

function TLlDOMPropertyProjectParameterBase.GetParameterType: TString;
begin
  result := GetProperty('ParameterType');
end;

procedure TLlDOMPropertyProjectParameterBase.SetContents(const value: TString);
begin
  if self <> nil then
    SetProperty('Contents', value);

end;

procedure TLlDOMPropertyProjectParameterBase.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

procedure TLlDOMPropertyProjectParameterBase.SetParameterType
  (const value: TString);
begin
  SetProperty('ParameterType', value);
end;

destructor TLlDOMPropertyProjectParameterList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMPropertyProjectParameterList.GetItemName(Name: TString)
  : TLlDOMPropertyProjectParameterBase;
var
  i: integer;
begin
  result := nil;
  for i := 0 to self.Count - 1 do
    if self.Items[i].Name = Name then
    begin
      result := self.Items[i];
      exit;
    end;
end;

function TLlDOMPropertyProjectParameterList.GetItems(index: integer)
  : TLlDOMPropertyProjectParameterBase;
begin
  result := TLlDOMPropertyProjectParameterBase(inherited Items[index]);
end;

function TLlDOMPropertyProjectParameterList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyProjectParameterBase;
begin
  newDomObj := TLlDOMPropertyProjectParameterBase.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'ProjectParemeter');
  result := newDomObj;
end;

procedure TLlDOMPropertyProjectParameterList.SetItemName(Name: TString;
  const value: TLlDOMPropertyProjectParameterBase);
var
  i: integer;
begin
  for i := 0 to self.Count - 1 do
    if self.Items[i].Name = Name then
    begin
      self.Items[i] := value;
      exit;
    end;
end;

procedure TLlDOMPropertyProjectParameterList.SetItems(index: integer;
  value: TLlDOMPropertyProjectParameterBase);
begin
  inherited Items[index] := value;
end;

{ TLlDOMPropertyLayoutPagesBase }

function TLlDOMPropertyLayoutPagesBase.GetForcePaperFormat: TString;
begin
  result := GetProperty('ForcePaperFormat');
end;

function TLlDOMPropertyLayoutPagesBase.GetUsePhysicalPage: TString;
begin
  result := GetProperty('UsePhysicalPage');
end;

procedure TLlDOMPropertyLayoutPagesBase.SetForcePaperFormat
  (const value: TString);
begin
  SetProperty('ForcePaperFormat', value);
end;

procedure TLlDOMPropertyLayoutPagesBase.SetUsePhysicalPage
  (const value: TString);
begin
  SetProperty('UsePhysicalPage', value);
end;

{ TLlDOMPropertyLayoutPages }

destructor TLlDOMPropertyLayoutListPages.Destroy;
begin
  fFirst.Free;
  fFollowing.Free;
  inherited;
end;

function TLlDOMPropertyLayoutListPages.GetFirst: TLlDOMPropertyLayoutPagesBase;
var
  baseObj: TLlDOMItem;
begin
  if (fFirst <> nil) then
  begin
    result := fFirst
  end
  else
  begin
    baseObj := GetObject('First');
    fFirst := TLlDOMPropertyLayoutPagesBase.Create(baseObj);
    baseObj.Free;
    result := fFirst;
  end;
end;

function TLlDOMPropertyLayoutListPages.GetFollowing
  : TLlDOMPropertyLayoutPagesBase;
var
  baseObj: TLlDOMItem;
begin
  if (fFollowing <> nil) then
  begin
    result := fFollowing
  end
  else
  begin
    baseObj := GetObject('Following');
    fFollowing := TLlDOMPropertyLayoutPagesBase.Create(baseObj);
    baseObj.Free;
    result := fFollowing;
  end;
end;

{ TLlDOMPropertyLayout }

destructor TLlDOMPropertyLayoutBase.Destroy;
begin
  fGrid.Free;
  fRulerGuides.Free;
  inherited;
end;

function TLlDOMPropertyLayoutBase.GetGrid: TLlDOMPropertyGrid;
var
  baseObj: TLlDOMItem;
begin
  if (fGrid <> nil) then
  begin
    result := fGrid
  end
  else
  begin
    baseObj := GetObject('Grid');
    fGrid := TLlDOMPropertyGrid.Create(baseObj);
    baseObj.Free;
    result := fGrid;
  end;
end;

function TLlDOMPropertyLayoutBase.GetRulerGuides: TLlDOMPropertyRulerGuides;
var
  baseObj: TLlDOMItem;
begin
  if (fRulerGuides <> nil) then
  begin
    result := fRulerGuides
  end
  else
  begin
    baseObj := GetObject('RulerGuides');
    fRulerGuides := TLlDOMPropertyRulerGuides.Create(baseObj);
    baseObj.Free;
    result := fRulerGuides;
  end;
end;

{ TLlDOMPropertyLayout }

function TLlDOMPropertyLayout.GetPrintOrder: TString;
begin
  result := GetProperty('PrintOrder');
end;

function TLlDOMPropertyLayout.GetXCount: TString;
begin
  result := GetProperty('XCount');
end;

function TLlDOMPropertyLayout.GetXDistance: TString;
begin
  result := GetProperty('XDistance');
end;

function TLlDOMPropertyLayout.GetXOffset: TString;
begin
  result := GetProperty('XOffset');
end;

function TLlDOMPropertyLayout.GetXSize: TString;
begin
  result := GetProperty('XSize');
end;

function TLlDOMPropertyLayout.GetYCount: TString;
begin
  result := GetProperty('YCount');
end;

function TLlDOMPropertyLayout.GetYDistance: TString;
begin
  result := GetProperty('YDistance');
end;

function TLlDOMPropertyLayout.GetYOffset: TString;
begin
  result := GetProperty('YOffset');
end;

function TLlDOMPropertyLayout.GetYSize: TString;
begin
  result := GetProperty('YSize');
end;

procedure TLlDOMPropertyLayout.SetPrintOrder(const value: TString);
begin
  SetProperty('PrintOrder', value)
end;

procedure TLlDOMPropertyLayout.SetXCount(const value: TString);
begin
  SetProperty('XCount', value)
end;

procedure TLlDOMPropertyLayout.SetXDistance(const value: TString);
begin
  SetProperty('XDistance', value)
end;

procedure TLlDOMPropertyLayout.SetXOffset(const value: TString);
begin
  SetProperty('XOffset', value)
end;

procedure TLlDOMPropertyLayout.SetXSize(const value: TString);
begin
  SetProperty('XSize', value)
end;

procedure TLlDOMPropertyLayout.SetYCount(const value: TString);
begin
  SetProperty('YCount', value)
end;

procedure TLlDOMPropertyLayout.SetYDistance(const value: TString);
begin
  SetProperty('YDistance', value)
end;

procedure TLlDOMPropertyLayout.SetYOffset(const value: TString);
begin
  SetProperty('YOffset', value)
end;

procedure TLlDOMPropertyLayout.SetYSize(const value: TString);
begin
  SetProperty('YSize', value)
end;

{ TLlDOMPropertyGrid }

destructor TLlDOMPropertyGrid.Destroy;
begin
  fSpacing.Free;
  inherited;
end;

function TLlDOMPropertyGrid.GetShow: TString;
begin
  result := GetProperty('Show');
end;

function TLlDOMPropertyGrid.GetSnap: TString;
begin
  result := GetProperty('Snap');
end;

function TLlDOMPropertyGrid.GetSpacing: TLlDOMPropertySpacing;
var
  baseObj: TLlDOMItem;
begin
  if (fSpacing <> nil) then
  begin
    result := fSpacing
  end
  else
  begin
    baseObj := GetObject('Spacing');
    fSpacing := TLlDOMPropertySpacing.Create(baseObj);
    baseObj.Free;
    result := fSpacing;
  end;
end;

procedure TLlDOMPropertyGrid.SetShow(const value: TString);
begin
  SetProperty('Show', value);
end;

procedure TLlDOMPropertyGrid.SetSnap(const value: TString);
begin
  SetProperty('Snap', value);
end;

{ TSpacing }

function TLlDOMPropertySpacing.GetHorizontal: TString;
begin
  result := GetProperty('Horizontal');
end;

function TLlDOMPropertySpacing.GetVertical: TString;
begin
  result := GetProperty('Vertical');
end;

procedure TLlDOMPropertySpacing.SetHorizontal(const value: TString);
begin
  SetProperty('Horizontal', value);
end;

procedure TLlDOMPropertySpacing.SetVertical(const value: TString);
begin
  SetProperty('Vertical', value);
end;

{ TLlDOMPropertySettings }

destructor TLlDOMPropertySettings.Destroy;
begin
  fDefaultFont.Free;
  fDefaultDefaultFont.Free;
  fRepresentationCodes.Free;
  fTextQuoteCodes.Free;
  inherited;
end;

function TLlDOMPropertySettings.GetCreated: TString;
begin
  result := GetProperty('Created');
end;

function TLlDOMPropertySettings.GetDecimals: TString;
begin
  result := GetProperty('Decimals');
end;

function TLlDOMPropertySettings.GetDefaultDefaultFont
  : TLlDOMPropertyDefaultFont;
var
  baseObj: TLlDOMItem;
begin
  if (fDefaultDefaultFont <> nil) then
  begin
    result := fDefaultDefaultFont
  end
  else
  begin
    baseObj := GetObject('DefaultDefaultFont');
    fDefaultDefaultFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fDefaultDefaultFont;
  end;
end;

function TLlDOMPropertySettings.GetDefaultDestination: TString;
begin
  result := GetProperty('DefaultDestination');
end;

function TLlDOMPropertySettings.GetDefaultFont: TLlDOMPropertyDefaultFont;
var
  baseObj: TLlDOMItem;
begin
  if (fDefaultFont <> nil) then
  begin
    result := fDefaultFont
  end
  else
  begin
    baseObj := GetObject('DefaultFont');
    fDefaultFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fDefaultFont;
  end;
end;

function TLlDOMPropertySettings.GetFileVersion: TString;
begin
  result := GetProperty('FileVersion');
end;

function TLlDOMPropertySettings.GetLCID: TString;
begin
  result := GetProperty('LCID');
end;

function TLlDOMPropertySettings.GetMaxPDFIndexDepth: TString;
begin
  result := GetProperty('MaxPDFIndexDepth');
end;

function TLlDOMPropertySettings.GetMaxPDFOutlineDepth: TString;
begin
  result := GetProperty('MaxPDFOutlineDepth');
end;

function TLlDOMPropertySettings.GetMetrics: TString;
begin
  result := GetProperty('Metrics');
end;

function TLlDOMPropertySettings.GetRepresentationCodes
  : TLlDOMPropertyRepresentationCodes;
var
  baseObj: TLlDOMItem;
begin
  if (fRepresentationCodes <> nil) then
  begin
    result := fRepresentationCodes
  end
  else
  begin
    baseObj := GetObject('RepresentationCodes');
    fRepresentationCodes := TLlDOMPropertyRepresentationCodes.Create(baseObj);
    baseObj.Free;
    result := fRepresentationCodes;
  end;
end;

function TLlDOMPropertySettings.GetTextQuoteCodes: TLlDOMPropertyTextQuoteCodes;
var
  baseObj: TLlDOMItem;
begin
  if (fTextQuoteCodes <> nil) then
  begin
    result := fTextQuoteCodes
  end
  else
  begin
    baseObj := GetObject('TextQuoteCodes');
    fTextQuoteCodes := TLlDOMPropertyTextQuoteCodes.Create(baseObj);
    baseObj.Free;
    result := fTextQuoteCodes;
  end;
end;

procedure TLlDOMPropertySettings.SetCreated(const value: TString);
begin
  SetProperty('Created', value);
end;

procedure TLlDOMPropertySettings.SetDecimals(const value: TString);
begin
  SetProperty('Decimals', value);
end;

procedure TLlDOMPropertySettings.SetDefaultDestination(const value: TString);
begin
  SetProperty('DefaultDestination', value);
end;

procedure TLlDOMPropertySettings.SetFileVersion(const value: TString);
begin
  SetProperty('FileVersion', value);
end;

procedure TLlDOMPropertySettings.SetMaxPDFIndexDepth(const value: TString);
begin
  SetProperty('SetMaxPDFIndexDepth', value);
end;

procedure TLlDOMPropertySettings.SetMaxPDFOutlineDepth(const value: TString);
begin
  SetProperty('MaxPDFOutlineDepth', value);
end;

procedure TLlDOMPropertySettings.SetMetrics(const value: TString);
begin
  SetProperty('Metrics', value);
end;

{ TDefaultFont }

function TLlDOMPropertyDefaultFont.GetBold: TString;
begin
  result := GetProperty('Bold');
end;

function TLlDOMPropertyDefaultFont.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyDefaultFont.GetFaceName: TString;
begin
  result := GetProperty('FaceName');
end;

function TLlDOMPropertyDefaultFont.GetGdiCharSet: TString;
begin
  result := GetProperty('GdiCharSet');
end;

function TLlDOMPropertyDefaultFont.GetItalic: TString;
begin
  result := GetProperty('Italic');
end;

function TLlDOMPropertyDefaultFont.GetSize: TString;
begin
  result := GetProperty('Size');
end;

function TLlDOMPropertyDefaultFont.GetStrikeout: TString;
begin
  result := GetProperty('Strikeout');
end;

function TLlDOMPropertyDefaultFont.GetUnderline: TString;
begin
  result := GetProperty('Underline');
end;

function TLlDOMPropertyDefaultFont.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyDefaultFont.SetBold(const value: TString);
begin
  SetProperty('Bold', value);
end;

procedure TLlDOMPropertyDefaultFont.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyDefaultFont.SetFaceName(const value: TString);
begin
  SetProperty('FaceName', value);
end;

procedure TLlDOMPropertyDefaultFont.SetFont(nFont: TFont);
begin
  if fsBold in nFont.Style then
    Bold := 'True'
  else
    Bold := 'False';
  if fsItalic in nFont.Style then
    Italic := 'True'
  else
    Italic := 'False';
  if fsUnderline in nFont.Style then
    Underline := 'True'
  else
    Underline := 'False';
  if fsStrikeOut in nFont.Style then
    Strikeout := 'True'
  else
    Strikeout := 'False';

  FaceName := '"' + nFont.Name + '"';
  Size := IntToStr(nFont.Size);
  GdiCharSet := IntToStr(nFont.Charset);
end;

procedure TLlDOMPropertyDefaultFont.SetGdiCharSet(const value: TString);
begin
  SetProperty('GdiCharSet', value);
end;

procedure TLlDOMPropertyDefaultFont.SetItalic(const value: TString);
begin
  SetProperty('Italic', value);
end;

procedure TLlDOMPropertyDefaultFont.SetSize(const value: TString);
begin
  SetProperty('Size', value);
end;

procedure TLlDOMPropertyDefaultFont.SetStrikeout(const value: TString);
begin
  SetProperty('Strikeout', value);
end;

procedure TLlDOMPropertyDefaultFont.SetUnderline(const value: TString);
begin
  SetProperty('Underline', value);
end;

procedure TLlDOMPropertyDefaultFont.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;


constructor TLlDOMConditionalFormatterItemList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();

end;

function TLlDOMConditionalFormatterItemList.Add(domObj: TLlDOMPropertyConditionalFormatterItem): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMConditionalFormatterItemList.GetItems(index: integer):
          TLlDOMPropertyConditionalFormatterItem;
begin
  result := TLlDOMPropertyConditionalFormatterItem(inherited Items[index]);
end;

procedure TLlDOMConditionalFormatterItemList.SetItems(index: integer;
  const value: TLlDOMPropertyConditionalFormatterItem);
begin
  inherited Items[index] := value;
end;

destructor TLlDOMConditionalFormatterItemList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMConditionalFormatterItemList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyConditionalFormatterItem;
begin
  newDomObj := TLlDOMPropertyConditionalFormatterItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'ConditionalFormatter');
  result := newDomObj;
end;

{ TLlDOMPropertyHelpLineBase }

constructor TLlDOMRulerGuide.Create(list: TLlDOMRulerGuideList);
var
  newHelpLine: TLlDOMItem;
begin
  newHelpLine := list.NewItem(list.Count);
  inherited Create(newHelpLine.fDomHandle);
  list.Add(self);
  newHelpLine.Free;
end;

function TLlDOMRulerGuide.GetCatchRangePixels: TString;
begin
  result := GetProperty('CatchRangePixels');
end;

function TLlDOMRulerGuide.GetLocked: TString;
begin
  result := GetProperty('Locked');
end;

function TLlDOMRulerGuide.GetPosition: TString;
begin
  result := GetProperty('Position');
end;

procedure TLlDOMRulerGuide.SetCatchRangePixels(const value: TString);
begin
  SetProperty('CatchRangePixels', value);
end;

procedure TLlDOMRulerGuide.SetLocked(const value: TString);
begin
  SetProperty('Locked', value);
end;

procedure TLlDOMRulerGuide.SetPosition(const value: TString);
begin
  SetProperty('Position', value);
end;

{ TLlDOMPropertyHelpLines }

destructor TLlDOMPropertyRulerGuides.Destroy;
begin
  fVertical.Free;
  fHorizontal.Free;
  inherited;
end;

function TLlDOMPropertyRulerGuides.GetHorizontalList: TLlDOMRulerGuideList;
begin
  if fHorizontal = nil then
  begin
    fHorizontal := TLlDOMRulerGuideList.Create(GetObject('Horizontal'));
  end;
  result := fHorizontal;
end;

function TLlDOMPropertyRulerGuides.GetVerticalList: TLlDOMRulerGuideList;
begin
  if fVertical = nil then
  begin
    fVertical := TLlDOMRulerGuideList.Create(GetObject('Vertical'));
  end;
  result := fVertical;
end;

{ TLlDOMPropertyHorizontalHelpLineList }
function TLlDOMRulerGuideList.GetItems(index: integer): TLlDOMRulerGuide;
begin
  result := TLlDOMRulerGuide(inherited Items[index]);
end;

procedure TLlDOMRulerGuideList.SetItems(index: integer;
  const value: TLlDOMRulerGuide);
begin
  inherited Items[index] := value;
end;

function TLlDOMRulerGuideList.Add(domObj: TLlDOMRulerGuide): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMRulerGuideList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMRulerGuideList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMRulerGuideList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMRulerGuide;
begin
  newDomObj := TLlDOMRulerGuide.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'Horizontal');
  result := newDomObj;
end;

{ TRepresentationCodes }

function TLlDOMPropertyRepresentationCodes.GetCondEnd: TString;
begin
  result := GetProperty('CondEnd');
end;

function TLlDOMPropertyRepresentationCodes.GetCondSep: TString;
begin
  result := GetProperty('CondSep');
end;

function TLlDOMPropertyRepresentationCodes.GetCondStart: TString;
begin
  result := GetProperty('CondStart');
end;

function TLlDOMPropertyRepresentationCodes.GetExprSep: TString;
begin
  result := GetProperty('ExprSep');
end;

function TLlDOMPropertyRepresentationCodes.GetLockNextChar: TString;
begin
  result := GetProperty('LockNextChar');
end;

function TLlDOMPropertyRepresentationCodes.GetPhantomSpace: TString;
begin
  result := GetProperty('PhantomSpace');
end;

function TLlDOMPropertyRepresentationCodes.GetRet: TString;
begin
  result := GetProperty('Ret');
end;

function TLlDOMPropertyRepresentationCodes.GetTab: TString;
begin
  result := GetProperty('Tab');
end;

procedure TLlDOMPropertyRepresentationCodes.SetCondEnd(const value: TString);
begin
  SetProperty('CondEnd', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetCondSep(const value: TString);
begin
  SetProperty('CondSep', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetCondStart(const value: TString);
begin
  SetProperty('CondStart', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetExprSep(const value: TString);
begin
  SetProperty('ExprSep', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetLockNextChar
  (const value: TString);
begin
  SetProperty('LockNextChar', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetPhantomSpace
  (const value: TString);
begin
  SetProperty('PhantomSpace', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetRet(const value: TString);
begin
  SetProperty('Ret', value);
end;

procedure TLlDOMPropertyRepresentationCodes.SetTab(const value: TString);
begin
  SetProperty('Tab', value);
end;


function TLlDOMPropertyDefaultFontExt.GetDefault: TString;
begin
  result := GetProperty('Default');
end;
procedure TLlDOMPropertyDefaultFontExt.SetDefault(const value: TString);
begin
  SetProperty('Default', value);
end;
{ TTextQuoteCodes }

function TLlDOMPropertyTextQuoteCodes.GetEndCode: TString;
begin
  result := GetProperty('End');
end;

function TLlDOMPropertyTextQuoteCodes.GetStartCode: TString;
begin
  result := GetProperty('Start');
end;

procedure TLlDOMPropertyTextQuoteCodes.SetEndCode(const value: TString);
begin
  SetProperty('End', value);
end;

procedure TLlDOMPropertyTextQuoteCodes.SetStartCode(const value: TString);
begin
  SetProperty('Start', value);
end;

{ TLlDOMObjectReportContainer }

constructor TLlDOMObjectReportContainer.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'ReportContainer', list.Count);
end;

constructor TLlDOMObjectReportContainer.Create(list: TLlDOMObjectList;
  index: integer);
begin
  inherited Create(list, 'ReportContainer', index);
end;

destructor TLlDOMObjectReportContainer.Destroy;
begin
  fDefaultColumns.Free;
  fDefaultFont.Free;
  fFilling.Free;
  fSubItemList.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectReportContainer.GetDefaultColumns
  : TLlDOMPropertyDefaultColumns;
var
  baseObj: TLlDOMItem;
begin
  if fDefaultColumns <> nil then
  begin
    result := fDefaultColumns
  end
  else
  begin
    baseObj := GetObject('DefaultColumns');
    fDefaultColumns := TLlDOMPropertyDefaultColumns.Create(baseObj);
    baseObj.Free;
    result := fDefaultColumns;
  end;
end;

function TLlDOMObjectReportContainer.GetDefaultFont: TLlDOMPropertyDefaultFont;
var
  baseObj: TLlDOMItem;
begin
  if fDefaultFont <> nil then
  begin
    result := fDefaultFont
  end
  else
  begin
    baseObj := GetObject('DefaultFont');
    fDefaultFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fDefaultFont;
  end;
end;

function TLlDOMObjectReportContainer.GetFilling: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectReportContainer.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMObjectReportContainer.GetSubItemList: TLlDOMSubItemCoreList;
begin
  if fSubItemList = nil then
  begin
    fSubItemList := TLlDOMSubItemCoreList.Create(GetObject('SubItems'));
  end;
  result := fSubItemList;
end;

{ TLlDOMPropertyLayoutList }

destructor TLlDOMPropertyLayoutList.Destroy;
begin
  fPages.Free;
  inherited;
end;

function TLlDOMPropertyLayoutList.GetPages: TLlDOMPropertyLayoutListPages;
var
  baseObj: TLlDOMItem;
begin
  if fPages <> nil then
  begin
    result := fPages
  end
  else
  begin
    baseObj := GetObject('Pages');
    fPages := TLlDOMPropertyLayoutListPages.Create(baseObj);
    baseObj.Free;
    result := fPages;
  end;
end;

{ TLlDomProjectList }

procedure TLlDOMProjectList.Close;
begin
  if projectLoaded then
  begin
    if Assigned(fLayout) then
    begin
      Layout.Free;
      fLayout := nil;
    end;
  end;
  inherited;
end;

constructor TLlDOMProjectList.Create(hTheParentComponent: ILlDomParent);
begin
  projectType := LL_PROJECT_LIST;
  inherited Create(hTheParentComponent);
end;

function TLlDOMProjectList.GetLayout: TLlDOMPropertyLayoutList;
var
  baseObj: TLlDOMItem;
begin
  if (fLayout <> nil) then
  begin
    result := fLayout
  end
  else
  begin
    baseObj := GetObject('Layout');
    fLayout := TLlDOMPropertyLayoutList.Create(baseObj);
    baseObj.Free;
    result := fLayout;
  end;
end;

{ TLlDOMPropertyLayoutPagesLabel }

destructor TLlDOMPropertyLayoutPagesLabel.Destroy;
begin
  fColumns.Free;
  fDistance.Free;
  fExtent.Free;
  fOffset.Free;
  inherited;
end;

function TLlDOMPropertyLayoutPagesLabel.GetColumns: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fColumns <> nil) then
  begin
    result := fColumns
  end
  else
  begin
    baseObj := GetObject('Columns');
    fColumns := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fColumns;
  end;
end;

function TLlDOMPropertyLayoutPagesLabel.GetDistance: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fDistance <> nil) then
  begin
    result := fDistance
  end
  else
  begin
    baseObj := GetObject('Distance');
    fDistance := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fDistance;
  end;
end;

function TLlDOMPropertyLayoutPagesLabel.GetExtent: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fExtent <> nil) then
  begin
    result := fExtent
  end
  else
  begin
    baseObj := GetObject('Extent');
    fExtent := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fExtent;
  end;
end;

function TLlDOMPropertyLayoutPagesLabel.GetOffset: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fOffset <> nil) then
  begin
    result := fOffset
  end
  else
  begin
    baseObj := GetObject('Offset');
    fOffset := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fOffset;
  end;
end;

function TLlDOMPropertyLayoutPagesLabel.GetPrintOrder: TString;
begin
  result := GetProperty('PrintOrder');
end;

procedure TLlDOMPropertyLayoutPagesLabel.SetPrintOrder(const value: TString);
begin
  SetProperty('PrintOrder', value);
end;

{ TLlDOMPropertyLayoutLabelPages }

destructor TLlDOMPropertyLayoutLabelPages.Destroy;
begin
  fFirst.Free;
  fFollowing.Free;
  inherited;
end;

function TLlDOMPropertyLayoutLabelPages.GetFirst
  : TLlDOMPropertyLayoutPagesLabel;
var
  baseObj: TLlDOMItem;
begin
  if (fFirst <> nil) then
  begin
    result := fFirst
  end
  else
  begin
    baseObj := GetObject('First');
    fFirst := TLlDOMPropertyLayoutPagesLabel.Create(baseObj);
    baseObj.Free;
    result := fFirst;
  end;
end;

function TLlDOMPropertyLayoutLabelPages.GetFollowing
  : TLlDOMPropertyLayoutPagesLabel;
var
  baseObj: TLlDOMItem;
begin
  if (fFollowing <> nil) then
  begin
    result := fFollowing
  end
  else
  begin
    baseObj := GetObject('Following');
    fFollowing := TLlDOMPropertyLayoutPagesLabel.Create(baseObj);
    baseObj.Free;
    result := fFollowing;
  end;
end;

{ TLlDomProjectLabel }

procedure TLlDOMProjectLabel.Close;
begin
  if projectLoaded then
  begin
    if Assigned(fLayout) then
    begin
      Layout.Free;
      fLayout := nil;
    end;
  end;
  inherited;
end;

constructor TLlDOMProjectLabel.Create(hTheParentComponent: ILlDomParent);
begin
  projectType := LL_PROJECT_LABEL;
  inherited Create(hTheParentComponent);
end;

function TLlDOMProjectLabel.GetLayout: TLlDOMPropertyLayoutLabel;
var
  baseObj: TLlDOMItem;
begin
  if (fLayout <> nil) then
  begin
    result := fLayout
  end
  else
  begin
    baseObj := GetObject('Layout');
    fLayout := TLlDOMPropertyLayoutLabel.Create(baseObj);
    baseObj.Free;
    result := fLayout;
  end;
end;

{ TLlDomProjectCard }

procedure TLlDOMProjectCard.Close;
begin
  if projectLoaded then
  begin
    if Assigned(fLayout) then
    begin
      Layout.Free;
      fLayout := nil;
    end;
  end;
  inherited;
end;

constructor TLlDOMProjectCard.Create(hTheParentComponent: ILlDomParent);
begin
  projectType := LL_PROJECT_CARD;
  inherited Create(hTheParentComponent);
end;

function TLlDOMProjectCard.GetLayout: TLlDOMPropertyLayoutCard;
var
  baseObj: TLlDOMItem;
begin
  if (fLayout <> nil) then
  begin
    result := fLayout
  end
  else
  begin
    baseObj := GetObject('Layout');
    fLayout := TLlDOMPropertyLayoutCard.Create(baseObj);
    baseObj.Free;
    result := fLayout;
  end;
end;

{ TLlDOMPropertyLayoutPagesLabelColumns }

function TllDomPropertySize.GetHorizontal: TString;
begin
  result := GetProperty('Horizontal');
end;

function TllDomPropertySize.GetVertical: TString;
begin
  result := GetProperty('Vertical');
end;

procedure TllDomPropertySize.SetHorizontal(const value: TString);
begin
  SetProperty('Horizontal', value);
end;

procedure TllDomPropertySize.SetVertical(const value: TString);
begin
  SetProperty('Vertical', value);
end;

{ TLlDOMPropertyLayoutPagesCard }

destructor TLlDOMPropertyLayoutPagesCard.Destroy;
begin
  fColumns.Free;
  fDistance.Free;
  fExtent.Free;
  fOffset.Free;
  inherited;
end;

function TLlDOMPropertyLayoutPagesCard.GetColumns: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fColumns <> nil) then
  begin
    result := fColumns
  end
  else
  begin
    baseObj := GetObject('Columns');
    fColumns := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fColumns;
  end;
end;

function TLlDOMPropertyLayoutPagesCard.GetDistance: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fDistance <> nil) then
  begin
    result := fDistance
  end
  else
  begin
    baseObj := GetObject('Distance');
    fDistance := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fDistance;
  end;
end;

function TLlDOMPropertyLayoutPagesCard.GetExtent: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fExtent <> nil) then
  begin
    result := fExtent
  end
  else
  begin
    baseObj := GetObject('Extent');
    fExtent := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fExtent;
  end;
end;

function TLlDOMPropertyLayoutPagesCard.GetOffset: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fOffset <> nil) then
  begin
    result := fOffset
  end
  else
  begin
    baseObj := GetObject('Offset');
    fOffset := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fOffset;
  end;
end;

function TLlDOMPropertyLayoutPagesCard.GetPrintOrder: TString;
begin
  result := GetProperty('PrintOrder');
end;

procedure TLlDOMPropertyLayoutPagesCard.SetPrintOrder(const value: TString);
begin
  SetProperty('PrintOrder', value);
end;

{ TLlDOMLayerList }
function TLlDOMLayerList.GetItems(index: integer): TLlDOMLayer;
begin
  result := TLlDOMLayer(inherited Items[index]);
end;

procedure TLlDOMLayerList.SetItems(index: integer; const value: TLlDOMLayer);
begin
  inherited Items[index] := value;
end;

function TLlDOMLayerList.Add(domObj: TLlDOMLayer): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMLayerList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMLayerList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMLayerList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMLayer;
begin
  newDomObj := TLlDOMLayer.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Layer');
  result := newDomObj;
end;

{ TLlDOMLayer }

constructor TLlDOMLayer.Create(list: TLlDOMLayerList);
var
  newLayer: TLlDOMItem;
begin
  newLayer := list.NewItem(list.Count);
  inherited Create(newLayer.fDomHandle);
  list.Add(self);
  newLayer.Free;
end;

function TLlDOMLayer.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMLayer.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMLayer.GetFromTemplate: TString;
begin
  result := GetProperty('FromTemplate');
end;

function TLlDOMLayer.GetLayerID: TString;
begin
  result := GetProperty('LayerID');
end;

function TLlDOMLayer.GetName: TString;
begin
  result := GetProperty('Name');
end;

function TLlDOMLayer.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMLayer.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMLayer.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMLayer.SetFromTemplate(const value: TString);
begin
  SetProperty('FromTemplate', value);
end;

procedure TLlDOMLayer.SetLayerID(const value: TString);
begin
  SetProperty('LayerID', value);
end;

procedure TLlDOMLayer.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

procedure TLlDOMLayer.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

{ TLlDOMProjectTemplateList }
function TLlDOMProjectTemplateList.GetItems(index: integer)
  : TLlDOMProjectTemplate;
begin
  result := TLlDOMProjectTemplate(inherited Items[index]);
end;

procedure TLlDOMProjectTemplateList.SetItems(index: integer;
  const value: TLlDOMProjectTemplate);
begin
  inherited Items[index] := value;
end;

function TLlDOMProjectTemplateList.Add(domObj: TLlDOMProjectTemplate): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMProjectTemplateList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMProjectTemplateList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMProjectTemplateList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMProjectTemplate;
begin
  newDomObj := TLlDOMProjectTemplate.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'ProjectTemplate');
  result := newDomObj;
end;

{ TLlDOMProjectTemplate }

constructor TLlDOMProjectTemplate.Create(list: TLlDOMProjectTemplateList);
var
  newLayer: TLlDOMItem;
begin
  newLayer := list.NewItem(list.Count);
  inherited Create(newLayer.fDomHandle);
  list.Add(self);
  newLayer.Free;
end;

function TLlDOMProjectTemplate.GetUUID: TString;
begin
   result := GetProperty('UUID');
end;

{ TLlDOMSubItemList }

function TLlDOMSubItemCoreList.GetItems(index: integer): TLlDOMSubItemCore;
begin
  result := TLlDOMSubItemCore(inherited Items[index]);
end;

procedure TLlDOMSubItemCoreList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMSubItemCore;
  i: integer;
  tempTable: TLlDOMSubItemTableBase;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  tempTable := nil;
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);

    if TLlDOMSubItemCore(baseObj).ObjectType = 'Table' then
    begin
      tempTable := TLlDOMSubItemTableBase.Create(baseObj);
      if (tempTable.TableId = 'LLStaticTable') then
      begin
        newDomObj := TLlDOMSubItemStaticTable.Create(baseObj);
      end
      else
      begin
        newDomObj := TLlDOMSubItemTable.Create(baseObj);
      end;
    end
    else if TLlDOMSubItemCore(baseObj).ObjectType = 'Crosstab' then
      newDomObj := TLlDOMSubItemCrosstab.Create(baseObj)
    else if TLlDOMSubItemCore(baseObj).ObjectType = 'Chart' then
      newDomObj := TLlDOMSubItemChart.Create(baseObj)
    else if TLlDOMSubItemCore(baseObj).ObjectType = 'Gantt' then
      newDomObj := TLlDOMSubItemGanttChart.Create(baseObj)
    else if TLlDOMSubItemCore(baseObj).ObjectType = 'SubReport' then
      newDomObj := TLlDOMSubItemSubReport.Create(baseObj)
    else
      newDomObj := TLlDOMSubItemCore.Create(baseObj);

    baseObj.Free;
	 if Assigned(tempTable) then
    begin
      tempTable.free;
	  tempTable := nil;
    end;
    Add(newDomObj);
  end;
end;

procedure TLlDOMSubItemCoreList.SetItems(index: integer;
  const value: TLlDOMSubItemCore);
begin
  inherited Items[index] := value;
end;

function TLlDOMSubItemCoreList.Add(domObj: TLlDOMSubItemCore): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMSubItemCoreList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMSubItemCoreList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMSubItemCoreList.NewItem(index: integer; ObjectType: TString)
  : TLlDOMItem;
var
  newDomObj: TLlDOMSubItemCore;
begin
  newDomObj := TLlDOMSubItemCore.Create(fDOMObj.CreateSubObject(index,
    ObjectType));
  result := newDomObj;
end;

{ TLlDOMSubItemTableBase }

constructor TLlDOMSubItemTableBase.Create(list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'Table', list.Count);
end;

destructor TLlDOMSubItemTableBase.Destroy;
begin

  fDefaultFrame.Free;
  fFixedSize.Free;

  inherited;

end;

function TLlDOMSubItemTableBase.GetFixedSize: TLlDOMPropertyFixedSize;
var
  baseObj: TLlDOMItem;
begin
  if (fFixedSize <> nil) then
  begin
    result := fFixedSize
  end
  else
  begin
    baseObj := GetObject('FixedSize');
    fFixedSize := TLlDOMPropertyFixedSize.Create(baseObj);
    baseObj.Free;
    result := fFixedSize;
  end;
end;

function TLlDOMSubItemTableBase.GetShowSeparatorTickmarks: TString;
begin
  result := GetProperty('ShowSeparatorTickmarks');
end;

procedure TLlDOMSubItemTableBase.SetShowSeparatorTickmarks
  (const value: TString);
begin
  SetProperty('ShowSeparatorTickmarks', value);
end;

function TLlDOMSubItemTableBase.GetExpandable: TString;
begin
  result := GetProperty('Expandable');
end;

procedure TLlDOMSubItemTableBase.SetExpandable(const value: TString);
begin
  SetProperty('Expandable', value);
end;

function TLlDOMSubItemTableBase.GetPageBreakCondition: TString;
begin
  result := GetProperty('PageBreakCondition');
end;

procedure TLlDOMSubItemTableBase.SetPageBreakCondition(const value: TString);
begin
  SetProperty('PageBreakCondition', value);
end;

function TLlDOMSubItemTableBase.GetSortOrderId: TString;
begin
  result := GetProperty('SortOrderID');
end;

procedure TLlDOMSubItemTableBase.SetSortOrderId(const value: TString);
begin
  SetProperty('SortOrderID', value);
end;

function TLlDOMSubItemTableBase.GetTableId: TString;
begin
  result := GetProperty('TableID');
end;

procedure TLlDOMSubItemTableBase.SetTableId(const value: TString);
begin
  SetProperty('TableID', value);
end;

function TLlDOMSubItemTableBase.GetDefaultFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fDefaultFrame <> nil) then
  begin
    result := fDefaultFrame
  end
  else
  begin
    baseObj := GetObject('DefaultFrame');
    fDefaultFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fDefaultFrame;
  end;
end;

{ TLlDOMSubItemTable }

constructor TLlDOMSubItemTable.Create(list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'Table', list.Count);
end;

destructor TLlDOMSubItemTable.Destroy;
begin

  fLineOptions.Free;
  fLines.Free;
  fSubItems.Free;
  inherited;

end;

function TLlDOMSubItemTable.GetLineOptions: TLlDOMPropertyTableLines;
var
  baseObj: TLlDOMItem;
begin
  if (fLineOptions <> nil) then
  begin
    result := fLineOptions
  end
  else
  begin
    baseObj := GetObject('LineOptions');
    fLineOptions := TLlDOMPropertyTableLines.Create(baseObj);
    baseObj.Free;
    result := fLineOptions;
  end;
end;

function TLlDOMSubItemTable.GetLines: TLlDOMTableLines;
var
  baseObj: TLlDOMItem;
begin
  if (fLines <> nil) then
  begin
    result := fLines
  end
  else
  begin
    baseObj := GetObject('Lines');
    fLines := TLlDOMTableLines.Create(baseObj);
    baseObj.Free;
    result := fLines;
  end;
end;

function TLlDOMSubItemTable.GetRelationID: TString;
begin
  result := GetProperty('RelationID');
end;

procedure TLlDOMSubItemTable.SetRelationID(const value: TString);
begin
  SetProperty('RelationID', value);
end;

function TLlDOMSubItemTable.GetSubItems: TLlDOMSubItemCoreList;
begin
  if (fSubItems <> nil) then
  begin
    result := fSubItems;
  end
  else
  begin
    fSubItems := TLlDOMSubItemCoreList.Create(GetObject('SubItems'));
    result := fSubItems;
  end;
end;

{ TLlDOMSubItemStaticTable }

constructor TLlDOMSubItemStaticTable.Create(list: TLlDOMSubItemCoreList);
begin

  inherited Create(list, 'Table', list.Count);
  TableId := 'LLStaticTable';

end;

destructor TLlDOMSubItemStaticTable.Destroy;
begin

  fLineOptions.Free;
  fLines.Free;
  inherited;

end;

function TLlDOMSubItemStaticTable.GetLineOptions
  : TLlDOMPropertyStaticTableLines;
var
  baseObj: TLlDOMItem;
begin
  if (fLineOptions <> nil) then
  begin
    result := fLineOptions
  end
  else
  begin
    baseObj := GetObject('LineOptions');
    fLineOptions := TLlDOMPropertyStaticTableLines.Create(baseObj);
    baseObj.Free;
    result := fLineOptions;
  end;
end;

function TLlDOMSubItemStaticTable.GetLines: TLlDOMTableLinesStaticTable;
var
  baseObj: TLlDOMItem;
begin
  if (fLines <> nil) then
  begin
    result := fLines
  end
  else
  begin
    baseObj := GetObject('Lines');
    fLines := TLlDOMTableLinesStaticTable.Create(baseObj);
    baseObj.Free;
    result := fLines;
  end;
end;

{ TLlDOMPropertyFixedSize }

function TLlDOMPropertyFixedSize.GetEnabled: TString;
begin
  result := GetProperty('Enabled');
end;

function TLlDOMPropertyFixedSize.GetFillGap: TString;
begin
  result := GetProperty('FillGap');
end;

procedure TLlDOMPropertyFixedSize.SetEnabled(const value: TString);
begin
  SetProperty('Enabled', value);
end;

procedure TLlDOMPropertyFixedSize.SetFillGap(const value: TString);
begin
  SetProperty('FillGap', value);
end;

{ TLlDOMPropertyDataLinesOptions }

destructor TLlDOMPropertyDataLinesOptions.Destroy;
begin
  fZebraPattern.Free;
  fKeepTogether.Free;
  inherited;
end;

function TLlDOMPropertyDataLinesOptions.GetForceSumCalculation: TString;
begin
  result := GetProperty('ForceSumCalculation');
end;

function TLlDOMPropertyDataLinesOptions.GetKeepTogether
  : TLlDOMPropertyKeepTogether;
var
  baseObj: TLlDOMItem;
begin
  if (fKeepTogether <> nil) then
  begin
    result := fKeepTogether
  end
  else
  begin
    baseObj := GetObject('KeepTogether');
    fKeepTogether := TLlDOMPropertyKeepTogether.Create(baseObj);
    baseObj.Free;
    result := fKeepTogether;
  end;
end;
function TLlDOMPropertyDataLinesOptions.GetLineOtpionDataZebraPattern
  : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if (fZebraPattern <> nil) then
  begin
    result := fZebraPattern
  end
  else
  begin
    baseObj := GetObject('ZebraPattern');
    fZebraPattern := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fZebraPattern;
  end;
end;

function TLlDOMPropertyDataLinesOptions.GetSuppress: TString;
begin
  result := GetProperty('Suppress');
end;

procedure TLlDOMPropertyDataLinesOptions.SetForceSumCalculation
  (const value: TString);
begin
  SetProperty('ForceSumCalculation', value);
end;

procedure TLlDOMPropertyDataLinesOptions.SetSuppress(const value: TString);
begin
  SetProperty('Suppress', value);
end;

function  TLlDOMPropertyDataLinesOptions.GetKeepTogetherDataLine;
begin
  result := GetProperty('KeepTogether.DataLine');
end;

procedure TLlDOMPropertyDataLinesOptions.SetKeepTogetherDataLine(const value: TString);
begin
  SetProperty('KeepTogether.DataLine', value);
end;
{ TLlDOMPropertyDataLinesOptionsStaticTable }

function TLlDOMPropertyDataLinesOptionsStaticTable.GetKeepTogether: TString;
begin
  result := GetProperty('KeepTogether');
end;

procedure TLlDOMPropertyDataLinesOptionsStaticTable.SetKeepTogether
  (const value: TString);
begin
  SetProperty('KeepTogether', value);
end;

{ TLlDOMPropertyTableLines }

destructor TLlDOMPropertyTableLines.Destroy;
begin
  fData.Free;
  fFooter.Free;
  fGroupHeader.Free;
  fGroupFooter.Free;
  inherited;
end;

function TLlDOMPropertyTableLines.GetLineOptionFooter
  : TLlDOMPropertyFooterLinesOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fFooter <> nil) then
  begin
    result := fFooter
  end
  else
  begin
    baseObj := GetObject('Footer');
    fFooter := TLlDOMPropertyFooterLinesOptions.Create(baseObj);
    baseObj.Free;
    result := fFooter;
  end;
end;

function TLlDOMPropertyTableLines.GetLineOptionGroupFooter
  : TLlDOMPropertyGroupFooterLinesOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fGroupFooter <> nil) then
  begin
    result := fGroupFooter
  end
  else
  begin
    baseObj := GetObject('GroupFooter');
    fGroupFooter := TLlDOMPropertyGroupFooterLinesOptions.Create(baseObj);
    baseObj.Free;
    result := fGroupFooter;
  end;
end;

function TLlDOMPropertyTableLines.GetLineOptionGroupHeader
  : TLlDOMPropertyGroupHeaderLinesOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fGroupHeader <> nil) then
  begin
    result := fGroupHeader
  end
  else
  begin
    baseObj := GetObject('GroupHeader');
    fGroupHeader := TLlDOMPropertyGroupHeaderLinesOptions.Create(baseObj);
    baseObj.Free;
    result := fGroupHeader;
  end;
end;

function TLlDOMPropertyTableLines.GetLineOptionData
  : TLlDOMPropertyDataLinesOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fData <> nil) then
  begin
    result := fData
  end
  else
  begin
    baseObj := GetObject('Data');
    fData := TLlDOMPropertyDataLinesOptions.Create(baseObj);
    baseObj.Free;
    result := fData;
  end;
end;

{ TLlDOMPropertyStaticTableLines }

function TLlDOMPropertyStaticTableLines.GetLineOptionData;
var
  baseObj: TLlDOMItem;
begin
  if (fData <> nil) then
  begin
    result := fData
  end
  else
  begin
    baseObj := GetObject('Data');
    fData := TLlDOMPropertyDataLinesOptionsStaticTable.Create(baseObj);
    baseObj.Free;
    result := fData;
  end;
end;

destructor TLlDOMPropertyStaticTableLines.Destroy;
begin

  fData.Free;
  inherited;

end;

function TLlDOMPropertyKeepTogether.GetDataLineDefinitions: TString;
begin
   result := GetProperty('DataLineDefinitions');
end;

function TLlDOMPropertyKeepTogether.GetIndexedGroups: TString;
begin
 result := GetProperty('IndexedGroups');
end;

procedure TLlDOMPropertyKeepTogether.SetDataLineDefinitions(const value: TString);
begin
  SetProperty('DataLineDefinitions', value);
end;

procedure TLlDOMPropertyKeepTogether.SetIndexedGroups(const value: TString);
begin
  SetProperty('IndexedGroups', value);
end;

{ TLineOptionFooter }
destructor TLlDOMPropertyFooterLinesOptions.Destroy;
begin
  fKeepTogether.Free;
  inherited;
end;

function TLlDOMPropertyFooterLinesOptions.GetKeepTogether
  : TLlDOMPropertyKeepTogether;
var
  baseObj: TLlDOMItem;
begin
  if (fKeepTogether <> nil) then
  begin
    result := fKeepTogether
  end
  else
  begin
    baseObj := GetObject('KeepTogether');
    fKeepTogether := TLlDOMPropertyKeepTogether.Create(baseObj);
    baseObj.Free;
    result := fKeepTogether;
  end;
end;

{ TLineOptionGroupFooter }

function TLlDOMPropertyGroupFooterLinesOptions.GetAlsoOnEmptyGroup: TString;
begin
  result := GetProperty('AlsoOnEmptyGroup');
end;

procedure TLlDOMPropertyGroupFooterLinesOptions.SetAlsoOnEmptyGroup
  (const value: TString);
begin
  SetProperty('AlsoOnEmptyGroup', value);
end;

function TLlDOMPropertyGroupFooterLinesOptions.GetKeepTogether: TString;
begin
  result := GetProperty('KeepTogether');
end;

procedure TLlDOMPropertyGroupFooterLinesOptions.SetKeepTogether
  (const value: TString);
begin
  SetProperty('KeepTogether', value);
end;

{ TLineOptionGroupHeader }

function TLlDOMPropertyGroupHeaderLinesOptions.GetConcatNextDataLine: TString;
begin
  result := GetProperty('ConcatNextDataLine');
end;

procedure TLlDOMPropertyGroupHeaderLinesOptions.SetConcatNextDataLine
  (const value: TString);
begin
  SetProperty('ConcatNextDataLine', value);
end;

function TLlDOMPropertyGroupHeaderLinesOptions.GetKeepTogether: TString;
begin
  result := GetProperty('KeepTogether');
end;

procedure TLlDOMPropertyGroupHeaderLinesOptions.SetKeepTogether
  (const value: TString);
begin
  SetProperty('KeepTogether', value);
end;

{ TLlDOMTableLineListData }

procedure TLlDOMTableLineDataList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableLineData;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMTableLineData.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineDataList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineDataList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMProjectTemplate.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMProjectTemplate.GetDescription: TString;
begin
  result := GetProperty('Description');
end;

function TLlDOMProjectTemplate.GetFileName: TString;
begin
  result := GetProperty('FileName');
end;

function TLlDOMProjectTemplate.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMProjectTemplate.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMProjectTemplate.SetDescription(const value: TString);
begin
  SetProperty('Description', value);
end;

procedure TLlDOMProjectTemplate.SetFileName(const value: TString);
begin
  SetProperty('FileName', value);
end;

procedure TLlDOMProjectTemplate.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

{ TLlDOMTableLines }

destructor TLlDOMTableLines.Destroy;
begin
  fData.Free;
  fFooter.Free;
  fHeader.Free;
  fGroupFooter.Free;
  fGroupHeader.Free;
  inherited;
end;

function TLlDOMTableLines.GetData: TLlDOMTableLineDataList;
begin
  if fData = nil then
  begin
    fData := TLlDOMTableLineDataList.Create(GetObject('Data'));
  end;
  result := fData;
end;

function TLlDOMTableLines.GetFooter: TLlDOMTableLineFooterList;
begin
  if fFooter = nil then
  begin
    fFooter := TLlDOMTableLineFooterList.Create(GetObject('Footer'));
  end;
  result := fFooter;
end;

function TLlDOMTableLines.GetGroupFooter: TLlDOMTableLineGroupFooterList;
begin
  if fGroupFooter = nil then
  begin
    fGroupFooter := TLlDOMTableLineGroupFooterList.Create
      (GetObject('GroupFooter'));
  end;
  result := fGroupFooter;
end;

function TLlDOMTableLines.GetGroupHeader: TLlDOMTableLineGroupHeaderList;
begin
  if fGroupHeader = nil then
  begin
    fGroupHeader := TLlDOMTableLineGroupHeaderList.Create
      (GetObject('GroupHeader'));
  end;
  result := fGroupHeader;
end;

function TLlDOMTableLines.GetHeader: TLlDOMTableLineHeaderList;
begin
  if fHeader = nil then
  begin
    fHeader := TLlDOMTableLineHeaderList.Create(GetObject('Header'));
  end;
  result := fHeader;
end;

{ TLlDOMTableLinesStaticTable }

destructor TLlDOMTableLinesStaticTable.Destroy;
begin

  fDataLineList.Free;
  inherited;

end;

function TLlDOMTableLinesStaticTable.GetData: TLlDOMTableLineDataList;
begin
  if (fDataLineList = nil) then
  begin
    fDataLineList := TLlDOMTableLineDataList.Create(GetObject('Data'));
  end;
  result := fDataLineList;
end;

{ TLlDOMObjectBaseTableLine }

constructor TLlDOMTableLineBase.Create(list: TLlDOMTableLineBaseList;
  objType: TString; index: integer);
var
  newDataLine: TLlDOMItem;
begin
  newDataLine := list.NewItem(index, objType);
  fDomHandle := newDataLine.fDomHandle;
  list.Add(self);
  newDataLine.Free;
end;

destructor TLlDOMTableLineBase.Destroy;
begin
  fDefaultFont.Free;
  fReservedSpace.Free;
  fFields.Free;
  fBookmark.Free;
  fAnchor.Free;
  inherited;
end;

function TLlDOMTableLineBase.GetAnchor: TLlDOMPropertyAnchor;
var
  baseObj: TLlDOMItem;
begin
  if (fAnchor <> nil) then
  begin
    result := fAnchor
  end
  else
  begin
    baseObj := GetObject('Anchor');
    fAnchor := TLlDOMPropertyAnchor.Create(baseObj);
    baseObj.Free;
    result := fAnchor;
  end;
end;

function TLlDOMTableLineBase.GetBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if (fBookmark <> nil) then
  begin
    result := fBookmark
  end
  else
  begin
    baseObj := GetObject('Bookmark');
    fBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fBookmark;
  end;
end;

function TLlDOMTableLineBase.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMTableLineBase.GetDefaultFont: TLlDOMPropertyDefaultFont;
var
  baseObj: TLlDOMItem;
begin
  if (fDefaultFont <> nil) then
  begin
    result := fDefaultFont
  end
  else
  begin
    baseObj := GetObject('DefaultFont');
    fDefaultFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fDefaultFont;
  end;
end;

function TLlDOMTableLineBase.GetDisplayInDesigner: TString;
begin
  result := GetProperty('DisplayInDesigner');
end;

function TLlDOMTableLineBase.GetFields: TLlDOMTableLineFieldList;
begin
  if fFields = nil then
  begin
    fFields := TLlDOMTableLineFieldList.Create(GetObject('Fields'));
  end;
  result := fFields;
end;

function TLlDOMTableLineBase.GetName: TString;
begin
  result := GetProperty('Name');
end;

function TLlDOMTableLineBase.GetReservedSpace: TLlDOMPropertyReservedSpace;
var
  baseObj: TLlDOMItem;
begin
  if (fReservedSpace <> nil) then
  begin
    result := fReservedSpace
  end
  else
  begin
    baseObj := GetObject('ReservedSpace');
    fReservedSpace := TLlDOMPropertyReservedSpace.Create(baseObj);
    baseObj.Free;
    result := fReservedSpace;
  end;
end;

procedure TLlDOMTableLineBase.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMTableLineBase.SetDisplayInDesigner(const value: TString);
begin
  SetProperty('DisplayInDesigner', value);
end;

procedure TLlDOMTableLineBase.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

{ TReservedSpace }

procedure TLlDOMPropertyReservedSpace.Define(nLeft, nTop, nRight,
  nBottom: integer);
begin
  Left := IntToStr(nLeft);
  Top := IntToStr(nTop);
  Right := IntToStr(nRight);
  Bottom := IntToStr(nBottom);
end;

function TLlDOMPropertyReservedSpace.GetBottom: TString;
begin
  result := GetProperty('Bottom');
end;

function TLlDOMPropertyReservedSpace.GetLeft: TString;
begin
  result := GetProperty('Left');
end;

function TLlDOMPropertyReservedSpace.GetRight: TString;
begin
  result := GetProperty('Right');
end;

function TLlDOMPropertyReservedSpace.GetTop: TString;
begin
  result := GetProperty('Top');
end;

procedure TLlDOMPropertyReservedSpace.SetBottom(const value: TString);
begin
  SetProperty('Bottom', value);
end;

procedure TLlDOMPropertyReservedSpace.SetLeft(const value: TString);
begin
  SetProperty('Left', value);
end;

procedure TLlDOMPropertyReservedSpace.SetRight(const value: TString);
begin
  SetProperty('Right', value);
end;

procedure TLlDOMPropertyReservedSpace.SetTop(const value: TString);
begin
  SetProperty('Top', value);
end;

{ TLlDOMTableLineFieldList }
function TLlDOMTableLineFieldList.GetItems(index: integer)
  : TLlDOMTableField;
begin
  result := TLlDOMTableField(inherited Items[index]);
end;

procedure TLlDOMTableLineFieldList.SetItems(index: integer;
  const value: TLlDOMTableField);
begin
  inherited Items[index] := value;
end;

function TLlDOMTableLineFieldList.Add(domObj: TLlDOMTableField): integer;
begin
  result := inherited Add(domObj);
end;

procedure TLlDOMTableLineFieldList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableField;
  i: integer;
  ObjectType: TString;
  ObjectTypeLLX: TString;
begin
  newDomObj := nil;
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    ObjectType := baseObj.GetProperty('ObjectType');

    if (ObjectType = 'Text') then
    begin
      newDomObj := TLlDOMTableFieldText.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'RTFText') then
    begin
      newDomObj := TLlDOMTableFieldRTF.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Drawing') then
    begin
      newDomObj := TLlDOMTableFieldDrawing.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'Barcode') then
    begin
      newDomObj := TLlDOMTableFieldBarcode.Create(baseObj);
      baseObj.Free;
    end;

    if (ObjectType = 'LLX') then
    begin

      ObjectTypeLLX := baseObj.GetProperty('ObjectTypeLLX');

      if (ObjectTypeLLX = 'LlHTMLObject') then
      begin
        newDomObj := TLlDOMTableFieldHTML.Create(baseObj);
        baseObj.Free;
      end;

      if (ObjectTypeLLX = 'LLChart') then
      begin
        newDomObj := TLlDOMTableFieldChart.Create(baseObj);
        baseObj.Free;
      end;

      if (ObjectTypeLLX = 'LLGauge') then
      begin
        newDomObj := TLlDOMTableFieldGauge(baseObj);
        baseObj.Free;
      end;

      if (ObjectTypeLLX = 'LLPDF') then
      begin
        newDomObj := TLlDOMTableFieldPDF(baseObj);
        baseObj.Free;
      end;

      if (ObjectTypeLLX = 'LLDataGraphic') then
      begin
        newDomObj := TLlDOMTableFieldDataGraphic(baseObj);
        baseObj.Free;
      end;

      if (ObjectTypeLLX = 'LLCheckbox') then
      begin
        newDomObj := TLlDOMTableFieldCheckbox(baseObj);
        baseObj.Free;
      end;

    end;

    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineFieldList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineFieldList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMTableLineFieldList.NewItem(index: integer; ObjectType: TString)
  : TLlDOMItem;
var
  newDomObj: TLlDOMTableField;
begin
  newDomObj := TLlDOMTableField.Create(fDOMObj.CreateSubObject(index,
    ObjectType));
  result := newDomObj;
end;

{ TLlDOMObjectTableField }

constructor TLlDOMTableFieldText.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'Text', list.Count);
end;

destructor TLlDOMTableFieldText.Destroy;
begin
  fAlignmentHorizontal.Free;
  fFont.Free;
  fOutputFormatter.Free;
  fWrapping.Free;
  inherited;
end;

function TLlDOMTableFieldText.GetAdjusted: TString;
begin
  result := GetProperty('Adjusted');
end;

function TLlDOMTableFieldText.GetAlignmentHorizontal
  : TLlDOMPropertyAlignmentHorizontal;
var
  baseObj: TLlDOMItem;
begin
  if (fAlignmentHorizontal <> nil) then
  begin
    result := fAlignmentHorizontal
  end
  else
  begin
    baseObj := GetObject('AlignmentHorizontal');
    fAlignmentHorizontal := TLlDOMPropertyAlignmentHorizontal.Create(baseObj);
    baseObj.Free;
    result := fAlignmentHorizontal;
  end;
end;

function TLlDOMTableFieldText.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMTableFieldText.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMTableFieldText.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMTableFieldText.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldText.GetFixedHeight: TString;
begin
  result := GetProperty('FixedHeight');
end;

function TLlDOMTableFieldText.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMTableFieldText.GetLineSpacing: TString;
begin
  result := GetProperty('LineSpacing');
end;

function TLlDOMTableFieldText.GetOptimizeSpaces: TString;
begin
  result := GetProperty('OptimizeSpaces');
end;

function TLlDOMTableFieldText.GetOutputFormatterBase
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
    fOutputFormatter := result;
  end;
end;

function TLlDOMTableFieldText.GetPlainTextFormat: TString;
begin
  result := GetProperty('PlainTextFormat');
end;

function TLlDOMTableFieldText.GetWrapping: TLlDOMPropertyWrapping;
var
  baseObj: TLlDOMItem;
begin
  if (fWrapping <> nil) then
  begin
    result := fWrapping
  end
  else
  begin
    baseObj := GetObject('Wrapping');
    fWrapping := TLlDOMPropertyWrapping.Create(baseObj);
    baseObj.Free;
    result := fWrapping;
  end;
end;

procedure TLlDOMTableFieldText.SetAdjusted(const value: TString);
begin
  SetProperty('Adjusted', value);
end;

procedure TLlDOMTableFieldText.SetAlignmentVertical(const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMTableFieldText.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMTableFieldText.SetDirection(const value: TString);
begin
  SetProperty('Direction', value);
end;

procedure TLlDOMTableFieldText.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldText.SetFixedHeight(const value: TString);
begin
  SetProperty('FixedHeight', value);
end;

procedure TLlDOMTableFieldText.SetLineSpacing(const value: TString);
begin
  SetProperty('LineSpacing', value);
end;

procedure TLlDOMTableFieldText.SetOptimizeSpaces(const value: TString);
begin
  SetProperty('OptimizeSpaces', value);
end;

procedure TLlDOMTableFieldText.SetPlainTextFormat(const value: TString);
begin
  SetProperty('PlainTextFormat', value);
end;

{ TAlignmentHorizontal }
function TLlDOMPropertyAlignmentHorizontal.GetAlignmentType: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMPropertyAlignmentHorizontal.GetDecimalPosition: TString;
begin
  result := GetProperty('DecimalPosition');
end;

procedure TLlDOMPropertyAlignmentHorizontal.SetAlignmentType
  (const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMPropertyAlignmentHorizontal.SetDecimalPosition
  (const value: TString);
begin
  SetProperty('DecimalPosition', value);
end;

{ TLlDOMTableLineFooterList }

procedure TLlDOMTableLineFooterList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableLineFooter;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMTableLineFooter.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineFooterList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineFooterList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

{ TLlDOMTableLineHederList }

procedure TLlDOMTableLineHeaderList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableLineHeader;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMTableLineHeader.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineHeaderList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineHeaderList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

{ TLlDOMTableLineGroupFooterList }

procedure TLlDOMTableLineGroupFooterList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableLineGroupFooter;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMTableLineGroupFooter.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineGroupFooterList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineGroupFooterList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

{ TLlDOMTableLineGroupHeaderList }

procedure TLlDOMTableLineGroupHeaderList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMTableLineGroupHeader;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMTableLineGroupHeader.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMTableLineGroupHeaderList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTableLineGroupHeaderList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

{ TLlDOMObjectFooterTableLine }

constructor TLlDOMTableLineFooter.Create(list: TLlDOMTableLineFooterList);
begin
  inherited Create(list, 'Lines', list.Count);
end;

function TLlDOMTableLineFooter.GetIndexedGroups: TString;
begin
  result:= GetProperty('IndexedGroups');
end;

procedure TLlDOMTableLineFooter.SetIndexedGroups(const value: TString);
begin
  SetProperty('IndexedGroups', value);
end;
{ TLlDOMObjectHeaderTableLine }

constructor TLlDOMTableLineHeader.Create(list: TLlDOMTableLineHeaderList);
begin
  inherited Create(list, 'Lines', list.Count);
end;

{ TLlDOMObjectGroupHeaderTableLine }

constructor TLlDOMTableLineGroupHeader.Create
  (list: TLlDOMTableLineGroupHeaderList);
begin
  inherited Create(list, 'Lines', list.Count);
end;

destructor TLlDOMTableLineGroupHeader.Destroy;
begin
  fBreakBefore.Free;
  inherited;
end;

{ TLlDOMObjectGroupFooterTableLine }

constructor TLlDOMTableLineGroupFooter.Create
  (list: TLlDOMTableLineGroupFooterList);
begin
  inherited Create(list, 'Lines', list.Count);
end;

{ TLlDOMObjectCrosstab }

constructor TLlDOMObjectCrosstab.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Crosstab', list.Count);
end;

constructor TLlDOMObjectCrosstab.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Crosstab', index);
end;

destructor TLlDOMObjectCrosstab.Destroy;
begin
  fFrame.Free;
  fDefinition.Free;
  inherited;
end;

function TLlDOMObjectCrosstab.GetDefintion: TLlDOMPropertyCrosstabDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyCrosstabDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMObjectCrosstab.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectCrosstab.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectCrosstab.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

{ TLlDOMPropertyCrosstabDefinition }

destructor TLlDOMPropertyCrosstabDefinition.Destroy;
begin
  fBookmark.Free;
  fFilling.Free;
  fDefaultFrame.Free;
  fDefaultFont.Free;
  fRowWrapping.Free;
  fColumnWrapping.Free;
  fColumns.Free;
  fRows.Free;
  fCells.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabDefinition.GetBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if (fBookmark <> nil) then
  begin
    result := fBookmark
  end
  else
  begin
    baseObj := GetObject('Bookmark');
    fBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fBookmark;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetCells: TLlDOMCrosstabCellsList;
begin
  if fCells = nil then
  begin
    fCells := TLlDOMCrosstabCellsList.Create(GetObject('Cells'));
  end;
  result := fCells;
end;

function TLlDOMPropertyCrosstabDefinition.GetColumns
  : TLlDOMPropertyCrosstabDimension;
var
  baseObj: TLlDOMItem;
begin
  if fColumns <> nil then
  begin
    result := fColumns
  end
  else
  begin
    baseObj := GetObject('Columns');
    fColumns := TLlDOMPropertyCrosstabDimension.Create(baseObj);
    baseObj.Free;
    result := fColumns;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetColumnWrapping
  : TLlDOMPropertyCrosstabColumnWrapping;
var
  baseObj: TLlDOMItem;
begin
  if fColumnWrapping <> nil then
  begin
    result := fColumnWrapping
  end
  else
  begin
    baseObj := GetObject('ColumnWrapping');
    fColumnWrapping := TLlDOMPropertyCrosstabColumnWrapping.Create(baseObj);
    baseObj.Free;
    result := fColumnWrapping;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetFilling: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

function TLlDOMPropertyCrosstabDefinition.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fDefaultFont <> nil then
  begin
    result := fDefaultFont
  end
  else
  begin
    baseObj := GetObject('DefaultFont');
    fDefaultFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fDefaultFont;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fDefaultFrame <> nil then
  begin
    result := fDefaultFrame
  end
  else
  begin
    baseObj := GetObject('DefaultFrame');
    fDefaultFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fDefaultFrame;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetLinkURL: TString;
begin
  result := GetProperty('LinkURL');
end;

function TLlDOMPropertyCrosstabDefinition.GetMinHeight: TString;
begin
  result := GetProperty('MinHeight');
end;

function TLlDOMPropertyCrosstabDefinition.GetRows
  : TLlDOMPropertyCrosstabDimension;
var
  baseObj: TLlDOMItem;
begin
  if fRows <> nil then
  begin
    result := fRows
  end
  else
  begin
    baseObj := GetObject('Rows');
    fRows := TLlDOMPropertyCrosstabDimension.Create(baseObj);
    baseObj.Free;
    result := fRows;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetRowWrapping
  : TLlDOMPropertyCrosstabRowWrapping;
var
  baseObj: TLlDOMItem;
begin
  if fRowWrapping <> nil then
  begin
    result := fRowWrapping
  end
  else
  begin
    baseObj := GetObject('RowWrapping');
    fRowWrapping := TLlDOMPropertyCrosstabRowWrapping.Create(baseObj);
    baseObj.Free;
    result := fRowWrapping;
  end;
end;

function TLlDOMPropertyCrosstabDefinition.GetWrapPercentage: TString;
begin
  result := GetProperty('WrapPercentage');
end;

procedure TLlDOMPropertyCrosstabDefinition.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

function TLlDOMPropertyCrosstabDefinition.GetHarmonicLineHeights: TString;
begin
  result := GetProperty('HarmonicLineHeights');
end;

procedure TLlDOMPropertyCrosstabDefinition.SetHarmonicLineHeights(const value: TString);
begin
  SetProperty('HarmonicLineHeights', value);
end;

function TLlDOMPropertyCrosstabDefinition.GetSubCellCount: TString;
begin
  result := GetProperty('SubCellCount');
end;

procedure TLlDOMPropertyCrosstabDefinition.SetSubCellCount(const value: TString);
begin
  SetProperty('SubCellCount', value);
end;

procedure TLlDOMPropertyCrosstabDefinition.SetLinkURL(const value: TString);
begin
  SetProperty('LinkURL', value);
end;

procedure TLlDOMPropertyCrosstabDefinition.SetMinHeight(const value: TString);
begin
  SetProperty('MinHeight', value);
end;

procedure TLlDOMPropertyCrosstabDefinition.SetWrapPercentage
  (const value: TString);
begin
  SetProperty('WrapPercentage', value);
end;

{ TLlDOMPropertyCrosstabWrapping }

destructor TLlDOMPropertyCrosstabWrapping.Destroy;
begin
  fPageBreakPreferences.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabWrapping.GetPageBreakPreferences
  : TLlDOMPropertyCrosstabPageBreakPreferences;
var
  baseObj: TLlDOMItem;
begin
  if fPageBreakPreferences <> nil then
  begin
    result := fPageBreakPreferences
  end
  else
  begin
    baseObj := GetObject('PageBreakPreferences');
    fPageBreakPreferences := TLlDOMPropertyCrosstabPageBreakPreferences.
      Create(baseObj);
    baseObj.Free;
    result := fPageBreakPreferences;
  end;
end;

function TLlDOMPropertyCrosstabWrapping.GetRepeatLabels: TString;
begin
  result := GetProperty('RepeatLabels');
end;

procedure TLlDOMPropertyCrosstabWrapping.SetRepeatLabels(const value: TString);
begin
  SetProperty('RepeatLabels', value);
end;

{ TLlDomPropertyCrosstabShadowPages }

function TLlDOMPropertyCrosstabShadowPages.GetDistanceTop: TString;
begin
  result := GetProperty('DistanceTop');
end;

procedure TLlDOMPropertyCrosstabShadowPages.SetDistanceTop
  (const value: TString);
begin
  SetProperty('DistanceTop', value);
end;

{ TLlDOMPropertyCrosstabWrapPreferences }

function TLlDOMPropertyCrosstabPageBreakPreferences.GetForce: TString;
begin
  result := GetProperty('Force');
end;

function TLlDOMPropertyCrosstabPageBreakPreferences.GetLevel: TString;
begin
  result := GetProperty('Level');
end;

procedure TLlDOMPropertyCrosstabPageBreakPreferences.SetForce
  (const value: TString);
begin
  SetProperty('Force', value);
end;

procedure TLlDOMPropertyCrosstabPageBreakPreferences.SetLevel
  (const value: TString);
begin
  SetProperty('Level', value);
end;

{ TLlDOMPropertyCrosstabColumnWrapping }

destructor TLlDOMPropertyCrosstabColumnWrapping.Destroy;
begin
  fShadowPages.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabColumnWrapping.GetShadowPages
  : TLlDOMPropertyCrosstabShadowPages;
var
  baseObj: TLlDOMItem;
begin
  if fShadowPages <> nil then
  begin
    result := fShadowPages
  end
  else
  begin
    baseObj := GetObject('ShadowPages');
    fShadowPages := TLlDOMPropertyCrosstabShadowPages.Create(baseObj);
    baseObj.Free;
    result := fShadowPages;
  end;
end;

{ TLlDOMPropertyCrosstabDimensionCellBase }

destructor TLlDOMPropertyCrosstabDimensionCellBase.Destroy;
begin
  fAlignmentHorizontal.Free;
  fFilling.Free;
  fFont.Free;
  fFrame.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetAlignmentHorizontal
  : TLlDOMPropertyAlignmentHorizontal;
var
  baseObj: TLlDOMItem;
begin
  if fAlignmentHorizontal <> nil then
  begin
    result := fAlignmentHorizontal
  end
  else
  begin
    baseObj := GetObject('AlignmentHorizontal');
    fAlignmentHorizontal := TLlDOMPropertyAlignmentHorizontal.Create(baseObj);
    baseObj.Free;
    result := fAlignmentHorizontal;
  end;
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetFilling
  : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetLinkURL: TString;
begin
  result := GetProperty('LinkURL');
end;

function TLlDOMPropertyCrosstabDimensionCellBase.GetOutputFormatterBase
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
end;

procedure TLlDOMPropertyCrosstabDimensionCellBase.SetAlignmentVertical
  (const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMPropertyCrosstabDimensionCellBase.SetDirection
  (const value: TString);
begin
  SetProperty('Direction', value);
end;

procedure TLlDOMPropertyCrosstabDimensionCellBase.SetFormula
  (const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyCrosstabDimensionCellBase.SetLinkURL
  (const value: TString);
begin
  SetProperty('LinkURL', value);
end;


constructor TLlDOMPropertyConditionalFormatterItem.Create(list: TLlDOMConditionalFormatterItemList);
var
  newConditionalFormatterItem: TLlDOMItem;
begin
  newConditionalFormatterItem := list.NewItem(list.Count);
  inherited Create(newConditionalFormatterItem.fDomHandle);
  list.Add(self);
  newConditionalFormatterItem.Free;

end;

destructor  TLlDOMPropertyConditionalFormatterItem.Destroy;
begin
  fModifiers.Free;
  inherited;
end;

function TLlDOMPropertyConditionalFormatterItem.GetModifiers: TLlDOMPropertyConditionalFormatterModifiers;
var
  baseObj: TLlDOMItem;
begin
  if (fModifiers <> nil) then
  begin
    result := fModifiers
  end
  else
  begin
    baseObj := GetObject('Modifiers');
    fModifiers := TLlDOMPropertyConditionalFormatterModifiers.Create(baseObj);
    baseObj.Free;
    result := fModifiers;
  end;
end;

function TLlDOMPropertyConditionalFormatterItem.GetStopIteration: TString;
begin
  result:= GetProperty('StopIteration');
end;

procedure TLlDOMPropertyConditionalFormatterItem.SetStopIteration(const value: TString);
begin
  SetProperty('StopIteration', value);
end;

function TLlDOMPropertyConditionalFormatterItem.GetCondition: TString;
begin
  result:= GetProperty('Condition');
end;

procedure TLlDOMPropertyConditionalFormatterItem.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

function TLlDOMPropertyConditionalFormatterModifiers.GetOutputFormatter : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;

end;

destructor TLlDOMPropertyConditionalFormatterModifiers.Destroy;
begin
  fFrame.Free;
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyConditionalFormatterModifiers.GetFrame: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;


function TLlDOMPropertyConditionalFormatterModifiers.GetFont: TLlDOMPropertyDefaultFontExt;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFontExt.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;

end;

function TLlDOMPropertyConditionalFormatterModifiers.GetColor: TString;
begin
  result:= GetProperty('Color');
end;

procedure TLlDOMPropertyConditionalFormatterModifiers.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;
{ TLlDOMCrosstabCellRowList }

function TLlDOMCrosstabCellBaseList.Add
  (domObj: TLlDOMPropertyCrosstabDimensionCellBase): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMCrosstabCellBaseList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

function TLlDOMCrosstabCellBaseList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyCrosstabDimensionSumLabelCell;
begin
  newDomObj := TLlDOMPropertyCrosstabDimensionSumLabelCell.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Cell');
  Add(newDomObj);
  result := newDomObj;
end;

{ TLlDOMPropertyCrosstabDimension }

destructor TLlDOMPropertyCrosstabDimension.Destroy;
begin
  fSumLabel.Free;
  fGroupLabel.Free;
  fGroupingList.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabDimension.GetGroupingList
  : TLlDOMCrosstabFormulaList;
begin
  if fGroupingList = nil then
  begin
    fGroupingList := TLlDOMCrosstabFormulaList.Create(GetObject('Groupings'));
  end;
  result := fGroupingList;
end;

function TLlDOMPropertyCrosstabDimension.GetGroupLabelList
  : TLlDOMCrosstabCellGroupLabelList;
begin
  if fGroupLabel = nil then
  begin
    fGroupLabel := TLlDOMCrosstabCellGroupLabelList.Create
      (GetObject('GroupLabel'));
  end;
  result := fGroupLabel;
end;

function TLlDOMPropertyCrosstabDimension.GetSumLabelList
  : TLlDOMCrosstabCellSumLabelList;
begin
  if fSumLabel = nil then
  begin
    fSumLabel := TLlDOMCrosstabCellSumLabelList.Create(GetObject('SumLabel'));
  end;
  result := fSumLabel;
end;

{ TLlDOMPropertyCrosstabSummary }

function TLlDOMPropertyCrosstabSummary.GetBeforeEntries: TString;
begin
  result := GetProperty('BeforeEntries');
end;

function TLlDOMPropertyCrosstabSummary.GetShow: TString;
begin
  result := GetProperty('Show');
end;

procedure TLlDOMPropertyCrosstabSummary.SetBeforeEntries(const value: TString);
begin
  SetProperty('BeforeEntries', value);
end;

procedure TLlDOMPropertyCrosstabSummary.SetShow(const value: TString);
begin
  SetProperty('Show', value);
end;

{ TLlDOMPropertyCrosstabDimensionSumLabelCell }

destructor TLlDOMPropertyCrosstabDimensionSumLabelCell.Destroy;
begin
  fSummary.Free;
  inherited;
end;

function TLlDOMPropertyCrosstabDimensionSumLabelCell.GetSummary
  : TLlDOMPropertyCrosstabSummary;
var
  baseObj: TLlDOMItem;
begin
  if fSummary <> nil then
  begin
    result := fSummary
  end
  else
  begin
    baseObj := GetObject('Summary');
    fSummary := TLlDOMPropertyCrosstabSummary.Create(baseObj);
    baseObj.Free;
    result := fSummary;
  end;
end;

{ TLlDOMPropertyCrosstabDimensionGroupLabelCell }
destructor TLlDOMPropertyCrosstabDimensionGroupLabelCell.Destroy;
begin
  fMaxEntryCount.Free;
  fSortOrderAscending.Free;
  fAutoFill.Free;
  fDrawing.free;
  inherited;
end;

function  TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetMaxEntryCount:
TLlDOMPropertyMaxEntryCount;
  begin
  if fMaxEntryCount = nil then
  begin
    fMaxEntryCount := TLlDOMPropertyMaxEntryCount.Create
      (GetObject('MaxEntryCount'));
  end;
  result := fMaxEntryCount;
end;

function TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetShowSpanLabel
  : TString;
begin
  result := GetProperty('ShowSpanLabel');
end;

function TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetExpandable : TString;
begin
  result := GetProperty('Expandable');
end;

procedure TLlDOMPropertyCrosstabDimensionGroupLabelCell.SetExpandable(const value: TString);
begin
  SetProperty('Expandable', value);
end;
function  TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetSortOrderAscending:
TLlDOMPropertySortOrderAscending;
  begin
  if fSortOrderAscending = nil then
  begin
    fSortOrderAscending := TLlDOMPropertySortOrderAscending.Create
      (GetObject('SortOrderAscending'));
  end;
  result := fSortOrderAscending;
end;

function TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetDrawing: TLlDOMPropertyDrawing;
  begin
  if fDrawing = nil then
  begin
    fDrawing := TLlDOMPropertyDrawing.Create
      (GetObject('Drawing'));
  end;
  result := fDrawing;
end;

function  TLlDOMPropertyCrosstabDimensionGroupLabelCell.GetAutoFill:
TLlDOMPropertyAutoFill;
  begin
  if fAutoFill = nil then
  begin
    fAutoFill := TLlDOMPropertyAutoFill.Create
      (GetObject('AutoFill'));
  end;
  result := fAutoFill;
end;

procedure TLlDOMPropertyCrosstabDimensionGroupLabelCell.SetShowSpanLabel
  (const value: TString);
begin
  SetProperty('ShowSpanLabel', value);
end;


{TLlDOMPropertyAutoFill}
function TLlDOMPropertyAutoFill.GetContent: TString;
begin
  result := GetProperty('Content');
end;

function TLlDOMPropertyAutoFill.GetStartValue: TString;
begin
    result := GetProperty('StartValue');
end;

function TLlDOMPropertyAutoFill.GetIncrement: TString;
begin
    result := GetProperty('Increment');
end;

function TLlDOMPropertyAutoFill.GetLabel: TString;
begin
  result := GetProperty('Label');
end;

function TLlDOMPropertyAutoFill.GetEndValue: TString;
begin
    result := GetProperty('EndValue');
end;

procedure TLlDOMPropertyAutoFill.SetContent(const value: TString);
begin
  SetProperty('Content', value);
end;

procedure TLlDOMPropertyAutoFill.SetStartValue(const value: TString);
begin
    SetProperty('StartValue', value);
end;

procedure TLlDOMPropertyAutoFill.SetIncrement(const value: TString);
begin
    SetProperty('Increment', value);
end;

procedure TLlDOMPropertyAutoFill.SetLabel(const value: TString);
begin
    SetProperty('Label', value);
end;

procedure TLlDOMPropertyAutoFill.SetEndValue(const value: TString);
begin
    SetProperty('tEndValue', value);
end;
{/TLlDOMPropertyAutoFill}
{TLlDOMPropertyMaxEntryCount}

function TLlDomPropertyMaxEntryCount.GetMaxEntries: TString;
begin
  result := GetProperty('MaxEntries');
end;

procedure TLlDomPropertyMaxEntryCount.SetMaxEntries(const value: TString);
begin
  SetProperty('MaxEntries', value);
end;

function TLlDomPropertyMaxEntryCount.GetLabel: TString;
begin
  result := GetProperty('Label');
end;

procedure TLlDomPropertyMaxEntryCount.SetLabel(const value: TString);
begin
  SetProperty('Label', value);
end;

function TLlDomPropertyMaxEntryCount.GetWithOthers: TString;
begin
  result := GetProperty('WithOthers');
end;

procedure TLlDomPropertyMaxEntryCount.SetWithOthers(const value: TString);
begin
  SetProperty('WithOthers', value);
end;

{/TLlDOMPropertyMaxEntryCount}

{TLlDOMPropertySortOrderAscending}
function TLlDOMPropertySortOrderAscending.GetSortOrder: TString;
begin
  result := GetProperty('SortOrder');
end;

procedure TLlDOMPropertySortOrderAscending.SetSortOrder(const value: TString);
begin
  SetProperty('SortOrder', value);
end;

function TLlDOMPropertySortOrderAscending.GetSubCellIndex: TString;
begin
  result := GetProperty('SubCellIndex');
end;

procedure TLlDOMPropertySortOrderAscending.SetSubCellIndex(const value: TString);
begin
  SetProperty('SubCellIndex', value);
end;
{/TLlDOMPropertySortOrderAscending}

{ TLlDOMCrosstabCellSumLabelList }
procedure TLlDOMCrosstabCellSumLabelList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyCrosstabDimensionSumLabelCell;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyCrosstabDimensionSumLabelCell.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

destructor TLlDOMCrosstabCellSumLabelList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMCrosstabCellSumLabelList.GetItems(index: integer)
  : TLlDOMPropertyCrosstabDimensionSumLabelCell;
begin
  result := TLlDOMPropertyCrosstabDimensionSumLabelCell(inherited Items[index]);
end;

procedure TLlDOMCrosstabCellSumLabelList.SetItems(index: integer;
  const value: TLlDOMPropertyCrosstabDimensionSumLabelCell);
begin
  inherited Items[index] := value;
end;

{ TLlDOMCrosstabCellGroupLabelList }


procedure TLlDOMCrosstabCellGroupLabelList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyCrosstabDimensionGroupLabelCell;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyCrosstabDimensionGroupLabelCell.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

destructor TLlDOMCrosstabCellGroupLabelList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMCrosstabCellGroupLabelList.GetItems(index: integer)
  : TLlDOMPropertyCrosstabDimensionGroupLabelCell;
begin
  result := TLlDOMPropertyCrosstabDimensionGroupLabelCell
    (inherited Items[index]);
end;

procedure TLlDOMCrosstabCellGroupLabelList.SetItems(index: integer;
  const value: TLlDOMPropertyCrosstabDimensionGroupLabelCell);
begin
  inherited Items[index] := value;
end;

{ TLlDOMPropertyCrosstabCells }

function TLlDOMPropertyCrosstabCells.GetMinHeight: TString;
begin
  result := GetProperty('MinHeight');
end;

function TLlDOMPropertyCrosstabCells.GetMinWidth: TString;
begin
  result := GetProperty('MinWidth');
end;

function TLlDOMPropertyCrosstabCells.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyCrosstabCells.SetMinHeight(const value: TString);
begin
  SetProperty('MinHeight', value);
end;
//
function TLlDOMPropertyCrosstabCells.GetSubCellLabel: TString;
begin
  result := GetProperty('SubCellLabel');
end;

procedure TLlDOMPropertyCrosstabCells.SetSubCellLabel(const value: TString);
begin
  SetProperty('SubCellLabel', value);
end;
//
procedure TLlDOMPropertyCrosstabCells.SetMinWidth(const value: TString);
begin
  SetProperty('MinWidth', value);
end;

procedure TLlDOMPropertyCrosstabCells.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMCrosstabFormulaList }
function TLlDOMCrosstabFormulaList.GetItems(index: integer)
  : TLlDOMPropertyCrosstabDimensionGrouping;
begin
  result := TLlDOMPropertyCrosstabDimensionGrouping(inherited Items[index]);
end;

procedure TLlDOMCrosstabFormulaList.SetItems(index: integer;
  const value: TLlDOMPropertyCrosstabDimensionGrouping);
begin
  inherited Items[index] := value;
end;

procedure TLlDOMCrosstabFormulaList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyCrosstabDimensionGrouping;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyCrosstabDimensionGrouping.Create(baseObj);
    baseObj.Free;
    inherited Add(newDomObj);
  end;
end;

function TLlDOMCrosstabFormulaList.Add(value: TString): integer;
var
  newDomObj: TLlDOMPropertyCrosstabDimensionGrouping;
begin
  newDomObj := TLlDOMPropertyCrosstabDimensionGrouping.Create(self);
  newDomObj.Grouping := value;
  result := inherited Add(newDomObj);
end;

constructor TLlDOMCrosstabFormulaList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMCrosstabFormulaList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMCrosstabFormulaList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyCrosstabDimensionGrouping;
begin
  newDomObj := TLlDOMPropertyCrosstabDimensionGrouping.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(0, 'Grouping');
  inherited Add(newDomObj);
  result := newDomObj;
end;

{ TLlDOMPropertyCrosstabDimensionGrouping }

constructor TLlDOMPropertyCrosstabDimensionGrouping.Create
  (list: TLlDOMCrosstabFormulaList);
var
  newGrouping: TLlDOMItem;
begin
  newGrouping := list.NewItem(list.Count);
  inherited Create(newGrouping.fDomHandle);
end;

function TLlDOMPropertyCrosstabDimensionGrouping.GetGrouping: TString;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyCrosstabDimensionGrouping.SetGrouping
  (const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMCrosstabCellsList }

function TLlDOMCrosstabCellsList.GetAll: TLlDOMPropertyCrosstabCells;
var
  resCell: TLlDOMPropertyCrosstabCells;
begin
  resCell := TLlDOMPropertyCrosstabCells.Create
    (self.fDOMObj.GetObject('Cell[,]'));
  if not Assigned(fCrosstabCells) then
    fCrosstabCells := TList.Create();
  fCrosstabCells.Add(resCell);
  result := resCell;
end;

function TLlDOMCrosstabCellsList.GetSubCell(cellLevel, rowLevel, subCellLevel: integer)
: TLlDOMPropertyCrosstabCells;
var
  resCell: TLlDOMPropertyCrosstabCells;
begin

  resCell := TLlDOMPropertyCrosstabCells.Create
    (self.fDOMObj.GetObject(Format('Cell[%d, %d, %d]', [cellLevel, rowLevel, subCellLevel])));
  if not Assigned(fCrosstabCells) then
    fCrosstabCells := TList.Create();
  fCrosstabCells.Add(resCell);
  result := resCell;
end;

function TLlDOMCrosstabCellsList.GetItems(index: integer)
  : TLlDOMPropertyCrosstabCells;
begin
  result := TLlDOMPropertyCrosstabCells(inherited Items[index]);
end;

procedure TLlDOMCrosstabCellsList.SetItems(index: integer;
  const value: TLlDOMPropertyCrosstabCells);
begin
  inherited Items[index] := value;
end;

function TLlDOMCrosstabCellsList.Add
  (domObj: TLlDOMPropertyCrosstabCells): integer;
begin
  result := inherited Add(domObj);
end;

procedure TLlDOMCrosstabCellsList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyCrosstabCells;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyCrosstabCells.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMCrosstabCellsList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMCrosstabCellsList.Destroy;
var
  i: integer;
begin
  if Assigned(fCrosstabCells) then
    fCrosstabCells.Free;

  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMCrosstabCellsList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyCrosstabCells;
begin
  newDomObj := TLlDOMPropertyCrosstabCells.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Cells');
  Add(newDomObj);
  result := newDomObj;
end;

{ TLlDOMSubItemCore }

constructor TLlDOMSubItemCore.Create(list: TLlDOMSubItemCoreList;
  objType: TString; index: integer);
var
  newDomObj: TLlDOMItem;
begin
  inherited Create();
  newDomObj := list.NewItem(index, objType);
  fDomHandle := newDomObj.fDomHandle;
  list.Add(self);
  newDomObj.Free;
end;

destructor TLlDOMSubItemCore.Destroy;
begin
  fBreakBefore.Free;
  inherited;
end;


function TLlDOMSubItemCore.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

procedure TLlDOMSubItemCore.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

function TLlDOMSubItemCore.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

procedure TLlDOMSubItemCore.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

function TLlDOMSubItemCore.GetDistanceTop: TString;
begin
  result := GetProperty('DistanceTop');
end;

procedure TLlDOMSubItemCore.SetDistanceTop(const value: TString);
begin
  SetProperty('DistanceTop', value);
end;

function TLlDOMSubItemCore.GetDistanceBottom: TString;
begin
  result := GetProperty('DistanceBottom');
end;

procedure TLlDOMSubItemCore.SetDistanceBottom(const value: TString);
begin
  SetProperty('DistanceBottom', value);
end;

function TLlDOMSubItemCore.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMSubItemCore.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

function TLlDOMSubItemCore.GetObjectType: TString;
begin
  result := GetProperty('ObjectType');
end;

function TLlDOMSubItemCore.GetBreakBefore: TLlDOMPropertyPageBreakOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fBreakBefore <> nil) then
  begin
    result := fBreakBefore;
  end
  else
  begin
    baseObj := GetObject('PageBreakOptions');
    fBreakBefore := TLlDOMPropertyPageBreakOptions.Create(baseObj);
    baseObj.Free;
    result := fBreakBefore;
  end;
end;

{/SubItemCore}
{SubItemBase}
constructor TLlDOMSubItemBase.Create(list: TLlDOMSubItemCoreList; objType: string; index: Integer);
begin
  inherited Create(list, objType, index);
end;

destructor TLlDOMSubItemBase.Destroy;
begin
  fColumns.Free;
  fAnimation.Free;
  fXhtmlAnimation.Free;
end;

function TLlDOMSubItemBase.GetColumns: TLlDOMPropertyColumns;
var
  baseObj: TLlDOMItem;
begin
  if (fColumns <> nil) then
  begin
    result := fColumns;
  end
  else
  begin
    baseObj := GetObject('Columns');
    fColumns := TLlDOMPropertyColumns.Create(baseObj);
    baseObj.Free;
    result := fColumns;
  end;
end;

function TLlDOMSubItemBase.GetAnimation: TLlDOMPropertyAnimation;
var
  baseObj: TLlDOMItem;
begin
  if (fAnimation <> nil) then
  begin
    result := fAnimation
  end
  else
  begin
    baseObj := GetObject('Animation');
    fAnimation := TLlDOMPropertyAnimation.Create(baseObj);
    baseObj.Free;
    result := fAnimation;
  end;
end;

function TLlDOMSubItemBase.GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
var
  baseObj: TLlDOMItem;
begin

  if (fXhtmlAnimation <> nil) then
  begin
    result := fXhtmlAnimation
  end
  else
  begin
    baseObj := GetObject('HTMLAnimation');
    fXhtmlAnimation := TLlDOMPropertyXhtmlAnimation.Create(baseObj);
    baseObj.Free;
    result := fXhtmlAnimation;
  end;
end;

function TLlDOMSubItemBase.GetTableID: Tstring;
begin
  result := GetProperty('TableID');
end;

procedure TLLDOMSubItemBase.SetTableId(const value: TString);
begin
	SetProperty('TableID', value);
end;

{/TLlDOMSubItemBase}

{TLlDOMSubItemSubReport}

constructor TLlDOMSubItemSubReport.Create(list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'SubReport', list.Count);
end;

function TLlDOMSubItemSubReport.GetScaling: TString;
begin
	result := GetProperty('Subreport.Scaling');
end;
function TLlDOMSubItemSubReport.GetLinked: TString;
begin
	result := GetProperty('Subreport.Linked');
end;
function TLlDOMSubItemSubReport.GetLinkUUID: TString;
begin
	result := GetProperty('Subreport.LinkUUID');
end;
function TLlDOMSubItemSubReport.GetRelation: TString;
begin
	result := GetProperty('Subreport.Relation');
end;
function TLlDOMSubItemSubReport.GetSource: TString;
begin
	result := GetProperty('Subreport.Source');
end;

procedure TLlDOMSubItemSubReport.SetScaling(const value: TString);
begin
	SetProperty('Subreport.Scaling', value);
end;

procedure TLlDOMSubItemSubReport.SetLinked(const value: TString);
begin
	SetProperty('Subreport.Linked', value);
end;

procedure TLlDOMSubItemSubReport.SetLinkUUID(const value: TString);
begin
	SetProperty('Subreport.LinkUUID', value);
end;

procedure TLlDOMSubItemSubReport.SetRelation(const value: TString);
begin
	SetProperty('Subreport.Relation', value);
end;

procedure TLlDOMSubItemSubReport.SetSource(const value: TString);
begin
	SetProperty('Subreport.Source', value);
end;

function TLlDOMSubItemSubReport.GetExpandable: TString;
begin
  result := GetProperty('Expandable');
end;

procedure TLlDOMSubItemSubReport.SetExpandable(const value: TString);
begin
  SetProperty('Expandable', value);
end;


{/TLlDOMSubItemSubReport}

{TLlDOMPropertyPageBreakOptions}

function TLlDOMPropertyPageBreakOptions.GetBreak: TString;
begin
  result := GetProperty('BreakBefore');
end;

function TLlDOMPropertyPageBreakOptions.GetResetPageNumberOption: TString;
begin
  result := GetProperty('ResetPageNumberOption');
end;

procedure TLlDOMPropertyPageBreakOptions.SetBreak(const value: TString);
begin
  SetProperty('BreakBefore', value);
end;

procedure TLlDOMPropertyPageBreakOptions.SetResetPageNumberOption(const value: TString);
begin
  SetProperty('ResetPageNumberOption', value);
end;
{ TLlDOMTableItemCrosstab }

constructor TLlDOMSubItemCrosstab.Create(list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'Crosstab', list.Count);
end;

destructor TLlDOMSubItemCrosstab.Destroy;
begin
  fDefinition.Free;
  fBorderDistance.Free;
  inherited;
end;

function TLlDOMSubItemCrosstab.GetBorderDistance: TLlDOMPropertyReservedSpace;
var
  baseObj: TLlDOMItem;
begin
  if fBorderDistance <> nil then
  begin
    result := fBorderDistance
  end
  else
  begin
    baseObj := GetObject('BorderDistance');
    fBorderDistance := TLlDOMPropertyReservedSpace.Create(baseObj);
    baseObj.Free;
    result := fBorderDistance;
  end;
end;

function TLlDOMSubItemCrosstab.GetDefinition: TLlDOMPropertyCrosstabDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyCrosstabDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMSubItemCrosstab.GetSourceTablePath: TString;
begin
  result := GetProperty('SourceTablePath');
end;

procedure TLlDOMSubItemCrosstab.SetSourceTablePath(const value: TString);
begin
  SetProperty('SourceTablePath', value);
  if (pos(';', value) > 0) then
  begin
    SetProperty('TableID', copy(value, 0, pos(';', value) - 1));
  end
  else
  begin
    SetProperty('TableID', value);
  end;
end;

{TLDOMPropertyTableFieldQRBarcodeSource}
function TLDOMPropertyTableFieldQRBarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLDOMPropertyTableFieldQRBarcodeSource.GetPreferredFormat: TString;
begin
  result:= GetProperty('PreferredFormat');
end;


procedure TLDOMPropertyTableFieldQRBarcodeSource.SetPreferredFormat(const value: TString);
begin
  SetProperty('PreferredFormat', value);
end;


procedure TLDOMPropertyTableFieldQRBarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

function TLDOMPropertyTableFieldQRBarcodeSource.GetCorrectionLevel: TString;
begin
  result:= GetProperty('CorrectionLevel');
end;

function TLDOMPropertyTableFieldQRBarcodeSource.GetFNC1Mode: TString;
begin
  result:= GetProperty('FNC1Mode');
end;

procedure TLDOMPropertyTableFieldQRBarcodeSource.SetCorrectionLevel(const value: TString);
begin
  SetProperty('CorrectionLevel', value);
end;

procedure TLDOMPropertyTableFieldQRBarcodeSource.SetFNC1Mode(const value: TString);
begin
  SetProperty('FNC1Mode', value);
end;

{/TLDOMPropertyTableFieldQRBarcodeSource}

{TLlDOMPropertyTableFieldAztecBarcodeSource}

function TLlDOMPropertyTableFieldAztecBarcodeSource.GetDataLayer: TString;
begin
  result:= GetProperty('DataLayer');
end;

procedure TLlDOMPropertyTableFieldAztecBarcodeSource.SetDataLayer(const value: TString);
begin
  SetProperty('DataLayer', value);
end;
{/TLlDOMPropertyTableFieldAztecBarcodeSource}

{TLlDOMPropertyTableFieldDatamatrixBarcodeSource}
function TLlDOMPropertyTableFieldDatamatrixBarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLlDOMPropertyTableFieldDatamatrixBarcodeSource.GetPreferredFormat: TString;
begin
  result:= GetProperty('PreferredFormat');
end;

procedure TLlDOMPropertyTableFieldDatamatrixBarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

procedure TLlDOMPropertyTableFieldDatamatrixBarcodeSource.SetPreferredFormat(const value: TString);
begin
  SetProperty('PreferredFormat', value);
end;
{/TLlDOMPropertyTableFieldDatamatrixBarcodeSource}

{TLlDOMPropertyTableFieldMaxicodeBarcodeSource}
function TLlDOMPropertyTableFieldMaxicodeBarcodeSource.GetPolygonFillRate: TString;
begin
  GetProperty('PolygonFillRate');
end;

function TLlDOMPropertyTableFieldMaxicodeBarcodeSource.GetMaxicodeMode: TString;
begin
  GetProperty('MaxicodeMode');
end;

procedure TLlDOMPropertyTableFieldMaxicodeBarcodeSource.SetPolygonFillRate(const value: TString);
begin
    SetProperty('PolygonFillRate', value);
end;

procedure TLlDOMPropertyTableFieldMaxicodeBarcodeSource.SetMaxicodeMode(const value: TString);
begin
    SetProperty('MaxicodeMode', value);
end;

{/TLlDOMPropertyTableFieldMaxicodeBarcodeSource}

{TLlDOMPropertyTableFieldMicroPDF417BarcodeSource}

function TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.GetEncoding: TString;
begin
  result:= GetProperty('Encoding');
end;

function TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.GetFormat: TString;
begin
  result:= GetProperty('Format');
end;

function TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.GetYToXRatio: TString;
begin
  result:= GetProperty('YToXRatio');
end;

procedure TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.SetEncoding(const value: TString);
begin
  SetProperty('Encoding', value);
end;

procedure TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.SetFormat(const value: TString);
begin
  SetProperty('Fortmat', value);
end;

procedure TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.SetYToXRatio(const value: TString);
begin
  SetProperty('YToXRatio', value);
end;

{/TLlDOMPropertyTableFieldMicroPDF417BarcodeSource}

{TLlDOMPropertyTableFieldPDF417BarcodeSource}

function TLlDOMPropertyTableFieldPDF417BarcodeSource.GetColumnCount: TString;
begin
  result:= GetProperty('ColumnCount');
end;

function TLlDOMPropertyTableFieldPDF417BarcodeSource.GetErrorCorrection: TString;
begin
  result:= GetProperty('ErrorCorrection');
end;

function TLlDOMPropertyTableFieldPDF417BarcodeSource.GetTruncated: TString;
begin
  result:= GetProperty('Truncated');
end;

function TLlDOMPropertyTableFieldPDF417BarcodeSource.GetYToXRatio: TString;
begin
  result:= GetProperty('YToXRatio');
end;

procedure TLlDOMPropertyTableFieldPDF417BarcodeSource.SetColumnCount(const value: TString);
begin
  SetProperty('ColumnCount', value);
end;
procedure TLlDOMPropertyTableFieldPDF417BarcodeSource.SetErrorCorrection(const value: TString);
begin
  SetProperty('ErrorCorrection', value);
end;
procedure TLlDOMPropertyTableFieldPDF417BarcodeSource.SetTruncated(const value: TString);
begin
  SetProperty('Truncated', value);
end;
procedure TLlDOMPropertyTableFieldPDF417BarcodeSource.SetYToXRatio(const value: TString);
begin
  SetProperty('YToXRatio', value);
end;
{/TLlDOMPropertyTableFieldPDF417BarcodeSource}

{TLlDOMPropertyTableFieldPremiumAddressBarcodeSource}
function TLlDOMPropertyTableFieldPremiumAddressBarcodeSource.GetPremiumAdress
  : TLlDOMPropertyPremiumAdress;
var
  baseObj: TLlDOMItem;
begin
  if fPremiumAdress <> nil then
  begin
    result := fPremiumAdress
  end
  else
  begin
    baseObj := GetObject('PremiumAdress');
    fPremiumAdress := TLlDOMPropertyPremiumAdress.Create(baseObj);
    baseObj.Free;
    result := fPremiumAdress;
  end;
end;

destructor TLlDOMPropertyTableFieldPremiumAddressBarcodeSource.Destroy;
begin
  fPremiumAdress.Free;
  inherited;
end;

{/TLlDOMPropertyTableFieldPremiumAddressBarcodeSource}

constructor TLlDOMTableField.Create(list: TLlDOMTableLineFieldList;
  objType: TString; index: integer);
var
  newField: TLlDOMItem;
begin
  inherited Create();
  newField := list.NewItem(index, objType);
  fDomHandle := newField.fDomHandle;
  list.Add(self);
  newField.Free;
end;

constructor TLlDOMTableFieldBase.Create(list: TLlDOMTableLineFieldList;
  objType: TString; index: integer);
var
  newField: TLlDOMItem;
begin
  inherited Create();
  newField := list.NewItem(index, objType);
  fDomHandle := newField.fDomHandle;
  list.Add(self);
  newField.Free;
end;

destructor TLlDOMTableFieldBase.Destroy;
begin
  fAnimation.Free;
  fXhtmlAnimation.Free;
  inherited;
end;



constructor TLlDOMTableInputFieldBase.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'InputObject', list.Count);

end;

destructor TLlDOMTableInputFieldBase.Destroy;
begin
  fConditionalFormatters.Free;
  fFont.Free;
  fFilling.Free;

  inherited;
end;

function TLlDOMTableInputFieldBase.GetConditionalFormatterItems: TLlDOMConditionalFormatterItemList;
begin
  if fConditionalFormatters = nil then
  begin
    fConditionalFormatters := TLlDOMConditionalFormatterItemList.Create(GetObject('ConditionalFormatter'));
  end;
  result := fConditionalFormatters;

end;

function TLlDOMTableInputFieldBase.GetFont: TLlDOMPropertyDefaultFontExt;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFontExt.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMTableInputFieldBase.GetUneditable: TString;
begin
  result := GetProperty('Uneditable');
end;

function TLlDOMTableInputFieldBase.GetFilling: TLlDOMPropertyFillingWithBitmap;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFillingWithBitmap.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;

end;

function TLlDOMTableInputFieldBase.GetFixedHeight: TString;
begin
  result := GetProperty('FixedHeight');
end;

function TLlDOMTableInputFieldBase.GetToolTip: TString;
begin
  result := GetProperty('ToolTip');
end;

procedure TLlDOMTableInputFieldBase.SetFixedHeight(const value: TString);
begin
   SetProperty('FixedHeight', value);
end;

procedure TLlDOMTableInputFieldBase.SetUneditable(const Value: TString);
begin
   SetProperty('Uneditable', value);
end;

procedure TLlDOMTableInputFieldBase.SetToolTip(const value: TString);
begin
   SetProperty('ToolTip', value);
end;

constructor TLlDOMTableInputFieldEdit.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list);
  SetProperty('InputObjectType', '0');
end;

destructor TLlDOMTableInputFieldEdit.Destroy;
begin
  fVerification.Free;

  inherited;
end;



function TLlDOMTableInputFieldEdit.GetVerification: TLlDOMPropertyVerification;
var
  baseObj: TLlDOMItem;
begin
  if fVerification <> nil then
  begin
    result := fVerification
  end
  else
  begin
    baseObj := GetObject('Verification');
    fVerification := TLlDOMPropertyVerification.Create(baseObj);
    baseObj.Free;
    result := fVerification;
  end;
end;

function TLlDOMTableInputFieldEdit.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMTableInputFieldEdit.GetDefaultValueText: TString;
begin
  result := GetProperty('DefaultValueText');
end;

function TLlDOMTableInputFieldEdit.GetFieldName: TString;
begin
  result := GetProperty('FieldName');
end;

function TLlDOMTableInputFieldEdit.GetMultiline: TString;
begin
  result := GetProperty('Multiline');
end;

function TLlDOMTableInputFieldEdit.GetNeedInput: TString;
begin
  result := GetProperty('NeedInput');
end;

procedure TLlDOMTableInputFieldEdit.SetAlignment(const value: TString);
begin
   SetProperty('Alignment', value);
end;

procedure TLlDOMTableInputFieldEdit.SetDefaultValueText(const value: TString);
begin
   SetProperty('DefaultValueText', value);
end;

procedure TLlDOMTableInputFieldEdit.SetFieldName(const value: TString);
begin
   SetProperty('FieldName', value);
end;

procedure TLlDOMTableInputFieldEdit.SetMultiline(const value: TString);
begin
   SetProperty('Multiline', value);
end;

procedure TLlDOMTableInputFieldEdit.SetNeedInput(const value: TString);
begin
   SetProperty('NeedInput', value);
end;

constructor TLlDOMTableInputFieldCheckbox.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list);
  SetProperty('InputObjectType', '1');
end;

function TLlDOMTableInputFieldCheckbox.GetFieldName: TString;
begin
  result := GetProperty('FieldName');
end;

function TLlDOMTableInputFieldCheckbox.GetCheckboxType: TString;
begin
  result := GetProperty('CheckboxType');
end;

function TLlDOMTableInputFieldCheckbox.GetDefaultValueBool: TString;
begin
  result := GetProperty('DefaultValueBool');
end;

procedure TLlDOMTableInputFieldCheckbox.SetFieldName(const value: TString);
begin
  SetProperty('FieldName', value);
end;

procedure TLlDOMTableInputFieldCheckbox.SetCheckboxType(const value: TString);
begin
  SetProperty('CheckboxType', value);
end;

procedure TLlDOMTableInputFieldCheckbox.SetDefaultValueBool(const value: TString);
begin
  SetProperty('DefaultValueBool', value);
end;


constructor TLlDOMTableInputFieldComboBox.Create(list: TLlDOMTableLineFieldList);
begin
   inherited Create(list);
    SetProperty('InputObjectType', '2');
end;

destructor TLlDOMTableInputFieldComboBox.Destroy;
begin
  fVerification.Free;
  inherited;
end;

function TLlDOMTableInputFieldComboBox.GetAlignment: TString;
begin
  result:= GetProperty('Alignment');
end;

function TLlDOMTableInputFieldComboBox.GetEditable: TString;
begin
  result:= GetProperty('Editable');
end;

function TLlDOMTableInputFieldComboBox.GetChoices: TString;
begin
  result:= GetProperty('Choices');
end;

function TLlDOMTableInputFieldComboBox.GetFieldName: TString;
begin
  result:= GetProperty('FieldName');
end;

function TLlDOMTableInputFieldComboBox.GetNeedInput: TString;
begin
  result:= GetProperty('NeedInput');
end;

function TLlDOMTableInputFieldComboBox.GetVerification: TLlDOMPropertyVerification;
var
  baseObj: TLlDOMItem;
begin
  if fVerification <> nil then
  begin
    result := fVerification
  end
  else
  begin
    baseObj := GetObject('Verification');
    fVerification := TLlDOMPropertyVerification.Create(baseObj);
    baseObj.Free;
    result := fVerification;
  end;
end;

procedure TLlDOMTableInputFieldComboBox.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMTableInputFieldComboBox.SetEditable(const value: TString);
begin
  SetProperty('Editable', value);
end;

procedure TLlDOMTableInputFieldComboBox.SetChoices(const value: TString);
begin
  SetProperty('Choices', value);
end;

procedure TLlDOMTableInputFieldComboBox.SetFieldName(const value: TString);
begin
 SetProperty('FieldName', value);
end;

procedure TLlDOMTableInputFieldComboBox.SetNeedInput(const value: TString);
begin
  SetProperty('NeedInput', value);
end;

constructor TLlDOMTableInputFieldButton.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list);
  SetProperty('InputObjectType', '3');
end;

destructor TLlDOMTableInputFieldButton.Destroy;
begin
  fAction.Free;
  inherited;
end;

function TLlDOMTableInputFieldButton.GetAction: TLlDOMPropertyInputButtonActionBase;
var
  baseObj: TLlDOMItem;
begin
  if fAction <> nil then
    fAction.Free;

    baseObj := GetObject('Button');
  fAction := TLlDOMPropertyInputButtonActionBase.Create(baseObj);
    baseObj.Free;
  fAction:= TLlDOMHelper.SafeInputButtonActionCast(fAction);
    result := fAction;

end;

function TLlDOMTableInputFieldButton.GetText: TString;
begin
  result:= GetProperty('Text');
end;

procedure TLlDOMTableInputFieldButton.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;


destructor TLlDOMTableField.Destroy;
begin
  fFilling.Free;
  fFrame.Free;
  fSortOrders.Free;


  if Assigned(fDrillDownLinks) then
  begin
    fDrillDownLinks.Free;
    fDrillDownLinks := nil;
  end;

  inherited;
end;

function TLlDOMTableField.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMTableFieldBase.GetAnimation: TLlDOMPropertyAnimation;
var
  baseObj: TLlDOMItem;
begin

  if (fAnimation <> nil) then
    begin
      result := fAnimation
    end
  else
    begin
      baseObj := GetObject('Animation');
      fAnimation := TLlDOMPropertyAnimation.Create(baseObj);
      baseObj.Free;
      result := fAnimation;
    end;

end;

function TLlDOMTableFieldBase.GetXhtmlAnimation: TLlDOMPropertyXhtmlAnimation;
var
  baseObj: TLlDOMItem;
begin
  if (fXhtmlAnimation <> nil) then
  begin
    result := fXhtmlAnimation
  end
  else
  begin
    baseObj := GetObject('HTMLAnimation');
    fXhtmlAnimation := TLlDOMPropertyXhtmlAnimation.Create(baseObj);
    baseObj.Free;
    result := fXhtmlAnimation;
  end;
end;


function TLlDOMTableField.GetDrillDownLinks: TLlDOMDrillDownLinkList;
begin
  if fDrillDownLinks = nil then
  begin
    fDrillDownLinks := TLlDOMDrillDownLinkList.Create
      (GetObject('DrillDownLinks'));
  end;
  result := fDrillDownLinks;

end;

procedure TLlDOMTableField.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

function TLlDOMTableField.GetFilling: TLlDOMPropertyChartFilling;
var
  baseObj: TLlDOMItem;
begin
  if (fFilling <> nil) then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMTableFieldBase.GetSortOrders: TLlDOMPropertySortOrders;
var
  baseObj: TLlDOMItem;
begin
  if (fSortOrders <> nil) then
  begin
    result := fSortOrders
  end
  else
  begin
    baseObj := GetObject('Filling');
    fSortOrders := TLlDOMPropertySortOrders.Create(baseObj);
    baseObj.Free;
    result := fSortOrders;
  end;
end;

function TLlDOMTableField.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if (fFrame <> nil) then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMTableFieldBase.GetLinkURL: TString;
begin
  result := GetProperty('LinkURL');
end;

procedure TLlDOMTableFieldBase.SetLinkURL(const value: TString);
begin
  SetProperty('LinkURL', value);
end;

function TLlDOMTableField.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMTableField.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

function TLlDOMTableField.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

function TLlDOMTableField.GetWrapping: TLlDOMPropertyFieldWrapping;
var
  baseObj: TLlDOMItem;
begin
  if (fWrapping <> nil) then
  begin
    result := fWrapping
  end
  else
  begin
    baseObj := GetObject('Wrapping');
    fWrapping := TLlDOMPropertyFieldWrapping.Create(baseObj);
    baseObj.Free;
    result := fWrapping;
  end;
end;

procedure TLlDOMTableField.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

procedure TLlDOMTableField.SetObjectType(const value: TString);
begin
  SetProperty('ObjectType', value);
end;

procedure TLlDOMTableField.SetObjectTypeLLX(const value: TString);
begin
  SetProperty('ObjectTypeLLX', value);
end;

function TLlDOMTableField.GetObjectType: TString;
begin
  result := GetProperty('ObjectType');
end;

function TLlDOMTableField.GetObjectTypeLLX: TString;
begin
  result := GetProperty('ObjectTypeLLX');
end;

function TLlDOMPropertySortOrders.GetAscending: TString;
begin
  result := GetProperty('Ascending');
end;

function TLlDOMPropertySortOrders.GetDescending: TString;
begin
  result := GetProperty('Descending');
end;

procedure TLlDOMPropertySortOrders.SetAscending(const value: TString);
begin
  SetProperty('Ascending', value);
end;

procedure TLlDOMPropertySortOrders.SetDescending(const value: TString);
begin
  SetProperty('Descending', value);
end;

{ TLlDOMTableFieldPDF }
destructor TLlDOMTableFieldPDF.Destroy;
begin
  fDefinition.Destroy;
end;

constructor TLlDOMTableFieldPDF.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'PDF', list.Count);
end;

function TLlDOMTableFieldPDF.GetDefinition: TLlDOMPropertyPDFDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyPDFDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMTableFieldPDF.GetExportAsPicture;
begin
  result := GetProperty('ExportAsPicture');
end;

procedure TLlDOMTableFieldPDF.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

function TLlDOMTableFieldPDF.GetHeight;
begin
  result := GetProperty('Height');
end;

procedure TLlDOMTableFieldPDF.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

{ TLlDOMTableFieldGauge }
destructor TLlDOMTableFieldGauge.Destroy;
begin
  fDefinition.Destroy;
end;

constructor TLlDOMTableFieldGauge.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'Gauge', list.Count);
end;

function TLlDOMTableFieldGauge.GetDefinition: TLlDOMPropertyGaugeDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyGaugeDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMTableFieldGauge.GetExportAsPicture;
begin
  result := GetProperty('ExportAsPicture');
end;

procedure TLlDOMTableFieldGauge.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

function TLlDOMTableFieldGauge.GetHeight;
begin
  result := GetProperty('Height');
end;

procedure TLlDOMTableFieldGauge.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

{ TLlDOMTableFieldDrawing }

constructor TLlDOMTableFieldDrawing.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'Drawing', list.Count);
end;

function TLlDOMTableFieldDrawing.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMTableFieldDrawing.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMTableFieldDrawing.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMTableFieldDrawing.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

procedure TLlDOMTableFieldDrawing.SetAlignmentVertical(const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMTableFieldDrawing.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMTableFieldDrawing.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMTableFieldDrawing.SetIsotropic(const value: TString);
begin
  SetProperty('Isotropic', value);
end;

{ TLlDOMTableFieldRTF }

constructor TLlDOMTableFieldRTF.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'RTFText', list.Count);
end;

function TLlDOMTableFieldRTF.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMTableFieldRTF.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldRTF.GetFixedHeight: TString;
begin
  result := GetProperty('FixedHeight');
end;

procedure TLlDOMTableFieldRTF.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMTableFieldRTF.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldRTF.SetFixedHeight(const value: TString);
begin
  SetProperty('FixedHeight', value);
end;

{ TLlDOMTableFieldBarcode }


function TLlDOMTableFieldBarcode.GetBarcodeSource: TLlDOMPropertyTableFieldBarcodeSource;
var
  baseObj: TLlDOMItem;
begin
  if fSource <> nil then
  begin
    result := fSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fSource := TLlDOMPropertyTableFieldBarcodeSource.Create(baseObj);
    baseObj.Free;
	  fSource :=TLlDOMHelper.SafeTableFielBarcodeSourceCast(fSource, self);
    result := fSource;
  end;
end;

function TLlDOMTableFieldBarcode.GetBarcodeType: TString;
begin
  result:=  GetProperty('BarcodeType');
end;

procedure TLlDOMTableFieldBarcode.SetBarcodeType(const value: TString);
begin
  SetProperty('BarcodeType', value);
end;

constructor TLlDOMTableFieldBarcode.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'Barcode', list.Count);
end;

destructor TLlDOMTableFieldBarcode.Destroy;
begin
  fFont.Free;
  fSource.Free;
  inherited;
end;

function TLlDOMTableFieldBarcode.GetMatchDevicePixel: TLlDOMPropertyMatchDevicePixel;
var
  baseObj: TLlDOMItem;
begin
  if fMatchDevicePixel <> nil then
  begin
    result := fMatchDevicePixel
  end
  else
  begin
    baseObj := GetObject('MatchDevicePixel');
    fMatchDevicePixel := TLlDOMPropertyMatchDevicePixel.Create(baseObj);
    baseObj.Free;
    result := fMatchDevicePixel;
  end;
end;

function TLlDOMTableFieldBarcode.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMTableFieldBarcode.GetBarColor: TString;
begin
  result := GetProperty('BarColor');
end;

function TLlDOMTableFieldBarcode.GetBarRatio: TString;
begin
  result := GetProperty('BarRatio');
end;

function TLlDOMTableFieldBarcode.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMTableFieldBarcode.GetDirection: TString;
begin
  result := GetProperty('Direction');
end;

function TLlDOMTableFieldBarcode.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldBarcode.GetFixedBarOptions: TString;
begin
  result := GetProperty('FixedBarOptions');
end;

function TLlDOMTableFieldBarcode.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMTableFieldBarcode.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMTableFieldBarcode.GetWithText: TString;
begin
  result := GetProperty('WithText');
end;

procedure TLlDOMTableFieldBarcode.SetAlignmentVertical(const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMTableFieldBarcode.SetBarColor(const value: TString);
begin
  SetProperty('BarColor', value);
end;

procedure TLlDOMTableFieldBarcode.SetBarRatio(const value: TString);
begin
  SetProperty('BarRatio', value);
end;

procedure TLlDOMTableFieldBarcode.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMTableFieldBarcode.SetDirection(const value: TString);
begin
  SetProperty('Direction', value);
end;

procedure TLlDOMTableFieldBarcode.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldBarcode.SetFixedBarOptions(const value: TString);
begin
  SetProperty('FixedBarOptions', value);
end;

procedure TLlDOMTableFieldBarcode.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMTableFieldBarcode.SetWithText(const value: TString);
begin
  SetProperty('WithText', value);
end;

{ TLlDOMTableFieldHTML }

constructor TLlDOMTableFieldHTML.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'LLX:LlHTMLObject', list.Count);
end;

function TLlDOMTableFieldHTML.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMTableFieldHTML.GetContentType: TString;
begin
  result := GetProperty('ContentType');
end;

function TLlDOMTableFieldHTML.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldHTML.GetFitToObject: TString;
begin
  result := GetProperty('FitToObject');
end;

procedure TLlDOMTableFieldHTML.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMTableFieldHTML.SetContentType(const value: TString);
begin
  SetProperty('ContentType', value);
end;

procedure TLlDOMTableFieldHTML.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldHTML.SetFitToObject(const value: TString);
begin
  SetProperty('FitToObject', value);
end;

{ TLlDOMTableLineData }

constructor TLlDOMTableLineData.Create(list: TLlDOMTableLineDataList);
begin
  inherited Create(list, 'Lines', list.Count);
end;

destructor TLlDOMTableLineData.Destroy;
begin
  if Assigned(fDrillDownLinkList) then
  begin
    fDrillDownLinkList.Free;
    fDrillDownLinkList := nil;
  end;

  inherited;
end;
function TLlDOMTableLineData.GetIndexedGroups: TString;
begin
  result := GetProperty('IndexedGroups');
end;
procedure TLlDOMTableLineData.SetIndexedGroups(const value: Tstring);
begin
  SetProperty('IndexedGroups', value);
end;

function TLlDOMTableLineData.GetDrillDownLinks: TLlDOMDrillDownLinkList;
begin
  if fDrillDownLinkList = nil then
  begin
    fDrillDownLinkList := TLlDOMDrillDownLinkList.Create
      (GetObject('DrillDownLinks'));
  end;
  result := fDrillDownLinkList;
end;

{ TLlDOMTableLineBaseList }

function TLlDOMTableLineBaseList.Add(domObj: TLlDOMTableLineBase): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMTableLineBaseList.GetItems(index: integer): TLlDOMTableLineBase;
begin
  result := TLlDOMTableLineBase(inherited Items[index]);
end;

function TLlDOMTableLineBaseList.NewItem(index: integer; ObjectType: TString)
  : TLlDOMItem;
var
  newDomObj: TLlDOMTableLineBase;
begin
  newDomObj := TLlDOMTableLineBase.Create(fDOMObj.CreateSubObject(index,
    ObjectType));
  result := newDomObj;
end;

procedure TLlDOMTableLineBaseList.SetItems(index: integer;
  const value: TLlDOMTableLineBase);
begin
  inherited Items[index] := value;
end;

{ TLlDOMTextItemList }
constructor TLlDOMTextItemList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMTextItemList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMTextItemList.AddTextItem(domObj: TLlDOMPropertyTextItem)
  : integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMTextItemList.Add(domObj: TLlDOMPropertyTextItem): integer;
begin
  result := AddTextItem(domObj);
end;

function TLlDOMTextItemList.GetItems(index: integer): TLlDOMPropertyTextItem;
begin
  result := inherited Items[index];
end;

function TLlDOMTextItemList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyTextItem;
begin
  newDomObj := TLlDOMPropertyTextItem.Create(fDOMObj.CreateSubObject(index,
    'TextItem'));
  result := newDomObj;
end;

procedure TLlDOMTextItemList.SetItems(index: integer;
  const value: TLlDOMPropertyTextItem);
begin
  inherited Items[index] := value;
end;

{ TLlDOMSignalItemList }
constructor TLlDOMSignalItemList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMSignalItemList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMSignalItemList.AddSignalItem
  (domObj: TLlDOMPropertySignalItem): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMSignalItemList.Add(domObj: TLlDOMPropertySignalItem): integer;
begin
  result := AddSignalItem(domObj);
end;

function TLlDOMSignalItemList.GetItems(index: integer)
  : TLlDOMPropertySignalItem;
begin
  result := inherited Items[index];
end;

function TLlDOMSignalItemList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertySignalItem;
begin
  newDomObj := TLlDOMPropertySignalItem.Create(fDOMObj.CreateSubObject(index,
    'SignalItem'));
  result := newDomObj;
end;

procedure TLlDOMSignalItemList.SetItems(index: integer;
  const value: TLlDOMPropertySignalItem);
begin
  inherited Items[index] := value;
end;

{ TLlDOMObjectTemplate }

constructor TLlDOMObjectTemplate.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Template', list.Count);
end;

constructor TLlDOMObjectTemplate.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Template', index);
end;

destructor TLlDOMObjectTemplate.Destroy;
begin
  fFileinfo.Free;
  inherited;
end;

function TLlDOMObjectTemplate.GetColorFade: TString;
begin
  result := GetProperty('ColorFade');
end;

function TLlDOMObjectTemplate.GetFileinfo: TLlDOMPropertyFileInfo;
var
  baseObj: TLlDOMItem;
begin
  if fFileinfo <> nil then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

function TLlDOMObjectTemplate.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMObjectTemplate.GetShowOnPreview: TString;
begin
  result := GetProperty('ShowOnPreview');
end;

procedure TLlDOMObjectTemplate.SetColorFade(const value: TString);
begin
  SetProperty('ColorFade', value);
end;

procedure TLlDOMObjectTemplate.SetIsotropic(const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMObjectTemplate.SetShowOnPreview(const value: TString);
begin
  SetProperty('ShowOnPreview', value);
end;

{ TLlDOMPropertyLayoutLabel }

destructor TLlDOMPropertyLayoutLabel.Destroy;
begin
  fPages.Free;
  inherited;
end;

function TLlDOMPropertyLayoutLabel.GetPages: TLlDOMPropertyLayoutLabelPages;
var
  baseObj: TLlDOMItem;
begin
  if fPages <> nil then
  begin
    result := fPages
  end
  else
  begin
    baseObj := GetObject('Pages');
    fPages := TLlDOMPropertyLayoutLabelPages.Create(baseObj);
    baseObj.Free;
    result := fPages;
  end;
end;

{ TLlDOMPropertyLayoutCard }

destructor TLlDOMPropertyLayoutCard.Destroy;
begin
  fPages.Free;
  inherited;
end;

function TLlDOMPropertyLayoutCard.GetPages: TLlDOMPropertyLayoutCardPages;
var
  baseObj: TLlDOMItem;
begin
  if fPages <> nil then
  begin
    result := fPages
  end
  else
  begin
    baseObj := GetObject('Pages');
    fPages := TLlDOMPropertyLayoutCardPages.Create(baseObj);
    baseObj.Free;
    result := fPages;
  end;
end;

{ TLlDOMPropertyLayoutCardPages }

destructor TLlDOMPropertyLayoutCardPages.Destroy;
begin
  fFirst.Free;
  fFollowing.Free;
  inherited;
end;

function TLlDOMPropertyLayoutCardPages.GetFirst: TLlDOMPropertyLayoutPagesCard;
var
  baseObj: TLlDOMItem;
begin
  if (fFirst <> nil) then
  begin
    result := fFirst
  end
  else
  begin
    baseObj := GetObject('First');
    fFirst := TLlDOMPropertyLayoutPagesCard.Create(baseObj);
    baseObj.Free;
    result := fFirst;
  end;
end;

function TLlDOMPropertyLayoutCardPages.GetFollowing
  : TLlDOMPropertyLayoutPagesCard;
var
  baseObj: TLlDOMItem;
begin
  if (fFollowing <> nil) then
  begin
    result := fFollowing
  end
  else
  begin
    baseObj := GetObject('Following');
    fFollowing := TLlDOMPropertyLayoutPagesCard.Create(baseObj);
    baseObj.Free;
    result := fFollowing;
  end;
end;

{ TLlDOMPropertyOutputFormatterBase }

constructor TLlDOMPropertyOutputFormatterBase.Create(item: TLlDOMItem);
begin
  inherited Create(item);
end;

constructor TLlDOMPropertyOutputFormatterBase.Create(FormatterType: TString;
  item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create(item);
  self.FormatterType := FormatterType;
end;

function TLlDOMPropertyOutputFormatterBase.GetFormatterType: TString;
begin
  result := GetProperty('FormatterType');
end;

procedure TLlDOMPropertyOutputFormatterBase.SetFormatterType
  (const value: TString);
begin
  SetProperty('FormatterType', value);
end;

{ TLlDOMPropertyOutputFormatterDouble }

constructor TLlDOMPropertyOutputFormatterNone.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('', item);
end;

constructor TLlDOMPropertyOutputFormatterDouble.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('DOUBLE', item);
end;

function TLlDOMPropertyOutputFormatterDouble.GetCountOfDecimals: TString;
begin
  result := GetProperty(FormatterType + '.CountOfDecimals');
end;

function TLlDOMPropertyOutputFormatterDouble.
  GetDecimalSeparatorCharType: TString;
begin
  result := GetProperty(FormatterType + '.DecimalSeparatorCharType');
end;

function TLlDOMPropertyOutputFormatterDouble.GetEmptyStringIfZero: TString;
begin
  result := GetProperty(FormatterType + '.EmptyStringIfZero');
end;

function TLlDOMPropertyOutputFormatterDouble.
  GetForceZeroBeforeDecimalSeparator: TString;
begin
  result := GetProperty(FormatterType + '.ForceZeroBeforeDecimalSeparator');
end;

function TLlDOMPropertyOutputFormatterDouble.GetNegativeFormatType: TString;
begin
  result := GetProperty(FormatterType + '.NegativeFormatType');
end;

function TLlDOMPropertyOutputFormatterDouble.
  GetThousandsSeparatorCharType: TString;
begin
  result := GetProperty(FormatterType + '.ThousandsSeparatorCharType');
end;

function TLlDOMPropertyOutputFormatterDouble.GetExponentialFormat: TString;
begin
  result := GetProperty(FormatterType + '.ExponentialFormat');
end;

function TLlDOMPropertyOutputFormatterDouble.GetUnits: TString;
begin
  result := GetProperty(FormatterType + '.Units');
end;

function TLlDOMPropertyOutputFormatterDouble.GetRemoveTrailingZeroes: TString;
begin
  result := GetProperty(FormatterType + '.RemoveTrailingZeroes');
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetCountOfDecimals
  (const value: TString);
begin
  SetProperty(FormatterType + '.CountOfDecimals', value);
end;

function TLlDOMPropertyOutputFormatterDouble.GetForceSign: TString;
begin
  result := GetProperty(FormatterType + '.ForceSign');
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetForceSign
  (const value: TString);
begin
  SetProperty(FormatterType + '.ForceSign', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetDecimalSeparatorCharType
  (const value: TString);
begin
  SetProperty(FormatterType + '.DecimalSeparatorCharType', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetEmptyStringIfZero
  (const value: TString);
begin
  SetProperty(FormatterType + '.EmptyStringIfZero', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetForceZeroBeforeDecimalSeparator
  (const value: TString);
begin
  SetProperty(FormatterType + '.ForceZeroBeforeDecimalSeparator', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetNegativeFormatType
  (const value: TString);
begin
  SetProperty(FormatterType + '.NegativeFormatType', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetThousandsSeparatorCharType
  (const value: TString);
begin
  SetProperty(FormatterType + '.ThousandsSeparatorCharType', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetExponentialFormat
  (const value: TString);
begin
  SetProperty(FormatterType + '.ExponentialFormat', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetUnits(const value: TString);
begin
  SetProperty(FormatterType + '.Units', value);
end;

procedure TLlDOMPropertyOutputFormatterDouble.SetRemoveTrailingZeroes
  (const value: TString);
begin
  SetProperty(FormatterType + '.RemoveTrailingZeroes', value);
end;

{ TLlDOMPropertyOutputFormatterCurrency }

constructor TLlDOMPropertyOutputFormatterCurrency.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('CURRENCY', item);
end;

function TLlDOMPropertyOutputFormatterCurrency.GetCurrencySymbol: TString;
begin
  result := GetProperty(FormatterType + '.CurrencySymbol');
end;

function TLlDOMPropertyOutputFormatterCurrency.GetPositiveFormatType: TString;
begin
  result := GetProperty(FormatterType + '.PositiveFormatType');
end;

function TLlDOMPropertyOutputFormatterCurrency.GetExponentialFormat: TString;
begin
  result := GetProperty(FormatterType + '.ExponentialFormat');
end;

procedure TLlDOMPropertyOutputFormatterCurrency.SetCurrencySymbol
  (const value: TString);
begin
  SetProperty(FormatterType + '.CurrencySymbol', value);
end;

procedure TLlDOMPropertyOutputFormatterCurrency.SetPositiveFormatType
  (const value: TString);
begin
  SetProperty(FormatterType + '.PositiveFormatType', value);
end;

procedure TLlDOMPropertyOutputFormatterCurrency.SetExponentialFormat
  (const value: TString);
begin
  SetProperty(FormatterType + '.ExponentialFormat', value);
end;

{ TLlDOMHelper }

class function TLlDOMHelper.SafeChartEngineCast
  (input: TLlDOMPropertyChartEngineBase): TLlDOMPropertyChartEngineBase;
var
  SubTypeEnum: integer;
begin
  SubTypeEnum := StrToInt(input.SubTypeIndex);
  result := nil;
  if input.ChartType = '0' then // PIE/DONUT-CHART
  begin
    if input.DataMode = '0' then
    begin
      case SubTypeEnum of
        0:
          if input.Flat = 'True' then
          begin
            result := TLlDOMPropertyChartEnginePie2D.Create(input)
          end
          else
          begin
            result := TLlDOMPropertyChartEnginePie3D.Create(input);
          end;
        1:
          if input.Flat = 'True' then
          begin
            result := TLlDOMPropertyChartEngineDonut2D.Create(input)
          end
          else
          begin
            result := TLlDOMPropertyChartEngineDonut3D.Create(input);
          end;
      end;
    end;
  end;

  if input.ChartType = '1' then // BAR-CHART
  begin
    if input.DataMode = '0' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBar2D.Create(input)
      else
        result := TLlDOMPropertyChartEngineBar3D.Create(input);
    end;
    if input.DataMode = '1' then
    begin
      if input.Flat = 'False' then
        result := TLlDOMPropertyChartEngineBar3DMultiRow.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '2' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBar2DClustered.Create(input)
      else
        result := TLlDOMPropertyChartEngineBar3DClustered.Create(input);
    end;
    if input.DataMode = '3' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBar2DStacked.Create(input)
      else
        result := TLlDOMPropertyChartEngineBar3DStacked.Create(input);
    end;
    if input.DataMode = '4' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBar2DStackedRelative.Create(input)
      else
        result := TLlDOMPropertyChartEngineBar3DStackedRelative.Create(input);
    end;
  end;
  if input.ChartType = '2' then // LINE-CHART
  begin
    if input.DataMode = '0' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineLineSimple.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '1' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineLineMultiRow.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '3' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineLineStacked.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '4' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineLineStackedRelative.Create(input)
      else
        result := input;
    end;
  end;
  if input.ChartType = '3' then // AREA-CHART
  begin
    if input.DataMode = '0' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineAreaSimple.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '3' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineAreaStacked.Create(input)
      else
        result := input;
    end;
    if input.DataMode = '4' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineAreaStackedRelative.Create(input)
      else
        result := input;
    end;
  end;
  if input.ChartType = '4' then // BUBBLE-CHART
  begin
    if input.DataMode = '1' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBubbleSorted.Create(input)
      else
        result := input
    end;
    if input.DataMode = '5' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineBubbleScattered.Create(input)
      else
        result := input
    end;
  end;
  if input.ChartType = '5' then // funnel
  begin
    if input.SubTypeIndex = '0' then
    begin
      result := TLlDOMPropertyChartEngineFunnelVertical.Create(input)
    end
    else
      result := TLlDOMPropertyChartEngineFunnelHorizontal.Create(input)
  end;
  if input.ChartType = '6' then // Shapefile
  begin
    result := TLlDOMPropertyChartEngineShapeFile.Create(input)
  end;

  //radar

    if input.ChartType = '7' then
  begin
    if input.DataMode = '0' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineRadarSimple.Create(input)
      else
        result := input
    end;
    if input.DataMode = '1' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineRadarClustered.Create(input)
      else
        result := input
    end;
      if input.DataMode = '3' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineRadarStacked.Create(input)
      else
        result := input
    end;
      if input.DataMode = '4' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineRadarStackedRelative.Create(input)
      else
        result := input
    end;
  end;
  //finish radar
  //treemap
  if input.ChartType = '8' then
  begin
    if input.DataMode = '0' then
    begin
      if input.Flat = 'True' then
        result := TLlDOMPropertyChartEngineTreeMapSingle.Create(input)
      else
        result := input
    end;
    if input.ChartType = '1' then
      if input.Flat = 'True' then
        result :=  TLlDOMPropertyChartEngineTreeMapClustered.Create(input)
      else
        result := input
    end;
  if input.ChartType = '9' then // RScript
    begin
      result := TLlDOMPropertyChartEngineRscript.Create(input)
    end;

  if result <> input then
  begin
    input.Free;
    // input:=nil;
  end;
end;

class function TLlDOMHelper.SafeFormatterCast
  (input: TLlDOMPropertyOutputFormatterBase): TLlDOMPropertyOutputFormatterBase;
begin
  if input.FormatterType = 'CURRENCY' then
  begin
    result := TLlDOMPropertyOutputFormatterCurrency.Create(input);
  end
  else if input.FormatterType = 'DOUBLE' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else if input.FormatterType = 'DATE' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else if input.FormatterType = 'TIME' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else if input.FormatterType = 'DATETIME' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else if input.FormatterType = 'PERCENTAGE' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else if input.FormatterType = 'DEGREE' then
  begin
    result := TLlDOMPropertyOutputFormatterDouble.Create(input);
  end
  else
    result := input;
  if result <> input then
  begin
    input.Free;
    // input:=nil;
  end;
end;

class function TLlDOMHelper.SafeValueAxisCast
  (input: TLlDOMPropertyValueAxisBase): TLlDOMPropertyValueAxisBase;
begin
  if input.BubbleChartMode = '0' then
  begin
    result := TLlDOMPropertyValueAxisBubbleChartScattered.Create(input);
  end
  else if input.BubbleChartMode = '1' then
  begin
    result := TLlDOMPropertyValueAxisBubbleChartSorted.Create(input);
  end
  else
    result := input;
  if result <> input then
  begin
    input.Free;
  end;
end;

class function TLlDOMHelper.SafeInputButtonActionCast
      (input: TLlDOMPropertyInputButtonActionBase): TLlDOMPropertyInputButtonActionBase;
      var actionType: TString;
begin
  actionType := input.Actiontype;

  if actionType ='0' then
    begin
      result := TLlDOMPropertyInputButtonActionSendTo.Create(input);
    end
      else if actionType ='1' then
    begin
      result := TLlDOMPropertyInputButtonActionSaveAs.Create(input);
    end
      else if actionType ='2' then
    begin
      result := TLlDOMPropertyInputButtonActionHttpPost.Create(input);
    end
      else if actionType ='3' then
    begin
      result := TLlDOMPropertyInputButtonActionLink.Create(input);
    end
      else if actionType ='4' then
    begin
      result := TLlDOMPropertyInputButtonActionPdfSig.Create(input);
    end
    else
    result := input;

   if result <> input then
    begin
      input.Free;
      // input:=nil;
    end;
end;

class function TLlDOMHelper.SafeBarcodeSourceCast
        (input: TLlDOMPropertyBarcodeSource):TLlDOMPropertyBarcodeSource;
        var barcodeType: TString;
begin
barcodeType := input.BarcodeType;

  if barcodeType ='PDF417' then
    begin
      result := TLlDOMPropertyPDF417BarcodeSource.Create(input);
    end
      else if barcodeType ='Maxicode' then
    begin
      result := TLlDOMPropertyMaxicodeBarcodeSource.Create(input);
    end
      else if barcodeType ='Datamatrix' then
    begin
      result := TLlDOMPropertyDatamatrixBarcodeSource.Create(input);
    end
      else if barcodeType ='Aztec' then
    begin
      result := TLlDOMPropertyAztecBarcodeSource.Create(input);
    end
      else if barcodeType ='QRCode' then
    begin
      result := TLlDOMPropertyQRBarcodeSource.Create(input);
    end
      else if barcodeType ='MicroPDF417' then
    begin
      result := TLlDOMPropertyMicroPDF417BarcodeSource.Create(input);
    end
      else if barcodeType ='PremiumAddress' then
    begin
      result := TLlDOMPropertyPremiumAddressBarcodeSource.Create(input);
    end
    else
    result := input;

   if result <> input then
    begin
      input.Free;
      // input:=nil;
    end;

end;


class function TLlDOMHelper.SafeTableFielBarcodeSourceCast
        (source: TLlDOMPropertyTableFieldBarCodeSource; input: TLlDOMTableFieldBarcode):TLlDOMPropertyTableFieldBarCodeSource;
        var barcodeType: TString;
begin
barcodeType := input.BarcodeType;

  if barcodeType ='PDF417' then
    begin
      result := TLlDOMPropertyTableFieldPDF417BarcodeSource.Create(input);
    end
      else if barcodeType ='Maxicode' then
    begin
      result := TLlDOMPropertyTableFieldMaxicodeBarcodeSource.Create(input);
    end
      else if barcodeType ='Datamatrix' then
    begin
      result := TLlDOMPropertyTableFieldDatamatrixBarcodeSource.Create(input);
    end
      else if barcodeType ='Aztec' then
    begin
      result := TLlDOMPropertyTableFieldAztecBarcodeSource.Create(input);
    end
      else if barcodeType ='QRCode' then
    begin
      result := TLDOMPropertyTableFieldQRBarcodeSource.Create(input);
    end
      else if barcodeType ='MicroPDF417' then
    begin
      result := TLlDOMPropertyTableFieldMicroPDF417BarcodeSource.Create(input);
    end
      else if barcodeType ='PremiumAddress' then
    begin
      result := TLlDOMPropertyTableFieldPremiumAddressBarcodeSource.Create(input);
    end
    else
    result := source;

   if result <> source then
    begin
      input.Free;
      // input:=nil;
    end;

end;

{ TLlDOMPropertyOutpuFormatterDate }

constructor TLlDOMPropertyOutputFormatterDate.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('DATE', item);
end;

function TLlDOMPropertyOutputFormatterDate.GetFormatTemplate: TString;
begin
  result := GetProperty(FormatterType + '.FormatTemplate');
end;

function TLlDOMPropertyOutputFormatterDate.GetFormatType: TString;
begin
  result := GetProperty(FormatterType + '.FormatType');
end;

procedure TLlDOMPropertyOutputFormatterDate.SetFormatTemplate
  (const value: TString);
begin
  SetProperty(FormatterType + '.FormatTemplate', value);
end;

procedure TLlDOMPropertyOutputFormatterDate.SetFormatType(const value: TString);
begin
  SetProperty(FormatterType + '.FormatType', value);
end;

{ TLlDOMPropertyOutpuFormatterDateTime }

constructor TLlDOMPropertyOutputFormatterDateTime.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('DATETIME', item);
end;

function TLlDOMPropertyOutputFormatterDateTime.GetDate
  : TLlDOMPropertyDateTimeFormat;
var
  baseObj: TLlDOMItem;
begin
  if fDate <> nil then
  begin
    result := fDate
  end
  else
  begin
    baseObj := GetObject(FormatterType + '.Date');
    fDate := TLlDOMPropertyDateTimeFormat.Create(baseObj);
    baseObj.Free;
    result := fDate;
  end;
end;

function TLlDOMPropertyOutputFormatterDateTime.GetSeparator: TString;
begin
  result := GetProperty(FormatterType + '.Separator');
end;

function TLlDOMPropertyOutputFormatterDateTime.GetTime
  : TLlDOMPropertyDateTimeFormat;
var
  baseObj: TLlDOMItem;
begin
  if fTime <> nil then
  begin
    result := fTime
  end
  else
  begin
    baseObj := GetObject(FormatterType + '.Time');
    fTime := TLlDOMPropertyDateTimeFormat.Create(baseObj);
    baseObj.Free;
    result := fTime;
  end;
end;

function TLlDOMPropertyOutputFormatterDateTime.GetTimeAtLeft: TString;
begin
  result := GetProperty(FormatterType + '.TimeAtLeft');
end;

procedure TLlDOMPropertyOutputFormatterDateTime.SetSeparator
  (const value: TString);
begin
  SetProperty(FormatterType + '.Separator', value);
end;

procedure TLlDOMPropertyOutputFormatterDateTime.SetTimeAtLeft
  (const value: TString);
begin
  SetProperty(FormatterType + '.TimeAtLeft', value);
end;

{ TLlDOMPropertyOutpuFormatterTime }

constructor TLlDOMPropertyOutputFormatterTime.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('TIME', item);
end;

function TLlDOMPropertyOutputFormatterTime.GetFormatTemplate: TString;
begin
  result := GetProperty(FormatterType + '.FormatTemplate');
end;

function TLlDOMPropertyOutputFormatterTime.GetFormatType: TString;
begin
  result := GetProperty(FormatterType + '.FormatType');
end;

procedure TLlDOMPropertyOutputFormatterTime.SetFormatTemplate
  (const value: TString);
begin
  SetProperty(FormatterType + '.FormatTemplate', value);
end;

procedure TLlDOMPropertyOutputFormatterTime.SetFormatType(const value: TString);
begin
  SetProperty(FormatterType + '.FormatType', value);
end;

{ TLlDOMPRopertyDateTimeFormat }

function TLlDOMPropertyDateTimeFormat.GetFormatTemplate: TString;
begin
  result := GetProperty('FormatTemplate');
end;

function TLlDOMPropertyDateTimeFormat.GetFormatType: TString;
begin
  result := GetProperty('FormatType');
end;

procedure TLlDOMPropertyDateTimeFormat.SetFormatTemplate(const value: TString);
begin
  SetProperty('FormatTemplate', value);
end;

procedure TLlDOMPropertyDateTimeFormat.SetFormatType(const value: TString);
begin
  SetProperty('FormatType', value);
end;

{ TLlDOMPropertyOutpuFormatterPercentage }

constructor TLlDOMPropertyOutputFormatterPercentage.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('PERCENTAGE', item);
end;

function TLlDOMPropertyOutputFormatterPercentage.GetCountOfDecimals: TString;
begin
  result := GetProperty(FormatterType + '.CountOfDecimals');
end;

function TLlDOMPropertyOutputFormatterPercentage.
  GetDecimalSeparatorCharType: TString;
begin
  result := GetProperty(FormatterType + '.DecimalSeparatorCharType');
end;

function TLlDOMPropertyOutputFormatterPercentage.GetEmptyStringIfZero: TString;
begin
  result := GetProperty(FormatterType + '.EmptyStringIfZero');
end;

function TLlDOMPropertyOutputFormatterPercentage.
  GetForceZeroBeforeDecimalSeparator: TString;
begin
  result := GetProperty(FormatterType + '.ForceZeroBeforeDecimalSeparator');
end;

function TLlDOMPropertyOutputFormatterPercentage.GetNegativeFormatType: TString;
begin
  result := GetProperty(FormatterType + '.NegativeFormatType');
end;

function TLlDOMPropertyOutputFormatterPercentage.
  GetThousandsSeparatorCharType: TString;
begin
  result := GetProperty(FormatterType + '.ThousandsSeparatorCharType');
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetCountOfDecimals
  (const value: TString);
begin
  SetProperty(FormatterType + '.CountOfDecimals', value);
end;

function TLlDOMPropertyOutputFormatterPercentage.
  GetForceSign: TString;
begin
  result := GetProperty(FormatterType + '.ForceSign');
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetForceSign
  (const value: TString);
begin
  SetProperty(FormatterType + '.ForceSign', value);
end;

function TLlDOMPropertyOutputFormatterPercentage.GetMultiplyBy100: TString;
begin
  result := GetProperty(FormatterType + '.MultiplyBy100');
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetMultiplyBy100
  (const value: TString);
begin
  SetProperty(FormatterType + '.MultiplyBy100', value);
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetDecimalSeparatorCharType
  (const value: TString);
begin
  SetProperty(FormatterType + '.DecimalSeparatorCharType', value);
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetEmptyStringIfZero
  (const value: TString);
begin
  SetProperty(FormatterType + '.EmptyStringIfZero', value);
end;

procedure TLlDOMPropertyOutputFormatterPercentage.
  SetForceZeroBeforeDecimalSeparator(const value: TString);
begin
  SetProperty(FormatterType + '.ForceZeroBeforeDecimalSeparator', value);
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetNegativeFormatType
  (const value: TString);
begin
  SetProperty(FormatterType + '.NegativeFormatType', value);
end;

procedure TLlDOMPropertyOutputFormatterPercentage.SetThousandsSeparatorCharType
  (const value: TString);
begin
  SetProperty(FormatterType + '.ThousandsSeparatorCharType', value);
end;

{ TLlDOMPropertyOutpuFormatterDegree }

constructor TLlDOMPropertyOutputFormatterDegree.Create
  (item: TLlDOMPropertyOutputFormatterBase);
begin
  inherited Create('DEGREE', item);
end;

function TLlDOMPropertyOutputFormatterDegree.GetCountOfDecimals: TString;
begin
  result := GetProperty(FormatterType + '.CountOfDecimals');
end;

function TLlDOMPropertyOutputFormatterDegree.
  GetDecimalSeparatorCharType: TString;
begin
  result := GetProperty(FormatterType + '.DecimalSeparatorCharType');
end;

function TLlDOMPropertyOutputFormatterDegree.GetEmptyStringIfZero: TString;
begin
  result := GetProperty(FormatterType + '.EmptyStringIfZero');
end;

function TLlDOMPropertyOutputFormatterDegree.GetFormatType: TString;
begin
  result := GetProperty(FormatterType + '.FormatType');
end;

function TLlDOMPropertyOutputFormatterDegree.GetInputDataType: TString;
begin
  result := GetProperty(FormatterType + '.InputDataType');
end;

function TLlDOMPropertyOutputFormatterDegree.GetOmitEmptyParts: TString;
begin
  result := GetProperty(FormatterType + '.OmitEmptyParts');
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetCountOfDecimals
  (const value: TString);
begin
  SetProperty(FormatterType + '.CountOfDecimals', value);
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetDecimalSeparatorCharType
  (const value: TString);
begin
  SetProperty(FormatterType + '.DecimalSeparatorCharType', value);
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetEmptyStringIfZero
  (const value: TString);
begin
  SetProperty(FormatterType + '.EmptyStringIfZero', value);
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetFormatType
  (const value: TString);
begin
  SetProperty(FormatterType + '.FormatType', value);
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetInputDataType
  (const value: TString);
begin
  SetProperty(FormatterType + '.InputDataType', value);
end;

procedure TLlDOMPropertyOutputFormatterDegree.SetOmitEmptyParts
  (const value: TString);
begin
  SetProperty(FormatterType + '.OmitEmptyParts', value);
end;

{ TLlDOMHorizontalLinkType }

class function TLlDOMHorizontalLinkType.AtEnd: integer;
begin
  result := $00000003;
end;

class function TLlDOMHorizontalLinkType.AtEndKeepSize: integer;
begin
  result := $00004000
end;

class function TLlDOMHorizontalLinkType.None: integer;
begin
  result := $00000000;
end;

class function TLlDOMHorizontalLinkType.RelativeToEnd: integer;
begin
  result := $00000002;
end;

class function TLlDOMHorizontalLinkType.RelativeToStart: integer;
begin
  result := $00000001;
end;

{ TLlDOMVerticalLinkType }

class function TLlDOMVerticalLinkType.AtEnd: integer;
begin
  result := $00000030;
end;

class function TLlDOMVerticalLinkType.AtEndKeepSize: integer;
begin
  result := $00004000
end;

class function TLlDOMVerticalLinkType.None: integer;
begin
  result := $00000000;
end;

class function TLlDOMVerticalLinkType.RelativeToEnd: integer;
begin
  result := $00000020;
end;

class function TLlDOMVerticalLinkType.RelativeToStart: integer;
begin
  result := $00000010;
end;

{ TLlDOMHorizontalSizeAdaptionType }

class function TLlDOMHorizontalSizeAdaptionType.Inverse: integer;
begin
  result := $00000200;
end;

class function TLlDOMHorizontalSizeAdaptionType.None: integer;
begin
  result := $00000000;
end;

class function TLlDOMHorizontalSizeAdaptionType.Propertional: integer;
begin
  result := $00000100;
end;

{ TLlDOMVerticalSizeAdaptionType }

class function TLlDOMVerticalSizeAdaptionType.Inverse: integer;
begin
  result := $00002000;
end;

class function TLlDOMVerticalSizeAdaptionType.None: integer;
begin
  result := $00000000;
end;

class function TLlDOMVerticalSizeAdaptionType.Propertional: integer;
begin
  result := $00001000;
end;

{ TLlDOMPropertyDrawingContents }

destructor TLlDOMPropertyDrawingContents.Destroy;
begin
  fDisplay.Free;
  fFileinfo.Free;
  inherited;
end;

function TLlDOMPropertyDrawingContents.GetDisplay: TLlDOMPropertyDisplay;
var
  baseObj: TLlDOMItem;
begin
  if fDisplay <> nil then
  begin
    result := fDisplay
  end
  else
  begin
    baseObj := GetObject('Display');
    fDisplay := TLlDOMPropertyDisplay.Create(baseObj);
    baseObj.Free;
    result := fDisplay;
  end;
end;

function TLlDOMPropertyDrawingContents.GetFileinfo: TLlDOMPropertyFileInfo;
var
  baseObj: TLlDOMItem;
begin
  if fFileinfo <> nil then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

function TLlDOMPropertyDrawingContents.GetEmbedded: TString;
begin
   result := GetProperty('Embedded');
end;

function TLlDOMPropertyDrawingContents.GetEmbeddedContents: TString;
begin
   result := GetProperty('EmbeddedContents');
end;

procedure TLlDOMPropertyDrawingContents.SetEmbedded(const value: TString);
begin
  SetProperty('Embedded', value);
end;

procedure TLlDOMPropertyDrawingContents.SetEmbeddedContents(const value: TString);
begin
   SetProperty('EmbeddedContents', value);
end;

function TLlDOMPropertyDrawingContents.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyDrawingContents.GetMode: TString;
begin
  result := GetProperty('Mode');
end;

function TLlDOMPropertyDrawingContents.GetVariable: TString;
begin
  result := GetProperty('Variable');
end;

procedure TLlDOMPropertyDrawingContents.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyDrawingContents.SetMode(const value: TString);
begin
  SetProperty('Mode', value);
end;

procedure TLlDOMPropertyDrawingContents.SetVariable(const value: TString);
begin
  SetProperty('Variable', value);
end;

{ TLlDOMPropertyColumns }

function TLlDOMPropertyColumns.GetColumnBreakCondition: TString;
begin
  result := GetProperty('ColumnBreakCondition');
end;

function TLlDOMPropertyColumns.GetColumnBreakBefore: TString;
begin
  result := GetProperty('ColumnBreakBefore');
end;

function TLlDOMPropertyColumns.GetCount: TString;
begin
  result := GetProperty('Count');
end;

function TLlDOMPropertyColumns.GetDistance: TString;
begin
  result := GetProperty('Distance');
end;

procedure TLlDOMPropertyColumns.SetColumnBreakCondition(const value: TString);
begin
  SetProperty('ColumnBreakCondition', value);
end;

procedure TLlDOMPropertyColumns.SetColumnBreakBefore(const value: TString);
begin
  SetProperty('ColumnBreakBefore', value);
end;

procedure TLlDOMPropertyColumns.SetCount(const value: TString);
begin
  SetProperty('Count', value);
end;

procedure TLlDOMPropertyColumns.SetDistance(const value: TString);
begin
  SetProperty('Distance', value);
end;


function TLlDOMTableLineGroupHeader.GetKeepGroupTogether: TString;
begin
  result:=  GetProperty('KeepTogether.Group');
end;

procedure TLlDOMTableLineGroupHeader.SetKeepGroupTogether(const value: TString);
begin
  SetProperty('KeepTogether.Group', value);
end;

function TLlDOMTableLineGroupHeader.GetBreakBefore: TLlDOMPropertyPageBreakOptions;
var
  baseObj: TLlDOMItem;
begin
  if (fBreakBefore <> nil) then
  begin
    result := fBreakBefore;
  end
  else
  begin
    baseObj := GetObject('PageBreakOptions');
    fBreakBefore := TLlDOMPropertyPageBreakOptions.Create(baseObj);
    baseObj.Free;
    result := fBreakBefore;
  end;
end;

function TLlDOMTableLineGroupHeader.GetGroupBy: TString;
begin
  result := GetProperty('GroupBy');
end;

function TLlDOMTableLineGroupHeader.GetGroupSums: TString;
begin
  result := GetProperty('GroupSums');
end;

function TLlDOMTableLineGroupHeader.GetRepeatAsHeader: TString;
begin
  result := GetProperty('RepeatAsHeader');
end;

procedure TLlDOMTableLineGroupHeader.SetGroupBy(const value: TString);
begin
  SetProperty('GroupBy', value);
end;

procedure TLlDOMTableLineGroupHeader.SetGroupSums(const value: TString);
begin
  SetProperty('GroupSums', value);
end;

procedure TLlDOMTableLineGroupHeader.SetRepeatAsHeader(const value: TString);
begin
  SetProperty('RepeatAsHeader', value);
end;

function TLlDOMTableLineGroupHeader.GetExpandable: TString;
begin
  result := GetProperty('Expandable');
end;

procedure TLlDOMTableLineGroupHeader.SetExpandable(const value: TString);
begin
  SetProperty('Expandable', value);
end;


{ TLlDOMPropertyBookmark }

function TLlDOMPropertyBookmark.GetLevel: TString;
begin
  result := GetProperty('Level');
end;

function TLlDOMPropertyBookmark.GetText: TString;
begin
  result := GetProperty('Text');
end;

procedure TLlDOMPropertyBookmark.SetLevel(const value: TString);
begin
  SetProperty('Level', value);
end;

procedure TLlDOMPropertyBookmark.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;

function TLlDOMTableLineGroupFooter.GetGroupBy: TString;
begin
  result := GetProperty('GroupBy');
end;

function TLlDOMTableLineGroupFooter.GetGroupSums: TString;
begin
  result := GetProperty('GroupSums');
end;

function TLlDOMTableLineGroupFooter.GetTriggerNewPage: TString;
begin
  result := GetProperty('TriggerNewPage');
end;

procedure TLlDOMTableLineGroupFooter.SetGroupBy(const value: TString);
begin
  SetProperty('GroupBy', value);
end;

procedure TLlDOMTableLineGroupFooter.SetGroupSums(const value: TString);
begin
  SetProperty('GroupSums', value);
end;

procedure TLlDOMTableLineGroupFooter.SetTriggerNewPage(const value: TString);
begin
  SetProperty('TriggerNewPage', value);
end;

{ TLlDOMObjectChart }

constructor TLlDOMObjectChart.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Chart', list.Count);
end;

constructor TLlDOMObjectChart.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Chart', index);
end;

constructor TLlDOMObjectChart.Create(ChartType: TLlDOMChartType;
  list: TLlDOMObjectList; index: integer);
begin
  case ChartType of
    ctBar2D:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DClustered:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '2';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DStacked:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar3D:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DClustered:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '2';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DMultiRow:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DStacked:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctLineStacked:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineMultiRow:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineSimple:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctPie2D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctPie3D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctAreaSimple:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctAreaStacked:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctAreaStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBubbleSorted:
      begin
        Definition.ChartEngine.ChartType := '4';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBubbleScattered:
      begin
        Definition.ChartEngine.ChartType := '4';
        Definition.ChartEngine.DataMode := '5';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctRadarSimple:
      begin
        Definition.ChartEngine.ChartType := '7';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctRadarClustered:
      begin
        Definition.ChartEngine.ChartType := '7';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctRadarStacked:
      begin
        Definition.ChartEngine.ChartType := '7';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctRadarStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '7';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctTreeMapSingle:
      begin
        Definition.ChartEngine.ChartType := '8';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctTreeMapClustered:
      begin
        Definition.ChartEngine.ChartType := '8';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
      ctRScript:
      begin
        Definition.ChartEngine.ChartType := '9';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
  end;
end;

destructor TLlDOMObjectChart.Destroy;
begin
  fDefinition.Free;
  fFrame.Free;
  inherited;
end;

function TLlDOMObjectChart.GetDefinition: TLlDOMPropertyChartDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyChartDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMObjectChart.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectChart.GetFilling: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMObjectChart.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectChart.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

{ TLlDOMObjectPDF }
constructor TLlDOMObjectPDF.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'PDF', list.Count);
end;

constructor TLlDOMObjectPDF.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'PDF', index);
end;

destructor TLlDOMObjectPDF.Destroy;
begin
  fDefinition.Free;
  fFrame.Free;
end;

function TLlDOMObjectPDF.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

procedure TLlDOMObjectPDF.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

function TLlDOMObjectPDF.GetFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

Function TLlDOMObjectPDF.GetDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition;
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyPDFDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

{ TLlDOMObjectGauge }
constructor TLlDOMObjectGauge.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'Gauge', list.Count);
end;

constructor TLlDOMObjectGauge.Create(list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, 'Gauge', index);
end;

constructor TLlDOMObjectGauge.Create(GaugeType: TLlDOMGaugeType;
  list: TLlDOMObjectList; index: integer);
begin
  case GaugeType of
    gtRound:
      begin
        Definition.SetProperty('Style', '0');
      end;
    gtLinear:
      begin
        Definition.SetProperty('Style', '1');
      end;
    gtLinearHorizontal:
      begin
        Definition.SetProperty('Style', '2');
      end;
  end;
end;

destructor TLlDOMObjectGauge.Destroy;
begin
  fDefinition.Free;
  fFrame.Free;
end;

function TLlDOMObjectGauge.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

procedure TLlDOMObjectGauge.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

function TLlDOMObjectGauge.GetFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

Function TLlDOMObjectGauge.GetDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition;
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyGaugeDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

{ TLlDOMPropertyChartDefinition }

destructor TLlDOMPropertyChartDefinition.Destroy;
begin
  fBackground.Free;
  fBookmark.Free;
  fChartEngine.Free;
  fConditionalColors.Free;
  fTitle.Free;
  fChartColor.Free;
  fManualLegends.Free;
  inherited;
end;

function TLlDOMPropertyChartDefinition.GetManualLegends
  : TLlDOMPropertyManualLegendsList;
begin
  if fManualLegends = nil then
  begin
    fManualLegends := TLlDOMPropertyManualLegendsList.Create
      (GetObject('ManualLegend'));
  end;
  result := fManualLegends;
end;

function TLlDOMPropertyChartDefinition.GetBackground: TLlDOMPropertyBackground;
var
  baseObj: TLlDOMItem;
begin
  if fBackground <> nil then
  begin
    result := fBackground
  end
  else
  begin
    baseObj := GetObject('Background');
    fBackground := TLlDOMPropertyBackground.Create(baseObj);
    baseObj.Free;
    result := fBackground;
  end;
end;

function TLlDOMPropertyChartDefinition.GetBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if (fBookmark <> nil) then
  begin
    result := fBookmark
  end
  else
  begin
    baseObj := GetObject('Bookmark');
    fBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fBookmark;
  end;
end;

function TLlDOMPropertyChartDefinition.GetChartColorArray
  : TLlDOMPropertyChartColorArray;
var
  baseObj: TLlDOMItem;
begin
  if fChartColor <> nil then
  begin
    result := fChartColor
  end
  else
  begin
    baseObj := GetObject('Colors');
    fChartColor := TLlDOMPropertyChartColorArray.Create(baseObj);
    baseObj.Free;
    result := fChartColor;
  end;
end;

function TLlDOMPropertyChartDefinition.GetChartEngine
  : TLlDOMPropertyChartEngineBase;
var
  baseObj: TLlDOMItem;
begin
  if fChartEngine <> nil then
    fChartEngine.Free;

  baseObj := GetObject('ChartEngine');
  fChartEngine := TLlDOMPropertyChartEngineBase.Create(baseObj);
  baseObj.Free;
  fChartEngine := TLlDOMHelper.SafeChartEngineCast(fChartEngine);

  result := fChartEngine;
end;

function TLlDOMPropertyChartDefinition.GetConditionalColors
  : TLlDOMChartConditionalColorsList;
var
  baseObj: TLlDOMItem;
begin
  if fConditionalColors = nil then
  begin
    baseObj := GetObject('ConditionalColors');
    fConditionalColors := TLlDOMChartConditionalColorsList.Create(baseObj);
    baseObj.Free;
  end;
  result := fConditionalColors;
end;

function TLlDOMPropertyChartDefinition.GetTitle: TLlDOMPropertyChartTitle;
var
  baseObj: TLlDOMItem;
begin
  if fTitle <> nil then
  begin
    result := fTitle
  end
  else
  begin
    baseObj := GetObject('Title');
    fTitle := TLlDOMPropertyChartTitle.Create(baseObj);
    baseObj.Free;
    result := fTitle;
  end;
end;

function TLlDOMPropertyChartDefinition.GetTitlePosition: TString;
begin
  result := GetProperty('TitlePosition');
end;

procedure TLlDOMPropertyChartDefinition.SetTitlePosition(const value: TString);
begin
  SetProperty('TitlePosition', value);
end;

{ TLlDOMPropertyPDFSource }
destructor TLlDOMPropertyPDFSource.Destroy;
begin
  fDisplay.Free;
  fFileinfo.Free;
end;

function TLlDOMPropertyPDFSource.GetMode: TString;
begin
  result := GetProperty('Mode');
end;

procedure TLlDOMPropertyPDFSource.SetMode(const value: TString);
begin
  SetProperty('Mode', value);
end;

function TLlDOMPropertyPDFSource.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

procedure TLlDOMPropertyPDFSource.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

function TLlDOMPropertyPDFSource.GetPageRange: TString;
begin
  result := GetProperty('PageRange');
end;

procedure TLlDOMPropertyPDFSource.SetPageRange(const value: TString);
begin
  SetProperty('PageRange', value);
end;

function TLlDOMPropertyPDFSource.GetPassword: TString;
begin
  result := GetProperty('Password');
end;

procedure TLlDOMPropertyPDFSource.SetPassword(const value: TString);
begin
  SetProperty('Password', value);
end;

function TLlDOMPropertyPDFSource.GetEmbedded: TString;
begin
  result := GetProperty('Embedded');
end;

procedure TLlDOMPropertyPDFSource.SetEmbedded(const value: TString);
begin
  SetProperty('Embedded', value);
end;

function TLlDOMPropertyPDFSource.GetPagebreak: TString;
begin
  result := GetProperty('Pagebreak');
end;

procedure TLlDOMPropertyPDFSource.SetPagebreak(const value: TString);
begin
  SetProperty('Pagebreak', value);
end;

function TLlDOMPropertyPDFSource.GetFontMode: TString;
begin
  result := GetProperty('FontMode');
end;

procedure TLlDOMPropertyPDFSource.SetFontMode(const value: TString);
begin
  SetProperty('FontMode', value);
end;

function TLlDOMPropertyPDFSource.GetDisplay;
var
  baseObj: TLlDOMItem;
begin
  if fDisplay <> nil then
  begin
    result := fDisplay
  end
  else
  begin
    baseObj := GetObject('Display');
    fDisplay := TLlDOMPropertyDisplay.Create(baseObj);
    baseObj.Free;
    result := fDisplay;
  end;
end;

function TLlDOMPropertyPDFSource.GetFileinfo;
var
  baseObj: TLlDOMItem;
begin
  if fFileinfo <> nil then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

{ TLlDOMPropertyPDFDefinition }
destructor TLlDOMPropertyPDFDefinition.Destroy;
begin
  fPDFSource.Free;
end;

function TLlDOMPropertyPDFDefinition.GetPDFSource;
var
  baseObj: TLlDOMItem;
begin
  if fPDFSource <> nil then
  begin
    result := fPDFSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fPDFSource := TLlDOMPropertyPDFSource.Create(baseObj);
    baseObj.Free;
    result := fPDFSource;
  end;
end;

{ TLlDOMPropertyGaugeDefinition }
destructor TLlDOMPropertyGaugeDefinition.Destroy;
begin
  fAlphaBlendableItemFrame.Free;
  fAlphaBlendableItemGlass.Free;
  fPointer.Free;
  fMinimumValue.Free;
  fMaximumValue.Free;
  fScaleLabels.Free;
  fTickmarks.Free;
  fLabels.Free;
  fSignalRanges.Free;
  fStartValue.Free;
end;

function TLlDOMPropertyGaugeDefinition.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyGaugeDefinition.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyGaugeDefinition.GetWhiteSpaceBeforeScaleRange;
begin
  result := GetProperty('WhiteSpaceBeforeScaleRange')
end;

function TLlDOMPropertyGaugeDefinition.GetWidthHeightRelation: TString;
begin
  result := GetProperty('WidthHeightRelation');
end;

procedure TLlDOMPropertyGaugeDefinition.SetWhiteSpaceBeforeScaleRange
  (const value: TString);
begin
  SetProperty('WhiteSpaceBeforeScaleRange', value);
end;

procedure TLlDOMPropertyGaugeDefinition.SetWidthHeightRelation
  (const value: TString);
begin
  SetProperty('WidthHeightRelation', value);
end;

function TLlDOMPropertyGaugeDefinition.GetWhiteSpaceAfterScaleRange;
begin
  result := GetProperty('WhiteSpaceAfterScaleRange');
end;

procedure TLlDOMPropertyGaugeDefinition.SetWhiteSpaceAfterScaleRange
  (const value: TString);
begin
  SetProperty('WhiteSpaceAfterScaleRange', value);
end;

function TLlDOMPropertyGaugeDefinition.GetPropertyAlphaBlendableItemFrame;
var
  baseObj: TLlDOMItem;
begin
  if fAlphaBlendableItemFrame <> nil then
  begin
    result := fAlphaBlendableItemFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fAlphaBlendableItemFrame := TLlDOMPropertyAlphaBlendableItem.Create
      (baseObj);
    baseObj.Free;
    result := fAlphaBlendableItemFrame;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetPropertyAlphaBlendableItemGlass;
var
  baseObj: TLlDOMItem;
begin
  if fAlphaBlendableItemGlass <> nil then
  begin
    result := fAlphaBlendableItemGlass
  end
  else
  begin
    baseObj := GetObject('Glass');
    fAlphaBlendableItemGlass := TLlDOMPropertyAlphaBlendableItem.Create
      (baseObj);
    baseObj.Free;
    result := fAlphaBlendableItemGlass;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetPropertyPointer;
var
  baseObj: TLlDOMItem;
begin
  if fPointer <> nil then
  begin
    result := fPointer
  end
  else
  begin
    baseObj := GetObject('Pointer');
    fPointer := TLlDOMPropertyPointer.Create(baseObj);
    baseObj.Free;
    result := fPointer;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetPropertyMinimumValue;
var
  baseObj: TLlDOMItem;
begin
  if fMinimumValue <> nil then
  begin
    result := fMinimumValue
  end
  else
  begin
    baseObj := GetObject('MinimumValue');
    fMinimumValue := TLlDOMPropertyScaleLimits.Create(baseObj);
    baseObj.Free;
    result := fMinimumValue;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetPropertyMaximumValue;
var
  baseObj: TLlDOMItem;
begin
  if fMaximumValue <> nil then
  begin
    result := fMaximumValue;
  end
  else
  begin
    baseObj := GetObject('MaximumValue');
    fMaximumValue := TLlDOMPropertyScaleLimits.Create(baseObj);
    baseObj.Free;
    result := fMaximumValue;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetScaleLabels;
var
  baseObj: TLlDOMItem;
begin
  if fScaleLabels <> nil then
  begin
    result := fScaleLabels
  end
  else
  begin
    baseObj := GetObject('ScaleLabels');
    fScaleLabels := TLlDOMPropertyScaleLabels.Create(baseObj);
    baseObj.Free;
    result := fScaleLabels;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetTickmarks;
var
  baseObj: TLlDOMItem;
begin
  if fTickmarks <> nil then
  begin
    result := fTickmarks
  end
  else
  begin
    baseObj := GetObject('Tickmarks');
    fTickmarks := TLlDOMPropertyTickmarks.Create(baseObj);
    baseObj.Free;
    result := fTickmarks;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetLabels;
var
  baseObj: TLlDOMItem;
begin
  if fLabels <> nil then
  begin
    result := fLabels
  end
  else
  begin
    baseObj := GetObject('Labels');
    fLabels := TLlDOMPropertyLabels.Create(baseObj);
    baseObj.Free;
    result := fLabels;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetSignalRanges: TLlDOMPropertySignalRanges;
var
  baseObj: TLlDOMItem;
begin
  if fSignalRanges <> nil then
  begin
    result := fSignalRanges
  end
  else
  begin
    baseObj := GetObject('SignalRanges');
    fSignalRanges := TLlDOMPropertySignalRanges.Create(baseObj);
    baseObj.Free;
    result := fSignalRanges;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetStartValue;
var
  baseObj: TLlDOMItem;
begin
  if fStartValue <> nil then
  begin
    result := fStartValue;
  end
  else
  begin
    baseObj := GetObject('StartValue');
    fStartValue := TLlDOMPropertyStartValue.Create(baseObj);
    baseObj.Free;
    result := fStartValue;
  end;
end;

function TLlDOMPropertyGaugeDefinition.GetScaleRangeRotationAngle: TString;
begin
  result := GetProperty('ScaleRangeRotationAngle');
end;

procedure TLlDOMPropertyGaugeDefinition.SetScaleRangeRotationAngle
  (const value: TString);
begin
  SetProperty('ScaleRangeRotationAngle', value);
end;

function TLlDOMPropertyGaugeDefinition.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyGaugeDefinition.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

{ TLlDOMPropertyHighlightRange }
function TLlDOMPropertyHighlightRange.GetColor;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyHighlightRange.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyHighlightRange.GetEndDate;
begin
  result := GetProperty('EndDate');
end;

procedure TLlDOMPropertyHighlightRange.SetEndDate(const value: TString);
begin
  SetProperty('EndDate', value);
end;

function TLlDOMPropertyHighlightRange.GetStartDate;
begin
  result := GetProperty('StartDate');
end;

procedure TLlDOMPropertyHighlightRange.SetStartDate(const value: TString);
begin
  SetProperty('StartDate', value);
end;

{ TLlDOMPropertyOuterInterval }
function TLlDOMPropertyOuterInterval.GetContents;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyOuterInterval.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

function TLlDOMPropertyOuterInterval.GetFormat;
begin
  result := GetProperty('Format');
end;

procedure TLlDOMPropertyOuterInterval.SetFormat(const value: TString);
begin
  SetProperty('Format', value);
end;

{ TLlDOMPropertyInnerInterval }
destructor TLlDOMPropertyInnerInterval.Destroy;
begin
  fOuterInterval.Free;
end;

function TLlDOMPropertyInnerInterval.GetContents;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyInnerInterval.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

function TLlDOMPropertyInnerInterval.GetFormat;
begin
  result := GetProperty('Format');
end;

procedure TLlDOMPropertyInnerInterval.SetFormat(const value: TString);
begin
  SetProperty('Format', value);
end;

function TLlDOMPropertyInnerInterval.GetMarkedDays;
begin
  result := GetProperty('MarkedDays');
end;

procedure TLlDOMPropertyInnerInterval.SetMarkedDays(const value: TString);
begin
  SetProperty('MarkedDays', value);
end;

function TLlDOMPropertyInnerInterval.GetOuterInterval
  : TLlDOMPropertyOuterInterval;
var
  baseObj: TLlDOMItem;
begin
  if fOuterInterval <> nil then
  begin
    result := fOuterInterval;
  end
  else
  begin
    baseObj := GetObject('OuterInterval');
    fOuterInterval := TLlDOMPropertyOuterInterval.Create(baseObj);
    baseObj.Free;
    result := fOuterInterval;
  end;
end;

{ TLlDOMPropertyChartArea }
destructor TLlDOMPropertyChartArea.Destroy;
begin
  fInnerInterval.Free;
end;

function TLlDOMPropertyChartArea.GetStartDate;
begin
  result := GetProperty('StartDate');
end;

procedure TLlDOMPropertyChartArea.SetStartDate(const value: TString);
begin
  SetProperty('StartDate', value);
end;

function TLlDOMPropertyChartArea.GetEndDate;
begin
  result := GetProperty('EndDate');
end;

procedure TLlDOMPropertyChartArea.SetEndDate(const value: TString);
begin
  SetProperty('EndDate', value);
end;

function TLlDOMPropertyChartArea.GetWidth;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyChartArea.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

function TLlDOMPropertyChartArea.GetInnerInterval;
var
  baseObj: TLlDOMItem;
begin
  if fInnerInterval <> nil then
  begin
    result := fInnerInterval;
  end
  else
  begin
    baseObj := GetObject('InnerInterval');
    fInnerInterval := TLlDOMPropertyInnerInterval.Create(baseObj);
    baseObj.Free;
    result := fInnerInterval;
  end;
end;

{ TLlDOMPropertyTitleRow }
destructor TLlDOMPropertyTitleRow.Destroy;
begin
  fBackgournd.Free;
  fFont.Free;
end;

function TLlDOMPropertyTitleRow.GetFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont;
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyTitleRow.GetBackground;
var
  baseObj: TLlDOMItem;
begin
  if fBackgournd <> nil then
  begin
    result := fBackgournd;
  end
  else
  begin
    baseObj := GetObject('Background');
    fBackgournd := TLlDOMPropertyBackground.Create(baseObj);
    baseObj.Free;
    result := fBackgournd;
  end;
end;

{ TLlDOMPropertyBar }
destructor TLlDOMPropertyBar.Destroy;
begin
  fFillingFinished.Free;
  fFillingUnfinished.Free;
end;

function TLlDOMPropertyBar.GetEndTicks;
begin
  result := GetProperty('EndTicks');
end;

procedure TLlDOMPropertyBar.SetEndTicks(const value: TString);
begin
  SetProperty('EndTicks', value);
end;

function TLlDOMPropertyBar.GetFinishedFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFillingFinished <> nil then
  begin
    result := fFillingFinished;
  end
  else
  begin
    baseObj := GetObject('FinishedFilling');
    fFillingFinished := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := fFillingFinished;
  end;
end;

function TLlDOMPropertyBar.GetHeightFinished;
begin
  result := GetProperty('HeightFinished');
end;

procedure TLlDOMPropertyBar.SetHeightFinished(const value: TString);
begin
  SetProperty('HeightFinished', value);
end;

function TLlDOMPropertyBar.GetHeightUnfinished;
begin
  result := GetProperty('HeightUnfinished');
end;

procedure TLlDOMPropertyBar.SetHeightUnfinished(const value: TString);
begin
  SetProperty('HeightUnfinished', value);
end;

function TLlDOMPropertyBar.GetRounding;
begin
  result := GetProperty('Rounding');
end;

procedure TLlDOMPropertyBar.SetRounding(const value: TString);
begin
  SetProperty('Rounding', value);
end;

function TLlDOMPropertyBar.GetUnfinishedFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFillingUnfinished <> nil then
  begin
    result := fFillingUnfinished;
  end
  else
  begin
    baseObj := GetObject('UnfinishedFilling');
    fFillingUnfinished := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := fFillingUnfinished;
  end;
end;

{ TLlDOMPropertyTaskRows }
destructor TLlDOMPropertyTaskRows.Destroy;
begin
  fFont.Free;
  fBackgournd.Free;
  fBar.Free;
end;

function TLlDOMPropertyTaskRows.GetFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont;
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyTaskRows.GetBackground;
var
  baseObj: TLlDOMItem;
begin
  if fBackgournd <> nil then
  begin
    result := fBackgournd;
  end
  else
  begin
    baseObj := GetObject('Background');
    fBackgournd := TLlDOMPropertyBackground.Create(baseObj);
    baseObj.Free;
    result := fBackgournd;
  end;
end;

function TLlDOMPropertyTaskRows.GetBar;
var
  baseObj: TLlDOMItem;
begin
  if fBar <> nil then
  begin
    result := fBar;
  end
  else
  begin
    baseObj := GetObject('Bar');
    fBar := TLlDOMPropertyBar.Create(baseObj);
    baseObj.Free;
    result := fBar;
  end;
end;

{ TLlDOMPropertyCell }
destructor TLlDOMPropertyCell.Destroy;
begin
  fOutputFormatter.Free;
end;

function TLlDOMPropertyCell.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyCell.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyCell.GetMaxWidth;
begin
  result := GetProperty('MaxWidth');
end;

function TLlDOMPropertyCell.GetMinWidth;
begin
  result := GetProperty('MinWidth');
end;

procedure TLlDOMPropertyCell.SetMaxWidth(const value: TString);
begin
  SetProperty('MaxWidth', value);
end;

procedure TLlDOMPropertyCell.SetMinWidth(const value: TString);
begin
  SetProperty('MinWidth', value);
end;

function TLlDOMPropertyCell.GetOuputFormatter;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter;
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyCell.GetTitle;
begin
  result := GetProperty('Title');
end;

procedure TLlDOMPropertyCell.SetTitle(const value: TString);
begin
  SetProperty('Title', value);
end;

{ TLlDOMPropertyIndexCell }
function TLlDOMPropertyIndexCell.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyIndexCell.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyIndexCell.GetMaxWidth;
begin
  result := GetProperty('MaxWidth');
end;

procedure TLlDOMPropertyIndexCell.SetMaxWidth(const value: TString);
begin
  SetProperty('MaxWidth', value);
end;

function TLlDOMPropertyIndexCell.GetTitle;
begin
  result := GetProperty('Title');
end;

procedure TLlDOMPropertyIndexCell.SetTitle(const value: TString);
begin
  SetProperty('Title', value);
end;

{ TLlDOMPropertyLabelCell }
function TLlDOMPropertyLabelCell.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyLabelCell.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyLabelCell.GetIndentation;
begin
  result := GetProperty('Indentation');
end;

procedure TLlDOMPropertyLabelCell.SetIndentation(const value: TString);
begin
  SetProperty('Indentation', value);
end;

function TLlDOMPropertyLabelCell.GetMaxWidth;
begin
  result := GetProperty('MaxWidth');
end;

procedure TLlDOMPropertyLabelCell.SetMaxWidth(const value: TString);
begin
  SetProperty('MaxWidth', value);
end;

function TLlDOMPropertyLabelCell.GetTitle;
begin
  result := GetProperty('Title');
end;

procedure TLlDOMPropertyLabelCell.SetTitle(const value: TString);
begin
  SetProperty('Title', value);
end;

{TLlDOMPropertyGridMode}

function TLlDomPropertyGridLineStyle.GetGridLineStyleColor: TString;
begin
  result:= GetProperty('GridLineStyleColor');
end;

function TLlDomPropertyGridLineStyle.GetLineWidth: TString;
begin
  result:= GetProperty('LineWidth');
end;

procedure TLlDomPropertyGridLineStyle.SetGridLineStyleColor(const value: TString);
begin
  SetProperty(GridLineStyleColor, value);
end;

procedure TLlDomPropertyGridLineStyle.SetLineWidth(const value: TString);
begin
  SetProperty('LineWidth', value);
end;

destructor TLlDomPropertyGridMode.Destroy;
begin
  fGridLineStyleDiagram.Free;
  fGridLineStyleTable.Free;
end;

function TLlDomPropertyGridMode.GetMode: TString;
begin
    result:= GetProperty('Mode');
end;

function TLlDomPropertyGridMode.GetGridLineStyleTable: TLlDomPropertyGridLineStyle;
var
  baseObj: TLlDOMItem;
begin
  if fGridLineStyleTable <> nil then
  begin
    result := fGridLineStyleTable;
  end
  else
  begin
    baseObj := GetObject('GridLineStyleTable');
    fGridLineStyleTable := TLlDomPropertyGridLineStyle.Create(baseObj);
    baseObj.Free;
    result := fGridLineStyleTable;
  end;

end;

function TLlDomPropertyGridMode.GetGridLineStyleDiagram: TLlDomPropertyGridLineStyle;
var
  baseObj: TLlDOMItem;
begin
  if fGridLineStyleDiagram <> nil then
  begin
    result := fGridLineStyleDiagram;
  end
  else
  begin
    baseObj := GetObject('GridLineStyleDiagram');
    fGridLineStyleDiagram := TLlDomPropertyGridLineStyle.Create(baseObj);
    baseObj.Free;
    result := fGridLineStyleDiagram;
  end;

end;

procedure TLlDomPropertyGridMode.SetMode(const value: TString);
begin
  SetProperty('Contents', value);
end;

{/TLlDOMPropertyGridMode}
{ TLlDOMPropertyTableArea }
destructor TLlDOMPropertyTableArea.Destroy;
begin
  fDurationCell.Free;
  fEndDateCell.Free;
  fIndexCell.Free;
  fLabelCell.Free;
  fPercentageCompleteCell.Free;
  fStartDateCell.Free;
end;

function TLlDOMPropertyTableArea.GetDurationCell;
var
  baseObj: TLlDOMItem;
begin
  if fDurationCell <> nil then
  begin
    result := fDurationCell;
  end
  else
  begin
    baseObj := GetObject('DurationCell');
    fDurationCell := TLlDOMPropertyCell.Create(baseObj);
    baseObj.Free;
    result := fDurationCell;
  end;
end;

function TLlDOMPropertyTableArea.GetEndDateCell;
var
  baseObj: TLlDOMItem;
begin
  if fEndDateCell <> nil then
  begin
    result := fEndDateCell;
  end
  else
  begin
    baseObj := GetObject('EndDateCell');
    fEndDateCell := TLlDOMPropertyCell.Create(baseObj);
    baseObj.Free;
    result := fEndDateCell;
  end;
end;

function TLlDOMPropertyTableArea.GetIndexCell;
var
  baseObj: TLlDOMItem;
begin
  if fIndexCell <> nil then
  begin
    result := fIndexCell;
  end
  else
  begin
    baseObj := GetObject('IndexCell');
    fIndexCell := TLlDOMPropertyIndexCell.Create(baseObj);
    baseObj.Free;
    result := fIndexCell;
  end;
end;

function TLlDOMPropertyTableArea.GetLabelCell;
var
  baseObj: TLlDOMItem;
begin
  if fLabelCell <> nil then
  begin
    result := fLabelCell;
  end
  else
  begin
    baseObj := GetObject('LabelCell');
    fLabelCell := TLlDOMPropertyLabelCell.Create(baseObj);
    baseObj.Free;
    result := fLabelCell;
  end;
end;

function TLlDOMPropertyTableArea.GetPercentageCompleteCell;
var
  baseObj: TLlDOMItem;
begin
  if fPercentageCompleteCell <> nil then
  begin
    result := fPercentageCompleteCell;
  end
  else
  begin
    baseObj := GetObject('PercentageCompleteCell');
    fPercentageCompleteCell := TLlDOMPropertyCell.Create(baseObj);
    baseObj.Free;
    result := fPercentageCompleteCell;
  end;
end;

function TLlDOMPropertyTableArea.GetStartDateCell;
var
  baseObj: TLlDOMItem;
begin
  if fStartDateCell <> nil then
  begin
    result := fStartDateCell;
  end
  else
  begin
    baseObj := GetObject('StartDateCell');
    fStartDateCell := TLlDOMPropertyCell.Create(baseObj);
    baseObj.Free;
    result := fStartDateCell;
  end;
end;

{ TLlDOMPropertyGanttChartDefinition }
destructor TLlDomPropertyGanttChartDefinition.Destroy;
begin
  fChartArea.Free;
  fFont.Free;
  fHighlightRange.Free;
  fTitleRow.Free;
  fTaskRows.Free;
  fTableArea.Free;
  fSummaryTaskRows.Free;
  fFilling.Free;
end;

function TLlDomPropertyGanttChartDefinition.GetAssumeDayResolution: TString;
begin
  result := GetProperty('AssumeDayResolution');
end;

function TLlDomPropertyGanttChartDefinition.GetBarLabel;
begin
  result := GetProperty('BarLabel');
end;

procedure TLlDomPropertyGanttChartDefinition.SetAssumeDayResolution
  (const value: TString);
begin
  SetProperty('AssumeDayResolution', value);
end;

procedure TLlDomPropertyGanttChartDefinition.SetBarLabel(const value: TString);
begin
  SetProperty('BarLabel', value);
end;

function TLlDomPropertyGanttChartDefinition.GetChartArea;
var
  baseObj: TLlDOMItem;
begin
  if fChartArea <> nil then
  begin
    result := fChartArea;
  end
  else
  begin
    baseObj := GetObject('ChartArea');
    fChartArea := TLlDOMPropertyChartArea.Create(baseObj);
    baseObj.Free;
    result := fChartArea;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetDistanceTop;
begin
  result := GetProperty('DistanceTop');
end;

procedure TLlDomPropertyGanttChartDefinition.SetDuration(const value: TString);
begin
  SetProperty('Duration', value);
end;

function TLlDomPropertyGanttChartDefinition.GetDuration;
begin
  result := GetProperty('Duration');
end;

procedure TLlDomPropertyGanttChartDefinition.SetDistanceTop
  (const value: TString);
begin
  SetProperty('DistanceTop', value);
end;

function TLlDomPropertyGanttChartDefinition.GetStartDate;
begin
  result := GetProperty('StartDate');
end;

procedure TLlDomPropertyGanttChartDefinition.SetStartDate(const value: TString);
begin
  SetProperty('StartDate', value);
end;

function TLlDomPropertyGanttChartDefinition.GetFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling;
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetEndDate;
begin
  result := GetProperty('EndDate');
end;

procedure TLlDomPropertyGanttChartDefinition.SetEndDate(const value: TString);
begin
  SetProperty('EndDate', value);
end;

function TLlDomPropertyGanttChartDefinition.GetFont: TLlDOMPropertyDefaultFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont;
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetGridMode;
begin
  result := GetProperty('GridMode');
end;

procedure TLlDomPropertyGanttChartDefinition.SetGridMode(const value: TString);
begin
  SetProperty('GridMode', value);
end;

function TLlDomPropertyGanttChartDefinition.GetHighlightRange
  : TLlDOMPropertyHighlightRange;
var
  baseObj: TLlDOMItem;
begin
  if fHighlightRange <> nil then
  begin
    result := fHighlightRange;
  end
  else
  begin
    baseObj := GetObject('HighlightRange');
    fHighlightRange := TLlDOMPropertyHighlightRange.Create(baseObj);
    baseObj.Free;
    result := fHighlightRange;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetLinkURL;
begin
  result := GetProperty('LinkURL');
end;

procedure TLlDomPropertyGanttChartDefinition.SetLinkURL(const value: TString);
begin
  SetProperty('LinkURL', value);
end;

function TLlDomPropertyGanttChartDefinition.GetMinHeight;
begin
  result := GetProperty('MinHeight');
end;

procedure TLlDomPropertyGanttChartDefinition.SetMinHeight(const value: TString);
begin
  SetProperty('MinHeight', value);
end;

function TLlDomPropertyGanttChartDefinition.GetPercentageComplete;
begin
  result := GetProperty('PercentageComplete');
end;

procedure TLlDomPropertyGanttChartDefinition.SetPercentageComplete
  (const value: TString);
begin
  SetProperty('PercentageComplete', value);
end;

function TLlDomPropertyGanttChartDefinition.GetSummaryTaskDescription;
begin
  result := GetProperty('SummaryTaskDescription');
end;

procedure TLlDomPropertyGanttChartDefinition.SetSummaryTaskDescription
  (const value: TString);
begin
  SetProperty('SummaryTaskDescription', value);
end;

function TLlDomPropertyGanttChartDefinition.GetSummaryTaskRows;
var
  baseObj: TLlDOMItem;
begin
  if fSummaryTaskRows <> nil then
  begin
    result := fSummaryTaskRows;
  end
  else
  begin
    baseObj := GetObject('SummaryTaskRows');
    fSummaryTaskRows := TLlDOMPropertyTaskRows.Create(baseObj);
    baseObj.Free;
    result := fSummaryTaskRows;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetTaskDescription;
begin
  result := GetProperty('TaskDescription');
end;

procedure TLlDomPropertyGanttChartDefinition.SetTaskDescription
  (const value: TString);
begin
  SetProperty('TaskDescription', value);
end;

function TLlDomPropertyGanttChartDefinition.GetTaskRows;
var
  baseObj: TLlDOMItem;
begin
  if fTaskRows <> nil then
  begin
    result := fTaskRows;
  end
  else
  begin
    baseObj := GetObject('TaskRows');
    fTaskRows := TLlDOMPropertyTaskRows.Create(baseObj);
    baseObj.Free;
    result := fTaskRows;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetTableArea;
var
  baseObj: TLlDOMItem;
begin
  if fTableArea <> nil then
  begin
    result := fTableArea;
  end
  else
  begin
    baseObj := GetObject('TableArea');
    fTableArea := TLlDOMPropertyTableArea.Create(baseObj);
    baseObj.Free;
    result := fTableArea;
  end;
end;

function TLlDomPropertyGanttChartDefinition.GetWrapGrouped;
begin
  result := GetProperty('WrapGrouped');
end;

procedure TLlDomPropertyGanttChartDefinition.SetWrapGrouped
  (const value: TString);
begin
  SetProperty('WrapGrouped', value);
end;

function TLlDomPropertyGanttChartDefinition.GetTitleRow;
var
  baseObj: TLlDOMItem;
begin
  if fTitleRow <> nil then
  begin
    result := fTitleRow;
  end
  else
  begin
    baseObj := GetObject('TitleRow');
    fTitleRow := TLlDOMPropertyTitleRow.Create(baseObj);
    baseObj.Free;
    result := fTitleRow;
  end;
end;

{ TLlDomPropertyAlphaBlendableItem }
function TLlDOMPropertyAlphaBlendableItem.GetAlpha;
begin
  result := GetProperty('Alpha');
end;

procedure TLlDOMPropertyAlphaBlendableItem.SetAlpha(const value: TString);
begin
  SetProperty('Alpha', value);
end;

function TLlDOMPropertyAlphaBlendableItem.GetColor;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyAlphaBlendableItem.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyAlphaBlendableItem.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyAlphaBlendableItem.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

{ TLlDOMPropertyPointer }
function TLlDOMPropertyPointer.GetSize;
begin
  result := GetProperty('Size');
end;

procedure TLlDOMPropertyPointer.SetSize(const value: TString);
begin
  SetProperty('Size', value);
end;

function TLlDOMPropertyPointer.GetColor;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyPointer.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyPointer.GetStyle;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyPointer.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

{ TLlDOMPropertyScaleLimits }
function TLlDOMPropertyScaleLimits.GetValue;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyScaleLimits.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyScaleLimits.GetFitToDistance;
begin
  result := GetProperty('FitToDistance');
end;

procedure TLlDOMPropertyScaleLimits.SetFitToDistance(const value: TString);
begin
  SetProperty('FitToDistance', value);
end;

{ TLlDomPropertyScaleLabels }
destructor TLlDOMPropertyScaleLabels.Destroy;
begin
  fDisplayRange.Free;
  fFont.Free;
  fOutputFormatter.Free;
end;

function TLlDOMPropertyScaleLabels.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyScaleLabels.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyScaleLabels.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyScaleLabels.GetRotated;
begin
  result := GetProperty('Rotated');
end;

procedure TLlDOMPropertyScaleLabels.SetRotated(const value: TString);
begin
  SetProperty('Rotated', value);
end;

function TLlDOMPropertyScaleLabels.GetSizeAdjustment;
begin
  result := GetProperty('SizeAdjustment');
end;

procedure TLlDOMPropertyScaleLabels.SetSizeAdjustment(const value: TString);
begin
  SetProperty('SizeAdjustment', value);
end;

function TLlDOMPropertyScaleLabels.GetAlignment;
begin
  result := GetProperty('Alignment');
end;

procedure TLlDOMPropertyScaleLabels.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

{ TLlDOMPropertyDisplayRange }
function TLlDOMPropertyDisplayRange.GetMax;
begin
  result := GetProperty('Max');
end;

procedure TLlDOMPropertyDisplayRange.SetMax(const value: TString);
begin
  SetProperty('Max', value);
end;

function TLlDOMPropertyDisplayRange.GetMin;
begin
  result := GetProperty('Min');
end;

procedure TLlDOMPropertyDisplayRange.SetMin(const value: TString);
begin
  SetProperty('Min', value);
end;

{ TLlDOMPropertyDistance }
function TLlDOMPropertyDistance.GetAutomatic;
begin
  result := GetProperty('Automatic');
end;

procedure TLlDOMPropertyDistance.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

function TLlDOMPropertyDistance.GetValue;
begin
  result := GetProperty('Value')
end;

procedure TLlDOMPropertyDistance.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertyLabels }
destructor TLlDOMPropertyLabels.Destroy;
begin
  fTextItemList.Free;
end;

function TLlDOMPropertyLabels.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyLabels.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyLabels.GetTextItemList;
begin
  if fTextItemList = nil then
  begin
    fTextItemList := TLlDOMTextItemList.Create(GetObject('List'));
  end;
  result := fTextItemList;
end;

{ TLlDOMPropertyStartValue }
function TLlDOMPropertyStartValue.GetAutomatic;
begin
  result := GetProperty('Automatic');
end;

procedure TLlDOMPropertyStartValue.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

function TLlDOMPropertyStartValue.GetValue;
begin
  result := GetProperty('value');
end;

procedure TLlDOMPropertyStartValue.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertySignalRanges }
destructor TLlDOMPropertySignalRanges.Destroy;
begin
  fSignalItemList.Free;
  fDisplayRange.Free;
end;

function TLlDOMPropertySignalRanges.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertySignalRanges.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertySignalRanges.GetDisplayRange;
var
  baseObj: TLlDOMItem;
begin
  if fDisplayRange <> nil then
  begin
    result := fDisplayRange
  end
  else
  begin
    baseObj := GetObject('DisplayRange');
    fDisplayRange := TLlDOMPropertyDisplayRange.Create(baseObj);
    baseObj.Free;
    result := fDisplayRange;
  end;
end;

function TLlDOMPropertySignalRanges.GetSignalItemList;
begin
  if fSignalItemList = nil then
  begin
    fSignalItemList := TLlDOMSignalItemList.Create(GetObject('List'));
  end;
  result := fSignalItemList;
end;

{ TLlDOMPropertyTextItemBackground }
destructor TLlDOMPropertyTextItemBackground.Destroy;
begin
  fBitmap.Free;
end;

function TLlDOMPropertyTextItemBackground.GetBitmap;
var
  baseObj: TLlDOMItem;
begin
  if fBitmap <> nil then
  begin
    result := fBitmap
  end
  else
  begin
    baseObj := GetObject('Bitmap');
    fBitmap := TLlDOMPropertyBitmap.Create(baseObj);
    baseObj.Free;
    result := fBitmap;
  end;
end;

function TLlDOMPropertyTextItemBackground.GetStyle;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyTextItemBackground.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

function TLlDOMPropertyTextItemBackground.GetColor;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyTextItemBackground.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyTextItemBackground.GetColor2;
begin
  result := GetProperty('Color2');
end;

procedure TLlDOMPropertyTextItemBackground.SetColor2(const value: TString);
begin
  SetProperty('Color2', value);
end;

function TLlDOMPropertyTextItemBackground.GetColor3;
begin
  result := GetProperty('Color3');
end;

procedure TLlDOMPropertyTextItemBackground.SetColor3(const value: TString);
begin
  SetProperty('Color3', value);
end;

function TLlDOMPropertyTextItemBackground.GetPattern;
begin
  result := GetProperty('Pattern');
end;

procedure TLlDOMPropertyTextItemBackground.SetPattern(const value: TString);
begin
  SetProperty('Pattern', value);
end;

{ TLlDOMPropertySignalItem }
function TLlDOMPropertySignalItem.GetMax;
begin
  result := GetProperty('Max');
end;

procedure TLlDOMPropertySignalItem.SetMax(const value: TString);
begin
  SetProperty('Max', value);
end;

function TLlDOMPropertySignalItem.GetMaxColor;
begin
  result := GetProperty('MaxColor');
end;

procedure TLlDOMPropertySignalItem.SetMaxColor(const value: TString);
begin
  SetProperty('MaxColor', value);
end;

function TLlDOMPropertySignalItem.GetMin;
begin
  result := GetProperty('Min');
end;

procedure TLlDOMPropertySignalItem.SetMin(const value: TString);
begin
  SetProperty('Min', value);
end;

function TLlDOMPropertySignalItem.GetMinColor;
begin
  result := GetProperty('MinColor');
end;

procedure TLlDOMPropertySignalItem.SetMinColor(const value: TString);
begin
  SetProperty('MinColor', value);
end;

{ TLlDOMPropertyTextItem }
constructor TLlDOMPropertyTextItem.Create(list: TLlDOMTextItemList);
var
  newTextItem: TLlDOMItem;
begin
  newTextItem := list.NewItem(list.Count);
  inherited Create(newTextItem.fDomHandle);
  list.Add(self);
  newTextItem.Free;
end;

destructor TLlDOMPropertyTextItem.Destroy;
begin
  fBackground.Free;
  fFont.Free;
  fPosition.Free;
  fOutputFormatter.Free;
end;

function TLlDOMPropertyTextItem.GetBackground;
var
  baseObj: TLlDOMItem;
begin
  if fBackground <> nil then
  begin
    result := fBackground
  end
  else
  begin
    baseObj := GetObject('Background');
    fBackground := TLlDOMPropertyTextItemBackground.Create(baseObj);
    baseObj.Free;
    result := fBackground;
  end;
end;

function TLlDOMPropertyTextItem.GetFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyTextItem.GetPosition;
var
  baseObj: TLlDOMItem;
begin
  if fPosition <> nil then
  begin
    result := fPosition
  end
  else
  begin
    baseObj := GetObject('Position');
    fPosition := TLlDOMPropertyPosition.Create(baseObj);
    baseObj.Free;
    result := fPosition;
  end;
end;

function TLlDOMPropertyTextItem.GetCondition;
begin
  result := GetProperty('Condition');
end;

procedure TLlDOMPropertyTextItem.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

function TLlDOMPropertyTextItem.GetContents;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyTextItem.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

function TLlDOMPropertyTextItem.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyTextItem.GetRotation;
begin
  result := GetProperty('Rotation');
end;

procedure TLlDOMPropertyTextItem.SetRotation(const value: TString);
begin
  SetProperty('Rotation', value);
end;

function TLlDOMPropertyTextItem.GetSize;
begin
  result := GetProperty('Size');
end;

procedure TLlDOMPropertyTextItem.SetSize(const value: TString);
begin
  SetProperty('Size', value);
end;

{ TLlDomPropertyScaleLabels }
function TLlDOMPropertyScaleLabels.GetDisplayRange;
var
  baseObj: TLlDOMItem;
begin
  if fDisplayRange <> nil then
  begin
    result := fDisplayRange
  end
  else
  begin
    baseObj := GetObject('DisplayRange');
    fDisplayRange := TLlDOMPropertyDisplayRange.Create(baseObj);
    baseObj.Free;
    result := fDisplayRange;
  end;
end;

function TLlDOMPropertyScaleLabels.GetFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont;
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyDefaultFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

{ TLlDOMPropertyTickmarks }
destructor TLlDOMPropertyTickmarks.Destroy;
begin
  fDisplayRange.Free;
  fDistance.Free;
  fFilling.Free;
end;

function TLlDOMPropertyTickmarks.GetVisible;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyTickmarks.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyTickmarks.GetColor;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyTickmarks.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyTickmarks.GetDetailLevel;
begin
  result := GetProperty('DetailLevel');
end;

procedure TLlDOMPropertyTickmarks.SetDetailLevel(const value: TString);
begin
  SetProperty('DetailLevel', value);
end;

function TLlDOMPropertyTickmarks.GetSubTickPosition;
begin
  result := GetProperty('SubTickPosition');
end;

procedure TLlDOMPropertyTickmarks.SetSubTickPosition(const value: TString);
begin
  SetProperty('SubTickPosition', value);
end;

function TLlDOMPropertyTickmarks.GetTickWidth;
begin
  result := GetProperty('TickWidth');
end;

procedure TLlDOMPropertyTickmarks.SetTickWidth(const value: TString);
begin
  SetProperty('TickWidth', value);
end;

function TLlDOMPropertyTickmarks.GetDisplayRange;
var
  baseObj: TLlDOMItem;
begin
  if fDisplayRange <> nil then
  begin
    result := fDisplayRange
  end
  else
  begin
    baseObj := GetObject('DisplayRange');
    fDisplayRange := TLlDOMPropertyDisplayRange.Create(baseObj);
    baseObj.Free;
    result := fDisplayRange;
  end;
end;

function TLlDOMPropertyTickmarks.GetDistance;
var
  baseObj: TLlDOMItem;
begin
  if fDistance <> nil then
  begin
    result := fDistance
  end
  else
  begin
    baseObj := GetObject('Distance');
    fDistance := TLlDOMPropertyDistance.Create(baseObj);
    baseObj.Free;
    result := fDistance;
  end;
end;

function TLlDOMPropertyTickmarks.GetFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

{ TLlDOMPropertyBackground }

destructor TLlDOMPropertyBackground.Destroy;
begin
  fFilling.Free;
  fFrame.Free;
  fShadow.Free;
  inherited;
end;

function TLlDOMPropertyBackground.GetFilling: TLlDOMPropertyChartFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyBackground.GetFrame: TLlDOMPropertyFrameExt;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrameExt.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMPropertyBackground.GetRounding: TString;
begin
  result := GetProperty('Rounding');
end;

function TLlDOMPropertyBackground.GetShadow: TLlDOMPropertyShadow;
var
  baseObj: TLlDOMItem;
begin
  if fShadow <> nil then
  begin
    result := fShadow
  end
  else
  begin
    baseObj := GetObject('Shadow');
    fShadow := TLlDOMPropertyShadow.Create(baseObj);
    baseObj.Free;
    result := fShadow;
  end;
end;

function TLlDOMPropertyBackground.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyBackground.SetRounding(const value: TString);
begin
  SetProperty('Rounding', value);
end;

procedure TLlDOMPropertyBackground.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

{ TLlDOMPropertyDisplay }

function TLlDOMPropertyDisplay.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMPropertyDisplay.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyDisplay.GetOriginalSize: TString;
begin
  result := GetProperty('OriginalSize');
end;

procedure TLlDOMPropertyDisplay.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMPropertyDisplay.SetIsotropic(const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyDisplay.SetOriginalSize(const value: TString);
begin
  SetProperty('OriginalSize', value);
end;

{ TLlDOMPropertyDefaultColumns }

function TLlDOMPropertyDefaultColumns.GetCount: TString;
begin
  result := GetProperty('Count');
end;

function TLlDOMPropertyDefaultColumns.GetDistance: TString;
begin
  result := GetProperty('Distance');
end;

procedure TLlDOMPropertyDefaultColumns.SetCount(const value: TString);
begin
  SetProperty('Count', value);
end;

procedure TLlDOMPropertyDefaultColumns.SetDistance(const value: TString);
begin
  SetProperty('Distance', value);
end;

{ TLlDOMPropertyVariable }
function TLlDOMPropertyVariable.GetUserVarOptions;
begin
  result := GetProperty('UserVarOptions');
end;

procedure TLlDOMPropertyVariable.SetUserVarOptions(const value: TString);
begin
  SetProperty('UserVarOptions', value);
end;

{TLlDOMPropertyDrawing}
function TLlDOMPropertyDrawing.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyDrawing.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMPropertyDrawing.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

function TLlDOMPropertyDrawing.GetPosition: TString;
begin
  result := GetProperty('Position');
end;

procedure TLlDOMPropertyDrawing.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyDrawing.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMPropertyDrawing.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

procedure TLlDOMPropertyDrawing.SetPosition(const value: TString);
begin
  SetProperty('Position', value);
end;

{/TLlDOMPropertyDrawing}

{ TLlDOMPropertyBitmap }

destructor TLlDOMPropertyBitmap.Destroy;
begin
  fDisplay.Free;
  fFileinfo.Free;
  fVariable.Free;
  inherited;
end;

function TLlDOMPropertyBitmap.GetDisplay: TLlDOMPropertyDisplay;
var
  baseObj: TLlDOMItem;
begin
  if fDisplay <> nil then
  begin
    result := fDisplay
  end
  else
  begin
    baseObj := GetObject('Display');
    fDisplay := TLlDOMPropertyDisplay.Create(baseObj);
    baseObj.Free;
    result := fDisplay;
  end;
end;

function TLlDOMPropertyBitmap.GetFileinfo: TLlDOMPropertyFileInfo;
var
  baseObj: TLlDOMItem;
begin
  if fFileinfo <> nil then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

function TLlDOMPropertyBitmap.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyBitmap.GetMode: TString;
begin
  result := GetProperty('Mode');
end;

function TLlDOMPropertyBitmap.GetVariable: TLlDOMPropertyVariable;
var
  baseObj: TLlDOMItem;
begin
  if fVariable <> nil then
  begin
    result := fVariable
  end
  else
  begin
    baseObj := GetObject('Variable');
    fVariable := TLlDOMPropertyVariable.Create(baseObj);
    baseObj.Free;
    result := fVariable;
  end;
end;

procedure TLlDOMPropertyBitmap.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyBitmap.SetMode(const value: TString);
begin
  SetProperty('Mode', value);
end;

{ TLlDOMPropertyChartFilling }

destructor TLlDOMPropertyChartFilling.Destroy;
begin
  fBitmap.Free;
  inherited;
end;

function TLlDOMPropertyChartFilling.GetBitmap: TLlDOMPropertyBitmap;
var
  baseObj: TLlDOMItem;
begin
  if fBitmap <> nil then
  begin
    result := fBitmap
  end
  else
  begin
    baseObj := GetObject('Bitmap');
    fBitmap := TLlDOMPropertyBitmap.Create(baseObj);
    baseObj.Free;
    result := fBitmap;
  end;
end;

{ TLlDOMPropertyChartTitle }

destructor TLlDOMPropertyChartTitle.Destroy;
begin
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartTitle.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyChartTitle.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartTitle.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

procedure TLlDOMPropertyChartTitle.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMPropertyChartEngineBase }

function TLlDOMPropertyChartEngineBase.GetChartType: TString;
begin
  result := GetProperty('ChartType');
end;

function TLlDOMPropertyChartEngineBase.GetDataMode: TString;
begin
  result := GetProperty('DataMode');
end;

function TLlDOMPropertyChartEngineBase.GetFlat: TString;
begin
  result := GetProperty('Flat');
end;

function TLlDOMPropertyChartEngineBase.GetFrameColor: TString;
begin
  result := GetProperty('FrameColor');
end;

function TLlDOMPropertyChartEngineBase.GetSubTypeIndex: TString;
begin
  result := GetProperty('SubTypeIndex');
end;

function TLlDOMPropertyChartEngineBase.GetLabelAlignment: TString;
begin
  result := GetProperty('LabelAlignment');
end;

procedure TLlDOMPropertyChartEngineBase.SetChartType(const value: TString);
begin
  SetProperty('ChartType', value);
end;

procedure TLlDOMPropertyChartEngineBase.SetLabelAlignment(const value: TString);
begin
  SetProperty('LabelAlignment', value);
end;

procedure TLlDOMPropertyChartEngineBase.SetDataMode(const value: TString);
begin
  SetProperty('DataMode', value);
end;

procedure TLlDOMPropertyChartEngineBase.SetFlat(const value: TString);
begin
  SetProperty('Flat', value);
end;

procedure TLlDOMPropertyChartEngineBase.SetFrameColor(const value: TString);
begin
  SetProperty('FrameColor', value);
end;

procedure TLlDOMPropertyChartEngineBase.SetSubTypeIndex(const value: TString);
begin
  SetProperty('SubTypeIndex', value);

end;

{ TLlDOMPropertyGradient }

function TLlDOMPropertyGradient.GetElevatedBorder: TString;
begin
  result := GetProperty('ElevatedBorder');
end;

function TLlDOMPropertyGradient.GetIntensity: TString;
begin
  result := GetProperty('Intensity');
end;

procedure TLlDOMPropertyGradient.SetElevatedBorder(const value: TString);
begin
  SetProperty('ElevatedBorder', value);
end;

procedure TLlDOMPropertyGradient.SetIntensity(const value: TString);
begin
  SetProperty('Intensity', value);
end;

{ TLlDOMPropertyChartEnginePie3D }

destructor TLlDOMPropertyChartEnginePie3D.Destroy;
begin
  fGradient.Free;
  fXaxis.Free;
  fYAxis.Free;
  inherited;
end;

function TLlDOMPropertyChartEnginePie3D.GetCategoryAxisPie
  : TLlDOMPropertyCategoryAxisPie;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxisPie.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEnginePie3D.GetColorMode: TString;
begin
  result := GetProperty('ColorModePie');
end;

function TLlDOMPropertyChartEnginePie3D.GetGradient: TLlDOMPropertyGradient;
var
  baseObj: TLlDOMItem;
begin
  if fGradient <> nil then
  begin
    result := fGradient
  end
  else
  begin
    baseObj := GetObject('Gradient');
    fGradient := TLlDOMPropertyGradient.Create(baseObj);
    baseObj.Free;
    result := fGradient;
  end;
end;

function TLlDOMPropertyChartEnginePie3D.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEnginePie3D.GetShowSeparatorLines: TString;
begin
  result := GetProperty('ShowSeparatorLines');
end;

function TLlDOMPropertyChartEnginePie3D.GetValueAxisPie3DArray
  : TLlDOMPropertyValueAxisPie3DArray;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYAxis := TLlDOMPropertyValueAxisPie3DArray.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEnginePie3D.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEnginePie3D.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEnginePie3D.SetColorMode(const value: TString);
begin
  SetProperty('ColorModePie', value);
end;

procedure TLlDOMPropertyChartEnginePie3D.SetPerspective(const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEnginePie3D.SetShowSeparatorLines
  (const value: TString);
begin
  SetProperty('ShowSeparatorLines', value);
end;

procedure TLlDOMPropertyChartEnginePie3D.SetXRotation(const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEnginePie3D.SetZRotation(const value: TString);
begin
  SetProperty('ZRotation', value);
end;
{ Report Parameter functions/procedures }

constructor TLlDOMReportParameter.Create(list: TLlDOMReportParameterList);
var
  newReportParameter: TLlDOMItem;
begin
  newReportParameter := list.NewItem(list.Count);
  inherited Create(newReportParameter.fDomHandle);
  list.Add(self);
  newReportParameter.Free;
end;

destructor TLlDOMReportParameter.Destroy;
begin
  fSource.Free;
  inherited;
end;

function TLlDOMReportParameter.GetAllowBlank: TString;
begin
  result := GetProperty('AllowBlank');
end;

procedure TLlDOMReportParameter.SetAllowBlank(const value: TString);
begin
  SetProperty('AllowBlank', value);
end;

function TLlDOMReportParameter.GetAllowMultipleValues: TString;
begin
  result := GetProperty('AllowMultipleValues');
end;

procedure TLlDOMReportParameter.SetAllowMultipleValues(const value: TString);
begin
  SetProperty('AllowMultipleValues', value);
end;

function TLlDOMReportParameter.GetAllowNull: TString;
begin
  result := GetProperty('AllowNull');
end;

procedure TLlDOMReportParameter.SetAllowNull(const value: TString);
begin
  SetProperty('AllowNull', value);
end;

function TLlDOMReportParameter.GetDefaultValue: TString;
begin
  result := GetProperty('DefaultValue');
end;

procedure TLlDOMReportParameter.SetDefaultValue(const value: TString);
begin
  SetProperty('DefaultValue', value);
end;

function TLlDOMReportParameter.GetId: TString;
begin
  result := GetProperty('ID');
end;

function TLlDOMReportParameter.GetIdentifier: TString;
begin
  result := GetProperty('Identifier');
end;

procedure TLlDOMReportParameter.SetIdentifier(const value: TString);
begin
  SetProperty('Identifier', value);
end;

function TLlDOMReportParameter.GetParentId: TString;
begin
  result := GetProperty('ParentId');
end;

procedure TLlDOMReportParameter.SetParentId(const value: TString);
begin
  SetProperty('ParentId', value);
end;

function TLlDOMReportParameter.GetPrompt: TString;
begin
  result := GetProperty('Prompt');
end;

procedure TLlDOMReportParameter.SetPrompt(const value: TString);
begin
  SetProperty('Prompt', value);
end;

function TLlDOMReportParameter.GetTooltip: TString;
begin
  result := GetProperty('ToolTip');
end;

procedure TLlDOMReportParameter.SetTooltip(const value: TString);
begin
  SetProperty('ToolTip', value);
end;

function TLlDOMReportParameter.GetSource: TLlDOMReportParameterSource;
var
  baseObj: TLlDOMItem;
begin
  if fSource <> nil then
  begin
    result := fSource
  end
  else
  begin
    baseObj := GetObject('Source');
    fSource := TLlDOMReportParameterSource.Create(baseObj);
    baseObj.Free;
    result := fSource;
  end;
end;

function TLlDOMReportParameter.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMReportParameter.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMReportParameter.GetControlType: TLlDOMControlType;
begin
  result := TLlDOMControlType(StrToInt(GetProperty('ControlType')));
end;

procedure TLlDOMReportParameter.SetControlType(const value: TLlDOMControlType);
begin
  case ControlType of
    ctrlText:
      begin
        SetProperty('ControlType', '0');
      end;
    ctrlDate:
      begin
        SetProperty('ControlType', '1');
      end;
    ctrlBoolYesNo:
      begin
        SetProperty('ControlType', '2');
      end;
    ctrlBoolTrueFalse:
      begin
        SetProperty('ControlType', '3');
      end;
  end;
end;

function TLlDOMReportParameterSource.GetDisplayFormula: TString;
begin
  result := GetProperty('DisplayFormula');
end;

procedure TLlDOMReportParameterSource.SetDisplayFormula(const value: TString);
begin
  SetProperty('DisplayFormula', value);
end;

function TLlDOMReportParameterSource.GetField: TString;
begin
  result := GetProperty('Field');
end;

procedure TLlDOMReportParameterSource.SetField(const value: TString);
begin
  SetProperty('Field', value);
end;

function TLlDOMReportParameterSource.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

procedure TLlDOMReportParameterSource.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

function TLlDOMReportParameterSource.GetManualItems: TString;
begin
  result := GetProperty('ManualItems');
end;

procedure TLlDOMReportParameterSource.SetManualItems(const value: TString);
begin
  SetProperty('ManualItems', value);
end;

function TLlDOMReportParameterSource.GetSortOrderId: TString;
begin
  result := GetProperty('SortOrderId');
end;

procedure TLlDOMReportParameterSource.SetSortOrderId(const value: TString);
begin
  SetProperty('SortOrderId', value);
end;

function TLlDOMReportParameterSource.GetTableId: TString;
begin
  result := GetProperty('TableID');
end;

procedure TLlDOMReportParameterSource.SetTableId(const value: TString);
begin
  SetProperty('TableID', value);
end;

function TLlDOMReportParameterSource.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter = nil then
  begin
    baseObj := GetObject('OutputFomatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    fOutputFormatter := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
  result := fOutputFormatter
end;

function TLlDOMReportParameterSource.GetSourceType: TLlDOMSourceType;
begin
  result := TLlDOMSourceType(StrToInt(GetProperty('SourceType')));
end;

procedure TLlDOMReportParameterSource.SetSourceType
  (const value: TLlDOMSourceType);
begin
  case SourceType of
    stDatabase:
      begin
        SetProperty('SourceType', '0');
      end;
    stChoice:
      begin
        SetProperty('SourceType', '1');
      end;
    stText:
      begin
        SetProperty('SourceType', '2');
      end;
  end;
end;

function TLlDOMReportParameterSource.GetSourceContentsType
  : TLlDOMSourceContentsType;
begin
  result := TLlDOMSourceContentsType
    (StrToInt(GetProperty('SourceContentsType')));
end;

procedure TLlDOMReportParameterSource.SetSourceContentsType
  (const value: TLlDOMSourceContentsType);
begin
  case value of
    sctText:
      begin
        SetProperty('SourceContentsType', '0');
      end;
    sctBoolean:
      begin
        SetProperty('SourceContentsType', '1');
      end;
    sctNumeric:
      begin
        SetProperty('SourceContentsType', '2');
      end;
    sctDate:
      begin
        SetProperty('SourceContentsType', '3');
      end;
  end;
end;
{ / Report Parameter functions/procedures }

{ TLlDOMReportParameterList }

function TLlDOMReportParameterList.Add(domObj: TLlDOMReportParameter): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMReportParameterList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMReportParameterList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMReportParameterList.GetItems(index: integer)
  : TLlDOMReportParameter;
begin
  result := TLlDOMReportParameter(inherited Items[index]);
end;

procedure TLlDOMReportParameterList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMReportParameter;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMReportParameter.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

function TLlDOMReportParameterList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMReportParameter;
begin
  newDomObj := TLlDOMReportParameter.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'ReportParameter');
  result := newDomObj;

end;

procedure TLlDOMReportParameterList.SetItems(index: integer;
  const value: TLlDOMReportParameter);
begin
  inherited Items[index] := value;
end;

{ TLlDOMPropertyChartEngineFunnelVertical functions/procedures }
destructor TLlDOMPropertyChartEngineFunnelVertical.Destroy;
begin
  fRelativeRadiusOfParallelPart.Free;
  fYAxis.Free;
  fXaxis.Free;
  inherited;
end;

destructor TLlDOMPropertyValueAxisFunnelArray.Destroy;
begin
  fValueAxisFunnel.Free;
  inherited;
end;

procedure TLlDOMPropertyChartEngineFunnelVertical.SetColorMode
  (const value: TString);
begin
  SetProperty('ColorModeFunnel', value);
end;

function TLlDOMPropertyChartEngineFunnelVertical.GetRelativeRadiusOfParallelPart
  : TLlDOMPropertyRelativeRadiusOfParallelPart;
var
  baseObj: TLlDOMItem;
begin
  if fRelativeRadiusOfParallelPart <> nil then
  begin
    result := fRelativeRadiusOfParallelPart
  end
  else
  begin
    baseObj := GetObject('RelativeRadiusOfParallelPart');
    fRelativeRadiusOfParallelPart := TLlDOMPropertyRelativeRadiusOfParallelPart.
      Create(baseObj);
    baseObj.Free;
    result := fRelativeRadiusOfParallelPart;
  end;
end;

function TLlDOMPropertyChartEngineFunnelVertical.GetColorMode: TString;
begin
  result := GetProperty('ColorModeFunnel');
end;

function TLlDOMPropertyValueAxisFunnelArray.GetValueAxisFunnel(index: integer)
  : TLlDOMPropertyValueAxisFunnel;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxisFunnel <> nil then
  begin
    result := fValueAxisFunnel
  end
  else
  begin
    baseObj := GetSubObject(0);
    if baseObj <> nil then
    begin
      fValueAxisFunnel := TLlDOMPropertyValueAxisFunnel.Create(baseObj);
      baseObj.Free;
      result := fValueAxisFunnel;
    end
    else
      result := nil;
  end;

end;

procedure TLlDOMPropertyChartEngineFunnelVertical.SetShowSeparatorLines
  (const value: TString);
begin
  SetProperty('ShowSeparatorLines', value);
end;

function TLlDOMPropertyChartEngineFunnelVertical.GetShowSeparatorLines: TString;
begin
  result := GetProperty('ShowSeparatorLines');
end;

procedure TLlDOMPropertyChartEngineFunnelVertical.SetRelativeRadiusOfStart
  (const value: TString);
begin
  SetProperty('RelativeRadiusOfStart', value);
end;

function TLlDOMPropertyChartEngineFunnelVertical.
  GetRelativeRadiusOfStart: TString;
begin
  result := GetProperty('RelativeRadiusOfStart');
end;

function TLlDOMPropertyChartEngineFunnelVertical.GetCategoryAxisFunnel
  : TLlDOMPropertyCategoryAxisFunnel;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxisFunnel.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyRelativeRadiusOfParallelPart.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyValueAxisFunnel.GetExplosionPercentage: TString;
begin
  result := GetProperty('ExplosionPercentage');
end;

procedure TLlDOMPropertyValueAxisFunnel.SetExplosionPercentage
  (const value: TString);
begin
  SetProperty('ExplosionPercentage', value);
end;

function TLlDOMPropertyValueAxisFunnel.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyValueAxisFunnel.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

procedure TLlDOMPropertyRelativeRadiusOfParallelPart.SetContents
  (const value: TString);
begin
  SetProperty('Contents', value);
end;

function TLlDOMPropertyRelativeRadiusOfParallelPart.
  GetPercentageOfParallelPart: TString;
begin
  result := GetProperty('RelativeRadiusOfParallelPart');
end;

procedure TLlDOMPropertyRelativeRadiusOfParallelPart.SetPercentageOfParallelPart
  (const value: TString);
begin
  SetProperty('RelativeRadiusOfParallelPart', value);
end;

function TLlDOMPropertyValueAxisFunnel.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObjectPie.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;
end;

function TLlDOMPropertyChartEngineFunnelVertical.GetValueAxisFunnelArray
  : TLlDOMPropertyValueAxisFunnelArray;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYAxis := TLlDOMPropertyValueAxisFunnelArray.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

destructor TLlDOMPropertyValueAxisFunnel.Destroy;
begin
  fCoordinateLabelOnObject.Free;
  Inherited;
end;

procedure TLlDOMPropertyCategoryAxisFunnel.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyCategoryAxisFunnel.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyCategoryAxisFunnel.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

function TLlDOMPropertyCategoryAxisFunnel.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

function TLlDOMPropertyCategoryAxisFunnel.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyCategoryAxisFunnel.GetCoordinateLabel
  : TLlDOMPropertyChartLabelCoordinate;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabel <> nil then
  begin
    result := fCoordinateLabel
  end
  else
  begin
    baseObj := GetObject('CoordinateLabel');
    fCoordinateLabel := TLlDOMPropertyChartLabelCoordinate.Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabel;
  end;
end;

function TLlDOMPropertyCategoryAxisFunnel.GetAxisLabel
  : TLlDOMPropertyChartLabel;
var
  baseObj: TLlDOMItem;
begin
  if fAxisLabel <> nil then
  begin
    result := fAxisLabel
  end
  else
  begin
    baseObj := GetObject('Label');
    fAxisLabel := TLlDOMPropertyChartLabel.Create(baseObj);
    baseObj.Free;
    result := fAxisLabel;
  end;
end;

destructor TLlDOMPropertyCategoryAxisFunnel.Destroy;
begin
  fCoordinateLabel.Free;
  fAxisLabel.Free;
  fLabelPlacement.Free;
  Inherited;
end;

{ /TLlDOMPropertyChartEngineFunnelVertical functions/procedures }
{ Collection Variables functions / process}
function TLlDOMListCollectionVariables.GetItems(index: integer): TLlDOMCollectionVariable;
begin
  result := TLlDOMCollectionVariable(inherited Items[index]);
end;

procedure TLlDOMListCollectionVariables.SetItems(index: integer;
  const value: TLlDOMCollectionVariable);
begin
  inherited Items[index] := value;
end;

function TLlDOMListCollectionVariables.Add(domObj: TLlDOMCollectionVariable): integer;
begin
  result := inherited Add(domObj);
  Initialize();
end;

constructor TLlDOMListCollectionVariables.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

function TLlDOMListCollectionVariables.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMCollectionVariable;
begin
  newDomObj := TLlDOMCollectionVariable.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'CollectionVariableCollection');
  result := newDomObj;
  Initialize();
end;

procedure TLlDOMListCollectionVariables.DeleteSubobject(index: integer);
begin
  inherited DeleteSubobject(index);
end;

destructor TLlDOMListCollectionVariables.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TlLDomCollectionVariable.GetNamePrefix: Tstring;
begin
  result := GetProperty('NamePrefix');
end;

procedure TLlDOMCollectionVariable.SetNamePrefix(const value: TString);
begin
  SetProperty('NamePrefix', value);
end;

function TLlDOMCollectionVariable.GetItems: TLlDOMListCollectionVariablesListItems;
begin
  if fItems = nil then
  begin
    fItems := TLlDOMListCollectionVariablesListItems.Create(GetObject('Items'));
  end;
  result := fItems;
end;

destructor TLlDOMCollectionVariable.Destroy;
begin
  fItems.Free;
end;

constructor TLlDOMCollectionVariable.Create
  (list: TLlDOMListCollectionVariables);
var
  newCollectionVariable: TLlDOMItem;
begin
  newCollectionVariable := list.NewItem(list.Count);
  inherited Create(newCollectionVariable.fDomHandle);
  list.Add(self);
  newCollectionVariable.Free;
end;

function TLlDOMListCollectionVariablesListItems.GetItems(index: Integer): TLlDOMCollectionVariableListItem;
begin
    result :=TLlDOMCollectionVariableListItem(inherited Items[index]);
end;

procedure TLlDOMListCollectionVariablesListItems.SetItems(index: integer;
  const value: TLlDOMCollectionVariableListItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMListCollectionVariablesListItems.Add(domObj: TLlDOMCollectionVariableListItem): integer;
begin
  result := inherited Add(domObj);
  Initialize();
end;

constructor TLlDOMListCollectionVariablesListItems.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

function TLlDOMListCollectionVariablesListItems.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMCollectionVariableListItem;
begin
  newDomObj := TLlDOMCollectionVariableListItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'CollectionVariableCollectionItem');
  result := newDomObj;
  Initialize();
end;

procedure TLlDOMListCollectionVariablesListItems.DeleteSubobject(index: integer);
begin
  inherited DeleteSubobject(index);
end;

destructor TLlDOMListCollectionVariablesListItems.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;
function TLlDOMCollectionVariableListItem.GetCondition :TString;
begin
  result := GetProperty('Condition');
end;

procedure TLlDOMCollectionVariableListItem.SetCondition(const value: TString);
begin
  SetProperty('Condition',value);
end;

function TLlDOMCollectionVariableListItem.GetItems: TLlDOMListCollectionVariableColumns;
begin
  if fItems = nil then
  begin
    fItems := TLlDOMListCollectionVariableColumns.Create(GetObject('Items'));
  end;
  result := fItems;
end;
destructor TLlDOMCollectionVariableListItem.Destroy;
begin
  fItems.Free;
end;
function TLlDOMListCollectionVariableColumns.GetItems(index: Integer):TLlDOMCollectionVariableColumn;
begin
   result :=TLlDOMCollectionVariableColumn(inherited Items[index]);
end;


constructor TLlDOMCollectionVariableListItem.Create
  (list: TLlDOMListCollectionVariablesListItems);
var
  newCollectionVariableCollectionItem: TLlDOMItem;
begin
  newCollectionVariableCollectionItem := list.NewItem(list.Count-1);
  inherited Create(newCollectionVariableCollectionItem.fDomHandle);
  list.Add(self);
  newCollectionVariableCollectionItem.Free;
end;

procedure TLlDOMListCollectionVariableColumns.SetItems(index: integer;
  const value: TLlDOMCollectionVariableColumn);
begin
  inherited Items[index] := value;
end;

function TLlDOMListCollectionVariableColumns.Add(domObj: TLlDOMCollectionVariableColumn): integer;
begin
  result := inherited Add(domObj);
  Initialize();
end;

constructor TLlDOMListCollectionVariableColumns.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

function TLlDOMListCollectionVariableColumns.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMCollectionVariableColumn;
begin
  newDomObj := TLlDOMCollectionVariableColumn.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, 'CollectionVariableColumn');
  result := newDomObj;
  Initialize();
end;

procedure TLlDOMListCollectionVariableColumns.DeleteSubobject(index: integer);
begin
  inherited DeleteSubobject(index);
end;

destructor TLlDOMListCollectionVariableColumns.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDomCollectionVariableColumn.GetNamePostfix: TString;
begin
  result := GetProperty('NamePostfix');
end;

procedure TLlDomCollectionVariableColumn.SetNamePostfix(const value: TString);
begin
  SetProperty('NamePostfix',value);
end;

function TLlDomCollectionVariableColumn.GetResult: TString;
begin
  result := GetProperty('Result');
end;

procedure TLlDomCollectionVariableColumn.SetResult(const value: TString);
begin
  SetProperty('Result',value);
end;

constructor TLlDomCollectionVariableColumn.Create
  (list: TLlDOMListCollectionVariableColumns);
var
  newCollectionVariableColumn: TLlDOMItem;
begin
  newCollectionVariableColumn := list.NewItem(list.Count);
  inherited Create(newCollectionVariableColumn.fDomHandle);
  list.Add(self);
  newCollectionVariableColumn.Free;
end;


{/ Collection Variables functions / process}
{ Shapechart functions/procedures }

constructor TLlDOMPropertyManualLegendItem.Create
  (list: TLlDOMPropertyManualLegendsList);
var
  newManualLegend: TLlDOMItem;
begin
  newManualLegend := list.NewItem(list.Count);
  inherited Create(newManualLegend.fDomHandle);
  list.Add(self);
  newManualLegend.Free;
end;


function TLlDOMPropertyManualLegendItem.GetColor :TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyManualLegendItem.GetFormula :TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyManualLegendItem.GetText :TString;
begin
  result := GetProperty('Text');
end;

procedure TLlDOMPropertyManualLegendItem.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyManualLegendItem.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyManualLegendItem.SetText(const value: TString);
begin
  SetProperty('Text', value);
end;

procedure TLlDOMPropertyManualLegendsList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyManualLegendItem;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyManualLegendItem.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

function TLlDOMPropertyManualLegendsList.GetItems(index: integer)
  : TLlDOMPropertyManualLegendItem;
begin
  result := TLlDOMPropertyManualLegendItem(inherited Items[index]);
end;

procedure TLlDOMPropertyManualLegendsList.SetItems(index: integer;
  const value: TLlDOMPropertyManualLegendItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMPropertyManualLegendsList.Add
  (domObj: TLlDOMPropertyManualLegendItem): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMPropertyManualLegendsList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;
  Initialize();
end;

destructor TLlDOMPropertyManualLegendsList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMPropertyManualLegendsList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyManualLegendItem;
begin

  newDomObj := TLlDOMPropertyManualLegendItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'ManualLegend');
  result := newDomObj;

end;

function TLlDOMPropertyShapeItemBase.GetRectangleFrame
  : TLlDOMPropertyRectangleFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyRectangleFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMPropertyShapeItemBase.GetBackground
  : TLlDOMPropertyShapeBackground;
var
  baseObj: TLlDOMItem;
begin
  if fBackground <> nil then
  begin
    result := fBackground
  end
  else
  begin
    baseObj := GetObject('Background');
    fBackground := TLlDOMPropertyShapeBackground.Create(baseObj);
    baseObj.Free;
    result := fBackground;
  end;
end;

function TLlDOMPropertyShapeItemBase.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMPropertyShapeItemBase.GetFileName: TString;
begin
  result := GetProperty('FileName');
end;

function TLlDOMPropertyShapeItemBase.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMPropertyShapeItemBase.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMPropertyShapeItemBase.SetFileName(const value: TString);
begin
  SetProperty('FileName', value);
end;

procedure TLlDOMPropertyShapeItemBase.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

destructor TLlDOMPropertyShapeItemBase.Destroy;
begin
  fFrame.Free;
  fBackground.Free;
  inherited;
end;

function TLlDOMPropertyShapeDefinition.GetProjection: TString;
begin
  result := GetProperty('Projection');
end;

procedure TLlDOMPropertyShapeDefinition.SetProjection(const value: TString);
begin
  SetProperty('Projection', value);
end;

function TLlDOMPropertyShapeDefinition.GetData
  : TLlDOMPropertyShapeDefinitionData;
var
  baseObj: TLlDOMItem;
begin
  if fData <> nil then
  begin
    result := fData
  end
  else
  begin
    baseObj := GetObject('Data');
    fData := TLlDOMPropertyShapeDefinitionData.Create(baseObj);
    baseObj.Free;
    result := fData;
  end;
end;

function TLlDOMPropertyShapeDefinition.GetForegroundShapesList
  : TLlDOMForegroundShapesList;
begin
  if fForegroundShapes = nil then
  begin
    fForegroundShapes := TLlDOMForegroundShapesList.Create
      (GetObject('ForegroundShapes').GetObject('Items'));
  end;
  result := fForegroundShapes;
end;

function TLlDOMPropertyShapeDefinition.GetBackgroundShapesList
  : TLlDOMBackgroundShapesList;
begin
  if fBackgroundShapes = nil then
  begin
    fBackgroundShapes := TLlDOMBackgroundShapesList.Create
      (GetObject('BackgroundShapes').GetObject('Items'));
  end;
  result := fBackgroundShapes;
end;

destructor TLlDOMPropertyShapeDefinition.Destroy;
begin
  fBackgroundShapes.Free;
  fForegroundShapes.Free;
  fData.Free;
  inherited;
end;

procedure TLlDOMForegroundShapesList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyForegroundShapesItem;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyForegroundShapesItem.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

function TLlDOMForegroundShapesList.GetItems(index: integer)
  : TLlDOMPropertyForegroundShapesItem;
begin
  result := TLlDOMPropertyForegroundShapesItem(inherited Items[index]);
end;

procedure TLlDOMForegroundShapesList.SetItems(index: integer;
  const value: TLlDOMPropertyForegroundShapesItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMForegroundShapesList.Add
  (domObj: TLlDOMPropertyForegroundShapesItem): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMForegroundShapesList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;
  Initialize();
end;

destructor TLlDOMForegroundShapesList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMForegroundShapesList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyForegroundShapesItem;
begin

  newDomObj := TLlDOMPropertyForegroundShapesItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Shape');
  result := newDomObj;

end;

procedure TLlDOMBackgroundShapesList.Initialize;

var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyBackgroundShapesItem;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyBackgroundShapesItem.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;

end;

function TLlDOMBackgroundShapesList.GetItems(index: integer)
  : TLlDOMPropertyBackgroundShapesItem;
begin
  result := TLlDOMPropertyBackgroundShapesItem(inherited Items[index]);
end;

procedure TLlDOMBackgroundShapesList.SetItems(index: integer;
  const value: TLlDOMPropertyBackgroundShapesItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMBackgroundShapesList.Add
  (domObj: TLlDOMPropertyBackgroundShapesItem): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMBackgroundShapesList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMBackgroundShapesList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMBackgroundShapesList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyBackgroundShapesItem;
begin
  newDomObj := TLlDOMPropertyBackgroundShapesItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Shape');
  result := newDomObj;

end;

function TLlDOMPropertyShapeDefinitionData.GetCentered: TString;
begin
  result := GetProperty('Centered');
end;

procedure TLlDOMPropertyShapeDefinitionData.SetCentered(const value: TString);
begin
  SetProperty('Centered', value);
end;

function TLlDOMPropertyShapeDefinitionData.GetBoundarySelection
  : TLlDOMPropertyShapeBoundarySelection;
var
  baseObj: TLlDOMItem;
begin
  if fBoundarySelection <> nil then
  begin
    result := fBoundarySelection
  end
  else
  begin
    baseObj := GetObject('BoundarySelection');
    fBoundarySelection := TLlDOMPropertyShapeBoundarySelection.Create(baseObj);
    baseObj.Free;
    result := fBoundarySelection;
  end;
end;

destructor TLlDOMPropertyShapeDefinitionData.Destroy;
begin
  fBoundarySelection.Free;
end;

function TLlDOMPropertyForegroundShapesItem.GetRestrictToDataRegion: TString;
begin
  result := GetProperty('RestrictToDataRegion');
end;

procedure TLlDOMPropertyForegroundShapesItem.SetRestrictToDataRegion
  (const value: TString);
begin
  SetProperty('RestrictToDataRegion', value);
end;

constructor TLlDOMPropertyForegroundShapesItem.Create
  (list: TLlDOMForegroundShapesList);
var
  newForegroundShape: TLlDOMItem;
begin
  newForegroundShape := list.NewItem(list.Count);
  inherited Create(newForegroundShape.fDomHandle);
  list.Add(self);
  newForegroundShape.Free;
end;

constructor TLlDOMPropertyBackgroundShapesItem.Create
  (list: TLlDOMBackgroundShapesList);
var
  newBackgroundShape: TLlDOMItem;
begin
  newBackgroundShape := list.NewItem(list.Count);
  inherited Create(newBackgroundShape.fDomHandle);
  list.Add(self);
  newBackgroundShape.Free;
end;

function TLlDOMPropertyBackgroundShapesItem.GetOffset: TString;
begin
  result := GetProperty('Offset');
end;

procedure TLlDOMPropertyBackgroundShapesItem.SetOffset(const value: TString);
begin
  SetProperty('Offset', value);
end;

function TLlDOMPropertyShapeBackground.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyShapeBackground.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

function TLlDOMPropertyShapeBackground.GetColor: TString;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyShapeBackground.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyRectangleFrame.GetStyle: TString;
begin
  result := GetProperty('Style');
end;

procedure TLlDOMPropertyRectangleFrame.SetStyle(const value: TString);
begin
  SetProperty('Style', value);
end;

function TLlDOMPropertyRectangleFrame.GetColor: TString;
begin
  result := GetProperty('Color');
end;

procedure TLlDOMPropertyRectangleFrame.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyRectangleFrame.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyRectangleFrame.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

function TLlDOMPropertyShapeBoundarySelection.GetIsFormula: TString;
begin
  result := GetProperty('IsFormula');
end;

procedure TLlDOMPropertyShapeBoundarySelection.SetIsFormula
  (const value: TString);
begin
  SetProperty('IsFormula', value);
end;

function TLlDOMPropertyShapeBoundarySelection.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

procedure TLlDOMPropertyShapeBoundarySelection.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

function TLlDOMPropertyShapeBoundarySelection.GetRect: TLlDOMPPropertyRectBase;
var
  baseObj: TLlDOMItem;
begin
  if fRect <> nil then
  begin
    result := fRect
  end
  else
  begin
    baseObj := GetObject('Rect');
    fRect := TLlDOMPPropertyRectBase.Create(baseObj);
    baseObj.Free;
    result := fRect;
  end;
end;

destructor TLlDOMPropertyShapeBoundarySelection.Destroy;
begin
  fRect.Free;
end;

function TLlDOMPPropertyRectBase.GetBottom: TString;
begin
  result := GetProperty('Bottom');
end;

procedure TLlDOMPPropertyRectBase.SetBottom(const value: TString);
begin
  SetProperty('Bottom', value);
end;

function TLlDOMPPropertyRectBase.GetLeft: TString;
begin
  result := GetProperty('Left');
end;

procedure TLlDOMPPropertyRectBase.SetLeft(const value: TString);
begin
  SetProperty('Left', value);
end;

function TLlDOMPPropertyRectBase.GetRight: TString;
begin
  result := GetProperty('Right');
end;

procedure TLlDOMPPropertyRectBase.SetRight(const value: TString);
begin
  SetProperty('Right', value);
end;

function TLlDOMPPropertyRectBase.GetTop: TString;
begin
  result := GetProperty('Top');
end;

procedure TLlDOMPPropertyRectBase.SetTop(const value: TString);
begin
  SetProperty('Top', value);
end;

function TLlDOMPropertyChartEngineShapeFile.GetYAxes
  : TLlDOMPropertyShapeAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyShapeAxisArray.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;

function TLlDOMPropertyChartEngineShapeFile.GetXAxis: TLlDOMPropertyShapeXAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyShapeXAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineShapeFile.GetDefinition
  : TLlDOMPropertyShapeDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('ShapeDefinition');
    fDefinition := TLlDOMPropertyShapeDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

destructor TLlDOMPropertyChartEngineShapeFile.Destroy;
begin
  fXaxis.Free;
  fYaxes.Free;
  fDefinition.Free;
end;

function TLlDOMPropertyShapeAxisArray.GetValueAxis(index: integer)
  : TLlDOMPropertyShapeYAxis;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxis <> nil then
  begin
    result := fValueAxis
  end
  else
  begin
    baseObj := GetSubObject(0);
    if baseObj <> nil then
    begin
      fValueAxis := TLlDOMPropertyShapeYAxis.Create(baseObj);
      baseObj.Free;
      result := fValueAxis;
    end
    else
      result := nil;
  end;
end;

destructor TLlDOMPropertyShapeAxisArray.Destroy;
begin
  fValueAxis.Free;
end;

function TLlDOMPropertyShapeXAxis.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyShapeXAxis.GetAxisLabel: TLlDOMPropertyChartLabel;
var
  baseObj: TLlDOMItem;
begin
  if fAxisLabel <> nil then
  begin
    result := fAxisLabel
  end
  else
  begin
    baseObj := GetObject('Label');
    fAxisLabel := TLlDOMPropertyChartLabel.Create(baseObj);
    baseObj.Free;
    result := fAxisLabel;
  end;
end;

function TLlDOMPropertyShapeXAxis.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

procedure TLlDOMPropertyShapeXAxis.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

function TLlDOMPropertyShapeXAxis.GetShapeAttribute: TString;
begin
  result := GetProperty('ShapeAttribute');
end;

procedure TLlDOMPropertyShapeXAxis.SetShapeAttribute(const value: TString);
begin
  SetProperty('ShapeAttribute', value);
end;

function TLlDOMPropertyShapeXAxis.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyShapeXAxis.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyShapeXAxis.GetCoordinateLabel
  : TLlDOMPropertyChartLabelCoordinate;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabel <> nil then
  begin
    result := fCoordinateLabel
  end
  else
  begin
    baseObj := GetObject('CoordinateLabel');
    fCoordinateLabel := TLlDOMPropertyChartLabelCoordinate.Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabel;
  end;
end;

destructor TLlDOMPropertyShapeXAxis.Destroy;
begin
  fLabelPlacement.Free;
  fAxisLabel.Free;
end;

function TLlDOMPropertyShapeYAxis.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyShapeYAxis.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyShapeYAxis.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObject;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObject.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;

end;

destructor TLlDOMPropertyShapeYAxis.Destroy;
begin
  fCoordinateLabelOnObject.Free;
end;

{ /Shapechart functions/procedures }

{ Donut chart functions/procedures }
destructor TLlDOMPropertyChartEngineDonut.Destroy;
begin
  fXaxis.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineDonut.GetColor: TString;
begin
  result := GetProperty('ColorModePie');
end;

function TLlDOMPropertyChartEngineDonut.GetShowSeparatorLines: TString;
begin
  result := GetProperty('ShowSeparatorLines');
end;

function TLlDOMPropertyChartEngineDonut.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineDonut.SetColor(const value: TString);
begin
  SetProperty('ColorModePie', value);
end;

procedure TLlDOMPropertyChartEngineDonut.SetShowSeparatorLines
  (const value: TString);
begin
  SetProperty('ShowSeparatorLines', value);
end;

procedure TLlDOMPropertyChartEngineDonut.SetZRotation(const value: TString);
begin
  SetProperty('ZRotation', value);
end;

function TLlDOMPropertyChartEngineDonut.GetCategoryAxisPie
  : TLlDOMPropertyCategoryAxisPie;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxisPie.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

Destructor TLlDOMPropertyChartEngineDonut2D.Destroy;
begin
  fYAxis.Free;
end;

function TLlDOMPropertyChartEngineDonut2D.GetInnerRadiusPercentage: TString;
begin
  result := GetProperty('InnerRadiusPercentage');
end;

function TLlDOMPropertyChartEngineDonut2D.GetValueAxisPie2DArray
  : TLlDOMPropertyValueAxisPie2DArray;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYAxis := TLlDOMPropertyValueAxisPie2DArray.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

procedure TLlDOMPropertyChartEngineDonut2D.SetInnerRadiusPercentage
  (const value: TString);
begin
  SetProperty('InnerRadiusPercentage', value);
end;

function TLlDOMPropertyChartEngineDonut3D.GetValueAxisPie3DArray
  : TLlDOMPropertyValueAxisPie3DArray;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYAxis := TLlDOMPropertyValueAxisPie3DArray.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

Destructor TLlDOMPropertyChartEngineDonut3D.Destroy;
begin
  fYAxis.Free;
end;

function TLlDOMPropertyChartEngineDonut3D.GetInnerRadiusPercentage: TString;
begin
  result := GetProperty('InnerRadiusPercentage');
end;

function TLlDOMPropertyChartEngineDonut3D.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

procedure TLlDOMPropertyChartEngineDonut3D.SetInnerRadiusPercentage
  (const value: TString);
begin
  SetProperty('InnerRadiusPercentage', value);
end;

procedure TLlDOMPropertyChartEngineDonut3D.SetXRotation(const value: TString);
begin
  SetProperty('XRotation', value);
end;

{ /Donut chart functions/procedures }

{ TLlDOMPropertyCategoryAxisPie }
destructor TLlDOMPropertyCategoryAxisPie.Destroy;
begin
  fCoordinateLabelOthers.Free;
  fCoordinateLabelPie.Free;
  fLabelPlacement.Free;
  inherited;
end;

function TLlDOMPropertyCategoryAxisPie.GetCoordinateLabelOthers
  : TLlDOMPropertyChartLabelCoordinateOthers;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOthers <> nil then
  begin
    result := fCoordinateLabelOthers
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOthers');
    fCoordinateLabelOthers := TLlDOMPropertyChartLabelCoordinateOthers.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOthers;
  end;
end;

function TLlDOMPropertyCategoryAxisPie.GetCoordinateLabelPie
  : TLlDOMPropertyChartLabelPie;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelPie <> nil then
  begin
    result := fCoordinateLabelPie
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPie');
    fCoordinateLabelPie := TLlDOMPropertyChartLabelPie.Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelPie;
  end;
end;

function TLlDOMPropertyCategoryAxisPie.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyCategoryAxisPie.GetMinimumPercentage: TString;
begin
  result := GetProperty('MinimumPercentage');
end;

function TLlDOMPropertyCategoryAxisPie.GetSamplesForDesigner: TString;
begin
  result := GetProperty('SamplesForDesigner');
end;

function TLlDOMPropertyCategoryAxisPie.GetSorted: TString;
begin
  result := GetProperty('Sorted');
end;

function TLlDOMPropertyCategoryAxisPie.GetValue: TString;
begin
  result := GetProperty('Value');
end;

function TLlDOMPropertyCategoryAxisPie.GetMaxEntriesForArcs: TString;
begin
  result := GetProperty('MaxEntriesForArcs');
end;

procedure TLlDOMPropertyCategoryAxisPie.SetMinimumPercentage
  (const value: TString);
begin
  SetProperty('MinimumPercentage', value);
end;

procedure TLlDOMPropertyCategoryAxisPie.SetSamplesForDesigner
  (const value: TString);
begin
  SetProperty('SamplesForDesigner', value);
end;

procedure TLlDOMPropertyCategoryAxisPie.SetSorted(const value: TString);
begin
  SetProperty('Sorted', value);
end;

procedure TLlDOMPropertyCategoryAxisPie.SetMaxEntriesForArcs(const value: TString);
begin
  SetProperty('MaxEntriesForArcs', value);
end;

procedure TLlDOMPropertyCategoryAxisPie.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertyChartLabelCoordinateOthers }

destructor TLlDOMPropertyChartLabelCoordinateOthers.Destroy;
begin
  fFont.Free;
  fOutputFormatter.Free;
  fLabelPlacement.Free;
  inherited;
end;

function TLlDOMPropertyChartLabelCoordinateOthers.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOthers.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOthers.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOthers.GetContent: TString;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyChartLabelCoordinateOthers.SetContent
  (const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMSubItemChart }

constructor TLlDOMSubItemChart.Create(ChartType: TLlDOMChartType;
  list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'Chart', list.Count);

  case ChartType of
    ctBar2D:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DClustered:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '2';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DStacked:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar2DStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBar3D:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DClustered:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '2';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DStacked:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctBar3DMultiRow:
      begin
        Definition.ChartEngine.ChartType := '1';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctLineMultiRow:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineSimple:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineStacked:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctLineStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '2';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctPie2D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctPie3D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'False';
      end;
    ctAreaSimple:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctAreaStacked:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '3';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctAreaStackedRelative:
      begin
        Definition.ChartEngine.ChartType := '3';
        Definition.ChartEngine.DataMode := '4';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBubbleSorted:
      begin
        Definition.ChartEngine.ChartType := '4';
        Definition.ChartEngine.DataMode := '1';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctBubbleScattered:
      begin
        Definition.ChartEngine.ChartType := '4';
        Definition.ChartEngine.DataMode := '5';
        Definition.ChartEngine.Flat := 'True';
      end;
    ctFunnelVertical:
      begin
        Definition.ChartEngine.ChartType := '5';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
        Definition.ChartEngine.SubTypeIndex := '0';
      end;
    ctFunnelHorizontal:
      begin
        Definition.ChartEngine.ChartType := '5';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
        Definition.ChartEngine.SubTypeIndex := '1';
      end;
    ctDonut2D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
        Definition.ChartEngine.SubTypeIndex := '1';
      end;
    ctDonut3D:
      begin
        Definition.ChartEngine.ChartType := '0';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'False';
        Definition.ChartEngine.SubTypeIndex := '1';
      end;
    ctShapeFile:
      begin
        Definition.ChartEngine.ChartType := '6';
        Definition.ChartEngine.DataMode := '0';
        Definition.ChartEngine.Flat := 'True';
      end;
  end;
end;

destructor TLlDOMSubItemChart.Destroy;
begin
  fBorderDistance.Free;
  fDefinition.Free;
  inherited;
end;

function TLlDOMSubItemChart.GetBorderDistance: TLlDOMPropertyReservedSpace;
var
  baseObj: TLlDOMItem;
begin
  if fBorderDistance <> nil then
  begin
    result := fBorderDistance
  end
  else
  begin
    baseObj := GetObject('BorderDistance');
    fBorderDistance := TLlDOMPropertyReservedSpace.Create(baseObj);
    baseObj.Free;
    result := fBorderDistance;
  end;
end;

function TLlDOMSubItemChart.GetDefinition: TLlDOMPropertyChartDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyChartDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMSubItemChart.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMSubItemChart.GetReserveSpaceForSubtitle: TString;
begin
  result := GetProperty('ReserveSpaceForSubtitle');
end;

function TLlDOMSubItemChart.GetSortOrderId: TString;
begin
  result := GetProperty('SortOrderID');
end;

function TLlDOMSubItemChart.GetSourceTablePath: TString;
begin
  result := GetProperty('SourceTablePath');
end;

procedure TLlDOMSubItemChart.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMSubItemChart.SetReserveSpaceForSubtitle(const value: TString);
begin
  SetProperty('ReserveSpaceForSubtitle', value);
end;

procedure TLlDOMSubItemChart.SetSortOrderId(const value: TString);
begin
  SetProperty('SortOrderID', value);
end;

procedure TLlDOMSubItemChart.SetSourceTablePath(const value: TString);
begin
  SetProperty('SourceTablePath', value);

  if (pos(';', value) > 0) then
  begin
    SetProperty('TableID', copy(value, 0, pos(';', value) - 1));
  end
  else
  begin
    SetProperty('TableID', value);
  end;

end;

{ TLlDOMSubItemGanttChart }
constructor TLlDOMSubItemGanttChart.Create(list: TLlDOMSubItemCoreList);
begin
  inherited Create(list, 'Gantt', list.Count);
end;

destructor TLlDOMSubItemGanttChart.Destroy;
begin
  fDefinition.Free;
  fBorderDistance.Free;
  fBookmark.Free;
  fIndexBookmark.Free;
  inherited;
end;

function TLlDOMSubItemGanttChart.GetSourceTablePath: TString;
begin
  result := GetProperty('SourceTablePath');
end;

procedure TLlDOMSubItemGanttChart.SetSourceTablePath(const value: TString);
begin
  SetProperty('SourceTablePath', value);

  if (pos(';', value) > 0) then
  begin
    SetProperty('TableID', copy(value, 0, pos(';', value) - 1));
  end
  else
  begin
    SetProperty('TableID', value);
  end;

end;

function TLlDOMSubItemGanttChart.GetDefinition
  : TLlDomPropertyGanttChartDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDomPropertyGanttChartDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMSubItemGanttChart.GetBorderDistance: TLlDOMPropertyReservedSpace;
var
  baseObj: TLlDOMItem;
begin
  if fBorderDistance <> nil then
  begin
    result := fBorderDistance
  end
  else
  begin
    baseObj := GetObject('BorderDistance');
    fBorderDistance := TLlDOMPropertyReservedSpace.Create(baseObj);
    baseObj.Free;
    result := fBorderDistance;
  end;
end;

function TLlDOMSubItemGanttChart.GetBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if fBookmark <> nil then
  begin
    result := fBookmark
  end
  else
  begin
    baseObj := GetObject('Bookmark');
    fBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fBookmark;
  end;
end;

function TLlDOMSubItemGanttChart.GetIndexBookmark: TLlDOMPropertyBookmark;
var
  baseObj: TLlDOMItem;
begin
  if fIndexBookmark <> nil then
  begin
    result := fIndexBookmark
  end
  else
  begin
    baseObj := GetObject('IndexBookmark');
    fIndexBookmark := TLlDOMPropertyBookmark.Create(baseObj);
    baseObj.Free;
    result := fIndexBookmark;
  end;
end;

{ TLlDOMPropertyChartLabelPie }
destructor TLlDOMPropertyChartLabelPie.Destroy;
begin
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartLabelPie.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyChartLabelPie.GetFixedFontSize: TString;
begin
  result := GetProperty('FixedFontSize');
end;

function TLlDOMPropertyChartLabelPie.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabelPie.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
end;

procedure TLlDOMPropertyChartLabelPie.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyChartLabelPie.SetFixedFontSize(const value: TString);
begin
  SetProperty('FixedFontSize', value);
end;

{ TLlDOMPropertyValueAxisPie3D }

destructor TLlDOMPropertyValueAxisPie3D.Destroy;
begin
  fCoordinateLabelOnObject.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisPie3D.GetAggregateType: TString;
begin
  result := GetProperty('AggregateType');
end;

function TLlDOMPropertyValueAxisPie3D.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObjectPie.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;
end;

function TLlDOMPropertyValueAxisPie3D.GetExplosionPercentage: TString;
begin
  result := GetProperty('ExplosionPercentage');
end;

function TLlDOMPropertyValueAxisPie3D.GetValue: TString;
begin
  result := GetProperty('Value');
end;

function TLlDOMPropertyValueAxisPie3D.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyValueAxisPie3D.SetAggregateType(const value: TString);
begin
  SetProperty('AggregateType', value);
end;

procedure TLlDOMPropertyValueAxisPie3D.SetExplosionPercentage
  (const value: TString);
begin
  SetProperty('ExplosionPercentage', value);
end;

procedure TLlDOMPropertyValueAxisPie3D.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

procedure TLlDOMPropertyValueAxisPie3D.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TLlDOMPropertyValueAxisPie3DArray }

destructor TLlDOMPropertyValueAxisPie3DArray.Destroy;
begin
  fValueAxisPie3D.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisPie3DArray.GetValueAxisPie3D(index: integer)
  : TLlDOMPropertyValueAxisPie3D;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxisPie3D <> nil then
  begin
    result := fValueAxisPie3D
  end
  else
  begin
    baseObj := GetSubObject(0);
    if baseObj <> nil then
    begin
      fValueAxisPie3D := TLlDOMPropertyValueAxisPie3D.Create(baseObj);
      baseObj.Free;
      result := fValueAxisPie3D;
    end
    else
      result := nil;
  end;
end;

{ TLlDOMPropertyChartLabelCoordinateOnObjectPie }

destructor TLlDOMPropertyChartLabelCoordinateOnObjectPie.Destroy;
begin
  fFilling.Free;
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartLabelCoordinateOnObjectPie.GetFilling
  : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObjectPie.GetFont
  : TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObjectPie.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyChartLabelCoordinateOnObjectPie.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObjectPie.GetPlacement: TString;
begin
  result := GetProperty('Placement');
end;

procedure TLlDOMPropertyChartLabelCoordinateOnObjectPie.SetFormula
  (const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyChartLabelCoordinateOnObjectPie.SetPlacement
  (const value: TString);
begin
  SetProperty('Placement', value);
end;

{ TLlDOMPropertyChartColorArray }

destructor TLlDOMPropertyChartColorArray.Destroy;
var
  i: integer;
begin
  for i := 0 to 11 do
    fColors[i].Free;
  inherited;
end;

function TLlDOMPropertyChartColorArray.GetColors(index: integer)
  : TLlDOMPropertyChartColor;
var
  baseObj: TLlDOMItem;
begin
  if fColors[index] <> nil then
  begin
    result := fColors[index]
  end
  else
  begin
    baseObj := GetSubObject(index);
    fColors[index] := TLlDOMPropertyChartColor.Create(baseObj);
    baseObj.Free;
    result := fColors[index];
  end;
end;

function TLlDOMPropertyChartColorArray.GetEnhancedColorContrast: TString;
begin
  result := GetProperty('EnhancedColorContrast');
end;

procedure TLlDOMPropertyChartColorArray.SetEnhancedColorContrast
  (const value: TString);
begin
  SetProperty('EnhancedColorContrast', value);
end;

{ TLlDOMPropertyChartColor }

function TLlDOMPropertyChartColor.GetColor: TString;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyChartColor.SetColor(const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMChartConditionalColorsList }
function TLlDOMChartConditionalColorsList.GetItems(index: integer)
  : TLlDOMPropertyChartConditionalColor;
begin
  result := TLlDOMPropertyChartConditionalColor(inherited Items[index]);
end;

procedure TLlDOMChartConditionalColorsList.SetItems(index: integer;
  const value: TLlDOMPropertyChartConditionalColor);
begin
  inherited Items[index] := value;
end;

function TLlDOMChartConditionalColorsList.Add
  (domObj: TLlDOMPropertyChartConditionalColor): integer;
begin
  result := inherited Add(domObj);
end;

procedure TLlDOMChartConditionalColorsList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyChartConditionalColor;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyChartConditionalColor.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

constructor TLlDOMChartConditionalColorsList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMChartConditionalColorsList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  inherited;
end;

function TLlDOMChartConditionalColorsList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyChartConditionalColor;
begin
  newDomObj := TLlDOMPropertyChartConditionalColor.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Color');
  result := newDomObj;
end;

{ TLlDOMPropertyChartConditionalColor }

function TLlDOMPropertyChartConditionalColor.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyChartConditionalColor.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

procedure TLlDOMPropertyChartConditionalColor.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMPropertyChartConditionalColor.SetFormula(const value: TString);
begin
  SetProperty('Formula', value);
end;

{ TLlDOMPropertyChartEnginePie2D }

destructor TLlDOMPropertyChartEnginePie2D.Destroy;
begin
  fGradient.Free;
  fYAxis.Free;
  fXaxis.Free;
  inherited;
end;

function TLlDOMPropertyChartEnginePie2D.GetCategoryAxisPie
  : TLlDOMPropertyCategoryAxisPie;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxisPie.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEnginePie2D.GetColorMode: TString;
begin
  result := GetProperty('ColorModePie');
end;

function TLlDOMPropertyChartEnginePie2D.GetGradient: TLlDOMPropertyGradient;
var
  baseObj: TLlDOMItem;
begin
  if fGradient <> nil then
  begin
    result := fGradient
  end
  else
  begin
    baseObj := GetObject('Gradient');
    fGradient := TLlDOMPropertyGradient.Create(baseObj);
    baseObj.Free;
    result := fGradient;
  end;
end;

function TLlDOMPropertyChartEnginePie2D.GetShowSeparatorLines: TString;
begin
  result := GetProperty('ShowSeparatorLines');
end;

function TLlDOMPropertyChartEnginePie2D.GetValueAxisPie2DArray
  : TLlDOMPropertyValueAxisPie2DArray;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYAxis := TLlDOMPropertyValueAxisPie2DArray.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEnginePie2D.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEnginePie2D.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEnginePie2D.SetColorMode(const value: TString);
begin
  SetProperty('ColorModePie', value);
end;

procedure TLlDOMPropertyChartEnginePie2D.SetShowSeparatorLines
  (const value: TString);
begin
  SetProperty('ShowSeparatorLines', value);
end;

procedure TLlDOMPropertyChartEnginePie2D.SetXRotation(const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEnginePie2D.SetZRotation(const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyValueAxisPie2DArray }

destructor TLlDOMPropertyValueAxisPie2DArray.Destroy;
begin
  fValueAxisPie2D.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisPie2DArray.GetValueAxisPie2D(index: integer)
  : TLlDOMPropertyValueAxisPie2D;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxisPie2D <> nil then
  begin
    result := fValueAxisPie2D
  end
  else
  begin
    baseObj := GetSubObject(0);
    if baseObj <> nil then
    begin
      fValueAxisPie2D := TLlDOMPropertyValueAxisPie2D.Create(baseObj);
      baseObj.Free;
      result := fValueAxisPie2D;
    end
    else
      result := nil;
  end;
end;

{ TLlDOMPropertyValueAxisPie2D }

destructor TLlDOMPropertyValueAxisPie2D.Destroy;
begin
  fCoordinateLabelOnObject.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisPie2D.GetAggregateType: TString;
begin
  result := GetProperty('AggregateType');
end;

function TLlDOMPropertyValueAxisPie2D.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObjectPie;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObjectPie.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;
end;

function TLlDOMPropertyValueAxisPie2D.GetExplosionPercentage: TString;
begin
  result := GetProperty('ExplosionPercentage');
end;

function TLlDOMPropertyValueAxisPie2D.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyValueAxisPie2D.SetAggregateType(const value: TString);
begin
  SetProperty('AggregateType', value);
end;

procedure TLlDOMPropertyValueAxisPie2D.SetExplosionPercentage
  (const value: TString);
begin
  SetProperty('ExplosionPercentage', value);
end;

procedure TLlDOMPropertyValueAxisPie2D.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertyChartEngineBar2D }

destructor TLlDOMPropertyChartEngineBar2D.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYaxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar2D.GetFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar2D.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar2D.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2D.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar2D.GetXAxis: TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2D.GetYAxes: TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;

procedure TLlDOMPropertyChartEngineBar2D.SetOrientation(const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar2D.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartSecondValueAxis }

function TLlDOMPropertyChartSecondaryValueAxis.GetAssignment: TString;
begin
  result := GetProperty('Assignment');
end;

function TLlDOMPropertyChartSecondaryValueAxis.GetEnabled: TString;
begin
  result := GetProperty('Enabled');
end;

procedure TLlDOMPropertyChartSecondaryValueAxis.SetAssignment
  (const value: TString);
begin
  SetProperty('Assignment', value);
end;

procedure TLlDOMPropertyChartSecondaryValueAxis.SetEnabled
  (const value: TString);
begin
  SetProperty('Enabled', value);
end;

{ TLlDOMPropertyCategoryAxis }

function TLlDOMPropertyValueAxisBaseMinimal.GetValue: TString;
begin
  result := GetProperty('Value');
end;

function TLlDOMPropertyValueAxisBaseMinimal.GetSourceMode: TString;
begin
  result := GetProperty('SourceMode');
end;

procedure TLlDOMPropertyValueAxisBaseMinimal.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

procedure TLlDOMPropertyValueAxisBaseMinimal.SetSourceMode(const value: TString);
begin
  SetProperty('SourceMode', value);
end;

destructor TLlDOMPropertyCategoryAxisBase.Destroy;
begin
  fCoordinateLabel.Free;
  fLabelPlacement.Free;
  if Assigned(fChartRowList) then
  begin
    fChartRowList.Free;
    fChartRowList := nil;
  end;

  inherited;
end;


function TLlDOMPropertyCategoryAxisBase.GetChartRowList: TLlDOMChartRowList;
begin
  if fChartRowList = nil then
  begin
    fChartRowList := TLlDOMChartRowList.Create(GetObject('Rows'));
  end;
  result := fChartRowList;

end;

function TLlDOMPropertyCategoryAxisBase.GetCoordinateLabel
  : TLlDOMPropertyChartLabelCoordinate;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabel <> nil then
  begin
    result := fCoordinateLabel
  end
  else
  begin
    baseObj := GetObject('CoordinateLabel');
    fCoordinateLabel := TLlDOMPropertyChartLabelCoordinate.Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabel;
  end;
end;


function TLlDOMPropertyCategoryAxis.GetAxisLabel: TLlDOMPropertyChartLabel;
var
  baseObj: TLlDOMItem;
begin
  if fAxisLabel <> nil then
  begin
    result := fAxisLabel
  end
  else
  begin
    baseObj := GetObject('Label');
    fAxisLabel := TLlDOMPropertyChartLabel.Create(baseObj);
    baseObj.Free;
    result := fAxisLabel;
  end;
end;

destructor TLlDOMPropertyCategoryAxis.Destroy;
begin
  fGridLines.Free;
  fAxisLabel.Free;
  inherited;
end;
function TLlDOMPropertyCategoryAxis.GetGridLines: TLlDOMPropertyGridLines;
var
  baseObj: TLlDOMItem;
begin
  if fGridLines <> nil then
  begin
    result := fGridLines
  end
  else
  begin
    baseObj := GetObject('GridLines');
    fGridLines := TLlDOMPropertyGridLines.Create(baseObj);
    baseObj.Free;
    result := fGridLines;
  end;
end;

function TLlDOMPropertyCategoryAxisBase.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyCategoryAxisBase.GetFilter: TString;
begin
  result := GetProperty('Filter');
end;

function TLlDOMPropertyCategoryAxis.GetIntermediateTickCount: TString;
begin
  result := GetProperty('IntermediateTickCount');
end;

function TLlDOMPropertyCategoryAxisBase.GetSamplesForDesigner: TString;
begin
  result := GetProperty('SamplesForDesigner');
end;

function TLlDOMPropertyCategoryAxis.GetSorted: TString;
begin
  result := GetProperty('Sorted');
end;

function TLlDOMPropertyCategoryAxisBase.GetValue: TString;
begin
  result := GetProperty('Value');
end;

function TLlDOMPropertyCategoryAxisBase.GetSourceMode: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyCategoryAxisBase.SetFilter(const value: TString);
begin
  SetProperty('Filter', value);
end;

procedure TLlDOMPropertyCategoryAxisBase.SetSourceMode(const value: TString);
begin
  SetProperty('SourceMode', value);
end;

procedure TLlDOMPropertyCategoryAxis.SetIntermediateTickCount
  (const value: TString);
begin
  SetProperty('IntermediateTickCount', value);
end;

procedure TLlDOMPropertyCategoryAxisBase.SetSamplesForDesigner
  (const value: TString);
begin
  SetProperty('SamplesForDesigner', value);
end;

procedure TLlDOMPropertyCategoryAxis.SetSorted(const value: TString);
begin
  SetProperty('Sorted', value);
end;

procedure TLlDOMPropertyCategoryAxisBase.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

function TLlDOMPropertyCategoryAxis.GetTickmarkColor: TString;
begin
  result := GetProperty('TickmarkColor');
end;

procedure TLlDOMPropertyCategoryAxis.SetTickmarkColor(const value: TString);
begin
  SetProperty('TickmarkColor', value);
end;

function TLlDOMPropertyCategoryAxisXRadar.GetTickmarkColor;
begin
  result := GetProperty('TickmarkColor');
end;

procedure TLlDOMPropertyCategoryAxisXRadar.SetTickmarkColor(const value: TString);
begin
  SetProperty('TickmarkColor', value);
end;

{Treemap}
  function TLlDOMPropertyChartEngineTreeMapClustered.GetZAxes : TLlDOMPropertyValueAxisArrayTreeMap;
   var
  baseObj: TLlDOMItem;
   begin
     if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArrayTreeMap.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

destructor TLlDOMPropertyChartEngineTreeMapSingle.Destroy;
begin
  fYAxes.Free;
  inherited;
end;

destructor TLlDOMPropertyChartEngineTreeMapClustered.Destroy;
begin
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineTreeMapClustered.GetYAxis : TLlDOMPropertyCategoryAxisYTreeMap;
  var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxisYTreeMap.Create(baseObj);
    baseObj.Free;
    result := fYAxis;

  end;
end;

function TLlDOMPropertyChartEngineTreeMapSingle.GetYAxes : TLlDOMPropertyValueAxisArrayTreeMap;
   var
  baseObj: TLlDOMItem;
   begin
     if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyValueAxisArrayTreeMap.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;

destructor TLlDOMPropertyCategoryAxisXTreeMap.Destroy;
begin
  fMaxEntryCount.Free;
  inherited;
end;

procedure TLlDOMPropertyCategoryAxisXTreeMap.SetFixedColorGroup(const value: TString);
begin
  SetProperty('TickmarkColor', value);
end;

function  TLlDOMPropertyCategoryAxisXTreeMap.GetMaxEntryCount:
TLlDOMPropertyMaxEntryCount;
  begin
  if fMaxEntryCount = nil then
  begin
    fMaxEntryCount := TLlDOMPropertyMaxEntryCount.Create
      (GetObject('MaxEntryCount'));
  end;
  result := fMaxEntryCount;
end;


function TLlDOMPropertyCategoryAxisYTreeMap.GetGridLines: TLlDOMPropertyGridLines;
var
  baseObj: TLlDOMItem;
begin
  if fGridLines <> nil then
  begin
    result := fGridLines
  end
  else
  begin
    baseObj := GetObject('GridLines');
    fGridLines := TLlDOMPropertyGridLines.Create(baseObj);
    baseObj.Free;
    result := fGridLines;
  end;
end;

function  TLlDOMPropertyCategoryAxisYTreeMap.GetMaxEntryCount:
TLlDOMPropertyMaxEntryCount;
  begin
  if fMaxEntryCount = nil then
  begin
    fMaxEntryCount := TLlDOMPropertyMaxEntryCount.Create
      (GetObject('MaxEntryCount'));
  end;
  result := fMaxEntryCount;
end;

function TLlDOMPropertyCategoryAxisYTreeMap.GetChartRowList: TLlDOMChartRowList;
begin
  if fChartRowList = nil then
  begin
    fChartRowList := TLlDOMChartRowList.Create(GetObject('Rows'));
  end;
  result := fChartRowList;

end;

Destructor TLlDOMPropertyCategoryAxisYTreeMap.Destroy;
begin
  fGridLines.Free;
  fMaxEntryCount.Free;
  fChartRowList.Free;
    inherited;
end;

function TLlDOMPropertyCategoryAxisXTreeMap.GetRoundLimits;
begin
  raise Exception.Create('NotImplemented');
end;

function TLlDOMPropertyCategoryAxisXTreeMap.GetFixedColorGroup : TString;
begin
      result := GetProperty('FixedColorGroup');
end;

function TLlDOMPropertyValueAxisArrayTreeMap.GetValueAxis(index: integer)
  : TLlDOMPropertyValueAxisTreeMap;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxis <> nil then
  begin
    result := fValueAxis
  end
  else
  begin
    baseObj := GetSubObject(0);
    if baseObj <> nil then
    begin
      fValueAxis := TLlDOMPropertyValueAxisTreeMap.Create(baseObj);
      baseObj.Free;
      result := fValueAxis;
    end
    else
      result := nil;
  end;
end;

destructor TLlDOMPropertyValueAxisArrayTreeMap.Destroy;
begin
  fValueAxis.Free;
  inherited;
end;

destructor TLlDOMPropertyValueAxisTreeMap.Destroy;
begin
  fDrillDownLinks.Free;
  fGridLines.Free;
  fCoordinateLabelOnObject.Free;
  fVisual.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisTreeMap.GetDrillDownLinks: TLlDOMDrillDownLinkList;
begin
  if fDrillDownLinks = nil then
  begin
    fDrillDownLinks := TLlDOMDrillDownLinkList.Create
      (GetObject('DrillDownLinks'));
  end;
  result := fDrillDownLinks;

end;

function TLlDOMPropertyValueAxisTreeMap.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObject;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObject.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;

end;

function TLlDOMPropertyValueAxisTreeMap.GetGridLines: TLlDOMPropertyGridLines;
var
  baseObj: TLlDOMItem;
begin
  if fGridLines <> nil then
  begin
    result := fGridLines
  end
  else
  begin
    baseObj := GetObject('GridLines');
    fGridLines := TLlDOMPropertyGridLines.Create(baseObj);
    baseObj.Free;
    result := fGridLines;
  end;
end;

procedure TLlDOMPropertyValueAxisTreeMap.SetFixedColorGroup(const value: TString);
begin
  SetProperty('FixedColorGroup', value);
end;


function TLlDOMPropertyValueAxisTreeMap.GetFixedColorGroup : TString;
begin
    result := GetProperty('FixedColorGroup');
end;

function TLlDOMPropertyValueAxisTreeMap.GetVisual : TLlDOMPropertyVisual;
var
  baseObj: TLlDOMItem;
begin
    if fVisual <> nil then
  begin
    result := fVisual
  end
  else
  begin
    baseObj := GetObject('Visual');
    fVisual := TLlDOMPropertyVisual.
      Create(baseObj);
    baseObj.Free;
    result := fVisual;
  end;
end;

destructor TLlDOMPropertyChartEngineTreeMapBase.Destroy;
begin
  fFilling.Free;
  fXAxis.Free;
  inherited;
end;
function TLlDOMPropertyChartEngineTreeMapBase.GetFilling : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;

end;

function TLlDOMPropertyChartEngineTreeMapBase.GetXAxis : TLlDOMPropertyCategoryAxisXTreeMap;
  var
  baseObj: TLlDOMItem;
begin
  if fXAxis <> nil then
  begin
    result := fXAxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXAxis := TLlDOMPropertyCategoryAxisXTreeMap.Create(baseObj);
    baseObj.Free;
    result := fXAxis;

  end;
end;

procedure TLlDOMPropertyChartEngineTreeMapBase.SetTreemapAlgorithm(const value: TString);
begin
     SetProperty('TreemapAlgorithm', value);
end;

procedure TLlDOMPropertyChartEngineTreeMapBase.SetTreemapLightFactor(const value: TString);
begin
     SetProperty('TreemapLightFactor', value);
end;

function TLlDOMPropertyChartEngineTreeMapBase.GetTreemapAlgorithm : TString;
begin
       result := GetProperty('TreemapAlgorithm');
end;

function TLlDOMPropertyChartEngineTreeMapBase.GetTreemapLightFactor : TString;
begin
       result := GetProperty('TreemapLightFactor');
end;
{\Treemap}
function TLlDOMPropertyCategoryAxisXRadar.GetGridLines: TLlDOMPropertyGridLines;
var
  baseObj: TLlDOMItem;
begin
  if fGridLines <> nil then
  begin
    result := fGridLines
  end
  else
  begin
    baseObj := GetObject('GridLines');
    fGridLines := TLlDOMPropertyGridLines.Create(baseObj);
    baseObj.Free;
    result := fGridLines;
  end;
end;


destructor TLlDOMPropertyCategoryAxisXRadar.Destroy;
begin
  fGridLines.Free;
end;

function TLlDOMPropertyCategoryAxisYRadar.GetSorted: TString;
begin
  result := GetProperty('Sorted');
end;

procedure TLlDOMPropertyCategoryAxisYRadar.SetSorted(const value: TString);
begin
  SetProperty('Sorted', value);
end;

destructor TLlDOMPropertyChartEngineRadar.Destroy;
  begin
    fYAxis.Free;
    FZAxes.Free;
     inherited;
  end;
  destructor  TLlDOMPropertyChartEngineRadarBase.Destroy;
  begin
    fFilling.Free;
    fXAxis.Free;
     inherited;
  end;

  destructor TLlDOMPropertyChartEngineRadarSimple.Destroy;
  begin
    fYAxes.Free;
      inherited;
  end;

 function TLlDOMPropertyChartEngineRadarBase.GetRadarCenterMinimumValue: TString;
 begin
   result := GetProperty('RadarCenterMinimumValue');
 end;

 function  TLlDOMPropertyChartEngineRadarBase.GetRadarCircularMode: TString;
 begin
   result := GetProperty('RadarCircularMode');
 end;

 function  TLlDOMPropertyChartEngineRadarBase.GetRadarForceAutoZeroValues: TString;
 begin
    result := GetProperty('RadarForceAutoZeroValues');
 end;

 function  TLlDOMPropertyChartEngineRadarBase.GetRadarForceCentered: TString;
 begin
    result := GetProperty('RadarForceCentered');
 end;

 function  TLlDOMPropertyChartEngineRadarBase.GetRadarRotateClockwise: TString;
 begin
    result := GetProperty('RadarRotateClockwise');
 end;

 function  TLlDOMPropertyChartEngineRadarBase.GetRadarRotationDelta: TString;
 begin
    result := GetProperty('RadarRotationDelta');
 end;

function TLlDOMPropertyChartEngineRadarBase.GetFilling
  : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

  function TLlDOMPropertyChartEngineRadarBase.GetXAxis: TLlDOMPropertyCategoryAxisXRadar;
  var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxisXRadar.Create(baseObj);
    baseObj.Free;
    result := fXaxis;

  end;
end;


  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarCenterMinimumValue(const value: TString);
  begin
     SetProperty('RadarCenterMinimumValue',value);
  end;

  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarCircularMode(const value: TString);
  begin
     SetProperty('RadarCircularMode',value);
  end;

  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarForceAutoZeroValues(const value: TString);
  begin
     SetProperty('RadarForceAutoZeroValues',value);
  end;

  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarForceCentered(const value: TString);
  begin
     SetProperty('RadarForceCentered',value);
  end;

  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarRotateClockwise(const value: TString);
  begin
     SetProperty('RadarRotateClockwise',value);
  end;

  procedure TLlDOMPropertyChartEngineRadarBase.SetRadarRotationDelta(const value: TString);
  begin
     SetProperty('RadarRotationDelta',value);
  end;

  function TLlDOMPropertyChartEngineRadar.GetYAxis;
  var
  baseObj: TLlDOMItem;
    begin
    if fYaxis <> nil then
    begin
      result := fYaxis
    end
    else
    begin
      baseObj := GetObject('YAxis');
      fYaxis := TLlDOMPropertyCategoryAxisYRadar.Create(baseObj);
      baseObj.Free;
      result := fYaxis;

    end;
  end;


  function TLlDOMPropertyChartEngineRadar.GetZAxes: TLlDOMPropertyValueAxisArray;
  var
    baseObj: TLlDOMItem;
  begin
    if fZAxes <> nil then
    begin
      result := fZAxes
    end
    else
    begin
      baseObj := GetObject('ZAxes');
      fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
      baseObj.Free;
      result := fZAxes;
    end;
  end;


function TLlDOMPropertyChartEngineRadarSimple.GetYAxes : TLlDOMPropertyValueAxisArray;
   var
  baseObj: TLlDOMItem;
   begin
     if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;


{ TLlDOMPropertyChartLabelCoordinate }

destructor TLlDOMPropertyChartLabelCoordinate.Destroy;
begin
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartLabelCoordinate.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyChartLabelCoordinate.GetFixedFontSize: TString;
begin
  result := GetProperty('FixedFontSize');
end;

function TLlDOMPropertyChartLabelCoordinate.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabelCoordinate.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyChartLabelCoordinate.GetRotation: TString;
begin
  result := GetProperty('Rotation');
end;

procedure TLlDOMPropertyChartLabelCoordinate.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyChartLabelCoordinate.SetFixedFontSize
  (const value: TString);
begin
  SetProperty('FixedFontSize', value);
end;

procedure TLlDOMPropertyChartLabelCoordinate.SetRotation(const value: TString);
begin
  SetProperty('Rotation', value);
end;

{ TLlDOMPropertyChartLabel }

destructor TLlDOMPropertyChartLabel.Destroy;
begin
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartLabel.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyChartLabel.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabel.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyChartLabel.GetRotation: TString;
begin
  result := GetProperty('Rotation');
end;

procedure TLlDOMPropertyChartLabel.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyChartLabel.SetRotation(const value: TString);
begin
  SetProperty('Rotation', value);
end;

{ TLlDOMPropertyValueAxisArray }

function TLlDOMPropertyValueAxisArrayLine.GetValueAxis(index: integer)
  : TLlDOMPropertyValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxis[index] <> nil then
  begin
    result := fValueAxis[index]
  end
  else
  begin
    baseObj := GetSubObject(index);
    if baseObj <> nil then
    begin
      fValueAxis[index] := TLlDOMPropertyValueAxis.Create(baseObj);
      baseObj.Free;
      result := fValueAxis[index];
    end
    else
      result := nil;
  end;
end;


destructor TLlDOMPropertyValueAxisArrayLine.Destroy;
var
  i: integer;
begin
  for i := 0 to 1 do
    if Assigned(fValueAxis[i]) then
      fValueAxis[i].Free;
  inherited;
end;

destructor TLlDOMPropertyValueAxisArray.Destroy;
var
  i: integer;
begin
  for i := 0 to 1 do
    if Assigned(fValueAxis[i]) then
      fValueAxis[i].Free;
  inherited;
end;

function TLlDOMPropertyValueAxisArray.GetValueAxis(index: integer)
  : TLlDOMPropertyValueAxisBase;
var
  baseObj: TLlDOMItem;
begin
  if fValueAxis[index] <> nil then
  begin
    result := fValueAxis[index]
  end
  else
  begin
    baseObj := GetSubObject(index);
    if baseObj <> nil then
    begin
      fValueAxis[index] := TLlDOMHelper.SafeValueAxisCast
        (TLlDOMPropertyValueAxisBase.Create(baseObj));
      baseObj.Free;
      result := fValueAxis[index];
    end
    else
      result := nil;
  end;
end;

{ TLlDOMPropertyValueAxis }

destructor TLlDOMPropertyValueAxis.Destroy;
begin
  fMax.Free;
  fMin.Free;
  fVisual.Free;
  inherited;
end;

function TLlDOMPropertyValueAxis.GetAggregateType: TString;
begin
  result := GetProperty('AggregateType');
end;

function TLlDOMPropertyValueAxis.GetAxisScale: TString;
begin
  result := GetProperty('AxisScale');
end;

function TLlDOMPropertyValueAxis.GetMax: TLlDOMPropertyRange;
var
  baseObj: TLlDOMItem;
begin
  if fMax <> nil then
  begin
    result := fMax
  end
  else
  begin
    baseObj := GetObject('Max');
    fMax := TLlDOMPropertyRange.Create(baseObj);
    baseObj.Free;
    result := fMax;
  end;
end;

function TLlDOMPropertyValueAxis.GetMin: TLlDOMPropertyRange;
var
  baseObj: TLlDOMItem;
begin
  if fMin <> nil then
  begin
    result := fMin
  end
  else
  begin
    baseObj := GetObject('Min');
    fMin := TLlDOMPropertyRange.Create(baseObj);
    baseObj.Free;
    result := fMin;
  end;
end;

function TLlDOMPropertyValueAxis.GetVisual: TLlDOMPropertyVisual;
  var
  baseObj: TLlDOMItem;
begin
    if fVisual <> nil then
  begin
    result := fVisual
  end
  else
  begin
    baseObj := GetObject('Visual');
    fVisual := TLlDOMPropertyVisual.
      Create(baseObj);
    baseObj.Free;
    result := fVisual;
  end;
end;

function TLlDOMPropertyValueAxis.GetSignalRanges : TLlDOMPropertySignalRanges;
var
  baseObj: TLlDOMItem;
begin
  if fSignalRanges <> nil then
  begin
    result := fSignalRanges
  end
  else
  begin
    baseObj := GetObject('SignalRanges');
    fSignalRanges := TLlDOMPropertySignalRanges.Create(baseObj);
    baseObj.Free;
    result := fSignalRanges;
  end;
end;

function TLlDOMPropertyValueAxis.GetVisualSym: TString;
begin
  result := GetProperty('VisualSym');
end;

procedure TLlDOMPropertyValueAxis.SetVisualSym(const value: TString);
begin
  SetProperty('VisualSym', value);
end;

function TLlDOMPropertyValueAxis.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMPropertyValueAxis.SetAggregateType(const value: TString);
begin
  SetProperty('AggregateType', value);
end;

procedure TLlDOMPropertyValueAxis.SetAxisScale(const value: TString);
begin
  SetProperty('AxisScale', value);
end;

procedure TLlDOMPropertyValueAxis.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

{ TLlDOMPropertyChartLabelCoordinateOnObject }

destructor TLlDOMPropertyChartLabelCoordinateOnObject.Destroy;
begin
  fFilling.Free;
  fFont.Free;
  fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyChartLabelCoordinateOnObject.GetFilling
  : TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObject.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if fFont <> nil then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObject.GetFormula: TString;
begin
  result := GetProperty('Formula');
end;

function TLlDOMPropertyChartLabelCoordinateOnObject.GetOutputFormatter
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter <> nil then
  begin
    result := fOutputFormatter
  end
  else
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    result := fOutputFormatter;
  end;
end;

function TLlDOMPropertyChartLabelCoordinateOnObject.GetPlacement: TString;
begin
  result := GetProperty('Placement');
end;

procedure TLlDOMPropertyChartLabelCoordinateOnObject.SetFormula
  (const value: TString);
begin
  SetProperty('Formula', value);
end;

procedure TLlDOMPropertyChartLabelCoordinateOnObject.SetPlacement
  (const value: TString);
begin
  SetProperty('Placement', value);
end;

{ TLlDOMPropertyGridLines }

function TLlDOMPropertyGridLines.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMPropertyGridLines.GetVisible: TString;
begin
  result := GetProperty('Visible');
end;

procedure TLlDOMPropertyGridLines.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

function TLlDOMPropertyGridLines.GetLineType: TString;
begin
  result := GetProperty('LineType');
end;

procedure TLlDOMPropertyGridLines.SetLineType(const value: TString);
begin
  SetProperty('LineType', value);
end;

procedure TLlDOMPropertyGridLines.SetVisible(const value: TString);
begin
  SetProperty('Visible', value);
end;

{ TLlDOMPropertyRange }

function TLlDOMPropertyRange.GetAutomatic: TString;
begin
  result := GetProperty('Automatic');
end;

function TLlDOMPropertyRange.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyRange.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

procedure TLlDOMPropertyRange.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertyGetSignalRanges }

function TLlDOMPropertyGetSignalRanges.GetAutomatic: TString;
begin
  result := GetProperty('Automatic');
end;

function TLlDOMPropertyGetSignalRanges.GetDistance: TString;
begin
  result := GetProperty('Distance');
end;

procedure TLlDOMPropertyGetSignalRanges.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

procedure TLlDOMPropertyGetSignalRanges.SetDistance(const value: TString);
begin
  SetProperty('Distance', value);
end;

{ TLlDOMPropertyChartEngineBar2DClustered }

destructor TLlDOMPropertyChartEngineBar2DClustered.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DClustered.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineBar2DClustered.SetOrientation
  (const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar2DClustered.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineBar2DStacked }

destructor TLlDOMPropertyChartEngineBar2DStacked.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStacked.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineBar2DStacked.SetOrientation
  (const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar2DStacked.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineBar2DStackedRelative }

destructor TLlDOMPropertyChartEngineBar2DStackedRelative.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.
  GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar2DStackedRelative.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineBar2DStackedRelative.SetOrientation
  (const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar2DStackedRelative.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineBar3D }

destructor TLlDOMPropertyChartEngineBar3D.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYaxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar3D.GetFilling: TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar3D.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyChartEngineBar3D.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar3D.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEngineBar3D.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3D.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar3D.GetXAxis: TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3D.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEngineBar3D.GetYAxes: TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;

function TLlDOMPropertyChartEngineBar3D.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineBar3D.SetIsotropic(const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyChartEngineBar3D.SetOrientation(const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar3D.SetPerspective(const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEngineBar3D.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

procedure TLlDOMPropertyChartEngineBar3D.SetXRotation(const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEngineBar3D.SetZRotation(const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyChartEngineBar3DClustered }

destructor TLlDOMPropertyChartEngineBar3DClustered.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetColorMode: TString;
begin
  result := GetProperty('ColorMode');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

function TLlDOMPropertyChartEngineBar3DClustered.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetColorMode
  (const value: TString);
begin
  SetProperty('ColorMode', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetIsotropic
  (const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetOrientation
  (const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetPerspective
  (const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetXRotation
  (const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DClustered.SetZRotation
  (const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyChartEngineBar3DStacked }

destructor TLlDOMPropertyChartEngineBar3DStacked.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStacked.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineBar3DStacked.SetIsotropic
  (const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStacked.SetPerspective
  (const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStacked.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStacked.SetXRotation
  (const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStacked.SetZRotation
  (const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyChartEngineBar3DStackedRelative }

destructor TLlDOMPropertyChartEngineBar3DStackedRelative.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.
  GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

function TLlDOMPropertyChartEngineBar3DStackedRelative.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineBar3DStackedRelative.SetIsotropic
  (const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStackedRelative.SetPerspective
  (const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStackedRelative.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStackedRelative.SetXRotation
  (const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DStackedRelative.SetZRotation
  (const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyChartEngineBar3DMultiRow }

destructor TLlDOMPropertyChartEngineBar3DMultiRow.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetIsotropic: TString;
begin
  result := GetProperty('Isotropic');
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetPerspective: TString;
begin
  result := GetProperty('Perspective');
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetXRotation: TString;
begin
  result := GetProperty('XRotation');
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

function TLlDOMPropertyChartEngineBar3DMultiRow.GetZRotation: TString;
begin
  result := GetProperty('ZRotation');
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetIsotropic
  (const value: TString);
begin
  SetProperty('Isotropic', value);
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetOrientation
  (const value: TString);
begin
  SetProperty('Orientation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetPerspective
  (const value: TString);
begin
  SetProperty('Perspective', value);
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetXRotation
  (const value: TString);
begin
  SetProperty('XRotation', value);
end;

procedure TLlDOMPropertyChartEngineBar3DMultiRow.SetZRotation
  (const value: TString);
begin
  SetProperty('ZRotation', value);
end;

{ TLlDOMPropertyChartEngineLineSimple }

destructor TLlDOMPropertyChartEngineLineSimple.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYaxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineLineSimple.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineLineSimple.GetLinearAxis: TString;
begin
  result := GetProperty('LinearAxis');
end;

function TLlDOMPropertyChartEngineLineSimple.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineSimple.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineLineSimple.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineLineSimple.GetYAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fYaxes <> nil then
  begin
    result := fYaxes
  end
  else
  begin
    baseObj := GetObject('YAxes');
    fYaxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fYaxes;
  end;
end;

procedure TLlDOMPropertyChartEngineLineSimple.SetLinearAxis
  (const value: TString);
begin
  SetProperty('LinearAxis', value);
end;

procedure TLlDOMPropertyChartEngineLineSimple.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineLineMultiRow }

destructor TLlDOMPropertyChartEngineLineMultiRow.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetLinearAxis: TString;
begin
  result := GetProperty('LinearAxis');
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineMultiRow.GetZAxes
  : TLlDOMPropertyValueAxisArrayLine;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArrayLine.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineLineMultiRow.SetLinearAxis
  (const value: TString);
begin
  SetProperty('LinearAxis', value);
end;

procedure TLlDOMPropertyChartEngineLineMultiRow.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineLineStacked }

destructor TLlDOMPropertyChartEngineLineStacked.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineLineStacked.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineLineStacked.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStacked.GetUseLightEffect: TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineLineStacked.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStacked.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStacked.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineLineStacked.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMPropertyChartEngineLineStackedRelative }

destructor TLlDOMPropertyChartEngineLineStackedRelative.Destroy;
begin
  fFilling.Free;
  fSecondaryValueAxis.Free;
  fXaxis.Free;
  fYAxis.Free;
  fZAxes.Free;
  inherited;
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetFilling
  : TLlDOMPropertyTextFilling;
var
  baseObj: TLlDOMItem;
begin
  if fFilling <> nil then
  begin
    result := fFilling
  end
  else
  begin
    baseObj := GetObject('Filling');
    fFilling := TLlDOMPropertyTextFilling.Create(baseObj);
    baseObj.Free;
    result := fFilling;
  end;
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetSecondaryValueAxis
  : TLlDOMPropertyChartSecondaryValueAxis;
var
  baseObj: TLlDOMItem;
begin
  if fSecondaryValueAxis <> nil then
  begin
    result := fSecondaryValueAxis
  end
  else
  begin
    baseObj := GetObject('SecondaryValueAxis');
    fSecondaryValueAxis := TLlDOMPropertyChartSecondaryValueAxis.Create
      (baseObj);
    baseObj.Free;
    result := fSecondaryValueAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetUseLightEffect
  : TString;
begin
  result := GetProperty('UseLightEffect');
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetXAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fXaxis <> nil then
  begin
    result := fXaxis
  end
  else
  begin
    baseObj := GetObject('XAxis');
    fXaxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fXaxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetYAxis
  : TLlDOMPropertyCategoryAxis;
var
  baseObj: TLlDOMItem;
begin
  if fYAxis <> nil then
  begin
    result := fYAxis
  end
  else
  begin
    baseObj := GetObject('YAxis');
    fYAxis := TLlDOMPropertyCategoryAxis.Create(baseObj);
    baseObj.Free;
    result := fYAxis;
  end;
end;

function TLlDOMPropertyChartEngineLineStackedRelative.GetZAxes
  : TLlDOMPropertyValueAxisArray;
var
  baseObj: TLlDOMItem;
begin
  if fZAxes <> nil then
  begin
    result := fZAxes
  end
  else
  begin
    baseObj := GetObject('ZAxes');
    fZAxes := TLlDOMPropertyValueAxisArray.Create(baseObj);
    baseObj.Free;
    result := fZAxes;
  end;
end;

procedure TLlDOMPropertyChartEngineLineStackedRelative.SetUseLightEffect
  (const value: TString);
begin
  SetProperty('UseLightEffect', value);
end;

{ TLlDOMTableFieldDesignerObject }

constructor TLlDOMTableFieldDesignerObject.Create(objectName: TString;
  list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'LLX:' + objectName, list.Count);
end;

function TLlDOMTableFieldDesignerObject.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

procedure TLlDOMTableFieldDesignerObject.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

{ TLlDOMObjectDesignerObject }

constructor TLlDOMObjectDesignerObject.Create(objectName: TString;
  list: TLlDOMObjectList);
begin
  inherited Create(list, objectName, list.Count);
end;

constructor TLlDOMObjectDesignerObject.Create(objectName: TString;
  list: TLlDOMObjectList; index: integer);
begin
  inherited Create(list, objectName, index);
end;

{ TLlDOMTableFieldChart }
destructor TLlDOMTableFieldChart.Destroy;
begin
  fDefinition.Free;
end;

constructor TLlDOMTableFieldChart.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'Chart', list.Count);
end;

function TLlDOMTableFieldChart.GetDefinition: TLlDOMPropertyChartDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyChartDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMTableFieldChart.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldChart.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMTableFieldChart.GetSourceTablePath: TString;
begin
  result := GetProperty('SourceTablePath');
end;

procedure TLlDOMTableFieldChart.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldChart.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMTableFieldChart.SetSourceTablePath(const value: TString);
begin
  SetProperty('SourceTablePath', value);
end;

{ TLlDOMPropertyFieldWrapping }

function TLlDOMPropertyFieldWrapping.GetFlowControl: TString;
begin
  result := GetProperty('FlowControl');
end;

function TLlDOMPropertyFieldWrapping.GetForce: TString;
begin
  result := GetProperty('Force');
end;

function TLlDOMPropertyFieldWrapping.GetLine: TString;
begin
  result := GetProperty('Line');
end;

procedure TLlDOMPropertyFieldWrapping.SetFlowControl(const value: TString);
begin
  SetProperty('FlowControl', value);
end;

procedure TLlDOMPropertyFieldWrapping.SetForce(const value: TString);
begin
  SetProperty('Force', value);
end;

procedure TLlDOMPropertyFieldWrapping.SetLine(const value: TString);
begin
  SetProperty('Line', value);
end;

function TLlDOMPropertyLineSmoothing.GetSmoothingType:TString;
begin
  result := GetProperty('SmoothingType');
end;

procedure TLlDOMPropertyLineSmoothing.SetSmoothingType(const value: TString);
begin
  SetProperty('SmoothingType', value);
end;

function TLlDOMPropertyLineSmoothing.GetMaximumSupportPoints: TString;
begin
  result:= GetProperty('MaximumSupportPoints');
end;

procedure  TLlDOMPropertyLineSmoothing.SetMaximumSupportPoints(const value: TString);
begin
  SetProperty('MaximumSupportPoints', value);
end;

destructor TLlDOMPropertyVisual.Destroy;
begin
  fLineSmoothing.Free;
  Inherited;
end;
function TLlDOMPropertyVisual.GetLineSmoothing: TLlDOMPropertyLineSmoothing;
var  baseObj: TLlDOMItem;
begin
    if fLineSmoothing <> nil then
  begin
    result := fLineSmoothing
  end
  else
  begin
    baseObj := GetObject('LineSmoothing');
    fLineSmoothing := TLlDOMPropertyLineSmoothing.
      Create(baseObj);
    baseObj.Free;
    result := fLineSmoothing;
  end;

end;

Function TLlDOMPropertyVisual.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyVisual.GetLineTypeOverride;
begin
  result := GetProperty('LineTypeOverride');
end;

procedure TLlDOMPropertyVisual.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyVisual.SetLineTypeOverride(const value: TString);
begin
  SetProperty('LineTypeOverride', value);
end;
{ TLlDOMChartRow }

constructor TLlDOMChartRow.Create(list: TLlDOMChartRowList);
var
  newChartRow: TLlDOMItem;
begin
  newChartRow := list.NewItem(list.Count);
  inherited Create(newChartRow.fDomHandle);
  list.Add(self);
  newChartRow.Free;
end;

Destructor TLlDOMChartRow.Destroy;
begin
  fCoordinateLabelOnObject.Free;
  fVisual.Free;
    inherited;
end;

function TLlDOMChartRow.GetColor: TString;
begin
  result := GetProperty('Color');
end;

function TLlDOMChartRow.GetCoordinateLabel: TString;
begin
  result := GetProperty('CoordinateLabel');
end;

function TLlDOMChartRow.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObject;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObject.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;

end;

function TLlDOMChartRow.GetName: TString;
begin
  result := GetProperty('Name');
end;

function TLlDOMChartRow.GetValue: TString;
begin
  result := GetProperty('Value');
end;

function TLlDOMChartRow.GetValueAxisAssignment: TString;
begin
  result := GetProperty('ValueAxisAssignment');
end;

function TLlDOMChartRow.GetVisual: TLlDOMPropertyVisual;
var
  baseObj: TLlDOMItem;
begin
    if fVisual <> nil then
  begin
    result := fVisual
  end
  else
  begin
    baseObj := GetObject('Visual');
    fVisual := TLlDOMPropertyVisual.
      Create(baseObj);
    baseObj.Free;
    result := fVisual;
  end;

end;

function TLlDOMChartRow.GetVisualSymbol: TString;
begin
  result := GetProperty('VisualSymbol');
end;

function TLlDOMChartRow.GetWidth: TString;
begin
  result := GetProperty('Width');
end;

procedure TLlDOMChartRow.SetColor(const value: TString);
begin
  SetProperty('Color', value);
end;

procedure TLlDOMChartRow.SetCoordinateLabel(const value: TString);
begin
  SetProperty('CoordinateLabel', value);
end;

procedure TLlDOMChartRow.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

procedure TLlDOMChartRow.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

procedure TLlDOMChartRow.SetValueAxisAssignment(const value: TString);
begin
  SetProperty('ValueAxisAssignment', value);
end;

procedure TLlDOMChartRow.SetWidth(const value: TString);
begin
  SetProperty('Width', value);
end;

procedure TLlDOMChartRow.SetVisualSymbol(const value: TString);
begin
  SetProperty('VisualSymbol', value);
end;

{ TLlDOMChartRowList }

function TLlDOMChartRowList.Add(domObj: TLlDOMChartRow): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMChartRowList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMChartRowList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMChartRowList.GetItems(index: integer): TLlDOMChartRow;
begin
  result := TLlDOMChartRow(inherited Items[index]);
end;

function TLlDOMChartRowList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMChartRow;
begin
  newDomObj := TLlDOMChartRow.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'ChartRow');
  result := newDomObj;
end;

procedure TLlDOMChartRowList.SetItems(index: integer;
  const value: TLlDOMChartRow);
begin
  inherited Items[index] := value;
end;

{ TLlDOMRegion }

constructor TLlDOMRegion.Create(list: TLlDOMRegionList);
var
  newRegion: TLlDOMItem;
begin
  newRegion := list.NewItem(list.Count);
  inherited Create(newRegion.fDomHandle);
  list.Add(self);
  newRegion.Free;
end;

destructor TLlDOMRegion.Destroy;
begin
  fDevice.Free;
  fPaper.Free;
  fLayout.Free;
  inherited;
end;

procedure TLlDOMRegion.SetDevMode({$IFDEF UNICODE} DevMode: PDeviceModeW
{$ELSE} DevMode: PDeviceModeA {$ENDIF});
begin
  SetDevMode(DevMode, DevMode.dmDeviceName);
end;

procedure TLlDOMRegion.SetDevMode({$IFDEF UNICODE} DevMode: PDeviceModeW
{$ELSE} DevMode: PDeviceModeA {$ENDIF}; DeviceName: string);
var
  nSizeReq: integer;
  pBuffer: PTChar;
begin
  Device.Name := TString(#39) + DeviceName + TString(#39);
  nSizeReq := LlConvertBLOBToString(_PCUINT8(DevMode),
    DevMode.dmSize + DevMode.dmDriverExtra, nil, 0, True);
  GetMem(pBuffer, nSizeReq);
  LlConvertBLOBToString(_PCUINT8(DevMode),
    DevMode.dmSize + DevMode.dmDriverExtra, pBuffer, nSizeReq, True);
  Device.DevMode := string(pBuffer);
  FreeMem(pBuffer);
end;

function TLlDOMRegion.GetIsStandardRegion: TString;
begin
  result := GetProperty('IsStandardRegion');
end;

function TLlDOMRegion.GetUseForOutput: TString;
begin
  result := GetProperty('UseForOutput');
end;
function TLlDOMRegion.GetCollate: TString;
begin
  result := GetProperty('Collate');
end;
function TLlDOMRegion.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMRegion.GetCopies: TString;
begin
  result := GetProperty('Copies');
end;

function TLlDOMRegion.GetDevice: TLlDOMPropertyDevice;
var
  baseObj: TLlDOMItem;
begin
  if (fDevice <> nil) then
  begin
    result := fDevice
  end
  else
  begin
    baseObj := GetObject('Device');
    fDevice := TLlDOMPropertyDevice.Create(baseObj);
    baseObj.Free;
    result := fDevice;
  end;

end;

function TLlDOMRegion.GetDuplex: TString;
begin
  result := GetProperty('Duplex');
end;

function TLlDOMRegion.GetFitPage: TString;
begin
  result := GetProperty('FitPage');
end;

function TLlDOMRegion.GetForcePaperFormat: TString;
begin
  result := GetProperty('ForcePaperFormat');
end;

function TLlDOMRegion.GetLayout: TLlDOMPropertyLayout;
var
  baseObj: TLlDOMItem;
begin
  if (fLayout <> nil) then
  begin
    result := fLayout
  end
  else
  begin
    baseObj := GetObject('Layout');
    fLayout := TLlDOMPropertyLayout.Create(baseObj);
    baseObj.Free;
    result := fLayout;
  end;
end;

function TLlDOMRegion.GetName: TString;
begin
  result := GetProperty('Name');
end;

function TLlDOMRegion.GetPaper: TLlDOMPropertyPaper;
var
  baseObj: TLlDOMItem;
begin
  if (fPaper <> nil) then
  begin
    result := fPaper
  end
  else
  begin
    baseObj := GetObject('Paper');
    fPaper := TLlDOMPropertyPaper.Create(baseObj);
    baseObj.Free;
    result := fPaper;
  end;

end;

function TLlDOMRegion.GetSourceTray: TString;
begin
  result := GetProperty('SourceTray');
end;

function TLlDOMRegion.GetUsePhysicalPaper: TString;
begin
  result := GetProperty('UsePhysicalPaper');
end;

function TLlDOMRegion.GetShowInPrintDialog: TString;
begin
  result := GetProperty('ShowInPrintDialog');
end;

procedure TLlDOMRegion.SetCollate(const value: TString);
begin
  SetProperty('Collate', value);
end;

procedure TLlDOMRegion.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMRegion.SetCopies(const value: TString);
begin
  SetProperty('Copies', value);
end;

procedure TLlDOMRegion.SetDuplex(const value: TString);
begin
  SetProperty('Duplex', value);
end;

procedure TLlDOMRegion.SetFitPage(const value: TString);
begin
  SetProperty('FitPage', value);
end;

procedure TLlDOMRegion.SetForcePaperFormat(const value: TString);
begin
  SetProperty('ForcePaperFormat', value);
end;

procedure TLlDOMRegion.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

procedure TLlDOMRegion.SetSourceTray(const value: TString);
begin
  SetProperty('SourceTray', value);
end;

procedure TLlDOMRegion.SetUsePhysicalPaper(const value: TString);
begin
  SetProperty('UsePhysicalPaper', value);
end;

procedure TLlDOMRegion.SetShowInPrintDialog(const value: TString);
begin
  SetProperty('ShowInPrintDialog', value);
end;

{ TLlDOMRegionList }

function TLlDOMRegionList.Add(domObj: TLlDOMRegion): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMRegionList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMRegionList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMRegionList.GetItems(index: integer): TLlDOMRegion;
begin
  result := TLlDOMRegion(inherited Items[index]);
end;

procedure TLlDOMRegionList.Initialize;
var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMRegion;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMRegion.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;
end;

function TLlDOMRegionList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMRegion;
begin
  newDomObj := TLlDOMRegion.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Region');
  result := newDomObj;

end;

procedure TLlDOMRegionList.SetItems(index: integer; const value: TLlDOMRegion);
begin
  inherited Items[index] := value;
end;

{ TLlDOMPropertyDevice }

function TLlDOMPropertyDevice.GetDEVMODE: TString;
begin
  result := GetProperty('DEVMODE');
end;

function TLlDOMPropertyDevice.GetExtraData: TString;
begin
  result := GetProperty('ExtraData');
end;

function TLlDOMPropertyDevice.GetName: TString;
begin
  result := GetProperty('Name');
end;

procedure TLlDOMPropertyDevice.SetDevMode(const value: TString);
begin
  SetProperty('DEVMODE', value);
end;

procedure TLlDOMPropertyDevice.SetExtraData(const value: TString);
begin
  SetProperty('ExtraData', value);
end;

procedure TLlDOMPropertyDevice.SetName(const value: TString);
begin
  SetProperty('Name', value);
end;

{ TLlDOMPropertyPaper }

destructor TLlDOMPropertyPaper.Destroy;
begin
  if Assigned(fExtent) then
    fExtent.Free;

  if Assigned(fPrintableArea) then
    fPrintableArea.Free;

  inherited;
end;

function TLlDOMPropertyPaper.GetExtent: TllDomPropertySize;
var
  baseObj: TLlDOMItem;
begin
  if (fExtent <> nil) then
  begin
    result := fExtent
  end
  else
  begin
    baseObj := GetObject('Extent');
    fExtent := TllDomPropertySize.Create(baseObj);
    baseObj.Free;
    result := fExtent;
  end;

end;

function TLlDOMPropertyPaper.GetPrintableArea: TllDomPropertyPrintableArea;
var
  baseObj: TLlDOMItem;
begin
  if (fPrintableArea <> nil) then
  begin
    result := fPrintableArea
  end
  else
  begin
    baseObj := GetObject('PrintableArea');
    fPrintableArea := TllDomPropertyPrintableArea.Create(baseObj);
    baseObj.Free;
    result := fPrintableArea;
  end;
end;

function TLlDOMPropertyPaper.GetFormat: TString;
begin
  result := GetProperty('Format');
end;

function TLlDOMPropertyPaper.GetOrientation: TString;
begin
  result := GetProperty('Orientation');
end;

procedure TLlDOMPropertyPaper.SetFormat(const value: TString);
begin
  SetProperty('Format', value);
end;

procedure TLlDOMPropertyPaper.SetOrientation(const value: TString);
begin
  SetProperty('Orientation', value);
end;

{ TLlDOMDrillDownBase }

constructor TLlDOMDrillDownLinkBase.Create(list: TLlDOMDrillDownLinkList; drillDownType: TString; index: integer);
var
  newDrillDownLink : TLlDOMItem;
begin
   inherited Create();
   if drillDownType = '0' then
     begin
      DrillDownType := '0';
      newDrillDownLink := list.AddNewDrillDownLink(index);
     end
   else
     begin
       DrillDownType := '1';
       newDrillDownLink := list.AddNewDrillDownLinkForParameterizedSubreport(index);
     end;

  fDomHandle := newDrillDownLink.fDomHandle;
  list.Add(self);
  newDrillDownLink.Free;
end;

constructor TLlDOMDrillDownLinkBase.Create(newItem: TLlDOMItem);
begin
	inherited create(newItem);
end;

function TLlDOMDrillDownLinkBase.GetDrillDownType: TString;
begin
  result := GetProperty('DrillDownType');
end;

procedure TLlDOMDrillDownLinkBase.SetDrillDownType(const value: TString);
begin
  SetProperty('DrillDownType', value);
end;

function TLlDOMDrillDownLinkBase.GetMenuText: TString;
begin
  result := GetProperty('MenuText');
end;

procedure TLlDOMDrillDownLinkBase.SetMenuText(const value: TString);
begin
  SetProperty('MenuText', value);
end;

function TLlDOMDrillDownLinkBase.GetProjectFileName: TString;
begin
  result := GetProperty('ProjectFileName');
end;

procedure TLlDOMDrillDownLinkBase.SetProjectFileName(const value: TString);
begin
  SetProperty('ProjectFileName', value);
end;
{ /TLlDOMDrillDownBase }

{ TLlDOMDrillDownLink }
constructor TLlDOMDrillDownLink.Create(newItem: TLlDOMItem);
begin
  inherited Create(newItem);
  DrillDownType := '0';
end;

function TLlDOMDrillDownLink.GetChildKeyField: TString;
begin
  result := GetProperty('ChildKeyField');
end;

function TLlDOMDrillDownLink.GetChildTableID: TString;
begin
  result := GetProperty('ChildTableID');
end;

function TLlDOMDrillDownLink.GetParentKeyField: TString;
begin
  result := GetProperty('ParentKeyField');
end;

function TLlDOMDrillDownLink.GetParentTableID: TString;
begin
  result := GetProperty('ParentTableID');
end;

function TLlDOMDrillDownLink.GetRelationID: TString;
begin
  result := GetProperty('RelationID');
end;

procedure TLlDOMDrillDownLink.SetChildKeyField(const value: TString);
begin
  SetProperty('ChildKeyField', value);
end;

procedure TLlDOMDrillDownLink.SetChildTableID(const value: TString);
begin
  SetProperty('ChildTableID', value);
end;

procedure TLlDOMDrillDownLink.SetParentKeyField(const value: TString);
begin
  SetProperty('ParentKeyField', value);
end;

procedure TLlDOMDrillDownLink.SetParentTableID(const value: TString);
begin
  SetProperty('ParentTableID', value);
end;

procedure TLlDOMDrillDownLink.SetRelationID(const value: TString);
begin
  SetProperty('RelationID', value);
end;
{\ TLlDOMDrillDownLink }
{ TLlDOMDrillDownLinkForParameterizedSubreport}
constructor TLlDOMDrillDownLinkForParameterizedSubreport.Create(newItem: TLlDomItem);
begin
  inherited Create(newItem);
  DrillDownType := '1';
end;

procedure TLlDOMDrillDownLinkForParameterizedSubreport.SetShowReportParameterPreviewPane(const value: TString);
begin
  SetProperty('ShowReportParameterPreviewPane', value);
end;

function TLlDOMDrillDownLinkForParameterizedSubreport.GetShowReportParameterPreviewPane: TString;
begin
  result := GetProperty('ShowReportParameterPreviewPane');
end;

function TLlDOMDrillDownLinkForParameterizedSubreport.GetSubReportDescription: TString;
begin
   result := GetProperty('SubReportDescription');
end;
procedure TLlDOMDrillDownLinkForParameterizedSubreport.SetSubReportDescription(const value: TString);
begin
  SetProperty('SubReportDescription', value);
end;
function TLlDOMDrillDownLinkForParameterizedSubreport.GetReportParameterList: TLlDOMDrillDownReportParameterList;
begin
  if fReportParameterList = nil then
  begin
   fReportParameterList :=TLlDOMDrillDownReportParameterList.Create(GetObject('ReportParameterList'));
  end;
   result := fReportParameterList;
end;
{/TLlDOMDrillDownLinkForParameterizedSubreport}
{TLlDOMDrillDownReportParameterList}
constructor TLlDOMDrillDownReportParameterList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

function TLlDOMDrillDownReportParameterList.GetItems(index: integer)
  : TLlDOMDrillDownReportParameterListItem;
begin
  result := TLlDOMDrillDownReportParameterListItem(inherited Items[index]);
end;

procedure TLlDOMDrillDownReportParameterList.SetItems(index: integer;
  const value: TLlDOMDrillDownReportParameterListItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMDrillDownReportParameterList.Add(domObj: TLlDOMDrillDownReportParameterListItem): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMDrillDownReportParameterList.NewItem(index: integer;name:
TString; value: TString; valueType: TLlDOMReportParameterValueType): TLlDOMDrillDownReportParameterListItem;
var
  newDomObj: TLlDOMDrillDownReportParameterListItem;
  charIndex: integer;
begin
//check whether @ is first char
  charIndex := Pos('@',name);
  newDomObj := TLlDOMDrillDownReportParameterListItem.Create;
  if  charIndex < 1 then
     begin
       name := '@'+ name;
     end;

  newDomObj.fDomHandle := fDOMObj.CreateSubObject(index, name);
  newDomObj.SetValue(value);
  newDomObj.SetContentType(valueType);
  inherited Add(newDomObj);
  result := newDomObj;
end;

{/TLlDOMDrillDownReportParameterList}
{TLlDOMDrillDownReportParameterListItem}
constructor TLlDOMDrillDownReportParameterListItem.Create(list: TLlDOMDrillDownReportParameterList;
          name: TString; value: TString; valueType: TLlDOMReportParameterValueType);
 var
  newDrillDownReportParameterListItem: TLlDOMItem;
begin
  newDrillDownReportParameterListItem := list.NewItem(list.Count, name, value, valueType);
  inherited Create(newDrillDownReportParameterListItem.fDomHandle);
  list.Add(self);
  newDrillDownReportParameterListItem.Free;
end;

function TLlDOMReportParameter.GetCurrentContents: TString;
begin
   result :=  VarToStr(CurrentContentsAsObject);
end;

function TLlDOMReportParameter.GetCurrentContentsAsObject: OleVariant;
begin
   result := GetVariantFromProfContents(PWideChar(GetProperty('CurrentContents')));
end;

procedure TLlDOMReportParameter.SetCurrentContentsAsObject(const value: OleVariant);
begin
   SetProperty('CurrentContents', GetProfContentsFromVariant(PCVARIANT(@value)));
end;

procedure TLlDOMReportParameter.SetCurrentContents(const value: TString);
begin
  SetProperty('CurrentContents', value);
end;


function TLlDOMDrillDownReportParameterListItem.GetName: TString;
begin
 result := GetProperty('Name');
end;

function TLlDOMDrillDownReportParameterListItem.GetValue: TString;
begin
 result := GetProperty('Value');
end;

function TLlDOMDrillDownReportParameterListItem.GetContentType: TLlDOMReportParameterValueType;
begin
result := TLlDOMReportParameterValueType
    (StrToInt(GetProperty('ContentsType')));
end;
function  TLlDOMDrillDownReportParameterListItem.GetAllowMultipleValues: TString;
begin
 result := GetProperty('AllowMultipleValues');
end;

procedure TLlDOMDrillDownReportParameterListItem.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

procedure TLlDOMDrillDownReportParameterListItem.SetAllowMultipleValues(const value: TString);
begin
  SetProperty('AllowMultipleValues', value);
end;

procedure TLlDOMDrillDownReportParameterListItem.SetContentType(const value: TLlDOMReportParameterValueType);
begin
  SetProperty('ContentsType', IntToStr(Ord(value)));
end;
{/TLlDOMDrillDownReportParameterListItem}
{ TLlDOMDrillDownLinkList }

function TLlDOMDrillDownLinkList.Add(domObj: TLlDOMItem): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMDrillDownLinkList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;
procedure TLlDOMDrillDownLinkList.Initialize;
var
  nObjCount: integer;
  newDomObj: TLlDOMItem;
  i: integer;
begin
  Clear();
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    newDomObj := fDOMObj.GetSubObject(i);
    Add(newDomObj);
  end;
end;

destructor TLlDOMDrillDownLinkList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMDrillDownLinkList.GetItems(index: integer): TLlDOMDrillDownLinkBase;
begin
  result := TLlDOMDrillDownLinkBase(inherited Items[index]);
end;

function TLlDOMDrillDownLinkList.AddNewDrillDownLink(index: Integer):TLlDOMDrillDownLink;
var
  newDomObj: TLlDOMDrillDownLink;
  baseObj: TLlDomItem;
begin
  baseObj := TLlDomItem.Create(fDOMObj.CreateSubObject(index, 'DrillDownLink'));
  newDomObj := TLlDOMDrillDownLink.Create(baseObj);
  baseObj.Free;
  result := newDomObj;;
end;

function TLlDOMDrillDownLinkList.AddNewDrillDownLinkForParameterizedSubreport
    (index: Integer):TLlDOMDrillDownLinkForParameterizedSubreport;
var
  newDomObj: TLlDOMDrillDownLinkForParameterizedSubreport;
  baseObj: TLlDomItem;
begin
  baseObj := TLlDomItem.Create(fDOMObj.CreateSubObject(index, 'DrillDownLink'));
  newDomObj := TLlDOMDrillDownLinkForParameterizedSubreport.Create(baseObj);
  baseObj.Free;
  result := newDomObj;
end;


procedure TLlDOMDrillDownLinkList.SetItems(index: integer;
  const value: TLlDOMDrillDownLinkBase);
begin
  inherited Items[index] := value;
end;
{ /TLlDOMDrillDownLinkList }
{ TLlDOMPropertyReportSections }

destructor TLlDOMPropertyReportSections.Destroy;
begin
  if (Assigned(FIndex)) then
    FIndex.Free;
  if (Assigned(FTableOfContents)) then
    FTableOfContents.Free;
  if (Assigned(FReverseSide)) then
    FReverseSide.Free;
  inherited;
end;

function TLlDOMPropertyReportSections.GetIndex: TLlDOMPropertyReportSection;
var
  baseObj: TLlDOMItem;
begin
  if (FIndex <> nil) then
  begin
    result := FIndex
  end
  else
  begin
    baseObj := GetObject('Index');
    FIndex := TLlDOMPropertyReportSection.Create(baseObj);
    baseObj.Free;
    result := FIndex;
  end;
end;

function TLlDOMPropertyReportSections.GetTableOfContents
  : TLlDOMPropertyReportSection;
var
  baseObj: TLlDOMItem;
begin
  if (FTableOfContents <> nil) then
  begin
    result := FTableOfContents
  end
  else
  begin
    baseObj := GetObject('TableOfContents');
    FTableOfContents := TLlDOMPropertyReportSection.Create(baseObj);
    baseObj.Free;
    result := FTableOfContents;
  end;
end;

function TLlDOMPropertyReportSections.GetReverseSide
  : TLlDOMPropertyReportSectionReverseSide;
var
  baseObj: TLlDOMItem;
begin
  if (FReverseSide <> nil) then
  begin
    result := FReverseSide
  end
  else
  begin
    baseObj := GetObject('ReverseSide');
    FReverseSide := TLlDOMPropertyReportSectionReverseSide.Create(baseObj);
    baseObj.Free;
    result := FReverseSide;
  end;
end;

{ TLlDOMPropertyReportSection }

function TLlDOMPropertyReportSection.GetFileName: TString;
begin
  result := GetProperty('FileName');
end;

procedure TLlDOMPropertyReportSection.SetFileName(const value: TString);
begin
  SetProperty('FileName', value);
end;

function TLlDOMPropertyReportSection.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

procedure TLlDOMPropertyReportSection.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;


{ TLlDOMPropertyReportSectionReverseSide }

function TLlDOMPropertyReportSectionReverseSide.GetIssueCondition: TString;
begin
  result := GetProperty('IssueCondition');
end;

procedure TLlDOMPropertyReportSectionReverseSide.SetIssueCondition
  (const value: TString);
begin
  SetProperty('IssueCondition', value);
end;

function TLlDOMPropertyReportSectionReverseSide.
  GetSimplexReverseSideMode: TString;
begin
  result := GetProperty('SimplexReverseSideMode');
end;

procedure TLlDOMPropertyReportSectionReverseSide.SetSimplexReverseSideMode
  (const value: TString);
begin
  SetProperty('SimplexReverseSideMode', value);
end;

function TLlDOMPropertyReportSectionReverseSide.
  GetDuplexReverseSideMode: TString;
begin
  result := GetProperty('DuplexReverseSideMode');
end;

procedure TLlDOMPropertyReportSectionReverseSide.SetDuplexReverseSideMode
  (const value: TString);
begin
  SetProperty('DuplexReverseSideMode', value);
end;

{ TLlDOMPropertyDataGraphicDefinition }

destructor TLlDOMPropertyDataGraphicDefinition.Destroy;
begin
  if Assigned(FPropertyBar) then
    FPropertyBar.Free;
  if Assigned(FPropertyData) then
    FPropertyData.Free;
  if Assigned(FPropertyIcon) then
    FPropertyIcon.Free;
  inherited;
end;

function TLlDOMPropertyDataGraphicDefinition.GetMaximumValue: TString;
begin
  result := GetProperty('MaximumValue');
end;

function TLlDOMPropertyDataGraphicDefinition.GetMinimumValue: TString;
begin
  result := GetProperty('MinimumValue');
end;

function TLlDOMPropertyDataGraphicDefinition.GetPropertyBar
  : TLlDOMPropertyDataGraphicBar;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyBar <> nil) then
  begin
    result := FPropertyBar;
  end
  else
  begin
    baseObj := GetObject('Bar');
    FPropertyBar := TLlDOMPropertyDataGraphicBar.Create(baseObj);
    baseObj.Free;
    result := FPropertyBar;
  end;
end;

function TLlDOMPropertyDataGraphicDefinition.GetPropertyData
  : TLlDOMPropertyDataGraphicData;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyData <> nil) then
  begin
    result := FPropertyData;
  end
  else
  begin
    baseObj := GetObject('Data');
    FPropertyData := TLlDOMPropertyDataGraphicData.Create(baseObj);
    baseObj.Free;
    result := FPropertyData;
  end;
end;

function TLlDOMPropertyDataGraphicDefinition.GetPropertyIcon
  : TLlDOMPropertyDataGraphicIcon;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyIcon <> nil) then
  begin
    result := FPropertyIcon;
  end
  else
  begin
    baseObj := GetObject('Icon');
    FPropertyIcon := TLlDOMPropertyDataGraphicIcon.Create(baseObj);
    baseObj.Free;
    result := FPropertyIcon;
  end;
end;

procedure TLlDOMPropertyDataGraphicDefinition.SetMaximumValue
  (const value: TString);
begin
  SetProperty('MaximumValue', value);
end;

procedure TLlDOMPropertyDataGraphicDefinition.SetMinimumValue
  (const value: TString);
begin
  SetProperty('MinimumValue', value);
end;

{ TLlDOMPropertyDataGraphicBar }

destructor TLlDOMPropertyDataGraphicBar.Destroy;
begin
  if Assigned(FPropertyAlignment) then
    FPropertyAlignment.Free;
  if Assigned(FPropertyColorRanges) then
    FPropertyColorRanges.Free;
  inherited;
end;

function TLlDOMPropertyDataGraphicBar.GetAlignment: TLlDOMPropertyAlignment;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyAlignment <> nil) then
  begin
    result := FPropertyAlignment;
  end
  else
  begin
    baseObj := GetObject('Alignment');
    FPropertyAlignment := TLlDOMPropertyAlignment.Create(baseObj);
    baseObj.Free;
    result := FPropertyAlignment;
  end;
end;

function TLlDOMPropertyDataGraphicBar.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMPropertyDataGraphicBar.GetColorRanges: TLlDOMPropertyColorRanges;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyColorRanges <> nil) then
  begin
    result := FPropertyColorRanges;
  end
  else
  begin
    baseObj := GetObject('ColorRanges');
    FPropertyColorRanges := TLlDOMPropertyColorRanges.Create(baseObj);
    baseObj.Free;
    result := FPropertyColorRanges;
  end;
end;

function TLlDOMPropertyDataGraphicBar.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMPropertyDataGraphicBar.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMPropertyDataGraphicBar.GetRounding: TString;
begin
  result := GetProperty('Rounding');
end;

procedure TLlDOMPropertyDataGraphicBar.SetAlignmentVertical
  (const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMPropertyDataGraphicBar.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMPropertyDataGraphicBar.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMPropertyDataGraphicBar.SetRounding(const value: TString);
begin
  SetProperty('Rounding', value);
end;

{ TLlDOMPropertyAlignment }

destructor TLlDOMPropertyAlignment.Destroy;
begin
  if Assigned(FPropertyBaseLine) then
    FPropertyBaseLine.Free;
  inherited;
end;

function TLlDOMPropertyAlignment.GetBaseValue: TString;
begin
  result := GetProperty('BaseValue');
end;

function TLlDOMPropertyAlignment.GetBaseLine: TLlDOMPropertyLine;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyBaseLine <> nil) then
  begin
    result := FPropertyBaseLine;
  end
  else
  begin
    baseObj := GetObject('BaseLine');
    FPropertyBaseLine := TLlDOMPropertyLine.Create(baseObj);
    baseObj.Free;
    result := FPropertyBaseLine;
  end;
end;

function TLlDOMPropertyAlignment.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

procedure TLlDOMPropertyAlignment.SetBaseValue(const value: TString);
begin
  SetProperty('BaseValue', value);
end;

procedure TLlDOMPropertyAlignment.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

{ TLlDOMPropertyColorRanges }

destructor TLlDOMPropertyColorRanges.Destroy;
begin
  if Assigned(FPropertyAutomaticFilling) then
    FPropertyAutomaticFilling.Free;
  if Assigned(FColorRangeItemList) then
    FColorRangeItemList.Free;
  inherited;
end;

function TLlDOMPropertyColorRanges.GetAbsoluteValues: TString;
begin
  result := GetProperty('AbsoluteValues');
end;

function TLlDOMPropertyColorRanges.GetAutomatic: TString;
begin
  result := GetProperty('Automatic');
end;

function TLlDOMPropertyColorRanges.GetAutomaticFilling
  : TLlDOMPropertyChartFilling;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyAutomaticFilling <> nil) then
  begin
    result := FPropertyAutomaticFilling;
  end
  else
  begin
    baseObj := GetObject('AutomaticFilling');
    FPropertyAutomaticFilling := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := FPropertyAutomaticFilling;
  end;
end;

function TLlDOMPropertyColorRanges.GetColorRangeItemList
  : TLlDOMColorRangeItemList;
begin
  if FColorRangeItemList = nil then
  begin
    FColorRangeItemList := TLlDOMColorRangeItemList.Create(GetObject('List'));
  end;
  result := FColorRangeItemList;
end;

procedure TLlDOMPropertyColorRanges.SetAbsoluteValues(const value: TString);
begin
  SetProperty('AbsoluteValues', value);
end;

procedure TLlDOMPropertyColorRanges.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

{ TLlDOMColorRangeItemList }
constructor TLlDOMColorRangeItemList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;
  Initialize();
end;

destructor TLlDOMColorRangeItemList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMColorRangeItemList.AddColorRangeItem
  (domObj: TLlDOMColorRangeItem): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMColorRangeItemList.Add(domObj: TLlDOMColorRangeItem): integer;
begin
  result := AddColorRangeItem(domObj);
end;

function TLlDOMColorRangeItemList.GetItems(index: integer)
  : TLlDOMColorRangeItem;
begin
  result := inherited Items[index];
end;

function TLlDOMColorRangeItemList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMColorRangeItem;
begin
  newDomObj := TLlDOMColorRangeItem.Create
    (fDOMObj.CreateSubObject(index, 'Item'));
  result := newDomObj;
end;

procedure TLlDOMColorRangeItemList.SetItems(index: integer;
  const value: TLlDOMColorRangeItem);
begin
  inherited Items[index] := value;
end;

{ TLlDOMColorRangeItem }

constructor TLlDOMColorRangeItem.Create(list: TLlDOMColorRangeItemList);
var
  newRange: TLlDOMItem;
begin
  newRange := list.NewItem(list.Count);
  inherited Create(newRange.fDomHandle);
  list.Add(self);
  newRange.Free;
end;

destructor TLlDOMColorRangeItem.Destroy;
begin
  if Assigned(FPropertyFilling) then
    FPropertyFilling.Free;
  inherited;
end;

function TLlDOMColorRangeItem.GetFilling: TLlDOMPropertyChartFilling;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyFilling <> nil) then
  begin
    result := FPropertyFilling;
  end
  else
  begin
    baseObj := GetObject('Filling');
    FPropertyFilling := TLlDOMPropertyChartFilling.Create(baseObj);
    baseObj.Free;
    result := FPropertyFilling;
  end;
end;

function TLlDOMColorRangeItem.GetMax: TString;
begin
  result := GetProperty('Max');
end;

function TLlDOMColorRangeItem.GetMin: TString;
begin
  result := GetProperty('Min');
end;

procedure TLlDOMColorRangeItem.SetMax(const value: TString);
begin
  SetProperty('Max', value);
end;

procedure TLlDOMColorRangeItem.SetMin(const value: TString);
begin
  SetProperty('Min', value);
end;

{ TLlDOMPropertyDataGraphicDisplay }

destructor TLlDOMPropertyDataGraphicDisplay.Destroy;
begin
  if Assigned(fFont) then
    fFont.Free;
  if Assigned(fOutputFormatter) then
    fOutputFormatter.Free;
  inherited;
end;

function TLlDOMPropertyDataGraphicDisplay.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMPropertyDataGraphicDisplay.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMPropertyDataGraphicDisplay.GetFont: TLlDOMPropertyFont;
var
  baseObj: TLlDOMItem;
begin
  if (fFont <> nil) then
  begin
    result := fFont
  end
  else
  begin
    baseObj := GetObject('Font');
    fFont := TLlDOMPropertyFont.Create(baseObj);
    baseObj.Free;
    result := fFont;
  end;
end;

function TLlDOMPropertyDataGraphicDisplay.GetOutputFormatterBase
  : TLlDOMPropertyOutputFormatterBase;
var
  baseObj: TLlDOMItem;
begin
  if fOutputFormatter = nil then
  begin
    baseObj := GetObject('OutputFormatter');
    fOutputFormatter := TLlDOMPropertyOutputFormatterBase.Create(baseObj);
    baseObj.Free;
    fOutputFormatter := TLlDOMHelper.SafeFormatterCast(fOutputFormatter);
  end;
  result := fOutputFormatter
end;

procedure TLlDOMPropertyDataGraphicDisplay.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMPropertyDataGraphicDisplay.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

{ TLlDOMPropertyDataGraphicData }

destructor TLlDOMPropertyDataGraphicData.Destroy;
begin
  if Assigned(FPropertyDisplay) then
    FPropertyDisplay.Free;
  inherited;
end;

function TLlDOMPropertyDataGraphicData.GetDisplay
  : TLlDOMPropertyDataGraphicDisplay;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyDisplay <> nil) then
  begin
    result := FPropertyDisplay;
  end
  else
  begin
    baseObj := GetObject('Display');
    FPropertyDisplay := TLlDOMPropertyDataGraphicDisplay.Create(baseObj);
    baseObj.Free;
    result := FPropertyDisplay;
  end;
end;

function TLlDOMPropertyDataGraphicData.GetValue: TString;
begin
  result := GetProperty('Value');
end;

procedure TLlDOMPropertyDataGraphicData.SetValue(const value: TString);
begin
  SetProperty('Value', value);
end;

{ TLlDOMPropertyDataGraphicIcon }

destructor TLlDOMPropertyDataGraphicIcon.Destroy;
begin
  if Assigned(FPropertyIconRanges) then
    FPropertyIconRanges.Free;
  inherited;
end;

function TLlDOMPropertyDataGraphicIcon.GetAlignment: TString;
begin
  result := GetProperty('Alignment');
end;

function TLlDOMPropertyDataGraphicIcon.GetAlignmentVertical: TString;
begin
  result := GetProperty('AlignmentVertical');
end;

function TLlDOMPropertyDataGraphicIcon.GetCondition: TString;
begin
  result := GetProperty('Condition');
end;

function TLlDOMPropertyDataGraphicIcon.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

function TLlDOMPropertyDataGraphicIcon.GetIcon: TString;
begin
  result := GetProperty('Icon');
end;

function TLlDOMPropertyDataGraphicIcon.GetIconRanges: TLlDOMPropertyIconRanges;
var
  baseObj: TLlDOMItem;
begin
  if (FPropertyIconRanges <> nil) then
  begin
    result := FPropertyIconRanges;
  end
  else
  begin
    baseObj := GetObject('IconRanges');
    FPropertyIconRanges := TLlDOMPropertyIconRanges.Create(baseObj);
    baseObj.Free;
    result := FPropertyIconRanges;
  end;
end;

procedure TLlDOMPropertyDataGraphicIcon.SetAlignment(const value: TString);
begin
  SetProperty('Alignment', value);
end;

procedure TLlDOMPropertyDataGraphicIcon.SetAlignmentVertical
  (const value: TString);
begin
  SetProperty('AlignmentVertical', value);
end;

procedure TLlDOMPropertyDataGraphicIcon.SetCondition(const value: TString);
begin
  SetProperty('Condition', value);
end;

procedure TLlDOMPropertyDataGraphicIcon.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

procedure TLlDOMPropertyDataGraphicIcon.SetIcon(const value: TString);
begin
  SetProperty('Icon', value);
end;

{ TLlDOMPropertyIconRanges }

destructor TLlDOMPropertyIconRanges.Destroy;
begin

  inherited;
end;

function TLlDOMPropertyIconRanges.GetAbsoluteValues: TString;
begin
  result := GetProperty('AbsoluteValues');
end;

function TLlDOMPropertyIconRanges.GetAutomatic: TString;
begin
  result := GetProperty('Automatic');
end;

function TLlDOMPropertyIconRanges.GetIconRangeItemList: TLlDOMIconRangeItemList;
begin
  if FIconRangeItemList = nil then
  begin
    FIconRangeItemList := TLlDOMIconRangeItemList.Create(GetObject('List'));
  end;
  result := FIconRangeItemList;
end;

procedure TLlDOMPropertyIconRanges.SetAbsoluteValues(const value: TString);
begin
  SetProperty('AbsoluteValues', value);
end;

procedure TLlDOMPropertyIconRanges.SetAutomatic(const value: TString);
begin
  SetProperty('Automatic', value);
end;

{ TLlDOMIconRangeItemList }
constructor TLlDOMIconRangeItemList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;
  Initialize();
end;

destructor TLlDOMIconRangeItemList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMIconRangeItemList.AddIconRangeItem
  (domObj: TLlDOMIconRangeItem): integer;
begin
  result := inherited Add(domObj);
end;

function TLlDOMIconRangeItemList.Add(domObj: TLlDOMIconRangeItem): integer;
begin
  result := AddIconRangeItem(domObj);
end;

function TLlDOMIconRangeItemList.GetItems(index: integer): TLlDOMIconRangeItem;
begin
  result := inherited Items[index];
end;

function TLlDOMIconRangeItemList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMIconRangeItem;
begin
  newDomObj := TLlDOMIconRangeItem.Create
    (fDOMObj.CreateSubObject(index, 'Item'));
  result := newDomObj;
end;

procedure TLlDOMIconRangeItemList.SetItems(index: integer;
  const value: TLlDOMIconRangeItem);
begin
  inherited Items[index] := value;
end;

{ TLlDOMIconRangeItem }

constructor TLlDOMIconRangeItem.Create(list: TLlDOMIconRangeItemList);
var
  newRange: TLlDOMItem;
begin
  newRange := list.NewItem(list.Count);
  inherited Create(newRange.fDomHandle);
  list.Add(self);
  newRange.Free;
end;

function TLlDOMIconRangeItem.GetIndex: TString;
begin
  result := GetProperty('Index');
end;

function TLlDOMIconRangeItem.GetMax: TString;
begin
  result := GetProperty('Max');
end;

function TLlDOMIconRangeItem.GetMin: TString;
begin
  result := GetProperty('Min');
end;

procedure TLlDOMIconRangeItem.SetIndex(const value: TString);
begin
  SetProperty('Index', value);
end;

procedure TLlDOMIconRangeItem.SetMax(const value: TString);
begin
  SetProperty('Max', value);
end;

procedure TLlDOMIconRangeItem.SetMin(const value: TString);
begin
  SetProperty('Min', value);
end;

{ TLlDOMTableFieldDataGraphic }

constructor TLlDOMTableFieldDataGraphic.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'DataGraphic', list.Count);
end;

destructor TLlDOMTableFieldDataGraphic.Destroy;
begin
  if Assigned(fDefinition) then
    fDefinition.Free;
  inherited;
end;

function TLlDOMTableFieldDataGraphic.GetDefinition
  : TLlDOMPropertyDataGraphicDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyDataGraphicDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMTableFieldDataGraphic.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMTableFieldDataGraphic.GetHeight: TString;
begin
  result := GetProperty('Height');
end;

procedure TLlDOMTableFieldDataGraphic.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

procedure TLlDOMTableFieldDataGraphic.SetHeight(const value: TString);
begin
  SetProperty('Height', value);
end;

{ TLlDOMObjectDataGraphic }

constructor TLlDOMObjectDataGraphic.Create(list: TLlDOMObjectList);
begin
  inherited Create(list, 'DataGraphic', list.Count);
end;

constructor TLlDOMObjectDataGraphic.Create(list: TLlDOMObjectList;
  index: integer);
begin
  inherited Create(list, 'DataGraphic', index);
end;

destructor TLlDOMObjectDataGraphic.Destroy;
begin
  if Assigned(fDefinition) then
    fDefinition.Free;
  if Assigned(fFrame) then
    fFrame.Free;
  inherited;
end;

function TLlDOMObjectDataGraphic.GetDefinition
  : TLlDOMPropertyDataGraphicDefinition;
var
  baseObj: TLlDOMItem;
begin
  if fDefinition <> nil then
  begin
    result := fDefinition;
  end
  else
  begin
    baseObj := GetObject('Definition');
    fDefinition := TLlDOMPropertyDataGraphicDefinition.Create(baseObj);
    baseObj.Free;
    result := fDefinition;
  end;
end;

function TLlDOMObjectDataGraphic.GetExportAsPicture: TString;
begin
  result := GetProperty('ExportAsPicture');
end;

function TLlDOMObjectDataGraphic.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

procedure TLlDOMObjectDataGraphic.SetExportAsPicture(const value: TString);
begin
  SetProperty('ExportAsPicture', value);
end;

{ TLlDOMPropertyValueAxisBase }

destructor TLlDOMPropertyValueAxisBase.Destroy;
begin
  fZebraPattern.Free;
  fCoordinateLabel.Free;
  fCoordinateLabelOnObject.Free;
  fGridLines.Free;
  fAxisLabel.Free;
  fGetSignalRanges.Free;
  fLabelPlacement.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisBase.GetAxisLabel: TLlDOMPropertyChartLabel;
var
  baseObj: TLlDOMItem;
begin
  if fAxisLabel <> nil then
  begin
    result := fAxisLabel
  end
  else
  begin
    baseObj := GetObject('Label');
    fAxisLabel := TLlDOMPropertyChartLabel.Create(baseObj);
    baseObj.Free;
    result := fAxisLabel;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetCoordinateLabel
  : TLlDOMPropertyChartLabelCoordinate;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabel <> nil then
  begin
    result := fCoordinateLabel
  end
  else
  begin
    baseObj := GetObject('CoordinateLabel');
    fCoordinateLabel := TLlDOMPropertyChartLabelCoordinate.Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabel;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetCoordinateLabelOnObject
  : TLlDOMPropertyChartLabelCoordinateOnObject;
var
  baseObj: TLlDOMItem;
begin
  if fCoordinateLabelOnObject <> nil then
  begin
    result := fCoordinateLabelOnObject
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelOnObject');
    fCoordinateLabelOnObject := TLlDOMPropertyChartLabelCoordinateOnObject.
      Create(baseObj);
    baseObj.Free;
    result := fCoordinateLabelOnObject;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetCoordinateLabelPlacement
  : TLlDOMPropertyCoordinateLabelPlacement;
var
  baseObj: TLlDOMItem;
begin
  if fLabelPlacement <> nil then
  begin
    result := fLabelPlacement
  end
  else
  begin
    baseObj := GetObject('CoordinateLabelPlacement');
    fLabelPlacement := TLlDOMPropertyCoordinateLabelPlacement.Create(baseObj);
    baseObj.Free;
    result := fLabelPlacement;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetFilterZeroes: TString;
begin
  result := GetProperty('FilterZeroes');
end;

function TLlDOMPropertyValueAxisBase.GetGridLines: TLlDOMPropertyGridLines;
var
  baseObj: TLlDOMItem;
begin
  if fGridLines <> nil then
  begin
    result := fGridLines
  end
  else
  begin
    baseObj := GetObject('GridLines');
    fGridLines := TLlDOMPropertyGridLines.Create(baseObj);
    baseObj.Free;
    result := fGridLines;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetIntermediateTickCount: TString;
begin
  result := GetProperty('IntermediateTickCount');
end;

function TLlDOMPropertyValueAxisBase.GetNullValueHandling: TString;
begin
  result := GetProperty('NullValueHandling');
end;

function TLlDOMPropertyValueAxisBase.GetTickmarkColor: TString;
begin
  result := GetProperty('TickmarkColor');
end;


function TLlDOMPropertyValueAxisBase.GetZebraPattern: TLlDOMPropertyFilling;
var
  baseObj: TLlDOMItem;
begin
  if fZebraPattern <> nil then
  begin
    result := fZebraPattern
  end
  else
  begin
    baseObj := GetObject('ZebraPattern');
    fZebraPattern := TLlDOMPropertyFilling.Create(baseObj);
    baseObj.Free;
    result := fZebraPattern;
  end;
end;

procedure TLlDOMPropertyValueAxisBase.SetIntermediateTickCount
  (const value: TString);
begin
  SetProperty('IntermediateTickCount', value);
end;

procedure TLlDOMPropertyValueAxisBase.SetNullValueHandling(
  const Value: TString);
begin
  SetProperty('NullValueHandling', value);
end;

procedure TLlDOMPropertyValueAxisBase.SetTickmarkColor(const value: TString);
begin
  SetProperty('TickmarkColor', value);
end;

function TLlDOMPropertyValueAxisBase.GetGetSignalRanges
  : TLlDOMPropertyGetSignalRanges;
var
  baseObj: TLlDOMItem;
begin
  if fGetSignalRanges <> nil then
  begin
    result := fGetSignalRanges
  end
  else
  begin
    baseObj := GetObject('SignalRanges');
    fGetSignalRanges := TLlDOMPropertyGetSignalRanges.Create(baseObj);
    baseObj.Free;
    result := fGetSignalRanges;
  end;
end;

function TLlDOMPropertyValueAxisBase.GetBubbleChartMode: TString;
begin
  result := GetProperty('BubbleChartMode');
end;

procedure TLlDOMPropertyValueAxisBase.SetBubbleChartMode(const value: TString);
begin
  SetProperty('BubbleChartMode', value);
end;

procedure TLlDOMPropertyValueAxisBase.SetFilterZeroes(const Value: TString);
begin
  SetProperty('FilterZeroes', value);
end;

{ TLlDOMPropertyValueAxisBubbleChartSorted }

destructor TLlDOMPropertyValueAxisBubbleChartSorted.Destroy;
begin
  fBubbleDesign.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisBubbleChartSorted.GetBubbleDesign
  : TLlDOMPropertyBubbleDesign;
var
  baseObj: TLlDOMItem;
begin
  if fBubbleDesign <> nil then
  begin
    result := fBubbleDesign
  end
  else
  begin
    baseObj := GetObject('BubbleDesign');
    fBubbleDesign := TLlDOMPropertyBubbleDesign.Create(baseObj);
    baseObj.Free;
    result := fBubbleDesign;
  end;
end;

function TLlDOMPropertyValueAxisBubbleChartSorted.GetBubbleSize: TString;
begin
  result := GetProperty('BubbleSize');
end;

procedure TLlDOMPropertyValueAxisBubbleChartSorted.SetBubbleSize
  (const value: TString);
begin
  SetProperty('BubbleSize', value);
end;

{ TLlDOMPropertyBubbleDesign }

destructor TLlDOMPropertyBubbleDesign.Destroy;
begin
  fFileinfo.Free;
  inherited;
end;

function TLlDOMPropertyBubbleDesign.GetDesignMode: TString;
begin
  result := GetProperty('DesignMode');
end;

function TLlDOMPropertyBubbleDesign.GetFileinfo: TLlDOMPropertyFileInfo;
var
  baseObj: TLlDOMItem;
begin
  if fFileinfo <> nil then
  begin
    result := fFileinfo
  end
  else
  begin
    baseObj := GetObject('FileInfo');
    fFileinfo := TLlDOMPropertyFileInfo.Create(baseObj);
    baseObj.Free;
    result := fFileinfo;
  end;
end;

function TLlDOMPropertyBubbleDesign.GetSizeFactor: TString;
begin
  result := GetProperty('SizeFactor');
end;

procedure TLlDOMPropertyBubbleDesign.SetDesignMode(const value: TString);
begin
  SetProperty('DesignMode', value);
end;

procedure TLlDOMPropertyBubbleDesign.SetSizeFactor(const value: TString);
begin
  SetProperty('SizeFactor', value);
end;

{ TLlDOMPropertyValueAxisBubbleChartScattered }

destructor TLlDOMPropertyValueAxisBubbleChartScattered.Destroy;
begin
  fMin.Free;
  fMax.Free;
  fBubbleDesign.Free;
  inherited;
end;

function TLlDOMPropertyValueAxisBubbleChartScattered.GetAxisScale: TString;
begin
  result := GetProperty('AxisScale');
end;

function TLlDOMPropertyValueAxisBubbleChartScattered.GetBubbleDesign
  : TLlDOMPropertyBubbleDesign;
var
  baseObj: TLlDOMItem;
begin
  if fBubbleDesign <> nil then
  begin
    result := fBubbleDesign
  end
  else
  begin
    baseObj := GetObject('BubbleDesign');
    fBubbleDesign := TLlDOMPropertyBubbleDesign.Create(baseObj);
    baseObj.Free;
    result := fBubbleDesign;
  end;
end;

function TLlDOMPropertyValueAxisBubbleChartScattered.GetBubbleSize: TString;
begin
  result := GetProperty('BubbleSize');
end;

function TLlDOMPropertyValueAxisBubbleChartScattered.GetMax
  : TLlDOMPropertyRange;
var
  baseObj: TLlDOMItem;
begin
  if fMax <> nil then
  begin
    result := fMax
  end
  else
  begin
    baseObj := GetObject('Max');
    fMax := TLlDOMPropertyRange.Create(baseObj);
    baseObj.Free;
    result := fMax;
  end;
end;

function TLlDOMPropertyValueAxisBubbleChartScattered.GetMin
  : TLlDOMPropertyRange;
var
  baseObj: TLlDOMItem;
begin
  if fMin <> nil then
  begin
    result := fMin
  end
  else
  begin
    baseObj := GetObject('Min');
    fMin := TLlDOMPropertyRange.Create(baseObj);
    baseObj.Free;
    result := fMin;
  end;
end;

procedure TLlDOMPropertyValueAxisBubbleChartScattered.SetAxisScale
  (const value: TString);
begin
  SetProperty('AxisScale', value);
end;

procedure TLlDOMPropertyValueAxisBubbleChartScattered.SetBubbleSize
  (const value: TString);
begin
  SetProperty('BubbleSize', value);
end;

{ TLlDOMPropertyCoordinateLabelPlacement }

destructor TLlDOMPropertyCoordinateLabelPlacement.Destroy;
begin
  fFrame.Free;
  inherited;
end;

function TLlDOMPropertyCoordinateLabelPlacement.GetEquidistant: TString;
begin
  result := GetProperty('Equidistant');
end;

function TLlDOMPropertyCoordinateLabelPlacement.GetFrame: TLlDOMPropertyFrame;
var
  baseObj: TLlDOMItem;
begin
  if fFrame <> nil then
  begin
    result := fFrame
  end
  else
  begin
    baseObj := GetObject('Frame');
    fFrame := TLlDOMPropertyFrame.Create(baseObj);
    baseObj.Free;
    result := fFrame;
  end;
end;

function TLlDOMPropertyCoordinateLabelPlacement.GetPlacement: TString;
begin
  result := GetProperty('Placement');
end;

procedure TLlDOMPropertyCoordinateLabelPlacement.SetEquidistant
  (const value: TString);
begin
  SetProperty('Equidistant', value);
end;

procedure TLlDOMPropertyCoordinateLabelPlacement.SetPlacement
  (const value: TString);
begin
  SetProperty('Placement', value);
end;

{RScript Chart}
function TLlDOMPropertyRScriptCommonVarExport.GetRScriptCommonChartColors: TString;
begin
     result:= GetProperty('RScriptCommonVarExport');
end;

function TLlDOMPropertyRScriptCommonVarExport.GetRScriptCommonExtents: TString;
begin
     result:= GetProperty('RScriptCommonVarExport');
end;

function TLlDOMPropertyRScriptCommonVarExport.GetRScriptCommonNamedColors: TString;
begin
     result:= GetProperty('RScriptCommonVarExport');
end;

function TLlDOMPropertyRScriptCommonVarExport.GetRScriptCommonSchemeColors: TString;
begin
     result:= GetProperty('RScriptCommonVarExport');
end;

procedure TLlDOMPropertyRScriptCommonVarExport.SetRScriptCommonChartColors(const value: TString);
begin
    SetProperty('RScriptCommonVarExport', value);
end;

procedure TLlDOMPropertyRScriptCommonVarExport.SetRScriptCommonExtents(const value: TString);
begin
    SetProperty('RScriptCommonVarExport', value);
end;

procedure TLlDOMPropertyRScriptCommonVarExport.SetRScriptCommonNamedColors(const value: TString);
begin
    SetProperty('RScriptCommonVarExport', value);
end;

procedure TLlDOMPropertyRScriptCommonVarExport.SetRScriptCommonSchemeColors(const value: TString);
begin
    SetProperty('RScriptCommonVarExport', value);
end;

function TLlDOMPropertyRScriptDataEntryItem.GetEnabled: TString;
begin
    result:= GetProperty('Enabled');
end;

function TLlDOMPropertyRScriptDataEntryItem.GetFormula: TString;
begin
    result:=  GetProperty('Formula');
end;

function TLlDOMPropertyRScriptDataEntryItem.GetPrefix: TString;
begin
    result:=  GetProperty('Prefix');
end;

function TLlDOMPropertyRScriptDataEntryItem.GetPrefixType: TString;
begin
    result:=  GetProperty('PrefixType');
end;

function TLlDOMPropertyRScriptDataEntryItem.GetVarName: TString;
begin
    result:=  GetProperty('VarName');
end;

procedure TLlDOMPropertyRScriptDataEntryItem.SetEnabled(const value: TString);
begin
    SetProperty('Enabled', value);
end;

procedure TLlDOMPropertyRScriptDataEntryItem.SetFormula(const value: TString);
begin
    SetProperty('Formula', value);
end;

procedure TLlDOMPropertyRScriptDataEntryItem.SetPrefix(const value: TString);
begin
    SetProperty('', value);
end;

procedure TLlDOMPropertyRScriptDataEntryItem.SetPrefixType(const value: TString);
begin
    SetProperty('PrefixType', value);
end;

procedure TLlDOMPropertyRScriptDataEntryItem.SetVarname(const value: TString);
begin
    SetProperty('Varname', value);
end;

function TLlDOMPropertyRScriptData.GetRSCode: TString;
begin
  result:= GetProperty('RSCode');
end;

destructor TLlDOMPropertyRScriptData.Destroy;
begin
  fRScriptEntryItems.free;
end;
procedure TLlDOMPropertyRScriptData.SetRSCode(const value: TString);
begin
  SetProperty('RSCode', value);
end;

function TLlDOMPropertyRScriptData.GetRScriptEntryItemsList
  : TLlDOMRScriptEntryItemsList;
begin
  if fRScriptEntryItems = nil then
  begin
    fRScriptEntryItems := TLlDOMRScriptEntryItemsList.Create
      (GetObject('Entries').GetObject('Items'));
  end;
  result := fRScriptEntryItems;
end;

function TLlDOMPropertyRScriptOutputExtension.GetContents;
begin
  result:= GetProperty('Contents');
end;

function TLlDOMPropertyRScriptOutputExtension.GetRScriptOOPointsize;
begin
  result:= GetProperty('RScriptOOPointsize');
end;

function TLlDOMPropertyRScriptOutputExtension.GetRScrptOORes;
begin
  result:= GetProperty('RscriptOORes');
end;

procedure TLlDOMPropertyRScriptOutputExtension.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyRScriptOutputExtension.SetRScriptOOPointsize(const value: TString);
begin
  SetProperty('RScriptOOPointsize', value);
end;

procedure TLlDOMPropertyRScriptOutputExtension.SetRscriptOORes(const value: TString);
begin
  SetProperty('RscriptOORes', value);
end;

destructor TLlDOMPropertyChartEngineRscript.Destroy;
begin
  fRScriptData.free;
  fRScriptOutputExtension.Free;
  fRScriptCommonVarExport.Free;
end;

function TLlDOMPropertyChartEngineRscript.GetDataSamplesForDesigner: TString;
begin
  result:= GetProperty('DataSamplesForDesigner');
end;

function TLlDOMPropertyChartEngineRscript.GetRScriptTimeoutMS: TString;
begin
  result:= GetProperty('RScriptTimeoutMS');
end;

function TLlDOMPropertyChartEngineRscript.GetRScriptEnableRealtimePreview: TString;
begin
  result:= GetProperty('RScriptEnableRealtimePreview');
end;

function TLlDOMPropertyChartEngineRscript.GetRScriptData: TLlDOMPropertyRScriptData;
var
  baseObj: TLlDOMItem;
begin
  if fRScriptData <> nil then
  begin
    result := fRScriptData
  end
  else
  begin
    baseObj := GetObject('RScriptData');
    fRScriptData := TLlDOMPropertyRScriptData.Create(baseObj);
    baseObj.Free;
    result := fRScriptData;
  end;
end;

function TLlDOMPropertyChartEngineRscript.GetRScriptOutputExtension: TLlDOMPropertyRScriptOutputExtension;
var
  baseObj: TLlDOMItem;
begin
  if fRScriptOutputExtension<> nil then
  begin
    result := fRScriptOutputExtension
  end
  else
  begin
    baseObj := GetObject('RScriptOutputExtension');
    fRScriptOutputExtension := TLlDOMPropertyRScriptOutputExtension.Create(baseObj);
    baseObj.Free;
    result := fRScriptOutputExtension;
  end;
end;

function TLlDOMPropertyChartEngineRscript.GetRScriptCommonVarExport: TLlDOMPropertyRScriptCommonVarExport;
var
  baseObj: TLlDOMItem;
begin
  if fRScriptCommonVarExport <> nil then
  begin
    result := fRScriptCommonVarExport
  end
  else
  begin
    baseObj := GetObject('RScriptCommonVarExport');
    fRScriptCommonVarExport := TLlDOMPropertyRScriptCommonVarExport.Create(baseObj);
    baseObj.Free;
    result := fRScriptCommonVarExport;
  end;

end;

procedure TLlDOMPropertyChartEngineRscript.SetDataSamplesForDesigner(const value: TString);
begin
  SetProperty('DataSamplesForDesigner', value);
end;

procedure TLlDOMPropertyChartEngineRscript.SetRScriptTimeoutMS(const value: TString);
begin
  SetProperty('RScriptTimeoutMS', value);
end;

procedure TLlDOMPropertyChartEngineRscript.SetRScriptEnableRealtimePreview(const value: TString);
begin
  SetProperty('RScriptEnableRealtimePreview', value);
end;


procedure TLlDOMRScriptEntryItemsList.Initialize;

var
  nObjCount: integer;
  baseObj: TLlDOMItem;
  newDomObj: TLlDOMPropertyRScriptDataEntryItem;
  i: integer;
begin
  nObjCount := fDOMObj.GetSubObjectCount();
  for i := 0 to nObjCount - 1 do
  begin
    baseObj := fDOMObj.GetSubObject(i);
    newDomObj := TLlDOMPropertyRScriptDataEntryItem.Create(baseObj);
    baseObj.Free;
    Add(newDomObj);
  end;

end;

function TLlDOMRScriptEntryItemsList.GetItems(index: integer)
  : TLlDOMPropertyRScriptDataEntryItem;
begin
  result := TLlDOMPropertyRScriptDataEntryItem(inherited Items[index]);
end;

procedure TLlDOMRScriptEntryItemsList.SetItems(index: integer;
  const value: TLlDOMPropertyRScriptDataEntryItem);
begin
  inherited Items[index] := value;
end;

function TLlDOMRScriptEntryItemsList.Add
  (domObj: TLlDOMPropertyRScriptDataEntryItem): integer;
begin
  result := inherited Add(domObj);
end;

constructor TLlDOMRScriptEntryItemsList.Create(hDomObj: TLlDOMItem);
begin
  inherited Create();
  fDOMObj := hDomObj;

  Initialize();
end;

destructor TLlDOMRScriptEntryItemsList.Destroy;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Free;
  end;
  fDOMObj.Free;
  inherited;
end;

function TLlDOMRScriptEntryItemsList.NewItem(index: integer): TLlDOMItem;
var
  newDomObj: TLlDOMPropertyRScriptDataEntryItem;
begin
  newDomObj := TLlDOMPropertyRScriptDataEntryItem.Create;
  newDomObj.fDomHandle := fDOMObj.CreateSubObject(Index, 'Entries');
  result := newDomObj;

end;


{ TLlDOMPropertyCrosstabShadowBase }



function TLlDOMPropertyCrosstabShadowBase.GetActive: TString;
begin
  result := GetProperty('Active');
end;

procedure TLlDOMPropertyCrosstabShadowBase.SetActive(const value: TString);
begin
  SetProperty('Active', value);
end;

{ TLlDOMPropertyGanttShadowPages }

function TLlDOMPropertyGanttShadowPages.GetRepeatLabels: TString;
begin
  result := GetProperty('RepeatLabels');
end;

procedure TLlDOMPropertyGanttShadowPages.SetRepeatLabels(const value: TString);
begin
  SetProperty('RepeatLabels', value);
end;

{ TLlDOMPropertyAnchor }

function TLlDOMPropertyAnchor.GetContents: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyAnchor.GetToTop: TString;
begin
  result := GetProperty('ToTop');
end;

procedure TLlDOMPropertyAnchor.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyAnchor.SetToTop(const value: TString);
begin
  SetProperty('ToTop', value);
end;

{ TLlDOMPropertyPostalData }

function TLlDOMPropertyPostalData.GetContens: TString;
begin
  result := GetProperty('Contents');
end;

function TLlDOMPropertyPostalData.GetPremiumAddressId: TString;
begin
  result := GetProperty('PremiumAddressId');
end;

procedure TLlDOMPropertyPostalData.SetContents(const value: TString);
begin
  SetProperty('Contents', value);
end;

procedure TLlDOMPropertyPostalData.SetPremiumAddressId(const value: TString);
begin
  SetProperty('PremiumAddressId', value);
end;

{ TLlDOMPropertyPremiumAdress }

destructor TLlDOMPropertyPremiumAdress.Destroy;
begin
  fPostalData.Free;
  inherited;
end;

function TLlDOMPropertyPremiumAdress.GetCustomerInfos: TString;
begin
  result := GetProperty('CustomerInfos');
end;

function TLlDOMPropertyPremiumAdress.GetCustomerNo: TString;
begin
  result := GetProperty('CustomerNo');
end;

function TLlDOMPropertyPremiumAdress.GetEDSNumber: TString;
begin
  result := GetProperty('EDSNumber');
end;

function TLlDOMPropertyPremiumAdress.GetFee: TString;
begin
  result := GetProperty('Fee');
end;

function TLlDOMPropertyPremiumAdress.GetPostalData: TLlDOMPropertyPostalData;
var
  baseObj: TLlDOMItem;
begin
  if fPostalData <> nil then
  begin
    result := fPostalData
  end
  else
  begin
    baseObj := GetObject('PostalData');
    fPostalData := TLlDOMPropertyPostalData.Create(baseObj);
    baseObj.Free;
    result := fPostalData;
  end;
end;

function TLlDOMPropertyPremiumAdress.GetProcessingData: TString;
begin
  result := GetProperty('ProcessingData');
end;

function TLlDOMPropertyPremiumAdress.GetProductKey: TString;
begin
  result := GetProperty('ProductKey');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine1: TString;
begin
  result := GetProperty('RecipientLine1');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine2: TString;
begin
  result := GetProperty('RecipientLine2');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine3: TString;
begin
  result := GetProperty('RecipientLine3');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine4: TString;
begin
  result := GetProperty('RecipientLine4');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine5: TString;
begin
  result := GetProperty('RecipientLine5');
end;

function TLlDOMPropertyPremiumAdress.GetRecipientLine6: TString;
begin
  result := GetProperty('RecipientLine6');
end;

function TLlDOMPropertyPremiumAdress.GetSenderAddress: TString;
begin
  result := GetProperty('SenderAddress');
end;

function TLlDOMPropertyPremiumAdress.GetTrackingNumber: TString;
begin
  result := GetProperty('TrackingNumber');
end;

procedure TLlDOMPropertyPremiumAdress.SetCustomerInfos(const value: TString);
begin
  SetProperty('CustomerInfos', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetCustomerNo(const value: TString);
begin
  SetProperty('CustomerNo', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetEDSNumber(const value: TString);
begin
  SetProperty('EDSNumber', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetFee(const value: TString);
begin
  SetProperty('Fee', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetProcessingData(const value: TString);
begin
  SetProperty('ProcessingData', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetProductKey(const value: TString);
begin
  SetProperty('ProductKey', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine1(const value: TString);
begin
  SetProperty('RecipientLine1', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine2(const value: TString);
begin
  SetProperty('RecipientLine2', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine3(const value: TString);
begin
  SetProperty('RecipientLine3', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine4(const value: TString);
begin
  SetProperty('RecipientLine4', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine5(const value: TString);
begin
  SetProperty('RecipientLine5', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetRecipientLine6(const value: TString);
begin
  SetProperty('RecipientLine6', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetSenderAddress(const value: TString);
begin
  SetProperty('SenderAddress', value);
end;

procedure TLlDOMPropertyPremiumAdress.SetTrackingNumber(const value: TString);
begin
  SetProperty('TrackingNumber', value);
end;

{ TLlDOMPropertyXhtmlAnimation }

destructor TLlDOMPropertyXhtmlAnimation.Destroy;
begin
  inherited;
end;

function TLlDOMPropertyXhtmlAnimation.GetAnimation: TString;
begin
  result:= GetProperty('Animation');
end;

function TLlDOMPropertyXhtmlAnimation.GetAnimationTime: TString;
begin
  result:= GetProperty('AnimationTime');
end;

function TLlDOMPropertyXhtmlAnimation.GetTriggerDelay: TString;
begin
  result:= GetProperty('TriggerDelay');
end;

procedure TLlDOMPropertyXhtmlAnimation.SetAnimation(const value: TString);
begin
  SetProperty('Amimation', value);
end;

procedure TLlDOMPropertyXhtmlAnimation.SetAnimationTime(const value: TString);
begin
  SetProperty('AnimationTime', value);
end;

procedure TLlDOMPropertyXhtmlAnimation.SetTriggerDelay(const value: TString);
begin
  SetProperty('TriggerDelay', value);
end;

function GetProfContentsFromVariant(input: PCVARIANT) :TString;
var
  {$ifdef VER90}
  Content: Variant;
  {$else}
  Content: OleVariant;
  {$endif}
begin
  VariantInit(Content);
  cmbTLl28x.LlUtilsGetProfContentsFromVariantInternal(input, PVARIANT(@Content));
  result:= Content;
  VariantClear(Content);

end;

function GetVariantFromProfContents(text: PWideChar): OleVariant;
var
  {$ifdef VER90}
  Content: Variant;
  {$else}
  Content: OleVariant;
  {$endif}

begin
  VariantInit(Content);
  cmbTLl28x.LlUtilsGetVariantFromProfContentsInternal(text, PVARIANT(@Content));
  result:= Content;
 VariantClear(Content);
end;

constructor TLlDOMTableFieldTable.Create(list: TLlDOMTableLineFieldList);
begin
  inherited Create(list, 'SubTableList', list.Count);
end;

destructor TLlDOMTableFieldTable.Destroy;
begin
  fSubItems.Free;
  inherited;
end;

function TLlDOMTableFieldTable.GetReservedMinHeight: string;
begin
  Result := GetProperty('ReservedMinHeight');
end;

function TLlDOMTableFieldTable.GetSubItems: TLlDOMSubItemCoreList;
begin
  if fSubItems = nil then
    fSubItems := TLlDOMSubItemCoreList.Create(GetObject('SubItems'));
  result := fSubItems;
end;

procedure TLlDOMTableFieldTable.SetReservedMinHeight(const Value: string);
begin
  SetProperty('ReservedMinHeight', Value);
end;


end.


