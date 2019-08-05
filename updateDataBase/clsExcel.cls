VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsExcel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim whk As Workbook
Dim sht As New Worksheet
Dim apl As New Excel.Application


Function ctrlHorasTecnicas(sWorkPath As Workbook, sSheet As String, sUserName As String, sFileName As String) As String
Dim FileName As New clsPathAndFiles
Dim NewBook  As New Workbook: Set NewBook = Workbooks.Add

Dim tmpFileName As String: tmpFileName = FileName.PathGetDesktopAddress & sFileName

' APAGAR A PLANILHA DE CTRL DE HORAS CASO EXISTA NO DESKTOP
If FileName.FileExist(tmpFileName) Then
    Kill tmpFileName
End If


With NewBook
    
    apl.DisplayAlerts = False
    
    .Title = Trim(Left(StrReverse(Split(StrReverse(sFileName), "-")(0)), Len(StrReverse(Split(StrReverse(sFileName), "-")(0))) - 5))
    .Subject = Trim(StrReverse(Split(StrReverse(sFileName), "-")(1)))
        
    ' ATIVAR GUIA
    sWorkPath.Worksheets(sSheet).Visible = xlSheetVisible
    sWorkPath.Worksheets(sSheet).Activate
        
    ' COPIAR A GUIA DE CTRL DE HORAS
    sWorkPath.Worksheets(sSheet).Copy before:=.Sheets(1)
    
    ' DESATIVAR GUIA
'    sWorkPath.Worksheets(sSheet).Visible = xlSheetVeryHidden
    
    ' APAGAR GUIA SEM USO
    .Sheets(2).Delete
'    ' APAGAR COLUNAS DE CONTROLE INTERNO
'    .Sheets(1).Range("h:t").Delete
    ' SELECIONAR A PRIMEIRA CELULA
    .Sheets(1).Range("a1").Select
    ' RENOMEAR GUIA
    .Sheets(1).Name = sUserName
    ' SALVAR A NOVA PLANILHA
    .SaveAs FileName:=tmpFileName
    .Close
    
    apl.DisplayAlerts = True
    
End With

Set FileName = Nothing

ctrlHorasTecnicas = tmpFileName

End Function

Sub ctrlHorasTecnicasK2(sWorkPath As Workbook, sSheet As String, sUserName As String, sFileName As String)
Dim FileName As New clsPathAndFiles
Dim NewBook  As New Workbook: Set NewBook = Workbooks.Add

' APAGAR A PLANILHA DE CTRL DE HORAS CASO EXISTA NO DESKTOP
If FileName.FileExist(sFileName) Then
'    Kill FileName.PathGetDesktopAddress & sFileName
End If


With NewBook
'    .Title = Trim(Left(StrReverse(Split(StrReverse(sFileName), "-")(0)), Len(StrReverse(Split(StrReverse(sFileName), "-")(0))) - 5))
'    .Subject = Trim(StrReverse(Split(StrReverse(sFileName), "-")(1)))
        
    ' ATIVAR GUIA
    sWorkPath.Worksheets(sSheet).Visible = xlSheetVisible
    sWorkPath.Worksheets(sSheet).Activate
    
    ' COPIAR A GUIA DE CTRL DE HORAS
    sWorkPath.Worksheets(sSheet).Copy before:=.Sheets(1)
    
    ' DESATIVAR GUIA
    sWorkPath.Worksheets(sSheet).Visible = xlSheetVeryHidden
    
    ' APAGAR GUIA SEM USO
'    .Sheets(2).Delete
    ' SELECIONAR A PRIMEIRA CELULA
'    .Sheets(1).Range("a1").Select
    ' SALVAR A NOVA PLANILHA
    .SaveAs FileName:=FileName.PathGetDesktopAddress & sFileName
    .Close
End With

Set FileName = Nothing

End Sub

Sub ctrlCronograma(sWorkPath As Workbook, sSheet As String, sUserName As String, sFileName As String)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' SEPARAR GUIA SELECIONADA EM NOVO ARQUIVO.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'' DECLARAÇÃO DE VARIAVEIS
Dim FileName As New clsPathAndFiles
Dim NewBook  As New Workbook: Set NewBook = Workbooks.Add

' APAGAR A PLANILHA DE CTRL DE HORAS CASO EXISTA NO DESKTOP
If FileName.FileExist(FileName.PathGetDesktopAddress & sFileName) Then
    Kill FileName.PathGetDesktopAddress & sFileName
