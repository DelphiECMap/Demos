unit UMainLegend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, Vcl.StdCtrls,
  Vcl.ExtCtrls,uecLegendPanel,uecMapUtil, Vcl.Imaging.pngimage;

type
  TFormLegend = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    ckVisible: TCheckBox;
    map: TECNativeMap;
    pins: TImage;
    GroupBox2: TGroupBox;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    GroupBox3: TGroupBox;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    AddCheckBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure RadioButton4Click(Sender: TObject);
    procedure ckVisibleClick(Sender: TObject);

    procedure RadioButton8Click(Sender: TObject);
    procedure RadioButton9Click(Sender: TObject);
    procedure AddCheckBoxClick(Sender: TObject);
  private
    { Déclarations privées }
   FLegendCp : TLegendComponent;

   procedure doOnItemLegendClick(sender : TObject);
   procedure doOnItemLegendCheckBoxChange(sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  FormLegend: TFormLegend;

implementation

{$R *.dfm}

procedure TFormLegend.FormCreate(Sender: TObject);
begin
  FLegendCp := TLegendComponent.Create(map);

  FLegendCp.Legend.color := clWhite;
  FLegendCp.Legend.Height:= 270;

  // width of legend pictogram
  FLegendCp.Legend.VisualWidth := 40;
  // line thickness for styles <> vsFrame and vsFillRect
  FLegendCp.Legend.VisualWeight := 3;


  FLegendCp.Legend.OnItemClick := doOnItemLegendClick;
  FLegendCp.Legend.OnItemCheckBoxChange := doOnItemLegendCheckBoxChange;

  FLegendCp.Legend.add('Item 1',getRandomColor,vsFillRect);
  FLegendCp.Legend.add('Item 2',getRandomColor,vsFrame);
  FLegendCp.Legend.add('Item 3',getRandomColor,vsSolidLine);
  FLegendCp.Legend.add('Item 4',getRandomColor,vsDashLine);
  FLegendCp.Legend.add('Item 5',getRandomColor,vsDotLine);
  FLegendCp.Legend.add('Item 6',getRandomColor,vsDashDotLine);

  // add graphic
  FLegendCp.Legend.add('Item 7',pins.picture.graphic);
 
  FLegendCp.Legend.Title := 'Legend';
  FLegendCp.Legend.Footer := 'Footer';
   


end;

procedure TFormLegend.FormDestroy(Sender: TObject);
begin
 FLegendCp.Free;
end;

procedure TFormLegend.AddCheckBoxClick(Sender: TObject);
begin
 FLegendCp.Legend.ItemCheckBox := AddCheckBox.Checked;
end;

procedure TFormLegend.ckVisibleClick(Sender: TObject);
begin
  FLegendCp.Visible := ckVisible.Checked;
end;

// event triggered by a click on an item
procedure TFormLegend.doOnItemLegendClick(sender : TObject);
begin
  if Sender is TItemLegend then
  begin
   showMessage(TItemLegend(Sender).ItemCaption);
  end;
end;

// event triggered by a click on an item checkbox
procedure TFormLegend.doOnItemLegendCheckBoxChange(sender : TObject);
var s:string;
begin
  if Sender is TItemLegend then
  begin
   if TItemLegend(Sender).ItemChecked then
    s := ' is checked'
   else
    s := ' is not checked';
   showMessage(TItemLegend(Sender).ItemCaption+s);
  end;
end;


(*

 ecTopRight   , ecTopLeft stacks components vertically upwards to right and left
 ecBottomRight, ecBottomLeft stack components vertically downwards on right and left
 ecRightTop   , ecLeftTop stack components horizontally upwards to right and left
 ecRightBottom, ecLeftBottom stacks components horizontally downwards to right and left

*)

procedure TFormLegend.RadioButton4Click(Sender: TObject);
begin
 case TRadioButton(Sender).tag of
  0 : FLegendCp.Align := ecTopRight;
  1 : FLegendCp.Align := ecTopLeft;
  2 : FLegendCp.Align := ecBottomRight;
  3 : FLegendCp.Align := ecBottomLeft;
 
 end;
end;

// item text alignment
procedure TFormLegend.RadioButton8Click(Sender: TObject);
begin
 case TRadioButton(Sender).tag of
  0 : FLegendCp.Legend.ItemAlignment := taLeftJustify;
  1 : FLegendCp.Legend.ItemAlignment := taCenter;
  2 : FLegendCp.Legend.ItemAlignment := taRightJustify;
 end;
end;

// item visual alignment
procedure TFormLegend.RadioButton9Click(Sender: TObject);
begin
 case TRadioButton(Sender).tag of
  0 : FLegendCp.Legend.VisualAlignment := valLeft;
  1 : FLegendCp.Legend.VisualAlignment := valRight;
 end;
end;

end.
