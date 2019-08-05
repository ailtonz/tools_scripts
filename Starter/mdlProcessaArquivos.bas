Attribute VB_Name = "mdlProcessaArquivos"
'Módulo para processamento de arquivos em lote
Option Explicit
Private clsBanco As Banco
Public Function ProcessaArquivos(pCol As Collection, Optional ByRef pResult As String)
'=====================================================================================================================
' Procedure    : ProcessaArquivos
' Author       : s.graziollijunior (AGO/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pCol As Collection
'   - Optional ByRef pResult As String
'=====================================================================================================================
    Dim strFile As Variant
    
    For Each strFile In pCol
        'Processa cada arquivo
        
    Next strFile
    
End Function
Private Function ProcessaArquivo_TXT(pFilePath As String, Optional ByRef pResult As String)
'=====================================================================================================================
' Procedure    : ProcessaArquivo_TXT
' Author       : s.graziollijunior (AGO/2016)
' Type         : Private Function
' Return       : Void
' Description  :
' Params
'   - pFilePath As String
'   - Optional ByRef pResult As String
'=====================================================================================================================
    Dim strLine As Variant
    Dim auxCol As Collection
    
    Set clsBanco = GetBanco
    
    Set auxCol = TextFile_ReadToCollection(pFilePath)
    For Each strLine In auxCol
        'Processa linhas do arquivo
        
    Next strLine
    
    Set clsBanco = Nothing
    
End Function

