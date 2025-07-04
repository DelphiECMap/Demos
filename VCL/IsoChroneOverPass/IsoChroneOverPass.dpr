program IsoChroneOverPass;

uses
  Vcl.Forms,
  UIsoChrone in 'UIsoChrone.pas' {FIsoChrone};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFIsoChrone, FIsoChrone);
  Application.Run;
end.
