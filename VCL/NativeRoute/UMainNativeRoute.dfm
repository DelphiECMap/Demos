�
 TFDEMONATIVEROUTE 0  TPF0TFDemoNativeRouteFDemoNativeRouteLeftbTop� Caption5   DemoNativeRoute Turn by turn © ESCOT-SEP Christophe ClientHeight�ClientWidth^Color	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style PositionpoScreenCenterOnCreate
FormCreate
TextHeight TPanelPanel1Left Top Width^Height)AlignalTop
BevelOuterbvNoneTabOrder 
DesignSize^)  	TComboBoxroutesLeftTopWidthLHeightStylecsDropDownListAnchorsakLeftakTopakRight TabOrder OnClickroutesChange   TPanelPanelStartEndLeft Top)Width^Height<AlignalTop
BevelOuterbvNoneTabOrder
DesignSize^<  TLabellbstartLeftTop
WidthHeightCaptionFrom  TLabelLabel1Left�Top
WidthHeightCaptionto  	TComboBoxcbStartLeft*TopWidthXHeightTabOrder OnChangecbStartChange  	TComboBoxcbDestinationLeft�TopWidth2HeightAnchorsakLeftakRight TabOrderOnChangecbStartChange  TPanelPanel2Left�Top WidthuHeight<AlignalRight
BevelOuterbvNoneTabOrder
DesignSizeu<  TButtonRouteAddLeft
TopWidthdHeightAnchors Caption	Add routeEnabledFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontTabOrder OnClickRouteAddClick   TRadioButton	rbDrivingLeftTop$WidthPHeightCaptionDrivingChecked	TabOrderTabStop	OnClickrbDrivingClick  TRadioButton	rbBicycleLeftMTop%WidthPHeightCaption	BicyclingTabOrderOnClickrbDrivingClick  TRadioButton	rbWalkingLeft� Top%WidthPHeightCaptionWalkingTabOrderOnClickrbDrivingClick  	TCheckBoxFollowLeftTop%Width� HeightCaptionfollow the vehicleChecked	State	cbCheckedTabOrder   TPanelPanel7Left TopeWidth^Height�AlignalClient
BevelOuterbvNoneCaptionPanel7TabOrder  TPanelNextInstructionLeft Top�Width^Height(Margins.Bottom
AlignalBottom
BevelOuterbvNoneFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style Padding.LeftPadding.TopPadding.RightPadding.Bottom
ParentFontTabOrder TPanelNextKMLeft�TopWidthpHeight"AlignalRight
BevelOuterbvNoneColor	clBtnTextFont.CharsetANSI_CHARSET
Font.ColorclHighlightTextFont.Height�	Font.NameTahoma
Font.StylefsBold ParentBackground
ParentFontTabOrder   TPanelInstructionsLeft� TopWidth2Height"Margins.TopMargins.BottomAlignalClient
BevelOuterbvNoneCtl3DParentCtl3DTabOrder  TPanelinfosLeftTopWidth� Height"Margins.TopMargins.BottomAlignalLeft
BevelOuterbvNoneCtl3DParentCtl3DTabOrder   TListBox	itineraryAlignWithMargins	LeftTop8WidthXHeightrStylelbOwnerDrawFixedAutoCompleteAlignalBottomExtendedSelect
ItemHeightTabOrderOnClickitineraryClick  TECNativeMapmapLeft TopeWidth^Height�HideShapesWhenZoomHideShapesWhenWaitingTileDblClickZoom	MouseWheelZoom	latitude 0H����@	longitude  @�t��?ReticleReticleColorclBlackZoomScaleFactor NumericalZoom       �@DragRectdrNone	Draggable	OnlyOneOpenInfoWindowWaitingForDestructionActive	NbrThreadTilettFourAlignalClientTabOrder  TColorDialogColordialogLeft~Top%   