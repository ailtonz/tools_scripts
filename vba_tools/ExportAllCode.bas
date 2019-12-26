Attribute VB_Name = "ExportAllCode"

Sub AddRefGuid()
On Error Resume Next

    'Add VBIDE (Microsoft Visual Basic for Applications Extensibility 5.3
   
    Application.VBE.VBProjects(1).References.AddFromGuid _
        "{0002E157-0000-0000-C000-000000000046}", 2, 0
 
End Sub

Public Sub ExportAllCode()

    Dim c As VBComponent
    Dim Sfx As String

    For Each c In Application.VBE.VBProjects(1).VBComponents
        Select Case c.Type
            Case vbext_ct_ClassModule, vbext_ct_Document
                Sfx = ".cls"
            Case vbext_ct_MSForm
                Sfx = ".frm"
            Case vbext_ct_StdModule
                Sfx = ".bas"
            Case Else
                Sfx = ""
        End Select

        If Sfx <> "" Then
            c.Export _
                FileName:=CurrentProject.Path & "\" & _
                c.Name & Sfx
        End If
    Next c

End Sub