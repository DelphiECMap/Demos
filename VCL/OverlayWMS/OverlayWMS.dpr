program OverlayWMS;

uses
  Vcl.Forms,
  UOverlayWMS in 'UOverlayWMS.pas' {FormWMS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormWMS, FormWMS);
  Application.Run;
end.
