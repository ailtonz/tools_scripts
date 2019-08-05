Attribute VB_Name = "mdlClassGen"
Option Explicit

#If VBA7 Then
    Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#Else
    Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Sub CriaClasse()

Dim ws As Worksheet: Set ws = Worksheets("Sheet1")
'Dim rng As Range, Target As Range: Set Target = Selection.Cells().SpecialCells(xlCellTypeConstants, 2)

Dim arrProps() As String: arrProps = Split(RangeToArray(ws.Range("a1:b6")), ",")

'NewClass ws.Name, arrProps
NewClass "movimientos2", arrProps

End Sub


Function NewClass(pName As String, pProperties As Variant)
    Dim strCaminho As String
    Dim strGetLet As String
    Dim intLinha1 As Integer
    Dim intLinha2 As Integer
    Dim intLinha3 As Integer
    Dim strDoubleQuote As String
    Dim strAuxInsert As String
    Dim i As Double

    On Error Resume Next
    Kill ThisWorkbook.Path & "\*.cls"
    On Error GoTo 0
    
    strDoubleQuote = Chr(34)
    
    strCaminho = ThisWorkbook.Path & "\" & pName & ".cls"
    Open strCaminho For Output As #1
    Print #1, "VERSION 1.0 CLASS"
    Print #1, "BEGIN"
    Print #1, "  MultiUse = -1  'True"
    Print #1, "END"
    Print #1, "Attribute VB_Name = " & Chr(34) & pName & Chr(34)
    Print #1, "Attribute VB_GlobalNameSpace = False"
    Print #1, "Attribute VB_Creatable = False"
    Print #1, "Attribute VB_PredeclaredId = False"
    Print #1, "Attribute VB_Exposed = False"
    Print #1, "Option Explicit"
    Print #1, vbNullString
    Print #1, FormataAtributo(True, "clsBanco", "Banco", 42)
    Print #1, FormataAtributo(True, "Col", "New Collection", 42)
    'Print #1, "Private iCol As New Collection"

    For i = LBound(pProperties) To UBound(pProperties) Step 2
        Print #1, FormataAtributo(True, CStr(pProperties(i)), CStr(pProperties(i + 1)), 42)
    Next i
    'Print #1, vbNullString

    '##- Gera os Gets e Lets

    intLinha1 = 80
    intLinha2 = 180
    intLinha3 = 220

    For i = LBound(pProperties) To UBound(pProperties) Step 2
        strGetLet = ""
        Select Case UCase(Trim(pProperties(i + 1)))
            Case "STRING", "INTEGER", "BOOLEAN", "LONG"

                strGetLet = "Property Get " & pProperties(i) & "() As " & pProperties(i + 1) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & pProperties(i) & " = i" & pProperties(i) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

                strGetLet = "Property Let " & pProperties(i) & "(pValue As " & pProperties(i + 1) & ")" & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & "i" & pProperties(i) & " = pValue:"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

            Case "DOUBLE"

                strGetLet = "Property Get " & pProperties(i) & "() As " & pProperties(i + 1) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & pProperties(i) & " = Format(i" & pProperties(i) & ", strNumberFormat):"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

                strGetLet = "Property Let " & pProperties(i) & "(pValue As " & pProperties(i + 1) & ")" & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & "i" & pProperties(i) & " = pValue:"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

            Case "DATE"

                strGetLet = "Property Get " & pProperties(i) & "() As " & pProperties(i + 1) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & pProperties(i) & " = Iif(i" & pProperties(i) & "=0," & Chr(34) & Chr(34) & ",Format(i" & pProperties(i) & ", strDateFormat)):"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

                strGetLet = "Property Let " & pProperties(i) & "(pValue As " & pProperties(i + 1) & ")" & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & "i" & pProperties(i) & " = pValue:"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

            Case Else

                strGetLet = "Property Get " & pProperties(i) & "() as " & pProperties(i + 1) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & "If i" & pProperties(i) & " Is Nothing Then Set i" & pProperties(i) & " = " & pProperties(i + 1) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "Set " & pProperties(i) & " = i" & pProperties(i) & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha3 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet

                strGetLet = "Property Let " & pProperties(i) & "(pValue as " & pProperties(i + 1) & ")" & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha1 - Len(strGetLet))
                strGetLet = strGetLet & "Set i" & pProperties(i) & " = pValue" & ":"
                strGetLet = strGetLet & WorksheetFunction.Rept(" ", intLinha2 - Len(strGetLet))
                strGetLet = strGetLet & "End Property"
                Print #1, strGetLet


