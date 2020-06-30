VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsEPF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sAppPath As String
Private sAppName As String
Private sPassword As String
Private sDestinationPath As String
Private sDestinationFile As String

Property Get strAppPath() As String:                   strAppPath = sPath:           End Property
Property Let strAppPath(pValue As String):             sAppPath = pValue:            End Property

Property Get strAppName() As String:                    strAppName = sAppName:      End Property
Property Let strAppName(pValue As String):              sAppName = pValue:          End Property

Property Get strPassword() As String:                      strPassword = sPassword:    End Property
Property Let strPassword(pValue As String):                sPassword = pValue:         End Property

Property Get strDestinationPath() As String:               strDestinationPath = sDestinationPath:       End Property
Property Let strDestinationPath(pValue As String):         sDestinationPath = pValue:                   End Property

Property Get strDestinationFile() As String:               strDestinationFile = sDestinationFile:       End Property
Property Let strDestinationFile(pValue As String):         sDestinationFile = pValue:                   End Property

Function gerarEpf()
Dim Col As New Collection

    Col.add sAppPath & sAppName & " -f " & sPassword & " " & sDestinationPath & "\" & sDestinationFile
    
    '' Exclusão
    If ((sDestinationPath) = "") Then sDestinationPath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(sDestinationPath & "\" & sDestinationFile) <> "") Then Kill sDestinationPath & "\" & sDestinationFile
    
    For Each c In Col
        saida sDestinationPath, Left(sDestinationFile, Len(sDestinationFile) - 5) & ".bat", CStr(c)
    Next c
    
    '' Adicionais
    saida sDestinationPath, Left(sDestinationFile, Len(sDestinationFile) - 5) & ".bat", "TIMEOUT 3"
    saida sDestinationPath, Left(sDestinationFile, Len(sDestinationFile) - 5) & ".bat", "DEL /Q /F " & sDestinationPath & "\" & Left(sDestinationFile, Len(sDestinationFile) - 5) & ".bat"
    
    '' Pause
    'Sleep 500
    
    '' Auto run
    Shell sDestinationPath & "\" & Left(sDestinationFile, Len(sDestinationFile) - 5) & ".bat"

Set Col = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    
'    If ((strCaminho) = "") Then strCaminho = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function
