program openweathercomponent;

uses
  Vcl.Forms,
  UOpenWeatherComponent in 'UOpenWeatherComponent.pas' {FormWeather};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormWeather, FormWeather);
  Application.Run;
end.
