unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Edit, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.Objects, FMX.uecNativeMapControl, FMX.uecMapUtil;

type

   
  TForm1 = class(TForm)
    Panel2: TPanel;
    GroupBox6: TGroupBox;
    ProgressBar: TProgressBar;
    StartStop: TButton;
    LabelDownLoad: TLabel;
    map: TECNativeMap;
    procedure doDownLoadTiles(Sender: TObject);
    procedure doEndDownLoadTiles(Sender: TObject);
    procedure doOnErrorLoadTiles(Sender: TObject; const X,Y,Z: integer; var ReloadTile: boolean);


    procedure FormCreate(Sender: TObject);

    procedure StartClick(Sender: TObject);
    procedure PauseClick(Sender: TObject);
    procedure ResumeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDownloadTiles: TECDownloadTiles;

    FFromZoom, FToZoom: Integer;
    FNorthEastLatitude, FNorthEastLongitude,
    FSouthWestLatitude, FSouthWestLongitude: double;
    FStartX,FStartY:integer;
    FStartZoom:byte;
    FStartCountTiles,
    FStartDownLoadtiles : integer;


  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}




procedure TForm1.StartClick(Sender: TObject);
begin

        // start downloading visible area

        StartStop.Text := 'Pause';
        StartStop.OnClick := PauseClick;

        // tiles are saved in DirectoryTiles
        FDownloadTiles.DirectoryTiles := map.LocalCache;
        FDownloadTiles.TileServer     := map.TileServer;
        FDownloadTiles.TileSize       := map.TileSize;

        // download visible area from zoom to MaxZoom

        FDownloadTiles.DownLoadTiles(map.Zoom , map.MaxZoom,
          map.NorthEastLatitude, map.NorthEastLongitude, map.SouthWestLatitude,
          map.SouthWestLongitude);


end;


procedure TForm1.PauseClick(Sender: TObject);
begin

  StartStop.Text    := 'Resume';
  StartStop.OnClick := ResumeClick;

  // save this properties for resume

  with FDownloadTiles do
  begin
    FFromZoom            := FromZoom;
    FToZoom              := ToZoom;
    FNorthEastLatitude   := NorthEastLatitude;
    FNorthEastLongitude  := NorthEastLongitude;
    FSouthWestLatitude   := SouthWestLatitude;
    FSouthWestLongitude  := SouthWestLongitude;
    FStartX              := StartX;
    FStartY              := StartY;
    FStartZoom           := StartZoom;
    FStartCountTiles     := StartCountTiles;
    FStartDownLoadtiles  := StartDownLoadtiles;
  end;


  FDownloadTiles.Pause := true;

end;

procedure TForm1.ResumeClick(Sender: TObject);
begin
  StartStop.Text    := 'Pause';
  StartStop.OnClick := PauseClick;

  FDownloadTiles.DownLoadTiles( FFromZoom, FToZoom,
                                  FNorthEastLatitude, FNorthEastLongitude,
                                  FSouthWestLatitude, FSouthWestLongitude,
                                  FStartX,FStartY,
                                  FStartZoom,
                                  FStartCountTiles,
                                  FStartDownLoadtiles) ;
end;


// fired after download tile
procedure TForm1.doDownLoadTiles(Sender: TObject);
begin
  ProgressBar.Max := FDownloadTiles.CountTotalTiles;
  ProgressBar.Value := FDownloadTiles.CountDownLoadTiles;

  LabelDownLoad.Text :=
    inttostr(round((FDownloadTiles.CountDownLoadTiles /
    FDownloadTiles.CountTotalTiles) * 100)) + '%   ' +
    inttostr(FDownloadTiles.CountDownLoadTiles) + ' / ' +
    inttostr(FDownloadTiles.CountTotalTiles);
end;

// fired when cancel or when all tiles are downloaded
procedure TForm1.doEndDownLoadtiles(Sender: TObject);
begin
  doDownLoadTiles(nil);

  StartStop.Text    := 'Start';
  StartStop.OnClick := PauseClick;

end;



// fired when an error occurs during download
procedure TForm1.doOnErrorLoadTiles(Sender: TObject; const X,Y,Z: integer; var ReloadTile: boolean);
begin
 ShowMessage('Error during download'+' X='+IntToStr(X)+' Y='+IntToStr(Y)+' Z='+IntToStr(Z));
end;


procedure TForm1.FormCreate(Sender: TObject);
begin

   map.LocalCache := ExtractfilePath(ParamStr(0)) + 'cache' ;

   StartStop.OnClick := StartClick;

   FDownloadTiles  := TECDownloadTiles.Create;
   // use the same directory as the local cache
   FDownloadTiles.DirectoryTiles := map.LocalCache;
   // event triggered after each tile loading
   FDownloadTiles.OnDownLoad    := doDownLoadtiles;
   // event triggered at end of loading or at cancel
   FDownloadTiles.OnEndDownLoad := doEndDownLoadtiles;
   // event triggered if error
   FDownloadTiles.OnErrorLoadTiles:= doOnErrorLoadTiles;



end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FDownloadTiles.Free;
end;

end.
