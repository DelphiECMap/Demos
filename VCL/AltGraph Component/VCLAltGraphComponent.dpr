program VCLAltGraphComponent;

uses
  Vcl.Forms,
  UAltGraph in 'UAltGraph.pas' {FormAltGraph};

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutDown :=true;
 {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAltGraph, FormAltGraph);
  Application.Run;
end.
