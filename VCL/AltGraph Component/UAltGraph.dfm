object FormAltGraph: TFormAltGraph
  Left = 0
  Top = 0
  Caption = 'FormAltGraph'
  ClientHeight = 441
  ClientWidth = 682
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
    Left = 472
    Top = 0
    Width = 210
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
    object info: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 395
      Width = 198
      Height = 17
      Align = alBottom
      WordWrap = True
      ExplicitTop = 418
      ExplicitWidth = 4
    end
    object btAddRoute: TButton
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 198
      Height = 25
      Align = alTop
      Caption = 'Create route from A to B'
      TabOrder = 0
      OnClick = btAddRouteClick
    end
    object LB: TListBox
      AlignWithMargins = True
      Left = 6
      Top = 37
      Width = 198
      Height = 352
      Align = alClient
      ItemHeight = 17
      TabOrder = 1
      ExplicitHeight = 284
    end
    object ckVisible: TCheckBox
      AlignWithMargins = True
      Left = 6
      Top = 418
      Width = 198
      Height = 17
      Align = alBottom
      Caption = 'Visible'
      TabOrder = 2
      OnClick = ckVisibleClick
      ExplicitTop = 430
      ExplicitWidth = 204
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 472
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
