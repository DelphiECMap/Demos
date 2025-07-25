unit UMAltGraph;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.ExtCtrls,
  uecNativeMapControl, uecNativeShape, uecMapUtil,ecAltGraph, Vcl.StdCtrls;

type
  TFMultiGraph = class(TForm)
    Panel1: TPanel;
    ViewGraphA: TImage;
    ViewGraphB: TImage;
    map: TECNativeMap;
    LabelA: TPanel;
    LabelB: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
   FGraphA,FGraphB : TECAltitudeGraph; // unit ecAltGraph
   FLineA,FLineB   : TECShapeLine;

   procedure doOnAddRoute(sender: TECShapeLine; const params: string);

   procedure doOnBeginAltitudes(sender: TObject);
   procedure doOnAltitudes(sender: TObject);

  public
    { Déclarations publiques }
  end;

var
  FMultiGraph: TFMultiGraph;

implementation

{$R *.dfm}

// This demo shows you how to display profiles outside the map.

procedure TFMultiGraph.FormCreate(Sender: TObject);
begin
 FGraphA := TECAltitudeGraph.Create(Map,ViewGraphA);
 // Triggered before the altitude calculation request
 FGraphA.OnBeginAltitude := doOnBeginAltitudes;
 // Triggered when altitudes are available
 FGraphA.OnAltitude      := doOnAltitudes;

 FGraphB := TECAltitudeGraph.Create(Map,ViewGraphB);
 FGraphB.OnBeginAltitude := doOnBeginAltitudes;
 FGraphB.OnAltitude      := doOnAltitudes;

// doOnAddRoute will be called when the route has been calculated
 Map.Routing.OnAddRoute := doOnAddRoute;

 // By default, the routing engine is reOpenStreetMap.
 //Map.Routing.engine(reValhalla);

  FLineA := map.addLine;
  FLineA.tag := 0;
  FLineB := map.addLine;
  FLineB.tag := 1;

  LabelA.Caption := 'Waiting for the road';
  LabelB.Caption := 'Waiting for the road';

  Map.Routing.Request('Tarbes','Lourdes', FLineA);
  Map.Routing.Request('Tarbes','Pau', FLineB);
end;

procedure TFMultiGraph.FormDestroy(Sender: TObject);
begin
 FGraphA.free;
 FGraphB.Free;
end;

// The road is available
procedure TFMultiGraph.doOnAddRoute(sender: TECShapeLine; const params: string);
begin
 sender.ShowText := false;
 sender.color    := getRandomPastelColor;
 // Adjust the map zoom to see the entire route
 sender.fitBounds;

 case sender.tag of
  0 : FGraphA.Line := Sender;
  1 : FGraphB.Line := Sender;
 end;
end;

// The request to obtain the altitudes will be launched.
procedure TFMultiGraph.doOnBeginAltitudes(sender: TObject);
begin
  if sender is TECAltitudeGraph then
  begin
    if TECAltitudeGraph(sender)=FGraphA  then
     LabelA.caption := 'Awaiting profile'
    else
     if TECAltitudeGraph(sender)=FGraphB  then
     LabelB.caption := 'Awaiting profile'

  end;

end;

// The altitudes have been obtained and the profile is displayed.
procedure TFMultiGraph.doOnAltitudes(sender: TObject);
begin
  if sender is TECAltitudeGraph then
  begin
    if TECAltitudeGraph(sender)=FGraphA  then
     LabelA.caption := 'Tarbes-Lourdes profile'
    else
     if TECAltitudeGraph(sender)=FGraphB  then
     LabelB.caption := 'Tarbes-Pau profile'

  end;
end;

end.
