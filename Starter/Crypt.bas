Attribute VB_Name = "Crypt"
'Módulo de criptografia de string
Option Compare Binary
Private Const KEY1 As String = "13579_!@#24=LmMnoPTx^;qrR0uUt"
Private Const KEY2 As String = "$%&aAbBcDEfFGhiIjJK-.*?/< ,yY"

Public Function Crypto(pTexto As String) As String
    Dim strResult As String
    Dim strTempChar As String
    Dim i, u As Integer
    Scramble pTexto
    For i = 1 To Len(pTexto)
    
        If Asc(Mid$(pTexto, i, 1)) < 128 Then
           strResult = strResult & Letra(Chr(Asc(Mid$(pTexto, i, 1)) + 128))
        ElseIf Asc(Mid$(pTexto, i, 1)) > 128 Then
           strResult = strResult & Chr(Asc(Letra(Mid$(pTexto, i, 1))) - 128)
        End If
    Next i
    Crypto = Trim(strResult)
End Function
Private Function Letra(pLetra As String) As String
    Dim auxLetra As String
    Dim i As Integer
    auxLetra = pLetra
    For i = 1 To Len(KEY1)
        If pLetra = Mid(KEY1, i, 1) Then auxLetra = Mid(KEY2, i, 1)
        If pLetra = Mid(KEY2, i, 1) Then auxLetra = Mid(KEY1, i, 1)
    Next i
    Letra = auxLetra
    
End Function
Private Function Scramble(ByRef pTexto As String)
    Dim strAux As String
    Dim i As Integer
    If Len(pTexto) Mod 2 <> 0 Then pTexto = pTexto & " "
    For i = 1 To Len(pTexto) Step 2
        strAux = Mid(pTexto, i, 2) & strAux
    Next i
    pTexto = StrReverse(Trim(strAux))
End Function