End If

With NewBook
    '' CADASTRO DE TITLE E SUBJECT
    .Title = Trim(Left(StrReverse(Split(StrReverse(sFileName), "-")(0)), Len(StrReverse(Split(StrReverse(sFileName), "-")(0))) - 5))
    .Subject = Trim(StrReverse(Split(StrReverse(sFileName), "-")(1)))
        
    ' ATIVAR GUIA
    sWorkPath.Worksheets(sSheet).Activate
        
    ' COPIAR A GUIA DE CTRL DE HORAS
    sWorkPath.Worksheets(sSheet).Copy before:=.Sheets(1)
        
    ' APAGAR GUIA SEM USO
    .Sheets(2).Delete
    ' SELECIONAR A PRIMEIRA CELULA
    .Sheets(1).Range("a1").Select
    ' SALVAR A NOVA PLANILHA
    .SaveAs FileName:=FileName.PathGetDesktopAddress & sFileName
    ' FECHAR
    .Close
End With

Set FileName = Nothing

End Sub

Sub listModules()

Dim obj As Variant
For Each obj In ActiveWorkbook.VBProject.VBComponents
    If obj.Type = 1 Then
        Debug.Print obj.Name
    End If
Next

End Sub

Public Function SheetProtect(pWorkPath As String, ByVal Senha As String)
Dim x As Long
    
Set whk = apl.Workbooks.Open(pWorkPath)
    
For x = 1 To whk.Worksheets.count
    whk.Sheets(x).Select
    apl.Cells.Select
    apl.ActiveSheet.Protect Senha, DrawingObjects:=True, Contents:=True, Scenarios:=True
    whk.Sheets(x).Range("A1").Select
Next x
   
whk.Save
whk.Close
apl.Quit

End Function

Public Function SheetUnprotect(pWorkPath As String, ByVal Senha As String)
Dim x As Long

Set whk = apl.Workbooks.Open(pWorkPath)
    
For x = 1 To whk.Worksheets.count
    whk.Sheets(x).Select
    apl.Cells.Select
    apl.ActiveSheet.Unprotect Senha
    whk.Sheets(x).Range("A1").Select
Next x

whk.Sheets(1).Select
    
whk.Save
whk.Close
apl.Quit
        
End Function

Sub FileDelimited(pPathAndFileName As String, Optional pOtherChar As String = "|")
    apl.Workbooks.OpenText FileName:=pPathAndFileName, DataType:=xlDelimited, Tab:=True, Other:=True, OtherChar:=pOtherChar
End Sub

Sub AjusteCursor(pWorkPath As String)
Set whk = apl.Workbooks.Open(pWorkPath)

Dim x As Long
    
For x = 1 To whk.Worksheets.count
    whk.Sheets(x).Select
    whk.Sheets(x).Range("A1").Activate
Next x

whk.Save
whk.Close
apl.Quit

End Sub

Function AreaDeImpressao(pWorkPath As String, pSheet As String, Selecao As String)
Set whk = apl.Workbooks.Open(pWorkPath)
    
whk.Worksheets(pSheet).Activate
whk.ActiveSheet.PageSetup.PrintArea = Selecao

whk.Save
whk.Close
apl.Quit

End Function

Sub ConfigurarPagina(pWorkPath As String, pSheet As String)
Dim MesAno As String
Dim TMesAno As String
Dim TITULO As String
Dim TTitulo As String

Set whk = apl.Workbooks.Open(pWorkPath)
    
whk.Worksheets(pSheet).Activate

