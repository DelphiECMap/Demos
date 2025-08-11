unit UClusterAggregateAaverageVvalues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl,uecNativeShape,uecmaputil,
  Vcl.StdCtrls;

type
  TFormCluster = class(TForm)
    map: TECNativeMap;
    Loading: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure doOnLoad(Sender: TObject; const GroupName: string;
      const FinishLoading: Boolean);
  private
    { Déclarations privées }

    FEarthquakes : TECShapes; // (unit uecNativeShape);

    procedure doOnGetClusterText(const Cluster: TECCluster; var Text: String) ;
    procedure doOnGetClusterColorSize(const Cluster: TECCluster; var Color: Tcolor;
    var BorderColor: Tcolor; var TextColor: Tcolor;
    var WidthHeight, FontSize: integer; var CStyle: TClusterStyle) ;

    function getAggregateAverageValues(const Cluster: TECCluster; const PropValue:string):double;

  public
    { Déclarations publiques }
  end;

var
  FormCluster: TFormCluster;

implementation

{$R *.dfm}

procedure TFormCluster.FormCreate(Sender: TObject);
begin
 map.Zoom := 2;

 // Create a group that will contain points representing earthquakes.
 FEarthquakes := map['earthquakes'];

 // The tooltip for the points will display the mag and place properties.
 FEarthquakes.Hint := 'Magnitude [mag]'#13#10'[place]';

 // definition of styles applied to markers in group earthquakes

 // this rule is for all markers in earthquakes group
 map.styles.addRule('#earthquakes.marker {width:35;height:35;StyleIcon : flat;hbcolor : white;bcolor : white; bsize : 3}');
 // The other rules depend on the content of the mag property.
 map.styles.addRule('#earthquakes.marker {if:mag<3;color:$008000;}');
 map.styles.addRule('#earthquakes.marker {if:mag<4;color:$00FFFF;}');
 map.styles.addRule('#earthquakes.marker {if:mag<5;color:$008CFF;}');
 map.styles.addRule('#earthquakes.marker {if:mag>5;color:$0000FF;}');


 // doOnLoad will be triggered when the file has finished loading.
 Map.OnLoad   := doOnLoad;

 // Load GeoJSON feed of all earthquakes from the past 30 days. Sourced from the USGS
 FEarthquakes.LoadFromFile('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson');

 // Enable clusters for the group
 FEarthquakes.Clusterable := true;
 // default size
 FEarthQuakes.ClusterManager.WidthHeight       := 50;
 // store the list of markers grouped in the cluster,
 // this will allow the average magnitude to be calculated
 FEarthQuakes.ClusterManager.FillClusterList   := true;
 // This event will allow us to change the color and size of the cluster.
 FEarthQuakes.ClusterManager.OnColorSizeCluster:= doOnGetClusterColorSize;
 // This event will allow us to modify the text of the cluster.
 FEarthQuakes.ClusterManager.OnClusterGetText  := doOnGetClusterText;

 end;

// hide the ‘Loading’ label when the group FEarthquakes is loaded
procedure TFormCluster.doOnLoad(Sender: TObject; const GroupName: string;
  const FinishLoading: Boolean);
begin
 Loading.Visible := not (GroupName = FEarthquakes.Name);
end;


// Calculate the average of the PropValue property of the markers contained in the Cluster
function TFormCluster.getAggregateAverageValues(const Cluster: TECCluster; const PropValue:string):double;
var i,MaxValues:integer;
begin

 result := 0;

 MaxValues := Cluster.Shapes.Count;

 if not assigned(Cluster) or (MaxValues=0) then
  exit;


 for i := 0 to MaxValues-1 do
   begin
      result := result + StrToDoubleDef(Cluster.Shapes[i][PropValue],0);
   end;

   result := result / MaxValues;
end;



// doOnGetClusterColorSize is called just before doOnGetClusterText
// Modify cluster properties based on average magnitudes
procedure TFormCluster.doOnGetClusterColorSize(const Cluster: TECCluster; var Color: Tcolor;
    var BorderColor: Tcolor; var TextColor: Tcolor;
    var WidthHeight, FontSize: integer; var CStyle: TClusterStyle) ;
var AValue : double;
begin
  AValue := getAggregateAverageValues(Cluster,'mag');

  Cluster.Hint := DoubleToStrDigit(AValue,2);

  if AValue<=3 then
  begin
   Color := clWebGreen;
   WidthHeight := 35;
   FontSize    := 8;
  end
  else
  if AValue<=4 then
  begin
   Color := clWebYellow ;
   WidthHeight := 40;
   FontSize    := 9;
  end
  else
  if AValue<=5 then
  begin
   Color := clWebDarkOrange;
   WidthHeight := 45;
   FontSize    := 10;
  end
  else
  begin
   Color := clWebRed;
   WidthHeight := 50;
   FontSize    := 11;
  end;

   TextColor := GetContrastingColor(Color);

end;

//
procedure TFormCluster.doOnGetClusterText(const Cluster: TECCluster; var Text: String) ;
begin
   // The average value of earthquakes was calculated in doOnGetClusterColorSize
   // and stored in Hint.
   Text := Cluster.Hint;
   // Stoking the number of earthquakes in Hint
   Cluster.Hint := inttostr(Cluster.count)+' earthquakes';
end;



end.
