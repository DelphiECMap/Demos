unit UOpenServices;

(*

  Example of using the Overpass API to display business hours
  Inspired by a bizdata API demo : https://mapsmania.github.io/geocoder/openbars.html ( https://bizdata-web.vercel.app/ )



*)

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.uecNativeMapControl, FMX.uecnativeshape, FMX.uecMaputil,
    OpeningHoursParser, FMX.StdCtrls;

type
  TFOpenServices = class(TForm)
    map: TECNativeMap;
    AIndicator: TAniIndicator;
    procedure FormCreate(Sender: TObject);
    procedure mapLoad(Sender: TObject; const GroupName: string; const
      FinishLoading: Boolean);
    procedure mapMapClick(Sender: TObject; const Lat, Lng: Double);
  private
    { Déclarations privées }
    FRadiusKM: double;
    FGIsOpen: TECShapes;

    procedure doOverPass(const value: TECOverPassData);
    procedure doOnClick(sender: TObject; const item: TECShape);
  public
    { Déclarations publiques }
  end;

var
  FOpenServices: TFOpenServices;

implementation

{$R *.fmx}

procedure TFOpenServices.FormCreate(Sender: TObject);
begin
  FRadiusKM := 2; // 2 km
  FGIsOpen := map['isOpen'];

  // define styles based on the service's open status
  map.styles.addRule('#isOpen {width:24;height:24}');
  map.styles.addRule('#isOpen.Marker.isOpen:? {color:gray}'); // unknow
  map.styles.addRule('#isOpen.Marker.isOpen:false {color:red}');
  map.styles.addRule('#isOpen.Marker.isOpen:true {color:green}');

  map.setCenter(40.7128, -74.0060);

end;

procedure TFOpenServices.mapMapClick(Sender: TObject; const Lat, Lng: Double);
var
  latSW, lngSW, latNE, lngNE: double;
begin

   AIndicator.Enabled := true;
  // Do not accept any new searches until this one is complete
  map.OnMapClick := nil;

  // determine the geographic area based on the clicked point and the distance in kilometers
  boundingCoordinates(lat, lng, FRadiusKM, latSW, lngSW, latNE, lngNE);

  // Perform a search with OverPass in this area; when a result is available, doOverPass is called
  Map.OverPassApi.amenity(latSW, lngSW, latNE, lngNE, 'bar', [odNode],
    doOverPass);
end;

// the event is triggered when data is available
procedure TFOpenServices.doOverPass(const value: TECOverPassData);
begin
  FGIsOpen.clear;
  // load OSM data in your map
  // Loading is asynchronous; `mapLoad` is called when it is complete
  FGIsOpen.LoadFromOSMString(value.Data);
end;

procedure TFOpenServices.mapLoad(Sender: TObject; const GroupName: string;
  const FinishLoading: Boolean);
var
  Status: TOpeningStatus;
  i: integer;
  M: TECShapeMarker;
begin

  // Browse through all the results
  for i := 0 to FGIsOpen.Markers.count - 1 do
  begin
    M := FGIsOpen.Markers[i];
    // hook up to respond to a click on the element
    M.OnShapeClick := doOnClick;

    // check if any information about the service's opening hours is available
    Status := ParseOpeningHours(M['opening_hours']);

    if Status.Known then
    begin
      M['isOpen'] := BoolToStr(Status.Open) ;
      M['allDay'] := BoolToStr(Status.AllDay)
    end
    else
      M['isOpen'] := '?';
   end;


  AIndicator.Enabled := false;
  // reauthorize research
  map.OnMapClick := mapMapClick;
  map.ColorFilter
end;

// fired whan click on item
procedure TFOpenServices.doOnClick(sender: TObject; const item: TECShape);
var
  Key, Value, content: string;
  win: TECShapeInfoWindow;
begin
  content := '';

  if item.PropertiesFindFirst(Key, Value) then
  begin
    repeat
      // if necessary line break
      if content <> '' then
        content := content + '<br>';
      // align the values to 100 pixels
      Key := Key + '<tab=100>';
      // Bold the keys
      content := content + '<b>' + Key + '</b>: ' + Value;
      // continue as long as there are properties
    until item.PropertiesFindNext(Key, Value);
  end;

  if content = '' then
    exit;

  // create window if not exists
  if FGIsOpen.InfoWindows.count = 0 then
  begin
    win := FGIsOpen.AddInfoWindow;
    win.Width := 270;
 end
  else
    win := FGIsOpen.InfoWindows[0];

  win.content := content;
  win.SetPosition(map.MouseLatLng.Lat, map.MouseLatLng.lng);
  win.Visible := true;

end;

end.

