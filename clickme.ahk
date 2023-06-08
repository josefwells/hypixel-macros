#Warn
#SingleInstance force
; SetKeyDelay, -1
SetKeyDelay, 2,5

; SendMode Input
DetectHiddenWindows, on

buttonList := ["a", "s", "d", "w"]

; Walking speed = 4.3B/s * <speed> = X blocks/sec
wheatSpeed := 4  ; 4.3*93 = 4
;pumpkinSpeed = 115  ; 4.3*115 <sideways?>

; Walking time.  96blocks ~ -2 blocks side = 94blocks
plotWidth := 94
wheatTime := 23500 ; (plotWidth / wheatSpeed)*1000

;wheatTime := 20000 ; (plotWidth / wheatSpeed)*1000
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
    randomX := Randomize(-420, 420)
    randomY := Randomize(-69, 69)
    MouseMove, %randomX%, %randomY%, Randomize(20,69), R
}

Warp_garden() {
	; Assume this warp gets us lined up.
	Send, t/
        Send, warp{space}garden
	Send, {enter}
	Sleep, 4069
}

Short_forward() {
	; Move forward a short random time
	randtime := Randomize(169-420)
	Send, {w Down}
	Sleep, randtime
	Send, {w Up}
}

Walk_garden(crop) {
        ; Start clicking
	SendInput, {space Down}
	Loop 16 {
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
		randomBuf := Randomize(269,420) + crop/17.0
		Sleep, randomBuf
		SendInput, {w Up}
		; left
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
	Walk_garden(wheatTime)
}

