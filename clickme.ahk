#Warn
#SingleInstance force
; SetKeyDelay, -1
SetKeyDelay, 2,5

; SendMode Input
DetectHiddenWindows, on

buttonList := ["a", "s", "d", "w"]

; Walking speed = 4.3B/s * <speed> = X blocks/sec
; wheatSpeed := 4  ; 4.3*93 = 4
; pumpkinSpeed := 7.53  ; 4.3*1.75 <sideways?>
; wartSpeed := 4 ; 4.3*93 = 4
; caneSpeed := 10 ; 4.3*2.33 = 10
; shroomSpeed := 10 ; guess
; cactusSpeed := 17.2 ; 4.3* 4.00 = 17.2
; cocoaSpeed :=    ; 4.3* 1.55 = 6.665

; Walking time.  96blocks ~ -2 blocks side = 94blocks
; wheatPlotWidth := 94
; PumpkinPlotWidth := 188

; Walking time pumpin double wide. 188 blocks
;pumpkinTime := 21500 ; (pumplinPlotWidth / pumpkinSpeed )*1000 ; too short
pumpkinTime := 24900 ; (pumplinPlotWidth / pumpkinSpeed )*1000 ; too short

wheatTime := 23500 ; (plotWidth / wheatSpeed)*1000
wartTime := 47500 ; (plotWidth*2 / wheatSpeed)*1000


shroomTime := 18000 ; guess
;wheatTime := 23500 ; (plotWidth / wheatSpeed)*1000 ; too short still?
;wheatTime := 20000 ; (plotWidth / wheatSpeed)*1000 ; wy too short
;wheatTime := 100


; blockwidth = superfarm 5 plots * 96 blocks = 480
; ( blockwidth / speed ) * 1000
superTime := 120000 ; 120s * 1000
caneTime := 48000 ; (plotWidth*5 / caneSpeed)*1000 ; but we are up against a thing here.. so I dunno
cactusTime := 27906 ; (480/17.2) * 1000
;cactusTime := 27 ; (480/17.2) * 1000
cocoaTime := 72018 ; (480/6.665) * 1000

;superTime := 2000 ; 120s * 1000

;cane 15 lanes

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
		randomBuf := Randomize(69,420) + cactusTime
		Sleep, randomBuf
		SendInput, {%dir% Up}
		Cactus_backward()
		dir := Reverse_Direction(dir)
		if (A_Index == 10)
			break ; finish loop before we walk back
		SendInput, {space Down}
		SendInput, {%dir% Down}
		randombuf := Randomize(69,420) + cactusTime
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


Walk_pgarden(crop, rows) {
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
		randomBuf := Randomize(269,420) + crop/16.5
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
		randomBuf := Randomize(269,420) + crop/16.5
		Sleep, randomBuf
		SendInput, {w Up}
		SendInput, {d Down}
		Short_forward()
		SendInput, {d up}
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/16.5
		Sleep, randomBuf
		SendInput, {w Up}
		; temp pause at the end of loop
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}


