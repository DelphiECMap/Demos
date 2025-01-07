program markerclick;

uses
  Vcl.Forms,
  UMarkerClick in 'UMarkerClick.pas' {FormMarkers};

{$R *.res}

begin
  ReportMemoryLeaksOnShutDown :=true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMarkers, FormMarkers);
  Application.Run;
end.