MesAno = UCase(Format(Now, "mmmm/yyyy"))
TMesAno = 16
TITULO = ""
TTitulo = 0


    With whk.ActiveSheet.PageSetup
        .PrintTitleRows = ""
        .PrintTitleColumns = ""
    End With
    
    whk.ActiveSheet.PageSetup.PrintArea = ""
    
    With whk.ActiveSheet.PageSetup
        .LeftHeader = ""
        .CenterHeader = "&""Arial,Negrito""&" + TTitulo + TITULO
        .RightHeader = "&""Arial,Negrito""&" + TMesAno + MesAno
        .LeftFooter = ""
        .CenterFooter = "&F" & Chr(10) & "&A"
        .RightFooter = "&D - &T &P / &N"
        .LeftMargin = Application.InchesToPoints(0.787401575)
        .RightMargin = Application.InchesToPoints(0.787401575)
        .TopMargin = Application.InchesToPoints(0.984251969)
        .BottomMargin = Application.InchesToPoints(0.984251969)
        .HeaderMargin = Application.InchesToPoints(0.492125985)
        .FooterMargin = Application.InchesToPoints(0.492125985)
        .PrintHeadings = False
        .PrintGridlines = False
        .PrintComments = xlPrintNoComments
        .PrintQuality = 600
        .CenterHorizontally = False
        .CenterVertically = False
        '.Orientation = xlPortrait
        .Orientation = xlLandscape
        .Draft = False
        .PaperSize = xlPaperLetter
        .FirstPageNumber = xlAutomatic
        .Order = xlDownThenOver
        .BlackAndWhite = False
        .Zoom = 100
        .PrintErrors = xlPrintErrorsDisplayed
    End With
    
whk.Save
whk.Close
apl.Quit

End Sub

Sub FooterUpdate(pWorkPath As String, pSheet As String)
Set whk = apl.Workbooks.Open(pWorkPath)
    
whk.Worksheets(pSheet).Activate
whk.ActiveSheet.PageSetup.LeftFooter = apl.ActiveWorkbook.FullName

whk.Save
whk.Close
apl.Quit

End Sub

Sub ContarColunasSelecionadas(pWorkPath As String, pSheet As String)
Dim areaCount As Variant
Dim i As Long

Set whk = apl.Workbooks.Open(pWorkPath)

whk.Worksheets(pSheet).Activate
areaCount = apl.Selection.Areas.count

If areaCount <= 1 Then
    MsgBox "The selection contains " & _
        apl.Selection.Columns.count & " columns."
Else
    For i = 1 To areaCount
        MsgBox "Area " & i & " of the selection contains " & _
            apl.Selection.Areas(i).Columns.count & " columns."
    Next i
End If

apl.Quit

End Sub

Public Function SheetDelete(pWorkPath As String, pSheet As String)
Dim x As Long

Set whk = apl.Workbooks.Open(pWorkPath)

For x = 1 To whk.Worksheets.count
    If whk.Sheets(x).Name = pSheet Then
        apl.DisplayAlerts = False
        whk.Sheets(x).Delete
        whk.Save
        whk.Close
        apl.DisplayAlerts = True
        apl.Quit
        Exit For
    End If
Next x

End Function

Function FormatarBordas(pWorkPath As String, pSheet As String, Selecao As String)
Dim Matriz As Variant

Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)


With sht.Range(Selecao).Borders(xlInsideHorizontal)
    .LineStyle = xlContinuous
    .Weight = xlThin
    .ColorIndex = xlAutomatic
End With
    
whk.Save
whk.Close
apl.Quit
    
End Function

Sub HistoricoDeArquivosRecentes(pWorkPath As String)

    Application.RecentFiles.Add Name:=pWorkPath

End Sub

Sub SheetAdd(pWorkPath As String, pSheetName As String)
Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets.Add(Type:=xlWorksheet)

sht.Name = pSheetName
    
whk.Save
whk.Close
apl.Quit

End Sub

Function LimparTemplate(pWorkPath As String, pSheet As String, Selecao As String, Conteudo As Variant)
Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)

With sht.Range(Selecao)
    .Value = Conteudo
End With

whk.Save
whk.Close
apl.Quit
    
End Function

Sub XmlOpenFile(pPathAndFileName As String)
    Dim oWX As Workbook
    Set oWX = Workbooks.OpenXML(pPathAndFileName)
End Sub

Sub XmlFileAsList(pPathAndFileName As String)
    Dim oWX As Workbook
    Set oWX = Workbooks.OpenXML(FileName:=pPathAndFileName, LoadOption:=XlXmlLoadOption.xlXmlLoadImportToList)
End Sub

Function OcultarLinhas(pWorkPath As String, pSheet As String, LinhaInicio As Long, LinhaFinal As Long, Optional ocultar As Boolean = True)
Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)

With sht
    sht.Rows(CStr(LinhaInicio) & ":" & CStr(LinhaFinal)).Rows.EntireRow.Hidden = ocultar
End With

whk.Save
whk.Close
apl.Quit

End Function

Function IntervaloEditacaoCriar(pWorkPath As String, pSheet As String, Senha As String, TituloDoIntervaloDeEdicao As String, Selecao As String)
On Error GoTo IntervaloEditacaoCriar_err
On Error Resume Next

Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)

