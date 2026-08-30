unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, UECNativeShape,
  Vcl.ExtCtrls, Vcl.StdCtrls,
  uecMapUtil, System.Threading, System.Diagnostics, Vcl.ComCtrls,
  OSMPBF.Types, OSMPBF.Reader, OSMPBF.Converter, OSMPBF.TECShapes;

type
  TFormOSMPBFToTECNativeMap = class(TForm)
    pFilename: TPanel;
    Panel2: TPanel;
    map: TECNativeMap;
    btOpen: TButton;
    OpenDialog1: TOpenDialog;
    ProgressBar: TProgressBar;
    btAbort: TButton;
    btCount: TButton;
    Log: TMemo;
    btImportPBF: TButton;
    btClearZones: TButton;
    btClearMap: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure btAbortClick(Sender: TObject);
    procedure btClearMapClick(Sender: TObject);
    procedure btClearZonesClick(Sender: TObject);
    procedure btCountClick(Sender: TObject);
    procedure btImportPBFClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure mapShapeClick(sender: TObject; const item: TECShape);
  private
    { Déclarations privées }

    FOsmPbfFilename: string;

    SW: TStopwatch;

    Conv: TOSMPBFTECShapesConverter;

    Shapes, PBFZones: TECShapes;

    CSWLat, CSWLng, CNELat, CNELng: double;

    CountNodes, CountWays, CountRelations, BlocksDone: int64;

    NodesRead: int64;
    WaysRead: int64;
    RelationsRead: int64;

    procedure ResetUI;
    procedure doConvertShapes;

    procedure doMapSelectRect(sender: TObject; const SWLat, SWLng, NELat, NELng:
      Double);
    procedure doProgressConvert(AProcessedBytes, ATotalBytes: Int64;
      ABlocksDone: Integer);

    function doContinue: boolean;

    procedure ReadAndDump(const AFileName: string);

  public
    { Déclarations publiques }
  end;

var
  FormOSMPBFToTECNativeMap: TFormOSMPBFToTECNativeMap;

implementation

{$R *.dfm}

procedure TFormOSMPBFToTECNativeMap.FormCreate(Sender: TObject);
begin

  // group that will contain the elements imported from the osm.pbf file
  Shapes := Map['OSMPBF'];
  Shapes.DefaultOsmStyle;


  PBFZones := Map['ZONES'];

  // Clicking on the bounding box of the OSM PBF file is prohibited.
  map.shapes.Clickable := false;

  Conv := TOSMPBFTECShapesConverter.Create(Shapes);

  Conv.OnProgress := doProgressConvert;
  Conv.OnContinue := doContinue;
  Conv.OSMTypeFilter := conv.OSMTypeFilter - [mtRelation];

end;

procedure TFormOSMPBFToTECNativeMap.FormDestroy(Sender: TObject);
begin
  Conv.free;
end;

procedure TFormOSMPBFToTECNativeMap.btOpenClick(Sender: TObject);
var
  FOsmPbf: TOSMPBFReader;
  FHeader: TOSMHeader;
  SouthWest, NorthEast: TLatLng;
  PbfArea: TECShapePolygone;
begin

  if OpenDialog1.execute then
  begin
    Log.lines.clear;
    FOsmPbfFilename := '';

    FOsmPbf := TOSMPBFReader.Create;
    try
      FHeader := FOsmPbf.ReadHeaderOnly(OpenDialog1.filename);
      if FHeader.HasBBox then
      begin
        SouthWest.Lat := FHeader.BBox.Bottom;
        SouthWest.Lng := FHeader.BBox.Left;
        NorthEast.Lat := FHeader.BBox.top;
        NorthEast.lng := FHeader.BBox.Right;

        //  OSM file's bounding box
        PbfArea := map.AddPolygone(SouthWest, NorthEast);
        PbfArea.FillOpacity := 0;
        PbfArea.BorderSize := 4;
        PbfArea.fitBounds;

        FOsmPbfFilename := OpenDialog1.filename;

        btCount.Enabled := true;

        Log.lines.add(OpenDialog1.filename);

        // Enable selection of a rectangular area by right-clicking and dragging
        // The OnMapSelectRect event is triggered when the mouse button is released
        map.DragRect := drManualSelect;
        map.OnMapSelectRect := doMapSelectRect;

        Shapes.clear;

        ResetUI;
      end;
    finally
      FOsmPbf.free;
    end;
  end;

end;

procedure TFormOSMPBFToTECNativeMap.btCountClick(Sender: TObject);
var
  aTask: ITask;
begin
  btAbort.Enabled := true;
  aTask := TTask.Create(
    procedure
    begin
      ReadAndDump(FOsmPbfFilename);
    end);
  aTask.Start;

end;

// Iterate through the entire file and count all the elements
procedure TFormOSMPBFToTECNativeMap.ReadAndDump(const AFileName: string);
var
  R: TOSMPBFReader;

