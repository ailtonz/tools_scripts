VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsPathAndFiles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Function PickFolder(pPath As String, pTitle As String, Optional pSubFolder As String) As String
    With Application.FileDialog(msoFileDialogFolderPicker)
    .Title = pTitle
    .InitialFileName = pPath
    .Show
        If .SelectedItems.count > 0 Then
            If Trim(pSubFolder) <> "" Then
                If Dir(.SelectedItems(1) & pSubFolder, vbDirectory) = "" Then
                    MkDir Path:=.SelectedItems(1) & pSubFolder
                End If
            End If
            PickFolder = .SelectedItems(1) & pSubFolder
        End If
    End With
End Function

Function PickFiles(pTitle As String, Optional pFilter As Variant, Optional pMultiselect As Boolean = False) As Collection
    Dim iCol As New Collection
    Dim IFilter As Variant
    Dim Sel As Variant
    
    With Application.FileDialog(msoFileDialogFilePicker)
        .Title = pTitle
        .InitialFileName = ThisWorkbook.Path
        .AllowMultiSelect = pMultiselect
        .Filters.Clear
        
        If Not IsMissing(pFilter) Then
            For IFilter = LBound(pFilter) To UBound(pFilter) Step 2
                .Filters.Add pFilter(IFilter), pFilter(IFilter + 1)
            Next IFilter
        End If
        
        .Show
        
        For Each Sel In .SelectedItems
            iCol.Add Sel
        Next
        
    End With
    
    Set PickFiles = iCol
    
End Function

Function PathGetDesktopAddress() As String
    PathGetDesktopAddress = CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\"
End Function

Function PathGet(pPath As String) As String
  PathGet = Left(pPath, InStrRev(pPath, "\"))
End Function

Function FileExist(filePath As String) As Boolean
    FileExist = IIf(Dir(filePath) <> vbNullString, True, False)
End Function

Function FileGetName(pPath As String) As String
    FileGetName = Right(pPath, Len(pPath) - InStrRev(pPath, "\"))
End Function

Function FileGetExt(pPath As String) As String
    FileGetExt = Right(pPath, Len(pPath) - InStrRev(pPath, "."))
End Function

Function FileGetNameByPath(pFileFullPath As String) As String
    FileGetNameByPath = StrReverse(Split(StrReverse(pFileFullPath), "\")(0))
End Function

Function FileGetRowCount(pFileFullPath As String) As Long
Dim FSO As Variant, theFile As Variant

Set FSO = CreateObject("Scripting.FileSystemObject")
Set theFile = FSO.OpenTextFile(pFileFullPath, 8, True)
    
    FileGetRowCount = theFile.Line

Set FSO = Nothing

    theFile.Close
Set theFile = Nothing
End Function

Function TextFileWrite(pFilePath As String, pText As String) As Boolean
    Dim intFNumber As Integer
    Dim boolAppendFile As Boolean
    intFNumber = FreeFile
    
    On Error GoTo ErrorHandler
    
    If boolAppendFile Then
        Open pFilePath For Output As #intFNumber
        Print #intFNumber, pText
        Close #intFNumber
    End If
    
    On Error GoTo 0
    TextFileWrite = True
    Exit Function
ErrorHandler:
    MsgBox "Não foi possível salvar o arquivo." & vbNewLine & "Verifique o caminho informado e as permissões de acesso", vbInformation, "Criptografia - CLM Tech"
End Function

Sub TextFileAppend(pPathAndFileName As String, pAppend As String)
    Dim fs, f, S
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set f = fs.OpenTextFile(pPathAndFileName, ForAppending)
    f.Write pAppend
    f.Close
End Sub

Sub TextFileCreate(pPathAndFileName As String, pComment As String)
Dim fs As Variant, a As Variant
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set a = fs.CreateTextFile(pPathAndFileName, True)
    a.WriteLine pComment
    a.Close
End Sub

Sub ShowFolderList(folderspec As String)
    Dim fs, f, f1, fc, S
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set f = fs.GetFolder(folderspec)
    Set fc = f.SubFolders
    For Each f1 In fc
        S = S & f1.Name
        S = S & vbCrLf
    Next
    MsgBox S
End Sub
 
Function EstimatedTime(pStart As Date, pPosition As Long, pTotal As Long) As Date
    Dim iTime As Date
    Dim iFracTime As Date
    
    iTime = Now - pStart
    iFracTime = iTime / pPosition
    
    EstimatedTime = Format(iFracTime * (pTotal - pPosition), "hh:mm:ss")
    
End Function

Function FileExists(ByVal strFile As String, Optional bFindFolders As Boolean) As Boolean
    
    'Purpose:   Return True if the file exists, even if it is hidden.
    'Arguments: strFile: File name to look for. Current directory searched if no path included.
    '           bFindFolders. If strFile is a folder, FileExists() returns False unless this argument is True.
    'Note:      Does not look inside subdirectories for the file.
    'Author:    Allen Browne. http://allenbrowne.com June, 2006.
    Dim lngAttributes As Long

    'Include read-only files, hidden files, system files.
    lngAttributes = (vbReadOnly Or vbHidden Or vbSystem)

    If bFindFolders Then
        lngAttributes = (lngAttributes Or vbDirectory) 'Include folders as well.
    Else
        'Strip any trailing slash, so Dir does not look inside the folder.
        Do While Right$(strFile, 1) = "\"
            strFile = Left$(strFile, Len(strFile) - 1)
        Loop
    End If

    'If Dir() returns something, the file exists.
    On Error Resume Next
    FileExists = (Len(Dir(strFile, lngAttributes)) > 0)
End Function

Public Function Saida(strConteudo As String, strArquivo As String)
    Open CreateObject("WScript.Shell").SpecialFolders("Desktop") & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function
