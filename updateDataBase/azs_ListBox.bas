Attribute VB_Name = "azs_ListBox"
Option Explicit

Function ListBoxChecarSelecao(frm As UserForm, strListBoxNome As String) As Boolean: ListBoxChecarSelecao = False
Dim Ctrl As Control
Dim intCurrentRow As Integer

For Each Ctrl In frm.Controls
    If TypeName(Ctrl) = "ListBox" Then
        If Ctrl.Name = strListBoxNome Then
            For intCurrentRow = 0 To Ctrl.ListCount - 1
                If Ctrl.Selected(intCurrentRow) = True Then
                    ListBoxChecarSelecao = True
                    Exit Function
                End If
            Next intCurrentRow
        End If
    End If
Next

End Function

Function ListBoxUpdate(wsGuia As String, strListagem As String, frm As UserForm, NomeLista As String)
Dim cLoc As Range
Dim ws As Worksheet
Set ws = Worksheets(wsGuia)

Dim Ctrl As Control
Dim x As Long: x = 3
Dim y As Long: y = 1

For Each Ctrl In frm.Controls
    If TypeName(Ctrl) = "ListBox" Then
        If Ctrl.Name = NomeLista Then
            Ctrl.Clear
            For Each cLoc In ws.Range(strListagem)
              Ctrl.AddItem cLoc.Value & " | " & cLoc.Cells(x, y)
              y = y + 1
            Next cLoc
        End If
    End If
Next

Set ws = Nothing

End Function

Public Function ListBoxCarregar(BaseDeDados As String, frm As UserForm, NomeLista As String, strCampo As String, strSQL As String)
On Error GoTo ListBoxCarregar_err

Dim dbOrcamento         As DAO.Database
Dim rstListBoxCarregar   As DAO.Recordset
Dim RetVal              As Variant

Dim Ctrl                As Control

RetVal = Dir(BaseDeDados)

If RetVal = "" Then

    ListBoxCarregar = False
    
Else
       
    Set dbOrcamento = DBEngine.OpenDatabase(BaseDeDados, False, False, "MS Access;PWD=" & SenhaBanco)
    Set rstListBoxCarregar = dbOrcamento.OpenRecordset(strSQL)
    
    For Each Ctrl In frm.Controls
        If TypeName(Ctrl) = "ListBox" Then
            If Ctrl.Name = NomeLista Then
                Ctrl.Clear
                While Not rstListBoxCarregar.EOF
                    Ctrl.AddItem rstListBoxCarregar.Fields(strCampo)
                    rstListBoxCarregar.MoveNext
                Wend
            End If
        End If
    Next
    
    rstListBoxCarregar.Close
    dbOrcamento.Close
    
    Set dbOrcamento = Nothing
    Set rstListBoxCarregar = Nothing
    
End If

ListBoxCarregar_Fim:
  
    Exit Function
ListBoxCarregar_err:
    ListBoxCarregar = False
    MsgBox err.Description
    Resume ListBoxCarregar_Fim
End Function
