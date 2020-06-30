#include <File.au3>

; Base de urls com o mesmo nome deste script
$fileSource = FileOpen(@ScriptDir & "\" & StringLeft(@ScriptName,StringLen(@ScriptName)-4) & ".txt",0)

#Region PreSets

	 ;Quando pressionar a tecla 'CTRL+END' sai da rotina
	 HotKeySet("^{END}", "CaptureEND")

	 ; Liga a opção de eventos de controle
	 Opt("GUIOnEventMode",1)

#EndRegion

If $fileSource = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

While 1
   $line = FileReadLine($fileSource)
   If @error = -1 then ExitLoop
   ConsoleWrite($line & @LF)
   ShellExecute($line)
WEnd

FileClose($fileSource)

Func CaptureEND()
 Switch @HotKeyPressed ; The last hotkey pressed.
		Case "^{end}" ; String is the {end} hotkey.ok
			   Exit
 EndSwitch
EndFunc