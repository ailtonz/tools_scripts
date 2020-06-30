Attribute VB_Name = "teste_conceito"
'
'Private Sheet As Worksheet
'Private cell As Range
'Private tmp As String
'
'Sub carregar_Itens()
''' Worksheet
'Dim wsCopy As Workbook
'
'Application.ScreenUpdating = False
'
'FileToOpen = Application.GetOpenFilename _
'            (Title:="Por favor selecione a planilha para importação de dados", _
'            FileFilter:="Report Files *.xls* (*.xls*),")
'If FileToOpen = False Then
'    MsgBox "Nenhum arquivo selecionado.", vbExclamation, "ERROR - Importação de dados"
'    Exit Sub
'Else
'    Set wsCopy = Workbooks.Open(FileName:=FileToOpen)
'
'    'ActiveWindow.Visible = False
'
'    For Each Sheet In wsCopy.Sheets
'        tmp = tmp + vbNewLine + Sheet.Name
'    Next Sheet
'
'    'ActiveWindow.Visible = True
'
'    wsCopy.Close
'End If
'
'ClipBoardThis tmp
'
'Application.ScreenUpdating = True
'
'End Sub


'Public Sub CopySheetToEndAnotherWorkbook()
'    ActiveSheet.Copy After:=Workbooks("Book1.xlsx").Sheets(Workbooks("Book1.xlsx").Worksheets.Count)
'End Sub
'


'Sub teste_CountRows()
'    Dim myCount As Integer
'    myCount = Selection.Rows.Count
'    MsgBox "This selection contains " & myCount & " row(s)", vbInformation, "Count Rows"
'End Sub
'
'Sub RoundToZero3()
' For Each c In ActiveCell.CurrentRegion.Cells
'    Debug.Print c.Value
' Next
'End Sub
'
'Sub teste_split()
'''https://excelmacromastery.com/excel-vba-array/
'
'Dim arr As Variant: arr = Split("James:Earl:Jones", ":")
'
' For Each c In arr
'    Debug.Print c
' Next
'
'End Sub
'
'Sub teste_listarEpf()
'
'Dim arr As Variant
'Dim str01 As String
'Dim str02 As String
'
'
' For Each c In ActiveCell.CurrentRegion.Cells
'    str01 = Split(c.Value, "|")(1)
'    str02 = Split(c.Value, "|")(0)
'    criarEpf str01, str02
' Next
'End Sub
'
'
'Sub teste_loop()
'
'For Each o In Range("b1:b10")
'
'    Debug.Print o.Value
'
'Next o
'
'End Sub
'
'Sub Example()
'    DownloadFile$ = "someFile.ext" 'here the name with extension
'    URL$ = "http://some.web.address/" & DownloadFile 'Here is the web address
'    LocalFilename$ = "C:\Some\Path" & DownloadFile Or CurrentProject.Path & "\" & DownloadFile 'here the drive and download directory
'    MsgBox "Download Status : " & URLDownloadToFile(0, URL, LocalFilename, 0, 0) = 0
'End Sub

'Sub abrirPipefy()
'
'Dim strURL As String: strURL = "https://pipefy.paas.santanderbr.corp/login" 'Etiqueta("Url_Console")
'Dim strUserName As String: strUserName = "ailton.z.da.silva@avanade.com" 'Etiqueta("Url_Console_userName")
'Dim strUserPass As String: strUserPass = "41L70N@@" 'Etiqueta("Url_Console_userPass")
'
'Dim URL As String: URL = strURL
'Dim ObjIE As Object: Set ObjIE = CreateObject("InternetExplorer.Application")
'
'
'With ObjIE
'  .Visible = True
'  .Navigate (URL)
'
''  Do
''    Sleep (50)
''  Loop Until .ReadyState = 4
'
'End With
'
'With ObjIE.document.forms("new_user")
'  .user_login.value = strUserName
'  .user_password.value = strUserPass
'  .submit
'End With
'
'End Sub



