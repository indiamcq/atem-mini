#include-Once
#include<Array.au3> ;added to fix the display order
Global $ini = "C:\Users\Public\Companion\video.ini"
Global $__MonitorList[1][5]
$__MonitorList[0][0] = 0

; Just for testing
;~ _ArrayDisplay(_GetMonitors()) ;added as another way to see the info
;_ShowMonitorInfo()

;==================================================================================================
; Function Name:   _ShowMonitorInfo()
; Description::    Show the info in $__MonitorList in a msgbox (line 0 is count of monitors and entire Desktop size)
; Parameter(s):    n/a
; Return Value(s): n/a
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _ShowMonitorInfo()
    If $__MonitorList[0][0] == 0 Then
        _GetMonitors()
    EndIf
    Local $Msg = ""
    Local $i = 0

    For $i = 0 To $__MonitorList[0][0]
        $Msg &= $i & " - hnd:" & $__MonitorList[$i][0] ;added for information
        $Msg &= ", L:" & $__MonitorList[$i][1] & ", T:" & $__MonitorList[$i][2]
        $Msg &= ", R:" & $__MonitorList[$i][3] & ", B:" & $__MonitorList[$i][4]
        If $i < $__MonitorList[0][0] Then $Msg &= @CRLF
    Next
    MsgBox(0, $__MonitorList[0][0] & " Monitors: ", $Msg)
EndFunc   ;==>_ShowMonitorInfo

;==================================================================================================
; Function Name:   _MaxOnMonitor($Title[, $Text = ''[, $Monitor = -1]])
; Description::    Maximize a window on a specific monitor (or the monitor the mouse is on)
; Parameter(s):    $Title   The title of the window to Move/Maximize
;     optional:    $Text    The text of the window to Move/Maximize
;     optional:    $Monitor The monitor to move to (1..NumMonitors) defaults to monitor mouse is on
; Note:            Should probably have specified return/error codes but haven't put them in yet
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _MaxOnMonitor($Title, $Text = '', $Monitor = -1)
    _CenterOnMonitor($Title, $Text, $Monitor)
    WinSetState($Title, $Text, @SW_MAXIMIZE)
EndFunc   ;==>_MaxOnMonitor

;==================================================================================================
; Function Name:   _CenterOnMonitor($Title[, $Text = ''[, $Monitor = -1]])
; Description::    Center a window on a specific monitor (or the monitor the mouse is on)
; Parameter(s):    $Title   The title of the window to Move/Maximize
;     optional:    $Text    The text of the window to Move/Maximize
;     optional:    $Monitor The monitor to move to (1..NumMonitors) defaults to monitor mouse is on
; Note:            Should probably have specified return/error codes but haven't put them in yet
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _CenterOnMonitor($Title, $Text = '', $Monitor = -1)
    $hWindow = WinGetHandle($Title, $Text)
    If Not @error Then
        If $Monitor == -1 Then
            $Monitor = _GetMonitorFromPoint()
        ElseIf $__MonitorList[0][0] == 0 Then
            _GetMonitors()
        EndIf
        If ($Monitor > 0) And ($Monitor <= $__MonitorList[0][0]) Then
            ; Restore the window if necessary
            Local $WinState = WinGetState($hWindow)
            If BitAND($WinState, 16) Or BitAND($WinState, 32) Then
                WinSetState($hWindow, '', @SW_RESTORE)
            EndIf
            Local $WinSize = WinGetPos($hWindow)
            Local $x = Int(($__MonitorList[$Monitor][3] - $__MonitorList[$Monitor][1] - $WinSize[2]) / 2) + $__MonitorList[$Monitor][1]
            Local $y = Int(($__MonitorList[$Monitor][4] - $__MonitorList[$Monitor][2] - $WinSize[3]) / 2) + $__MonitorList[$Monitor][2]
            WinMove($hWindow, '', $x, $y)
        EndIf
    EndIf
EndFunc   ;==>_CenterOnMonitor

