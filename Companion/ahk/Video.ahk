; Sample Color AutoHotKey file test edition.
; for use with simplekeys.ahk and KeysOff.ahk
;
; Written by Ian McQuay
; 2014-Jun-26
; Revised by IM 2013-10-12
;
; Set the menu icon
;menu tray, Icon, p.ico

; The following two lines are essential.
startScript = %A_ScriptName%	; This line is required at the start of a simplekeys script file.
#include SimpleKeys.ahk	; This line is required at the start of a simplekeys script file.
;  This ends the shell script.

^+a::
SetTitleMatchMode, 2
; Start Atem, Edge, OBS
; Start Atem
run, "C:\Program Files (x86)\Blackmagic Design\Blackmagic ATEM Switchers\ATEM Software Control\ATEM Software Control.exe"
Sleep, 2000
posx := calcPos(544,"x","c")
posy := calcPos(0,"y","c")
WinMove, Atem, , posx , posy, 1376, 1057

; Start Edge
run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Sleep, 2000
posx := calcPos(0,"x","c")
posy := calcPos(0,"y","c")
WinMove, Microsoft Edge, , posx , posy, 660, 1040
run, "C:\Users\mcquayi\Desktop\Video\OBS Studio (64bit).lnk"
return

^+o::
; Start OBS
run, "C:\Users\mcquayi\Desktop\Video\OBS Studio (64bit).lnk"
;Sleep, 2000
; Numbers for WRBC:  -440, 0, 520, 600
; Numbers for testing: 533, -1080, 520, 600
;posx := calcPos(1400,"x","l")
;posy := calcPos(0,"y","l")
;WinMove, OBS, , posx , posy, 536, 600
return

^+z::
SetTitleMatchMode, 2
; Start Zoom and enter username but not password
run, "C:\Users\mcquayi\AppData\Roaming\Zoom\bin\Zoom.exe"
Sleep, 2000
WinActivate , Zoom
Send, {tab 2}{enter}
Send, mark@windsorroad.org.au{tab}
return

^+f::
; Start Chrome and Facebook
SetTitleMatchMode, 2
; Start facebook
run, https://facebook.com
WinWaitActive , Facebook
Sleep, 4000
; Position FB left screen and Maximize
posx := calcPos(1,"x","l")
posy := calcPos(1,"y","l")
WinMove, Facebook, , posx , posy, 1920, 1080

; Click on the Windsor road FB link
;Testing numbers laptop screen: 100, 825
posx := calcPos(100,"x","l")
posy := calcPos(825,"y","l")
MouseClick, left, posx , posy
WinWaitActive , Windsor Road Baptist Church | Facebook
Sleep, 2000

; Click on the Live button 
posx := calcPos(1170,"x","l")
posy := calcPos(705,"y","l")
MouseClick, left, posx , posy
WinWaitActive , Live Producer
Sleep, 6000

; Click in the Title text box of the Live page
posx := calcPos(50,"x","l")
posy := calcPos(735,"y","l")
MouseClick, left, posx , posy
FormatTime, DateVar, , d MMMM yyyy
send, WRBC Worship %DateVar%
; Move to the subtitle text box
send, {tab 2}
send, Sunday Morning Worship
return


^+c::
; test calPos function
SetTitleMatchMode, 2
posx := calcPos(100,"x","c")
posy := calcPos(200,"y","c")
;msgbox, %posx% "   - posy"
WinMove, Notepad, , posx , posy
return

^+l::
; test calPos function
SetTitleMatchMode, 2
posx := calcPos(100,"x","l")
posy := calcPos(200,"y","l")
;msgbox, %posx% "   - posy"
WinMove, Notepad, , posx , posy
return

^+6::
; test calPos function r
SetTitleMatchMode, 2
posx := calcPos(100,"x","r")
posy := calcPos(200,"y","r")
;msgbox, %posx% "   - posy"
WinMove, Notepad, , posx , posy, 235 , 1040
return

^+s::
; Open Chat Alt H, Participants Alt U, Open Share Alt s
WinActivate, Zoom Meeting
WinWait, Zoom Meeting
;sleep, 500
; Start Chat
send, !h   ; chat
WinWait, Chat
sleep, 500
posx := calcPos(1600,"x")
posy := calcPos(0,"y")
WinMove, Chat, posx , posy, 320, 600
WinMove, Chat, posx , posy, 320, 600

; Start Participants
send, !u ; Participants
WinWait, Participants
posx := calcPos(965,"x","l")
posy := calcPos(0,"y","l")
WinMove, Participants, posx , posy, 400, 1040
WinMove, Participants, posx , posy, 400, 1040

; Start Share screen
send, !s  ; Share
sleep, 500
; screen 1 600 360
; screen 2 850 360
; screen 3 1070 360
;posx := calcPos(600,"x","l") ; Click on Screen one
;posy := calcPos(360,"y","l")
;MouseClick, left, posx , posy
send, {tab 2}
send, {right}{enter} ; move to screen two


return

^+q::
WinActivate, Zoom Meeting
WinWait, Zoom Meeting
send, !q
sleep, 500
WinGetPos , , , , Height, End Meeting
if (Height < 150) {
    send, {enter}
} else {
    send, {tab}{enter}
}
return

^+r::
; Swap to remote Zoom window
WinActivate, Meeting Controls
WinWait, Meeting Controls
sleep, 300
send, !s
sleep, 200
WinMaximize , Zoom Meeting
sleep, 300
posx := calcPos(1880,"x","l")
posy := calcPos(50,"y","l")
MouseMove, posx , posy
MouseClick, left, posx , posy
sleep, 200
posx := calcPos(1880,"x","l")
posy := calcPos(160,"y","l")
MouseMove, posx , posy
MouseClick, left, posx , posy
return

^+m::
CoordMode, Mouse , Screen
posx := calcPos(1880,"x","l")
posy := calcPos(160,"y","l")
run, "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "D:\All-SIL-Publishing\github-SILAsiaPub\atem-mini\trunk\Companion\au3\mouseLeftScr.au3"
MouseMove, posx , posy,
;DllCall("SetCursorPos", "int", posx, "int", posy)
;MouseClick, left
return


; calculate position function
calcPos(osp,axis="x",screen="c")
{
	if axis = "y"
	{
		switch screen
		{
			case "c": scroffset := 0
			case "l": scroffset := 0
			case "r": scroffset := 0
		}
		switch screen
		{
			case "c": testoffset := 0
			case "l": testoffset := 0 ; Left top screen -1080
			case "r": testoffset := 0
		}
	} else
	{
		switch screen
		{
			case "c": scroffset := 0
			case "l": scroffset := -1920
			case "r": scroffset := 1920
		}
		switch screen
		{
			case "c": testoffset := 0
			case "l": testoffset := 0 ;Left to screen 853
			case "r": testoffset := 0	; Right top screen -1066
		}
	}
	return osp + scroffset + testoffset
	;send, %pos%
}