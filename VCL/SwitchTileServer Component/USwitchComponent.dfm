object FormSwitch: TFormSwitch
  Left = 0
  Top = 0
  Caption = 'SwitchTileServer for TECNativeMap'
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
    AlignWithMargins = True
    Left = 3
    Top = 326
    Width = 618
    Height = 112
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 469
      Height = 112
      Align = alClient
      TabOrder = 0
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 472
      Top = 3
      Width = 143
      Height = 106
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 59
        Width = 36
        Height = 17
        Caption = 'Size : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 0
        Width = 129
        Height = 49
        Margins.Left = 7
        Margins.Top = 0
        Margins.Right = 7
        Margins.Bottom = 7
        Align = alTop
        Caption = 'Colors'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object pnSecondaryColor: TPanel
          AlignWithMargins = True
          Left = 65
          Top = 22
          Width = 58
          Height = 22
          Margins.Left = 0
          Align = alLeft
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          OnClick = pnColorClick
        end
        object pnColor: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 22
          Width = 58
          Height = 22
          Margins.Right = 2
          Align = alLeft
          Color = clBlack
          ParentBackground = False
          TabOrder = 1
          OnClick = pnColorClick
        end
      end
      object cbSize: TComboBox
        Left = 45
        Top = 57
        Width = 92
        Height = 23
        AutoComplete = False
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 1
        Text = 'Medium'
        OnChange = cbSizeChange
        Items.Strings = (
          'Small'
          'Medium'
          'Large')
      end
      object ckVertical: TCheckBox
        AlignWithMargins = True
        Left = 7
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Vertical'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = ckVerticalClick
      end
    end
  end
  object map: TECNativeMap
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 317
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
  object ColorDialog: TColorDialog
    Left = 467
    Top = 267
  end
end
