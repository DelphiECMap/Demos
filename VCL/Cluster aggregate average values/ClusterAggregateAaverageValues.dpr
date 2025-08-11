program ClusterAggregateAaverageValues;

uses
  Vcl.Forms,
  UClusterAggregateAaverageVvalues in 'UClusterAggregateAaverageVvalues.pas' {FormCluster};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCluster, FormCluster);
  Application.Run;
end.
