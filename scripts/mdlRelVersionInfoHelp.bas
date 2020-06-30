Attribute VB_Name = "mdlRelVersionInfoHelp"
Private htmlStr As String

Public Function ShowVersion()

    Dim strVerNumber As String

    Dim strVerData As String

    Dim colNews As Collection, colBugs As Collection

    Dim bolNew As Boolean

    bolNew = True

    htmlStr = ""

    htmlStr = htmlStr & "<!DOCTYPE html><html><body>"

    htmlStr = htmlStr & "<br><h1><center>VERSÃO ATUAL</center></h1>"

    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    strVerData = "21/08/2019": strVerNumber = "2.0.1": Set colNews = New Collection: Set colBugs = New Collection

    colNews.add "<b> criarEpf() </b> - Gerar arquivos criptografados em epf"

'    colBugs.Add "Ononononononononononononononon"
'
'    colBugs.Add "Ononononononononononononononon"
'
'    colBugs.Add "Ononononononononononononononon"

    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)


    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    If ThisWorkbook.BuiltinDocumentProperties("Title") <> "V" & strVerNumber Then

        ThisWorkbook.BuiltinDocumentProperties("Title") = "V" & strVerNumber
    
        ThisWorkbook.Save

    End If

    htmlStr = htmlStr & "<br><h1><center>VERSÕES ANTERIORES</center></h1>"

    bolNew = False

    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    strVerData = "30/07/2019": strVerNumber = "2.0.0": Set colNews = New Collection: Set colBugs = New Collection

    colNews.add "<b>criarTarefa</b>(ByVal control As IRibbonControl)"

    colNews.add "<b>EnviarPosicaoAtual</b>(ByVal control As IRibbonControl)"

    colNews.add "<b>EnviarPosicaoTodas</b>(ByVal control As IRibbonControl)"

    colNews.add "<b>abrirRdp</b>(ByVal control As IRibbonControl)"

    colNews.add "<b>abrirConsole</b>(ByVal control As IRibbonControl)"
    
    colNews.add "<b>CaminhoDocumentacao</b>(ByVal control As IRibbonControl)"
    
    colNews.add "<b>listarPosicaoDeProjetos</b>(ByVal control As IRibbonControl)"
    
    colNews.add "<b>criarRepositorio</b>(ByVal control As IRibbonControl)"
    
    colNews.add "<b>listarTarefas</b>(ByVal control As IRibbonControl)"
    
    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)
    
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    strVerData = "05/04/2019": strVerNumber = "1.1.0": Set colNews = New Collection: Set colBugs = New Collection

    colNews.add "importarBaseDeDados(ByVal control As IRibbonControl)"

    colNews.add "novoCaminhoPadrao(ByVal control As IRibbonControl)"

    colNews.add "criarRdpPorSelecao(ByVal control As IRibbonControl)"

    
    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)
        
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    strVerData = "01/03/2019": strVerNumber = "1.0.0": Set colNews = New Collection: Set colBugs = New Collection

    colNews.add "Layout de planilha modelo - 00000_APP_NomeRobo"
    
    htmlStr = htmlStr & FormatVersion(strVerNumber, strVerData, colNews, colBugs, bolNew)
    
    '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    htmlStr = htmlStr & "</body></html>"

    With frmReport.WebBrowser

        .Navigate "about:blank": DoEvents
    
        .Document.Write htmlStr: DoEvents

    End With

    Sleep 1000

    frmReport.Show


End Function

Private Function FormatVersion(pVersion As String, pDate As String, pNews As Collection, pBugs As Collection, pNew As Boolean) As String

    Dim iHtml As String

    iHtml = iHtml & "<hr>"

    iHtml = iHtml & "<h2><b><u>Versão " & pVersion & ":</u></b></h2>"

    iHtml = iHtml & "<b>Data:</b> " & pDate

    If pNew Then iHtml = iHtml & "<br><br><b>O que há de novo:</b>"

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

    htmlStr = htmlStr & "<h1 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">PROJETO ? Manual do Usu?rio</h1>" & vbNewLine

    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">Vers?o - " & ThisWorkbook.BuiltinDocumentProperties("Title") & "</h2>" & vbNewLine

    htmlStr = htmlStr & "" & vbNewLine

    htmlStr = htmlStr & "<div>" & vbNewLine

    htmlStr = htmlStr & "<a name=" & Chr(34) & "topo" & Chr(34) & "><h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">?ndice</h2>" & vbNewLine

    htmlStr = htmlStr & "<ul>" & vbNewLine

    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine

    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine

    htmlStr = htmlStr & "<li>ITEM;</li>" & vbNewLine

    htmlStr = htmlStr & "<li>Informa??o de vers?o;</li>" & vbNewLine

    htmlStr = htmlStr & "</ul>" & vbNewLine

    htmlStr = htmlStr & "</div>" & vbNewLine

    htmlStr = htmlStr & "" & vbNewLine

    htmlStr = htmlStr & "<div>" & vbNewLine

    htmlStr = htmlStr & "<hr>" & vbNewLine

    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine

    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine

    htmlStr = htmlStr & "DESCRI??O" & vbNewLine

    htmlStr = htmlStr & "</div>" & vbNewLine

    htmlStr = htmlStr & "" & vbNewLine

    htmlStr = htmlStr & "<div>" & vbNewLine

    htmlStr = htmlStr & "<hr>" & vbNewLine

    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine

    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine

    htmlStr = htmlStr & "DESCRI??O" & vbNewLine

    htmlStr = htmlStr & "</div>" & vbNewLine

    htmlStr = htmlStr & "" & vbNewLine

    htmlStr = htmlStr & "<div>" & vbNewLine

    htmlStr = htmlStr & "<hr>" & vbNewLine

    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">ITEM</h2>" & vbNewLine

    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine

    htmlStr = htmlStr & "DESCRI??O" & vbNewLine

    htmlStr = htmlStr & "</div>" & vbNewLine

    htmlStr = htmlStr & "" & vbNewLine

    htmlStr = htmlStr & "<div>" & vbNewLine

    htmlStr = htmlStr & "<hr>" & vbNewLine

    htmlStr = htmlStr & "<h2 style=" & Chr(34) & "color:#0000FF" & Chr(34) & ">Informa??o de vers?o</h2>" & vbNewLine

    htmlStr = htmlStr & "<p style =" & Chr(34) & "margin-left:40px" & Chr(34) & ">" & vbNewLine

    htmlStr = htmlStr & "Exibe um relat?rio com as informa??es das vers?es publicadas." & vbNewLine

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
