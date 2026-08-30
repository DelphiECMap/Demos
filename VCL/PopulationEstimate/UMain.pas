unit UMain;

(*
  Demonstration of how to use the PopulationCircle API with TECNativeMap

  https://populationcircle.com/api-docs
*)


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls,
  uecNativeMapControl, uecNativeShape, PopulationCircle.API;

type
  TFormPopulation = class(TForm)
    Log: TMemo;
    map: TECNativeMap;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    FPopulationCircleClient: TPopulationCircleClient;
    FGeoPointArray: TGeoPointArray;
    FPopulationEstimate: TPopulationEstimate;

    procedure doDraw(Sender: TObject);
    procedure doEstimate;
  public
    { Déclarations publiques }
  end;

var
  FormPopulation: TFormPopulation;

implementation

{$R *.dfm}

procedure TFormPopulation.FormDestroy(Sender: TObject);
begin
  FPopulationCircleClient.free;
end;

procedure TFormPopulation.FormCreate(Sender: TObject);
begin
  // unit PopulationCircle.API
  FPopulationCircleClient := TPopulationCircleClient.create;

  // define label properties for default group (map.shapes)
 Map.shapes.polygones.Labels.Visible := true;
 Map.shapes.polygones.Labels.LabelType := ltDescription;
 Map.shapes.polygones.Labels.Style := lsTransparent;
 Map.shapes.polygones.Labels.ColorType := lcColor;
 Map.shapes.polygones.Labels.MinZoom := 1;
 Map.shapes.polygones.Labels.Align := laCenter;
 Map.shapes.polygones.Labels.ShadowText := true;
 Map.shapes.polygones.Labels.FontBold := true;
 Map.shapes.polygones.Labels.FontColor := clWhite;
 Map.shapes.polygones.Labels.ShadowColor := clBlack;

  // Freehand sketch to define the area to be estimated
  map.FreeHand.draw := true;
  // event triggered when the drawing is finished
  map.FreeHand.OnDraw := doDraw;
end;

// event triggered by the end of freehand drawing
procedure TFormPopulation.doDraw(Sender: TObject);
var
  i: integer;
  Poly: TECShapePolygone;
  aTask: ITask;
begin

  // A new request is blocked until the current one is completed
  map.FreeHand.draw := false;

  // add the shape to your map

   // add polygon in default group
   // To add it to another group, do : poly := FreeHand.addPolygone('group_name');
  poly := Map.FreeHand.addPolygone;

  poly.FillColor := clBlack;
  poly.color := poly.FillColor;
  poly.FillOpacity := 50;

  setLength(FGeoPointArray, poly.Count + 1);

  for i := 0 to Poly.count - 1 do
    FGeoPointArray[i] := TGeoPoint.create(Poly[i].Longitude, Poly[i].Latitude);

  // close Polygon
  FGeoPointArray[poly.Count] := FGeoPointArray[0];

  // In a background task, we request population estimate in the area
  aTask := TTask.Create(
    procedure
    begin
      doEstimate;
    end);
  aTask.Start;

end;

//  background task population estimate
procedure TFormPopulation.doEstimate;
begin

  FPopulationEstimate := FPopulationCircleClient.Estimate(FGeoPointArray);

  // We update the map in the main thread using Queue
  TThread.Queue(nil, procedure
    begin

      Log.lines.add(FPopulationEstimate.ToString);

      Map.shapes.polygones[Map.shapes.polygones.count-1].Description := format('%d inhabitants',[FPopulationEstimate.Population]);

      // Allow a new request
      map.FreeHand.draw := true;

    end);

end;

end.

