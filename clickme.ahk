#Warn
#SingleInstance force
; SetKeyDelay, -1

winTitle = jwells@

SendMode Input
DetectHiddenWindows, on

buttonList := ["a", "s", "d", "w"]

; Pause  ; Start the script paused initially

Randomize(min, max) {
    Random, randomNum, %min%, %max%
    return randomNum
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
    randomY := Randomize(-420, 420)
    MouseMove, %randomX%, %randomY%, Randomize(20,69), R
}

F6::
Pause
return

F8::
randnum := Randomize(1,3)
MsgBox, 4,, rand num is %randnum% , 10
IfMsgBox Timeout
    MsgBox You didn't press YES or NO within the 10-second period.
else IfMsgBox No
    ExitApp

F7::
Loop {
  Rand_button(buttonList)
  Rand_click()
  Rand_button(buttonList)
  Rand_click()
  Rand_button(buttonList)

  Rand_mouse()

  ; loopwait := RandomizeTime(1420, 10420)
  ; Sleep, %loopwait%
  Sleep, 1000
}
