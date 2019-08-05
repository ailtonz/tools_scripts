VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Banco"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Classe de conexão ADO
'Necessário para utilização:
'Referência para 'Microsoft ActiveX Data Objects 2.8 Library'
'Módulo Util



Option Explicit

Private Const MAX_TENTATIVAS        As Integer = 3
Private Const MAX_SLEEP             As Long = 500
Private Const ERR_SELECT            As Long = 1
Private Const ERR_EXECUTE           As Long = 2
Private Const ERR_CONECT            As Long = 3

Private iSql                        As String
Private iDataSource                 As String
Private iDatabaseName               As String
Private iUser                       As String
Private iPwd                        As String
Private iDriverODBC                 As enDriverODBC
Private iCn                         As New ADODB.Connection
Private iRs                         As New ADODB.Recordset

Property Get sql() As String
    sql = iSql
End Property
Property Let sql(value As String)
    iSql = value
End Property
Property Get rs() As ADODB.Recordset
    Set rs = iRs
End Property
Property Let DataSource(pValue As String)
    iDataSource = pValue
End Property
Property Let DatabaseName(pValue As String)
    iDatabaseName = pValue
End Property
Property Let User(pValue As String)
    iUser = pValue
End Property
Property Let Pwd(pValue As String)
    iPwd = pValue
End Property
Property Let DriverODBC(pValue As enDriverODBC)
    iDriverODBC = pValue
End Property
'================================================================================================================
'=   FIM DAS PROPRIEDADES DA CLASSE   ===========================================================================
'================================================================================================================
Public Function SqlSelect(Optional pSql As String, Optional pStayConnected As Boolean)
    Dim intTentativas As Integer
    If pSql <> vbNullString Then iSql = pSql
    If iSql = vbNullString Then Exit Function
    If boolErrorHandler Then On Error GoTo ErrHandler
        
    OpenConnection
    Set iRs = Nothing
    iRs.CursorLocation = adUseClient

    Do Until intTentativas = MAX_TENTATIVAS
        err.Clear
        iRs.Open iSql, iCn, ADODB.adOpenForwardOnly, adLockReadOnly
        If err.Number = 0 Then
            Set iRs.ActiveConnection = Nothing
            If Not pStayConnected Then CloseConnection
            Exit Do
        Else
            intTentativas = intTentativas + 1
            Sleep MAX_SLEEP
        End If
    Loop
Exit Function
ErrHandler:
    If intTentativas = MAX_TENTATIVAS Then
        Debug.Print " -- Erro " & err.Description & " " & Now() & " -- " & vbNewLine & iSql
        err.Raise vbObjectError + 512 + ERR_SELECT
    Else
        intTentativas = intTentativas + 1
        Sleep MAX_SLEEP
        Resume
    End If
End Function
Public Function SqlExecute(Optional pSql As String, Optional pStayConnected As Boolean)
    Dim intTentativas As Integer
    If pSql <> vbNullString Then iSql = pSql
    If iSql = vbNullString Then Exit Function
    If boolErrorHandler Then On Error GoTo ErrHandler
    
    OpenConnection
    
    Do Until intTentativas = MAX_TENTATIVAS
        err.Clear
        iCn.Execute iSql, adExecuteNoRecords
        If err.Number = 0 Then
            If Not pStayConnected Then CloseConnection
            Exit Do
        Else
            intTentativas = intTentativas + 1
            Sleep MAX_SLEEP
        End If
    Loop
Exit Function
ErrHandler:
    If intTentativas = MAX_TENTATIVAS Then
        Debug.Print " -- Erro " & err.Description & " " & Now() & " -- " & vbNewLine & iSql
        err.Raise vbObjectError + 512 + ERR_EXECUTE
    Else
        intTentativas = intTentativas + 1
        Sleep MAX_SLEEP
        Resume
    End If
End Function
Public Function OpenConnection()
    Dim intTentativas As Integer
    If boolErrorHandler Then On Error GoTo ErrHandler
    If iCn.State = 0 Then
    
        If (iCn.Provider <> "Microsoft.ACE.OLEDB.12.0") _
        And (iCn.Provider <> "Microsoft.Jet.OLEDB.4.0") Then
            iCn.ConnectionTimeout = 3600
            iCn.CommandTimeout = 3600
        End If

        Do Until intTentativas = MAX_TENTATIVAS
            iCn.Open
            Exit Do
        Loop
    End If
Exit Function
ErrHandler:
    If intTentativas = MAX_TENTATIVAS Then
        Debug.Print " -- Erro " & err.Description & " " & Now() & " -- "
        err.Raise vbObjectError + 512 + ERR_CONECT
    Else
        intTentativas = intTentativas + 1
        Sleep MAX_SLEEP
        Resume
    End If
