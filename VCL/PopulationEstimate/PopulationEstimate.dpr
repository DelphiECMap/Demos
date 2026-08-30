program PopulationEstimate;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FormPopulation};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPopulation, FormPopulation);
  Application.Run;
end.
