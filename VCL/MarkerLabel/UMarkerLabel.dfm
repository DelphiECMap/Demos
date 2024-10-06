object Form27: TForm27
  Left = 0
  Top = 0
  Caption = 'Labels - TECNativeMap - '#169' ESCOT-SEP Christophe'
  ClientHeight = 545
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 309
      Top = 42
      Width = 29
      Height = 13
      Caption = 'Style'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 308
      Top = 14
      Width = 28
      Height = 13
      Caption = 'Align'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 575
      Top = 42
      Width = 35
      Height = 13
      Caption = 'Select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 437
      Top = 42
      Width = 52
      Height = 13
      Caption = 'Style line'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 575
      Top = 14
      Width = 39
      Height = 13
      Caption = 'Margin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object addMarker: TButton
      Left = 7
      Top = 3
      Width = 98
      Height = 25
      Caption = 'Add 8 Markers'
      TabOrder = 0
      OnClick = addMarkerClick
    end
    object cbStyle: TComboBox
      Left = 342
      Top = 38
      Width = 85
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Rectangle'
      OnChange = cbStyleChange
      Items.Strings = (
        'Rectangle'
        'RoundRect'
        'Transparent')
    end
    object cbAlign: TComboBox
      Left = 342
      Top = 11
      Width = 85
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cbAlignChange
      Items.Strings = (
        'Top'
        'Bottom'
        'Left'
        'Right')
    end
    object ckLabels: TCheckBox
      Left = 208
      Top = 11
      Width = 49
      Height = 17
      Caption = 'Labels'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = ckLabelsClick
    end
    object AddPois: TButton
      Left = 7
      Top = 34
      Width = 98
      Height = 25
      Caption = 'Add 8 Pois'
      TabOrder = 4
      OnClick = AddPoisClick
    end
    object RadioGroup1: TRadioGroup
      Left = 111
      Top = 0
      Width = 82
      Height = 59
      Caption = 'Select'
      TabOrder = 5
    end
    object rbMarkers: TRadioButton
      Left = 123
      Top = 16
      Width = 60
      Height = 17
      Caption = 'Markers'
      Checked = True
      TabOrder = 6
      TabStop = True
      OnClick = rbMarkersClick
    end
    object rbPois: TRadioButton
      Left = 123
      Top = 36
      Width = 60
      Height = 17
      Caption = 'Pois'
      TabOrder = 7
      OnClick = rbMarkersClick
    end
    object ckScale: TCheckBox
      Left = 208
      Top = 38
      Width = 95
      Height = 17
      Caption = 'Scale to Zoom'
      TabOrder = 8
      OnClick = ckScaleClick
    end
    object cbSelect: TComboBox
      Left = 616
      Top = 39
      Width = 73
      Height = 21
      Style = csDropDownList
      TabOrder = 9
      OnChange = cbSelectChange
      Items.Strings = (
        'none'
        'Alpha'
        'Beta'
        'Gamma')
    end
    object ckConnector: TCheckBox
      Left = 439
      Top = 11
      Width = 74
      Height = 17
      Caption = 'Connector'
      TabOrder = 10
      OnClick = ckConnectorClick
    end
    object cbStyleLine: TComboBox
      Left = 494
      Top = 38
      Width = 75
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 11
      Text = 'Solid'
      OnChange = cbStyleLineChange
      Items.Strings = (
        'Solid'
        'Dash'
        'DashDot'
        'Dot')
    end
    object cbMargin: TComboBox
      Left = 616
      Top = 11
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 12
      Text = '10'
      OnChange = cbMarginChange
      Items.Strings = (
        '10'
        '20'
        '30'
        '40'
        '50'
        '60'
        '')
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 65
    Width = 763
    Height = 480
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
    TileServer = tsOsmFr
    OnlyOneOpenInfoWindow = False
    WaitingForDestruction = False
    Active = True
    NbrThreadTile = ttFour
    Align = alClient
    TabOrder = 1
  end
end
