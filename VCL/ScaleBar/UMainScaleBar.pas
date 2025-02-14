unit UMainScaleBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, Vcl.ExtCtrls,
  Vcl.StdCtrls,
  uecMapUtil, Vcl.ComCtrls //
  ;

type
  TForm14 = class(TForm)
    controls: TPanel;
    map: TECNativeMap;
    ckScaleBar: TCheckBox;
    gbStyle: TGroupBox;
    rbLine: TRadioButton;
    rbBar: TRadioButton;
    pnProperties: TPanel;
    gbDivision: TGroupBox;
    rbNone: TRadioButton;
    rbOne: TRadioButton;
    rbFour: TRadioButton;
    tbThickNess: TTrackBar;
    Label1: TLabel;
    gbPosition: TGroupBox;
    rbTopRight: TRadioButton;
    rbBottomRight: TRadioButton;
    rbTopLeft: TRadioButton;
    rbBottomLeft: TRadioButton;
    GroupBox1: TGroupBox;
    pnSecondaryColor: TPanel;
    pnColor: TPanel;
    ColorDialog: TColorDialog;
    ckShadow: TCheckBox;
    gpMeasure: TGroupBox;
    rbMetric: TRadioButton;
    rbImperial: TRadioButton;
    ckRadiusScale: TCheckBox;
    procedure ckScaleBarClick(Sender: TObject);
    procedure rbLineClick(Sender: TObject);
    procedure rbNoneClick(Sender: TObject);
    procedure tbThickNessChange(Sender: TObject);
    procedure rbTopRightClick(Sender: TObject);
    procedure pnColorClick(Sender: TObject);
    procedure ckShadowClick(Sender: TObject);
    procedure rbMetricClick(Sender: TObject);
    procedure ckRadiusScaleClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form14: TForm14;

implementation

{$R *.dfm}

procedure TForm14.ckRadiusScaleClick(Sender: TObject);
begin
 map.ScaleBar.RadiusScale := ckRadiusScale.Checked;
end;

procedure TForm14.ckScaleBarClick(Sender: TObject);
begin
 map.ScaleBar.Visible := ckScaleBar.Checked;
 pnProperties.Visible  := ckScaleBar.Checked;
end;

procedure TForm14.ckShadowClick(Sender: TObject);
begin
 map.ScaleBar.Shadow := ckShadow.Checked;
end;

procedure TForm14.pnColorClick(Sender: TObject);
begin
 if ColorDialog.Execute then
  TPanel(Sender).Color := ColorDialog.Color;

  map.ScaleBar.Color := pnColor.Color;
  map.ScaleBar.SecondaryColor := pnSecondaryColor.Color;


end;

procedure TForm14.rbLineClick(Sender: TObject);
begin
   if rbLine.Checked then
    map.ScaleBar.Style := sbsLine
   else
    map.ScaleBar.Style := sbsBar;
end;

procedure TForm14.rbMetricClick(Sender: TObject);
begin
 if rbMetric.Checked then
  map.ScaleBar.MeasureSystem := msMetric
 else
  map.ScaleBar.MeasureSystem := msImperial;
end;

procedure TForm14.rbNoneClick(Sender: TObject);
begin
 if rbNone.Checked then
   map.ScaleBar.Division := sbdNone
 else
 if rbOne.Checked then
   map.ScaleBar.Division := sbdOne
 else
   map.ScaleBar.Division := sbdFour;

end;

procedure TForm14.rbTopRightClick(Sender: TObject);
begin
 if rbTopRight.Checked then
    map.ScaleBar.AnchorPosition := apTopRight
 else
 if rbTopLeft.Checked then
    map.ScaleBar.AnchorPosition := apTopLeft
 else
 if rbBottomRight.Checked then
    map.ScaleBar.AnchorPosition := apBottomRight
 else
 if rbBottomLeft.Checked then
    map.ScaleBar.AnchorPosition := apBottomLeft;


end;

procedure TForm14.tbThickNessChange(Sender: TObject);
begin
 map.ScaleBar.Thickness := tbThickness.Position;
 map.ScaleBar.FontSize  := 8 + tbThickness.Position;
end;

end.
