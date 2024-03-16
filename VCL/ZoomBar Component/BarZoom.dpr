program BarZoom;

uses
  Vcl.Forms,
  UBarZoom in 'UBarZoom.pas' {FormZoomBar},
  uecZoomBarComponent in '..\..\Source\uecZoomBarComponent.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutDown :=true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormZoomBar, FormZoomBar);
  Application.Run;
end.
