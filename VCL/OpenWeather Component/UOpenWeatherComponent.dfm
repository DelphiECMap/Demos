object FormWeather: TFormWeather
  Left = 0
  Top = 0
  Caption = 'OpenWeather component for TECNativeMap'
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
    Height = 319
    Align = alRight
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 245
      Width = 127
      Height = 15
      Align = alTop
      Caption = 'Time line'
      ExplicitWidth = 48
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 127
      Height = 213
      Align = alTop
      Caption = 'Position'
      Padding.Left = 3
      Padding.Top = 3
      Padding.Right = 3
      Padding.Bottom = 3
      TabOrder = 0
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
      object RadioButton5: TRadioButton
        Tag = 4
        AlignWithMargins = True
        Left = 8
        Top = 115
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Top-Center'
        TabOrder = 4
        OnClick = RadioButton4Click
      end
      object RadioButton6: TRadioButton
        Tag = 5
        AlignWithMargins = True
        Left = 8
        Top = 138
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Bottom-Center'
        TabOrder = 5
        OnClick = RadioButton4Click
      end
      object RadioButton7: TRadioButton
        Tag = 6
        AlignWithMargins = True
        Left = 8
        Top = 161
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Left-Center'
        TabOrder = 6
        OnClick = RadioButton4Click
      end
      object RadioButton8: TRadioButton
        Tag = 7
        AlignWithMargins = True
        Left = 8
        Top = 184
        Width = 111
        Height = 17
        Align = alTop
        Caption = 'Right-Center'
        TabOrder = 7
        OnClick = RadioButton4Click
      end
    end
    object ckVisible: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 222
      Width = 127
      Height = 17
      Align = alTop
      Caption = 'Visible'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = ckVisibleClick
    end
    object TimeLine: TTrackBar
      AlignWithMargins = True
      Left = 3
      Top = 266
      Width = 127
      Height = 45
      Align = alTop
      Max = 39
      PositionToolTip = ptTop
      TabOrder = 2
      OnChange = TimeLineChange
      ExplicitLeft = 0
      ExplicitTop = 264
      ExplicitWidth = 126
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 328
    Width = 618
    Height = 110
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object map: TECNativeMap
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 479
    Height = 319
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
    TabOrder = 2
  end
end
