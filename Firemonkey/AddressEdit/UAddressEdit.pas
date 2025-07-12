unit UAddressEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.uecNativeMapControl, FMX.AddressEditComponent,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormAddressEditComponent = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    ckVisible: TCheckBox;
    procedure AlignChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ckVisibleChange(Sender: TObject);
  private
    { Déclarations privées }
   FAddressEditComponent : TAddressEditComponent;

   procedure doOnChange(Sender : TObject);
   procedure doOnAddress(const Address : string; const Latitude, Longitude: double; var Accept : boolean) ;

  public
    { Déclarations publiques }
  end;

var
  FormAddressEditComponent: TFormAddressEditComponent;

implementation

{$R *.fmx}


procedure TFormAddressEditComponent.FormCreate(Sender: TObject);
begin
 FAddressEditComponent := TAddressEditComponent.Create(map);
 // Triggered after selecting an address, allows you to refuse it
 FAddressEditComponent.OnAddress := doOnAddress;
 // triggered when align, visible, size properties are modified
 FAddressEditComponent.onChange := doOnChange;
 // true is default, here it's used to trigger Onchange
 FAddressEditComponent.visible  := true;
 // 'Address' is the default value
 FAddressEditComponent.TextHint := 'Address';

end;

procedure TFormAddressEditComponent.FormDestroy(Sender: TObject);
begin
 FAddressEditComponent.Free;
end;

procedure TFormAddressEditComponent.doOnChange(Sender : TObject);
begin
 ckVisible.IsChecked := FAddressEditComponent.Visible;
end;


procedure TFormAddressEditComponent.doOnAddress(const Address : string; const Latitude, Longitude: double; var Accept : boolean) ;
begin
  // set Accept to false not to change address
end;

procedure TFormAddressEditComponent.ckVisibleChange(Sender: TObject);
begin
  FAddressEditComponent.Visible := ckVisible.IsChecked;
end;



procedure TFormAddressEditComponent.AlignChange(Sender: TObject);
begin
 case TRadiobutton(Sender).tag of
     // takes up all the remaining space at the top from the right
  0: FAddressEditComponent.Align := ecAlRightTop;
     // takes up half the width of the map, top right
  1: begin
      FAddressEditComponent.Align := ecRightTop;
      FAddressEditComponent.Width := trunc(map.Width / 2);
     end;
     // takes up all the remaining space at the bottom from the right
  2: FAddressEditComponent.Align := ecAlRightBottom;
     // takes up half the width of the map, bottom right
  3: begin
      FAddressEditComponent.Align := ecRightBottom;
      FAddressEditComponent.Width := trunc(map.Width / 2);
     end;
 end;
end;

end.
