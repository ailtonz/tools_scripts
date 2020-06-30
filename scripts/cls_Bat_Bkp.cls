VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_Bat_Bkp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sFileName As String
Private sFilePath As String

Property Get strFileName() As String:           strFileName = sFileName:          End Property
Property Let strFileName(pValue As String):     sFileName = pValue:               End Property

Property Get strFilePath() As String:           strFilePath = sFilePath:          End Property
Property Let strFilePath(pValue As String):     sFilePath = pValue:               End Property


Function gerarModelo_BatBkp(ByRef colNews As Collection)
Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
Dim strFileName As String: strFileName = Split(ws.Range(Etiqueta("robot_07_Environment")).Value, "\")(0)
    
LockScreen True
    
    colNews.add vbNewLine
    colNews.add "/* MODELO BAT-BKP"
    
    colNews.add "@echo off"
    colNews.add "SET Today=%Date: =0%"
    colNews.add "SET Year=%Today:~-4%"
    colNews.add "SET Month=%Today:~-7,2%"
    colNews.add "SET Day=%Today:~-10,2%"
    colNews.add "SET hr=%TIME: =0%"
    colNews.add "SET hr=%hr:~0,2%"
    colNews.add "SET min=%TIME:~3,2%"
    colNews.add "SET src_folder=%cd%"
    colNews.add "SET dst_folder=%cd%""\bkp"""
    
    colNews.add vbNewLine
    colNews.add "REM Nome deste script"
    colNews.add "REM SET sFolder=%~n0"
    colNews.add "SET sFolder=" & strFileName
    
    colNews.add vbNewLine
    colNews.add "REM pegar os ultimos 6 caracteres do nome"
    colNews.add "REM SET sFolder=%sFolder:~-6%"
    
    colNews.add vbNewLine
    colNews.add "REM arq tmp para uso do script"
    colNews.add "SET sFile=print.txt"
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Compactar arquivos em pasta selecionada"
    colNews.add "REM"
    colNews.add "CD ""%src_folder%"""
    colNews.add "for /d %%X in (""%sFolder%"") do 7za.exe a %Year%%Month%%Day%-%hr%%min%_""%%X.7z"" ""%%X\"""
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Gerar arquivo lista para copia"
    colNews.add "REM"
    colNews.add "del ""%sFile%"""
    colNews.add "dir *.7z /b > ""%sFile%"""
    
    colNews.add vbNewLine
    colNews.add "TIMEOUT 3"
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Efetuar copia de arquivos em lista"
    colNews.add "REM"
    colNews.add "for /f ""tokens=*"" %%i in (print.txt) DO ("
    colNews.add "    xcopy /y ""%src_folder%\%%i"" ""%dst_folder%"""
    colNews.add "    del ""%src_folder%\%%i"""
    colNews.add ")"
    
    colNews.add vbNewLine
    colNews.add "del ""%sFile%"""
    
    colNews.add "pause"
    
    colNews.add "*/"
    
LockScreen False

End Function

Function gerarBatBkp()
Dim colNews As New Collection
Dim c As Variant
    
LockScreen True

    colNews.add "@echo off"
    colNews.add "SET Today=%Date: =0%"
    colNews.add "SET Year=%Today:~-4%"
    colNews.add "SET Month=%Today:~-7,2%"
    colNews.add "SET Day=%Today:~-10,2%"
    colNews.add "SET hr=%TIME: =0%"
    colNews.add "SET hr=%hr:~0,2%"
    colNews.add "SET min=%TIME:~3,2%"
    colNews.add "SET src_folder=%cd%"
    colNews.add "SET dst_folder=%cd%""\bkp"""
    
    colNews.add vbNewLine
    colNews.add "REM Nome deste script"
    colNews.add "REM SET sFolder=%~n0"
    colNews.add "SET sFolder=" & strFileName
    
    colNews.add vbNewLine
    colNews.add "REM pegar os ultimos 6 caracteres do nome"
    colNews.add "REM SET sFolder=%sFolder:~-6%"
    
    colNews.add vbNewLine
    colNews.add "REM arq tmp para uso do script"
    colNews.add "SET sFile=print.txt"
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Compactar arquivos em pasta selecionada"
    colNews.add "REM"
    colNews.add "CD ""%src_folder%"""
    colNews.add "for /d %%X in (""%sFolder%"") do 7za.exe a %Year%%Month%%Day%-%hr%%min%_""%%X.7z"" ""%%X\"""
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Gerar arquivo lista para copia"
    colNews.add "REM"
    colNews.add "del ""%sFile%"""
    colNews.add "dir *.7z /b > ""%sFile%"""
    
    colNews.add vbNewLine
    colNews.add "TIMEOUT 3"
    
    colNews.add vbNewLine
    colNews.add "REM"
    colNews.add "REM Efetuar copia de arquivos em lista"
    colNews.add "REM"
    colNews.add "for /f ""tokens=*"" %%i in (print.txt) DO ("
    colNews.add "    xcopy /y ""%src_folder%\%%i"" ""%dst_folder%"""
    colNews.add "    del ""%src_folder%\%%i"""
    colNews.add ")"
    
    colNews.add vbNewLine
    colNews.add "del ""%sFile%"""
    
    colNews.add "pause"
    
    Dim strFilePathBat As String
    
    '' Exclusão
    If ((strFilePath) = "") Then strFilePath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePath & "\" & "Bkp_" & strFileName & ".bat") <> "") Then Kill strFilePath & "\" & "Bkp_" & strFileName & ".bat"
    
    '' Criação
    For Each c In colNews
        saida strFilePath, "Bkp_" & strFileName & ".bat", CStr(c)
    Next c

LockScreen False

Set colNews = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function

