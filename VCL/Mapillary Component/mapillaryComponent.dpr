program mapillaryComponent;

uses
  Vcl.Forms,
  UMapillaryComponent in 'UMapillaryComponent.pas' {MapillaryForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMapillaryForm, MapillaryForm);
  Application.Run;
end.