'Sub WebPage()
'
'Application.ScreenUpdating = False
'
'    Dim ws As Worksheet: Set ws = Worksheets("Pipefy")
'    Dim WebUrl As String
'    Dim lRow As Long
'
'
'    ws.Activate
''    If (ws.Name = ActiveSheet.Name) Then
''        lRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
''        For Each cell In ws.Range("$R$2:$R$" & lRow)
''            If (Len(cell.Value) > 0) Then WebUrl = cell.Value
''            Shell ("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -url " & WebUrl)
''        Next cell
''    End If
'
'Application.ScreenUpdating = True
'
'End Sub


'Sub WebPage()
'
'Application.ScreenUpdating = False
'
'    Dim ws As Worksheet: Set ws = Worksheets("Pipefy")
'    Dim LocalFilename As String: LocalFilename = "c:\temp\"
'    Dim WebUrl As String
'    Dim lRow As Long
'
'
'    ws.Activate
'    If (ws.Name = ActiveSheet.Name) Then
'        lRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
'        For Each cell In ws.Range("$R$2:$R$" & lRow)
'            If (Len(cell.Value) > 0) Then WebUrl = cell.Value
'            'Shell ("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -url " & WebUrl)
'
'            URLDownloadToFile 0, WebUrl, LocalFilename, 0, 0
'
'        Next cell
'    End If
'
'Application.ScreenUpdating = True
'
'End Sub


'Sub rdp_PathDefalt(ByVal control As IRibbonControl)
'Dim sCaminho As String
'Dim strCaminhoPadrao As String: strCaminhoPadrao = Etiqueta("caminhoRdp")
'Dim sTitle As String:       sTitle = "Caminho padrão"
'Dim sMessage As String:     sMessage = "Deseja alterar o camimho padrão ( " & strCaminhoPadrao & " ) onde ficará salvas as VMs ?"
'Dim resposta As Variant:    resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
'
'If (resposta = vbYes) Then
'    Select Case StrPtr(resposta)
'        Case 0
'             MsgBox "Atualização cancelada.", 64, sTitle
'            Exit Sub
'        Case Else
'             sCaminho = GetFolder()
'             If (sCaminho <> "") Then
'                ThisWorkbook.Names("caminhoRdp").Value = sCaminho
'                MsgBox "Caminho atualizado para : " & (sCaminho) & ".", 64, sTitle
'             Else
'                MsgBox "Operação cancelada", vbInformation, sTitle
'             End If
'    End Select
'End If
'End Sub


'Sub criarEpf(strPassword As String, strDestinationFile As String)
'Dim obj As New clsEPF
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim strCaminho As String: strCaminho = Application.ActiveWorkbook.Path & "\"
'Dim strAppName As String: strAppName = "GenEpf.exe"
'
'Dim sTitle As String:       sTitle = "Criar arquivo EPF"
'Dim sMessage As String:     sMessage = "Deseja criar um arquivo EPF ?"
'Dim resposta As Variant:    resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
'
'If (resposta = vbYes) Then
'    With obj
'        .strAppPath = strCaminho
'        .strAppName = strAppName
'        .strPassword = strPassword
'        .strDestinationPath = strCaminho
'        .strDestinationFile = strDestinationFile
'        .gerarEpf
'    End With
'Else
'    MsgBox "Operação cancelada", vbInformation, sTitle
'End If
'
'End Sub

