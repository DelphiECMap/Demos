object FormZoomBar: TFormZoomBar
  Left = 0
  Top = 0
  Caption = 'ZoomBar Component Demo'
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
    AlignWithMargins = True
    Left = 488
    Top = 3
    Width = 133
    Height = 435
    Align = alRight
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ckVertical: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 127
      Height = 17
      Align = alTop
      Caption = 'Vertical Bar'
      TabOrder = 0
      OnClick = ckVerticalClick
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 26
      Width = 127
      Height = 126
      Align = alTop
      Caption = 'Position'
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      TabOrder = 1
      object RadioButton1: TRadioButton
        Tag = 3
        AlignWithMargins = True
        Left = 8
        Top = 92
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Bottom-Left'
        TabOrder = 0
        OnClick = RadioButton4Click
      end
      object RadioButton2: TRadioButton
        Tag = 2
        AlignWithMargins = True
        Left = 8
        Top = 69
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Bottom-Right'
        TabOrder = 1
        OnClick = RadioButton4Click
      end
      object RadioButton3: TRadioButton
        Tag = 1
        AlignWithMargins = True
        Left = 8
        Top = 46
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Top-Left'
        TabOrder = 2
        OnClick = RadioButton4Click
      end
      object RadioButton4: TRadioButton
        AlignWithMargins = True
        Left = 8
        Top = 23
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Top-Right'
        Checked = True
        TabOrder = 3
        TabStop = True
        OnClick = RadioButton4Click
      end
    end
    object ckVisible: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 181
      Width = 127
      Height = 17
      Align = alTop
      Caption = 'Visible'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ckVisibleClick
      ExplicitTop = 158
    end
    object ckProgressive: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 158
      Width = 127
      Height = 17
      Hint = 'Press and hold a zoom button to activate progressive zoom.'
      Align = alTop
      Caption = 'Progressive zoom'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = ckProgressiveClick
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 485
    Height = 441
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
