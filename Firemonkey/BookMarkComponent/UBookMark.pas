unit UBookMark;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.uecNativeMapControl, FMX.uecBookmarkComponent, FMX.UECMapUtil,
  FMX.Objects;

type
  TFormBookMark = class(TForm)
    MainBat: TRectangle;
    map: TECNativeMap;
    ckVisible: TCheckBox;
    ckTopBottom: TCheckBox;
    RandomColor: TButton;
    Panel1: TPanel;
    Save: TButton;
    Load: TButton;
    ckShowOnMap: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ckVisibleChange(Sender: TObject);
    procedure ckTopBottomChange(Sender: TObject);
    procedure RandomColorClick(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ckShowOnMapChange(Sender: TObject);
  private
    { Déclarations privées }
    FBookMarkComponent: TBookMarkComponent;

    procedure doOnchange(Sender: TObject);

  public
    { Déclarations publiques }
  end;

var
  FormBookMark: TFormBookMark;

implementation

{$R *.fmx}

procedure TFormBookMark.FormCreate(Sender: TObject);
begin

  FBookMarkComponent               := TBookMarkComponent.Create(map);
  // display bookmark bar
  FBookMarkComponent.Visible       := ckVisible.IsChecked;
  // show bookmarks on map
  FBookMarkComponent.Group.Visible := ckShowOnMap.IsChecked;
  // triggered if visible, position or bookmarks change
  FBookMarkComponent.OnChange := doOnchange;


end;

procedure TFormBookMark.FormDestroy(Sender: TObject);
begin

  FBookMarkComponent.Free;

end;

procedure TFormBookMark.doOnchange(Sender: TObject);
begin

 if FBookMarkComponent.visible then
  FBookMarkComponent.Group.Visible := ckShowOnMap.IsChecked;


end;


procedure TFormBookMark.ckVisibleChange(Sender: TObject);
begin

  FBookMarkComponent.Visible := ckVisible.IsChecked;

end;

procedure TFormBookMark.ckShowOnMapChange(Sender: TObject);
begin

  FBookMarkComponent.Group.Visible := ckShowOnMap.IsChecked;

end;

procedure TFormBookMark.ckTopBottomChange(Sender: TObject);
begin

  if ckTopBottom.IsChecked then
    FBookMarkComponent.Align := ecAlRightBottom
  else
    FBookMarkComponent.Align := ecAlRightTop;

end;

procedure TFormBookMark.LoadClick(Sender: TObject);
begin

  FBookMarkComponent.LoadFromFile(ExtractfilePath(ParamStr(0)) +
    'bookmark.txt');

end;

procedure TFormBookMark.SaveClick(Sender: TObject);
begin

  FBookMarkComponent.SaveToFile(ExtractfilePath(ParamStr(0)) + 'bookmark.txt');

end;

procedure TFormBookMark.RandomColorClick(Sender: TObject);
begin

  FBookMarkComponent.Color := GetRandomcolor;

end;

end.
