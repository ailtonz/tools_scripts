Attribute VB_Name = "azs_Zip"
Option Explicit

'Declare API
#If VBA7 Then
    Declare PtrSafe Function GetKeyState Lib "USER32" (ByVal vKey As Long) As Integer
#Else
    Declare Function GetKeyState Lib "USER32" (ByVal vKey As Long) As Integer
#End If


#If VBA7 Then

    Declare PtrSafe Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As LongPtr, ByVal bInheritHandle As LongPtr, ByVal dwProcessId As LongPtr) As LongPtr
    
    Declare PtrSafe Function GetTickCount64 Lib "kernel32" () As LongPtr

    Declare PtrSafe Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As LongPtr, lpExitCode As LongPtr) As LongPtr

#Else

    Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long

    Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long


#End If

Public Const PROCESS_QUERY_INFORMATION = &H400
Public Const STILL_ACTIVE = &H103


Public Sub ShellAndWait(ByVal PathName As String, Optional WindowState)

#If VBA7 Then
    Dim hProg As LongPtr
    Dim hProcess As LongPtr, ExitCode As LongPtr
#Else
    Dim hProg As Long
    Dim hProcess As Long, ExitCode As Long
#End If

    'fill in the missing parameter and execute the program
    If IsMissing(WindowState) Then WindowState = 1
        hProg = Shell(PathName, WindowState)
        'hProg is a "process ID under Win32. To get the process handle:
        hProcess = OpenProcess(PROCESS_QUERY_INFORMATION, False, hProg)
    Do
        'populate Exitcode variable
        GetExitCodeProcess hProcess, ExitCode
        DoEvents
    Loop While ExitCode = STILL_ACTIVE
    
End Sub


Function bIsBookOpen(ByRef szBookName As String) As Boolean
' Rob Bovey
    On Error Resume Next
    bIsBookOpen = Not (Application.Workbooks(szBookName) Is Nothing)
End Function



'With this example you browse to the folder you want to zip
'The zip file will be saved in: DefPath = Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'You can change this folder to this if you want to use another folder
'DefPath = "C:\Users\Ron\ZipFolder"
'There is no need to change the code before you test it

Sub A_Zip_Folder_And_SubFolders_Browse()
    Dim PathZipProgram As String, NameZipFile As String, FolderName As String
    Dim ShellStr As String, strDate As String, DefPath As String
    Dim Fld As Object

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Create Path and name of the new zip file
    'The zip file will be saved in: DefPath = Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder
    'You can change the folder if you want to another folder like this
    'DefPath = "C:\Users\Ron\ZipFolder"
    DefPath = Application.DefaultFilePath
    If Right(DefPath, 1) <> "\" Then
        DefPath = DefPath & "\"
    End If

    'Create date/Time string, also the name of the Zip in this example
    strDate = Format(Now, "yyyy-mm-dd h-mm-ss")

    'Set NameZipFile to the full path/name of the Zip file
    'If you want to add the word "MyZip" before the date/time use
    'NameZipFile = DefPath & "MyZip " & strDate & ".zip"
    NameZipFile = DefPath & strDate & ".zip"

    'Browse to the folder with the files that you want to Zip
    Set Fld = CreateObject("Shell.Application").BrowseForFolder(0, "Select folder to Zip", 512)
    If Not Fld Is Nothing Then
        FolderName = Fld.Self.Path
        If Right(FolderName, 1) <> "\" Then
            FolderName = FolderName & "\"
        End If

        'Zip all the files in the folder and subfolders, -r is Include subfolders
        ShellStr = PathZipProgram & "7z.exe a -r" _
                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 & " " & Chr(34) & FolderName & "*.*" & Chr(34)

        'Note: you can replace the ShellStr with one of the example ShellStrings
        'below to test one of the examples


        'Zip the txt files in the folder and subfolders, use "*.xl*" for all excel files
        '        ShellStr = PathZipProgram & "7z.exe a -r" _
                 '                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 '                 & " " & Chr(34) & FolderName & "*.txt" & Chr(34)

        'Zip all files in the folder and subfolders with a name that start with Week
        '        ShellStr = PathZipProgram & "7z.exe a -r" _
                 '                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 '                 & " " & Chr(34) & FolderName & "Week*.*" & Chr(34)

        'Zip every file with the name ron.xlsx in the folder and subfolders
        '        ShellStr = PathZipProgram & "7z.exe a -r" _
                 '                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 '                 & " " & Chr(34) & FolderName & "ron.xlsx" & Chr(34)

        'Add -ppassword -mhe of you want to add a password to the zip file(only .7z files)
        '                ShellStr = PathZipProgram & "7z.exe a -r -ppassword -mhe" _
                         '                                  & " " & Chr(34) & NameZipFile & Chr(34) _
                         '                                  & " " & Chr(34) & FolderName & "*.*" & Chr(34)

        'Add -seml if you want to open a mail with the zip attached
        '                ShellStr = PathZipProgram & "7z.exe a -r -seml" _
                         '                                  & " " & Chr(34) & NameZipFile & Chr(34) _
                         '                                  & " " & Chr(34) & FolderName & "*.*" & Chr(34)

        ShellAndWait ShellStr, vbHide

        MsgBox "You will find the zip file here: " & NameZipFile
    End If
