#include <Timers.au3>

#Region PreSets
	HotKeySet("^{END}", "CaptureEND")
	Opt("GUIOnEventMode",1)
#EndRegion

While true
   MouseMove(10,10,1)
   MouseMove(20,10,1)
   MouseMove(30,20,1)
   MouseMove(40,20,1)
WEnd

Func CaptureEND()
	Switch @HotKeyPressed
		Case "^{end}"
		Exit
	EndSwitch
EndFunc
