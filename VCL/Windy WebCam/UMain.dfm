object Form13: TForm13
  Left = 0
  Top = 0
  Caption = 'Windy WebCam for TECNativeMap'
  ClientHeight = 453
  ClientWidth = 938
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
    Left = 615
    Top = 3
    Width = 320
    Height = 391
    Align = alRight
    BevelOuter = bvNone
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 0
    object InfoCam: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 312
      Height = 383
      Align = alClient
      ReadOnly = True
      TabOrder = 0
      ExplicitLeft = 7
      ExplicitTop = 7
      ExplicitWidth = 306
      ExplicitHeight = 377
    end
  end
  object PLog: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 400
    Width = 932
    Height = 50
    Align = alBottom
    Padding.Left = 3
    Padding.Top = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 2
    object btWebCams: TButton
      AlignWithMargins = True
      Left = 609
      Top = 7
      Width = 316
      Height = 36
      Align = alRight
      Caption = 'Display Webcams in the visible area'
      TabOrder = 0
      OnClick = btWebCamsClick
    end
    object MLog: TMemo
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 596
      Height = 36
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      WantReturns = False
      WordWrap = False
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 612
    Height = 397
    Cursor = crDefault
    HideShapesWhenZoom = False
    HideShapesWhenWaitingTile = False
    DblClickZoom = True
    MouseWheelZoom = True
    MouseWheelZoomCenter = mwzcMouse
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
    OnShapeClick = mapShapeClick
    Align = alClient
    TabOrder = 1
  end
end
