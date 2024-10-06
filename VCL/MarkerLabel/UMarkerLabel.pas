unit UMarkerLabel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uecNativeMapControl,uecnativeshape,uecMapUtil,uecGraphics,
  Vcl.ExtCtrls;

type


  TForm27 = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    addMarker: TButton;
    Label1: TLabel;
    cbStyle: TComboBox;
    Label2: TLabel;
    cbAlign: TComboBox;
    ckLabels: TCheckBox;
    AddPois: TButton;
    RadioGroup1: TRadioGroup;
    rbMarkers: TRadioButton;
    rbPois: TRadioButton;
    ckScale: TCheckBox;
    Label3: TLabel;
    cbSelect: TComboBox;
    ckConnector: TCheckBox;
    Label4: TLabel;
    cbStyleLine: TComboBox;
    Label5: TLabel;
    cbMargin: TComboBox;
    procedure addMarkerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbStyleChange(Sender: TObject);
    procedure cbAlignChange(Sender: TObject);
    procedure ckLabelsClick(Sender: TObject);
    procedure rbMarkersClick(Sender: TObject);
    procedure AddPoisClick(Sender: TObject);
    procedure ckScaleClick(Sender: TObject);



    procedure cbSelectChange(Sender: TObject);
    procedure ckConnectorClick(Sender: TObject);
    procedure cbStyleLineChange(Sender: TObject);
    procedure cbMarginChange(Sender: TObject);
  private
    { Déclarations privées }
    FLabelShape : TLabelShape;


    procedure doSelectAlphaBetaGamma(sender:TObject;const Shape: TECShape;var cancel: Boolean);

  public
    { Déclarations publiques }
  end;

var
  Form27: TForm27;

implementation

{$R *.dfm}



// select items according to the AlphaBetaGamma filter
procedure TForm27.doSelectAlphaBetaGamma(sender:TObject;const Shape: TECShape;var cancel: Boolean);
begin

  case cbSelect.ItemIndex of
   1 : cancel :=  (shape.propertyValue['alphabetagamma']<>'alpha');
   2 : cancel :=  (shape.propertyValue['alphabetagamma']<>'beta');
   3 : cancel :=  (shape.propertyValue['alphabetagamma']<>'gamma');
  end;

end;



procedure TForm27.AddPoisClick(Sender: TObject);
var poi : TECShapePoi;
    i,direction   : integer;
    lat,lng : double;

    anim : TECAnimationMoveToDirection;

    KmH : integer;

begin

  direction := random(360);

  for i:= 0 to 7 do
  begin

    // calculate lat and lng at 500 meters from the center of the map, depending on direction
    map.LatLonFromDistanceBearing(map.latitude,map.longitude,500,direction,lat,lng);


    poi := map.AddPoi(lat,lng) ;


    poi.POIShape := poiArrowHead;

     case random(3) of
     0 : begin
          poi.propertyValue['alphabetagamma']:='alpha';
          poi.Selected := cbSelect.ItemIndex=1;
         end;
     1 : begin
          poi.propertyValue['alphabetagamma']:='beta';
          poi.Selected := cbSelect.ItemIndex=2;
         end;
     2 : begin
          poi.propertyValue['alphabetagamma']:='gamma';
          poi.Selected := cbSelect.ItemIndex=3;
         end;
   end;



    KmH := 30 + random(90);

    poi.Description := 'Poi n°'+inttostr(poi.IndexOf+1)+#13#10+'Speed : '+inttostr(KmH)+' KmH'+#13#10+poi.propertyValue['alphabetagamma'];

    poi.fillOpacity := 80;

    poi.Draggable := true;

    poi.Color := GetRandomPastelColor;

    poi.borderColor := GetShadowColorBy(poi.Color,48);

    poi.BorderSize  := 1;

    poi.HoverColor       := poi.borderColor;
    poi.HoverBorderColor := poi.Color;

    anim := TECAnimationMoveToDirection.Create(Kmh, direction);

    // anim is automatic free when mrk is free
    poi.animation := anim;
    anim.Heading  := true;
    anim.Start;



    direction := (direction + 45) mod 360;




  end;



  rbPois.Checked := true;



end;

procedure TForm27.cbAlignChange(Sender: TObject);
begin

 case cbAlign.ItemIndex of
   0 : FLabelShape.Align      := laTop;
   1 : FLabelShape.Align      := laBottom;
   2 : FLabelShape.Align      := laLeft;
   3 : FLabelShape.Align      := laRight;
 end;


end;

procedure TForm27.cbMarginChange(Sender: TObject);
begin
 FLabelShape.Margin := (1+cbMargin.ItemIndex)*10;
