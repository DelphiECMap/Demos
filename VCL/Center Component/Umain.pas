unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uecNativeMapControl,uecLegendPanel,uecZoomBarComponent;

type
  TForm21 = class(TForm)
    map: TECNativeMap;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    FLegend : TLegendComponent;
    FZoomBar: TZoomBarComponent;
    FSpace  : TECComponent;

    procedure doMapResize(Sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  Form21: TForm21;

implementation

{$R *.dfm}

procedure TForm21.FormCreate(Sender: TObject);
begin
 map.OnResize := doMapResize;

 // align the components at the bottom of the map to the left

 FLegend      := TLegendComponent.Create(map);
 FLegend.Legend.Add('Item 1',clRed);
 FLegend.Legend.Add('Item 2',clYellow);
 FLegend.Width := 80;
 FLegend.Height:= 60;
 FLegend.Align := ecLeftBottom;

 // FSpace will act as a margin between the legend and the zoom bar.
 FSpace := map.Components.Add(50,ecLeftBottom);

 FZoomBar := TZoomBarComponent.Create(map);
 FZoomBar.Layout := ctlHorizontal;
 FZoomBar.Align  := ecLeftBottom;

 // calculate the gap between the two components
 doMapResize(map);

end;


// The spacing between the legend and the zoom bar is calculated when the map is resized,
// so as to center the zoom bar horizontally.
procedure TForm21.doMapResize(Sender : TObject);
begin
  FSpace.width := (map.width div 2) - FLegend.width - (FZoomBar.width div 2);
end;

end.
