Attribute VB_Name = "Util_Projeto"
Option Explicit

Public Function GetBanco() As Banco
    Set GetBanco = New Banco
    GetBanco.Start pUser:="", _
                   pPwd:="", _
                   pDataSource:=ThisWorkbook.Path & "\", _
                   pDataBaseName:="", _
                   pDriverODBC:=drAccess
End Function

