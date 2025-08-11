object FormCluster: TFormCluster
  Left = 0
  Top = 0
  Caption = 'FormCluster'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Loading: TLabel
    Left = 0
    Top = 0
    Width = 624
    Height = 21
    Align = alTop
    Alignment = taCenter
    Caption = 'Loading data ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 116
  end
  object map: TECNativeMap
    Left = 0
    Top = 21
    Width = 624
    Height = 420
    Cursor = crDefault
    HideShapesWhenZoom = False
    HideShapesWhenWaitingTile = False
    DblClickZoom = True
    MouseWheelZoom = True
    latitude = 43.232951000000000000
    longitude = 0.078081999999994910
    Reticle = False
    ReticleColor = clBlack
    ZoomScaleFactor = 0
    NumericalZoom = 14.000000000000000000
    DragRect = drNone
    Draggable = True
    OnlyOneOpenInfoWindow = False
    WaitingForDestruction = False
    Active = True
    NbrThreadTile = ttFour
    OnLoad = doOnLoad
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 128
    ExplicitTop = 120
    ExplicitWidth = 256
    ExplicitHeight = 256
  end
end
