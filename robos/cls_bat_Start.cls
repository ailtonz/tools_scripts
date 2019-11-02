VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_bat_Start"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sFilePathBat As String
Private sFilePathRobo As String
Private sPathRepository As String
Private sFileNameIni As String
Private sFileNameWsf As String
Private sFileNameBat As String
Private sQtdeMassa As String
Private sFileNameEPF As String
Private bCarregarBase As Boolean


Property Get strFilePathBat() As String:                        strFilePathBat = sFilePathBat:          End Property
Property Let strFilePathBat(pValue As String):                  sFilePathBat = pValue:                  End Property

Property Get strFilePathRobo() As String:                        strFilePathRobo = sFilePathRobo:          End Property
Property Let strFilePathRobo(pValue As String):                  sFilePathRobo = pValue:                  End Property

Property Get strPathRepository() As String:                      strPathRepository = sPathRepository:   End Property
Property Let strPathRepository(pValue As String):                sPathRepository = pValue:                  End Property

Property Get strFileNameIni() As String:                        strFileNameIni = sFileNameIni:          End Property
Property Let strFileNameIni(pValue As String):                  sFileNameIni = pValue:                  End Property

Property Get strFileNameWsf() As String:                        strFileNameWsf = sFileNameWsf:          End Property
Property Let strFileNameWsf(pValue As String):                  sFileNameWsf = pValue:                  End Property

Property Get strFileNameBat() As String:                        strFileNameBat = sFileNameBat:          End Property
Property Let strFileNameBat(pValue As String):                  sFileNameBat = pValue:                  End Property

Property Get strQtdeMassa() As String:                        strQtdeMassa = sQtdeMassa:          End Property
Property Let strQtdeMassa(pValue As String):                  sQtdeMassa = pValue:                  End Property

Property Get strFileNameEPF() As String:                        strFileNameEPF = sFileNameEPF:          End Property
Property Let strFileNameEPF(pValue As String):                  sFileNameEPF = pValue:                  End Property

Property Get CarregarBase() As Boolean:           CarregarBase = bCarregarBase:  End Property
Property Let CarregarBase(pValue As Boolean):     bCarregarBase = pValue:        End Property


Function gerarModelo_BatStart(ByRef colNews As Collection, Optional sFileNameIni As String, Optional sFileNameWsf As String)

Dim c As Variant

Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
Dim strFilePathRobo As String: strFilePathRobo = ws.Range(Etiqueta("robot_07_Environment")).Value
Dim strPathRepository As String: strPathRepository = Etiqueta("pathRepository")
Dim strFileNameIni As String: strFileNameIni = IIf(sFileNameIni <> "", sFileNameIni, "Step_Debugger.ini")
Dim strFileNameWsf As String: strFileNameWsf = IIf(sFileNameWsf <> "", sFileNameWsf, "debugger.wsf")

    colNews.add vbNewLine
    colNews.add "/* MODELO BAT-START"
    colNews.add "taskkill /F /IM mdm.exe "
    colNews.add "cd " + strPathRepository
    If (strFileNameIni <> "") Then
        colNews.add "rem set Step=" + strFilePathRobo + strFileNameIni
        colNews.add "rem set Sigla_AHK=" + strFileNameEPF
        colNews.add "rem set QtdeMassa=" + strQtdeMassa
    End If
        
    colNews.add "rem C:\Windows\Syswow64\cscript.exe //x " + strFilePathRobo + strFileNameWsf
    colNews.add "C:\Windows\Syswow64\cscript.exe //x " + strFileNameWsf
    colNews.add "pause"
    colNews.add "*/"

End Function


Function gerarBatStart()
Dim colNews As New Collection
Dim c As Variant

    colNews.add "taskkill /F /IM mdm.exe "
    colNews.add "cd " + strPathRepository
    colNews.add IIf(strFileNameIni <> "", "set Step=" + strFilePathRobo + strFileNameIni, "")
    colNews.add IIf(strFileNameEPF <> "", "set Sigla_AHK=" + strFileNameEPF, "")
    
    If (CarregarBase) Then
        colNews.add "set QtdeMassa=" + strQtdeMassa
    End If
    
    colNews.add "C:\Windows\Syswow64\cscript.exe //x " + strFilePathRobo + strFileNameWsf
    colNews.add "pause"
    
    '' Exclusão
    If ((strFilePathBat) = "") Then strFilePathBat = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePathBat & "\" & strFileNameBat) <> "") Then Kill strFilePathBat & "\" & strFileNameBat
    
    '' Criação
    For Each c In colNews
        saida strFilePathBat, strFileNameBat, CStr(c)
    Next c

Set colNews = Nothing
End Function


Function gerarBatStart_old()
Dim colNews As New Collection
Dim c As Variant

    colNews.add "taskkill /F /IM mdm.exe "
    colNews.add "cd " + strPathRepository
    
    If (strFileNameIni <> "") Then
        colNews.add "set Step=" + strFilePathRobo + strFileNameIni
        colNews.add "set Sigla_AHK=" + strFileNameEPF
        colNews.add "set QtdeMassa=" + strQtdeMassa
    End If
        
    colNews.add "C:\Windows\Syswow64\cscript.exe //x " + strFilePathRobo + strFileNameWsf
    colNews.add "pause"
    
    '' Exclusão
    If ((strFilePathBat) = "") Then strFilePathBat = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePathBat & "\" & strFileNameBat) <> "") Then Kill strFilePathBat & "\" & strFileNameBat
    
    '' Criação
    For Each c In colNews
        saida strFilePathBat, strFileNameBat, CStr(c)
    Next c

Set colNews = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function
