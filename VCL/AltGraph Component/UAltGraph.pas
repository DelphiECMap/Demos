unit UAltGraph;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Vcl.ExtCtrls,
  uecNativeMapControl,uecnativeshape, uecMapUtil,
  uecEditNativeLine,ecAltGraph,altGraphComponent ;

type
  TFormAltGraph = class(TForm)
    Panel1: TPanel;
    btAddRoute: TButton;
    LB: TListBox;
    map: TECNativeMap;
    info: TLabel;
    ckVisible: TCheckBox;
    procedure btAddRouteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ckVisibleClick(Sender: TObject);
  private
    { Déclarations privées }
     PA, PB: TECShapePoi;

     FAltCmp : TAltGraphComponent;

    procedure doOnAddRoute(sender: TECShapeLine; const params: string);
    procedure doOnLineClick(sender: TObject; const item: TECShape);

    procedure doOnAltitudes(sender: TObject);
    procedure doOnBeginAltitudes(sender: TObject);

    procedure doOnHoverPoint(const sender: TObject; const Latitude,Longitude, Km : double; const Altitude : integer)  ;
    procedure doOnClickPoint(const sender: TObject; const Latitude,Longitude, Km : double; const Altitude : integer)  ;
    procedure doOnLeavePoint(sender: TObject);

  public
    { Déclarations publiques }
  end;

var
  FormAltGraph: TFormAltGraph;

implementation

{$R *.dfm}


// This demo shows you how to use a component to overlay a line profile on the map.


procedure TFormAltGraph.FormCreate(Sender: TObject);
begin

 // doOnAddRoute will be called when the route has been calculated
 Map.Routing.OnAddRoute := doOnAddRoute;

 // By default, the routing engine is reOpenStreetMap.
 //Map.Routing.engine(reValhalla);


  // PA and PB will be used to define the starting and ending points of the route.
  PA := Map.AddPOI(Map.Latitude, Map.Longitude);
  PA.POIShape := poiDiamond;
  PA.Draggable := true;
  PA.Description := 'A';
  PA.WithEgalHeight := true;
  PA.Width := 48;
  PA.YAnchor := 24;

  PB := Map.AddPOI(Map.Latitude, Map.Longitude+0.0005);
  PB.POIShape := poiDiamond;
  PB.Draggable := true;
  PB.WithEgalHeight := true;
  PB.Width := 48;
  PB.YAnchor := 24;
  PB.Description := 'B';

  // Enable label display for points
  // By default, the Description field is used as the content source.
  Map.Shapes.Pois.Labels.Visible := true;
  Map.Shapes.Pois.Labels.Style := lsTransparent;
  Map.Shapes.Pois.Labels.Align := lacenter;
  Map.Shapes.Pois.Labels.ColorType := lcContrasting;
  Map.Shapes.Pois.Labels.fontsize := 11;

  // Creation of the AltGraph component
  FAltCmp := TAltGraphComponent.Create(Map);
  ckVisible.Checked := true;

  // Triggered before the altitude calculation request
  FAltCmp.Graph.OnBeginAltitude := doOnBeginAltitudes;
  // Triggered when altitudes are available
  FAltCmp.Graph.OnAltitude := doOnAltitudes;
  // Triggered when a point is hovered over, whether on the chart or on the line
  FAltCmp.Graph.OnHoverPoint := doOnHoverPoint;
  // Triggered when a point is clicked, whether on the chart or on the line
  FAltCmp.Graph.OnClickPoint := doOnClickPoint;
  // Triggered when leaving the chart or line
  FAltCmp.Graph.OnLeavePoint := doOnLeavePoint;

  (*

    FAltCmp.Graph.Graph allows you to style the graph

     BackGroundColor (white), GraphColor (red), AxeColor (black)
     FontSize (default 12 under FMX and 9 with VCL
     MaxTickX, MaxTickY number of graduations on the axes (default 8 and 4)

     AltLegende (default 'Altitude in m')
     DistLegende (default 'Distance in KM')

  *)

end;

procedure TFormAltGraph.FormDestroy(Sender: TObject);
begin
 FAltCmp.Free;
end;

procedure TFormAltGraph.ckVisibleClick(Sender: TObject);
begin
  FAltCmp.visible := ckVisible.Checked;
end;


// Request to calculate the route between points A and B
procedure TFormAltGraph.btAddRouteClick(Sender: TObject);
begin
   btAddRoute.Enabled := false;
   Map.Routing.Request([PA.Latitude, PA.Longitude, PB.Latitude, PB.Longitude]);
end;


// The route (sender) has been calculated and displayed on the map.
procedure TFormAltGraph.doOnAddRoute(sender: TECShapeLine; const params: string);
begin

  sender.ShowText     := false;
  sender.Hint         := 'Click for select';
  sender.color        := getRandomPastelColor;
  // triggered by clicking on the line
  sender.OnShapeClick := doOnLineClick;


  (*
   The profile will not be calculated directly on the points of the line,
   but a fictitious line will be superimposed on it,
   with all points approximately AltitudeSegmentLength meters apart.

   This allows for a more harmonious graph.

   default FAltCmp.Graph.AltitudeSegmentLength = 250 meters
  *)
  // Displaying the line profile
  FAltCmp.Graph.Line  := sender;

  // The graph will take on the color of the line. You can change it like this.
  // FAltCmp.Graph.graph.GraphColor := clGreen;


end;

// Displaying the line profile
procedure TFormAltGraph.doOnLineClick(sender: TObject; const item: TECShape);
begin
  FAltCmp.Graph.Line := TECShapeLine(item);
end;


procedure TFormAltGraph.doOnLeavePoint(sender: TObject);
begin
  info.caption := '';
end;


procedure TFormAltGraph.doOnHoverPoint(const sender: TObject; const Latitude,Longitude, Km : double; const Altitude : integer);
begin

  info.caption := 'Hover : '+doubletostrDigit(Latitude,4)+' '+doubletostrDigit(Longitude,4)
                  +#13#10+doubletostrDigit(Km,2)+' Km '+inttostr(Altitude)+' m';

end;

procedure TFormAltGraph.doOnClickPoint(const sender: TObject; const Latitude,Longitude, Km : double; const Altitude : integer);
begin

  info.caption := 'Click : '+doubletostrDigit(Latitude,4)+' '+doubletostrDigit(Longitude,4)
                  +#13#10+doubletostrDigit(Km,2)+' Km '+inttostr(Altitude)+' m';

end;

procedure TFormAltGraph.doOnBeginAltitudes(sender: TObject);
begin
  LB.items.clear;
  LB.items.Add('waiting altitudes...');
end;

// Altitudes are available, sender = FAltCmp.Graph
procedure TFormAltGraph.doOnAltitudes(sender: TObject);
var
  i: integer;
  L: TECShapeLine;
  D: Double;
begin

  btAddRoute.Enabled := true;

  if not (sender is TECAltitudeGraph ) then
    exit;

  // AltitudeLine is the imaginary line where all points
  // are TECAltitudeGraph(sender).AltitudeSegmentLength apart from each other.
  L := TECAltitudeGraph(sender).AltitudeLine;


  LB.items.BeginUpdate;
  LB.items.clear;
  LB.items.Add('Distance : '+doubletostr(L.Distance)+' km');
  for i := 0 to L.Count - 1 do
  begin
    D := (L.Path[i].Distance);

    LB.items.Add(doubletostr(D / 1000) + ' km : ' + doubletostr(L.Path[i].Alt)+' m');
  end;

  LB.items.EndUpdate;

end;

end.
