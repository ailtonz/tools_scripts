Attribute VB_Name = "mdlMain"
'' [ imageMSO ]
'' https://bert-toolkit.com/imagemso-list.html

'' [ git ]
'' https://githowto.com/pt-BR/create_a_project

Private Const ColumnIndex As Integer = 3
Private Const InicioDaPesquisa As Long = 12
Private Const ColunaTipoDeArquivo As String = "C"
Private Const ColunaStatus As String = "E"
Private Const ColunaTarefa As String = "D"
Private cell As Range
Private strBody As String
Private tmp As String

Option Explicit

Private Sub create_FileTxt(ByVal control As IRibbonControl)
'https://www.automateexcel.com/vba/cut-copy-paste-with-macro/

Dim ws As Worksheet
Set ws = Worksheets(ActiveSheet.Name)
 
Dim lRow As Long, x As Long
lRow = ws.Cells(Rows.Count, 2).End(xlUp).Offset(1, 0).Row
 
Dim t As Variant
Dim tmp As String: tmp = ""
Dim cSaida As New Collection
Dim pathExit As String: pathExit = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\" & ActiveSheet.Name & ".txt"
If (Dir(pathExit) <> "") Then Kill pathExit
    
    For x = 2 To lRow - 1
        cSaida.add CStr(ws.Range("E" & x).Value) & vbNewLine
    Next x
 
    For Each t In cSaida
        tmp = tmp & t
    Next
    
    TextFile_Append pathExit, tmp
    
    ClipBoardThis tmp
 
    Shell "notepad.exe " & pathExit, vbMaximizedFocus

        
End Sub

Sub create_runUrl()

Dim ws As Worksheet
Set ws = Worksheets(ActiveSheet.Name)

Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
lRow = ws.Cells(Rows.Count, 2).End(xlUp).Offset(1, 0).Row

'' Source
Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")

'' File path
Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".txt"
If (Dir(pathExit) <> "") Then Kill pathExit

    '' Build file text
    For Each t In ws.Range("E2:E" & lRow).SpecialCells(xlCellTypeVisible)
        tmp = tmp & t & vbNewLine
    Next
    TextFile_Append pathExit, tmp
    
    '' Build script
    Dim objFile As New cls_file_AutoIt
    objFile.runUrl ActiveSheet.Name, Etiqueta("appAutoIt")
    
    '' Kill pathExit
    If (Dir(pathExit) <> "") Then Kill pathExit
        
End Sub

Sub create_runMouse()
   
'' Build script
Dim objFile As New cls_file_AutoIt
objFile.runMouse Etiqueta("appAutoIt")
        
End Sub

Private Sub create_NewFile(ByVal control As IRibbonControl)
'' Copiar a guia atual para um novo arquivo

Dim ws As Worksheet
Set ws = Worksheets(ActiveSheet.Name)

ws.Copy

Dim pathExit As String: pathExit = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\" & ActiveSheet.Name & ".xlsx"
If (Dir(pathExit) <> "") Then Kill pathExit

ActiveWorkbook.SaveAs FileName:=pathExit, FileFormat:=xlOpenXMLWorkbook, CreateBackup:=False

End Sub


Sub jsonTraining()
Dim jsonItems As New Collection
Dim jsonDictionary As New Dictionary
Dim jsonFileObject As New FileSystemObject
Dim jsonFileExport As TextStream

'' Worksheet
Dim ws As Worksheet: Set ws = Worksheets("training")
Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
Dim ColumnIndex  As Integer: ColumnIndex = 2
Dim RowIndex  As Integer: RowIndex = 2
lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Offset(1, 0).Row

'' Source
Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")
Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".json"
If (Dir(pathExit) <> "") Then Kill pathExit

For i = RowIndex To lRow - 1

    jsonDictionary("categoria") = CStr(Trim(ws.Range("C" & i).Value))
    jsonDictionary("descricao") = CStr(Trim(ws.Range("D" & i).Value))
    jsonDictionary("link") = CStr(Trim(ws.Range("E" & i).Value))
    jsonDictionary("conta") = CStr(Trim(ws.Range("F" & i).Value))
    jsonDictionary("senha") = CStr(Trim(ws.Range("G" & i).Value))

    jsonItems.add jsonDictionary
    Set jsonDictionary = Nothing

