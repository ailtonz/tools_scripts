' To-Do: Filtrar apenas arquivos excel - [ PENDENTE ] 
 
' Excluir guias ocultas
Dim oFolder, oFile, app, wb
 
Dim oFSO : Set oFSO = CreateObject("Scripting.FileSystemObject")
Dim sScriptDir : sScriptDir = oFSO.GetParentFolderName(WScript.ScriptFullName)
Set oFolder = oFSO.GetFolder(sScriptDir)
 
For Each oFile In oFolder.Files
	set app = createobject("Excel.Application")
	set wb = app.workbooks.open(oFile.Path)
	For Each ws In app.Worksheets
	   If ws.Visible = xlSheetHidden Then
					   ws.Delete
	   End If
	Next      
	wb.Save
	app.Quit 
Next
 
MsgBox("Concluido")
