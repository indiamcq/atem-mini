$sTitle = "Zoom Meeting"
$xPos = -1073
$yPos = -1080
;WinMove ( $sTitle, "", $xPos, $yPos )
;WinSetState ( $sTitle, "", @SW_MAXIMIZE )
WinActivate ( $sTitle )
Sleep ( 300 )
Send ( "!s" )
Send ( "{tab 2}{right 1}" )
Send ( "{enter}" )

