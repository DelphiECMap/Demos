object FormHandsFree: TFormHandsFree
  Left = 0
  Top = 0
  Caption = 'Hands-free draw and selection for TECNativeMap'
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
  object Bar: TPanel
    AlignWithMargins = True
    Left = 445
    Top = 3
    Width = 176
    Height = 340
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 448
    ExplicitTop = 0
    ExplicitHeight = 441
    object Selection: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 251
      Width = 170
      Height = 17
      Align = alTop
      Caption = 'Selection'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = SelectionClick
      ExplicitLeft = 22
      ExplicitTop = 226
      ExplicitWidth = 97
    end
    object gbDraw: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 179
      Width = 170
      Height = 66
      Align = alTop
      Caption = 'Draw'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitTop = 327
      object rbLine: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 160
        Height = 17
        Align = alTop
        Caption = 'Line'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        ExplicitLeft = 32
        ExplicitTop = 40
        ExplicitWidth = 113
      end
      object rbPolygone: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 43
        Width = 160
        Height = 17
        Align = alTop
        Caption = 'Polygone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 24
        ExplicitTop = 64
        ExplicitWidth = 113
      end
    end
    object gbMouse: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 103
      Width = 170
      Height = 70
      Align = alTop
      Caption = 'Mouse button'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 3
      object rbLeft: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 160
        Height = 17
        Align = alTop
        Caption = 'Left'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = rbLeftClick
        ExplicitLeft = 24
        ExplicitTop = 40
        ExplicitWidth = 113
      end
      object rbRight: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 43
        Width = 160
        Height = 17
        Align = alTop
        Caption = 'Right'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = rbLeftClick
        ExplicitLeft = 16
        ExplicitTop = 64
        ExplicitWidth = 113
      end
    end
    object gbStyle: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 170
      Height = 94
      Align = alTop
      Caption = 'Style'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Label1: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 160
        Height = 15
        Align = alTop
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 38
      end
      object seWeight: TSpinEdit
        Left = 56
        Top = 14
        Width = 57
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxValue = 8
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 4
        OnChange = doUpdateStyle
      end
      object cgColor: TColorGrid
        AlignWithMargins = True
        Left = 3
        Top = 44
        Width = 160
        Height = 46
        GridOrdering = go8x2
        ForegroundIndex = 9
        BackgroundEnabled = False
        Selection = 1
        TabOrder = 1
        OnChange = doUpdateStyle
      end
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 442
    Height = 346
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
    ExplicitTop = 35
    ExplicitWidth = 624
    ExplicitHeight = 406
  end
  object mmLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 349
    Width = 618
    Height = 89
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
