$sTitleM = "Zoom Meeting"
$sTitleMC = "Meeting Controls"
$xPos = -1000
$yPos = -1000
WinActivate ( $sTitleMC )
Sleep ( 300 )
Send ( "!s" )
;WinMove ( $sTitleM, "", $xPos, $yPos )
Sleep ( 100 )
WinSetState ( $sTitleM, "", @SW_MAXIMIZE )
;MouseClick ( "left", -35, 30 )
;MouseClick ( "left", -35, 30 )
; SEttongs to test at home
MouseClick ( "left", 817, -1038 )
MouseClick ( "left", 817, -962 )
