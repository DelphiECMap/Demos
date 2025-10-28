unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uecNativeMapControl, uecNativeShape,uecmaputil,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ColorGrd;

type
  TFormHandsFree = class(TForm)
    map: TECNativeMap;
    Bar: TPanel;
    Selection: TCheckBox;
    gbDraw: TGroupBox;
    rbLine: TRadioButton;
    rbPolygone: TRadioButton;
    gbMouse: TGroupBox;
    rbLeft: TRadioButton;
    rbRight: TRadioButton;
    gbStyle: TGroupBox;
    Label1: TLabel;
    seWeight: TSpinEdit;
    cgColor: TColorGrid;
    mmLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure rbLeftClick(Sender: TObject);
    procedure SelectionClick(Sender: TObject);
    procedure doUpdateStyle(Sender: TObject);
  private
    { Déclarations privées }
    procedure doDraw(Sender: TObject);
    procedure doSelection(Sender: TObject);
    procedure doValidate(Sender: TObject);
  public
    { Déclarations publiques }
  end;

var
  FormHandsFree: TFormHandsFree;

implementation

{$R *.dfm}


// Select only the pois, not the lines or polygones.
// and only for default group
procedure FilterSelection(const Shape: TECShape; var cancel: boolean);
begin
  cancel := (not (Shape is TECShapePOI)) or (shape.group.name<>'');
end;


procedure TFormHandsFree.FormCreate(Sender: TObject);
var i,neg:integer;
    lat,lng : double;
begin
// activate the hands-free drawing
map.FreeHand.Draw := true;


// event triggered when the drawing is finished
// ! it is not triggered if Selection is true
map.FreeHand.OnDraw := doDraw;

// filter the selection of each selected item
// Filtering takes place before validation.
map.FreeHand.SelectionFilter := FilterSelection;

// event triggered just before OnSelection and after SelectionFilter
map.FreeHand.OnValidSelection := doValidate;


// the event is triggered even if not items selected, default false
map.FreeHand.OnSelectedIfEmpty := true;

// the event is triggered when the selection is made
map.FreeHand.OnSelection := doSelection;


// display the label for pois

Map.shapes.pois.labels.LabelType := ltIndexOf;
Map.shapes.pois.labels.style     := lsTransparent;
Map.shapes.pois.labels.align     := laCenter;
Map.shapes.pois.labels.FontBold  := true;
Map.shapes.pois.labels.ColorType := lcContrasting;
Map.shapes.pois.labels.visible   := true;

// add random pois

  lat := map.latitude;
  lng := map.longitude;
  neg := 1;

 for I := 0 to 5 do
   begin
     lat := lat + neg*(random(1000)) / 100000  ;
     lng := lng + neg*(random(1000)) / 100000   ;
     neg := neg*-1;


     map.addpoi(lat,lng);

   end;

   // zoom to pois
   map.shapes.pois.fitBounds;

end;


// update to the freehand line style
procedure TFormHandsFree.doUpdateStyle(Sender: TObject);
var rule : string;
begin

   // rule for line in group TECNativeFreeHand
   rule := '#TECNativeFreeHand.line {'+
           'weight:'+inttostr(seWeight.value)+';'+
           'color:'+ColorToHTML(cgColor.ForegroundColor)+'}'; // ColorToHtml in unit uecMapUtil

   // deletes the previous rule and replaces it with the new one

   // The style rules are cumulative. If several rules modify the same parameter,
   // the last one takes precedence for that parameter.

  // To avoid unnecessary accumulation, since the parameters are identical here,
  // we use ClearAddRule instead of AddRule.

   map.styles.ClearAddRule(rule);

   mmLog.lines.add('Style : '+rule);
end;


// event triggered by the end of freehand drawing
// does not exist if selection mode is active
procedure TFormHandsFree.doDraw(Sender: TObject);
var  FreeHand : TECNativeFreeHand;
     poly : TECShapePolygone;
     line : TECShapeLine;
begin

  if not (Sender is TECNativeFreeHand)  then exit;
  FreeHand := Sender as TECNativeFreeHand;


// add the shape to your map

if rbPolygone.checked then
begin

 // add polygon in default group
 // To add it to another group, do : poly := FreeHand.addPolygone('group_name');
 poly := FreeHand.addPolygone; // or map.addPolygone(FreeHand.line);

 poly.FillColor := GetRandomPastelColor; // unit uecMapUtil;
 poly.color := poly.FillColor;
 poly.FillOpacity := 50+random(40);

 mmLog.lines.add('Addition of a '+doubleToStrdigit(poly.Area,2)+' km² polygon');

end
else
begin
 line := FreeHand.addLine; // or map.addLine(FreeHand.line);

 line.color := GetRandomPastelColor;

 mmLog.lines.add('Addition of a '+doubleToStrDigit(line.distance,2)+' km line');
end;


end;


// Here, validation is used to deselect items that are already selected.
// this event is activated before OnSelection
procedure TFormHandsFree.doValidate(Sender: TObject);
var FreeHand : TECNativeFreeHand;
    sIndex : string;
    i:integer;
begin
    if not (Sender is TECNativeFreeHand)  then exit;

    FreeHand := Sender as TECNativeFreeHand;

    i := 0;
    sIndex := '';

    while i < FreeHand.SelectionList.count do
    begin
      if FreeHand.SelectionList[i].Selected then
      begin
       sIndex := sIndex + inttostr(1+FreeHand.SelectionList[i].indexof)+' ';
       // deselect the item
       FreeHand.SelectionList[i].selected := false;
       // When you delete an item from this list,
       // it is not deleted from the map, nor is it deselected.
       FreeHand.SelectionList.delete(i) ;
      end
      else
       inc(i);

    end;

    if sIndex <> '' then
       mmLog.lines.add('Deselected items : '+sIndex);



end;

// event triggered by the end of the selection
procedure TFormHandsFree.doSelection(Sender: TObject);
var i:integer;
    sIndex : string;
    FreeHand : TECNativeFreeHand;
begin

  if not (Sender is TECNativeFreeHand)  then exit;

  FreeHand := Sender as TECNativeFreeHand;

  sIndex := '';
  for I := 0 to FreeHand.SelectionList.count-1 do
  begin
    sIndex := sIndex + inttostr(1+FreeHand.SelectionList[i].indexof)+' ';
  end;

  if sIndex<>'' then
     mmLog.lines.add('selected items : '+sIndex)
  else
    mmLog.lines.add('No items selected');

end;

// selection of the mouse button that activates freehand drawing
procedure TFormHandsFree.rbLeftClick(Sender: TObject);
begin
 if rbLeft.checked then
  map.FreeHand.MouseButton := TMouseButton.mbLeft
 else
 map.FreeHand.MouseButton := TMouseButton.mbRight;

end;



// Enabling hands-free selection mode
procedure TFormHandsFree.SelectionClick(Sender: TObject);
begin
 map.FreeHand.Selection := not map.FreeHand.Selection ;

 gbDraw.enabled :=  not map.FreeHand.Selection ;

 // selection := false disables freehand drawing, restore drawing
 if not map.FreeHand.Selection then
   map.FreeHand.draw := true;

end;


end.
