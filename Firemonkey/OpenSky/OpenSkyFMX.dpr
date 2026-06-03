program OpenSkyFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {FormOpenSky};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormOpenSky, FormOpenSky);
  Application.Run;
end.
