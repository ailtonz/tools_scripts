VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_file_Ini"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sFileName As String
Private sFilePath As String
Private sPathEnvironment As String
'Private sInitials As String

Property Get strFileName() As String:           strFileName = sFileName:          End Property
Property Let strFileName(pValue As String):     sFileName = pValue:               End Property

Property Get strFilePath() As String:           strFilePath = sFilePath:          End Property
Property Let strFilePath(pValue As String):     sFilePath = pValue:               End Property

Property Get strPathEnvironment() As String:           strPathEnvironment = sPathEnvironment:          End Property
Property Let strPathEnvironment(pValue As String):     sPathEnvironment = pValue:                              End Property

'Property Get strInitials() As String:           strInitials = sInitials:          End Property
'Property Let strInitials(pValue As String):     sInitials = pValue:                              End Property



Function gerarFileIni()
Dim colNews As New Collection
Dim c As Variant

    colNews.add "[main]"
    colNews.add "steps=carregar_Base,Home_TFC,Login_TFC,Processa_TFC,ProcessadosOK,ProcessadosNOK,ProblemasAcesso"
    
    colNews.add vbNewLine
    colNews.add "[carregar_Base]"
    colNews.add "timeout=60000"
    colNews.add "func=carregarBase"
    colNews.add "dependencies=Home_TFC"
    colNews.add "friendlyname=ROBO 01 - Carregar Arquivos"
    
    colNews.add vbNewLine
    colNews.add "[Home_TFC]"
    colNews.add "timeout=130000"
    colNews.add "func=homeTFC"
    colNews.add "dependencies=Login_TFC"
    colNews.add "friendlyname=TFC 02 - Tela Login"
    
    colNews.add vbNewLine
    colNews.add "[Login_TFC]"
    colNews.add "timeout=70000"
    colNews.add "func=loginTFC"
    colNews.add "dependencies=Processa_TFC"
'    colNews.Add "Credenciais=TFC;" & strInitials
    colNews.add "friendlyname=TFC 03 - Login"
    
    colNews.add vbNewLine
    colNews.add "[Processa_TFC]"
    colNews.add "timeout=60000"
    colNews.add "func=iniciarProcesso"
    colNews.add "friendlyname=TFC 04 - Processamento"
    
    colNews.add vbNewLine
    colNews.add "[ProcessadosOK]"
    colNews.add "timeout=10000"
    colNews.add "func=DadosProcessados"
    colNews.add "dadosXLS=\" & sPathEnvironment & "Processados;null;1;Status;OK"
    colNews.add "friendlyname=Total de Sucessos"
    
    colNews.add vbNewLine
    colNews.add "[ProcessadosNOK]"
    colNews.add "timeout=10000"
    colNews.add "func=DadosProcessados"
    colNews.add "dadosXLS=\" & sPathEnvironment & "Processados;null;1;Status;OK"
    colNews.add "friendlyname=Total de Falhas"
    
    colNews.add vbNewLine
    colNews.add "[ProblemasAcesso]"
    colNews.add "timeout=10000"
    colNews.add "func=ProblemasAcesso"
    colNews.add "friendlyname=Total de Falhas em Acessos "
    
    '' Exclusão
    If ((strFilePath) = "") Then strFilePath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strFilePath & "\" & strFileName) <> "") Then Kill strFilePath & "\" & strFileName
    
    '' Criação
    For Each c In colNews
        saida strFilePath, strFileName, CStr(c)
    Next c

Set colNews = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function


