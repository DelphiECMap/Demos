object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'OpenWeather for TECNativeMap '#169' ESCOT-SEP Christophe'
  ClientHeight = 533
  ClientWidth = 668
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
    Width = 668
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object route: TButton
      AlignWithMargins = True
      Left = 537
      Top = 3
      Width = 124
      Height = 35
      Margins.Right = 7
      Align = alRight
      Caption = 'Calculate the route'
      TabOrder = 0
      OnClick = routeClick
      ExplicitLeft = 536
      ExplicitTop = 4
      ExplicitHeight = 33
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 534
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = Panel3Resize
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 532
      ExplicitHeight = 39
      object rend: TEdit
        AlignWithMargins = True
        Left = 263
        Top = 10
        Width = 268
        Height = 21
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alRight
        TabOrder = 0
        Text = 'end-route'
        ExplicitLeft = 261
      end
      object start: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 10
        Width = 252
        Height = 21
        Margins.Top = 10
        Margins.Bottom = 10
        Align = alLeft
        TabOrder = 1
        Text = 'start-route'
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 424
    Width = 668
    Height = 109
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 660
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 
        'Double click on the map to get the weather, Right click + drag t' +
        'o select an area'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 493
    end
    object weatherMemo: TMemo
      Left = 1
      Top = 21
      Width = 666
      Height = 87
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 92
    Width = 668
    Height = 332
    Cursor = crDefault
    HideShapesWhenZoom = False
    HideShapesWhenWaitingTile = False
    DblClickZoom = False
    MouseWheelZoom = True
    latitude = 43.232951000000000000
    longitude = 0.078081999999994910
    Reticle = False
    ReticleColor = clBlack
    ZoomScaleFactor = 0
    NumericalZoom = 14.000000000000000000
    DragRect = drSelect
    Draggable = True
    OnlyOneOpenInfoWindow = False
    WaitingForDestruction = False
    Active = True
    NbrThreadTile = ttFour
    OnMapSelectRect = mapMapSelectRect
    OnMapDblClick = mapMapDblClick
    Align = alClient
    TabOrder = 2
    ExplicitTop = 104
    ExplicitHeight = 320
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 44
    Width = 655
    Height = 45
    Margins.Left = 10
    Align = alTop
    Caption = 'Departure date'
    TabOrder = 3
    ExplicitLeft = 3
    ExplicitWidth = 662
    object rbNow: TRadioButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 49
      Height = 22
      Align = alLeft
      Caption = 'Now'
      Checked = True
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 24
      ExplicitTop = 17
      ExplicitHeight = 17
    end
    object rbTomorrow: TRadioButton
      AlignWithMargins = True
      Left = 60
      Top = 18
      Width = 78
      Height = 22
      Align = alLeft
      Caption = 'Tomorrow'
      TabOrder = 1
      ExplicitLeft = 51
      ExplicitTop = 15
      ExplicitHeight = 28
    end
    object rbATomorrow: TRadioButton
      AlignWithMargins = True
      Left = 144
      Top = 18
      Width = 113
      Height = 22
      Align = alLeft
      Caption = 'After tomorrow'
      TabOrder = 2
      ExplicitLeft = 272
      ExplicitTop = 16
      ExplicitHeight = 17
    end
  end
end
