object FormWMS: TFormWMS
  Left = 0
  Top = 0
  Caption = 'demo OverlayWMS for TECNativeMap'
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
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 368
    Top = 3
    Width = 253
    Height = 435
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbSelect: TLabel
      AlignWithMargins = True
      Left = 24
      Top = 49
      Width = 226
      Height = 51
      Margins.Left = 24
      Margins.Bottom = 10
      Align = alTop
      Caption = 
        'Select an area on the map with the mouse, holding down the right' +
        ' mouse button.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 113
      Width = 240
      Height = 20
      Margins.Left = 10
      Align = alTop
      Caption = 'Opacity'
      ExplicitWidth = 51
    end
    object info: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 412
      Width = 247
      Height = 20
      Align = alBottom
      Alignment = taCenter
      ExplicitWidth = 4
    end
    object ckOverlay: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 247
      Height = 17
      Align = alTop
      Caption = 'Visible overlay'
      TabOrder = 0
      OnClick = ckOverlayClick
    end
    object ckLinkedMap: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 26
      Width = 247
      Height = 17
      Align = alTop
      Caption = 'Overlay linked to visible map area'
      TabOrder = 1
      OnClick = ckLinkedMapClick
    end
    object tkOpacity: TTrackBar
      AlignWithMargins = True
      Left = 10
      Top = 139
      Width = 240
      Height = 30
      Margins.Left = 10
      Align = alTop
      Max = 100
      ParentShowHint = False
      Frequency = 10
      PositionToolTip = ptBottom
      ShowHint = True
      TabOrder = 2
      OnChange = tkOpacityChange
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 365
    Height = 441
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
    OnMapSelectRect = mapMapSelectRect
    Align = alClient
    TabOrder = 1
  end
end
