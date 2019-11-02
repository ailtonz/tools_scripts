VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_obj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Public Function objGlobal(ByRef pCol As Collection)
'
'    pCol.Add vbNewLine
'    pCol.Add vbTab & vbTab & "var objGlobal = new Array();"
'    pCol.Add vbTab & vbTab & "objGlobal = { ""pathAmbiente"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\"" "
'    pCol.Add vbTab & vbTab & vbTab & ",""pathExecucao"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\Arquivos\\"" "
'    pCol.Add vbTab & vbTab & vbTab & ",""pathFilaEspera"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\Arquivos\\filaDeEspera\\"" "
'    pCol.Add vbTab & vbTab & vbTab & ",""pathProcessados"" : ""\\\\MSCLUSTER12FS\\DIGITACAOMCR\\ROBO\\MASSA\\"" "
'    pCol.Add vbTab & vbTab & vbTab & ",""fileOrdemPagamento"" : logData.format('yyyymmdd_HHMM') + ""_OrdemDePagamento.csv"" "
'    pCol.Add vbTab & vbTab & vbTab & ",""arrayPathProcessados"" : [{""caminho"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\Arquivos\\filaProcessados\\""}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""\\\\MSCLUSTER12FS\\DIGITACAOMCR\\ROBO\\MASSA\\Processados\\""}]"""
'    pCol.Add vbTab & vbTab & vbTab & ",""arrayPathLog"" : [{""caminho"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\Processados\\""}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : WshShell.currentDirectory + ""\\GestaoDeQualidade\\Revitalizacao\\Arquivos\\""}]"""
'    pCol.Add vbTab & vbTab & vbTab & ",""arrayFolders"" : [{""caminho"" : ""Arquivos""}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""Processados""}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""\\Arquivos\\filaDeEspera""}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",{""caminho"" : ""\\Arquivos\\filaProcessados""}]"
'    pCol.Add vbTab & vbTab & vbTab & "};"
'
'End Function
'
'Public Function objGenerico(ByRef pCol As Collection)
'
'    pCol.Add vbNewLine
'    pCol.Add vbTab & vbTab & "var objOperacao = new Array();"
'    pCol.Add vbTab & vbTab & "objOperacao = { ""pathRepositorio"": objGlobal.pathProcessados"
'    pCol.Add vbTab & vbTab & vbTab & ",""FiltrarArquivo"": ""ParcelaVencida"""
'    pCol.Add vbTab & vbTab & vbTab & ",""arrayLog"" : ["
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "{""Arquivo"": objGlobal.arrayPathLog[0].caminho + ""Rev_""+ logData.format('yyyymmdd_HHMM') +"".csv"""
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Campos"" : [""agencia"",""contrato"",""dataInicioContrato"",""Observacoes"",""DataLog"",""Status""]"""
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "},{"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "{""Arquivo"": objGlobal.arrayPathLog[1].caminho + ""Rev_""+ logData.format('yyyymmdd_HHMM') +"".csv"""
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Campos"" : [""agencia"",""contrato"",""dataInicioContrato"",""Observacoes"",""DataLog"",""Status""]"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
'    pCol.Add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "]};"
'
'End Function