End Sub



'With this example you zip a fixed folder: FolderName = "C:\Users\Ron\Desktop\TestFolder"
'Note this folder must exist, this is the only thing that you must change before you test it
'The zip file will be saved in: DefPath = Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'You can change this folder to this if you want to use another folder
'DefPath = "C:\Users\Ron\ZipFolder"

Sub B_Zip_Fixed_Folder_And_SubFolders()
    Dim PathZipProgram As String, NameZipFile As String, FolderName As String
    Dim ShellStr As String, strDate As String, DefPath As String

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Create Path and name of the new zip file
    'The zip file will be saved in: DefPath = Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder
    'You can change the folder if you want to another folder like this
    'DefPath = "C:\Users\Ron\ZipFolder"
    DefPath = Application.DefaultFilePath
    If Right(DefPath, 1) <> "\" Then
        DefPath = DefPath & "\"
    End If

    'Create date/Time string, also the name of the Zip in this example
    strDate = Format(Now, "yyyy-mm-dd h-mm-ss")

    'Set NameZipFile to the full path/name of the Zip file
    'If you want to add the word "MyZip" before the date/time use
    'NameZipFile = DefPath & "MyZip " & strDate & ".zip"
    NameZipFile = DefPath & strDate & ".zip"

    'Fill in the folder name
    FolderName = "C:\Users\Ron\Desktop\TestFolder"
    If Right(FolderName, 1) <> "\" Then
        FolderName = FolderName & "\"
    End If

    'Zip all the files in the folder and subfolders, -r is Include subfolders
    ShellStr = PathZipProgram & "7z.exe a -r" _
             & " " & Chr(34) & NameZipFile & Chr(34) _
             & " " & Chr(34) & FolderName & "*.*" & Chr(34)

    'Note: you can replace the ShellStr with one of the example ShellStrings
    'in the first macro example on this page

    ShellAndWait ShellStr, vbHide

    MsgBox "You will find the zip file here: " & NameZipFile
End Sub



'With this example you browse to the folder you want and select the files that you want to zip
'Use the Ctrl key to select more then one file or select blocks of files with the shift key pressed.
'With Ctrl a you select all files in the dialog.
'The name of the zip file will be the Date/Time, you can change the NameZipFile string
'If you want to add the word "MyZip" before the date/time use
'NameZipFile = DefPath & "MyZip " & strDate & ".zip"
'The zip file will be saved in: DefPath = Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'You can change this folder to this if you want to use another folder
'DefPath = "C:\Users\Ron\ZipFolder"
'No need to change the code before you test it