''' Sub criarRdpPorSelecao(ByVal control As IRibbonControl)
'Sub criarEpf()
'
'Dim obj As New clsBringTo
'
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim strCaminho As String: strCaminho = Application.ActiveWorkbook.Path & "\"
'Dim strAppName As String: strAppName = "GenEpf.exe"
'
'Dim sTitle As String:       sTitle = "Criar arquivo EPF"
'Dim sMessage As String:     sMessage = "Deseja criar um arquivo EPF ?"
'Dim resposta As Variant:    resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
'
'If (resposta = vbYes) Then
'    With obj
'        .strAppPath = strCaminho
'        .strAppName = strAppName
'        .strPassword = ws.Range("$C$9")
'        .strDestinationPath = strCaminho
'        .strDestinationFile = ws.Range("$C$8")
'        .gerarEpf
'    End With
'Else
'    MsgBox "Operação cancelada", vbInformation, sTitle
'End If
'
'End Sub



'Sub create_FileIni(ByVal control As IRibbonControl)
'Dim o As New cls_file_Ini
'Dim t As String: t = Etiqueta("pathRepository") & ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value & ActiveSheet.Name
'
'With o
'    .strFileName = "Reviatalizacao"
'    .strFilePath = t
'    .strFilePathRepository = ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value
'    .gerarFileIni
'End With
'
'End Sub
'
'Sub create_FileWsf(ByVal control As IRibbonControl)
'Dim o As New cls_file_Wsf
'Dim t As String: t = Etiqueta("pathRepository") & ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value & ActiveSheet.Name
'
'With o
'    .strFileName = "Reviatalizacao"
'    .strFilePath = t
'    .gerarWsf
'End With
'
'End Sub
'
'Sub create_FileJs(ByVal control As IRibbonControl)
'Dim o As New cls_file_js
'Dim t As String: t = Etiqueta("pathRepository") & ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value & ActiveSheet.Name
'
'With o
'    .strFileName = "Pagamentos"
'    .strFilePath = t
'    .gerarJs
'End With
'
'End Sub
'
'Sub create_BatStart(ByVal control As IRibbonControl)
'Dim o As New cls_bat_Start
'Dim t As String: t = Etiqueta("pathRepository") & ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value & ActiveSheet.Name
'
'With o
'    .strFileNameWsf = "Revitalizacao"
'    .strFileNameIni = "Liquidacao"
'    .strFilePathBat = t
'    .strFilePathRobo = ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value
'    .strQtdeMassa = "10"
'    .gerarBatStart
'End With
'
'End Sub
'
'Sub create_BatBkp(ByVal control As IRibbonControl)
'Dim o As New cls_Bat_Bkp
'Dim t As String: t = Etiqueta("pathRepository") & ActiveSheet.Range(Etiqueta("robot_07_Repository")).Value & ActiveSheet.Name
'
'With o
'    .strFileName = ActiveSheet.Range(Etiqueta("robot_02_Name")).Value
'    .strFilePath = t
'    .gerarBatBkp
'End With
'
'End Sub


'
'Sub create_FileWsf(ByVal control As IRibbonControl) '' Criar arquivo wsf
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileWsf")
'
'Dim strFileName As String: strFileName = ""
'Dim strPathFileSource As String: strPathFileSource = ""
'
''' Principal
'Dim o As New cls_file_Wsf
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
''' Consulta a existencia de uma base de dados para carregar funções de controle de fila
'Dim dbDados As New Collection: Set dbDados = GetData()
'
'    '' Carregará apenas itens onde a coluna "Status" estiver diferente de "OK"
'    For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'        If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And ws.Range("$" & ColunaStatus & "$" & linha).Value <> "OK" Then
'
'            strFileName = cell.Value ''Trim(Split(cell.Value, "|")(0))
'            With o
'                .strFileName = strFileName
'                .strFilePath = t
'
'                '' Carrega todos os procedimentos que serão usados no robo
'                .colProcedures = getProcedures
'
'                '' Carrega as bibliotecas marcadas na coluna "Status" com "OK"
'                .colLibrary = getLibrary
'
'                '' Ativar / Desativar a existencia de base(s)
'                .CarregarBase = dbDados.Count
'
'                '' Ambiente do robo - "Caminho do Robo"
'                .strPathEnvironment = ws.Range(Etiqueta("robot_07_Environment")).Value
'
'                '' Repositório onde o robo vai coletar a(s) Base(s)
'                .strPathRepository = ws.Range(Etiqueta("robot_08_Repository")).Value '"%HOMEDRIVE%%HOMEPATH%\\Downloads\\"
'                .gerarWsf
'            End With
'
'            ws.Range("$" & ColunaStatus & "$" & linha).Value = "OK"
'        End If
'        linha = linha + 1
'    Next cell
'
'End Sub

'Sub create_FileEpf(ByVal control As IRibbonControl) '' Criar arquivo epf
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileEpf")
'Dim strPassword As String: strPassword = Etiqueta("robot_FileEpf_Password")
'
''' Principal
'Dim o As New clsEPF
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim pathApp As String: pathApp = Etiqueta("pathApp")
'Dim pathName As String: pathName = "GenEpf.exe"
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
''' Confirmar de execução
'Dim sTitle As String:       sTitle = "Criar arquivo EPF"
'Dim sMessage As String:     sMessage = "Deseja criar um arquivo EPF ?"
'Dim resposta As Variant:    resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
'
'    If (resposta = vbYes) Then
'
'        '' Carregará apenas itens onde a coluna "Status" estiver diferente de "OK"
'        For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'            If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And ws.Range("$" & ColunaStatus & "$" & linha).Value <> "OK" Then
'
'                With o
'                    '' Caminho do app
'                    .strAppPath = pathApp
'                    '' Aplicação de criptografia
'                    .strAppName = pathName
'                    '' Password
'                    .strPassword = strPassword
'                    '' Name file
'                    .strDestinationFile = cell.Value
'                    '' Caminho onde será salvo o arquivo.epf
'                    .strDestinationPath = t
'                    .gerarEpf
'                End With
'
'                ws.Range("$" & ColunaStatus & "$" & linha).Value = "OK"
'            End If
'            linha = linha + 1
'        Next cell
'    End If
'
'End Sub

'Sub create_BatStart(ByVal control As IRibbonControl) '' Criar bat de start do robo
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'
''' Principal
'Dim o As New cls_bat_Start
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim strFilePathRobo As String: strFilePathRobo = ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim strPathRepository As String: strPathRepository = Etiqueta("pathRepository")
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
''' Colecao de filtros
'Dim Col As New Collection
'Col.add Etiqueta("robot_FileWsf")
'Col.add Etiqueta("robot_FileIni")
'Col.add Etiqueta("robot_FileEpf")
'
'Dim item(2) As String
'Dim x As Integer: x = 0
'Dim filtro As Variant
'
''' Consulta a existencia de uma base de dados para carregar funções de controle de fila
'Dim dbDados As New Collection: Set dbDados = getData()
'
'    '' Coleta de dados
'    For Each filtro In Col
'        linha = InicioDaPesquisa
'        For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'            If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, filtro) <> 0 Then
'                item(x) = cell.Value
'                x = x + 1
'            End If
'            linha = linha + 1
'        Next cell
'    Next filtro
'
'    '' Criação do arquivo
'    With o
'        .strFileNameBat = "Exec_" & Left(item(0), Len(item(0)) - 4) & ".bat"
'        .strFileNameWsf = item(0)
'        .strFileNameIni = item(1)
'        .strFileNameEPF = item(2) ''Left(Split(item(2), "|")(0), Len(Split(item(2), "|")(0)) - 4)
'        .strFilePathBat = t
'        .strFilePathRobo = strFilePathRobo
'        .strPathRepository = strPathRepository
'
'        '' Ativar / Desativar a existencia de base(s)
'        .CarregarBase = dbDados.Count
'
'        '' Quantidade padrao
'        .strQtdeMassa = "10"
'
'        .gerarBatStart
'    End With
'
'End Sub

