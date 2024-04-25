program multiview;

uses
  Vcl.Forms,
  UMainMultiView in 'UMainMultiView.pas' {FormMultiView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMultiView, FormMultiView);
  Application.Run;
end.
