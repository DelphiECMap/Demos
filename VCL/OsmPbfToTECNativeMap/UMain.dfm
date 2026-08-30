object FormOSMPBFToTECNativeMap: TFormOSMPBFToTECNativeMap
  Left = 0
  Top = 0
  Caption = 
    'OsmPbf To TECNativeMap - Right-click and drag to add an import a' +
    'rea'
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
  object pFilename: TPanel
    AlignWithMargins = True
    Left = 464
    Top = 3
    Width = 157
    Height = 331
    Align = alRight
    TabOrder = 0
    object btOpen: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 149
      Height = 29
      Align = alTop
      Caption = 'Open file...'
      TabOrder = 0
      OnClick = btOpenClick
    end
    object ProgressBar: TProgressBar
      AlignWithMargins = True
      Left = 3
      Top = 280
      Width = 151
      Height = 17
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 1
    end
    object btAbort: TButton
      AlignWithMargins = True
      Left = 4
      Top = 302
      Width = 149
      Height = 25
      Align = alBottom
      Caption = 'Abort'
      Enabled = False
      TabOrder = 2
      OnClick = btAbortClick
    end
    object btCount: TButton
      AlignWithMargins = True
      Left = 4
      Top = 39
      Width = 149
      Height = 25
      Align = alTop
      Caption = 'PBF count'
      Enabled = False
      TabOrder = 3
      OnClick = btCountClick
    end
    object btImportPBF: TButton
      AlignWithMargins = True
      Left = 4
      Top = 70
      Width = 149
      Height = 25
      Align = alTop
      Caption = 'Import BPF'
      Enabled = False
      TabOrder = 4
      OnClick = btImportPBFClick
    end
    object btClearZones: TButton
      AlignWithMargins = True
      Left = 4
      Top = 219
      Width = 149
      Height = 25
      Align = alBottom
      Caption = 'Clear Zones'
      TabOrder = 5
      OnClick = btClearZonesClick
    end
    object btClearMap: TButton
      AlignWithMargins = True
      Left = 4
      Top = 250
      Width = 149
      Height = 25
      Align = alBottom
      Caption = 'Clear Map'
      TabOrder = 6
      OnClick = btClearMapClick
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 340
    Width = 618
    Height = 98
    Align = alBottom
    TabOrder = 1
    object Log: TMemo
      Left = 1
      Top = 1
      Width = 616
      Height = 96
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object map: TECNativeMap
    Left = 0
    Top = 0
    Width = 461
    Height = 337
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
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.pbf'
    Left = 379
    Top = 11
  end
end