'Sub create_BatBkp(ByVal control As IRibbonControl) '' Criar bat de bkp
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'
''' Principal
'Dim o As New cls_Bat_Bkp
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim sFileName As String: sFileName = ws.Range(Etiqueta("robot_batBkp")).Value
'
'    With o
'        .strFileName = Split(ws.Range(Etiqueta("robot_07_Environment")).Value, "\")(0)
'        .strFilePath = t
'        .gerarBatBkp
'    End With
'
'End Sub

'Sub create_FileRdp(ByVal control As IRibbonControl) '' Criar arquivo rdp
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileRdp")
'Dim strDominio As String: strDominio = Etiqueta("ServerDominio")
'
''' Principal
'Dim o As New clsRdp
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim strFilePathRobo As String: strFilePathRobo = ws.Range(Etiqueta("robot_07_Environment")).Value
'Dim strPathRepository As String: strPathRepository = Etiqueta("pathRepository")
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
'    '' Carregará apenas itens onde a coluna "Status" estiver diferente de "OK"
'    For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'        If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And ws.Range("$" & ColunaStatus & "$" & linha).Value <> "OK" Then
'
'            With o
'                '' Dados para arqivo
'                .strAddress = Trim(Split(cell.Value, "|")(0))
'                .strUserName = strDominio & "\" & CStr(Split(cell.Value, "|")(1))
'                .strUserPass = Trim(Split(cell.Value, "|")(2))
'                .strPath = t
'
'                .gerarRdp
'                .gerarCredencial
'                '' Copia de senha
'                ClipBoardThis Trim(.strUserPass)
'
'            End With
'
'            ws.Range("$" & ColunaStatus & "$" & linha).Value = "OK"
'
'        End If
'        linha = linha + 1
'    Next cell
'
'End Sub


