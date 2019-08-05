Attribute VB_Name = "azs_File"
Option Explicit



Function getFileStep(strNomeArquivo As String) As String
''' Função particular ao projeto "Orçamentos" Responsavel por informar qual o passo do arquivo.
    getFileStep = Right(getFileName(pathWorkSheetAddress & strNomeArquivo), Len(getFileName(pathWorkSheetAddress & strNomeArquivo)) - 14)
End Function

Public Function getPath(sPathIn As String) As String
'''Esta função irá retornar apenas o path de uma string que contenha o path e o nome do arquivo:
Dim i As Integer

  For i = Len(sPathIn) To 1 Step -1
     If InStr(":\", Mid$(sPathIn, i, 1)) Then Exit For
  Next

  getPath = Left$(sPathIn, i)

End Function

Public Function getFileName(sFileIn As String) As String
' Essa função irá retornar apenas o nome do  arquivo de uma
' string que contenha o path e o nome do arquiva
Dim i As Integer

  For i = Len(sFileIn) To 1 Step -1
     If InStr("\", Mid$(sFileIn, i, 1)) Then Exit For
  Next

  getFileName = Left(Mid$(sFileIn, i + 1, Len(sFileIn) - i), Len(Mid$(sFileIn, i + 1, Len(sFileIn) - i)) - 4)

End Function

Public Function getFileExt(sFileIn As String) As String
' Essa função irá retornar apenas a extensão do  arquivo de uma
' string que contenha o path e o nome do arquiva
Dim i As Integer

  For i = Len(sFileIn) To 1 Step -1
     If InStr("\", Mid$(sFileIn, i, 1)) Then Exit For
  Next

  getFileExt = Right(Mid$(sFileIn, i + 1, Len(sFileIn) - i), 4)

End Function

Public Function getFileNameAndExt(sFileIn As String) As String
' Essa função irá retornar apenas o nome do  arquivo de uma
' string que contenha o path e o nome do arquiva
Dim i As Integer

    For i = Len(sFileIn) To 1 Step -1
       If InStr("\", Mid$(sFileIn, i, 1)) Then Exit For
    Next
    
    getFileNameAndExt = Mid$(sFileIn, i + 1, Len(sFileIn) - i)

End Function

Public Function pathDesktopAddress() As String
    pathDesktopAddress = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\"
End Function

Public Function pathWorkSheetAddress() As String
    pathWorkSheetAddress = ActiveWorkbook.Path & "\"
End Function

Public Function pathWorkbookFullName() As String
    pathWorkbookFullName = ActiveWorkbook.FullName
End Function

Function getFileStatus(filespec) As Boolean: getFileStatus = False
    
    If (CreateObject("Scripting.FileSystemObject").FileExists(filespec)) Then
       getFileStatus = True
    End If
    
End Function


'Function getFileStatus(filespec) As Boolean: getFileStatus = False
'Dim fso
'
'    Set fso = CreateObject("Scripting.FileSystemObject")
'
'    If (fso.FileExists(filespec)) Then
'       getFileStatus = True
'    End If
'
'
'
'End Function


'Public Function TestaExistenciaArquivo(ByVal caminhoArquivo As String) As Boolean
'On Error Resume Next
'
'    TestaExistenciaArquivo = IIf(Dir$(caminhoArquivo, vbArchive) <> "", True, False)
'
'End Function
