unit UMain;


(*

This demo shows how to integrate Windy's webcam API.
You can find the documentation and instructions on how to obtain your API key at: https://api.windy.com/webcams/docs

*)


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  // Delphi units for managing the Windy API
  Windy.Webcams.Types, Windy.Webcams.Vcl, Windy.Webcams.Models, Windy.Webcams.Query,
  //
  uecNativeMapControl, uecnativeshape;

type
  TForm13 = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    PLog: TPanel;
    btWebCams: TButton;
    MLog: TMemo;
    InfoCam: TMemo;
    procedure btWebCamsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mapShapeClick(sender: TObject; const item: TECShape);
  private
    { Déclarations privées }
    VclWindyWebcamsClient: TVclWindyWebcamsClient;
    VclWindyWebcamImage: TVclWindyWebcamImage;
    FSelectedCam: TECShape;

    procedure doWebCamRefresh(Sender: TObject);
    procedure ShowInfoWebCam;
  public
    { Déclarations publiques }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}


procedure TForm13.FormCreate(Sender: TObject);
begin

  // TVclWindyWebcamsClient is the client that supports the Windy API
  VclWindyWebcamsClient := TVclWindyWebcamsClient.create(self);
  VclWindyWebcamsClient.ApiKey := 'use your api key';

  // VclWindyWebcamImage is derived from TImage and allows a webcam to be displayed based on its ID
  // You must connect a TVclWindyWebcamsClient to it
  VclWindyWebcamImage := TVclWindyWebcamImage.create(Panel1);
  VclWindyWebcamImage.Client := VclWindyWebcamsClient;
  VclWindyWebcamImage.OnRefresh := doWebCamRefresh;
  VclWindyWebcamImage.parent := Panel1;
  VclWindyWebcamImage.align := alTop;
  VclWindyWebcamImage.top := 0;
  VclWindyWebcamImage.height := 256;
  VclWindyWebcamImage.RefreshInterval := 60; // 1 minute
  VclWindyWebcamImage.AutoRefresh := True;
end;


// Retrieving the list of webcams within the map's visible area
procedure TForm13.btWebCamsClick(Sender: TObject);
var
  LList: TWindyWebcamList;
  LWebcam: TWindyWebcam;
  i: integer;
  P: TECShapeMarker;

  Total: int64;
  Offset: int64;
begin

  Offset := 0;
  Total := 0;

  map.BeginUpdate;

  (*
   A single API call can retrieve a maximum of 50 webcams.
   You must make multiple calls, adjusting the offset (maximum 1,000), to retrieve the remaining ones.
  *)
  while (Offset <= Total) and (Offset < 1000) do
  begin
    // You must free LList when you are done using it; each API call creates a new one.
    LList := VclWindyWebcamsClient.GetWebcams(
      TWindyWebcamsQuery.Create
      // .lang('fr')
      // .Countries(['CH', 'FR'])
      // .CategoryOperation(coOr)
      //.Categories([wcBeach, wcMountain])
      // .SortBy(skPopularity, sdDescending)
      .Offset(Offset)
      .Limit(50) // maximum by call
      // We define the geographic search area
      .BBox(map.NorthEastLatitude, map.NorthEastLongitude, map.SouthWestLatitude, map.SouthWestLongitude)
      // You can also set up a search based on a specific point and a distance in kilometers.
      // .Nearby( ALatitude, ALongitude, ARadiusKm: Double)
      .Include([ipImages, ipLocation, ipCategories, ipPlayer, ipUrls]));

    if total = 0 then
      Total := LList.total;
    // Show Webcams on the Map
    try
      for i := 0 to LList.Count - 1 do
      begin
        LWebcam := LList.items[i];

        // Only active webcams are taken into account
        if LWebcam.Status <> wsActive then
        begin
          dec(total);
          continue;
        end;

        P := map.AddMArker(LWebcam.Location.Latitude, LWebcam.Location.Longitude);
        (*
          We use the icon URL.
          Note that in the free plan, image URLs are only valid for 10 minutes
          here, that's not a problem because the image is stored in memory and will remain valid.
        *)
        P.filename := LWebcam.Images.Url(WindyImageSizeToCode(isIcon));

        P.hint := LWebcam.Title;
        P['webcamid'] := inttostr(LWebcam.WebcamId);
        P['DateTime'] := DateTimeToStr(LWebCam.LastUpdatedOn);
        if LWebcam.HasLiveStream then
          P['live'] := LWebcam.Player.Live
      end;

    finally
      // Required; otherwise, memory leak
      LList.Free;
    end;
    // next range
    Offset := Offset + 50;

  end;
  map.EndUpdate;

  MLog.lines.add('New Webcams : ' + inttostr(Total) + ' - Total : ' + inttostr(map.shapes.markers.count));

end;



// Display the image of the clicked icon
// VclWindyWebcamImage has an AutoRefresh property that automatically loads the new image if it is available
procedure TForm13.mapShapeClick(sender: TObject; const item: TECShape);
begin
  FSelectedCam := Item;
  ShowInfoWebCam;
  VclWindyWebcamImage.WebcamId := StrToInt64(FSelectedCam['webcamid']);
end;

// Trigger when the VclWindyWebcamImage automatically refreshes
procedure TForm13.doWebCamRefresh(Sender: TObject);
var
  id: string;
  LWebcam: TWindyWebcam;
begin

  if not assigned(FSelectedCam) then
    exit;

  id := FSelectedCam['webcamid'];
  InfoCam.Lines.clear;
  if id = '' then
    exit;

  // This does not mean the image is new
  // you must load the data to compare the date
  LWebcam := VclWindyWebcamsClient.GetWebcam(StrToInt64(id), [ipImages, ipLocation, ipPlayer, ipUrls]);

  if assigned(LWebCam) then
  begin
    FSelectedCam['DateTime'] := DateTimeToStr(LWebCam.LastUpdatedOn);
    ShowInfoWebCam;
  end;

end;


procedure TForm13.ShowInfoWebCam;
var
  id: string;
begin
  if not assigned(FSelectedCam) then
    exit;

  id := FSelectedCam['webcamid'];

  InfoCam.Lines.clear;

  if id = '' then
    exit;

  InfoCam.Lines.add(FSelectedCam.hint);
  Infocam.lines.add('WebCamId : ' + id);
  Infocam.lines.add('update : ' + FSelectedCam['DateTime']);
  Infocam.lines.add('Live : ' + FSelectedCam['live']);

end;



end.

