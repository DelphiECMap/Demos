program AddressEdit;

uses
  System.StartUpCopy,
  FMX.Forms,
  UAddressEdit in 'UAddressEdit.pas' {FormAddressEditComponent};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormAddressEditComponent, FormAddressEditComponent);
  Application.Run;
end.
