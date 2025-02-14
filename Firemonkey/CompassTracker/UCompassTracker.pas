unit UCompassTracker;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.uecNativeMapControl, FMX.uecNativeShape, FMX.UECMapUtil,
  FMX.uecLegendPanel,
  System.UIConsts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormTracker = class(TForm)
    pnMap: TPanel;
    map: TECNativeMap;
    CheckBoxCompass: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxCompassClick(Sender: TObject);
  private
    { Déclarations privées }
    FDrones: array [0 .. 3] of TECShapeMarker;
    FLegendCp: TLegendComponent;

    procedure CreateDrone(var Drone: TECShapeMarker; const AColor: TColor;
      const ADirection: integer);

    procedure doOnMoveDrone(Sender: TObject; const Item: TECShape;
      var cancel: boolean);

    procedure doOnItemLegendClick(sender : TObject);

  public
    { Déclarations publiques }
  end;

var
  FormTracker: TFormTracker;

implementation

{$R *.fmx}

procedure TFormTracker.FormCreate(Sender: TObject);
var
  i: integer;
begin
  map.OverSizeForRotation := true;

  // see https://www.helpandweb.com/ecmap/en/components.htm#COMPONENT_LEGEND
  FLegendCp := TLegendComponent.Create(map);

  FLegendCp.Legend.OnItemClick := doOnItemLegendClick;
  FLegendCp.Legend.color := claWhite;
  FLegendCp.Legend.Height := 125;
  FLegendCp.Legend.Width := 105;
  FLegendCp.Opacity := 0.75;

  FLegendCp.Legend.Title := 'Drones';

  map.ScaleBar.Visible := true;
  map.ScaleBar.Compass := true;

  // Optimization, call BeginUpdate before adding elements
  // not really necessary here, there are only 4 drones
  map.BeginUpdate;

  for i := Low(FDrones) to High(FDrones) do
    // GetRandomColor in uecMapUtil unit
    CreateDrone(FDrones[i], GetRandomColor, random(360));

  // We can now allow the map to be updated
  map.EndUpdate;

  map.Components.Add('compass', CheckBoxCompass, ecBottomRight);

end;

procedure TFormTracker.CreateDrone(var Drone: TECShapeMarker;
  const AColor: TColor; const ADirection: integer);
var
  animD: TECAnimationMoveToDirection;
begin
  // All drones will start from the map center
  Drone := map.AddMarker(map.Latitude, map.longitude);

  // use data svg for draw drone

  Drone.StyleIcon := siSVG;

  Drone.Filename := 'M6.8182,0.6818H4.7727' +
    'C4.0909,0.6818,4.0909,0,4.7727,0h5.4545c0.6818,0,0.6818,0.6818,0,' +
    '0.6818H8.1818c0,0,0.8182,0.5909,0.8182,1.9545V4h6v2L9,8l-0.5,5' +
    'l2.5,1.3182V15H4v-0.6818L6.5,13L6,8L0,6V4h6V2.6364C6,1.2727,' +
    '6.8182,0.6818,6.8182,0.6818z';

  Drone.Width := 32;
  Drone.Height := 32;

  Drone.color := AColor;

  // The distance to the centre of the map will be updated after each move
  Drone.onShapeMove := doOnMoveDrone;

  // create animation
  // drone speed between 100 and 200 km / h
  animD := TECAnimationMoveToDirection.Create(100 + random(100), ADirection);

  // there is no need to destroy the animation,
  // this is done automatically when the item is destroyed
  // or when you assign a new animation
  Drone.Animation := animD;

  // the drone is in the direction of travel
  animD.Heading := true;

  // start move
  animD.Start;

  Drone.Tag := map.ScaleBar.AddTracker(AColor, Drone);

  FLegendCp.Legend.Add('0 m', Drone.color, vsFillRect,Drone);

  Drone.draggable := true;
end;



// Updating distances
procedure TFormTracker.doOnMoveDrone(Sender: TObject; const Item: TECShape;
  var cancel: boolean);
var
  idTracker: integer;
begin

  idTracker := map.ScaleBar.FindTracker(Item);

  if (idTracker > -1) and (idTracker < map.ScaleBar.trackerCount) then

    FLegendCp.Legend.Items[Item.Tag].ItemCaption :=
      KMToString(map.ScaleBar.trackers[idTracker].km);
end;

// event triggered by a click on an Legend
procedure TFormTracker.doOnItemLegendClick(sender : TObject);
begin
if Sender is TItemLegend then
 if TItemLegend(Sender).TagObject is TECShapeMarker then
  TECShapeMarker(TItemLegend(Sender).TagObject).CenterOnMap;
end;


procedure TFormTracker.CheckBoxCompassClick(Sender: TObject);
var
  i: integer;
begin
  map.ScaleBar.Compass := not CheckBoxCompass.IsChecked;
  FLegendCp.Visible := map.ScaleBar.Compass;

  if map.ScaleBar.Compass then
  begin
    map.ScaleBar.ClearTrackers;

    for i := Low(FDrones) to High(FDrones) do
      FDrones[i].Tag := map.ScaleBar.AddTracker(FDrones[i].color, FDrones[i]);
  end;
end;

end.