With sht
    .Unprotect Senha
    .Protection.AllowEditRanges.Add Title:=TituloDoIntervaloDeEdicao, Range:=.Range(Selecao)
    .Protect Senha
End With
   

IntervaloEditacaoCriar_Fim:
whk.Save
whk.Close
apl.Quit

Exit Function

IntervaloEditacaoCriar_err:
    MsgBox err.Description
    Resume IntervaloEditacaoCriar_Fim
End Function

Function IntervaloEditacaoRemover(pWorkPath As String, pSheet As String, Senha As String, TituloDoIntervaloDeEdicao As String)
Dim AER As AllowEditRange

Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)

For Each AER In sht.Protection.AllowEditRanges
    If AER.Title = TituloDoIntervaloDeEdicao Then
        sht.Unprotect Senha
        sht.Protection.AllowEditRanges(TituloDoIntervaloDeEdicao).Delete
        sht.Protect Senha
    End If
Next AER
    
whk.Save
whk.Close
apl.Quit

End Function

Function listarRange(pWorkPath As String, pSheet As String, sRange As String) As String
Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)
Dim Rng As Range

For Each Rng In sht.Range(sRange)
    listarRange = listarRange & ";" & Rng.Value
Next Rng

whk.Close
apl.Quit

End Function

Function MarcaTexto(pWorkPath As String, pSheet As String, Senha As String, sRange As String) As String
On Error GoTo Procedimento_err
Set whk = apl.Workbooks.Open(pWorkPath)
Set sht = whk.Worksheets(pSheet)
Dim Rng As Range

sht.Unprotect Senha

With sht.Range(sRange).Interior
        .Pattern = xlGray25
        .PatternColorIndex = xlAutomatic
        .ColorIndex = xlAutomatic
End With

sht.Protect Senha

Procedimento_Fim:
whk.Save
whk.Close
apl.Quit

Exit Function

Procedimento_err:
    MsgBox err.Description
    Resume Procedimento_Fim
End Function

Sub NewTask()
    With CreateObject("Outlook.Application").CreateItem(3)
        .Subject = "TESTE DE SCRIPT"
        .StartDate = Now
        .DueDate = Now
        .ReminderSet = True
        .ReminderTime = .DueDate - 3 + TimeValue("8:30AM")
        .Body = "TESTE ..." & vbNewLine & vbNewLine & "Ass. Ailton"
        .Save
    End With


End Sub


Function EnviarEmail(strEmail As String, strAssunto As String, Optional strConteudo As String = "", Optional FileNames As Variant = "", Optional sLabel As String)
On Error GoTo Enviar_err

Dim OutApp As Object
Dim OutMail As Object
Dim i As Long

    Set OutApp = CreateObject("Outlook.Application")
    Set OutMail = OutApp.CreateItem(0)

    On Error Resume Next
    With OutMail
        .To = strEmail
        .CC = ""
        .BCC = ""
        If sLabel <> "" Then
            .Subject = "[" & sLabel & "] " & strAssunto
        Else
            .Subject = strAssunto
        End If
'        .Body = strConteudo
        .htmlbody = strConteudo
        
        ' ADICIONAR UM OU MAIS ARQUIVOS EM ANEXO
        If IsArray(FileNames) Then
            For i = LBound(FileNames) To UBound(FileNames)
                .Attachments.Add FileNames(i)
            Next i
        End If
        
        .Send
        DoEvents
    End With
    On Error GoTo 0

Enviar_Fim:
    Set OutMail = Nothing
    Set OutApp = Nothing

    Exit Function
Enviar_err:
    MsgBox err.Description
    Resume Enviar_Fim

End Function

Function Controle() As String
    Controle = Right(Year(Now()), 2) & Format(Month(Now()), "00") & Format(Day(Now()), "00") & "-" & Format(Hour(Now()), "00") & Format(Minute(Now()), "00") & Format(Second(Now()), "00")
End Function

Public Function Saida(strConteudo As String, strArquivo As String)
    Open CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function

Sub clear_immediate()
    SendKeys "^g ^a {DEL}"
End Sub

Sub StatusBar(msg As String)

If Len(msg) > 0 Then
    apl.DisplayStatusBar = True
    apl.StatusBar = msg
Else
    apl.DisplayStatusBar = False
End If
DoEvents

