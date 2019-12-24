Attribute VB_Name = "mod_ExportModules"
Option Explicit

'' https://social.msdn.microsoft.com/Forums/en-US/57813453-9a21-4080-9d4a-e548e715d7ca/add-visual-basic-extensibility-library-through-code?forum=isvvba
Sub ListRefPathsGUID()
     'Macro purpose:  To determine full path and Globally Unique Identifier (GUID)
     'to each referenced library.  Select the reference in the Tools\References
     'window, then run this code to get the information on the reference's library
    
    Dim i As Long
   
    For i = 1 To ThisWorkbook.VBProject.References.count
        With ThisWorkbook.VBProject.References(i)
            Debug.Print .Name & "    " & .FullPath & "    " & .GUID
        End With
    Next i
End Sub

Sub AddRefGuid()
    'Add VBIDE (Microsoft Visual Basic for Applications Extensibility 5.3
   
    ThisWorkbook.VBProject.References.AddFromGuid _
        "{0002E157-0000-0000-C000-000000000046}", 2, 0
 
End Sub

'' https://www.rondebruin.nl/win/s9/win002.htm

Public Sub ExportModules()
    Dim bExport As Boolean
    Dim wkbSource As Excel.Workbook
    Dim szSourceWorkbook As String
    Dim szExportPath As String
    Dim szFileName As String
    Dim cmpComponent As VBIDE.VBComponent
        
    Dim strPath As String: strPath = ActiveWorkbook.Path & "\"
    Dim strPrj As String: strPrj = Left(ActiveWorkbook.Name, Len(ActiveWorkbook.Name) - 5) & "\bas"
    Dim FolderWithVBAProjectFiles As String: FolderWithVBAProjectFiles = strPath & strPrj
    
    If Dir(strPath & strPrj, vbDirectory) = vbNullString Then
        'MkDir strPath & Left(strPrj, Len(strPrj) - 4)
        MkDir strPath & strPrj
    End If
    

    ''' The code modules will be exported in a folder named.
    ''' VBAProjectFiles in the Documents folder.
    ''' The code below create this folder if it not exist
    ''' or delete all files in the folder if it exist.
    If FolderWithVBAProjectFiles = "Error" Then
        MsgBox "Export Folder not exist"
        Exit Sub
    End If
    
    On Error Resume Next
        Kill FolderWithVBAProjectFiles & "\*.*"
    On Error GoTo 0

    ''' NOTE: This workbook must be open in Excel.
    szSourceWorkbook = ActiveWorkbook.Name
    Set wkbSource = Application.Workbooks(szSourceWorkbook)
    
    If wkbSource.VBProject.Protection = 1 Then
    MsgBox "The VBA in this workbook is protected," & _
        "not possible to export the code"
    Exit Sub
    End If
    
    szExportPath = FolderWithVBAProjectFiles & "\"
    
    For Each cmpComponent In wkbSource.VBProject.VBComponents
        
        bExport = True
        szFileName = cmpComponent.Name

        ''' Concatenate the correct filename for export.
        Select Case cmpComponent.Type
            Case vbext_ct_ClassModule
                szFileName = szFileName & ".cls"
            Case vbext_ct_MSForm
                szFileName = szFileName & ".frm"
            Case vbext_ct_StdModule
                szFileName = szFileName & ".bas"
            Case vbext_ct_Document
                ''' This is a worksheet or workbook object.
                ''' Don't try to export.
                bExport = False
        End Select
        
        If bExport Then
            ''' Export the component to a text file.
            cmpComponent.Export szExportPath & szFileName
            
        ''' remove it from the project if you want
        '''wkbSource.VBProject.VBComponents.Remove cmpComponent
        
        End If
   
    Next cmpComponent

    MsgBox "Export is ready"
End Sub

