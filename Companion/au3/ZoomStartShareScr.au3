#include-Once
#include <Date.au3>
#include <MultiMon.au3>
Opt("WinTitleMatchMode", 2)
local $winp[0] = 0

$winp  = _getPosSize( "chat" )
WinActivate( "Zoom Meeting" )
Sleep(500)
WinWaitActive ( "Zoom Meeting" )
Send ( "!h" )
_winMonMove( $winp[1],$winp[2],$winp[3],$winp[4],$winp[5],$winp[6])


$winp  = _getPosSize( "Participants" )
WinActivate( "Zoom Meeting" )
Sleep(500)
WinWaitActive ( "Zoom Meeting" )
Send ( "!u" )
_winMonMove( $winp[1],$winp[2],$winp[3],$winp[4],$winp[5],$winp[6])

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