Sub C_Zip_File_Or_Files_Browse()
    Dim PathZipProgram As String, NameZipFile As String, FolderName As String
    Dim ShellStr As String, strDate As String, DefPath As String
    Dim NameList As String, sFileNameXls As String
    Dim vArr As Variant, FileNameXls As Variant, iCtr As Long

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Create Path and name of the new zip file
    'The zip file will be saved in: DefPath = Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder
    'You can change the folder if you want to another folder like this
    'DefPath = "C:\Users\Ron\ZipFolder"
    DefPath = Application.DefaultFilePath
    If Right(DefPath, 1) <> "\" Then
        DefPath = DefPath & "\"
    End If

    'Create date/Time string, also the name of the Zip in this example
    strDate = Format(Now, "yyyy-mm-dd h-mm-ss")

    'Set NameZipFile to the full path/name of the Zip file
    'If you want to add the word "MyZip" before the date/time use
    'NameZipFile = DefPath & "MyZip " & strDate & ".zip"
    NameZipFile = DefPath & strDate & ".zip"

    FileNameXls = Application.GetOpenFilename(filefilter:="Excel Files, *.xl*", _
                                              MultiSelect:=True, Title:="Select the files that you want to add to the new zip file")

    If IsArray(FileNameXls) = False Then
        'do nothing
    Else
        NameList = ""
        For iCtr = LBound(FileNameXls) To UBound(FileNameXls)
            NameList = NameList & " " & Chr(34) & FileNameXls(iCtr) & Chr(34)
            vArr = Split(FileNameXls(iCtr), "\")
            sFileNameXls = vArr(UBound(vArr))

            If bIsBookOpen(sFileNameXls) Then
                MsgBox "You can't zip a file that is open!" & vbLf & _
                       "Please close: " & FileNameXls(iCtr)
                Exit Sub
            End If
        Next iCtr

        'Zip every file you have selected with GetOpenFilename
        ShellStr = PathZipProgram & "7z.exe a" _
                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 & " " & NameList

        ShellAndWait ShellStr, vbHide

        MsgBox "You will find the zip file here: " & NameZipFile
    End If

End Sub



'With this example you browse to the folder you want and select the files that you want to
'add or update to/in a existing zip file, if the zip file not exist it will be created for you.
'Use the Ctrl key to select more then one file or select blocks of files with the shift key pressed.
'With Ctrl a you select all files in the dialog.
'The zip file will be saved in: DefPath = Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'You can change the folder if you want to another folder like this :
'DefPath = "C:\Users\Ron\ZipFolder"
'Change this code line if you want to change the name of the zip file :
'NameZipFile = DefPath & "ron.zip
'There is no need to change the code before you test it

Sub D_Zip_File_Or_Files_Browse_Add_Update()
'Update older files in the archive and add files that are not in the archive
'Change NameZipFile in the code to your zip file before you run the code
    Dim PathZipProgram As String, NameZipFile As String, FolderName As String
    Dim ShellStr As String, DefPath As String
    Dim NameList As String, sFileNameXls As String
    Dim vArr As Variant, FileNameXls As Variant, iCtr As Long

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Create Path and name of the existing/new zip file
    'If the zip file not exist the code create it for you
    'The zip file will be saved in: DefPath = Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder
    'You can change the folder if you want to another folder like this
    'DefPath = "C:\Users\Ron\ZipFolder"
    DefPath = Application.DefaultFilePath
    If Right(DefPath, 1) <> "\" Then
        DefPath = DefPath & "\"
    End If
    'Set NameZipFile to the full path/name of the Zip file
    'Change this code line if you want to change the name of the zip file
    NameZipFile = DefPath & "ron.zip"

    FileNameXls = Application.GetOpenFilename(filefilter:="Excel Files, *.xl*", _
                                              MultiSelect:=True, Title:="Select the files that you want to update or add to the zip file")

    If IsArray(FileNameXls) = False Then
        'do nothing
    Else
        NameList = ""
        For iCtr = LBound(FileNameXls) To UBound(FileNameXls)
            NameList = NameList & " " & Chr(34) & FileNameXls(iCtr) & Chr(34)
            vArr = Split(FileNameXls(iCtr), "\")
            sFileNameXls = vArr(UBound(vArr))

            If bIsBookOpen(sFileNameXls) Then
                MsgBox "You can't zip a file that is open!" & vbLf & _
                       "Please close: " & FileNameXls(iCtr)
                Exit Sub
            End If
        Next iCtr

        'Zip every file you have selected with GetOpenFilename
        ShellStr = PathZipProgram & "7z.exe u" _
                 & " " & Chr(34) & NameZipFile & Chr(34) _
                 & " " & NameList

        ShellAndWait ShellStr, vbHide

        MsgBox "You will find the zip file here: " & NameZipFile
    End If

End Sub



'With this example you zip the ActiveWorkbook
'The name of the zip file will be the name of the workbook + Date/Time
'The zip file will be saved in: DefPath = Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'You can change this folder to this if you want to use another folder
'DefPath = "C:\Users\Ron\ZipFolder"
'There is no need to change the code before you test it

Sub E_Zip_ActiveWorkbook()
    Dim PathZipProgram As String, NameZipFile As String
    Dim ShellStr As String, strDate As String, DefPath As String
    Dim FileNameXls As String, TempFilePath As String, TempFileName As String
    Dim MyWb As Workbook, FileExtStr As String

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If
    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Build the path and name for the new xls? file
    Set MyWb = ActiveWorkbook
    If ActiveWorkbook.Path = "" Then Exit Sub

    TempFilePath = Environ$("temp") & "\"
    FileExtStr = "." & LCase(Right(MyWb.Name, _
                                   Len(MyWb.Name) - InStrRev(MyWb.Name, ".", , 1)))
    TempFileName = Left(MyWb.Name, Len(MyWb.Name) - Len(FileExtStr))

    'Use SaveCopyAs to make a copy of the file
    FileNameXls = TempFilePath & TempFileName & FileExtStr
    MyWb.SaveCopyAs FileNameXls

    'Build the path and name for the new zip file
    'The name of the zip file will be the name of the workbook + Date/Time
    'The zip file will be saved in: DefPath = Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder.
    'You can change this folder to this if you want to use another folder
    'DefPath = "C:\Users\Ron\ZipFolder"
    DefPath = Application.DefaultFilePath
    If Right(DefPath, 1) <> "\" Then
        DefPath = DefPath & "\"
    End If
    strDate = Format(Now, "yyyy-mm-dd h-mm-ss")
    NameZipFile = DefPath & TempFileName & " " & strDate & ".zip"

    'Zip FileNameXls (copy of the ActiveWorkbook)
    ShellStr = PathZipProgram & "7z.exe a" _
             & " " & Chr(34) & NameZipFile & Chr(34) _
             & " " & Chr(34) & FileNameXls & Chr(34)
    ShellAndWait ShellStr, vbHide

    'Delete the file that you saved with SaveCopyAs and add to the zip file
    Kill TempFilePath & TempFileName & FileExtStr

    MsgBox "You will find the zip file here: " & NameZipFile
End Sub



'With this example you browse to the zip or 7z file you want to unzip
'The zip file will be unzipped in a new folder in: Application.DefaultFilePath
'Normal if you have not change it this will be your Documents folder
'The name of the folder that the code create in this folder is the Date/Time
'You can change this folder to this if you want to use a fixed folder:
'NameUnZipFolder = "C:\Users\Ron\TestFolder\"
'Read the comments in the code about the commands/Switches in the ShellStr
'There is no need to change the code before you test it

Sub A_UnZip_Zip_File_Browse()
    Dim PathZipProgram As String, NameUnZipFolder As String
    Dim FileNameZip As Variant, ShellStr As String

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'Create path and name of the normal folder to unzip the files in
    'In this example we use: Application.DefaultFilePath
    'Normal if you have not change it this will be your Documents folder
    'The name of the folder that the code create in this folder is the Date/Time
    NameUnZipFolder = Application.DefaultFilePath & "\" & Format(Now, "yyyy-mm-dd h-mm-ss")
    'You can also use a fixed path like
    'NameUnZipFolder = "C:\Users\Ron\TestFolder"

    'Select the zip file (.zip or .7z files)
    FileNameZip = Application.GetOpenFilename(filefilter:="Zip Files, *.zip, 7z Files, *.7z", _
                                              MultiSelect:=False, Title:="Select the file that you want to unzip")

    'Unzip the files/folders from the zip file in the NameUnZipFolder folder
    If FileNameZip = False Then
        'do nothing
    Else
        'There are a few commands/Switches that you can change in the ShellStr
        'We use x command now to keep the folder stucture, replace it with e if you want only the files
        '-aoa Overwrite All existing files without prompt.
        '-aos Skip extracting of existing files.
        '-aou aUto rename extracting file (for example, name.txt will be renamed to name_1.txt).
        '-aot auto rename existing file (for example, name.txt will be renamed to name_1.txt).
        'Use -r if you also want to unzip the subfolders from the zip file
        'You can add -ppassword if you want to unzip a zip file with password (only 7zip files)
        'Change "*.*" to for example "*.txt" if you only want to unzip the txt files
        'Use "*.xl*" for all Excel files: xls, xlsx, xlsm, xlsb
        ShellStr = PathZipProgram & "7z.exe x -aoa -r" _
                 & " " & Chr(34) & FileNameZip & Chr(34) _
                 & " -o" & Chr(34) & NameUnZipFolder & Chr(34) & " " & "*.*"

        ShellAndWait ShellStr, vbHide
        MsgBox "Look in " & NameUnZipFolder & " for extracted files"

    End If
End Sub





Function Zip(myFileSpec, myZip)
' This function uses X-standards.com's X-zip component to add
' files to a ZIP file.
' If the ZIP file doesn't exist, it will be created on-the-fly.
' Compression level is set to maximum, only relative paths are
' stored.
'
' Arguments:
' myFileSpec    [string] the file(s) to be added, wildcards allowed
'                        (*.* will include subdirectories, thus
'                        making the function recursive)
' myZip         [string] the fully qualified path to the ZIP file
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com
'
' The X-zip component is available at:
' http://www.xstandard.com/en/documentation/xzip/
' For more information on available functionality read:
' http://www.xstandard.com/printer-friendly.asp?id=C9891D8A-5390-44ED-BC60-2267ED6763A7

    Dim objZIP
    On Error Resume Next
    err.Clear
    Set objZIP = CreateObject("XStandard.Zip")
    objZIP.Pack myFileSpec, myZip, , , 9
    Zip = err.Number
    err.Clear
    Set objZIP = Nothing
    On Error GoTo 0
End Function

Function UnZip(myFileSpec, myZip)
' This function uses X-standards.com's X-zip component to add
' files to a ZIP file.
' If the ZIP file doesn't exist, it will be created on-the-fly.
' Compression level is set to maximum, only relative paths are
' stored.
'
' Arguments:
' myFileSpec    [string] the file(s) to be added, wildcards allowed
'                        (*.* will include subdirectories, thus
'                        making the function recursive)
' myZip         [string] the fully qualified path to the ZIP file
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com
'
' The X-zip component is available at:
' http://www.xstandard.com/en/documentation/xzip/
' For more information on available functionality read:
' http://www.xstandard.com/printer-friendly.asp?id=C9891D8A-5390-44ED-BC60-2267ED6763A7

    Dim objZIP
    On Error Resume Next
    err.Clear
    Set objZIP = CreateObject("XStandard.Zip")
    objZIP.UnPack myFileSpec, myZip, "*.*"
    
'    objZIP.UnPack myFileSpec, myZip, , , 9
    UnZip = err.Number
    err.Clear
    Set objZIP = Nothing
    On Error GoTo 0
End Function


Sub Compact(NameFile As String, NameZipFile As String)
    Dim PathZipProgram As String
    Dim ShellStr As String

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    ShellStr = PathZipProgram & "7z.exe a" _
             & " " & Chr(34) & NameZipFile & Chr(34) _
             & " " & NameFile

    ShellAndWait ShellStr, vbHide



End Sub

Sub DesCompact(FileNameZip As Variant, NameUnZipFolder As String)
    Dim PathZipProgram As String
    Dim ShellStr As String

    'Path of the Zip program
    PathZipProgram = "C:\program files\7-Zip\"
    If Right(PathZipProgram, 1) <> "\" Then
        PathZipProgram = PathZipProgram & "\"
    End If

    'Check if this is the path where 7z is installed.
    If Dir(PathZipProgram & "7z.exe") = "" Then
        MsgBox "Please find your copy of 7z.exe and try again"
        Exit Sub
    End If

    'There are a few commands/Switches that you can change in the ShellStr
    'We use x command now to keep the folder stucture, replace it with e if you want only the files
    '-aoa Overwrite All existing files without prompt.
    '-aos Skip extracting of existing files.
    '-aou aUto rename extracting file (for example, name.txt will be renamed to name_1.txt).
    '-aot auto rename existing file (for example, name.txt will be renamed to name_1.txt).
    'Use -r if you also want to unzip the subfolders from the zip file
    'You can add -ppassword if you want to unzip a zip file with password (only 7zip files)
    'Change "*.*" to for example "*.txt" if you only want to unzip the txt files
    'Use "*.xl*" for all Excel files: xls, xlsx, xlsm, xlsb
    ShellStr = PathZipProgram & "7z.exe x -aoa -r" _
             & " " & Chr(34) & FileNameZip & Chr(34) _
             & " -o" & Chr(34) & NameUnZipFolder & Chr(34) & " " & "*.*"

    ShellAndWait ShellStr, vbHide

End Sub





