unit UMainNativeMiniMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uecNativeMapControl, ExtCtrls, StdCtrls,uecNativeShape,uecNativeMiniMap,uecMapUtil;

type
  TFormNativeMiniMap = class(TForm)
    Map: TECNativeMap;
    plus: TButton;
    tileserver: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure plusClick(Sender: TObject);
    procedure tileserverChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MapChangeMapZoom(Sender: TObject);
  private
    { D�clarations priv�es }
       FECMiniMap : TECNativeMiniMap;

       procedure GetGoogleTile(var TileFilename:string;const x,y,z:integer);
       procedure GetWaterColorTile(var TileFilename:string;const x,y,z:integer);
       procedure getNokiatile(var TileFilename:string;const x,y,z:integer);
       procedure getArcgistile(var TileFilename:string;const x,y,z:integer);
  public
    { D�clarations publiques }
  end;

var
  FormNativeMiniMap: TFormNativeMiniMap;

implementation

{$R *.dfm}

procedure TFormNativeMiniMap.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
 FECMiniMap.free;
end;

procedure TFormNativeMiniMap.FormCreate(Sender: TObject);
begin
 Map.LocalCache     := ExtractFilePath(application.exename) + 'cache';
 FECMiniMap         := TECNativeMiniMap.create(Map);
 FECMiniMap.BorderColor := clBlue;

 (*Map.TileServerInfo.Name      := 'ARCGIS';
 Map.TileServerInfo.TileFormat:= stJpeg;
 Map.TileServerInfo.GetTileFilename := GetArcGisTile;
 Map.TileServerInfo.CopyRight := 'National Geographic, Esri, DeLorme, NAVTEQ, UNEP-WCMC, USGS, NASA, ESA, METI, NRCAN, GEBCO, NOAA, iPC';
*)
 (*Map.TileServerInfo.MaxZoom   := 21;
 Map.TileServerInfo.Name      := 'GGL-ROAD';
 Map.TileServerInfo.GetTileFilename := GetGoogleTile;*)
 (*Map.TileServerInfo.MaxZoom   := 18;
 Map.TileServerInfo.TileFormat:= stJpeg;
 Map.TileServerInfo.Name      := 'WATERCOLOR';
 Map.TileServerInfo.GetTileFilename := GetWaterColorTile; *)
end;


procedure TFormNativeMiniMap.GetGoogleTile(var TileFilename:string;const x,y,z:integer);
begin
  TileFilename := format('http://mt%d.googleapis.com/vt?x=%d&y=%d&z=%d',[random(4),x,y,z]);
end;

procedure TFormNativeMiniMap.GetWaterColorTile(var TileFilename:string;const x,y,z:integer);
begin
  TileFilename := format('http://tile.stamen.com/watercolor/%d/%d/%d.jpg',[z,x,y]);
end;

procedure TFormNativeMiniMap.MapChangeMapZoom(Sender: TObject);
begin
 Caption := inttostr(Map.zoom)  ;
end;

procedure TFormNativeMiniMap.getNokiatile(var TileFilename:string;const x,y,z:integer);
begin
  TileFilename := format('http://maptile.maps.svc.ovi.com/maptiler/maptile/newest/normal.day/%d/%d/%d/256/png8',[z,x,y]);
end;

procedure TFormNativeMiniMap.getArcgistile(var TileFilename:string;const x,y,z:integer);
begin
  TileFilename := format('http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/%d/%d/%d.png',[z,y,x]);
end;


procedure TFormNativeMiniMap.plusClick(Sender: TObject);
begin
 if assigned(FECMiniMap.map) then
  FECMiniMap.map := nil
 else
 begin
   FECMiniMap.map := Map;
 end;

end;

procedure TFormNativeMiniMap.tileserverChange(Sender: TObject);
begin

 // use same tileserver than map
 FECMiniMap.TileServer := tsNone;

 case tileserver.ItemIndex of

  0 :  map.TileServer := tsOSM;

  1 :  map.TileServer := tsOpenCycleMap;
  2 :  map.TileServer := tsOPNV;

  3 :  map.tileServer := tsArcGisWorldTopoMap;
  4 :  map.tileServer := tsArcGisWorldStreetMap;
  5 :  begin
          map.tileServer        := tsArcGisWorldImagery;
          FECMiniMap.TileServer := tsArcGisWorldStreetMap;
       end;

end;
end;

end.
