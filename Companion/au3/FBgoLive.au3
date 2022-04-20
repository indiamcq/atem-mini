; Start/stop Facebook Go Live button
$sTitle = "Live Producer"
; Set window relative position of button on 1920x1080 screen
$x = 160
$y = 1030
Opt("WinTitleMatchMode", 2)
WinSetState ( $sTitle, "", @SW_MAXIMIZE )
WinActivate ( $sTitle )
WinWaitActive( $sTitle )
$pos = WinGetPos( $sTitle )

MouseClick("left", $pos[0] + $x, $pos[1] + $y, 1, 0)

WinSetState ( $sTitle, "", @SW_MINIMIZE )