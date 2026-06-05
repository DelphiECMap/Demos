unit UnitMain;

(*
  Demonstration of how to use the OpenSky API with TECNativeMap

  https://opensky-network.org/about/terms-of-use
*)

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  System.Threading,System.Math, FMX.Controls.Presentation, FMX.StdCtrls ,

  FMX.uecNativeMapControl,FMX.uecNativeShape,FMX.uecMapUtil,
  OpenSkyAPI.REST, uecGraphics, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFormOpenSky = class(TForm)
    map: TECNativeMap;
    Timer: TTimer;
    Info: TLabel;
    AIndicator: TAniIndicator;
    Interval: TLabel;
    Log: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mapShapesPaint(Sender: TObject; const canvas: TECCanvas);
    procedure TimerTimer(Sender: TObject);
  private
    { Déclarations privées }
    FOpenSky: TOpenSkyClientREST;
    FBoundingBox: TRectF;

    FMaxInterval : integer;

    FSVGAirPlane : string;

    G_AirPlanes : TECShapes;

    procedure GetAllStates;
    procedure UpdateMap(const States: TArray<TOpenSkyState>);
  public
    { Déclarations publiques }
  end;

var
  FormOpenSky: TFormOpenSky;

implementation

{$R *.fmx}

procedure TFormOpenSky.FormDestroy(Sender: TObject);
begin
 FOpenSky.free;
end;

procedure TFormOpenSky.FormCreate(Sender: TObject);
begin

 map.CopyrightTile := map.CopyrightTile + ' - data from The OpenSky Network';

 FSVGAirPlane := 'M6.8182,0.6818H4.7727' +
    'C4.0909,0.6818,4.0909,0,4.7727,0h5.4545c0.6818,0,0.6818,0.6818,0,' +
    '0.6818H8.1818c0,0,0.8182,0.5909,0.8182,1.9545V4h6v2L9,8l-0.5,5' +
    'l2.5,1.3182V15H4v-0.6818L6.5,13L6,8L0,6V4h6V2.6364C6,1.2727,' +
    '6.8182,0.6818,6.8182,0.6818z';

 // group containing our markers
 G_AirPlanes := map['airplanes'];

 // define label properties
 G_AirPlanes.Markers.Labels.Visible := true;
 G_AirPlanes.Markers.Labels.LabelType := ltDescription;
 G_AirPlanes.Markers.Labels.Style := lsTransparent;
 G_AirPlanes.Markers.Labels.MinZoom := 1;
 G_AirPlanes.Markers.Labels.Align := laBottom;
 G_AirPlanes.Markers.Labels.ShadowText := true;
 G_AirPlanes.Markers.Labels.FontBold := true;

 //The OpenSky API will be called every 10 seconds
 FMaxInterval := 10;

 // To log in to OpenSky, enter your client_id and client_secret to authenticate yourself
 // see https://openskynetwork.github.io/opensky-api/rest.html
 FOpenSky := TOpenSkyClientREST.Create('','');

 // we focus exclusively on Switzerland
 FBoundingBox := TRectF.Create(45.8389,5.9962,47.8229,10.5226);
 map.Bounds(45.8389,5.9962,47.8229,10.5226);

 //  We have set up a timer that triggers every second to display the countdown before the API call every 10 seconds
 Timer.interval := 1000; // 1 secondes
 Timer.Enabled  := true;
 // We initiate the immediate call
 TimerTimer(nil);
end;

procedure TFormOpenSky.TimerTimer(Sender: TObject);
var
  aTask: ITask;
begin

  // We use Tag to determine whether it is time to connect to OpenSky

  if timer.Tag>0 then
  begin
    // Countdown update
    timer.tag := timer.tag-1;
    Interval.Text := timer.tag.ToString;
    exit;
  end;

  Timer.Enabled := false;
  timer.tag := FMaxInterval;
  Interval.Text := timer.tag.ToString;


  // In a background task, we request a list of all airplanes in the area
  aTask := TTask.Create(
    procedure
    begin
      GetAllStates;
    end);
  aTask.Start;
end;

//  request a list of all airplanes in the area
//  This procedure runs in a background task
procedure TFormOpenSky.GetAllStates;
var
  Resp: TOpenSkyResponse;
  States: TArray<TOpenSkyState>;
begin
  try

    Resp := FOpenSky.GetAllStates(FBoundingBox);
    try

      States := Resp.States.ToArray;

      // We update the map in the main thread using Queue
      TThread.Queue(nil, procedure
        begin

          UpdateMap(states);

        end);

    finally
      Resp.Free;
    end;

  except
    on E: Exception do
       TThread.Queue(nil, procedure
          begin
            Info.text := E.Message;
          end);
  end;
end;


// This event is triggered once the tiles and elements are displayed
procedure TFormOpenSky.mapShapesPaint(Sender: TObject; const canvas: TECCanvas);
var i:integer;
    M:TECShape;
begin

 // display this information only when the map is idle
 if not Map.isIdle then exit;

 // log info for visible airplanes

  Log.Lines.BeginUpdate;
  Log.Lines.clear;

  // The “Displayed” list contains all the elements in the group that are shown in the visible area of the map
  // Displayed list is only valid in OnShapesPaint
  for i := 0 to G_AirPlanes.Displayed.count-1 do
  begin

    M := G_AirPlanes.Displayed[i];

  Log.Lines.Add(Format('%s | %s,%s | %s km/h | %s m | %s',
        [M['callsign'].padleft(9),
         DoubleToStrDigit(M.Latitude,4).padleft(7), DoubleToStrDigit(M.Longitude,4).padleft(7),
         M['velocity'].padLeft(8), M['alt'].PadLeft(9),M['origin']]));
  end;

  Log.Lines.endUpdate;
  // force redraw tmemo, bug firemonkey ?
  Log.width := log.Width+1;

end;


// Map update using data returned by OpenSky
procedure TFormOpenSky.UpdateMap(const States: TArray<TOpenSkyState>);
var State: TOpenSkyState;
    M : TECShapeMarker;
begin
 info.text := Format('[%s] %d airplanes ( remaining credit : %d)', [TimeToStr(Now), Length(States), FOpenSky.X_Rate_Limit_Remaining]) ;


 Map.BeginUpdate;
 G_AirPlanes.clear;

 for State in States do
  begin
    if (not IsNan(State.Latitude)) and (State.Callsign.Trim <> '') and (State.Velocity > 30) then
    begin

      M := G_AirPlanes.addMarker(State.Latitude,State.Longitude);
      // use data svg for draw airplanes
     M.StyleIcon := siSVG;
     M.filename := FSVGAirPlane;

     M.Width  := 32;
     M.Height := 32;

     M.Angle := round(State.TrueTrack);

     // A color is determined based on the country of origin
     M.color := GetHashColor(State.OriginCountry);

     // label text size
     M.TextFont.size := 8;

     //  CallSign is used as a label
     M.Description := State.Callsign.ToUpper;

     // show origin and altitude in hint
     M.hint := format('Origin %s'+#13#10+'Alt %.0fm',[State.OriginCountry, State.BaroAltitude]);

     // Store the values we're interested in in the element's properties
     M['origin']   := State.OriginCountry;
     M['alt']      := DoubleToStrDigit(State.BaroAltitude,2);
     M['callsign'] := State.Callsign;
     M['velocity'] := DoubleToStrDigit(State.Velocity * 3.6,2);
    end;
  end;

  Map.EndUpdate;

  Timer.Enabled := true;

end;

end.
