object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
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
  object Panel1: TPanel
    Left = 439
    Top = 0
    Width = 185
    Height = 441
    Align = alRight
    Padding.Left = 7
    Padding.Top = 7
    Padding.Right = 7
    Padding.Bottom = 7
    TabOrder = 0
    object QuerySearch: TLabel
      Left = 8
      Top = 337
      Width = 169
      Height = 25
      Margins.Top = 7
      Align = alTop
      Alignment = taCenter
      Caption = ' Searching ...'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clCream
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      GlowSize = 2
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
      ExplicitWidth = 90
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 89
      Width = 169
      Height = 104
      Align = alTop
      Caption = 'Amenities'
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      TabOrder = 0
      object Amenities: TCheckListBox
        Left = 9
        Top = 24
        Width = 151
        Height = 71
        Align = alClient
        CheckBoxPadding = 7
        ItemHeight = 22
        Items.Strings = (
          'restaurant'
          'fuel'
          'parking')
        TabOrder = 0
        OnClick = ckNodeClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 169
      Height = 81
      Align = alTop
      Caption = 'OSM Data'
      TabOrder = 1
      object ckNode: TCheckBox
        Left = 7
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Node'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = ckNodeClick
      end
      object ckWay: TCheckBox
        Left = 7
        Top = 47
        Width = 97
        Height = 17
        Caption = 'Way'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = ckNodeClick
      end
    end
    object ckLayer: TCheckBox
      Left = 8
      Top = 416
      Width = 169
      Height = 17
      Align = alBottom
      Caption = 'OverPassAPI layer'
      TabOrder = 2
      OnClick = ckLayerClick
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 193
      Width = 169
      Height = 144
      Margins.Bottom = 7
      Align = alTop
      Caption = 'Colors'
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      TabOrder = 3
      object btParking: TPanel
        Left = 9
        Top = 90
        Width = 151
        Height = 33
        Align = alTop
        Caption = 'Parking'
        Color = clHighlight
        ParentBackground = False
        TabOrder = 0
        OnClick = btRestaurantClick
      end
      object btFuel: TPanel
        Left = 9
        Top = 57
        Width = 151
        Height = 33
        Align = alTop
        Caption = 'Fuel'
        Color = 41984
        ParentBackground = False
        TabOrder = 1
        OnClick = btRestaurantClick
      end
      object btRestaurant: TPanel
        Left = 9
        Top = 24
        Width = 151
        Height = 33
        Align = alTop
        Caption = 'Restaurant'
        Color = 33023
        ParentBackground = False
        TabOrder = 2
        OnClick = btRestaurantClick
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 439
    Height = 441
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 240
    ExplicitTop = 160
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabSheet1: TTabSheet
      Caption = 'Map'
      object map: TECNativeMap
        Left = 0
        Top = 0
        Width = 431
        Height = 411
        FocusedShapeWhenClicking = True
        FocusedShapeWhenHovering = False
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
        Align = alClient
        ExplicitLeft = 2
        ExplicitTop = -278
        ExplicitWidth = 183
        ExplicitHeight = 441
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Xml Data'
      ImageIndex = 1
      object XmlData: TMemo
        Left = 0
        Top = 0
        Width = 431
        Height = 411
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object ColorDialog: TColorDialog
    Left = 360
    Top = 24
  end
end
