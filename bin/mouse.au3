#include <Timers.au3>
;Loop:

#Region PreSets

	;Quando pressionar a tecla 'CTRL+END' sai da rotina
	HotKeySet("^{END}", "CaptureEND")

	; Liga a opção de eventos de controle
	Opt("GUIOnEventMode",1)

#EndRegion


While true
   ;Check if the idle time reached :
   MouseMove(10,10,1) ;point A
   MouseMove(20,10,1) ;point B
   MouseMove(30,20,1) ;point C
   MouseMove(40,20,1)  ;point D
WEnd

Func CaptureEND()
Switch @HotKeyPressed ; The last hotkey pressed.
                               Case "^{end}" ; String is the {end} hotkey.
                                                  Exit
EndSwitch
EndFunc
