program BookMarkComponent;

uses
  System.StartUpCopy,
  FMX.Forms,
  UBookMark in 'UBookMark.pas' {FormBookMark};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormBookMark, FormBookMark);
  Application.Run;
end.
