object FMultiGraph: TFMultiGraph
  Left = 0
  Top = 0
  Caption = 'Displaying multiple profiles with TECNativeMap'
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
    Left = 352
    Top = 0
    Width = 272
    Height = 441
    Align = alRight
    TabOrder = 0
    object ViewGraphA: TImage
      AlignWithMargins = True
      Left = 4
      Top = 41
      Width = 264
      Height = 125
      Align = alTop
      ExplicitLeft = -4
      ExplicitTop = 0
      ExplicitWidth = 177
    end
    object ViewGraphB: TImage
      AlignWithMargins = True
      Left = 4
      Top = 209
      Width = 264
      Height = 125
      Align = alTop
      ExplicitTop = 4
      ExplicitWidth = 177
    end
    object LabelA: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 264
      Height = 31
      Align = alTop
      BiDiMode = bdLeftToRight
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 6
      ExplicitTop = -6
    end
    object LabelB: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 172
      Width = 264
      Height = 31
      Align = alTop
      BiDiMode = bdLeftToRight
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = -4
      ExplicitTop = 159
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 352
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
    ExplicitLeft = 152
    ExplicitTop = 168
    ExplicitWidth = 256
    ExplicitHeight = 256
  end
end
