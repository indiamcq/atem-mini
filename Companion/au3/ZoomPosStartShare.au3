; Position Zoom Meeting window
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

WinActivate ( "Zoom Meeting" )
Sleep ( 300 )
Send ( "!s" )
Send ( "{tab 2}{right 1}" )
Send ( "{enter}" )