; cgarden = cane, fun!
Walk_cgarden(crop, rows) {
        ; Start clicking
	SendInput, {space Down}
	Loop % rows {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {d Down}
		randomBuf := Randomize(320,469)
		Sleep, randomBuf
		Short_backward()
		randomBuf := Randomize(1069,1420) + crop
		Sleep, randomBuf
		SendInput, {d Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + 769
		Sleep, randomBuf
		SendInput, {w Up}
		; lefts
		SendInput, {space Down}
		SendInput, {a Down}
		randomBuf := Randomize(320,469)
		Sleep, randomBuf
		Short_backward()
		randomBuf := Randomize(1069,1420) + crop
		Sleep, randomBuf
		SendInput, {a Up}
		; if we are on the last iteration
		if (A_Index == rows)
			break ; finish loop before we walk forward.
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + 769
		Sleep, randomBuf
		SendInput, {w Up}
		; temp pause at the end of loop
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}


; shrooms
Walk_sgarden(crop, rows) {
	Click, Down Right
	randomBuf := Randomize(9,69)
	Sleep, randomBuf
	Click, Up Right
        ; Start clicking
	SendInput, {space Down}
	Loop % rows {
		; forward  this calculation is whack and probably only works on wheat	
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right (forward for shrooms)
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop
		Sleep, randomBuf
		SendInput, {w Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/19
		Sleep, randomBuf
		SendInput, {w Up}
		; lefts
		SendInput, {space Down}
		SendInput, {a Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop*2 ; long walk back with w pressed
		Sleep, randomBuf
		SendInput, {a Up}
		SendInput, {w Up}
		; if we are on the last iteration
		; if (A_Index == rows)
		; 	break ; finish loop before we walk forward.
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/32
		Sleep, randomBuf
		SendInput, {w Up}
		; fix strange left edge
		SendInput, {d Down}
		Short_forward()
		SendInput, {d up}
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/32
		Sleep, randomBuf
		SendInput, {w Up}
		; done fix left edge
		; temp pause at the end of loop
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; if we are at the middle iteration
		if (A_Index == 4) {
			Click, Down Right
			randomBuf := Randomize(9,69)
			Sleep, randomBuf
			Click, Up Right
		}
	}
	SendInput, {space Up}
}

; wheat
Walk_wheatgarden(crop, rows) {
        ; Start clicking
	SendInput, {space Down}
	Loop % rows {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {d Down}
		Short_forward()
		randomBuf := Randomize(269,420) + crop
		Sleep, randomBuf
		SendInput, {d Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/19
		Sleep, randomBuf
		SendInput, {w Up}
		; lefts
		SendInput, {space Down}
		SendInput, {a Down}
		Short_forward()
		randomBuf := Randomize(269,420) + crop
		Sleep, randomBuf
		SendInput, {a Up}
		; if we are on the last iteration
		if (A_Index == rows)
			break ; finish loop before we walk forward.
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/19
		Sleep, randomBuf
		SendInput, {w Up}
		; temp pause at the end of loop
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
	}
	SendInput, {space Up}
}

; wart
Walk_wartgarden(crop, rows) {
        ; Start clicking
	SendInput, {space Down}
	Loop % rows {
		randomBuf := Randomize(69,169)
		Sleep, randomBuf
		; Start right
		SendInput, {space Down}
		SendInput, {d Down}
		Short_forward()
		randomBuf := Randomize(269,420) + crop
		Sleep, randomBuf
		SendInput, {d Up}
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(269,420) + crop/32
		Sleep, randomBuf
		SendInput, {w Up}
		; lefts
		SendInput, {space Down}
		SendInput, {a Down}
		Short_forward()
		randomBuf := Randomize(269,420) + crop
		Sleep, randomBuf
		SendInput, {a Up}
		; if we are on the last iteration
		; if (A_Index == 3) {
		; 	; forward  this calculation is whack and probably only works on wheat
		; 	SendInput, {space Down}
		; 	SendInput, {w Down}
		; 	randomBuf := Randomize(420,469) + crop/32
		; 	Sleep, randomBuf
		; 	SendInput, {w Up}
		; 	; fix strange left edge
		; 	SendInput, {d Down}
		; 	Short_forward()
		; 	SendInput, {d up}
		; }                     
		; forward  this calculation is whack and probably only works on wheat
		SendInput, {space Down}
		SendInput, {w Down}
		randomBuf := Randomize(420,469) + crop/32
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
Pause,, 1
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

; Wart loop
F10::
Loop {
	Warp_garden()
	Walk_wartgarden(wartTime, 7)
}

; Left Long Loop
F11::
Loop {
	Warp_garden()
	Walk_WWPC("a")
}

; Right Long Loop
F12::
Loop {
	Warp_garden()
	Walk_WWPC("d")
}

; Shroom loop
^h::
Loop {
	Warp_garden()
	Walk_sgarden(shroomTime, 8)
}

; Cocoa Loop
^t::
Loop {
	Warp_garden()
	Walk_Cocoa("w")
}




^r:: ; press control+r to reload
Reload
return


;TODO: fix pumpkin delay issue
