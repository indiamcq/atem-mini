Opt("WinTitleMatchMode", 2)

WinActivate ( $CmdLine[1] )
While 1
	If WinActive( $CmdLine[1] ) Then
		Send ( $CmdLine[2] )
		Exit
	Else
		Sleep(100)
		WinActivate ( $CmdLine[1] )
	EndIf
WEnd