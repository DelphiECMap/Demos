unit UMapillaryComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uecMapillaryComponent,
  uecNativeMapControl, uecNativeShape,uecMapUtil, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMapillaryForm = class(TForm)
    map: TECNativeMap;
    Memo1: TMemo;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    ckVisible: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure ckVisibleClick(Sender: TObject);
  private
    { Déclarations privées }
    FMapillaryComponent : TMapillaryComponent;
    FPosition : TECShapeMarker;

    procedure doOnImage(Sender:TObject);
    procedure doOnChange(Sender:TObject);
  public
    { Déclarations publiques }
  end;

var
  MapillaryForm: TMapillaryForm;

implementation

{$R *.dfm}

procedure TMapillaryForm.FormCreate(Sender: TObject);
begin
  // Pass the map that will display the Mapillary component
  FMapillaryComponent := TMapillaryComponent.Create(map);
  // color component
  FMapillaryComponent.Color := clWhite;
  // Triggered when a Mapillary image is displayed
  FMapillaryComponent.OnImage := doOnImage;
  // Triggered when component state, visibility, position, size change
  FMapillaryComponent.OnChange:= doOnChange;

  // FPosition will indicate the position of the displayed Mapillary image
  FPosition := map.AddMarker(map.Latitude, map.Longitude);
  FPosition.Visible := false;
  FPosition.filename := GOOGLE_RED_DOT_ICON; // unit uecMapUtil also BLUE,YELLOW and GREEN
  FPosition.YAnchor := 32;

  // Enter your access key, see  https://www.mapillary.com/developer
  FMapillaryComponent.AccessToken := 'ENTER-YOUR-KEY';
  FMapillaryComponent.visible := true;

end;



// Triggered when component state, visibility, position, size change
procedure TMapillaryForm.doOnChange(Sender:TObject);
begin

 ckVisible.Checked := FMapillaryComponent.visible;
 FPosition.Visible := FMapillaryComponent.visible;


 with Memo1.Lines do
  begin
   BeginUpdate;
     Clear;
     add('Visible   : '+BoolToStr(FMapillaryComponent.visible));
   EndUpdate;
  end

end;

// Triggered when a Mapillary image is displayed
procedure TMapillaryForm.doOnImage(Sender:TObject);
begin

  if assigned(FMapillaryComponent.Image) then
  begin
   FPosition.SetPosition(FMapillaryComponent.Image.lat,FMapillaryComponent.Image.lng);
   FPosition.setFocus;
  with Memo1.Lines do
  begin
   BeginUpdate;
     Clear;
     add('Lat   : '+doubleToStrDigit(FMapillaryComponent.Image.lat,4));
     add('Lng   : '+doubleToStrDigit(FMapillaryComponent.Image.lng,4));
     add('Angle : '+inttostr(FMapillaryComponent.Image.Compass_angle)+'°');
     add('Time  : '+DateTimeToStr(FMapillaryComponent.Image.Captured_at));
   EndUpdate;
  end;
  end
  else
   Memo1.Lines.Clear;

end;

procedure TMapillaryForm.FormDestroy(Sender: TObject);
begin
  FMapillaryComponent.Free;
end;

procedure TMapillaryForm.ckVisibleClick(Sender: TObject);
begin
  FMapillaryComponent.Visible := ckVisible.Checked;
end;

procedure TMapillaryForm.RadioButton4Click(Sender: TObject);
begin
 case TRadioButton(Sender).tag of
  0 : FMapillaryComponent.Align := ecTopRight;
  1 : FMapillaryComponent.Align := ecTopLeft;
  2 : FMapillaryComponent.Align := ecBottomRight;
  3 : FMapillaryComponent.Align := ecBottomLeft;
  4 : FMapillaryComponent.Align := ecTopCenter;
  5 : FMapillaryComponent.Align := ecBottomCenter;
  6 : FMapillaryComponent.Align := ecLeftCenter;
  7 : FMapillaryComponent.Align := ecRightCenter;
 end;
end;

end.