;==================================================================================================
; Function Name:   _GetMonitorFromPoint([$XorPoint = -654321[, $Y = 0]])
; Description::    Get a monitor number from an x/y pos or the current mouse position
; Parameter(s):
;     optional:    $XorPoint X Position or Array with X/Y as items 0,1 (ie from MouseGetPos())
;     optional:    $Y        Y Position
; Note:            Should probably have specified return/error codes but haven't put them in yet,
;                  and better checking should be done on passed variables.
;                  Used to use MonitorFromPoint DLL call, but it didn't seem to always work.
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _GetMonitorFromPoint($XorPoint = 0, $y = 0)
    If @NumParams = 0 then
        local $MousePos = MouseGetPos()
        Local $myX = $MousePos[0]
        Local $myY = $MousePos[1]
    Elseif ( @NumParams = 1 ) and IsArray($XorPoint) Then
        Local $myX = $XorPoint[0]
        Local $myY = $XorPoint[1]
    Else
        Local $myX = $XorPoint
        Local $myY = $y
    EndIf
    If $__MonitorList[0][0] == 0 Then
        _GetMonitors()
    EndIf
    Local $i = 0
    Local $Monitor = 0
    For $i = 1 To $__MonitorList[0][0]
        If ($myX >= $__MonitorList[$i][1]) _
                And ($myX < $__MonitorList[$i][3]) _
                And ($myY >= $__MonitorList[$i][2]) _
                And ($myY < $__MonitorList[$i][4]) Then $Monitor = $i
    Next
    Return $Monitor
EndFunc   ;==>_GetMonitorFromPoint

;==================================================================================================
; Function Name:   _GetMonitors()
; Description::    Load monitor positions
; Parameter(s):    n/a
; Return Value(s): 2D Array of Monitors
;                       [0][0] = Number of Monitors
;                       [i][0] = HMONITOR handle of this monitor.
;                       [i][1] = Left Position of Monitor
;                       [i][2] = Top Position of Monitor
;                       [i][3] = Right Position of Monitor
;                       [i][4] = Bottom Position of Monitor
; Note:            [0][1..4] are set to Left,Top,Right,Bottom of entire screen
;                  hMonitor is returned in [i][0], but no longer used by these routines.
;                  Also sets $__MonitorList global variable (for other subs to use)
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _GetMonitors()
    $__MonitorList[0][0] = 0  ;  Added so that the global array is reset if this is called multiple times
    Local $handle = DllCallbackRegister("_MonitorEnumProc", "int", "hwnd;hwnd;ptr;lparam")
    DllCall("user32.dll", "int", "EnumDisplayMonitors", "hwnd", 0, "ptr", 0, "ptr", DllCallbackGetPtr($handle), "lparam", 0)
    DllCallbackFree($handle)
    Local $i = 0
    For $i = 1 To $__MonitorList[0][0]
        If $__MonitorList[$i][1] < $__MonitorList[0][1] Then $__MonitorList[0][1] = $__MonitorList[$i][1]
        If $__MonitorList[$i][2] < $__MonitorList[0][2] Then $__MonitorList[0][2] = $__MonitorList[$i][2]
        If $__MonitorList[$i][3] > $__MonitorList[0][3] Then $__MonitorList[0][3] = $__MonitorList[$i][3]
        If $__MonitorList[$i][4] > $__MonitorList[0][4] Then $__MonitorList[0][4] = $__MonitorList[$i][4]
    Next

    _ArraySort($__MonitorList, 0, 1, 0, 0, 0) ;added to sort it by the first column (hMonitor) so that they line up in physical order like Display Settings-->Rearrange Displays
    Return $__MonitorList
EndFunc   ;==>_GetMonitors

;==================================================================================================
; Function Name:   _MonitorEnumProc($hMonitor, $hDC, $lRect, $lParam)
; Description::    Enum Callback Function for EnumDisplayMonitors in _GetMonitors
; Author(s):       xrxca (autoit@forums.xrx.ca)
;==================================================================================================
Func _MonitorEnumProc($hMonitor, $hDC, $lRect, $lParam)
    Local $Rect = DllStructCreate("int left;int top;int right;int bottom", $lRect)
    $__MonitorList[0][0] += 1
    ReDim $__MonitorList[$__MonitorList[0][0] + 1][5]
    $__MonitorList[$__MonitorList[0][0]][0] = $hMonitor
    $__MonitorList[$__MonitorList[0][0]][1] = DllStructGetData($Rect, "left")
    $__MonitorList[$__MonitorList[0][0]][2] = DllStructGetData($Rect, "top")
    $__MonitorList[$__MonitorList[0][0]][3] = DllStructGetData($Rect, "right")
    $__MonitorList[$__MonitorList[0][0]][4] = DllStructGetData($Rect, "bottom")
    Return 1 ; Return 1 to continue enumeration
EndFunc   ;==>_MonitorEnumProc


;==================================================================================================
; Function Name:   _MouseMonClick($Monitor = -1, $x = 0 , $y = 0 )
; Description::    Click mouse on monitor using positions relative to monitor
; Parameter(s):    Monitor number to click on, x psoition relative to Mon, y pos relative to Mon.
; Return Value(s): Absolute x position
; Note:            This is useful when test monitor configuration is different to production implimentation.
; Author(s):       indiamcq (indiamcq@yahoo.com.au)
;==================================================================================================
Func _MouseMonClick($monitor = -1, $x = 0 , $y = 0 )
    If $__MonitorList[0][0] == 0 Then
        _GetMonitors()
	 EndIf
	 $xoffset = $__MonitorList[$monitor][1]
	 $yoffset = $__MonitorList[$monitor][2]
	 $xclick = $x + $xoffset
	 $yclick = $y + $yoffset
	 MouseClick ( "left", $xclick, $yclick )
  EndFunc

