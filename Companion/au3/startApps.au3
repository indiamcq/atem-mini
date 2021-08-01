; start programs macro
#include-Once
#include <Date.au3>
#include <MultiMon.au3>

Opt("WinTitleMatchMode", 2)
; Start Atem Software ControlClick
_startAppPos("atem")

; Start Edge with buttons
_startAppPos("edge")

; Start OBS
_startAppPos("obs")


