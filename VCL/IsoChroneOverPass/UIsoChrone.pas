unit UIsoChrone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, uecNativeShape,
  uecmaputil, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFIsoChrone = class(TForm)
    pnCmd: TPanel;
    map: TECNativeMap;
    rgSearch: TRadioGroup;
    foot5: TRadioButton;
    foot10: TRadioButton;
    car5: TRadioButton;
    car10: TRadioButton;
    foot500m: TRadioButton;
    car3km: TRadioButton;
    car10km: TRadioButton;
    foot1km: TRadioButton;
    btSearch: TButton;
    procedure FormCreate(Sender: TObject);
    procedure foot5Click(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
  private
    { Déclarations privées }

    FPolygoneIsoChrone : TECShapePolygone;

    procedure doOverPass(const value:TECOverPassData);
    procedure doOnLoadRestaurant(sender : TObject);

  public
    { Déclarations publiques }
  end;

var
  FIsoChrone: TFIsoChrone;

implementation

{$R *.dfm}



procedure TFIsoChrone.FormCreate(Sender: TObject);
begin

  // use Valhalla for isoChrone
  map.Routing.Engine(reValhalla);

  // create empty polygon in iso group
  FPolygoneIsoChrone := map['iso'].AddPolygone;
  map['iso'].zindex := -10;
  map['iso'].clickable := false;

  // define the polygon style for iso group
  map.styles.addRule('#iso.polygone{penStyle:dash;fopacity:20;color:dark(green);fcolor:green}');


  // style restaurant
  map.styles.addRule('.marker.amenity:restaurant ' +
    '{scale:1;graphic:base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAAaBAMAAABI' +
    'sxEJAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABJQTFRFAAAA////AAAAAAA'
    + 'AAAAAAAAA/h6U3wAAAAV0Uk5TAAAQgL++EJOXAAAAOElEQVQY02MIFQ0MFWRUCXVigLBcQ0OgrNDQUH'
    + 'JYQIDOMg0NDYawBIFC2FgCSCxBerFMg0Es02AAP34wMx8/aIAAAAAASUVORK5CYII=;visible:true;}');

  // triggered when the restaurant search is over
  map.OverPassApi.OnData := doOverPass;
  // triggered when restaurant data is loaded
  map['restaurant'].OnLoad := doOnLoadRestaurant;
end;


// click on radiobutton
procedure TFIsoChrone.foot5Click(Sender: TObject);
begin
 if assigned(Sender) and (Sender is TRadioButton) then
 begin

  rgSearch.tag :=  TRadioButton(sender).tag;

 end;

end;


procedure TFIsoChrone.btSearchClick(Sender: TObject);
begin
   btSearch.Caption := 'Wait...';

   map['restaurant'].Clear;

   pnCmd.Enabled := false;


   // find isochrone center on map
    case rgSearch.tag of
   0: map.routing.IsoChrone.Time(map.latitude,map.longitude,[FPolygoneIsoChrone],[5],rtPedestrian) ;
   1: map.routing.IsoChrone.Time(map.latitude,map.longitude,[FPolygoneIsoChrone],[10],rtPedestrian) ;
   2: map.routing.IsoChrone.Time(map.latitude,map.longitude,[FPolygoneIsoChrone],[5],rtCar) ;
   3: map.routing.IsoChrone.Time(map.latitude,map.longitude,[FPolygoneIsoChrone],[10],rtCar) ;
   4: map.routing.IsoChrone.Distance(map.latitude,map.longitude,[FPolygoneIsoChrone],[0.5],rtPedestrian) ;
   5: map.routing.IsoChrone.Distance(map.latitude,map.longitude,[FPolygoneIsoChrone],[1],rtPedestrian) ;
   6: map.routing.IsoChrone.Distance(map.latitude,map.longitude,[FPolygoneIsoChrone],[1],rtCar) ;
   7: map.routing.IsoChrone.Distance(map.latitude,map.longitude,[FPolygoneIsoChrone],[3],rtCar) ;

  end;

   // Zooming in on the isochrone
   FPolygoneIsoChrone.fitBounds;


  // find all 'restaurant' (only Node not Way) in FPolygoneIsoChrone
   map.OverPassApi.FilterPolygone := FPolygoneIsoChrone ;
   map.OverPassApi.Amenity('restaurant',[odNode]);

end;

// the OverpassAPI request is completed
procedure TFIsoChrone.doOverPass(const value:TECOverPassData);
begin
 // load OSM data in your map
 // loading is performed in a thread,
 // map['restaurant'].OnLoad is triggered when everything is ready
 map['restaurant'].LoadFromOSMString(value.Data);
end;

// Loading is complete
procedure TFIsoChrone.doOnLoadRestaurant(sender : TObject);
begin
  btSearch.Caption := 'Search...';
  pnCmd.Enabled := true;
end;


end.
