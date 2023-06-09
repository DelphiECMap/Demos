unit Uoverpasslayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  uecNativeMapControl,uecNativeShape,uecMapUtil,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ComCtrls;

type
  TForm9 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    ckNode: TCheckBox;
    ckWay: TCheckBox;
    Amenities: TCheckListBox;
    GroupBox2: TGroupBox;
    ckLayer: TCheckBox;
    QuerySearch: TLabel;
    GroupBox3: TGroupBox;
    btParking: TPanel;
    btFuel: TPanel;
    btRestaurant: TPanel;
    ColorDialog: TColorDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    XmlData: TMemo;
    map: TECNativeMap;
    procedure ckLayerClick(Sender: TObject);
    procedure ckNodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btRestaurantClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure BuildQuery;
    procedure doOnBeginQuery(sender : TObject);
    procedure doOnEndQuery(sender : TObject);
    procedure doOnClick(sender: TObject; const item: TECShape);
    procedure doOnData(const XmlValue:string);

    procedure UpdateStyleColors;

  public
    { Déclarations publiques }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.ckLayerClick(Sender: TObject);
begin
 map.OverPassApi.Layer.Visible := ckLayer.Checked;

 if ckLayer.Checked then BuildQuery;

end;

procedure TForm9.ckNodeClick(Sender: TObject);
begin
 BuildQuery;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
   // define the default styles of the elements
   // marker size is adjusted according to the zoom
   map.styles.addRule('.marker {scale:0-10=0.7,11-15=0.8,16-17=0.95,18-20=1;width:24;height:24;visible:true;styleicon:Flat}');
   map.styles.addRule('.polygone{bsize:1;fopacity:70;visible:true;}');

   //  define the rules of styles which can vary, here the colors are modifiable
   UpdateStyleColors;

   map.OverPassApi.Layer.OnBeginQuery := doOnBeginQuery;
   map.OverPassApi.Layer.OnEndQuery   := doOnEndQuery;
   map.OverPassApi.Layer.OnClick      := doOnClick;
   map.OverPassApi.Layer.OnData       := doOnData;

   caption := 'OverPassAPI Layer for TECNativeMap © ESCOT-SEP Christophe';

end;

procedure TForm9.UpdateStyleColors;
var c,rule_M,rule_P:string;
 procedure update_Rules(color:TColor);
 begin
   c      := ColorToHTML(Color);
   rule_M := '{color:'+c+';bcolor:dark('+c+');hcolor:dark('+c+');hbcolor:'+c+';}';
   rule_P := '{color:'+c+';fcolor:'+c+';bcolor:dark('+c+');hcolor:dark('+c+');hbcolor:'+c+';}';
 end;
begin




  update_Rules(btRestaurant.Color);

  //  Use ClearAddRule and not AddRule to replace the old rules,
  //  otherwise they will be processed and waste time unnecessarily
  map.styles.ClearAddRule('.marker.amenity:restaurant'+rule_M );
  map.styles.ClearAddRule('.polygone.amenity:restaurant'+Rule_P);

  update_Rules(btFuel.Color);

  map.styles.ClearAddRule('.marker.amenity:fuel'+rule_M);
  map.styles.ClearAddRule('.polygone.amenity:fuel'+Rule_P);

  update_Rules(btParking.Color);

  map.styles.ClearAddRule('.marker.amenity:parking'+rule_M);
  map.styles.ClearAddRule('.polygone.amenity:parking'+Rule_P);

end;


procedure TForm9.doOnData(const XmlValue:string);
begin
 XmlData.Lines.BeginUpdate;
 XmlData.Lines.Text := XmlValue;
 XmlData.Lines.EndUpdate;
end;

// fired whan click on ovepassapi layer item
procedure TForm9.doOnClick(sender: TObject; const item: TECShape);
var Key, Value, content: string;
    win: TECShapeInfoWindow;
begin
  content := '';

  if item.PropertiesFindFirst(Key, Value) then
  begin
    repeat
      // if necessary line break
      if content<>'' then content := content+'<br>';
      // align the values to 100 pixels
      Key := Key + '<tab=100>';
      // Bold the keys
      content := content + '<b>' + Key + '</b>: ' + Value ;
    // continue as long as there are properties
    until item.PropertiesFindNext(Key, Value);
  end;

  if content='' then exit;


  // create window if not exists
  if map.OverPassApi.Layer.Group.InfoWindows.count = 0 then
  begin
    win := map.OverPassApi.Layer.Group.AddInfoWindow;
    win.Width := 270;
  end
  else
    win := map.OverPassApi.Layer.Group.InfoWindows[0];

  win.content := content;
  win.SetPosition(map.MouseLatLng.Lat, map.MouseLatLng.lng);
  win.Visible := true;

end;

procedure  TForm9.doOnBeginQuery(sender : TObject);
begin
   QuerySearch.Visible := true;
end;
procedure  TForm9.doOnEndQuery(sender : TObject);
begin
   QuerySearch.Visible := false;
end;

procedure TForm9.btRestaurantClick(Sender: TObject);
begin
 if colorDialog.Execute then
 begin
  TPanel(Sender).Color := colorDialog.Color;
  // GetContrastingColor in uecMapUtil unit
  TPanel(Sender).Font.Color := GetContrastingColor(TPanel(Sender).Color);
  UpdateStyleColors;
 end;

end;

procedure TForm9.BuildQuery;
var  Data:TSetOSMData;
     amenity_values: array of string;
     i,count : integer;
begin
   Data := [];

   if ckNode.Checked then
    Data := Data+[odNode];

    if ckWay.Checked then
    Data := Data+[odWay];

   SetLength(amenity_values,3);

   count := 0;


   for i := 0 to Amenities.Items.Count-1 do
   begin
     if Amenities.Checked[i] then
     begin
       amenity_values[count]:= Amenities.Items[i];
       inc(count);
     end;
   end;

   SetLength(amenity_values,count);

   if (count>0) and (Data<>[]) then
   begin
     map.OverPassApi.Layer.Amenity(amenity_values,Data);
   end;



end;

end.
