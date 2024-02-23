object FormHeatMap: TFormHeatMap
  Left = 0
  Top = 0
  Caption = 'Demo HeatMap for TECNativeMap'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 456
    Top = 0
    Width = 168
    Height = 441
    Align = alRight
    TabOrder = 0
    object btnMarkers: TButton
      Left = 16
      Top = 16
      Width = 137
      Height = 25
      Caption = 'Add 10000 Markers'
      TabOrder = 0
      OnClick = btnMarkersClick
    end
    object BtnHeatMapLayer: TButton
      Left = 16
      Top = 56
      Width = 137
      Height = 25
      Caption = 'HeatMapLayer manual'
      TabOrder = 1
      OnClick = BtnHeatMapLayerClick
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 456
    Height = 441
    HideShapesWhenZoom = False
    HideShapesWhenWaitingTile = False
    DblClickZoom = True
    MouseWheelZoom = True
    latitude = 43.232951000000000000
    longitude = 0.078081999999994910
    Reticle = False
    ReticleColor = clBlack
    Zoom = 12
    ZoomScaleFactor = 0
    NumericalZoom = 12.000000000000000000
    DragRect = drNone
    Draggable = True
    OnlyOneOpenInfoWindow = False
    WaitingForDestruction = False
    Active = True
    NbrThreadTile = ttFour
    OnShapeClick = mapShapeClick
    Align = alClient
    TabOrder = 1
  end
end
