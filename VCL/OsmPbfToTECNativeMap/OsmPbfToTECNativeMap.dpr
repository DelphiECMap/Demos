program OsmPbfToTECNativeMap;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FormOSMPBFToTECNativeMap};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormOSMPBFToTECNativeMap, FormOSMPBFToTECNativeMap);
  Application.Run;
end.
