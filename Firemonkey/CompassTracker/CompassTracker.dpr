program CompassTracker;

uses
  System.StartUpCopy,
  FMX.Forms,
  UCompassTracker in 'UCompassTracker.pas' {FormTracker};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormTracker, FormTracker);
  Application.Run;
end.