Next i

Set jsonFileExport = jsonFileObject.CreateTextFile(pathExit, True)
jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))

Shell "notepad.exe " & pathExit, vbMaximizedFocus

End Sub


Sub jsonContatos()
'Dim jsonItems As New Collection
'Dim jsonDictionary As New Dictionary
'Dim jsonFileObject As New FileSystemObject
'Dim jsonFileExport As TextStream
'
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets("contatos")
'Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
'Dim ColumnIndex  As Integer: ColumnIndex = 2
'Dim RowIndex  As Integer: RowIndex = 2
'lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Offset(1, 0).Row
'
''' Source
'Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")
'Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".json"
'If (Dir(pathExit) <> "") Then Kill pathExit
'
'
'For Each t In ws.Range("C2:F" & lRow).SpecialCells(xlCellTypeVisible).Columns
'    For i = 1 To 4
'
'        jsonDictionary("area") = CStr(Trim(ws.Range(t & i).Value))
'
'        jsonDictionary("area") = CStr(Trim(ws.Range("B" & i).Value))
'        jsonDictionary("nome") = CStr(Trim(ws.Range("C" & i).Value))
'        jsonDictionary("email") = CStr(Trim(ws.Range("D" & i).Value))
'        jsonDictionary("obs") = CStr(Trim(ws.Range("E" & i).Value))
'
'        jsonItems.add jsonDictionary
'        Set jsonDictionary = Nothing
'
'    Next i
'
'Next
'
'Set jsonFileExport = jsonFileObject.CreateTextFile(pathExit, True)
'jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))
'
'Shell "notepad.exe " & pathExit, vbMaximizedFocus

End Sub



'Sub jsonContatos()
'Dim jsonItems As New Collection
'Dim jsonDictionary As New Dictionary
'Dim jsonFileObject As New FileSystemObject
'Dim jsonFileExport As TextStream
'
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets("contatos")
'Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
'Dim ColumnIndex  As Integer: ColumnIndex = 2
'Dim RowIndex  As Integer: RowIndex = 2
'lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Offset(1, 0).Row
'
''' Source
'Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")
'Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".json"
'If (Dir(pathExit) <> "") Then Kill pathExit
'
'For i = RowIndex To lRow - 1
'
'    jsonDictionary("area") = CStr(Trim(ws.Range("B" & i).Value))
'    jsonDictionary("nome") = CStr(Trim(ws.Range("C" & i).Value))
'    jsonDictionary("email") = CStr(Trim(ws.Range("D" & i).Value))
'    jsonDictionary("obs") = CStr(Trim(ws.Range("E" & i).Value))
'
'    jsonItems.add jsonDictionary
'    Set jsonDictionary = Nothing
'
'Next i
'
'Set jsonFileExport = jsonFileObject.CreateTextFile(pathExit, True)
'jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))
'
'Shell "notepad.exe " & pathExit, vbMaximizedFocus
'
'End Sub


Sub jsonLinks()
Dim jsonItems As New Collection
Dim jsonDictionary As New Dictionary
Dim jsonFileObject As New FileSystemObject
Dim jsonFileExport As TextStream

'' Worksheet
Dim ws As Worksheet: Set ws = Worksheets("links")
Dim lRow As Long, x As Long, t As Variant, tmp As String: tmp = ""
Dim ColumnIndex  As Integer: ColumnIndex = 2
Dim RowIndex  As Integer: RowIndex = 2
lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Offset(1, 0).Row

'' Source
Dim pathSource As String: pathSource = CreateObject("WScript.Shell").SpecialFolders("Desktop")
Dim pathExit As String: pathExit = pathSource & "\" & ActiveSheet.Name & ".json"
If (Dir(pathExit) <> "") Then Kill pathExit

For i = RowIndex To lRow - 1
    jsonDictionary("categoria") = CStr(Trim(ws.Range("B" & i).Value))
    jsonDictionary("link") = CStr(Trim(ws.Range("C" & i).Value))
    jsonDictionary("conta") = CStr(Trim(ws.Range("D" & i).Value))
    jsonDictionary("descricao") = CStr(Trim(ws.Range("E" & i).Value))
    
    jsonItems.add jsonDictionary
    Set jsonDictionary = Nothing

