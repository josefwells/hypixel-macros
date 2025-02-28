# Hypixel Farming updated AutoHotKey Script
Build a farm like this: Superfarm https://www.youtube.com/watch?v=KmY4CN1Wyy0

Then use these keys after loading:
--
F6 Pause/unpause.  Timers still run, but nothing else
so if you pause, you can move to the end of your current row
line up, and unpause, pickign up where you left off.
This is harder in the "superfarm" because of the cramped quarters.

^r (Cntrl+r) Reload script.  If things go bad, pause(F6) and reload(Ctrl-r)

These last ones are super-farm (carrot, potato, wheat, wart) since they
are all the same speed and basically the same layout, but left or right facing
easy to remember because F11, the 1 looks like an l, so that one goes left first.
F11 ; Left Long Loop ; for superfarm where you start off going left.
F12 ; Right Long Loop ; for superfarm where you start off going right.

# Old, probably useless macros for my old farm and the goblin fireplace in the dwarven mines.

--
F7  Goblin loop; pretty crappy, prolly get you banned and makes squat for money.

F8  Cactus loop
F9  Cane Loop
F10 Gourd Loop
^t (Ctrl-t) Cocoa Loop

# Code
The code is commented, kind of a mess, but it worked a while back pretty well.
Many assumptions about walking speed, etc are built in with the formulas shown
so you should be able to math it out if something changes for your setup.
