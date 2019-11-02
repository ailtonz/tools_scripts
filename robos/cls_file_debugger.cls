VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_file_debugger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private sFileName As String
Private sFilePath As String
Private cProcedures As Collection
Private cLibrary As Collection
Private bCarregarBase As Boolean
Private sPathEnvironment As String
Private sPathRepository As String
Private sPathFileSource As String

Property Get strFileName() As String:           strFileName = sFileName:          End Property
Property Let strFileName(pValue As String):     sFileName = pValue:               End Property

Property Get strFilePath() As String:           strFilePath = sFilePath:          End Property
Property Let strFilePath(pValue As String):     sFilePath = pValue:               End Property

Property Get colProcedures() As Collection:           Set colProcedures = cProcedures:  End Property
Property Let colProcedures(pValue As Collection):     Set cProcedures = pValue:         End Property

Property Get colLibrary() As Collection:           Set colLibrary = cLibrary:           End Property
Property Let colLibrary(pValue As Collection):     Set cLibrary = pValue:               End Property

Property Get CarregarBase() As Boolean:           CarregarBase = bCarregarBase:  End Property
Property Let CarregarBase(pValue As Boolean):     bCarregarBase = pValue:        End Property

Property Get strPathEnvironment() As String:           strPathEnvironment = sPathEnvironment:       End Property
Property Let strPathEnvironment(pValue As String):     sPathEnvironment = pValue:                   End Property

Property Get strPathRepository() As String:           strPathRepository = sPathRepository:          End Property
Property Let strPathRepository(pValue As String):     sPathRepository = pValue:                     End Property

Property Get strPathFileSource() As String:           strPathFileSource = sPathFileSource:          End Property
Property Let strPathFileSource(pValue As String):     sPathFileSource = pValue:                     End Property

Function gerarWsf()
Dim Col As New Collection
Dim b As New cls_bat_Start
Dim k As New cls_Bat_Bkp
Dim f As New cls_fnc_globais
Dim c As Variant

LockScreen True

'' ###############
'' CABEÇALHO
'' ###############

    Col.add "<?XML version=""2.0"" standalone=""yes"" encoding=""iso-8859-1"" ?>"
    Col.add "<package>"
    Col.add vbTab & "<job id=""Santander"">"
    Col.add vbTab & vbTab & "<?job debug=""true""?>"
    Col.add vbTab & vbTab & "<runtime>"
    Col.add vbTab & vbTab & vbTab & "<description>Scripts Automação Santander</description>"
    Col.add vbTab & vbTab & "</runtime>"

'' ###############
'' BIBLIOTECA(S)
'' ###############

    '' Listar bibliotecas
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\Call_AutoIt.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\AutoIt_Functions.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\Excel_Functions.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\Utils_Santander_RPA.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\STMRun.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\JSON2.js""/>"
    Col.add vbTab & vbTab & "<script language=""JScript"" src=""bin\IEUtils_Santander.js""/>"
    
    '' Language
    Col.add vbTab & vbTab & "<script language=""JScript"">"
    
    
'' ###############
'' CONTEUDO
'' ###############


    Col.add vbTab & vbTab & "<![CDATA["
    
    

    
    
    Col.add vbNewLine
    Col.add vbTab & vbTab & "debugger;"
    Col.add vbTab & vbTab & "debugger;"
    Col.add vbTab & vbTab & "debugger;"
        
    Col.add vbTab & vbTab & "WScript.Quit();"
       
    b.gerarModelo_BatStart Col
    
''    ATENÇÃO: ATIVAR ESTES ITEMS APENAS QUANDO NECESSÁRIO!
'    k.gerarModelo_BatBkp Col
'    f.fncCarregarLogs Col
       
    Col.add vbTab & vbTab & "]]>"
    Col.add vbTab & vbTab & "</script>"
    Col.add vbTab & "</job>"
    Col.add "</package>"
    

'' #############################################
'' EXCLUSÃO DE ARQUIVO CASO JÁ EXISTA
'' #############################################

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
Set o = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function