'Sub import_pipefy(ByVal control As IRibbonControl)
'
'MsgBox "pipefy"
'
'End Sub
'
'Sub import_vms(ByVal control As IRibbonControl)
'
'MsgBox "vms"
'
'End Sub
'
'Sub import_epf(ByVal control As IRibbonControl)
'
'MsgBox "epf"
'
'End Sub
'Private Const ColumnIndex As Integer = 2
'Private Const InicioDaPesquisa As Long = 2
'Private selectedRange As Range
'Private cell As Range
'Private x As Long
'
'Sub rdp_importDate(ByVal control As IRibbonControl)
'''' Worksheet
''Dim wsDest As Worksheet: Set wsDest = Worksheets("vms")
''Dim wsCopy As Workbook
''Dim Sheet As Worksheet
''
''ws.Activate
''ws.Visible = IIf(ws.Visible = xlSheetVisible, xlSheetHidden, xlSheetVisible)
''
''If (ws.Visible = xlSheetVisible) Then
'
''    MsgBox "EM TESTES!", vbInformation + vbOKOnly, "rdp_importDate"
'
''End If
'
''
'''' Principal
'''Dim strSenha As String: strSenha = Etiqueta("SenhaPadrao")
''
'''' linhas e colunas
''Dim lCopyLastRow As Long
''Dim lDestLastRow As Long
''
'''' Confirmar de execução
''Dim sTitle As String:       sTitle = "Importar base de VMs"
''Dim sMessage As String:     sMessage = "Deseja importar base de VMs ?"
''Dim resposta As Variant:    resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
''
''If (resposta = vbYes) Then
''    Application.ScreenUpdating = False
''
''    Select Case StrPtr(resposta)
''        Case 0
''             MsgBox "Atualização cancelada.", 64, sTitle
''            Exit Sub
''        Case Else
''            FileToOpen = Application.GetOpenFilename _
''                        (Title:="Por favor selecione a planilha para importação de dados", _
''                        FileFilter:="Report Files *.xls* (*.xls*),")
''            If FileToOpen = False Then
''                MsgBox "Nenhum arquivo selecionado.", vbExclamation, "ERROR - Importação de dados"
''                Exit Sub
''            Else
''                Set wsCopy = Workbooks.Open(Filename:=FileToOpen)
''                For Each Sheet In wsCopy.Sheets
''                      lCopyLastRow = Sheet.Cells(Sheet.Rows.Count, "A").End(xlUp).Row
''                      lDestLastRow = wsDest.Cells(wsDest.Rows.Count, "B").End(xlUp).Offset(1).Row
''                      Sheet.Range("A" & InicioDaPesquisa & ":D" & lCopyLastRow).Copy wsDest.Range("B" & lDestLastRow)
''                      wsDest.Range("A" & lDestLastRow).Value = Sheet.Name
''                Next Sheet
''            End If
''            wsCopy.Close
''    End Select
''
''    Application.ScreenUpdating = True
''End If
'
'End Sub
'
'Sub rdp_open(ByVal control As IRibbonControl)
'
''    MsgBox "EM TESTES!", vbInformation + vbOKOnly, "rdp_open"
'
'''' Worksheet
''Dim ws As Worksheet: Set ws = Worksheets("vms")
''
'''' Principal
''Dim obj As New clsRdp
''Dim strDominio As String: strDominio = Etiqueta("ServerDominio")
''Dim strCaminho As String: strCaminho = Application.ActiveWorkbook.Path & "\Vms\"
''
'''' linhas e colunas
''Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row 'lRow = ws.Cells(Rows.Count, 2).End(xlUp).Offset(1, 0).Row
''
'''' Confirmar de execução
''Dim sTitle As String:       sTitle = "Abrir Vm's (Selecionadas)"
''Dim sMessage As String:     sMessage = "Deseja abrir a(s) VMs selecionado(s) ?"
''Dim resposta As Variant
''
''ws.Activate
''ws.Visible = IIf(ws.Visible = xlSheetVisible, xlSheetHidden, xlSheetVisible)
''
''If (ws.Visible = xlSheetVisible) Then
''
''    '' Base de VM's
''    CreateDir strCaminho
''
''    If (ActiveSheet.Name <> ws.Name) Then
''        ws.Visible = xlSheetVisible
''        ws.Activate
''    Else
''        If Len(Dir(strCaminho, vbDirectory)) > 0 Then
''            resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
''            If (resposta = vbYes) Then
''                Set selectedRange = Application.Selection
''
''                For Each cell In selectedRange.Cells
''                    For x = InicioDaPesquisa To lRow - 1
''                        With obj
''                            If (ws.Range("B" & x).Value = cell.Value And ws.Range("E" & x).Value = "RDP") Then
''                                '' Dados para arqivo
''                                .strAddress = Trim(CStr(ws.Range("B" & x).Value))
''                                .strUserName = strDominio & "\" & CStr(ws.Range("C" & x).Value)
''                                .strUserPass = Trim(CStr(ws.Range("D" & x).Value))
''                                .strPath = IIf(CStr(ws.Range("G" & x).Value) = "", strCaminho, CStr(ws.Range("G" & x).Value))
''                                .strRun = CStr(ws.Range("H" & x).Value)
''                                .gerarRdp
''                                .gerarCredencial
''                                '' Copia de senha
''                                ClipBoardThis Trim(CStr(ws.Range("D" & x).Value))
''                            End If
''                        End With
''                    Next x
''                Next cell
''                Set obj = Nothing
''            End If
''        Else
''            MsgBox "Por favor indique o caminho padrão onde será gravado os arquivos RDP.", vbCritical + vbOKOnly, "Atenção: Caminho padrão não foi criado! "
''        End If
''    End If
''
''End If
'
'End Sub



'Sub open_Repository(ByVal control As IRibbonControl) '' Criar repositorio
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim t As String: t = Etiqueta("pathRepository") & ws.Range(Etiqueta("robot_07_Environment")).Value '& ActiveSheet.Name
'Dim strTemp As String: strTemp = Etiqueta("nameFolders")
'Dim item As Variant
'
'    '' BASE
'    CreateDir t
'
'    For Each item In Split(strTemp, "|")
'        CreateDir t & "\" & item
'    Next
'
'
'    Shell "explorer.exe " + t, vbMaximizedFocus
'
'End Sub

'Function getData() As Collection '' Validar existencia de base de dados
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim var As New Collection
'
''' Principal
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileDb")
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
'    '' Carregará apenas itens onde a coluna "Tarefa" estiver diferente de "vazio"
'    For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'        If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And cell.Value <> "" Then
'            var.add cell.Value
'        End If
'        linha = linha + 1
'    Next cell
'
'    Set getData = var
'End Function

