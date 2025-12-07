unit UGTFSReader;

(*
  Demo of how to use GTFS Shedule and GTFS RealTime with TECNativeMap
  © ESCOT-SEP Christophe Décembre 2025

 see GTFS Technical Documentation : https://gtfs.org/documentation/overview/

 You can find GTFS feeds at https://mobilitydatabase.org/

*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.IOUtils, Vcl.Graphics,
  System.TypInfo, System.Diagnostics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  uecNativeGTFS, transit_realtime, uecNativeMapControl, uecnativeshape,
  uecmaputil, Vcl.CheckLst,
  Vcl.ComCtrls;

type

  TFormGTFS = class(TForm)
    pnPageControlGTFS: TPanel;
    Log: TMemo;

    map: TECNativeMap;
    Label2: TLabel;
    lbHoraire: TListBox;
    lbLines: TLabel;
    ckLines: TCheckListBox;
    cbLines: TComboBox;
    cbTrips: TComboBox;
    lbStops: TListBox;
    pnBottom: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbNbrStops: TLabel;
    PageControlGTFS: TPageControl;
    TabStations: TTabSheet;
    TabVehicles: TTabSheet;
    cbVehicles: TComboBox;
    vehicleShedule: TListBox;
    PageControlLogs: TPageControl;
    TabLog: TTabSheet;
    TabAlert: TTabSheet;
    Alert: TMemo;
    TabLines: TTabSheet;
    ckUnCheckAllLines: TButton;
    ckCheckAllLines: TButton;
    Splitter1: TSplitter;
    lbVehicleRoute: TLabel;
    cbGTFSDirectory: TComboBox;
    lbAllStops: TListBox;
    SearchStops: TEdit;

    procedure cbGTFSDirectoryChange(Sender: TObject);
    procedure cbLinesChange(Sender: TObject);

    procedure cbStationsChange(Sender: TObject);
    procedure cbTripsChange(Sender: TObject);
    procedure cbVehiclesChange(Sender: TObject);
    procedure ckCheckAllLinesClick(Sender: TObject);
    procedure ckLinesClick(Sender: TObject);
    procedure ckLinesClickCheck(Sender: TObject);
    procedure ckUnCheckAllLinesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbAllStopsClick(Sender: TObject);
    procedure lbAllStopsData(Control: TWinControl; Index: Integer; var Data:
      string);
    procedure lbHoraireClick(Sender: TObject);
    procedure lbStopsClick(Sender: TObject);
    procedure mapMapClick(Sender: TObject; const Lat, Lng: Double);
    procedure PageControlGTFSChange(Sender: TObject);
    procedure SearchStopsEnter(Sender: TObject);
    procedure SearchStopsKeyUp(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure vehicleSheduleClick(Sender: TObject);

  private
    { Déclarations privées }

    Stopwatch: TStopwatch;

    AR_Trips_HeadSign_Id: TAR_Trips_HeadSign_Id;
    AR_Stops_Name_Id: TAR_Stops_Name_Id;

    FGTFS: TGTFS;

    procedure ZoomToShedule(const SheduleLine: string);

    procedure SelectRoute(const Route_long_Name: string);

    procedure doRouteShapeClick(sender: TObject; const item: TECShape);

    procedure doStopShapeClick(sender: TObject; const item: TECShape);

    procedure doVehicleShapeClick(sender: TObject; const item: TECShape);

    procedure showShedule(const AShedules: TAR_Shedules);

    procedure ShowTrip(const Trip_id: string; const stop_sequence: integer =
      -1);

    procedure Show_Stop_time(const Route_Name: string; const AList:
      TAR_Stop_times);

    procedure OnRealTimepUpdate(Sender: TObject);

    procedure doOnLoadGTFS(Sender: TObject);
    procedure doOnLoadShapesLayer(Sender: TObject);
    procedure doOnLoadStopsLayer(Sender: TObject);

  public
    { Déclarations publiques }
  end;

var
  FormGTFS: TFormGTFS;

implementation

{$R *.dfm}

const

  TAB_STOPS = 0;
  TAB_LINES = 1;
  TAB_VEHICLES = 2;

procedure TFormGTFS.FormCreate(Sender: TObject);
begin

  // For simplicity's sake in this demo,
  // we consider the subdirectories of the directory where the demo is located
  // to be unzipped GTFS Schedule files.

  cbGTFSDirectory.items.AddStrings(TDirectory.GetDirectories(ExtractFileDir(application.ExeName)));

  if cbGTFSDirectory.items.count = 0 then
    ShowMessage('Unzip the GTFS Schedule archives and place them in subdirectories at the level of this demo''s executable file.');

  FGTFS := TGTFS.Create;
  // event triggered after GTFS files are loaded
  FGTFS.OnLoad := doOnLoadGTFS;
  // event triggered after loading the routes in the map
  FGTFS.OnShapesLoad := doOnLoadShapesLayer;
  // event triggered after loading the stops in the map
  FGTFS.OnStopsLoad := doOnLoadStopsLayer;

  // event triggered after click on route
  FGTFS.OnShapesClick := doRouteShapeClick;
  // event triggered after click on stop
  FGTFS.OnStopsClick := doStopShapeClick;
  // event triggered after click on vehicle
  FGTFS.OnVehicleClick := doVehicleShapeClick;

  // styles

  // all routes
  map.styles.addRule('#GTFS_SHAPES {weight:5;bcolor:white;bsize:2;scale:1;} ');
  // route selected
  map.styles.addRule('#GTFS_SHAPES:selected {scale:1.5;hbcolor:black;} ');

 // map.styles.addRule('.marker {color:green;scale:1;} ');
  map.styles.addRule('.marker:focused {scale:1.3;} ');

  // stops
  map.styles.addRule('#GTFS_STOPS {StyleIcon:square;color:#01A7C2;width:12;scale:1} ');
  map.styles.addRule('#GTFS_STOPS:focused {scale:1.5;} ');
  map.styles.addRule('.stop_name:* {if:wheelchair_boarding=1;color:#cbef43;scale:1.1;} ');
  map.styles.addRule('.stop_name:* {if:wheelchair_boarding=2;color:#A3BAC3;scale:1.1} ');


  // real time vehicle
  // By default, the marker points in the direction of movement.
  map.styles.addRule('.statut:IN_TRANSIT_TO {StyleIcon:direction;width:15;} ');
  // Certain feeds do not indicate the direction of the vehicle;
  // for these, a simple circle is displayed.
  map.styles.addRule('.marker.bearing:? {styleicon:flat;} ');
  // When the vehicle is stopped at a stop, the marker is displayed in the shape of a square.
  map.styles.addRule('.statut:STOPPED_AT {styleicon:square;width:15;} ');



  // if ShowVehiculeDelay = true
  // then the delay property of vehicles contains the advance (negative) or delay in minutes.
  // If there are thousands vehicles and numerous schedule updates, this can be time-consuming.
  FGTFS.ShowVehiculeDelay := true;
  // Again, if there are thousands of vehicles, this can cause a slowdown.
  FGTFS.ShowVehiculeStopName := true;

  map.styles.addRule('#GTFS_RT {if:delay<1;color:#8de969;scale:1;}');
  // delay >= 1 minutes
  map.styles.addRule('#GTFS_RT {if:delay>1;color:#FF9000;scale:1.2;} ');
   // delay >= 5 minutes
  map.styles.addRule('#GTFS_RT {if:delay>5;color:#8C001A;scale:1.3;} ');
    // delay >= 8 minutes
  map.styles.addRule('#GTFS_RT {if:delay>8;color:#5F021F;scale:1.3;} ');
  // delay >= 12 minutes
  map.styles.addRule('#GTFS_RT {if:delay>=12;color:black;scale:1.5;} ');

end;

procedure TFormGTFS.FormDestroy(Sender: TObject);
begin
  FGTFS.free;
end;

// Select a directory containing the unzipped GTFS files.
procedure TFormGTFS.cbGTFSDirectoryChange(Sender: TObject);
var
  i: integer;
begin

  FGTFS.Close;

  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TComboBox) and
       (Components[i] <> cbGTFSDirectory)  then
    begin
      TComboBox(Components[i]).Items.clear;
      TComboBox(Components[i]).text := '';
    end
    else if (Components[i] is TListBox) then
      TListBox(Components[i]).Items.clear;

  if FGTFS.isFirstOpening(cbGTFSDirectory.text) then
    Log.lines.text :=
      'Loading and indexing may take several seconds depending on the size of the files.' + #13#10
      + 'Future loads will be faster.'
  else
    Log.lines.text := 'Loading...';

  Stopwatch.Reset;
  Stopwatch.Start;

  // GTFS will be opened in a secondary thread,
  // doOnLoadGTFS will be called when the data is available

  // The first time you open the file, it will index the files
  // and may take several seconds depending on the size of the CSV files.

  // Subsequent openings will be much faster.

  // To reduce memory consumption,
  // CSV files are not loaded entirely into memory;
  // only the requested lines are loaded.
  FGTFS.OpenDirectory(cbGTFSDirectory.text, doOnLoadGTFS);

end;

// Response to GTFS file loading
procedure TFormGTFS.doOnLoadGTFS(Sender: TObject);
var
  directory: string;
begin

  Log.lines.Add(Format('Loaded in %d ms', [Stopwatch.ElapsedMilliseconds]));

  caption := 'GTFS from ' + FGTFS.Feed_Info.Publisher_name + ', valid from ' +
    DateToStr(FGTFS.Feed_Info.Start_date) + ' to ' +
    DateToStr(FGTFS.Feed_Info.End_date) + ' ' + FGTFS.Agency.TimeZone;

  // Name of all stops according to the information in the stops.txt file
  // To speed up display, we use a TListBox in virtual mode.
  // Here, we only enter the actual number of items,
  // which will be displayed on demand in procedure TFormGTFS.lbAllStopsData
  lbAllStops.count := FGTFS.Stops.count;

  lbNbrStops.Caption := Format('Number of stops %d', [FGTFS.Stops.count]);
  Log.lines.Add(Format('total number of stops : %d', [FGTFS.Stops.count]));

  // Load the route layer in the background with the contents of the shapes.txt file.
  FGTFS.MapShapes := Map['GTFS_SHAPES'];

  // Load the stops layer in the background with the contents of the stops.txt file.
  FGTFS.MapStops := Map['GTFS_STOPS'];
  FGTFS.MapStops.Hint := '[stop_name] [wheelchair]';
  FGTFS.MapStops.MinZoom := 14;

  // display vehicles in pseudo real time if available.
  FGTFS.MapRealTime := Map['GTFS_RT'];

  // information displayed in the vehicle hint
  // date and time of information transmission
  // vehicle name
  // status (moving toward/stopped), station name
  // speed
  // delay/advance
  FGTFS.MapRealTime.hint := '[timestamp]' + #13#10 +
      '[caption]' + #13#10 +
      '[statut]'+' [stop_name]' + #13#10 +
      '[speed]' + #13#10 +
      '[delay]';

  // format of the text contained in the [delay] property
  FGTFS.HintDelay := '%d minute(s) delay';

  // By default, speed is displayed in km/h.

  // FGTFS.VehiculeSpeedMph := true;

  // event triggered after loading real-time data
  FGTFS.OnRealTimeUpdate := OnRealTimepUpdate;

  directory := LowerCase(cbGTFSDirectory.text);

  FGTFS.UrlMultiFeed := '';
  FGTFS.UrlTripUpdateFeed := '';
  FGTFS.UrlVehiclePositionFeed := '';
  FGTFS.UrlAlertFeed := '';

  // Here you combine real-time feeds with your static files.
  if pos('fileX', directory) > 0 then
    // if it is a feed that combines Alert, TripUpdate, and VehiclePosition
    FGTFS.UrlMultiFeed :=  'https://...'
  else if pos('FileY', directory) > 0 then
  begin
    FGTFS.UrlAlertFeed :=   'https://...';
    FGTFS.UrlVehiclePositionFeed := 'https://...';
    FGTFS.UrlTripUpdateFeed := 'https://...';
	// if necessary, enter your API keys
	FGTFS.setApiKeyTripUpdateFeed('Key','value');
    FGTFS.setApiKeyVehiclePositionFeed('Key','value');

  end;

end;

// Fill in the virtual list with the name of the stop corresponding to the index.
procedure TFormGTFS.lbAllStopsData(Control: TWinControl; Index: Integer; var
  Data: string);
begin
  Data := FGTFS.Stops.Data[Index].Name;
end;

// emulate basic autocompletion on station names
procedure TFormGTFS.SearchStopsKeyUp(Sender: TObject; var Key: Word; Shift:
  TShiftState);
var
  i, j: integer;
begin

  if Key = 13 then
  begin
    if SearchStops.Tag <> -1 then
    begin
      lbAllStops.SetFocus;
      lbAllStops.ItemIndex := SearchStops.Tag;
      lbAllStopsClick(lbAllStops);
    end;
  end
  else
  begin
    SearchStops.Tag := -1;

    for i := 0 to FGTFS.Stops.count - 1 do
      if pos(copy(SearchStops.text, 1, SearchStops.SelStart),
        lowercase(FGTFS.Stops.Data[i].name)) = 1 then
      begin
        j := SearchStops.SelStart;
        SearchStops.Text := FGTFS.Stops.Data[i].name;
        SearchStops.SelStart := j;
        SearchStops.Tag := i;
        break;
      end;

  end;
end;

procedure TFormGTFS.SearchStopsEnter(Sender: TObject);
begin
  SearchStops.text := '';
end;

// zoom in on the selected station and search for all routes that pass through it
procedure TFormGTFS.lbAllStopsClick(Sender: TObject);
var

  data: TGTFS_Stop_Data;
  route: TAR_Routes_Name_Id;

begin

  if lbAllStops.ItemIndex < 0 then
    exit;

  // Get the main information about this station based on its name
  Data := FGTFS.Stops[lbAllStops.ItemIndex];

  if Data.name <> '' then
  begin

    // zoom in on
    FGTFS.Stops_Layer.setFocus(Data.Id);

    Stopwatch.Reset;
    Stopwatch.Start;

    // Find the routes that pass through this stop
    route := FGTFS.GetRoutesFromStopId(Data.Id);

    Log.lines.add(format('%d routes pass through this stop, found in %d ms', [1
        + high(route.Name), Stopwatch.ElapsedMilliseconds]));

    cbLines.items.clear;
    cbLines.items.addStrings(route.Name);

  end;
end;

// event triggered after loading the routes in the map
procedure TFormGTFS.doOnLoadShapesLayer(Sender: TObject);
var
  i: integer;
begin

  // zoom in to display all routes
  FGTFS.MapShapes.fitBounds;

  ckLines.Items.BeginUpdate;
  ckLines.Items.clear;

  // Browse the routes.txt file to extract the full names of the routes.
  for i := 0 to FGTFS.Routes.RowCount - 1 do
  begin
    ckLines.items.add(FGTFS.Routes.Row[i].route_long_name);
    ckLines.Checked[i] := true;
  end;

  ckLines.Items.EndUpdate;

  lbLines.Caption := format('%d line(s)', [FGTFS.Routes.RowCount]);

  if not assigned(FGTFS.MapRealTime) then
    exit;

  FGTFS.MapRealTime.markers.labels.LabelType := ltProperty;
  FGTFS.MapRealTime.markers.labels.LabelProperty := 'caption';
  FGTFS.MapRealTime.markers.labels.ShowOnlyIf := lsoFocused;
  FGTFS.MapRealTime.markers.labels.style := lsTransparent;
  FGTFS.MapRealTime.markers.labels.align := laTop;
  FGTFS.MapRealTime.markers.labels.FontBold := true;
  FGTFS.MapRealTime.markers.labels.ShadowText := true;
  FGTFS.MapRealTime.markers.labels.ColorType := lcColor;
  FGTFS.MapRealTime.markers.labels.FontColor := clBlack;
  FGTFS.MapRealTime.markers.labels.ShadowColor := clWhite;
  FGTFS.MapRealTime.markers.labels.Pading := -2;
  FGTFS.MapRealTime.markers.labels.visible := true;

end;

// event triggered after loading the stops in the map
procedure TFormGTFS.doOnLoadStopsLayer(Sender: TObject);
begin
  //
end;

// event triggered after loading real-time data
// The time between two triggers is calculated based on the update information
// from the GTFS Realtime feed.
procedure TFormGTFS.OnRealTimepUpdate(Sender: TObject);
var
  i: integer;
  v: string;
  vehicle: TVehicleDescriptor;
begin

  if Log.lines.count>100 then
   Log.Lines.clear;

  Log.lines.add('RealTime update : ' + TimeToStr(now) + ' vehicles : ' +
    inttostr(FGTFS.Vehicles.count) + ' - tripupdate : ' +
    inttostr(FGTFS.TripUpdates.count) + ' - alert : ' +
    inttostr(FGTFS.Alerts.count));

  // vehicles
  cbVehicles.items.BeginUpdate;
  cbVehicles.items.clear;
  // keep the previously selected vehicle
  v := cbVehicles.text;
  Vehicleshedule.items.clear;
  for i := 0 to FGTFS.Vehicles.count - 1 do
  begin
    vehicle := FGTFS.Vehicles[i].vehicle;
    // Normally, Caption contains the display name of the vehicle, but sometimes it is not specified,
    // so we fall back on other possibilities that are not optimal in terms of display.
    if vehicle.caption <> '' then
      cbVehicles.items.add(vehicle.caption)
    else if vehicle.license_plate <> '' then
      cbVehicles.items.add(vehicle.license_plate)
    else
      cbVehicles.items.add(vehicle.id);
  end;
  cbVehicles.items.EndUpdate;

  // reselect our vehicle if it still exists
  cbVehicles.itemindex := cbVehicles.Items.indexof(v);
  if PageControlGTFS.TabIndex = TAB_VEHICLES then
    cbVehiclesChange(cbVehicles);

  // show alerts
  Alert.lines.clear;
  for i := 0 to FGTFS.Alerts.count - 1 do
   if FGTFS.Alerts[i].description_text.translationList.count > 0 then
    Alert.lines.addStrings(Remplace_Str(FGTFS.Alerts[i].description_text.translationList[0].text,#10,#13#10));

end;

// Response to clicking on a route from the map
procedure TFormGTFS.doRouteShapeClick(sender: TObject; const item: TECShape);
begin
  //  emulate a click in the route checkbox list; the route name is stored in its Hint property
  ckLines.ItemIndex := ckLines.items.indexof(item.hint);
  ckLines.OnClick(ckLines);

end;

// Response to a click in the route checkbox list
// Highlights the route on the map and zooms in on it
procedure TFormGTFS.ckLinesClick(Sender: TObject);
var
  route_long_name, route_short_name: string;
begin
  // Select / Unselect the TECShapeLine based on the content of its route_short_name property
  // This works because we are sure that the routes.txt file contains a single route per line,
  // ckLines contains all routes in the same order as the routes.txt file,
  // each route has a unique route_short_name
  // A route can be divided into several TECShapeLines, so you must select them all.

  route_short_name := fGTFS.Routes.row[ckLines.ItemIndex].route_short_name;

  // deselect the route if it is selected
  if (map.selected.count > 0) and (map.Selected[0]['route_short_name'] =
    route_short_name) then

    FGTFS.Shapes_Layer.Selected('route_short_name', route_short_name, false)

  else
  begin
    // select all rows that have a ‘route_short_name’ property = route_short_name
    FGTFS.Shapes_Layer.Selected('route_short_name', route_short_name);

    // select our route in the ‘Stations’ tab
    route_long_name := fGTFS.Routes.row[ckLines.ItemIndex].route_long_name;

    cbLines.items.clear;
    cbLines.items.add(route_long_name);
    cbLines.ItemIndex := 0;

    SelectRoute(route_long_name);
  end;

end;

// Select a route by its full name
// All trips and stops on this route are displayed.
procedure TFormGTFS.SelectRoute(const Route_long_Name: string);

begin

  lbStops.items.clear;
  lbHoraire.items.clear;
  cbTrips.Items.clear;

  if FGTFS.Routes.select('route_long_name', Route_long_Name) > 0 then
  begin

    Stopwatch.Reset;
    Stopwatch.Start;

    // find All stops for this route_id

    AR_Stops_Name_Id :=
      FGTFS.getStopsFromRouteId(FGTFS.Routes.SelectRows[0].route_id, true);

    Log.lines.add(Format('"%s" has %d stops, found in %d ms',
      [FGTFS.Routes.SelectRows[0].route_long_name, 1 +
        high(AR_Stops_Name_Id.Name), Stopwatch.ElapsedMilliseconds]));

    // Select all the elements that make up the route on the map and zoom in on them.
    FGTFS.Shapes_Layer.Selected('route_short_name',
      FGTFS.Routes.SelectRows[0].route_short_name);
    map.Selected.fitBounds;

    Stopwatch.Reset;
    Stopwatch.Start;

    // Find all trips on this route
    // use trips.txt
    AR_Trips_HeadSign_Id :=
      FGTFS.getTripsFromRouteId(FGTFS.Routes.SelectRows[0].route_id);

    Log.lines.add(Format('%d trips, found in %d ms', [1 +
        high(AR_Trips_HeadSign_Id.HeadSign), Stopwatch.ElapsedMilliseconds]));

    // Fill in the trip and stop comboboxes

    cbTrips.items.AddStrings(AR_Trips_HeadSign_Id.HeadSign);
    lbStops.items.AddStrings(AR_Stops_Name_Id.Name);
  end;

end;

// Response to a click in the shedule list
// Find the corresponding stop and zoom in on it
procedure TFormGTFS.lbHoraireClick(Sender: TObject);
begin
  if lbHoraire.ItemIndex < 0 then
    exit;

  ZoomToShedule(lbHoraire.Items[lbHoraire.ItemIndex]);

end;

procedure TFormGTFS.ZoomToShedule(const SheduleLine: string);
var
  s: string;
  AStop: TGTFS_Stop_Data;
begin

  s := SheduleLine;

  // verify that you are on a line containing a schedule
  if (length(s) > 0) and CharInSet(s[1], ['1', '2', '3', '4', '5', '6', '7',
      '8',
      '9',
      '0']) then
  begin
    // extract the name
    StrToken(s, #9);

    // Get the TGTFS_Stop_Data based on the station name
    AStop := FGTFS.Stops[StrToken(s, #9)];

    if AStop.Name <> '' then
    begin
      // zoom in on it
      FGTFS.Stops_Layer.setFocus(AStop.id);
    end;
  end;

end;

// Response to a click in the station list
// Find the corresponding stop and zoom in on it
procedure TFormGTFS.lbStopsClick(Sender: TObject);
var
  AStop: TGTFS_CSVRow;
begin
  // use stops.txt
  AStop := FGTFS.Stops.Stop_id(AR_Stops_Name_Id.Id[lbStops.ItemIndex]);

  if assigned(AStop) then
    FGTFS.Stops_Layer.setFocus(AStop.stop_id);

end;

// Response to a click on a station in the layer FGTFS.MapStops
// we search for and display the schedule of upcoming departures
procedure TFormGTFS.doStopShapeClick(sender: TObject; const item: TECShape);
var
  TAR: TAR_Shedules;
begin
  // You need to convert your local time to the local time of the GTFS data.
  // To do this, use FGTFS.Agency.TimeZone.
  TAR := FGTFS.getShedule(item.latitude, item.longitude, now);
  showShedule(tar);
end;

// Response to a click on a vehicle in the layer FGTFS.Maps
// show next station
//
// Technical reference : https://gtfs.org/documentation/realtime/reference/#message-vehicleposition
//
procedure TFormGTFS.doVehicleShapeClick(sender: TObject; const item: TECShape);
var
  Row: TGTFS_CSVRow;
  vehicle: TVehiclePosition;
  Stop_times: TR_Stop_times;
  stop_id, stop_name, info: string;
begin

  // tagObject contains all vehicle data obtained from the real-time feed.
  vehicle := TVehiclePosition(item.TagObject);

  if not assigned(vehicle) then
    exit;

  stop_name := '';

  // Since feed properties are often optional, we test for their presence to ensure their validity.
  if vehicle.FieldHasValue[vehicle.tag_stop_id] then
    stop_id := vehicle.stop_id
  else
    stop_id := '';

  // get an estimate of the next departure, taking TripUpdate into account
  // Since Trip is optional, we test whether it is present in the feed.
  // The trip must also be entered in the stop_times.txt file.
  if (vehicle.FieldHasValue[vehicle.tag_trip]) and
    (vehicle.trip.FieldHasValue[vehicle.trip.tag_trip_id]) then
  begin

    if stop_id <> '' then
      Stop_times := FGTFS.getTripUpdateFromTripAtStopId(vehicle.trip.trip_id,
        stop_id)
    else if vehicle.FieldHasValue[vehicle.tag_current_stop_sequence] then
      Stop_times :=
        FGTFS.getTripUpdateFromTripAtStopSequence(vehicle.trip.trip_id,
        vehicle.current_stop_sequence);

    stop_name := Stop_times.Name;

  end
  else if stop_id <> '' then
  begin
    // The stop_id property contains the station id to which the vehicle is heading.
    // See stops.txt for information about this stop.
    Row := FGTFS.Stops.Stop_id(stop_id);
    if assigned(row) then
      stop_name := row.stop_name;
  end;

  if vehicle.FieldHasValue[vehicle.tag_current_status] then
  begin

    // item['caption'] = vehicle.vehicle.caption or vehicle.vehicle.licence_plate or vehicle.vehicle.id
    info := item['caption'];

    if vehicle.current_status <> TVehicleStopStatus.STOPPED_AT then
      info := info + ' on way to '
    else
      info := info + ' stopped at the station ';

    if stop_name <> '' then
    begin
      info := info + stop_name;

      if Stop_times.Name = stop_name then
        info := info + ' next departure at ' + Stop_times.Departure_time;
    end;

    Log.lines.add(info);
  end;

  cbVehicles.ItemIndex := cbVehicles.items.indexof(item['caption']);

end;

procedure TFormGTFS.PageControlGTFSChange(Sender: TObject);
begin

  if PageControlGTFS.TabIndex = TAB_VEHICLES then
    cbVehiclesChange(cbVehicles);

end;

// Select a vehicle from the list
procedure TFormGTFS.cbVehiclesChange(Sender: TObject);
var
  stop_times: TAR_Stop_times;
  vehicle: TVehiclePosition;
  WheelChair, delay, VPos: string;
  i, NextStation: integer;
  TAR: TAR_Shedules;
  Row: TGTFS_CSVRow;
  stop_id,
    stop_name: string;

begin

  if (cbVehicles.ItemIndex < 0) or (cbVehicles.ItemIndex >= FGTFS.Vehicles.count)
    then
    exit;

  NextStation := -1;

  // find the marker corresponding to the vehicle
  // the ‘caption’ property contains the name ( Caption or license_plate or Id )
  i := FGTFS.MapRealTime.Markers.IndexOf('caption', cbVehicles.Text);
  if i > -1 then
  begin
    FGTFS.MapRealTime.Markers[i].setFocus;
  end;

  // retrieve the TVehiclePosition from the real-time feed
  vehicle := FGTFS.Vehicles[cbVehicles.ItemIndex];

  map.setcenter(vehicle.position.latitude, vehicle.position.longitude);
  map.zoom := 17;

  // Find the trip based on the vehicle's tip_id
  // if the TripUpdate real-time feed is available,
  // schedule updates will be performed if possible
  // use stoptimes.txt
  stop_times := FGTFS.getStopTimesFromTrip(vehicle.trip.trip_id);

  // Since feed properties are often optional, we test for their presence to ensure their validity.
  if vehicle.FieldHasValue[vehicle.tag_stop_id] then
    stop_id := vehicle.stop_id
  else
    stop_id := '';

  // find the name of the stop you are heading to or the one where you are stopped
  Row := FGTFS.Stops.Stop_id(stop_id);
  if assigned(Row) then
    stop_name := row.stop_name
  else
    stop_name := '';

  // If the trip_id is not in stoptimes.txt,
  // then we will try to find it based on the vehicle's position and the current date and time.
  if high(stop_times) = -1 then
  begin

    // You need to convert your local time to the local time of the GTFS data.
    // To do this, use FGTFS.Agency.TimeZone.

    // Here we obtain the static calendar without real-time data.

    TAR := FGTFS.getShedule(vehicle.position.latitude,
      vehicle.position.longitude, now);

    if high(TAR) > 0 then
    begin
      stop_times := TAR[0].Stop_times;
    end;

  end;

  // Find the name of the line on which the vehicle runs
  if FGTFS.Routes.Select(vehicle.trip.route_id) > 0 then
    lbVehicleRoute.Caption := FGTFS.Routes.SelectRows[0].route_long_name
  else
    lbVehicleRoute.Caption := '';

  Vehicleshedule.items.BeginUpdate;
  Vehicleshedule.items.Clear;

  Vehicleshedule.ItemIndex := -1;

  for i := 0 to high(stop_times) do
  begin

    // add the wheelchair icon or not
    if (stop_times[i].wheelchair_boarding = 1) then
      WheelChair := char($267F)
    else
      WheelChair := '';

    // determined whether we are at this stop based on stop_sequence or stop_name
    if (stop_times[i].stop_sequence = vehicle.current_stop_sequence)
      or (stop_times[i].Name = stop_name) then
    begin

      // act according to whether the vehicle is stopped or traveling toward the next stop
      if vehicle.FieldHasValue[vehicle.tag_current_status] then
      begin

        if vehicle.current_status = TVehicleStopStatus.STOPPED_AT then
        begin
          VPos := char($2611) + ' ';
          Log.lines.add(cbVehicles.Text + ' stopped at the station : ' +
            stop_times[i].Name);
        end
        else
        begin
          VPos := char($2186) + ' ';
          Log.lines.add(cbVehicles.Text + ' on way to : ' + stop_times[i].Name);
        end;

      end;

      NextStation := i;

    end
    else
      VPos := '';

    // if the TripUpdate real-time feed is available, display a delay or advance
    if stop_times[i].Departure_delay <> 0 then
      delay := char($26A0) + inttostr(stop_times[i].Departure_delay) + ' mn';

    Vehicleshedule.items.Add(stop_times[i].Departure_time + #9 +
      stop_times[i].Name + #9 +
      VPos + WheelChair + delay);

  end;

  Vehicleshedule.items.EndUpdate;

  Vehicleshedule.TopIndex := NextStation;

end;


// Select a station
procedure TFormGTFS.cbStationsChange(Sender: TObject);
begin
end;

// select a route
procedure TFormGTFS.cbLinesChange(Sender: TObject);
begin
  SelectRoute(cbLines.Text);
end;


// select a trip
procedure TFormGTFS.cbTripsChange(Sender: TObject);
begin
  ShowTrip(AR_Trips_HeadSign_Id.Id[cbTrips.itemindex]);
end;

// check/uncheck a route to display or hide it on the map
procedure TFormGTFS.ckLinesClickCheck(Sender: TObject);
begin
  if ckLines.ItemIndex < 0 then
    exit;

  FGTFS.Shapes_Layer.setVisible('route_long_name',
    ckLines.items[ckLines.ItemIndex],
    ckLines.Checked[ckLines.ItemIndex]);

end;

// check all lines
procedure TFormGTFS.ckCheckAllLinesClick(Sender: TObject);
var
  i: integer;
begin
  ckLines.CheckAll(cbChecked, false, true);

  for i := 0 to ckLines.items.count - 1 do
    FGTFS.Shapes_Layer.setVisible('route_long_name', ckLines.items[i], true);

end;

// uncheck all lines
procedure TFormGTFS.ckUnCheckAllLinesClick(Sender: TObject);
var
  i: integer;
begin
  ckLines.CheckAll(cbUnchecked, true, false);
  for i := 0 to ckLines.items.count - 1 do
    FGTFS.Shapes_Layer.setVisible('route_long_name', ckLines.items[i], false);
end;

// Find the station closest to the point clicked on the map
// Display the schedule for upcoming departures.
procedure TFormGTFS.mapMapClick(Sender: TObject; const Lat, Lng: Double);
var
  Row: TGTFS_CSVRow;
  TAR: TAR_Shedules;
begin

  map.Selected.UnSelectedAll;

  Stopwatch.Reset;
  Stopwatch.Start;

  // find station
  Row := FGTFS.Stops.getStopClosest(Lat, Lng);

  if assigned(row) then
  begin

    Log.lines.add(format('Nearest station : %s , found in %d ms',
      [row.stop_name, stopWatch.ElapsedMilliseconds]));
    FGTFS.Stops_Layer.setFocus(Row.stop_id);

  end
  else
  begin
    Log.lines.add('error');
    exit;
  end;

  Stopwatch.Reset;
  Stopwatch.Start;

  // find the schedule for upcoming departures

  // You need to convert your local time to the local time of the GTFS data.
  // To do this, use FGTFS.Agency.TimeZone.
  TAR := FGTFS.getShedule(Row.stop_id, now);
  // getShedule(lat,lng, now) is also available, it calls getStopClosest internally.

  Log.lines.add(format('%d schedule(s) found in %d ms', [1 + high(TAR),
      stopWatch.ElapsedMilliseconds]));

  // display schedules
  showShedule(tar);

end;

// show shedule
procedure TFormGTFS.showShedule(const AShedules: TAR_Shedules);
var
  i: integer;
  AList: TAR_Stop_times;
begin

  lbHoraire.Items.BeginUpdate;

  lbHoraire.Items.clear;

  for I := 0 to High(AShedules) do
  begin

    AList := AShedules[i].Stop_times;

    if high(AList) = -1 then
      continue;

    Show_Stop_time(AShedules[i].Route_Name, AList);

  end;

  lbHoraire.Items.EndUpdate;

end;

// show a trip
procedure TFormGTFS.ShowTrip(const Trip_id: string; const stop_sequence: integer
  =
  -1);
var
  route_name: string;
begin

  lbHoraire.Items.clear;

  // Select the trip based on its trip_id in the trips.txt file.
  if FGTFS.Trips.Select(Trip_id) > 0 then
  begin
    // Select the route in the routes.txt file based on the route_id associated with the trip_id.
    if FGTFS.Routes.Select(FGTFS.Trips.SelectRows[0].route_id) > 0 then
      route_name := FGTFS.Routes.SelectRows[0].route_long_name
    else
      route_name := '';

    // Extract the Stoptimes from the stoptimes.txt file based on the trip_id, and display them.
    Show_Stop_time(route_name, FGTFS.getStopTimesFromTrip(Trip_id,
      stop_sequence));

  end;

end;

// show shedules in listbox
procedure TFormGTFS.Show_Stop_time(const Route_Name: string; const AList:
  TAR_Stop_times);
var
  j: integer;
  WheelChair: string;
begin

  lbHoraire.Items.Add(Route_Name);
  LbHoraire.Items.Add('');

  for j := 0 to high(AList) do
  begin

    // add the wheelchair icon or not
    if (AList[j].wheelchair_boarding = 1) then
      WheelChair := char($267F)
    else
      WheelChair := '';

    lbHoraire.Items.Add(AList[j].Departure_time + #9 + AList[j].Name +
      WheelChair);
  end;

  lbHoraire.Items.Add('');

end;

procedure TFormGTFS.vehicleSheduleClick(Sender: TObject);
begin
  if vehicleShedule.ItemIndex < 0 then
    exit;

  ZoomToShedule(vehicleShedule.Items[vehicleShedule.ItemIndex]);
end;

end.