end;

procedure TForm27.cbStyleChange(Sender: TObject);
begin
 case cbStyle.ItemIndex of
   0 : FLabelShape.Style := lsRectangle ;
   1 : FLabelShape.Style := lsRoundRect;
   2 : FLabelShape.Style := lsTransparent;

 end;


end;

procedure TForm27.cbStyleLineChange(Sender: TObject);
begin
 case cbStyleLine.ItemIndex of
  0 : FLabelShape.ConnectorLineStyle := psSolid;
  1 : FLabelShape.ConnectorLineStyle := psDash;
  2 : FLabelShape.ConnectorLineStyle := psDashdot;
  3 : FLabelShape.ConnectorLineStyle := psdot;
 end;
end;

procedure TForm27.ckConnectorClick(Sender: TObject);
begin
 FLabelShape.ConnectorLine := ckConnector.Checked;
end;

procedure TForm27.ckLabelsClick(Sender: TObject);
begin
 FLabelShape.Visible := ckLabels.Checked;
end;

procedure TForm27.ckScaleClick(Sender: TObject);
begin
FLabelShape.Scale := ckScale.Checked;
end;

procedure TForm27.FormCreate(Sender: TObject);
begin

  FLabelShape :=  map.Shapes.Markers.Labels;


  //map.Shapes['shadowcolor'] := clRed.ToString;
  //FLabelShape.margin := 10;

 // FLabelShape.ShadowText := true;
  //FLabelShape.ShadowTextOffset := 2;


  FLabelShape.align      := latop;
  FLabelShape.Style := lsRectangle;

  FLabelShape.Bordersize := 0;


  map.Selected.OnSelectShape := doSelectAlphaBetaGamma;

  map.ScaleMarkerToZoom := true;

  addMarkerClick(self);

  FLabelShape.Visible    := true;

  map.ColorFilter.filter := fcGrey;

  rbMarkersClick(nil);


end;

procedure TForm27.rbMarkersClick(Sender: TObject);
begin

 if rbMarkers.checked then
  FLabelShape :=  map.Shapes.Markers.Labels
 else
  FLabelShape :=  map.Shapes.Pois.Labels  ;


  ckLabelsClick(nil);
  cbSelectChange(nil);
  cbStyleChange(nil);
  cbAlignChange(nil);
  ckConnectorClick(nil);
  cbStyleLineChange(nil);
  cbMarginChange(nil);
end;

procedure TForm27.cbSelectChange(Sender: TObject);
begin
 map.Selected.UnSelectedAll;

 if cbSelect.ItemIndex>0 then
    FLabelShape.ShowOnlyIf := lsoSelected
 else
    FLabelShape.ShowOnlyIf := lsoAll;

 if FLabelShape.ShowOnlyIf = lsoSelected then
   map.Selected.all;
end;

procedure TForm27.addMarkerClick(Sender: TObject);
var mrk : TECShapeMarker;
    i,direction   : integer;
    lat,lng : double;
begin

  direction := 0;

  for i:= 0 to 7 do
  begin

    // calculate lat and lng at 500 meters from the center of the map, depending on direction
    map.LatLonFromDistanceBearing(map.latitude,map.longitude,500,direction,lat,lng);


    mrk := map.AddMarker(lat,lng) ;

    mrk.StyleIcon := siFlatNoBorder;//  siflat;


    case random(3) of
     0 : begin
          mrk.propertyValue['alphabetagamma']:='alpha';
          mrk.Selected := cbSelect.ItemIndex=1;
         end;
     1 : begin
          mrk.propertyValue['alphabetagamma']:='beta';
          mrk.Selected := cbSelect.ItemIndex=2;
         end;
     2 : begin
          mrk.propertyValue['alphabetagamma']:='gamma';
          mrk.Selected := cbSelect.ItemIndex=3;
         end;
   end;


    mrk.Description := 'Marker n°'+inttostr(mrk.IndexOf+1)+#13#10 +mrk.propertyValue['alphabetagamma'];

    mrk.hint := 'hint marker n°'+inttostr(mrk.IndexOf+1);

    mrk.Opacity := 100;

    mrk.Draggable := true;

    mrk.Color := GetHashColor('M'+mrk.propertyValue['alphabetagamma']);;

    direction := direction + 45;

   // mrk['fontcolor']:='rgb('+inttostr(random(255))+','+inttostr(random(255))+','+inttostr(random(255))+')';
   // mrk['fillcolor']:='red';
   // mrk['bordercolor']:='#10ee55';
   //mrk['shadowcolor'] := clyellow.ToString;




  end;

  rbMarkers.Checked := true;



end;

end.
