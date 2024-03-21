program centercomponent;

uses
  Vcl.Forms,
  Umain in 'Umain.pas' {Form21};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm21, Form21);
  Application.Run;
end.
