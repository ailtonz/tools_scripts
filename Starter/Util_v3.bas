Attribute VB_Name = "Util_v3"
'Módulo com funções úteis e Facilitadores
'Necessário para utilização:
'Referência para 'Microsoft Forms 2.0 Object Library'
'Referência para 'Microsoft Windows Common Controls 6.0 (SP6)'

'=====================================================================================================================
' Module    : Util_v3
' Author    : Sidnei Graciolli
' Date      : 12/05/2016
' Purpose   : Contém funções úteis e facilitadores
'=====================================================================================================================

' FUNCTION DECLARATIONS ==============================================================================================
Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Declare PtrSafe Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer


'Windows API calls to handle windows
#If VBA7 Then
    Private Declare PtrSafe Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long:
#Else
    Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
#End If

#If VBA7 Then
    Private Declare PtrSafe Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
#Else
    Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
#End If

#If VBA7 Then
    Private Declare PtrSafe Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
#Else
    Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
#End If

' ENUMERATORS ========================================================================================================
Public Enum enumState
    sttNone = 0
    sttInsert = 1
    sttOk = 2
    sttDelete = 3
    sttSearch = 4
    sttExport = 5
    sttCancel = 6
    sttClear = 7
    sttUpdate = 8
End Enum
Public Enum enumLanguage
    langUS_English = 0
    langBR_Portuguese = 1
End Enum
Public Enum enTipo
    tpInt = 0
    tpStr = 1
    tpBool = 2
    tpDate = 3
    tpFK = 4
    tpFloat = 5
    tpTime = 6
End Enum
Public Enum enDriverODBC
    drAccess = 0
    drSqlServer = 1
    drExcel_12 = 2
    drExcel_8 = 3
    drSqlite = 4
End Enum

' VARIABLES DECLARATIONS =============================================================================================
Public clsUser                              As New User
Public bolRecall                            As Boolean
Private Const mcGWL_STYLE = (-16)
Private Const mcWS_SYSMENU = &H80000
Public Const MASTER_USER                    As String = "fp5738" '"xn4718"
Public boolErrorHandler                     As Boolean
Public boolAppendFile                       As Boolean
Public Const VK_CONTROL                     As Integer = &H11
Public Const NOME_PROJETO                   As String = "PROJETO"
Public Const NOME_EMPRESA                   As String = "EMPRESA"
Public Const TITULO_MSG                     As String = NOME_PROJETO & " :: " & NOME_EMPRESA
Public Const FORMAT_CURRENCY                As String = "#,##0.00;(#,##0.00);-"
Public Const NUMBER_FORMAT                  As String = "#,##0.00;(#,##0.00);0.00"
Public Const DATE_FORMAT                    As String = "dd/mm/yy"
Public sql                                  As String
Public i                                    As Integer
Public j                                    As Integer
Public Function MonthName(pMonthNumber As Integer, Optional pLanguage As enumLanguage) As String
'=====================================================================================================================
' Procedure    : MonthName
' Author       : s.graziollijunior (MAI/2012)
' Type         : Public Function
' Return       : String
' Description  : This function take an integer and returns the name of the corresponding month. Optionally, you can pass the language for return.
' Params
'   - pMonthNumber As Integer
'   - Optional pLanguage As enumLanguage
'=====================================================================================================================
    Dim strMonths As String
    
    If pMonthNumber < 1 Or pMonthNumber > 12 Then
        MonthName = "#InvalidParameter"
    Else
        Select Case pLanguage
            Case langUS_English:        strMonths = " January February March April May June July August September October November December"
            Case langBR_Portuguese:     strMonths = " Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro"
            Case Else:                  strMonths = " January February March April May June July August September October November December"
        End Select
        
        MonthName = Split(strMonths, " ")(pMonthNumber)
    End If
End Function
Public Function MonthNumber(pMonth As String, Optional pLanguage As enumLanguage) As String
'=====================================================================================================================
' Procedure    : MonthNumber
' Author       : s.graziollijunior (MAI/2012)
' Type         : Public Function
' Return       : String
' Description  : This function take the month name and returns a string of the integer value. Optionally, you can pass the language of the entry.
' Params
'   - pMonth As String
'   - Optional pLanguage As enumLanguage
'=====================================================================================================================
    For i = 1 To 12
        If UCase(pMonth) = UCase(MonthName(i, pLanguage)) Then
            MonthNumber = CStr(Format(i, "00"))
            Exit Function
        End If
    Next i
    
    MonthNumber = "#InvalidParameter"
