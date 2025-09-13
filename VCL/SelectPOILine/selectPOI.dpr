program selectPOI;

uses
  Vcl.Forms,
  USelectPOI in 'USelectPOI.pas' {FormSelectLine};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSelectLine, FormSelectLine);
  Application.Run;
end.
