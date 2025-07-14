program photographer;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPhotographer in 'UPhotographer.pas' ;

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutDown :=true;
 {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TFormPhoto, FormPhoto);
  Application.Run;
end.
