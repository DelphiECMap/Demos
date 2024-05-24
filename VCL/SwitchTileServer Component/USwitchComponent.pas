unit USwitchComponent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,uecNativeMapControl,uecSwitchServerComponent,uecMapUtil,
  Vcl.StdCtrls;

type
  TFormSwitch = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    Memo1: TMemo;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    pnSecondaryColor: TPanel;
    pnColor: TPanel;
    ColorDialog: TColorDialog;
    cbSize: TComboBox;
    Label1: TLabel;
    ckVertical: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure pnColorClick(Sender: TObject);
    procedure cbSizeChange(Sender: TObject);
    procedure ckVerticalClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure doOnSwitch(Sender : TObject);
    procedure doOnChange(Sender : TObject);

    procedure GetTile(var TileFilename: string; const x, y, z: Integer);

  public
    { Déclarations publiques }
    FSwitchServer,FSwitchServer2 : TSwitchServerComponent;
  end;

var
  FormSwitch: TFormSwitch;

implementation

{$R *.dfm}



procedure TFormSwitch.FormCreate(Sender: TObject);
begin
  FSwitchServer := TSwitchServerComponent.create(map);
  FSwitchServer.Visible := true;

  // line useless because it is the default server, indicate for info
  FSwitchServer.TileServer := tsArcGisWorldImagery;

  // Triggered by switch click after server change
  FSwitchServer.OnSwitch := doOnSwitch;
  // Triggered especially when changing alignment and size
  FSwitchServer.OnChange := doOnChange;



  // Pass a name in addition (here '2') to be able to add another TSwitchServerComponent, otherwise the first one is reused.
  FSwitchServer2 := TSwitchServerComponent.create(map,'2');
  FSwitchServer2.Visible := true;

  FSwitchServer2.OnSwitch := doOnSwitch;

  FSwitchServer2.TileServer := tsIgn;
  FSwitchServer2.MapStyle   :=  'SCAN';

  // You can specify your own server like this
  // FSwitchServer2.CustomTileServer := getTile;

  pnColor.Color           := FSwitchServer.Color;
  pnSecondaryColor.Color  := FSwitchServer.SecondaryColor;


end;

// build access to your own tiles here
procedure TFormSwitch.GetTile(var TileFilename: string; const x, y, z: Integer);
begin
  TileFilename := Format('your_tile_url/%s%/%s/%s',[x,y,z]);
end;

procedure TFormSwitch.pnColorClick(Sender: TObject);
begin
 if ColorDialog.Execute then
 begin
  TPanel(Sender).Color := ColorDialog.Color;

  FSwitchServer.Color          := pnColor.Color;
  FSwitchServer.SecondaryColor := pnSecondaryColor.Color;

  FSwitchServer2.Color          := pnColor.Color;
  FSwitchServer2.SecondaryColor := pnSecondaryColor.Color;
 end;
end;

procedure TFormSwitch.cbSizeChange(Sender: TObject);
begin
 case cbSize.ItemIndex of
  0: FSwitchServer.size := 32;
  1: FSwitchServer.size := 48;
  2: FSwitchServer.size := 64;
 end;

  FSwitchServer2.size := FSwitchServer.size ;
end;

procedure TFormSwitch.doOnSwitch(Sender : TObject);
begin
  memo1.Lines.Add(TSwitchServerComponent(Sender).Name + ' -> '+tsToString(map.TileServer)+' '+map.TileServerInfo.MapStyle)  ;
end;

// button stacking direction
procedure TFormSwitch.ckVerticalClick(Sender: TObject);
begin
 if ckVertical.Checked then
 begin
   // from bottom to top on left side
   FSwitchServer.Align  := ecBottomLeft;
   FSwitchServer2.Align := ecBottomLeft;
 end
 else
 begin
   // from left to right at the bottom of the screen
   FSwitchServer.Align  := ecLeftBottom;
   FSwitchServer2.Align := ecLeftBottom;
 end;
end;

// Triggered especially when changing alignment and size
procedure TFormSwitch.doOnChange(Sender : TObject);
var sAlign : string;
begin
  if TSwitchServerComponent(Sender).Align=ecLeftBottom then
   sAlign := ' Align : LeftBottom'
  else
   sAlign := ' Align : BottomLeft';

  memo1.Lines.Add('Size : '+inttostr(TSwitchServerComponent(Sender).size)+sAlign)  ;
end;
end.
