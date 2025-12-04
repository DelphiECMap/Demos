object FormGTFS: TFormGTFS
  Left = 0
  Top = 0
  Caption = 'FormGTFS'
  ClientHeight = 532
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Splitter1: TSplitter
    AlignWithMargins = True
    Left = 494
    Top = 32
    Width = 5
    Height = 322
    Align = alRight
    Beveled = True
    ExplicitLeft = 492
    ExplicitTop = 3
    ExplicitHeight = 351
  end
  object pnPageControlGTFS: TPanel
    AlignWithMargins = True
    Left = 503
    Top = 30
    Width = 240
    Height = 326
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PageControlGTFS: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 234
      Height = 320
      ActivePage = TabStations
      Align = alClient
      TabOrder = 0
      OnChange = PageControlGTFSChange
      object TabStations: TTabSheet
        Caption = 'Stations'
        object lbNbrStops: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Caption = 'All stops'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 54
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 135
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Caption = 'Route'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 36
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 189
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Caption = 'Trips on this route'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 114
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 243
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Caption = 'Stops'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 34
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 344
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Caption = 'Shedule'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 49
        end
        object cbLines: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 158
          Width = 220
          Height = 25
          Align = alTop
          AutoComplete = False
          AutoDropDown = True
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbLinesChange
        end
        object cbTrips: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 212
          Width = 220
          Height = 25
          Align = alTop
          Style = csDropDownList
          TabOrder = 1
          OnChange = cbTripsChange
        end
        object lbStops: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 266
          Width = 220
          Height = 72
          Align = alTop
          IntegralHeight = True
          ItemHeight = 17
          TabOrder = 2
          OnClick = lbStopsClick
        end
        object lbHoraire: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 367
          Width = 220
          Height = 0
          Align = alClient
          ItemHeight = 17
          ScrollWidth = 100
          TabOrder = 3
          TabWidth = 10
          OnClick = lbHoraireClick
        end
        object lbAllStops: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 220
          Height = 72
          Style = lbVirtual
          Align = alTop
          IntegralHeight = True
          ItemHeight = 17
          TabOrder = 4
          OnClick = lbAllStopsClick
          OnData = lbAllStopsData
        end
        object SearchStops: TEdit
          AlignWithMargins = True
          Left = 3
          Top = 26
          Width = 220
          Height = 25
          Align = alTop
          CharCase = ecLowerCase
          TabOrder = 5
          OnEnter = SearchStopsEnter
          OnKeyUp = SearchStopsKeyUp
        end
      end
      object TabLines: TTabSheet
        Caption = 'Lines'
        ImageIndex = 2
        object lbLines: TLabel
          Left = 0
          Top = 0
          Width = 226
          Height = 15
          Align = alTop
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 3
        end
        object ckLines: TCheckListBox
          AlignWithMargins = True
          Left = 3
          Top = 18
          Width = 220
          Height = 191
          Align = alClient
          IntegralHeight = True
          ItemHeight = 17
          TabOrder = 0
          OnClick = ckLinesClick
          OnClickCheck = ckLinesClickCheck
        end
        object ckUnCheckAllLines: TButton
          AlignWithMargins = True
          Left = 3
          Top = 260
          Width = 220
          Height = 25
          Align = alBottom
          Caption = 'uncheck all lines'
          TabOrder = 1
          OnClick = ckUnCheckAllLinesClick
        end
        object ckCheckAllLines: TButton
          AlignWithMargins = True
          Left = 3
          Top = 229
          Width = 220
          Height = 25
          Align = alBottom
          Caption = 'Check all'
          TabOrder = 2
          OnClick = ckCheckAllLinesClick
        end
      end
      object TabVehicles: TTabSheet
        Caption = 'Vehicles'
        ImageIndex = 1
        object lbVehicleRoute: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 220
          Height = 17
          Align = alTop
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 4
        end
        object cbVehicles: TComboBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 220
          Height = 25
          Align = alTop
          TabOrder = 0
          OnChange = cbVehiclesChange
        end
        object vehicleShedule: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 220
          Height = 228
          Align = alClient
          ItemHeight = 17
          TabOrder = 1
          TabWidth = 10
          OnClick = vehicleSheduleClick
          ExplicitHeight = 176
        end
      end
    end
  end
  object pnBottom: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 360
    Width = 738
    Height = 169
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object PageControlLogs: TPageControl
      Left = 0
      Top = 0
      Width = 738
      Height = 169
      ActivePage = TabLog
      Align = alClient
      TabOrder = 0
      object TabLog: TTabSheet
        Caption = 'Log'
        object Log: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 724
          Height = 133
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WordWrap = False
        end
      end
      object TabAlert: TTabSheet
        Caption = 'Alert'
        ImageIndex = 1
        object Alert: TMemo
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 724
          Height = 133
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          WordWrap = False
        end
      end
    end
  end
  object cbGTFSDirectory: TComboBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 738
    Height = 23
    Align = alTop
    Style = csDropDownList
    TabOrder = 2
    OnChange = cbGTFSDirectoryChange
  end
  object map: TECNativeMap
    AlignWithMargins = True
    Left = 3
    Top = 32
    Width = 485
    Height = 322
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
    OnMapClick = mapMapClick
    Align = alClient
    TabOrder = 3
  end
end