End Function
Public Function MonthComboBox(pComboBox As ComboBox, Optional pSelected As Integer, Optional pLanguage As enumLanguage)
'=====================================================================================================================
' Procedure    : MonthComboBox
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  : This function populate a ComboBox object with months. Optionally, you can pass the language for return, and the month that will stay selected.
' Params
'   - pComboBox As ComboBox
'   - Optional pSelected As Integer
'   - Optional pLanguage As enumLanguage
'=====================================================================================================================
    With pComboBox
        .Clear
        For i = 1 To 12
            .AddItem MonthName(i, pLanguage)
        Next i
        If pSelected <> 0 Then
            .ListIndex = pSelected
        Else
            .Text = "Select..."
        End If
    End With
End Function
Public Function YearComboBox(pComboBox As ComboBox)
'=====================================================================================================================
' Procedure    : YearComboBox
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  : This function populate a ComboBox object with years.
' Params
'   - pComboBox As ComboBox
'=====================================================================================================================
    With pComboBox
        .Clear
        For i = 1 To 5
            .AddItem (Year(Now) - 3) + i
        Next i
        .ListIndex = 2
    End With
End Function
Public Function ClearStatusBar()
'=====================================================================================================================
' Procedure    : ClearStatusBar
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
'=====================================================================================================================
    ThisWorkbook.Application.StatusBar = vbNullString
End Function
Public Function statusFinal(pDate As Date)
'=====================================================================================================================
' Procedure    : statusFinal
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pDate As Date
'=====================================================================================================================
    ThisWorkbook.Application.StatusBar = "Operação concluída! Tempo de execução: " & Format(Now - pDate, "hh:mm:ss")
    'ShowProgress ThisWorkbook.Application.StatusBar
    ThisWorkbook.Application.OnTime Now() + TimeValue("00:00:15"), "ClearStatusBar"
End Function
Public Function Greet() As String
'=====================================================================================================================
' Procedure    : Greet
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
'=====================================================================================================================
    Select Case Hour(Now)
        Case 6 To 11:               Greet = "Bom dia"
        Case 12 To 17:              Greet = "Boa tarde"
        Case Else:                  Greet = "Boa noite"
    End Select
End Function
Public Function Contains(pCollection As Collection, pKey As Variant) As Boolean
'=====================================================================================================================
' Procedure    : Contains
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Boolean
' Description  :
' Params
'   - pCollection As Collection
'   - pKey As Variant
'=====================================================================================================================
    On Error GoTo NoSuchKey
    If VarType(pCollection.Item(pKey)) = vbObject Then
    End If
    Contains = True
    Exit Function
NoSuchKey:
    Contains = False
End Function
Public Function RaiseError(Optional pSource As String, Optional pDescription As String)
'=====================================================================================================================
' Procedure    : RaiseError
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - Optional pSource As String
'   - Optional pDescription As String
'=====================================================================================================================
    ThisWorkbook.Application.StatusBar = ""
    With err
        If pDescription = vbNullString Then
            .Description = "Ocorreu um erro de sistema: " & .Description
        Else
            .Description = pDescription
        End If
        If pSource <> vbNullString Then .Source = pSource
        'Debug.Print CStr(Time()) + "@" + .Source + " >> " + .Description
        .Raise vbObjectError + 513
    End With
End Function
Public Function ShowError()
'=====================================================================================================================
' Procedure    : ShowError
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
'=====================================================================================================================
    Dim FileNumber As Integer
    Dim strLog As String
    Dim strSource As String
    Dim strDescription As String
    
    ThisWorkbook.Application.StatusBar = ""
    
    With err
        strSource = .Source
        strDescription = .Description
        
