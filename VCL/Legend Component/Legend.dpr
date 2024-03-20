program Legend;

uses
  Vcl.Forms,
  UMainLegend in 'UMainLegend.pas' {FormLegend};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLegend, FormLegend);
  Application.Run;
end.
