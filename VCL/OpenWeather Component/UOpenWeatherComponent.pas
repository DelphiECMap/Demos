unit UOpenWeatherComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uecOpenWeatherComponent, Vcl.StdCtrls,
  Vcl.ExtCtrls, uecNativeMapControl,uecNativeShape,uecmaputil, Vcl.ComCtrls;

type
  TFormWeather = class(TForm)
    map: TECNativeMap;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    ckVisible: TCheckBox;
    Memo1: TMemo;
    TimeLine: TTrackBar;
    Label1: TLabel;
    procedure RadioButton4Click(Sender: TObject);
    procedure ckVisibleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimeLineChange(Sender: TObject);

  private
    { Déclarations privées }
    FOpenWeatherComponent:TOpenWeatherComponent;

    procedure doOnClick(sender : TObject);
    procedure doOnChange(sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  FormWeather: TFormWeather;

implementation

{$R *.dfm}


procedure TFormWeather.FormCreate(Sender: TObject);
begin


   // get your key from http://openweathermap.org/appid
  map.OpenWeather.Key := 'YOUR-API-KEY';

  // Air quality is optional, leave the key empty if you don't want to use it.
  // get your free key from https://aqicn.org/data-platform/token/
  map.AirQuality.key := 'YOUR-API-KEY';

  FOpenWeatherComponent := TOpenWeatherComponent.Create(Map);
  FOpenWeatherComponent.Color := clWhite;

  // The component is only displayed for zoom 13 and above.
  FOpenWeatherComponent.MinZoom := 13;

  /// Triggered by clicking on component or map marker
  FOpenWeatherComponent.OnClick := doOnClick;
  // Triggered by change of weather station
  FOpenWeatherComponent.OnChange:= doOnChange;

  // You can specify the language for the weather description
  map.openWeather.Lang := 'fr';
  // Translate the hint for "Air quality".
  FOpenWeatherComponent.HintAirQuality := 'Qualité de l''air';
  // You can also translate the table containing the air quality indicators
  Map.AirQuality.Legend[aqlGood]               := 'Bonne';
  Map.AirQuality.Legend[aqlModerate]           := 'Modérée';
  Map.AirQuality.Legend[aqlUnhealthySensitive] := 'Insalubre pour les groupes sensibles';
  Map.AirQuality.Legend[aqlUnhealthy]          := 'Insalubre';
  Map.AirQuality.Legend[aqlVeryUnhealthy]      := 'Nocive';
  Map.AirQuality.Legend[aqlHazardous]          := 'Dangereuse';


  FOpenWeatherComponent.visible := true;

  // DateTimeIndex from 0 to 39 to select date and time in 3-hour increments
  //   0 = now
  //   1 = now + 3 hours
  //   8 = tomorrow at the same time
  FOpenWeatherComponent.DateTimeIndex := 0;
end;

procedure TFormWeather.FormDestroy(Sender: TObject);
begin
 FOpenWeatherComponent.free;
end;

// Triggered by change of weather station
procedure  TFormWeather.doOnChange(sender : TObject);
begin
 with Memo1.Lines do
 begin
  BeginUpdate;
    Clear;
    Add(FOpenWeatherComponent.Station.Name);
    Add(DateTimeTostr(FOpenWeatherComponent.Station.UTCDateTime));
    Add('Temp : '+DoubleToStr(round(FOpenWeatherComponent.Station.temp))+'°'+
        ' (min: '+doubletostr(round(FOpenWeatherComponent.Station.temp_min))+'°'+
         ' max: '+doubletostr(round(FOpenWeatherComponent.Station.temp_max))+'°)' );
    Add(FOpenWeatherComponent.Station.weather.description) ;

    if FOpenWeatherComponent.CityAirQuality.Ok then
     Add(FOpenWeatherComponent.HintAirQuality+' '+Map.AirQuality.Legend[FOpenWeatherComponent.CityAirQuality.level]);


  EndUpdate;
 end;

end;

// Triggered by clicking on component or map marker
procedure TFormWeather.doOnClick(sender : TObject);
var Q:string;
begin

 (*
   OnClick reacts both to the click on the component and to the marker on the map
   Sender makes it possible to distinguish between them
 *)
  if not (Sender is TECShape) then
   // compact or full display
   FOpenWeatherComponent.ShowDescription := not FOpenWeatherComponent.ShowDescription;

  if FOpenWeatherComponent.CityAirQuality.Ok then
  begin
   Q := FOpenWeatherComponent.HintAirQuality;
   if Q<>'' then Q := Q + ' : ';
   Q := Q + Map.AirQuality.Legend[FOpenWeatherComponent.CityAirQuality.level];
  end
  else
   Q := '';
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Click component');
  Memo1.Lines.Add('  '+FOpenWeatherComponent.Station.name);
  if Q<>'' then
  Memo1.Lines.Add('  '+Q);
end;

procedure TFormWeather.ckVisibleClick(Sender: TObject);
begin
 FOpenWeatherComponent.Visible := ckVisible.Checked;
end;

procedure TFormWeather.RadioButton4Click(Sender: TObject);
begin
  case TRadioButton(Sender).tag of
  0 : FOpenWeatherComponent.Align := ecTopRight;
  1 : FOpenWeatherComponent.Align := ecTopLeft;
  2 : FOpenWeatherComponent.Align := ecBottomRight;
  3 : FOpenWeatherComponent.Align := ecBottomLeft;
  4 : FOpenWeatherComponent.Align := ecTopCenter;
  5 : FOpenWeatherComponent.Align := ecBottomCenter;
  6 : FOpenWeatherComponent.Align := ecLeftCenter;
  7 : FOpenWeatherComponent.Align := ecRightCenter;
 end;
end;

procedure TFormWeather.TimeLineChange(Sender: TObject);
begin
 FOpenWeatherComponent.datetimeindex := TimeLine.Position;
end;

end.