'        If clsBanco.possuiAcesso Then
'            strLog = Format(Now(), "dd_mm_yyyy HH:mm:ss") & " --> "
'            strLog = strLog & Left("@" & strSource & space(25), 25)
'            strLog = strLog & Left("ERRO: " & strDescription & space(100), 100)
'            strLog = strLog & Left("USER: " & Environ("UserName") & space(30), 30)
'            strLog = strLog & Left("MÓDULO: " & NOME_PROJETO & space(30), 30)
'
'            FileNumber = FreeFile                                                ' Get unused file number
'            Open ThisWorkbook.Path & "\LOG_" & UCase(TITULO_MSG) & ".txt" For Append As #FileNumber    ' Connect to the file
'            Print #FileNumber, strLog: Close #FileNumber                         ' Append our string
'
'            If MsgBox("Ocorreu um erro inesperado. Detalhes do erro:" & vbNewLine & vbNewLine & _
'                    vbTab & "-" & strSource & vbNewLine & vbTab & "-" & strDescription & vbNewLine & vbNewLine & _
'                    "Um log do erro foi criado em " & ThisWorkbook.Path & "\LOG_" & UCase(TITULO_MSG) & ".txt" & vbNewLine & vbNewLine & _
'                    "Deseja abrí-lo?", vbYesNo + vbDefaultButton2, TITULO_MSG) = vbYes Then
'
'                Shell "c:\WINDOWS\notepad.exe " & ThisWorkbook.Path & "\LOG_" & UCase(TITULO_MSG) & ".txt"
'            End If
'        Else
            MsgBox "Ocorreu um erro inesperado. Detalhes do erro:" & vbNewLine & vbNewLine & _
                    vbTab & "-" & strSource & vbNewLine & vbTab & "-" & strDescription '& vbNewLine & vbNewLine & _
                    '"Um log do erro não pode ser criado.", vbOKOnly, TITULO_MSG
'        End If
    End With
End Function
Public Function PickFolder(pPath As String, pTitle As String, Optional pSubFolder As String) As String
'=====================================================================================================================
' Procedure    : PickFolder
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pPath As String
'   - pTitle As String
'   - Optional pSubFolder As String
'=====================================================================================================================
    With Application.FileDialog(msoFileDialogFolderPicker)
    .Title = pTitle
    .InitialFileName = pPath
    .Show
        If .SelectedItems.Count > 0 Then
            If Trim(pSubFolder) <> "" Then
                If Dir(.SelectedItems(1) & pSubFolder, vbDirectory) = "" Then
                    MkDir Path:=.SelectedItems(1) & pSubFolder
                End If
            End If
            PickFolder = .SelectedItems(1) & pSubFolder
        End If
    End With
End Function
Public Function PickFiles(pTitle As String, Optional pFilter As Variant, Optional pMultiselect As Boolean) As Collection
'=====================================================================================================================
' Procedure    : PickFiles
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Collection
' Description  :
' Params
'   - pTitle As String
'   - Optional pFilter As Variant
'   - Optional pMultiselect As Boolean
'=====================================================================================================================
    Dim iCol As New Collection
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
Public Function GetFilesInFolder(pFolder As String) As Collection
'=====================================================================================================================
' Procedure    : GetFilesInFolder
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Collection
' Description  :
' Params
'   - pFolder As String
'=====================================================================================================================
    Dim objFSO As Object
    Dim objFolder As Object
    Dim objFile As Object
    Dim iCol As New Collection
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFolder = objFSO.GetFolder(pFolder)
    
    For Each objFile In objFolder.Files
        iCol.Add objFile.Path & "\" & objFile.Name
    Next objFile
    
    Set objFSO = Nothing
    Set objFolder = Nothing
    
    Set GetFilesInFolder = iCol
End Function
Public Function AppendCollectionFilesInFolder(ByRef pCol As Collection, pFolder As String)
'=====================================================================================================================
' Procedure    : AppendCollectionFilesInFolder
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - ByRef pCol As Collection
'   - pFolder As String
'=====================================================================================================================
    Dim objFSO As Object
    Dim objFolder As Object
    Dim objFile As Object
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set objFolder = objFSO.GetFolder(pFolder)
    
    For Each objFile In objFolder.Files
        If Not Contains(pCol, objFile.Name) Then
            pCol.Add objFile.Path, objFile.Name
        End If
    Next objFile
    
    Set objFSO = Nothing
    Set objFolder = Nothing

End Function
Public Function DateToSql(pDateValue As Date) As String
'=====================================================================================================================
' Procedure    : DateToSql
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pDateValue As Date
'=====================================================================================================================
    DateToSql = "'" & Year(pDateValue) & "-" & Month(pDateValue) & "-" & Day(pDateValue) & "'"
End Function
Public Function TimeToSql(pValue As Date) As String
'=====================================================================================================================
' Procedure    : TimeToSql
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pValue As Date
'=====================================================================================================================
    TimeToSql = "'" & Hour(pValue) & ":" & Minute(pValue) & ":" & Second(pValue) & "'"