End Function
Public Function CloseConnection()
    On Error Resume Next
        iCn.Close
    On Error GoTo 0
End Function
Public Function Start(pUser As String, pPwd As String, pDataSource As String, pDataBaseName As String, pDriverODBC As enDriverODBC)
    iUser = pUser
    iPwd = pPwd
    iDataSource = pDataSource
    iDatabaseName = pDataBaseName
    Select Case pDriverODBC
        Case drAccess:      iCn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0" & _
                                                    ";Data Source=" & pDataSource & pDataBaseName & _
                                                    ";Jet OLEDB:Database Password=" & pPwd & ";"

        Case drSqlServer:   iCn.ConnectionString = "Provider = SQLOLEDB" & _
                                                    ";Data Source=" & pDataSource & _
                                                    ";Initial Catalog=" & pDataBaseName & _
                                                    ";User ID=" & pUser & _
                                                    ";Password=" & pPwd
                                                    
        Case drExcel_8:     iCn.ConnectionString = "Provider = Microsoft.Jet.OLEDB.4.0" & _
                                                    ";Data Source=" & pDataSource & ";"
                            iCn.Properties("Extended Properties") = "Excel 8.0;HDR=Yes;"
        
        Case drExcel_12:    iCn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0" & _
                                                    ";Data Source=" & pDataSource & ";"
                            iCn.Properties("Extended Properties") = "Excel 12.0 Macro;HDR=YES;"
                            
        Case drSqlite:      iCn.ConnectionString = "DRIVER=SQLite3 ODBC Driver;Database=" & pDataSource & pDataBaseName
    End Select
End Function
Public Function PaginateQuery(pTable As String, pIndex As String, pQuery As String, pWhere As String, pStartLine As Long, pQtdLines As Long)
    iSql = "SELECT * FROM(SELECT ROW_NUMBER() OVER (ORDER BY " & pIndex & ") AS RowNum, " & _
            Right(pQuery, Len(pQuery) - 6) & pWhere & ") AS RowConstrainedResult WHERE RowNum >= " & pStartLine & _
            " AND RowNum <= " & pStartLine + (pQtdLines - 1) & " ORDER BY RowNum"
    
    SqlSelect
End Function
Public Function SqlSelectToCollection(ByRef pColHeader As Collection, ByRef pColRows As Collection, Optional pSql As String)
    Dim colResult As Collection
    Dim colRow As Collection
    Dim rsField As ADODB.Field
    
    SqlSelect pSql
    
    Set colResult = New Collection
    
    If Not iRs.EOF Then
        
        Set colRow = New Collection
        For Each rsField In iRs.Fields
            colRow.Add rsField
        Next
        Set pColHeader = colRow
        
        Do While Not iRs.EOF
            Set colRow = New Collection
            For Each rsField In iRs.Fields
                colRow.Add PreventNullString(rsField.value)
            Next
            colResult.Add colRow
            iRs.MoveNext
        Loop
        Set pColRows = colResult
    Else
        Set pColHeader = New Collection
        Set pColRows = New Collection
    End If
End Function

Public Function SqlSelectToListView(ByRef pListView As ListView, Optional pSql As String)
    Dim rsField As ADODB.Field
    Dim lst As ListView
    Dim colHeaderWidth As Collection

    Set lst = pListView
    lst.ListItems.Clear
    lst.ColumnHeaders.Clear
    lst.HideColumnHeaders = False
    lst.View = lvwReport
    
    SqlSelect CStr(Split(UCase(pSql), "WHERE")(0))
    Set colHeaderWidth = New Collection
    
    For Each rsField In iRs.Fields
        lst.ColumnHeaders.Add Text:=rsField.Name
        colHeaderWidth.Add Len(rsField.Name)
    Next
    
    SqlSelect pSql
    
    If Not iRs.EOF Then
        Do While Not iRs.EOF
            lst.ListItems.Add , , iRs(0)
            CheckGreaterValue colHeaderWidth, Len(iRs(0)), 1
            
            For i = 2 To iRs.Fields.Count
                lst.ListItems(lst.ListItems.Count).ListSubItems.Add , , PreventNullString(iRs(i - 1))
                CheckGreaterValue colHeaderWidth, Len(iRs(i - 1)), CLng(i)
            Next
            
            iRs.MoveNext
        Loop
        
    End If
    For i = 1 To colHeaderWidth.Count
        lst.ColumnHeaders(i).Width = colHeaderWidth(i) * 8
    Next i
End Function

