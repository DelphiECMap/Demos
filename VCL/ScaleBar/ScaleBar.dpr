program ScaleBar;

uses
  Vcl.Forms,
  UMainScaleBar in 'UMainScaleBar.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm14, Form14);
  Application.Run;
end.
