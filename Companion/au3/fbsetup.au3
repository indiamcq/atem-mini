; Facebook start macro
#include <Date.au3>
#include <MultiMon.au3>

Opt("WinTitleMatchMode", 2)
;$tCur = _Date_Time_GetLocalTime()
;$date = _DateTimeFormat ( $tCur, 2 )
$sDate = @MDAY & " " & _DateToMonth ( @Mon , 2) & " " & @Year
; start FB in browser
ShellExecute("chrome.exe", "https://facebook.com --new-window")
;Run ( "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://facebook.com"
;Run ( "C:\Users\Public\Companion\chrome.cmd" )
WinWaitActive ( "Facebook" )
Sleep ( 4000 )
_MaxOnMonitor("Facebook", 2 )
;WinMove ( "Facebook",-1920,0,1920,1080)
; Click on WRBC link
MouseClick ("left", -1820, 825)
WinWaitActive ("Windsor Road Baptist Church | Facebook" )
Sleep ( 2000 )
; click on live
MouseClick ("left", -750, 705)
WinWaitActive ( "Live Producer" )
Sleep (6000)
; click in the Title box
MouseClick ( "left" , -1820, 725)
Send ( "WRBC Worship " )
Send ( $sDate )
; Move to the subtitle text box
Send ( "{tab 2}" )
Send ( "Sunday Morning Worship" )

