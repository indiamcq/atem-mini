$sTitle = "Zoom Meeting"
$sharescreen = 3
WinActivate ( $sTitle )
WinWaitActive( $sTitle )
Sleep ( 300 )
Send ( "!s" )

$contitle = "Select a window or an application that you want to share"
WinWaitActive( $contitle )
Opt("WinTitleMatchMode", 2)
$pos = WinGetPos( $contitle )
$x = ($sharescreen * 250 ) -150
$y = 150

MouseClick("left", $pos[0] + $x, $pos[1] + $y, 2, 0)


