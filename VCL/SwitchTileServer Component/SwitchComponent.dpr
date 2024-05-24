program SwitchComponent;

uses
  Vcl.Forms,
  USwitchComponent in 'USwitchComponent.pas' {FormSwitch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSwitch, FormSwitch);
  Application.Run;
end.
