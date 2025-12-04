program gtfs_rt_reader;

uses
  Vcl.Forms,
  UGTFSReader in 'UGTFSReader.pas' {FormGTFS};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormGTFS, FormGTFS);
  Application.Run;
end.
