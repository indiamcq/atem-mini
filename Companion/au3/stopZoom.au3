#include <MsgBoxConstants.au3>
WinActivate ( "Zoom" )
WinWaitActive ( "Zoom" )
Send ( "!q" )
Sleep (200)
$aClientSize = WinGetClientSize ( "End Meeting" )
If $aClientSize[1] < 150 then
   ; Host has been assigned
   send ( "{enter}" )
Else
   ; You have not given Host to post-service leader
   send ( "{tab}{enter}" )
EndIf