End Sub

'Function SelecionarGuiaAtual()
'    Sheets(ActiveSheet.Name).Select
'End Function
'
'Function PesquisaNomeGuia(sGuia As String) As Boolean
'Dim s As Integer
'    For s = 1 To Sheets.Count
'        If Sheets(s).Name = sGuia Then
'            PesquisaNomeGuia = True
'        End If
'    Next
'End Function
'
'Function ContarAreaPreechida(area As Range) As Long
'    Dim celula As Range, Contador As Long
'    Contador = 0
'    For Each celula In area
'        If celula <> "" Then
'            Contador = Contador + 1
'        End If
'    Next
'    ContarAreaPreechida = Contador
'End Function
'
'Sub SheetsHide()
'    Dim tmpInt As Integer
'    On Error Resume Next
'    For tmpInt = 2 To Sheets.Count
'        Worksheets(tmpInt).Visible = xlSheetVeryHidden
'    Next
'End Sub
'
'Function WorkbookIsOpen(pName As String) As Boolean
'    Dim iWb As Workbook
'    For Each iWb In Application.Workbooks
'        If iWb.Name = pName Then
'            WorkbookIsOpen = True
'            Exit For
'        End If
'    Next
'End Function
'
'Function ColumnLetter(pNumber As Long) As String
'    If pNumber > Columns.Count Then pNumber = pNumber Mod Columns.Count
'    ColumnLetter = Split(Cells(1, pNumber).Address(True, False), "$")(0)
'End Function
'
'Function WorksheetExist(WorksheetName As String) As Boolean
'Dim Sheet As Worksheet
'
'For Each Sheet In ActiveWorkbook.Worksheets
'    If Sheet.Name = WorksheetName Then
'        WorksheetExist = True
'        Exit Function
'    End If
'Next Sheet
'
'WorksheetExist = False
'End Function
'
'

'Sub ShowLinks()
'
'Dim colRange As Collection
'
'Dim rng As Range
'Dim c As Range
'Dim sht As Worksheet
'
'Set colRange = New Collection
'
'For Each sht In ThisWorkbook.Worksheets
'
'Set rng = Nothing
'On Error Resume Next
'Set rng = sht.Cells.SpecialCells(xlCellTypeFormulas)
'On Error GoTo 0
'
'    If Not rng Is Nothing Then
'        For Each c In rng
'            If InStr(1, c.Formula, "!") > 0 Then 'references another sheet
'            colRange.Add sht.Name & "." & c.Address & " - Fórmula(" & c.Formula & ")"
'            End If
'        Next c
'    End If
'Next
'
'MsgBox colRange.Count
'
'Set rng = Nothing
'Set sht = Nothing
'End Sub


''Sub TESTE_01()
''
''Dim ws As Worksheet
''Dim rng As Range
''Dim sValor As String
''
''Set ws = Worksheets(ActiveSheet.Name)
''
''For Each rng In ws.Range("Analista")
''    sValor = sValor & rng.Value
''Next rng
''
''MsgBox sValor
''
''End Sub
'
'
'
''Sub teste()
''    Dim ws As Worksheet
''    Set ws = Worksheets(ActiveSheet.Name)
''
''    Dim rng As Range
''
''    'Set rng = ws.Range(Cells(1, 1), Cells(Range("C" & Rows.Count).End(xlUp).Row, Cells(1, Columns.Count).End(xlToLeft).Column))
''    Set rng = ws.Range(Cells(1, 1), Cells(Range("C" & Rows.Count).End(xlUp).Row, Cells(1, Columns.Count).End(xlToLeft).Column))
''
''
''
''    MsgBox rng.Address
''
''
''
''End Sub

'Function listEmails(sRange As Range) As String
'Dim strResult As String
'Dim c As Range
'
'strResult = ""
'
'For Each c In sRange
'    strResult = strResult & IIf(strResult = "", "", ";") & c
'Next
'
'listEmails = strResult
'End Function
'
'Sub teste_listarRange()
'
'    Debug.Print listarRange("Cadastros")
'
'End Sub
'
'Function listarRange(sRange As String) As String
''Dim rngCadastro As Range: Set rngCadastro = ActiveSheet.Range(sRange)
'
'Dim rng As Range
'
'For Each rng In ActiveSheet.Range(sRange)
'    listarRange = listarRange & " - " & rng.Value
'Next rng
'
'End Function

