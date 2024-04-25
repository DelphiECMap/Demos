unit UMainMultiView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, uecNativeMapControl, uecNativeShape,uecMapUtil, Vcl.StdCtrls;

type
  TFormMultiView = class(TForm)
    pnMaster: TPanel;
    pnViews: TPanel;
    pnMasterBar: TPanel;
    MasterMap: TECNativeMap;
    pnRight: TPanel;
    pnBarViewA: TPanel;
    ViewAMap: TECNativeMap;
    pnLeft: TPanel;
    pnBarViewB: TPanel;
    ViewBMap: TECNativeMap;
    AddMasterPois: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormResize(Sender: TObject);
    procedure AddMasterPoisClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormMultiView: TFormMultiView;

implementation

{$R *.dfm}


procedure TFormMultiView.FormCreate(Sender: TObject);
begin
  MasterMap.AddView(ViewAMap);
  MasterMap.AddView(ViewBMap);

  MasterMap.Shapes.Pois.Labels.Visible := true;
  MasterMap.Shapes.Pois.Labels.Align   := laCenter;
  MasterMap.Shapes.Pois.Labels.Margin  := 0;
  MasterMap.Shapes.Pois.Labels.Style   := lsTransparent;
end;

procedure TFormMultiView.AddMasterPoisClick(Sender: TObject);
var
  x, y,r: integer;
  P: TECShapePOI;
  M: TECShapeMarker;
  Poly:TECShapePolygone;
  SouthWest, NorthEast: TLatLng;
  Lat, Lng,
  dx, dy: double;
begin

  // add shapes only in MasterMap
  MasterMap.BeginUpdate;

  dy := (MasterMap.NorthEastLatitude - MasterMap.SouthWestLatitude) / 2;
  dx := (MasterMap.NorthEastLongitude - MasterMap.SouthWestlongitude) / 2;

  for y := 0 to 5 do
  begin
    for x := 0 to 5 do
    begin


      Lat := MasterMap.latitude - dy + (random(round(dy*2 * 1000)) / 1000);
      Lng := MasterMap.longitude - dx + (random(round(dx*2 * 1000)) / 1000);

      r := random(3);
      // add Marker or Polygon or Poi
      if r=0 then
      begin
       M := MasterMap.AddMarker(lat,lng);
       M.Hint := 'Marker n°'+inttostr(M.IndexOf);
       M.Draggable := true;
       M.Color := GetrandomColor;
      end
      else
      if r=1 then
      begin
        SouthWest.Lat := lat;
        SouthWest.Lng := lng;
        NorthEast.Lat := lat+0.005;
        NorthEast.Lng := lng+0.005;
        poly := MasterMap.AddPolygone(SouthWest,NorthEast);
        poly.FillColor := GetrandomColor;
      end
      else
      begin
      P  := MasterMap.AddPoi(Lat,Lng);


      P.width  := 32;
      P.height := 32;

      P.hint := 'Poi n°' + inttostr(P.IndexOf);

      P.Description :=  inttostr(P.indexof);

      P.Draggable := true;

      P.FillOpacity := 10+random(90);

      P.BorderSize := 2;

      case random(13) of
        0:
          P.POIShape := poiEllipse;
        1:
          P.POIShape := poiStar;
        2:
          P.POIShape := poiTriangle;
        4:
          P.POIShape := poiDiamond;
        5:
          P.POIShape := poiHexagon;
        6:
          P.POIShape := poiArrow;
        7:
          P.POIShape := poiArrowHead;
        8:
          P.POIShape := poiCross;
        9:
          P.POIShape := poiDiagCross;
        10:
          begin
            P.POIShape := poiDirectionSign;
            P.width := 64;
          end;
        12:
          P.POIShape := poiRect;
        11:
          begin
            // now draw, only text label
            P.POIShape := poiNone;
            P.Description := 'Poi n°' + inttostr(P.IndexOf);
          end;
      end;

      P.Color := GetHashColor(lowercase(copy(psToStr(P.POIShape), 4)));

     end;

    end;
  end;



  MasterMap.EndUpdate;

end;



procedure TFormMultiView.FormResize(Sender: TObject);
begin
  pnViews.Height := ClientHeight div 2;
  pnRight.Width  := ClientWidth  div 2;
end;

end.
