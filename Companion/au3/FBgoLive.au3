;WinSetState ( "Google Docs", "", @SW_MAXIMIZE )
$sTitle = "Live Producer"
WinSetState ( $sTitle, "", @SW_MAXIMIZE )
sleep ( 300 )
MouseClick ( "left" , -1700, 965 )
WinSetState ( $sTitle, "", @SW_MINIMIZE )