VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_file_js"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sFileName As String
Private sFilePath As String
Private bCarregarBase As Boolean

Property Get strFileName() As String:           strFileName = sFileName:          End Property
Property Let strFileName(pValue As String):     sFileName = pValue:               End Property

Property Get strFilePath() As String:           strFilePath = sFilePath:          End Property
Property Let strFilePath(pValue As String):     sFilePath = pValue:               End Property

Property Get CarregarBase() As Boolean:           CarregarBase = bCarregarBase:  End Property
Property Let CarregarBase(pValue As Boolean):     bCarregarBase = pValue:        End Property


Function gerarJs()
Dim Col As New Collection
Dim f As New cls_fnc_Process
Dim c As Variant


LockScreen True

'' ###############
'' MODELO
'' ###############

    f.Cabecalho Col

If (CarregarBase) Then

    f.fncCarregarBase Col

    f.fncIniciarProcesso Col

    f.fncProcesso Col

    f.fncBaseJson Col

    f.fncFecharTelasV01 Col

    f.fncFecharTelasV02 Col

    f.fncEsperarPesquisa Col

    f.fncMenu_Processo Col

Else

    f.fncProcessamento Col

End If





'' ###############
'' EXCLUSÃO
'' ###############

    If ((strFilePath) = "") Then strFilePath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePath & "\" & strFileName) <> "") Then Kill strFilePath & "\" & strFileName
    
'' ###############
'' CRIAÇÃO
'' ###############
    
    For Each c In Col
        saida strFilePath, strFileName, CStr(c)
    Next c

LockScreen False

Set Col = Nothing
Set f = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function


