program OpenServices;

uses
  System.StartUpCopy,
  FMX.Forms,
  UOpenServices in 'UOpenServices.pas' {FOpenServices};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFOpenServices, FOpenServices);
  Application.Run;
end.