'Function getProcedures() As Collection '' Coleção de procedimentos
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim var As New Collection
'
''' Principal
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileJs")
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
'    '' Carregará apenas itens onde a coluna "Status" estiver igual a "OK"
'    For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'        If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And ws.Range("$" & ColunaStatus & "$" & linha).Value = "OK" Then
'            var.add cell.Value
'        End If
'        linha = linha + 1
'    Next cell
'
'    Set getProcedures = var
'End Function

'Function getLibrary() As Collection '' Coleção de bibliotecas
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim var As New Collection
'
''' Principal
'Dim strFiltro As String: strFiltro = Etiqueta("robot_FileLibrary")
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
'    '' Carregará apenas bibliotecas marcadas na coluna "Status" com "OK"
'    For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'        If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, strFiltro) <> 0 And ws.Range("$" & ColunaStatus & "$" & linha).Value = "OK" Then
'            var.add cell.Value
'        End If
'        linha = linha + 1
'    Next cell
'
'    Set getLibrary = var
'End Function

'Function ADM_List_Itens(ByVal control As IRibbonControl) '' Listar itens do robo atual para ajuda no copy/paste na console
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim t As String: t = ws.Range(Etiqueta("robot_06_Help_name")).Value
'
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'Dim strFiltro As String
'Dim notas As New clsNotas
'
''' Colecao de filtros
'Dim colNotas As New clsNotas
'Dim recNotas As clsNotas
'Dim filtro As clsNotas
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileWsf")
'        .strNotes = t
'        .strPath = ws.Range(Etiqueta("robot_07_Environment")).Value
'        colNotas.add recNotas
'    End With
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileJs")
'        .strNotes = t
'        .strPath = ws.Range(Etiqueta("robot_07_Environment")).Value
'        colNotas.add recNotas
'    End With
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileIni")
'        .strNotes = t
'        .strPath = ws.Range(Etiqueta("robot_07_Environment")).Value
'        colNotas.add recNotas
'    End With
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileEpf")
'        .strNotes = "Credenciais\TFC\"
'        colNotas.add recNotas
'    End With
'
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileRdp")
'        colNotas.add recNotas
'    End With
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_FileLibrary")
'        colNotas.add recNotas
'    End With
'
'    Set recNotas = New clsNotas
'    With recNotas
'        .strName = Etiqueta("robot_Users")
'        colNotas.add recNotas
'    End With
'
'
'    '' criar tmp_file apenas para apresentacao
'    Dim pathExit As String: pathExit = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\tmp_file" & ".txt"
'    If (Dir(pathExit) <> "") Then Kill pathExit
'
'    For Each filtro In colNotas.Itens
'        linha = InicioDaPesquisa
'        '' Coleta e saida de pesquisa
'        TextFile_Append pathExit, vbNewLine & "[" & filtro.strName & "]" & vbNewLine
'
'        For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'            If InStr(ws.Range("$" & ColunaTipoDeArquivo & "$" & linha).Value, filtro.strName) <> 0 Then
'                TextFile_Append pathExit, filtro.strNotes & cell.Value & vbNewLine & filtro.strPath
'            End If
'            linha = linha + 1
'        Next cell
'
'    Next filtro
'
'    Shell "notepad.exe " & pathExit, vbMaximizedFocus
'
'    Kill pathExit
'
'End Function

'Sub ADM_create_debugger(ByVal control As IRibbonControl) '' Criar wsf para testes genericos
'Dim t As String: t = CreateObject("WScript.Shell").SpecialFolders("Desktop") ' Etiqueta("pathRepository")
'Dim o As New cls_file_debugger
'
'    '' Wsf
'    With o
'        .strFileName = "debugger.wsf"
'        .strFilePath = t
'        .gerarWsf
'    End With
'
'    Shell "notepad.exe " & t & "\debugger.wsf", vbMaximizedFocus
'
'End Sub


