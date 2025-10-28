program hands_free_selection;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FormHandsFree};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHandsFree, FormHandsFree);
  Application.Run;
end.
