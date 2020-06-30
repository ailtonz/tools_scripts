VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_file_AutoIt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Sub create_runUrl()
'
'Dim ws As Worksheet
'Set ws = Worksheets(ActiveSheet.Name)
'
'Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
'lRow = ws.Cells(Rows.Count, 2).End(xlUp).Offset(1, 0).Row
'
''' Source
'Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")
'
''' File path
'Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".txt"
'If (Dir(pathExit) <> "") Then Kill pathExit
'
'    '' Build file text
'    For Each t In ws.Range("C2:C" & lRow).SpecialCells(xlCellTypeVisible)
'        tmp = tmp & t & vbNewLine
'    Next
'    TextFile_Append pathExit, tmp
'
'    '' Build script
'    Dim objFile As New cls_file_AutoIt
'    objFile.runUrl ActiveSheet.Name
'
'End Sub
'
'Sub create_runMouse()
'
''' Build script
'Dim objFile As New cls_file_AutoIt
'objFile.runMouse
'
'End Sub


Function runUrl(strFileName As String, strApp As String) 'runUrl.au3
Dim colNews As New Collection
Dim c As Variant
    
LockScreen True

    colNews.add "#include <File.au3>"
    colNews.add "$fileSource = FileOpen(@ScriptDir & ""\"" & StringLeft(@ScriptName,StringLen(@ScriptName)-4) & "".txt"",0)"
    colNews.add "#Region PreSets"
    colNews.add "    HotKeySet(""^{END}"", ""CaptureEND"")"
    colNews.add "    Opt(""GUIOnEventMode"",1)"
    colNews.add "#EndRegion"
    colNews.add "If $fileSource = -1 Then"
    colNews.add "    MsgBox(0, ""Error"", ""Unable to open file."")"
    colNews.add "    Exit"
    colNews.add "EndIf"
    colNews.add "While 1"
    colNews.add "   $line = FileReadLine($fileSource)"
    colNews.add "   If @error = -1 then ExitLoop"
    colNews.add "   ConsoleWrite($line & @LF)"
    colNews.add "   ShellExecute($line)"
    colNews.add "WEnd"
    colNews.add "FileClose($fileSource)"
    colNews.add "Func CaptureEND()"
    colNews.add " Switch @HotKeyPressed "
    colNews.add "       Case ""^{end}"" "
    colNews.add "          Exit"
    colNews.add " EndSwitch"
    colNews.add "EndFunc"
    
    Dim strFilePath As String
    Dim tempFileName As String: tempFileName = "\" & strFileName & ".au3"
    
    '' Exclusão
    If ((strFilePath) = "") Then strFilePath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePath & tempFileName) <> "") Then Kill strFilePath & tempFileName
    
    '' Criação
    For Each c In colNews
        saida strFilePath, tempFileName, CStr(c)
    Next c
    
    Dim pathApp As String: pathApp = strApp & " " & strFilePath & tempFileName
    Shell pathApp
    

LockScreen False

Set colNews = Nothing
End Function

Function runMouse(strApp As String)
Dim colNews As New Collection
Dim c As Variant
    
LockScreen True

    colNews.add "#include <Timers.au3>"
    colNews.add "#Region PreSets"
    colNews.add "   HotKeySet(""^{END}"", ""CaptureEND"")"
    colNews.add "   Opt(""GUIOnEventMode"",1)"
    colNews.add "#EndRegion"
    colNews.add "While true"
    colNews.add "   MouseMove(10,10,1)"
    colNews.add "   MouseMove(20,10,1)"
    colNews.add "   MouseMove(30,20,1)"
    colNews.add "   MouseMove(40,20,1)"
    colNews.add "WEnd"
    colNews.add "Func CaptureEND()"
    colNews.add "   Switch @HotKeyPressed"
    colNews.add "       Case ""^{end}"""
    colNews.add "       Exit"
    colNews.add "   EndSwitch"
    colNews.add "EndFunc"
    
    Dim strFilePath As String
    Dim strFileName As String: strFileName = "\mouse.au3"
    
    '' Exclusão
    If ((strFilePath) = "") Then strFilePath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePath & strFileName) <> "") Then Kill strFilePath & strFileName
    
    '' Criação
    For Each c In colNews
        saida strFilePath, strFileName, CStr(c)
    Next c

    Dim pathApp As String: pathApp = strApp & " " & strFilePath & strFileName
    Shell pathApp


LockScreen False

Set colNews = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function

