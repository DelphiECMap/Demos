program vclheatmap;

uses
  Vcl.Forms,
  Umain in 'Umain.pas' {FormHeatMap};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormHeatMap, FormHeatMap);
  Application.Run;
end.
