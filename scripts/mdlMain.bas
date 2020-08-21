Attribute VB_Name = "mdlMain"
'' [ imageMSO ]
'' https://bert-toolkit.com/imagemso-list.html

'' [ git ]
'' https://githowto.com/pt-BR/create_a_project

Option Explicit

Private Sub create_FileTxt(ByVal control As IRibbonControl)
    tools_createFileTxt
End Sub

Private Sub create_NewFile(ByVal control As IRibbonControl)
    tools_createFileNew
End Sub

Sub create_Script()
    tools_createScript
End Sub

Sub create_runUrls()
    tools_createRunUrls
End Sub

Sub create_runTema()
    tools_createRunTema
End Sub

Sub create_runMouse()
    tools_createScriptMouse
End Sub
 
Sub create_scriptBackup()
    tools_createScriptBkp
End Sub