;==================================================================================================
; Function Name:   _WinMonMove($monitor , $x, $y [, $h,$w])
; Description::    Move window to specified monitor and position relative to Monitor, then size window.
; Parameter(s):    Monitor number to click on, x psoition relative to Mon, y pos relative to Mon.
; Return Value(s): Absolute x position
; Note:            This is useful when test monitor configuration is different to production implimentation.
; Author(s):       indiamcq (indiamcq@yahoo.com.au)
;==================================================================================================
Func _WinMonMove( $Title, $Text , $Monitor, $x, $y, $w = 0, $h = 0)
     If $__MonitorList[0][0] == 0 Then
        _GetMonitors()
	 EndIf
	 $xoffset = $__MonitorList[$monitor][1]
	 $yoffset = $__MonitorList[$monitor][2]
     $xpos = $x + $xoffset
	 $ypos = $y + $yoffset
	 $winmoved = 0
	 _CenterOnMonitor($Title, $Text, $Monitor)
	 While $winmoved = 0

		If $h == 0 Then
			$winmoved = WinMove ( $Title, $Text, $xpos, $ypos)
		 Else
			$winmoved = WinMove ( $Title, $Text, $xpos, $ypos, $w ,$h)
		 EndIf
		 Sleep( 100 )
	  WEnd
	  WinActivate ( $Title ) ; Not needed  but so you can see it arrived in the right position.
	  Return 1
  EndFunc

Func _winMonRelPos( $Title )
   Local $aPos = WinGetPos($Title)
   Local $msg = ""
   $monitor = _GetMonitorFromPoint($aPos[0], $aPos[1])
   	 $xoffset = $__MonitorList[$monitor][1]
	 $yoffset = $__MonitorList[$monitor][2]
     $xpos = $aPos[0] - $xoffset
	 $ypos = $aPos[1] - $yoffset
	 $Msg &= "Monitor: " & $monitor & @CRLF
	 $Msg &= "x pos: " & $xpos & "  y Pos: " & $ypos & @CRLF
	 $Msg &= "x absolute: " & $apos[0] & "  y absolute: " & $apos[1] & "   " & $apos[2] & "   " & $apos[3]
	 MsgBox(0, "Monitor Relative Position for " & $Title, $msg)
  EndFunc

Func _getPosSize( $section )

   $a0 = IniRead ( $ini, $section , "exe" , "Notepad")
   $a1 = IniRead ( $ini, $section , "title" , "")
   $a2 = IniRead ( $ini, $section , "text" , "")
   $a3 = IniRead ( $ini, $section , "scr" , "")
   $a4 = IniRead ( $ini, $section , "x" , "0")
   $a5= IniRead ( $ini, $section , "y" , "0")
   $a6= IniRead ( $ini, $section , "height" , "0")
   $a7 = IniRead ( $ini, $section , "width" , "0")
   local $array[8] = [ $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7]
   Return $array
EndFunc

Func _startAppPos( $section )
   local $winp[8]
   $winp = _getPosSize( $section)
   if NOT WinExists ( $winp[1] ) Then
	  ShellExecute ( $winp[0] , IniRead ( $ini, $section , "param" , ""))
   EndIf
   Sleep(IniRead ( $ini, $section , "sleep" , "Notepad"))
   if $winp[4] <> Null then
	  _winMonMove( $winp[1],$winp[2],$winp[3],$winp[4],$winp[5],$winp[6],$winp[7] )
   EndIf
EndFunc

Func _startPos( $section )
   $winp = _getPosSize( $section)
   $cpos = WinGetPos (  $winp[1] )
   While @error <> 0
	  SetError ( 0 )
	  While not WinExists( $winp[1] )
		 if NOT WinExists ( $winp[1] ) Then
			ShellExecute ( $winp[0] , IniRead ( $ini, $section , "param" , ""))
		 EndIf
		 Sleep (500)
	  WEnd
	  $cpos = WinGetPos (  $winp[1] )
	  While $cpos[0] <> $winp[4]
		 _winmonmove( $winp[1],$winp[2],$winp[3],$winp[4],$winp[5],$winp[6],$winp[7] )
		 Sleep (500)
	  WEnd
	  $cpos = WinGetPos (  $winp[1] )
   WEnd
EndFunc