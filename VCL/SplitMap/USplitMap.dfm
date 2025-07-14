object FormSplitMap: TFormSplitMap
  Left = 0
  Top = 0
  Caption = 'SplitMap'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object Panel1: TPanel
    Left = 480
    Top = 0
    Width = 144
    Height = 441
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 30
      Width = 132
      Height = 17
      Margins.Top = 10
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Map Tile Server'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 97
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 90
      Width = 132
      Height = 17
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Left Map Tile Server'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 125
    end
    object ckSplit: TCheckBox
      Left = 3
      Top = 3
      Width = 138
      Height = 17
      Margins.Top = 6
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Split Map'
      TabOrder = 0
      OnClick = ckSplitClick
    end
    object cbMainMap: TComboBox
      AlignWithMargins = True
      Left = 13
      Top = 56
      Width = 125
      Height = 25
      Margins.Left = 10
      Align = alTop
      Style = csDropDownList
      TabOrder = 1
      OnChange = cbMainMapChange
      Items.Strings = (
        'OpenStreetMap'
        'Cycle Map'
        'OPVN'
        'ArcGis Aerial')
    end
    object cbLeftMap: TComboBox
      AlignWithMargins = True
      Left = 13
      Top = 116
      Width = 125
      Height = 25
      Margins.Left = 10
      Align = alTop
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbMainMapChange
      Items.Strings = (
        'OpenStreetMap'
        'Cycle Map'
        'OPVN'
        'ArcGis Aerial')
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 480
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
