#Warn
#SingleInstance force
; SetKeyDelay, -1
SetKeyDelay, 2,5

; SendMode Input
DetectHiddenWindows, on

buttonList := ["a", "s", "d", "w"]

; Walking speed = 4.3B/s * <speed> = X blocks/sec
wheatSpeed := 4  ; 4.3*93 = 4
pumpkinSpeed = 7.53  ; 4.3*1.75 <sideways?>

; Walking time.  96blocks ~ -2 blocks side = 94blocks
; wheatPlotWidth := 94
; PumpkinPlotWidth := 188

; Walking time pumpin double wide. 188 blocks
;pumpkinTime := 21500 ; (pumplinPlotWidth / pumpkinSpeed )*1000 ; too short
pumpkinTime := 24900 ; (pumplinPlotWidth / pumpkinSpeed )*1000 ; too short

wheatTime := 23500 ; (plotWidth / wheatSpeed)*1000
;wheatTime := 23500 ; (plotWidth / wheatSpeed)*1000 ; too short still?
;wheatTime := 20000 ; (plotWidth / wheatSpeed)*1000 ; wy too short
;wheatTime := 100

; Pause  ; Start the script paused initially

Randomize(min, max) {
    Random, randomNum, %min%, %max%
    return randomNum
}

RandomSleep(min, max) {
	Random, sleepNum, %min%, %max%
	Sleep %sleepNum%
}

Rand_button(buttonList) {
    ; Random button press
    randomButton := buttonList[Randomize(1, buttonList.Length())]
    randomDuration := Randomize(269, 1420)

    SendInput, {%randomButton% down}
    Sleep, %randomDuration%
    SendInput, {%randomButton% up}
}

Rand_click() {
    ; Random click
    Clicks := Randomize(1, 3)
    Loop, %Clicks% {
	    randomClickDuration := Randomize(69, 369)
	    Click, Down Left
        Sleep, %randomClickDuration%
        Click, Up Left
    }
}

Rand_mouse() {
    randomX := Randomize(-69, 69)
    randomY := Randomize(-6, 9)
    MouseMove, %randomX%, %randomY%, Randomize(20,69), R
}

Warp_garden() {
	; Assume this warp gets us lined up.
	Send, t
	randtime := Randomize(69, 169)
	Sleep, randtime
	Send, /
	randtime := Randomize(69, 169)
	Sleep, randtime
        Send, warp{space}garden
	randtime := Randomize(69, 169)
	Sleep, randtime
	Send, {enter}
	randtime := Randomize(169, 269)
	Sleep, randtime
	Send, {Lshift Down}
	Sleep, randtime
        Send, {Lshift Up}
	randtime := Randomize(1420, 2069)
	Sleep, randtime
}

Short_forward() {
	; Move forward a short random time
	randtime := Randomize(169, 420)
	Send, {w Down}
	Sleep, randtime
	Send, {w Up}
}

Walk_garden(crop, rows) {
        ; Start clicking
	SendInput, {space Down}
	Loop % rows {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {d Down}
		Short_forward()
		randomBuf := Randomize(1069,1420) + crop
		Sleep, randomBuf
		SendInput, {d Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/17.0
		Sleep, randomBuf
		SendInput, {w Up}
		; lefts
		SendInput, {space Down}
		SendInput, {a Down}
		Short_forward()
		randomBuf := Randomize(1069,1420) + crop
		Sleep, randomBuf
		SendInput, {a Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/17.0
		Sleep, randomBuf
		SendInput, {w Up}
		; temp pause at the end of loop
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}
		


F6::
SendInput, {space Up}
SendInput, {w Up}
SendInput, {a Up}
SendInput, {s Up}
SendInput, {d Up}
Click, Up Left
Pause
return

; F10::
; MsgBox, 4,, wheatSpeed is %randnum% , 10
; IfMsgBox Timeout
;     MsgBox You didn't press YES or NO within the 10-second period.
; else IfMsgBox No
;     ExitApp

; Goblin loop
F7::
Loop {
  Rand_button(buttonList)
  Rand_click()
  Rand_button(buttonList)
  Rand_click()
  Rand_button(buttonList)

  Rand_mouse()

  loopwait := Randomize(1420, 10420)
  Sleep, %loopwait%
}

; Wheat loop
F8::
Loop {
	Warp_garden()
	Walk_garden(wheatTime, 16)
}

; Pumpkin loop
F9::
Loop {
	Warp_garden()
	Walk_garden(pumpkinTime, 8)
}

^r:: ; press control+r to reload
Reload
return