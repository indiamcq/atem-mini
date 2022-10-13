Opt("WinTitleMatchMode", 2)

WinActivate ( $CmdLine[1] )
WinWaitActive ( $CmdLine[1] )
Send ( $CmdLine[2] )