End Function
Public Function StringToSql(pText As String, Optional pMaxLenght As Integer) As String
'=====================================================================================================================
' Procedure    : StringToSql
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pText As String
'   - Optional pMaxLenght As Integer
'=====================================================================================================================
    Dim iStrAux As String
    iStrAux = Replace(pText, Chr(39), vbNullString)         ' Remove aspa simples: '
    iStrAux = Replace(iStrAux, Chr(145), vbNullString)      ' Remove aspa simples: ‘
    iStrAux = Replace(iStrAux, Chr(146), vbNullString)      ' Remove aspa simples: ’
    
    If pMaxLenght > 0 Then iStrAux = Left(iStrAux, pMaxLenght)
    
    If iStrAux = "" Then
        StringToSql = "NULL"
    Else
        StringToSql = "'" & iStrAux & "'"
    End If
End Function
Public Function NumberToSql(pNumber As Variant) As String
'=====================================================================================================================
' Procedure    : NumberToSql
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pNumber As Variant
'=====================================================================================================================
    Dim i As Integer
    Dim iStrSinal As String
    Dim iStrAux As String
    Dim iCaracteres As String
    iCaracteres = "1234567890,.-"
    iStrAux = vbNullString
    iStrSinal = vbNullString
    
    pNumber = CStr(pNumber)
    
    If pNumber = vbNullString Then
        NumberToSql = "NULL"
    Else
        For i = 1 To Len(pNumber)
            If Mid(pNumber, i, 1) = "(" Then iStrSinal = "-"
            If InStr(iCaracteres, Mid(pNumber, i, 1)) <> 0 Then
                iStrAux = iStrAux & Mid(pNumber, i, 1)
            End If
        Next i
        iStrAux = Replace(iStrAux, Chr(46), vbNullString)       ' Remove pontos
        iStrAux = Replace(iStrAux, Chr(44), Chr(46))            ' Substitui vírgula por ponto
        NumberToSql = iStrSinal & iStrAux
        If Right(NumberToSql, 1) = "." Then NumberToSql = Left(NumberToSql, Len(NumberToSql) - 1)

        If Not IsNumeric(NumberToSql) Then
            Debug.Print Now & " -:- ERRO Function NumberToSql -:- Impossível formatar " & pNumber & ". Resultado não é um número válido: " & NumberToSql
            NumberToSql = "0"
        End If
    End If
End Function
Public Function ValidateNumberField(ByRef pTextBox As control, ByVal pKeyAscii As MSForms.ReturnInteger)
'=====================================================================================================================
' Procedure    : ValidateNumberField
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - ByRef pTextBox As control
'   - ByVal pKeyAscii As MSForms.ReturnInteger
'=====================================================================================================================
    With pTextBox
        Select Case pKeyAscii
            Case Asc("0") To Asc("99")
            Case Asc(","): pKeyAscii = 0
                If InStr(1, .Text, ",") <= 0 Then
                    If .Text = vbNullString Then
                        .Text = "0,"
                    Else
                        .Text = .Text & ","
                    End If
                End If
            Case Asc("-"): pKeyAscii = 0
                If (Left(.Text, 1)) <> "-" Then .Text = "-" & .Text
            Case Asc("+"): pKeyAscii = 0
                If (Left(.Text, 1)) = "-" Then .Text = Right(.Text, Len(.Text) - 1)
            Case Else: pKeyAscii = 0
        End Select
    End With
End Function
Public Function ValidateIntegerField(ByRef pTextBox As control, ByVal pKeyAscii As MSForms.ReturnInteger)
'=====================================================================================================================
' Procedure    : ValidateIntegerField
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - ByRef pTextBox As control
'   - ByVal pKeyAscii As MSForms.ReturnInteger
'=====================================================================================================================
    With pTextBox
        Select Case pKeyAscii
            Case Asc("0") To Asc("99")
            Case Else: pKeyAscii = 0
        End Select
    End With
