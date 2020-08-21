VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsRepositorio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Private sAppPath As String
'Property Get strAppPath() As String:                   strAppPath = sPath:           End Property
'Property Let strAppPath(pValue As String):             sAppPath = pValue:            End Property

Public Function batBkp(ByRef pCol As Collection)
    
    pCol.add "@echo off"
    pCol.add "SET Today=%Date: =0%"
    pCol.add "SET Year=%Today:~-4%"
    pCol.add "SET Month=%Today:~-7,2%"
    pCol.add "SET Day=%Today:~-10,2%"
    pCol.add "SET hr=%TIME: =0%"
    pCol.add "SET hr=%hr:~0,2%"
    pCol.add "SET min=%TIME:~3,2%"
    pCol.add "SET src_folder=%cd%"
    pCol.add "SET dst_folder=%cd%""\bkp"""
    
    pCol.add vbNewLine
    pCol.add "REM"
    pCol.add "REM Criar pasta de bkp em destino escolhido"
    pCol.add "REM"
    pCol.add "mkdir ""%dst_folder%"""
    
    pCol.add vbNewLine
    pCol.add "REM Nome deste script"
    pCol.add "REM SET sFolder=%~n0"
    pCol.add "SET sFolder=" & strFileName
    
    pCol.add vbNewLine
    pCol.add "REM pegar os ultimos 6 caracteres do nome"
    pCol.add "REM SET sFolder=%sFolder:~-6%"
    
    pCol.add vbNewLine
    pCol.add "REM arq tmp para uso do script"
    pCol.add "SET sFile=print.txt"
    
    pCol.add vbNewLine
    pCol.add "REM"
    pCol.add "REM Compactar arquivos em pasta selecionada"
    pCol.add "REM"
    pCol.add "CD ""%src_folder%"""
    pCol.add "for /d %%X in (""%sFolder%"") do 7za.exe a %Year%%Month%%Day%-%hr%%min%_""%%X.7z"" ""%%X\"""
    
    pCol.add vbNewLine
    pCol.add "REM"
    pCol.add "REM Gerar arquivo lista para copia"
    pCol.add "REM"
    pCol.add "del ""%sFile%"""
    pCol.add "dir *.7z /b > ""%sFile%"""
    
    pCol.add vbNewLine
    pCol.add "TIMEOUT 3"
    
    pCol.add vbNewLine
    pCol.add "REM"
    pCol.add "REM Efetuar copia de arquivos em lista"
    pCol.add "REM"
    pCol.add "for /f ""tokens=*"" %%i in (print.txt) DO ("
    pCol.add "    xcopy /y ""%src_folder%\%%i"" ""%dst_folder%"""
    pCol.add "    del ""%src_folder%\%%i"""
    pCol.add ")"
    
    pCol.add vbNewLine
    pCol.add "del ""%sFile%"""
    
    pCol.add "pause"
    
End Function

Public Function Url(ByRef pCol As Collection)

    pCol.add "#include <File.au3>"
    pCol.add "$fileSource = FileOpen(@ScriptDir & ""\"" & StringLeft(@ScriptName,StringLen(@ScriptName)-4) & "".txt"",0)"
    pCol.add "#Region PreSets"
    pCol.add "    HotKeySet(""^{END}"", ""CaptureEND"")"
    pCol.add "    Opt(""GUIOnEventMode"",1)"
    pCol.add "#EndRegion"
    pCol.add "If $fileSource = -1 Then"
    pCol.add "    MsgBox(0, ""Error"", ""Unable to open file."")"
    pCol.add "    Exit"
    pCol.add "EndIf"
    pCol.add "While 1"
    pCol.add "   $line = FileReadLine($fileSource)"
    pCol.add "   If @error = -1 then ExitLoop"
    pCol.add "   ConsoleWrite($line & @LF)"
    pCol.add "   ShellExecute($line)"
    pCol.add "WEnd"
    pCol.add "FileClose($fileSource)"
    pCol.add "Func CaptureEND()"
    pCol.add " Switch @HotKeyPressed "
    pCol.add "       Case ""^{end}"" "
    pCol.add "          Exit"
    pCol.add " EndSwitch"
    pCol.add "EndFunc"

End Function

Public Function mouse(ByRef pCol As Collection)

    pCol.add "#include <Timers.au3>"
    pCol.add "#Region PreSets"
    pCol.add "   HotKeySet(""^{END}"", ""CaptureEND"")"
    pCol.add "   Opt(""GUIOnEventMode"",1)"
    pCol.add "#EndRegion"
    pCol.add "While true"
    pCol.add "   MouseMove(10,10,1)"
    pCol.add "   MouseMove(20,10,1)"
    pCol.add "   MouseMove(30,20,1)"
    pCol.add "   MouseMove(40,20,1)"
    pCol.add "WEnd"
    pCol.add "Func CaptureEND()"
    pCol.add "   Switch @HotKeyPressed"
    pCol.add "       Case ""^{end}"""
    pCol.add "       Exit"
    pCol.add "   EndSwitch"
    pCol.add "EndFunc"
    
End Function
