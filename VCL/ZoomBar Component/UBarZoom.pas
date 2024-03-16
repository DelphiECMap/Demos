unit UBarZoom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,Vcl.stdCtrls,
  uecNativeMapControl,uecZoomBarComponent;

type




  TFormZoomBar = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    ckVertical: TCheckBox;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    ckVisible: TCheckBox;
    ckProgressive: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ckVerticalClick(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure ckVisibleClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ckProgressiveClick(Sender: TObject);

  private
    { Déclarations privées }

    FZoomBarComponent : TZoomBarComponent;


  public
    { Déclarations publiques }
  end;

var
  FormZoomBar: TFormZoomBar;

implementation

{$R *.dfm}



procedure TFormZoomBar.FormCreate(Sender: TObject);
begin

  FZoomBarComponent  := TZoomBarComponent.create(map);
  ckVertical.checked := (FZoomBarComponent.Layout = ctlVertical);

end;


procedure TFormZoomBar.FormDestroy(Sender: TObject);
begin
  FZoomBarComponent.free;
end;

// switch between vertical and horizontal bar
procedure TFormZoomBar.ckProgressiveClick(Sender: TObject);
begin
 FZoomBarComponent.ProgressiveZoom := ckProgressive.Checked;
end;

procedure TFormZoomBar.ckVerticalClick(Sender: TObject);
begin

  if ckVertical.checked then
    FZoomBarComponent.Layout := ctlVertical
  else
    FZoomBarComponent.Layout := ctlHorizontal;

end;


procedure TFormZoomBar.ckVisibleClick(Sender: TObject);
begin
  FZoomBarComponent.visible := ckVisible.checked;
end;



(*

 ecTopRight   , ecTopLeft stacks components vertically upwards to right and left
 ecBottomRight, ecBottomLeft stack components vertically downwards on right and left
 ecRightTop   , ecLeftTop stack components horizontally upwards to right and left
 ecRightBottom, ecLeftBottom stacks components horizontally downwards to right and left

*)

procedure TFormZoomBar.RadioButton4Click(Sender: TObject);
begin
 case TRadioButton(Sender).tag of
  0 : FZoomBarComponent.Align := ecTopRight;
  1 : FZoomBarComponent.Align := ecTopLeft;
  2 : FZoomBarComponent.Align := ecBottomRight;
  3 : FZoomBarComponent.Align := ecBottomLeft;
 end;
end;

end.