End Function
Public Function TextFile_Write(pFilePath As String, pText As String) As Boolean
'=====================================================================================================================
' Procedure    : WriteTextFile
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Boolean
' Description  :
' Params
'   - pFilePath As String
'   - pText As String
'=====================================================================================================================
    Dim intFNumber As Integer
    intFNumber = FreeFile
    
    If boolErrorHandler Then On Error GoTo ErrorHandler
    
    If boolAppendFile Then
        Open pFilePath For Output As #intFNumber
        Print #intFNumber, pText
        Close #intFNumber
    End If
    
    On Error GoTo 0
    TextFile_Write = True
    Exit Function
ErrorHandler:
    MsgBox "Não foi possível salvar o arquivo." & vbNewLine & "Verifique o caminho informado e as permissões de acesso", vbInformation
End Function
Public Function TextFile_Append(pFilePath As String, pText As String) As Boolean
'=====================================================================================================================
' Procedure    : AppendTextFile
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Boolean
' Description  :
' Params
'   - pFilePath As String
'   - pText As String
'=====================================================================================================================
    Dim intFNumber As Integer
    intFNumber = FreeFile
    
    If boolErrorHandler Then On Error GoTo ErrorHandler
    
    Open pFilePath For Append As #intFNumber
    Print #intFNumber, pText
    Close #intFNumber
    
    On Error GoTo 0
    
    TextFile_Append = True
    Exit Function
ErrorHandler:
    MsgBox "Não foi possível salvar o arquivo." & vbNewLine & "Verifique o caminho informado e as permissões de acesso", vbInformation
End Function
Public Function LockScreen(pLock As Boolean)
'=====================================================================================================================
' Procedure    : LockScreen
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pLock As Boolean
'=====================================================================================================================
    With Application
        .DisplayAlerts = Not (boolErrorHandler And pLock)
        .EnableEvents = Not (boolErrorHandler And pLock)
        .ScreenUpdating = Not (boolErrorHandler And pLock)
        .Cursor = IIf((boolErrorHandler And pLock), xlWait, xlDefault)
    End With
End Function
Public Function ShowProgress(pText As String, Optional pLen As Double, Optional ptextAux As String, Optional pChar As String)
'=====================================================================================================================
' Procedure    : ShowProgress
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pText As String
'   - Optional pLen As Double
'   - Optional ptextAux As String
'   - Optional pChar As String
'=====================================================================================================================
    Dim strAux As String
    strAux = pText
    If Trim(ptextAux) <> "" Then
        strAux = strAux & " " & WorksheetFunction.Rept(IIf(pChar = "", " ", pChar), pLen - Len(strAux)) & " " & ptextAux
    End If
    Application.StatusBar = Left("Atualizando... " & strAux, 255)
    Debug.Print strAux
End Function
Public Function LogError()
'=====================================================================================================================
' Procedure    : LogError
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
'=====================================================================================================================
    Debug.Print Format(Now(), "hh:MM:ss") & "@" & err.Source & " - " & err.Description
End Function
Public Function ClipBoardThis(pText As String)
'=====================================================================================================================
' Procedure    : ClipBoardThis
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pText As String
'=====================================================================================================================
    Dim objData As New MSForms.DataObject
    objData.SetText pText
    objData.PutInClipboard
End Function
Public Function ColumnLetter(pNumber As Long) As String
'=====================================================================================================================
' Procedure    : ColumnLetter
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  : Created by brettdj (Melbourne, Australia) Oct/2012 at http://stackoverflow.com/questions/12796973/vba-function-to-convert-column-number-to-letter
'                Updated by Sidnei A. Graciolli Jr. (SP, Brazil) Nov/2014
' Params
'   - pNumber As Long
'=====================================================================================================================
    If pNumber > Columns.Count Then pNumber = pNumber Mod Columns.Count
    ColumnLetter = Split(Cells(1, pNumber).Address(True, False), "$")(0)
End Function
Public Function SetErrorHandler(pRotina As String)
'=====================================================================================================================
' Procedure    : SetErrorHandler
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pRotina As String
'=====================================================================================================================
    boolErrorHandler = (GetKeyState(VK_CONTROL) >= 0)
    If Not boolErrorHandler Then boolErrorHandler = MsgBox("Atenção! O Sistema identificou que a tecla CTRL estava pressionada ao chamar a rotina " & pRotina & "." & vbNewLine & vbNewLine & _
                                                           "Esta opção desabilita o tratamento de erros para debbugging e aumenta consideravelmente o tempo de processamento." & vbNewLine & vbNewLine & _
                                                           "A opção de debugging deve ser utilizada apenas para análise do código VBA. Deseja continuar? (Escolha NÃO para desabilitar o modo de debugging)", vbYesNo + vbDefaultButton2 + vbExclamation, "Debugging mode") = vbNo
