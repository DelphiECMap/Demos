unit UMarkerClick;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, Vcl.StdCtrls,
  // this is the unit that references all elements (markers, pois, lines, polygons, etc.)
  uecNativeShape,uecmaputil, Vcl.Imaging.pngimage, Vcl.ExtCtrls,uecGraphics,
  System.ImageList, Vcl.ImgList,TileCacheSQLite.FireDac,uecSwitchServerComponent;

type
  TFormMarkers = class(TForm)
    Memo1: TMemo;
    map: TECNativeMap;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    procedure mapMapClick(sender: TObject; const Lat, Lng: Double);
    procedure mapShapeClick(sender: TObject; const item: TECShape);
     procedure mapShapeDrag(sender: TObject; const item: TECShape;
      var cancel: Boolean);
    procedure mapShapeDragEnd(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure mapMapRightClick(Sender: TObject; const Lat, Lng: Double);
    procedure FormDestroy(Sender: TObject);



  private
    { Déclarations privées }
   procedure doSpecificClick(sender: TObject; const item: TECShape);

   procedure doOwnerDraw(const canvas: TECCanvas; var rect: TRect; item: TECShape) ;
   procedure doCircleMarker(const canvas: TECCanvas; var rect: TRect; item: TECShape) ;
   procedure doOverIntention(Sender: TObject);
   procedure doMouseOut(sender: TObject; const item: TECShape);
   procedure doRemoveMarker(sender: TObject; const item: TECShape);
   procedure doEndAnimationMove(Sender: TObject);


  public
    { Déclarations publiques }

  end;

var
  FormMarkers: TFormMarkers;


implementation

{$R *.dfm}


const

  // Google Encoded Polyline Algorithm Format
  // see https://developers.google.com/maps/documentation/utilities/polylinealgorithm

  ENCODED_PATH_ROUTE = 'ocvmqAoexCC@bDAz@R~RRvLf@R?z@R|@h@AAf@oARgEvBsl@nA_b' +
    '@~C_{@z@_DbBoPbBs]f@{JjH{r@f@kC~Cg^rD_]z@gO?sDSgE{@k' +
    'Hg@kCkCsSg@eC?EoK_q@{@_ISwBoUscBcBgJSoAgYwpBwG{c@cB_' +
    'IwB{OUgC@Cf@SRg@nAkCz@{@bG_DfOwGf@g@f@g@z@oABECyCoAo' +
    'FQw@ACoAg@{JwBsD?oF?mMbB@?_Ikk@QgBAOsDf@{OgEgY_IkCg@' +
    'oP{E_jAc[wQ{EcGcBsIwBsNsDgJkCwVsIsBk@CB?wB{@wBcB{@ch' +
    'AwkB_D{EsjA{dBqAsB@Ccj@rDwLf@{^vB_Nz@gOnAkHf@sb@nAsD?kCRkC?eLC??@B';



procedure TFormMarkers.FormCreate(Sender: TObject);
var mrk:TECShapeMarker;
    road  : TECShapeLine;
    moving: TECAnimationMoveOnPath;
begin



  // ImageList for markers
  map.icons := imagelist1;



  map.onMapClick := mapMapClick;


  // global element events, triggered if the element has no specific events
  map.OnShapeClick      := mapShapeClick;
  map.OnShapeDrag       := mapShapeDrag;
  map.OnshapeDragEnd    := mapShapeDragEnd;
  map.OnShapeRightClick := doRemoveMarker;
  map.OnShapeOverIntent := doOverIntention;
  map.OnShapeMouseOut   := doMouseOut;

  (* OnShapeOverIntent is triggered when the mouse remains motionless over an element
     for more than TimeMouseStop ms.
  *)
  map.TimeMouseStop     := 1000; // a second

  // add a circle in the background of the marker
  // for all markers of default group
  map.shapes.markers.OnBeforeDraw := doCircleMarker;
  // OnAfterDraw exist, for draw on top of shape

  // create a marker in a specific group
  mrk := map.AddMarker(map.latitude,map.longitude,'Car');
  mrk.Hint := 'Yellow car';
  mrk.Width := 64;
  mrk.height := 64;

  // Set the car group's ZIndex higher than the other markers' groups,
  // so that the car is displayed on top.
  mrk.Group.ZIndex := 10;


  // Specific response to clicking on this marker
  mrk.OnShapeClick := doSpecificClick;

  // use image 0 from map.icons
  mrk.Icon := 0;


  // create line in group 'Car"
  // precision of 6 decimal
  road := map.AddencodedLine(ENCODED_PATH_ROUTE, 6, 'Car');
  road.Visible := false;

  // Create an animation to move marker along the road
  // starting from km 0
  // speed 50 km/h
  moving := TECAnimationMoveOnPath.create(road, 0, 50);

   // event fired when arrived
  moving.OnDriveUp := doEndAnimationMove;

  // the animation is automatically destroyed when the marker is destroyed
  // or if you assign another animation

  mrk.animation := moving;

  // start animation
  moving.Stop   := false;



end;

procedure TFormMarkers.FormDestroy(Sender: TObject);
begin
end;

// fired when the car reaches the end of road
procedure TFormMarkers.doEndAnimationMove(Sender: TObject);
begin

  // we got it reverses direction
  TECAnimationMoveOnPath(TECShape(Sender).animation).ComeBack :=
    not TECAnimationMoveOnPath(TECShape(Sender).animation).ComeBack;

  // start animation
  TECAnimationMoveOnPath(TECShape(Sender).animation).stop := false;

  memo1.Lines.Add('End of the trip, back the other way');


end;


// click on Map
// Add a marker to the default group at the click point on the map
procedure TFormMarkers.mapMapClick(sender: TObject; const Lat, Lng: Double);
var mrk:TECShapeMarker;
begin

   // create a marker in a default group
   mrk := map.AddMarker(Lat,Lng);

   // different marker styles
   case random(5) of
    0 : begin
         // indicate the image file to be used, either a url or a local file
         mrk.filename := 'https://maps.google.com/mapfiles/ms/icons/red-dot.png';

         // You can also use an image encoded in Base64 (data uri).
         (* mrk.filename :=  'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA'+
                             'AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO'+
                             '9TXL0Y4OHwAAAABJRU5ErkJggg=='; *)

         // Under Firemonkey you can pass data from an svg
         (*

          mrk.StyleIcon := siSVG;
          mrk.Filename  := 'M7.49,15C4.5288,14.827,2.1676,12.4615,2,9.5C2,6.6,6.25'+
                           ',1.66,7.49,0c1.24,1.66,5,6.59,5,9.49S10.17,15,7.49,15z';

         *)

         mrk.Hint := 'Red dot';
         // the marker can be moved with the mouse, by default not
         mrk.Draggable := true;
         // Specific response to clicking on this marker
         mrk.OnShapeClick := doSpecificClick;
        end;

    1 : begin
         mrk.color      := clYellow;
         mrk.hovercolor := clred;
         mrk.Hint       := 'Yellow';
        end;

    2 : begin
         mrk.StyleIcon  := siFlat;

         mrk.color      := clGreen;
         // We change the border color after the marker color
         // because the marker color also changes the border color by using a darker shade.
         mrk.BorderColor:= clWhite;

         mrk.Hint     := 'Green';
         mrk.Width    := 24;
         mrk.Height   := 24;
        end;

    3 : begin
         mrk.Hint      := 'Image1';

         // the marker can be moved with the mouse, by default not
         mrk.Draggable := true;

         // directly specify the image to be used
         mrk.Graphic   := image1.Picture.Graphic;
         (*
          ! you must set OwnsGraphic to false, otherwise graphic will be released
          when the marker is destroyed and this will cause a crash when image1 is destroyed.
         *)
        mrk.OwnsGraphic := false;
        end;

     4 :begin

          mrk.color      := clblue;
          mrk.HoverColor := clHotLight;

          // The marker design will be created entirely in doOwnerDraw
          mrk.StyleIcon := siOwnerDraw;
          mrk.OnOwnerDraw := doOwnerDraw;

          mrk.Hint     := 'Blue cross';

        end;
   end;


   (*

    As mouse-over on a marker is indicated by a specific trace,
    we set focus to force redrawing of the marker to take it into account.
    Otherwise you have to move the mouse to detect the hover

   *)

   mrk.setFocus;

   mrk.Visible := true;
   mrk.Scale := 1.2;

   memo1.Lines.Add('Add Marker '+
                  ' Lat : '+DoubleToStrDigit(lat,4)+' Lng : '+DoubleToStrDigit(lng,4));
end;

procedure TFormMarkers.mapMapRightClick(Sender: TObject; const Lat,
  Lng: Double);
begin
 if not map.Shapes.Markers[0].ShowOnMap() then
  map.Shapes.Markers[0].centeronmap;

end;

// Global response for clicks on elements of any type
procedure TFormMarkers.mapShapeClick(sender: TObject; const item: TECShape);
begin
 memo1.Lines.Add('Global click : '+item.hint+' '+item.Group.Name);
end;

// spécific click on marker
procedure TFormMarkers.doSpecificClick(sender: TObject; const item: TECShape);
begin
  memo1.Lines.Add('Specific click : '+item.hint+' '+item.Group.Name);
end;

// Global response for OnShapeOverIntent
procedure TFormMarkers.doOverIntention(Sender: TObject);
begin
  memo1.Lines.Add('Global OverIntent : '+TECShape(Sender).hint);
  // Cancel the event, and reactivate it when the mouse is released.
  map.OnShapeOverIntent := nil;
end;

// Global response for OnShapeMouseOut
procedure TFormMarkers.doMouseOut(sender: TObject; const item: TECShape);
begin
  // Reactivate event
  map.OnShapeOverIntent := doOverIntention;
end;



// global response for Drag shape
// this event is called every time you move, test DragStart to determine the start of the movement
procedure TFormMarkers.mapShapeDrag(sender: TObject; const item: TECShape;
  var cancel: Boolean);
begin
 if not item.DragStart then
  memo1.Lines.Add('Drag Start : '+item.hint);
end;

// global response for drag end
procedure TFormMarkers.mapShapeDragEnd(Sender: TObject);
var shape : TECShape;
begin
  shape := TECShape(Sender);
  memo1.Lines.Add('Drag End   '+
                  ' Lat : '+DoubleToStrDigit(shape.latitude,4)+' Lng : '+DoubleToStrDigit(shape.longitude,4));
end;




// global response for right click
procedure TFormMarkers.doRemoveMarker(sender: TObject; const item: TECShape);
begin

  // Do not destroy the car
  if (item.Group.name='Car') then
  begin
   memo1.Lines.Add('Not the car!');
  end
  else
  begin
    // ! manipulate the item BEFORE deleting it
    memo1.Lines.Add('Remove '+item.Hint);
    item.Remove;
    // now item doesn't exist, we can't use it
   end;
end;

(*
 procedure called in OnBeforeDraw that lets you draw before displaying the element, so you can add a background.
 There's an equivalent procedure for drawing on top, OnAfterDraw
*)
procedure TFormMarkers.doCircleMarker(const canvas: TECCanvas; var rect: TRect; item: TECShape) ;
begin

  // only if mouse hovers over element
  if not item.Hover then  exit;

  // size border
  Canvas.PenSize := 3;
  // border color
  canvas.pen.Color := clWhite;
  // fill color
  canvas.Brush.Color := item.HoverColor;
  // 50% opacity
  canvas.FillOpacity := 50;

  canvas.Ellipse(rect.left - 10 ,rect.Top -10 ,rect.Right + 10,rect.Bottom + 10);
end;


// full support for element drawing
procedure TFormMarkers.doOwnerDraw(const canvas: TECCanvas; var rect: TRect; item: TECShape) ;
var
  x, y, radius: integer;
begin

  radius := item.width;

  canvas.PenWidth(2);


  if item.Hover then
    canvas.Pen.Color := item.hovercolor
  else
    canvas.Pen.Color := item.color;


  // draw center cross
  x := rect.Left + (rect.Right  - rect.Left) div 2;
  y := rect.Top  + (rect.Bottom - rect.Top) div 2;
  canvas.Polyline([Point(x, y - radius), Point(x, y + radius)]);
  canvas.Polyline([Point(x - radius, y), Point(x + radius, y)]);


  // draw circle

  canvas.Pen.Color := clBlack;

  // transparent
  canvas.FillOpacity := 0;

  canvas.Ellipse(x - radius, y - radius, x + radius, y + radius);
end;



end.
