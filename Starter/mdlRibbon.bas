Attribute VB_Name = "mdlRibbon"
'Módulo para controle de Ribbon
Option Explicit

'Callback for cmdLogin onAction
Sub cmdLogin_Click(control As IRibbonControl)
    CallSub "", "cmdLogin_Click"
End Sub

'Callback for cmdExport onAction
Sub cmdLogout_Click(control As IRibbonControl)
    CallSub "", "cmdLogout_Click"
End Sub

'Callback for cmdImport onAction
Sub cmdImport_Click(control As IRibbonControl)
    CallSub "", "cmdImport_Click"
End Sub

'Callback for cmdExport onAction
Sub cmdExport_Click(control As IRibbonControl)
    CallSub "", "cmdExport_Click"
End Sub

'Callback for cmdVersionInfo onAction
Sub cmdVersionInfo_Click(control As IRibbonControl)
    CallSub "ShowVersion", "cmdVersionInfo_Click"
End Sub

'Callback for cmdHelp onAction
Sub cmdHelp_Click(control As IRibbonControl)
    CallSub "ShowHelp", "cmdHelp_Click"
End Sub
Private Function CallSub(pSubName As String, pSource As String)
    If Trim(pSubName) = "" Then
        MsgBox "À Implementar", vbInformation, TITULO_MSG
        Exit Function
    End If
    SetErrorHandler pSource
    If boolErrorHandler Then On Error GoTo ErrHandler
    Application.Run pSubName
    Exit Function
ErrHandler:
    Application.StatusBar = "Erro: " & err.Number & " - " & err.Description
    LockScreen False
    MsgBox "Ocorreu um erro inesperado. Erro " & err.Number & " (" & err.Description & ") em Módulo(mdlRibbon)." & pSource, vbCritical, TITULO_MSG
End Function