begin
  R := TOSMPBFReader.Create;
  try

    R.OnProgress := doProgressConvert;
    R.OnContinue := doContinue;
    // Parallel decoding of PrimitiveBlocks
    R.Parallel := true;

    SW := TStopwatch.StartNew;
    SW.Start;

    R.ReadFromFile(AFileName);

    SW.Stop;

    CountNodes := R.CountNodes;
    CountWays := R.CountWays;
    CountRelations := R.CountRelations;
    BlocksDone := R.BlocksDone;

    // We update UI in the main thread using Queue
    TThread.Queue(nil, procedure
      begin

        var sTime: string;

        if SW.ElapsedMilliseconds < 1000 then
          sTime := Format('%d ms', [SW.ElapsedMilliseconds])
        else
          sTime := Format('%s', [SecondeToTimeStr(SW.ElapsedMilliseconds div 1000)]);

        ProgressBar.Position := 0;
        if btAbort.tag = 0 then
          Log.lines.add(Format('nodes: %d - ', [R.CountNodes]) +
            Format('ways : %d - ', [R.CountWays]) +
            Format('rel. : %d - ', [R.CountRelations]) +
            Format('blc. : %d - ', [R.BlocksDone]) +
            Format('time : %s', [sTime]));

        btAbort.Tag := 0;

        btAbort.Enabled := false;

      end);
  finally
    R.Free;
  end;
end;

// Add a zone to import
procedure TFormOSMPBFToTECNativeMap.doMapSelectRect(sender: TObject; const SWLat,
  SWLng, NELat, NELng: Double);
var
  SouthWest, NorthEast: TLatLng;
begin

  Conv.AddZone(SWLng, SWLat, NELng, NELat);

  SouthWest.Lat := SWLat;
  SouthWest.Lng := SWLng;
  NorthEast.Lat := NELat;
  NorthEast.Lng := NELng;

  PBFZones.AddPolygone(SouthWest, NorthEast);

  btImportPBF.Enabled := true;

end;

// Set up the UI, then start the import in a task
procedure TFormOSMPBFToTECNativeMap.btImportPBFClick(Sender: TObject);
var
  aTask: ITask;
begin

  btAbort.tag := 0;

  map.DragRect := drNone;

  btAbort.Enabled := true;
  // convert In a background task
  aTask := TTask.Create(
    procedure
    begin
      doConvertShapes;
    end);
  aTask.Start;

end;

// Import Selected Areas
procedure TFormOSMPBFToTECNativeMap.doConvertShapes;
begin

  SW := TStopwatch.StartNew;
  SW.Start;

  Conv.ConvertFromFile(FOsmPbfFilename, true);

  SW.Stop;

  // We update UI in the main thread using Queue
  TThread.Queue(nil, procedure
    begin

      var sTime: string;

      if SW.ElapsedMilliseconds < 1000 then
        sTime := Format('%d ms', [SW.ElapsedMilliseconds])
      else
        sTime := Format('%s', [SecondeToTimeStr(SW.ElapsedMilliseconds div 1000)]);

      if btAbort.tag = 0 then
        Log.lines.add(Format('pois: %d - ', [shapes.pois.count]) +
          Format('lines : %d - ', [shapes.lines.count]) +
          Format('polys : %d - ', [shapes.Polygones.count]) +
          Format('time : %s', [sTime]))
      else
      begin
        Shapes.clear;
      end;

      ResetUI;
    end);

end;

procedure TFormOSMPBFToTECNativeMap.doProgressConvert(AProcessedBytes, ATotalBytes:
  Int64; ABlocksDone: Integer);
begin
  ProgressBar.Position := (AProcessedBytes * 100) div ATotalBytes;
end;

function TFormOSMPBFToTECNativeMap.doContinue: boolean;
begin
  result := btAbort.Tag = 0;

  if not result then
    TThread.Queue(nil, procedure
      begin
        Log.Lines.add('Aborted...');
        ResetUI;
      end);

end;

// Response to a click on an element: display its OSM tags
procedure TFormOSMPBFToTECNativeMap.mapShapeClick(sender: TObject; const item:
  TECShape);
var

  Key, Value, content: string;

  win: TECShapeInfoWindow;
begin

  content := '';

  if item.PropertiesFindFirst(Key, Value) then
  begin
    repeat

      Key := Key + '<tab="110">';

      content := content + '<b>' + Key + '</b>: ' + Value + '<br>';

    until item.PropertiesFindNext(Key, Value);
  end;

  if content = '' then
    exit;

  content := '<h3>OpenStreetMap Data</h3><br>' + content + '<br>';

  // create window if not exists
  if map.group['info'].InfoWindows.count = 0 then
  begin
    map.group['info'].InfoWindows.add(0, 0, '');

    win := map.group['info'].InfoWindows[0];
    win.Zindex := 100;
    win.Width := 320;
    map.group['info'].Zindex := map.shapes.Zindex + 1;

  end
  else
    win := map.group['info'].InfoWindows[0];

  win.content := content;
  win.SetPosition(map.MouseLatLng.Lat, map.MouseLatLng.lng);
  win.Visible := true;

  // automatically close the window after 15 seconds
  win.Animation := TECAnimationAutoHide.Create;
  TECAnimationAutoHide(win.Animation).MaxTiming := 1000 * 15;

end;

procedure TFormOSMPBFToTECNativeMap.ResetUI;
begin
  btAbort.Tag := 0;
  ProgressBar.Position := 0;
  btAbort.Enabled := false;
  map.DragRect := drManualSelect;
  conv.ClearZones;
  PBFZones.clear;
  btImportPBF.Enabled := false;
end;

procedure TFormOSMPBFToTECNativeMap.btAbortClick(Sender: TObject);
begin
  btAbort.tag := 1;
end;

procedure TFormOSMPBFToTECNativeMap.btClearMapClick(Sender: TObject);
begin
  Shapes.Clear;
end;

procedure TFormOSMPBFToTECNativeMap.btClearZonesClick(Sender: TObject);
begin
  PBFZones.clear;
  btImportPBF.Enabled := false;
end;

end.

