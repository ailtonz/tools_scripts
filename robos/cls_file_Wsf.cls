VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_file_Wsf"
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
Dim f As New cls_fnc_globais
Dim b As New cls_bat_Start
Dim k As New cls_Bat_Bkp
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

    '' Listar processos do robo
    addProcedures Col, colProcedures

    '' Listar bibliotecas
    addLibrary Col, colLibrary
    
    '' Language
    Col.add vbTab & vbTab & "<script language=""JScript"">"

'' ###############
'' CONTEUDO
'' ###############


    Col.add vbTab & vbTab & "<![CDATA["
    
    
    Col.add vbNewLine
    Col.add vbTab & vbTab & "/****************************************/"
    Col.add vbTab & vbTab & "/********** Funções Globais *************/"
    Col.add vbTab & vbTab & "/****************************************/"
        
    If (CarregarBase) Then
        '' Global
        f.fncCriarAmbiente Col
        f.fncEscreveLog Col

        '' Carregar base
        f.fncMoverDoRepositorioParaFilaDeEspera Col
        f.fncMoverDaFilaDeEsperaParaProcessamento Col
        f.fncFilaDeExecucao Col

        '' Carregar base + Processamento
        f.fncStatusOperacao Col
        
    End If
                
    Col.add vbNewLine
    Col.add vbTab & vbTab & "/****************************************/"
    Col.add vbTab & vbTab & "/********** Variaveis Globais ***********/"
    Col.add vbTab & vbTab & "/****************************************/"
    
    Col.add vbNewLine
    Col.add vbTab & vbTab & "var QtdMassa = WshSysEnv(""QtdeMassa"");           //--[ CONTROLE DO SISTEMA ]"
    Col.add vbTab & vbTab & "var countAccessError = 0, msgAccessError = """";   //--[ CONTROLE DO SISTEMA ]"
    Col.add vbTab & vbTab & "var continueProcess = true;                       //--[ VALIDAR TFC ]"
    
    Col.add vbTab & vbTab & "var logData = new Date();"
    
    If (CarregarBase) Then
        objGlobal Col
        objGenerico Col
    End If
        
    Col.add vbNewLine
    Col.add vbTab & vbTab & "runSTM();"
    Col.add vbTab & vbTab & "killApl();"
    Col.add vbTab & vbTab & "WScript.Quit();"
              
    b.gerarModelo_BatStart Col
    k.gerarModelo_BatBkp Col
    
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

Private Function addProcedures(ByRef pCol As Collection, pItens As Collection)
Dim item As Variant

    For Each item In pItens
        pCol.add vbTab & vbTab & "<script language=""JScript"" src=""" & item & """/>"
    Next item

End Function

Private Function addLibrary(ByRef pCol As Collection, pItens As Collection)
Dim item As Variant

    For Each item In pItens
        pCol.add vbTab & vbTab & "<script language=""JScript"" src=""..\..\" & item & """/>"
    Next item

End Function


Public Function objGlobal(ByRef pCol As Collection)

    Dim sCaminhoDoRobo As String: sCaminhoDoRobo = strPathEnvironment
    Dim sCaminhoRepositorio As String: sCaminhoRepositorio = strPathRepository
    
    pCol.add vbNewLine
    
    '' Estrutura principal
    pCol.add vbTab & vbTab & "var objGlobal = new Array();"
    pCol.add vbTab & vbTab & "objGlobal = { ""pathAmbiente"" : WshShell.currentDirectory +  ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + """ "
    pCol.add vbTab & vbTab & vbTab & ",""pathExecucao"" : WshShell.currentDirectory +  ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + "Arquivos\\"" "
    pCol.add vbTab & vbTab & vbTab & ",""pathFilaEspera"" : WshShell.currentDirectory + ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + "Arquivos\\filaDeEspera\\"" "
    pCol.add vbTab & vbTab & vbTab & ",""pathRepositorio"" : """ + sCaminhoRepositorio + """ "
    
    '' Arquivo log
    pCol.add vbTab & vbTab & vbTab & ",""fileLog"" : logData.format('yyyymmdd_HHMM') + ""_log.csv"" "
    
    '' Caminho(s) de processados
    pCol.add vbTab & vbTab & vbTab & ",""arrayPathProcessados"" : [{""caminho"" : WshShell.currentDirectory + ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + "Arquivos\\filaProcessados\\""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : " + """" + sCaminhoRepositorio + "Processados\\""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "]"
    
    '' Caminho(s) de log
    pCol.add vbTab & vbTab & vbTab & ",""arrayPathLog"" : [{""caminho"" : WshShell.currentDirectory + ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + "Processados\\""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : WshShell.currentDirectory +  ""\\" + Replace(sCaminhoDoRobo, "\", "\\") + "Arquivos\\""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "]"
    
    '' Pasta(s) de controle de processamento
    pCol.add vbTab & vbTab & vbTab & ",""arrayFolders"" : [{""caminho"" : ""Arquivos""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""Processados""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""\\Arquivos\\filaDeEspera""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""\\Arquivos\\filaProcessados""}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "]"
    
    pCol.add vbTab & vbTab & vbTab & "};"

End Function

Public Function objGenerico(ByRef pCol As Collection)


    Dim strFiltrarArquivo As String: strFiltrarArquivo = strPathFileSource

    pCol.add vbNewLine
    
    '' Estrutura principal
    pCol.add vbTab & vbTab & "var objOperacao = new Array();"
    pCol.add vbTab & vbTab & "objOperacao = { ""pathRepositorio"": objGlobal.pathRepositorio"
'    pCol.Add vbTab & vbTab & vbTab & ",""FiltrarArquivo"": """ + strFiltrarArquivo + """"
    pCol.add vbTab & vbTab & vbTab & ",""FiltrarArquivo"": """""
    
    '' Caminho(s) do log
    pCol.add vbTab & vbTab & vbTab & ",""arrayPathLog"" : [{""Arquivo"": objGlobal.arrayPathLog[0].caminho + ""Rev_""+ logData.format('yyyymmdd_HHMM') +"".csv"""
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Campos"" : [""agencia"",""contrato"",""dataInicioContrato"",""Observacoes"",""DataLog"",""Status""]"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Cabecalho"" : false"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "},{""Arquivo"": objGlobal.arrayPathLog[1].caminho + ""Rev_""+ logData.format('yyyymmdd_HHMM') +"".csv"""
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Campos"" : [""agencia"",""contrato"",""dataInicioContrato"",""Observacoes"",""DataLog"",""Status""]"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Cabecalho"" : false"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "]"
    pCol.add vbTab & vbTab & "};"
    
    
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "// Ambiente de trabalho do robo"
    pCol.add vbTab & vbTab & "for( var y = 0 ; y < objGlobal.arrayFolders.length ; y++ ){ criarAmbiente(objGlobal.pathAmbiente , [objGlobal.arrayFolders[y].caminho] ); }"
    
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "// Repositorio do cliente"
    pCol.add vbTab & vbTab & "criarAmbiente(objGlobal.pathRepositorio, [""Processados""]);"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "// Backup de códigos"
    pCol.add vbTab & vbTab & "criarAmbiente(WshShell.currentDirectory +  ""\\"" , [""bkp""]);"
    
End Function
