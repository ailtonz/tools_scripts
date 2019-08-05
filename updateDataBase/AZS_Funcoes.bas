Attribute VB_Name = "AZS_Funcoes"
Option Explicit

Public Function SelecionarBanco() As String
Dim fd As Office.FileDialog
Dim strArq As String
    
    On Error GoTo SelecionarBanco_err
    
    'Diálogo de selecionar arquivo - Office
    Set fd = Application.FileDialog(msoFileDialogFilePicker)
    fd.Filters.Clear
    fd.Filters.Add "BDs do Access", "*.MDB;*.MDE"
    fd.Title = "Localize a fonte de dados"
    fd.AllowMultiSelect = False
    If fd.Show = -1 Then
        strArq = fd.SelectedItems(1)
    End If
        
    If strArq <> "" Then SelecionarBanco = strArq

SelecionarBanco_Fim:
    Exit Function

SelecionarBanco_err:
    MsgBox err.Description
    Resume SelecionarBanco_Fim

End Function

Public Function Controle() As String
    Controle = Right(Year(Now()), 2) & Format(Month(Now()), "00") & Format(Day(Now()), "00") & "-" & Format(Hour(Now()), "00") & Format(Minute(Now()), "00")
End Function

Public Function DivisorDeTexto(Texto As String, divisor As String, Indice As Integer) As String
On Error Resume Next
Dim Matriz As Variant
    
    Matriz = Array()
    Matriz = Split(Texto, divisor)
    DivisorDeTexto = Trim(CStr(Matriz(Indice)))

End Function

Public Function Saida(strConteudo As String, strArquivo As String)
    Open CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function

Function ListarDiretorio(strCaminho As String, strExtensao As String) As String
Dim resultado As Variant
Dim Arquivos As Variant
Dim TamVarNome As Variant

Arquivos = Dir(strCaminho & "\" & strExtensao, vbArchive) ' Recupera a primeira  entrada.
    
''' CHECA A EXISTENCIA DE ARQUIVOS.
If Len(Arquivos) > 0 Then
    Do While Arquivos <> "" ' Inicia o loop.
        resultado = Arquivos & ";" & resultado
        Arquivos = Dir ' Obtém a próxima entrada.
    Loop
    TamVarNome = Mid(resultado, 1, Val(Len(resultado)) - 1)
    ListarDiretorio = TamVarNome
End If

End Function








