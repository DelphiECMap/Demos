program PTVDemo;

uses
  Vcl.Forms,
  MainPTV in 'MainPTV.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPTVForm, PTVForm);
  Application.Run;
end.