End Function
Public Function WorkbookIsOpen(pName As String) As Boolean
'=====================================================================================================================
' Procedure    : WorkbookIsOpen
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Boolean
' Description  :
' Params
'   - pName As String
'=====================================================================================================================
    Dim iWb As Workbook
    For Each iWb In Application.Workbooks
        If iWb.Name = pName Then
            WorkbookIsOpen = True
            Exit For
        End If
    Next
End Function
Public Function IsMasterUser() As Boolean
'=====================================================================================================================
' Procedure    : IsMasterUser
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Boolean
' Description  :
'=====================================================================================================================
    If (MASTER_USER = Environ("UserName")) Then
        'MsgBox "MASTER_USER Verified!", vbOKOnly + vbExclamation, TITULO_MSG
        IsMasterUser = True
    Else
        IsMasterUser = False
    End If
End Function
Public Function GetFileNameByPath(pFileFullPath As String) As String
'=====================================================================================================================
' Procedure    : GetFileNameByPath
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pFileFullPath As String
'=====================================================================================================================
    GetFileNameByPath = StrReverse(Split(StrReverse(pFileFullPath), "\")(0))
End Function
Public Function TextFile_GetRowCount(pFileFullPath As String) As Long
'=====================================================================================================================
' Procedure    : GetTxtFileRowCount
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Long
' Description  :
' Params
'   - pFileFullPath As String
'=====================================================================================================================
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set theFile = fso.OpenTextFile(pFileFullPath, 8, True)
    TextFile_GetRowCount = theFile.Line
    Set oFso = Nothing
    theFile.Close
    Set theFile = Nothing
End Function
Public Function ClearCacheMemory()
'=====================================================================================================================
' Procedure    : ClearCacheMemory
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
'=====================================================================================================================
    Dim wsh As Object
    Set wsh = VBA.CreateObject("WScript.Shell")
    Dim waitOnReturn As Boolean: waitOnReturn = True
    Dim windowStyle As Integer: windowStyle = 1
    
    wsh.Run "cmd.exe /S /C %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks", windowStyle, waitOnReturn
End Function
Public Function EstimatedTime(pStart As Date, pPosition As Long, pTotal As Long) As Date
'=====================================================================================================================
' Procedure    : EstimatedTime
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Date
' Description  :
' Params
'   - pStart As Date
'   - pPosition As Long
'   - pTotal As Long
'=====================================================================================================================
    Dim iTime As Date
    Dim iFracTime As Date
    
    iTime = Now - pStart
    iFracTime = iTime / pPosition
    
    EstimatedTime = Format(iFracTime * (pTotal - pPosition), "dd/mm/yy hh:mm:ss")
    
End Function
Public Function PreventNullString(pText As Variant) As String
'=====================================================================================================================
' Procedure    : PreventNullString
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pText As Variant
'=====================================================================================================================
    If IsNull(pText) Then
        PreventNullString = ""
    Else
        PreventNullString = CStr(pText)
    End If
End Function
Public Sub SelectAllText(ByRef pTextBox As MSForms.TextBox)
'=====================================================================================================================
' Procedure    : SelectAllText
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Sub
' Return       : Void
' Description  :
' Params
'   - ByRef pTextBox As MSForms.TextBox
'=====================================================================================================================
    pTextBox.SelStart = 0
    pTextBox.SelLength = Len(pTextBox.Text)
End Sub
Public Function KillIfExists(pFileFullName As String)
'=====================================================================================================================
' Procedure    : KillIfExists
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pFileFullName As String
'=====================================================================================================================
    If Dir(pFileFullName) <> vbNullString Then Kill pFileFullName
End Function
Public Function CreateBatch(pLines As Variant, Optional pAutoRun As Boolean = True, Optional pAutoDestroy As Boolean = True, Optional pEchoOff As Boolean = True)
'=====================================================================================================================
' Procedure    : CreateBatch
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pLines As Variant
'   - Optional pAutoRun As Boolean = True
'   - Optional pAutoDestroy As Boolean = True
'   - Optional pEchoOff As Boolean = True
'=====================================================================================================================
    Dim batchFullName As String
    Dim s As Integer
    
    If ThisWorkbook.Saved Then
        batchFullName = Environ("TEMP") & "\" & IIf(ThisWorkbook.Saved, UCase(ClearString(CStr(Split(ThisWorkbook.Name, ".")(0)))), "TEMP_BATCH_FILE") & ".bat"
    Else
    
    End If
    
    KillIfExists batchFullName
    
    Sleep 1000
    
    Do While Dir(batchFullName) = vbNullString
        If pEchoOff Then TextFile_Append batchFullName, "@ECHO OFF"
        
        For s = LBound(pLines) To UBound(pLines)
            TextFile_Append batchFullName, CStr(pLines(s))
        Next s
        
        If pAutoDestroy Then
            TextFile_Append batchFullName, "TIMEOUT 3"
            TextFile_Append batchFullName, "DEL /Q /F " & batchFullName
        End If
        
        Sleep 500
    Loop
    
    If pAutoRun Then Shell batchFullName, vbMinimizedNoFocus
End Function
Public Function ClearString(pText As String) As String
'=====================================================================================================================
' Procedure    : ClearString
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : String
' Description  :
' Params
'   - pText As String
'=====================================================================================================================
    codiA = "àáâãäèéêëìíîïòóôõöùúûüÀÁÂÃÄÈÉÊËÌÍÎÒÓÔÕÖÙÚÛÜçÇñÑ,. /\?!"
    codiB = "aaaaaeeeeiiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcCnN_______"
    temp = pText
    For j = 1 To Len(temp)
        p = InStr(codiA, Mid(temp, j, 1))
        If p > 0 Then Mid(temp, j, 1) = Mid(codiB, p, 1)
    Next
    ClearString = temp
End Function
Public Function RemoveCloseButton(pUserForm As Object)
'=====================================================================================================================
' Procedure    : RemoveCloseButton
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - pUserForm As Object
'=====================================================================================================================
    Dim lngStyle As Long
    Dim lngHWnd As Long

    lngHWnd = FindWindow(vbNullString, pUserForm.Caption)
    lngStyle = GetWindowLong(lngHWnd, mcGWL_STYLE)

    If lngStyle And mcWS_SYSMENU > 0 Then
        SetWindowLong lngHWnd, mcGWL_STYLE, (lngStyle And Not mcWS_SYSMENU)
    End If
End Function
Public Function ListView_SetHeader(ByVal oObjListView As ListView, ByVal aTitulos As Variant)
'=====================================================================================================================
' Procedure    : ListView_SetHeader
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - ByVal oObjListView As ListView
'   - ByVal aTitulos As Variant
'=====================================================================================================================
    Dim j As Integer
    
    oObjListView.HideColumnHeaders = False
    oObjListView.View = lvwReport
    oObjListView.ColumnHeaders.Clear
    
    For j = 0 To UBound(aTitulos) Step 2
        oObjListView.ColumnHeaders.Add , , aTitulos(j), aTitulos(j + 1)
    Next j
End Function
Public Function ListView_Populate(oObjListView As ListView, ByVal aDados As Variant)
'=====================================================================================================================
' Procedure    : ListView_Populate
' Author       : s.graziollijunior (MAI/2016)
' Type         : Public Function
' Return       : Void
' Description  :
' Params
'   - oObjListView As ListView
'   - ByVal aDados As Variant
'=====================================================================================================================
    Dim j As Integer
    Dim nPOS As Integer
    
    oObjListView.ListItems.Add , , aDados(0)  ' ID
    nPOS = oObjListView.ListItems.Count
    
    For j = 1 To UBound(aDados)
        oObjListView.ListItems(nPOS).ListSubItems.Add , , aDados(j)
    Next j
End Function
Public Function TextFile_ReadToCollection(pFilePath As String) As Collection
'=====================================================================================================================
' Procedure    : ReadTextFile
' Author       : s.graziollijunior (AGO/2016)
' Type         : Public Function
' Return       : Collection
' Description  :
' Params
'   - pFilePath As String
'=====================================================================================================================
    Dim colResult As New Collection
    Dim intFNumber As Integer
    Dim strTextLine As String
    
    intFNumber = FreeFile
    
    Open pFilePath For Input As #intFNumber
    Do Until EOF(intFNumber)
        Line Input #intFNumber, strTextLine
        colResult.Add strTextLine
    Loop
    Close #intFNumber
    
    Set TextFile_ReadToCollection = colResult
    
End Function


