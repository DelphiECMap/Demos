program SplitMap;

uses
  Vcl.Forms,
  USplitMap in 'USplitMap.pas' {FormSplitMap};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSplitMap, FormSplitMap);
  Application.Run;
end.
