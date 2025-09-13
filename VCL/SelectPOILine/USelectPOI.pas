unit USelectPOI;

// Indicate the position on a Line when hovering with the mouse

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uecNativeMapControl,uecNativeShape, uecEditNativeLine,uecMapUtil;

type
  TFormSelectLine = class(TForm)
    FMap: TECNativeMap;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
   FSelectPoi: TecSelectPointNativeLine; // unit uecEditNativeLine

   FSelectLine : TECShapeLine ; // unit uecNativeShape

   procedure setLine(const ALine : TECShapeLine);

   procedure doOnAddRoute(sender: TECShapeLine; const params: string);

   procedure doOnPOIMove(sender: TObject; const item: TECShape);
   procedure doOnPOIMouseOut(sender: TObject; const item: TECShape);
   procedure doOnPOIClick(sender: TObject; const Lat, Lng: double);

  public
    { Déclarations publiques }
  property SelectLine : TECShapeLine read FSelectLine write setLine;
  end;

var
  FormSelectLine: TFormSelectLine;

implementation

{$R *.dfm}


procedure TFormSelectLine.FormCreate(Sender: TObject);
begin

  FSelectPoi := TecSelectPointNativeLine.Create;

  // doOnAddRoute will be called when the route has been calculated
  FMap.Routing.OnAddRoute := doOnAddRoute;

  // By default, the routing engine is reOpenStreetMap.
  //Map.Routing.engine(reValhalla);

  FMap.Routing.Request('Tarbes','Lourdes');

end;

// The route (sender) has been calculated and displayed on the map.
procedure TFormSelectLine.doOnAddRoute(sender: TECShapeLine; const params: string);
begin

  sender.ShowText     := false;
  sender.color        := clRed;

  SelectLine := Sender;

end;



procedure TFormSelectLine.setLine(const ALine: TECShapeLine);
begin

  FSelectLine     := ALine;
  FSelectPoi.Line := ALine;

  if not assigned(ALine) then exit;

  ALine.fitBounds;

  FSelectLine.BorderColor := clWhite;
  FSelectLine.HoverBorderColor := clWhite;

  // style poi on line
  // ColorToHTML in uecMapUtil unit
  FMap.Styles.addRule('#' + FSelectPoi.Group.Name +
    '.poi{poishape:ellipse;width:20;height:20;bsize:4;color:' +
     ColorToHTML(ALine.color) + ';bcolor:white;hbcolor:white}');

  FSelectPoi.OnshapeMove := doOnPOIMove;
  FSelectPoi.OnshapeMouseOut := doOnPOIMouseOut;
  FSelectPoi.OnClick := doOnPOIClick;

end;

procedure TFormSelectLine.doOnPOIMove(sender: TObject; const item: TECShape);
var KM : double;
begin

   KM := FSelectLine.DistanceToPoint(item.Latitude, item.Longitude);

   FSelectPoi.Select.Hint := doubletostrDigit(KM, 2)+' km'; // unit uecMapUtil

   FSelectPoi.Select.ShowHint;


end;


procedure TFormSelectLine.doOnPOIMouseOut(sender: TObject; const item: TECShape);
begin
  //
end;

procedure TFormSelectLine.doOnPOIClick(sender: TObject; const Lat, Lng: double);
begin
  ShowMessage('Lat : '+DoubleToStrDigit(Lat,4)+#13#10+
              'Lng : '+DoubleToStrDigit(Lng,4)+#13#10+
              'Km  : '+doubletostrDigit((Sender as TECShapeLine).DistanceToPoint(Lat, Lng),2));
end;


end.
