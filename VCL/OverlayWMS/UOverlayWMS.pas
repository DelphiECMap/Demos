unit UOverlayWMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, uecmaputil, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFormWMS = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    ckOverlay: TCheckBox;
    ckLinkedMap: TCheckBox;
    tkOpacity: TTrackBar;
    lbSelect: TLabel;
    Label2: TLabel;
    info: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ckOverlayClick(Sender: TObject);
    procedure ckLinkedMapClick(Sender: TObject);
    procedure mapMapSelectRect(Sender: TObject; const SWLat, SWLng, NELat,
      NELng: Double);
    procedure tkOpacityChange(Sender: TObject);
  private
    { Déclarations privées }
   FECOverlayWMS : TECOverlayWMS;

   procedure doBeforeLoad(Sender: TObject);
   procedure doLoad(Sender: TObject);
  public
    { Déclarations publiques }
  end;

var
  FormWMS: TFormWMS;

implementation

{$R *.dfm}


procedure TFormWMS.FormCreate(Sender: TObject);
begin


  FECOverlayWMS := TECOverlayWMS.Create(
     map,
    'https://ows.mundialis.de/services/service', // WMS service url
    'OSM-Overlay-WMS', // WMS Layer
    'Labels-WMS' // Name of the group containing the overlay, which is a TECShapeMarker
   );

   //Triggered just before the call to the WMS server
   //If the image is already in the cache, then the event does not occur.
   FECOverlayWMS.OnBeforeLoad := doBeforeLoad;

   // Triggered when image has been retrieved either from cache or from WMS server
   FECOverlayWMS.onLoad       := doLoad;

   (* you can modify after creation

    FECOverlayWMS.layers := 'new layers';
    FECOverlayWMS.Server := 'new server';

  *)

  ckOverlay.Checked     := true;
  ckLinkedMap.Checked   := true;
  tkOpacity.Position    := FECOverlayWMS.Opacity;

  map.TileServer := tsArcGisWorldImagery; // in uecMapUtil


end;

procedure TFormWMS.doBeforeLoad(Sender: TObject);
begin
   info.Caption := 'Loading...';
end;

procedure TFormWMS.doLoad(Sender: TObject);
begin
  info.Caption := '';
end;

// The overlay is link to the visible area of the map or not
procedure TFormWMS.ckLinkedMapClick(Sender: TObject);
begin

  (*
    When LinkToMapArea = true,
    the overlay is automatically updated when the map changes location.
  *)

   FECOverlayWMS.LinkToMapArea := ckLinkedMap.Checked;
   lbSelect.Visible            := not ckLinkedMap.Checked;

   if lbSelect.Visible then
    map.DragRect := drSelect
   else
    map.DragRect := drNone;

end;

// triggered by selecting a rectangular area with the mouse
procedure TFormWMS.mapMapSelectRect(Sender: TObject; const SWLat, SWLng, NELat,
  NELng: Double);
begin
 FECOverlayWMS.Bounds(NELat,NELng,SWLat,SWLng);
end;


procedure TFormWMS.ckOverlayClick(Sender: TObject);
begin
  FECOverlayWMS.Visible := ckOverlay.Checked;
end;


procedure TFormWMS.tkOpacityChange(Sender: TObject);
begin
  FECOverlayWMS.Opacity := tkOpacity.Position;
end;

end.
