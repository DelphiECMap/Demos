program MultiAltGraph;

uses
  Vcl.Forms,
  UMAltGraph in 'UMAltGraph.pas' {FMultiGraph};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMultiGraph, FMultiGraph);
  Application.Run;
end.
