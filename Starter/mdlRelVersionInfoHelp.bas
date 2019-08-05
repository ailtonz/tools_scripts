Attribute VB_Name = "mdlRelVersionInfoHelp"
'Módulo de exibição de Versão e HELP
Private htmlStr As String
Public Function ShowVersion()
    Dim strVerNumber As String
    Dim strVerData As String
    Dim colNews As Collection, colBugs As Collection
    Dim bolNew As Boolean
    
    bolNew = True
    htmlStr = ""
    htmlStr = htmlStr & "<!DOCTYPE html><html><body>"
    htmlStr = htmlStr & "<br><h1><center>VERS&Atilde;O ATUAL</center></h1>"
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    strVerData = "DD/MM/AAAA":  strVerNumber = "0.0.0":   Set colNews = New Collection:    Set colBugs = New Collection
    
    colNews.Add "Ononononononononononononononon"
    colNews.Add "Ononononononononononononononon"
    colNews.Add "Ononononononononononononononon"
    colBugs.Add "Ononononononononononononononon"
    colBugs.Add "Ononononononononononononononon"
    colBugs.Add "Ononononononononononononononon"
    
    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    If ThisWorkbook.BuiltinDocumentProperties("Title") <> "V" & strVerNumber Then
        ThisWorkbook.BuiltinDocumentProperties("Title") = "V" & strVerNumber
        ThisWorkbook.Save
    End If
    htmlStr = htmlStr & "<br><h1><center>VERS&Otilde;ES ANTERIORES</center></h1>"
    bolNew = False
    
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    strVerData = "DD/MM/AAAA":  strVerNumber = "0.0.0":   Set colNews = New Collection:    Set colBugs = New Collection
    
    colNews.Add "Ononononononononononononononon"
    colNews.Add "Ononononononononononononononon"
    
    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    htmlStr = htmlStr & "</body></html>"
    
    frmReport.Show
    With frmReport.WebBrowser
        .Navigate "about:blank": DoEvents
        .Document.Write htmlStr: DoEvents
    End With

End Function
Private Function FormatVersion(pVersion As String, pDate As String, pNews As Collection, pBugs As Collection, pNew As Boolean) As String
    Dim iHtml As String

    iHtml = iHtml & "<hr>"
    iHtml = iHtml & "<h2><b><u>Vers&atilde;o " & pVersion & ":</u></b></h2>"
    iHtml = iHtml & "<b>Data:</b> " & pDate
    If pNew Then iHtml = iHtml & "<br><br><b>O que h&aacute; de novo:</b>"
    iHtml = iHtml & "<ul>"
    For Each t In pNews
        iHtml = iHtml & "<li>" & t & ";</li>"
    Next
    iHtml = iHtml & "</ul>"
    If pBugs.Count > 0 Then
        iHtml = iHtml & "<b>Bugs conhecidos:</b>"
        iHtml = iHtml & "<ul>"
        For Each t In pBugs
            iHtml = iHtml & "<li>" & t & ";</li>"
        Next
        iHtml = iHtml & "</ul>"
    End If
    iHtml = iHtml & "<hr>"

    FormatVersion = iHtml

End Function

Public Function ShowHelp()

    htmlStr = ""
    htmlStr = htmlStr & "<!DOCTYPE html>" & vbNewLine
    htmlStr = htmlStr & "<html>" & vbNewLine
    htmlStr = htmlStr & "<head>" & vbNewLine
    htmlStr = htmlStr & "<title>Page Title</title>" & vbNewLine
    htmlStr = htmlStr & "</head>" & vbNewLine
    htmlStr = htmlStr & "<body>" & vbNewLine
    
    htmlStr = htmlStr & "<h1 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">PROJETO – Manual do Usuário</h1>" & vbNewLine
    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">Versão - " & ThisWorkbook.BuiltinDocumentProperties("Title") & "</h2>" & vbNewLine
    htmlStr = htmlStr & "" & vbNewLine
    htmlStr = htmlStr & "<div>" & vbNewLine
    
    htmlStr = htmlStr & "<a name=" & Chr(34) & "topo" & Chr(34) & "><h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">Índice</h2>" & vbNewLine
    htmlStr = htmlStr & "<ul>" & vbNewLine
    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine
    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine
    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine
    htmlStr = htmlStr & "<li>Informação de versão;</li>" & vbNewLine
    htmlStr = htmlStr & "</ul>" & vbNewLine
    htmlStr = htmlStr & "</div>" & vbNewLine
    htmlStr = htmlStr & "" & vbNewLine
    
    htmlStr = htmlStr & "<div>" & vbNewLine
    htmlStr = htmlStr & "<hr>" & vbNewLine
    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine
    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine
    htmlStr = htmlStr & "DESCRIÇÃO" & vbNewLine
    htmlStr = htmlStr & "</div>" & vbNewLine
    htmlStr = htmlStr & "" & vbNewLine
    
    htmlStr = htmlStr & "<div>" & vbNewLine
    htmlStr = htmlStr & "<hr>" & vbNewLine
    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine
    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine
    htmlStr = htmlStr & "DESCRIÇÃO" & vbNewLine
    htmlStr = htmlStr & "</div>" & vbNewLine
    htmlStr = htmlStr & "" & vbNewLine
    
    htmlStr = htmlStr & "<div>" & vbNewLine
    htmlStr = htmlStr & "<hr>" & vbNewLine
    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine
    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine
    htmlStr = htmlStr & "DESCRIÇÃO" & vbNewLine
    htmlStr = htmlStr & "</div>" & vbNewLine
    htmlStr = htmlStr & "" & vbNewLine
    
    htmlStr = htmlStr & "<div>" & vbNewLine
    htmlStr = htmlStr & "<hr>" & vbNewLine
    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">Informação de versão</h2>" & vbNewLine
    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine
    htmlStr = htmlStr & "Exibe um relatório com as informações das versões publicadas." & vbNewLine
    htmlStr = htmlStr & "</p>" & vbNewLine
    htmlStr = htmlStr & "</div>" & vbNewLine
    
    htmlStr = htmlStr & "</body>" & vbNewLine
    htmlStr = htmlStr & "</html>" & vbNewLine

    
    frmReport.Show
    With frmReport.WebBrowser
        .Navigate "about:blank": DoEvents
        .Document.Write htmlStr: DoEvents
    End With

End Function
