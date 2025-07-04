object FIsoChrone: TFIsoChrone
  Left = 0
  Top = 0
  Caption = 'Demo IsoChrone & OverPassAPI'
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
  object pnCmd: TPanel
    Left = 439
    Top = 0
    Width = 185
    Height = 441
    Align = alRight
    TabOrder = 0
    object rgSearch: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 177
      Height = 245
      Align = alTop
      Caption = '    Find a restaurant in  '
      DefaultHeaderFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -15
      HeaderFont.Name = 'Segoe UI'
      HeaderFont.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object foot5: TRadioButton
      Left = 16
      Top = 40
      Width = 145
      Height = 17
      Caption = '5 minutes on foot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = foot5Click
    end
    object foot10: TRadioButton
      Tag = 1
      AlignWithMargins = True
      Left = 16
      Top = 63
      Width = 137
      Height = 17
      Caption = '10 minutes on foot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = foot5Click
    end
    object car5: TRadioButton
      Tag = 2
      Left = 16
      Top = 88
      Width = 145
      Height = 17
      Caption = '5 minutes by car'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = foot5Click
    end
    object car10: TRadioButton
      Tag = 3
      AlignWithMargins = True
      Left = 16
      Top = 111
      Width = 137
      Height = 17
      Caption = '10 minutes by car'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = foot5Click
    end
    object foot500m: TRadioButton
      Tag = 4
      Left = 16
      Top = 136
      Width = 145
      Height = 17
      Caption = '500 metres on foot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = foot5Click
    end
    object foot1km: TRadioButton
      Tag = 5
      AlignWithMargins = True
      Left = 16
      Top = 159
      Width = 137
      Height = 17
      Caption = '1 km on foot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = foot5Click
    end
    object car3km: TRadioButton
      Tag = 6
      Left = 16
      Top = 184
      Width = 145
      Height = 17
      Caption = '1 km by car'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = foot5Click
    end
    object car10km: TRadioButton
      Tag = 7
      AlignWithMargins = True
      Left = 16
      Top = 207
      Width = 137
      Height = 17
      Caption = '3 km by car'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = foot5Click
    end
    object btSearch: TButton
      AlignWithMargins = True
      Left = 4
      Top = 255
      Width = 177
      Height = 25
      Align = alTop
      Caption = 'Search...'
      TabOrder = 9
      OnClick = btSearchClick
      ExplicitLeft = 32
      ExplicitTop = 240
      ExplicitWidth = 75
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 439
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
    Align = alClient
    TabOrder = 1
  end
end