Next i

Set jsonFileExport = jsonFileObject.CreateTextFile(pathExit, True)
jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))

Shell "notepad.exe " & pathExit, vbMaximizedFocus

End Sub




'Sub send_communication_current(ByVal control As IRibbonControl) '' Enviar e-mail com posição da tarefa atual
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim eMail As New clsOutlook
'
''' Principal
'Dim strFiltro As String: strFiltro = Etiqueta("eMail_Search")
'Dim strTo As String: strTo = Etiqueta("eMail_To")
'Dim strCC As String: strCC = Etiqueta("eMail_CC")
'Dim strSubject As String: strSubject = Etiqueta("eMail_Subject")
'
'
''' Confirmação de envio de e-mail
'Dim sTitle As String:       sTitle = ws.Range(Etiqueta("robot_02_Name")).Value
'Dim sMessage As String:     sMessage = "Deseja enviar e-mail com posição da tarefa atual ?"
'Dim resposta As Variant
'
''' criar tmp_file apenas para apresentacao
'Dim pathExit As String: pathExit = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\tmp_file" & ".txt"
'If (Dir(pathExit) <> "") Then Kill pathExit
'
''' linhas e colunas
'Dim lRow As Long: lRow = ws.Cells(Rows.Count, ColumnIndex).End(xlUp).Row
'Dim linha As Long: linha = InicioDaPesquisa
'
'    strBody = ""
'
'    With eMail
'
'        '' To
'        .strTo = strTo
'        .strCC = strCC
'        .strSubject = strSubject
'
'        '' Subject
'        For Each cell In ws.Range("$" & ColunaTarefa & "$" & linha & ":$" & ColunaTarefa & "$" & lRow)
'            If InStr(ws.Range("$" & ColunaStatus & "$" & linha).Value, ws.Range(strFiltro).Value) <> 0 Then
'                If (Len(cell.Value) > 0) Then strBody = strBody & cell.Value & vbNewLine
'            End If
'            linha = linha + 1
'        Next cell
'
'        '' Send
'        .strBody = strBody
'
'        '' Apresentação
'        TextFile_Append pathExit, strTo & vbNewLine
'        TextFile_Append pathExit, strCC & vbNewLine
'        TextFile_Append pathExit, ws.Range(strSubject).Value & vbNewLine
'        TextFile_Append pathExit, strBody
'        Shell "notepad.exe " & pathExit, vbMaximizedFocus
'        Kill pathExit
'
'        resposta = MsgBox(sMessage, vbQuestion + vbYesNo, sTitle)
'        If (resposta = vbYes) Then
'            .EnviarEmail
'            MsgBox "Concluido!", vbInformation + vbOKOnly, sTitle
'        End If
'
'    End With
'
'End Sub
'
'Sub open_List_Tasks(ByVal control As IRibbonControl) '' listar tarefas
''' Worksheet
'Dim ws As Worksheet: Set ws = Worksheets(ActiveSheet.Name)
'Dim cSaida As New Collection
'
''' Principal
'Dim strFiltro As String: strFiltro = Etiqueta("eMail_Search")
'
''' criar tmp_file apenas para apresentacao
'Dim pathExit As String: pathExit = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\tmp_file" & ".txt"
'If (Dir(pathExit) <> "") Then Kill pathExit
'
'Dim t As Variant
'Dim tmp As String: tmp = ""
'
'    For Each ws In Worksheets
'        If ws.Visible = xlSheetVisible Then
'            If (ws.Name <> Etiqueta("wbk_Modelo") And ws.Name <> Etiqueta("wbk_vms")) Then
'                cSaida.add ws.Name & vbTab & ws.Range(strFiltro).Value & vbNewLine
'            End If
'        End If
'    Next
'
'    For Each t In cSaida
'        tmp = tmp & t
'    Next
'
'    TextFile_Append pathExit, tmp
'
'    ClipBoardThis tmp
'
'    MsgBox "O conteudo tambem foi copiado para o ClipBoard ", vbInformation + vbOKOnly, "Concluido!"
'
'    Shell "notepad.exe " & pathExit, vbMaximizedFocus
'
'    Kill pathExit
'
'End Sub
