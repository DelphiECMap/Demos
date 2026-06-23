unit USplitMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl, uecMapUtil,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFormSplitMap = class(TForm)
    Panel1: TPanel;
    map: TECNativeMap;
    ckSplit: TCheckBox;
    Label1: TLabel;
    cbMainMap: TComboBox;
    Label2: TLabel;
    cbLeftMap: TComboBox;
    procedure ckSplitClick(Sender: TObject);
    procedure cbMainMapChange(Sender: TObject);
    procedure mapMapClick(Sender: TObject; const Lat, Lng: Double);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormSplitMap: TFormSplitMap;

implementation

{$R *.dfm}

procedure TFormSplitMap.cbMainMapChange(Sender: TObject);
var
  SelectMap: TECNativeMap;
begin
  if (Sender = cbMainMap) then
    SelectMap := map
  else
   if (Sender = cbLeftMap) then
    //  ! if not map.SplitMap then map.RightMap = nil
    SelectMap := map.RightMap
   else
    SelectMap := nil;

  if assigned(SelectMap) then
  begin
    // tile servers are defined in the uecMapUtil unit
    case TComboBox(Sender).ItemIndex of

      0 : SelectMap.TileServer := tsOSM;

      1 : SelectMap.TileServer := tsOpenCycleMap;

      2 : SelectMap.TileServer := tsOPNV;

      3 : SelectMap.TileServer := tsArcGisWorldImagery;

    end;
  end;

end;

procedure TFormSplitMap.ckSplitClick(Sender: TObject);
begin
  map.SplitMap := ckSplit.Checked;

  if map.SplitMap then
  begin
    // ! if not map.SplitMap then map.SplitterMap = nil
    map.SplitterMap.Width := 6;
    map.SplitterMap.Color := clBlack;

    map.AddView(Map.RightMap);

    // select tiles server if necessary
    cbMainMapChange(cbLeftMap);
  end ;

end;

procedure TFormSplitMap.mapMapClick(Sender: TObject; const Lat, Lng: Double);
begin
 map.Shapes.AddMarker(lat,lng);
end;

end.
