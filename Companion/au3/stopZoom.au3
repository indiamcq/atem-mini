#include <MsgBoxConstants.au3>
WinActivate ( "Zoom" )
WinWaitActive ( "Zoom" )
Send ( "!q" )
Sleep (200)
$aClientSize = WinGetClientSize ( "End Meeting or Leave Meeting?")
If $aClientSize[1] < 150 then
   ;MsgBox($MB_SYSTEMMODAL, "", "WinActive" & @CRLF & $aClientSize[1])
   send ( "{enter}" )
Else
   ;MsgBox($MB_SYSTEMMODAL, "", "WinActive" & @CRLF & "You have not given Host to post-service leader"  & $aClientSize[1])
   send ( "{tab}{enter}" )
EndIf