'                Print #1, "Property Get " & pProperties(i) & "() as Collection"
'                Print #1, "    If i" & pProperties(i) & " Is Nothing Then Set i" & pProperties(i) & " = " & pProperties(i + 1)
'                Print #1, "    Set " & pProperties(i) & " = i" & pProperties(i)
'                Print #1, "End Property"
'                Print #1, "Property Let " & pProperties(i) & "(pValue as " & pProperties(i + 1) & ")"
'                Print #1, "    Set i" & pProperties(i) & " = pValue"
'                Print #1, "End Property"
        End Select
    Next i

    Print #1, vbNullString
    Print #1, "''---------------"
    Print #1, "'' administração"
    Print #1, "''---------------"
    Print #1, vbNullString
    Print #1, "Public Function NewEnum() As IUnknown"
    Print #1, "Attribute NewEnum.VB_UserMemId = -4"
    Print #1, "    Set NewEnum = iCol.[_NewEnum]"
    Print #1, "End Function"
    Print #1, vbNullString
    Print #1, "Private Sub Class_Initialize()"
    Print #1, "    Set iCol = New Collection"
    Print #1, "End Sub"
    Print #1, vbNullString
    Print #1, "Private Sub Class_Terminate()"
    Print #1, "    Set iCol = Nothing"
    Print #1, "End Sub"
    Print #1, vbNullString
    Print #1, "Public Sub add(ByVal rec As " & pName & ", Optional ByVal key As Variant, Optional ByVal before As Variant, Optional ByVal after As Variant)"
    Print #1, "    iCol.add rec, key, before, after"
    Print #1, "End Sub"
    Print #1, vbNullString
    Print #1, "Public Sub all(ByVal rec As " & pName & ")"
    Print #1, "    iCol.add rec, rec.id"
    Print #1, "End Sub"
    Print #1, vbNullString
    Print #1, "Public Function count() As Long"
    Print #1, "    count = iCol.count"
    Print #1, "End Function"
    Print #1, vbNullString
    Print #1, "Public Sub remove(ByVal i As Integer)"
    Print #1, "    iCol.remove i"
    Print #1, "End Sub"
    Print #1, vbNullString
    Print #1, "Public Function " & pName & "(ByVal i As Variant) As " & pName & ""
    Print #1, "    Set " & pName & " = iCol.item(i)"
    Print #1, "End Function"
    Print #1, vbNullString
    Print #1, "Public Property Get Itens() As Collection"
    Print #1, "    Set Itens = iCol"
    Print #1, "End Property"
    Print #1, vbNullString
    Print #1, "Public Property Get item(i As Variant) As " & pName & ""
    Print #1, "    Set item = iCol(i)"
    Print #1, "End Property"
    Print #1, vbNullString
    Print #1, vbNullString
    Print #1, "''---------------"
    Print #1, "'' FUNÇÕES"
    Print #1, "''---------------"
    
    Print #1, "Public Function Insert()"
    
    Print #1, "    Dim strInsert as string"
    Print #1, "    strInsert = " & strDoubleQuote & "INSERT INTO " & pName & " (" & strDoubleQuote
    
    strAuxInsert = ""
    For i = LBound(pProperties) To UBound(pProperties) Step 2
        strAuxInsert = strAuxInsert & IIf(strAuxInsert = vbNullString, "", ",") & pProperties(i)
    Next i
    
    Print #1, "    strInsert = strInsert & " & strDoubleQuote & strAuxInsert & ") VALUES (" & strDoubleQuote
    
    strAuxInsert = ""
    For i = LBound(pProperties) To UBound(pProperties) Step 2
        strAuxInsert = strAuxInsert & IIf(strAuxInsert = vbNullString, "", " & " & strDoubleQuote & "," & strDoubleQuote & " & ") & "i" & pProperties(i)
    Next i
    
    Print #1, "    strInsert = strInsert & " & strAuxInsert & " & " & strDoubleQuote & ")" & strDoubleQuote
    Print #1, "End Function"

    Close #1

    DoEvents: Sleep 100
    DoEvents: Sleep 100

    ImportaClasse ThisWorkbook, strCaminho, pName
    Kill strCaminho

End Function
Function FormataAtributo(pPrivate As Boolean, pNome As String, pTipo As String, Optional pTamanho As Integer) As String
    Dim iPrefixo As String
    iPrefixo = IIf(pPrivate, "Private ", "Public ") & "i" & PrimMaiusc(pNome)
    If pTamanho - Len(iPrefixo) >= 0 Then
        FormataAtributo = iPrefixo & WorksheetFunction.Rept(" ", pTamanho - Len(iPrefixo)) & "As " & PrimMaiusc(pTipo)
    Else
        FormataAtributo = iPrefixo & " As " & PrimMaiusc(pTipo)
    End If
End Function
Function ImportaClasse(ByVal wb As Workbook, ByVal CompFileName As String, pNomeClasse As String)
    If Dir(CompFileName) <> vbNullString Then
        On Error Resume Next
        wb.VBProject.VBComponents.remove wb.VBProject.VBComponents(pNomeClasse)
        DoEvents
        wb.VBProject.VBComponents.Import CompFileName
        On Error GoTo 0
    End If
    Set wb = Nothing
End Function
Function QuebraLinha(pTexto As String) As String
    QuebraLinha = "' " & WorksheetFunction.Rept("-", 90 - Len(pTexto)) & " " & pTexto
End Function
Function PrimMaiusc(pTexto As String) As String
    PrimMaiusc = UCase(Left(pTexto, 1)) & Right(pTexto, Len(pTexto) - 1)
End Function

Function RangeToArray(pRange As Range) As String
    Dim c As Variant
    Dim strAux As String

    For Each c In pRange
        strAux = strAux & IIf(strAux = "", "", ",") & c
    Next c

    RangeToArray = strAux

End Function

