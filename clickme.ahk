#Warn
#SingleInstance force
; SetKeyDelay, -1
SetKeyDelay, 2,5

; SendMode Input
DetectHiddenWindows, on

buttonList := ["a", "s", "d", "w"]


; Superfarm https://www.youtube.com/watch?v=KmY4CN1Wyy0

; Walking speed = 4.3B/s * <speed> = X blocks/sec
; wart/carrot/potato/wheat = 4.3 * .93 = 3.999 ~4

; pumpkin/melon := 7.53  ; 4.3*1.75 <sideways?>
; caneSpeed := 10 ; 4.3*2.33 = 10
; cactusSpeed := 17.2 ; 4.3* 4.64 = 19.952
; cocoaSpeed := 6.665   ; 4.3* 1.55 = 6.665
; gourdSpeed := ; 4.3* 1.55 = 6.665

; blockwidth = superfarm 5 plots * 96 blocks = 480
; ( blockwidth / speed ) * 1000
superTime := 120000 ; 120s * 1000
caneTime := 48000 ; (plotWidth*5 / caneSpeed)*1000
cactusTime := 23900 ; (480/19.952) * 1000
cocoaTime := 72018 ; (480/6.665) * 1000
gourdTime := 72018 ; (480/6.665) * 1000


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

Short_backward() {
	; Move forward a short random time
	randtime := Randomize(169, 420)
	Send, {s Down}
	Sleep, randtime
	Send, {s Up}
}

Reverse_Direction(direction) {
	if (direction == "a") {
		return "d"
	}
	else if (direction == "d") {
		return "a"
	}
	else if (direction == "w") {
		return "s"
	}
	else if (direction == "s") {
		return "w"
	}
	else {
		return "space"
	}
}

Swap_Back_Left(direction) {
	if (direction == "a") {
		return "s"
	}
	else {
		return "a"
	}
}

Cactus_backward() {
	; Move backward for cactus speeds
	randtime := Randomize(269, 369)
	Send, {s Down}
	Sleep, randtime
	Send, {s Up}
}

Gourd_forward() {
	randtime := Randomize(1869, 2069)
	Send, {w Down}
	Sleep, randtime
	Send, {w Up}
}

Cocoa_right() {
	; Move forward for cactus speeds
	randtime := Randomize(369, 420)
	Send, {d Down}
	Sleep, randtime
	Send, {d Up}
}

Walk_WWPC(dir) {
	; Start clicking
	global superTime
	SendInput, {space Down}
	Loop % 3 {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randomBuf := Randomize(69,420) + superTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		dir := Reverse_Direction(dir)
		if (A_Index == 3)
			break ; finish loop before we walk back
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,420) + superTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

Walk_Cane(dir) {
	; Start clicking
	global caneTime
	SendInput, {space Down}
	Loop % 5 {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randomBuf := Randomize(69,420) + caneTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		dir := Swap_Back_Left(dir)
		if (A_Index == 5)
			break ; finish loop before we walk back
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,420) + caneTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		dir := Swap_Back_Left(dir)
		SendInput, {space Down}
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

Walk_Cactus(dir) {
	; Start clicking
	global cactusTime
	SendInput, {space Down}
	Loop % 10 {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randomBuf := Randomize(69,369) + cactusTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Cactus_backward()
		dir := Reverse_Direction(dir)
		if (A_Index == 10)
			break ; finish loop before we walk back
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,369) + cactusTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Cactus_backward()
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

Walk_Cocoa(dir) {
	; Start clicking
	global cocoaTime
	SendInput, {space Down}
	Loop % 8 {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start forward
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randomBuf := Randomize(69,420) + cocoaTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Cocoa_Right()
                ; Start Backward
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,420) + cocoaTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Cocoa_Right()
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

Walk_Gourds(dir) {
	; Start clicking
	global gourdTime
	SendInput, {space Down}
	Loop % 5 {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randomBuf := Randomize(69,420) + gourdTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		if (A_Index == 5)
			break ; finish loop before we walk back
		Gourd_forward()
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,420) + gourdTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Gourd_forward()
		dir := Reverse_Direction(dir)
		SendInput, {space Down}
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

;;;
;;;  Actual hotkeys are below
;;;


; Pause/unpause.  Timers still run, but nothing else
; so if you pause, you can move to the end of your current row
; line up, and unpause, pickign up where you left off.
; This is harder in the "superfarm" because of the cramped quarters.
F6::
SendInput, {space Up}
SendInput, {w Up}
SendInput, {a Up}
SendInput, {s Up}
SendInput, {d Up}
Click, Up Left
Pause,, 1
return

; Goblin loop; pretty crappy, prolly get you banned
; and makes squat for money.
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

; Cactus loop
F8::
Loop {
	Warp_garden()
	Walk_Cactus("d")
}

; Cane Loop
F9::
Loop {
	Warp_garden()
	Walk_Cane("s")
}

; Gourd Loop
F10::
Loop {
	Warp_garden()
	Walk_Gourds("a")
}

; Cocoa Loop   (Ctrl-t)
^t::
Loop {
	Warp_garden()
	Walk_Cocoa("w")
}

; Reload script.  If things go bad, pause(F6) and reload(Ctrl-r)
^r:: ; press control+r to reload
Reload
return

; These last ones are super-farm (carrot, potato, wheat, wart) since they
; are all the same speed and basically the same layout, but left or right facing
; easy to remember because F11, the 1 looks like an l, so that one goes left first.

; Left Long Loop ; for superfarm where you start off going left.
F11::
Loop {
	Warp_garden()
	Walk_WWPC("a")
}

; Right Long Loop ; for superfarm where you start off going right.
F12::
Loop {
	Warp_garden()
	Walk_WWPC("d")
}

