Private Sub btnTesteSoap_Click()

    Dim strSoapAction As String
    Dim strUrl As String
    Dim strXml As String
    Dim strParam As String
    
    
    strUrl = "http://tempuri.org/MyMethod"
    strSoapAction = ""
    
    strXml = "<?xml version=""1.0"" encoding=""utf-8""?>" & _
             "<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">" & _
             "<soap:Body>" & _
             "<CheckActCode xmlns=""http://tempuri.org/"">" & _
             "</checkactcode>" & _
             "</soap:body>" & _
             "</soap:envelope>"

    ' Call PostWebservice and put result in text box
    PostWebservice strUrl, strSoapAction, strXml

End Sub

Private Function PostWebservice(ByVal AsmxUrl As String, ByVal SoapActionUrl As String, ByVal XmlBody As String) As String
    Dim objDom As Object
    Dim objXmlHttp As Object
    Dim strRet As String
    Dim intPos1 As Integer
    Dim intPos2 As Integer
    
    On Error GoTo Err_PW
    
    ' Create objects to DOMDocument and XMLHTTP
    Set objDom = CreateObject("MSXML2.DOMDocument")
    Set objXmlHttp = CreateObject("MSXML2.XMLHTTP")
    
    ' Load XML
    objDom.async = False
    objDom.loadXML XmlBody

    ' Open the webservice
    objXmlHttp.Open "POST", AsmxUrl, False
    
    ' Create headings
    objXmlHttp.setRequestHeader "Content-Type", "text/xml; charset=utf-8"
    objXmlHttp.setRequestHeader "SOAPAction", SoapActionUrl
    
    ' Send XML command
    objXmlHttp.Send objDom.xml

    ' Get all response text from webservice
    strRet = objXmlHttp.responseText
    
    ' Close object
    Set objXmlHttp = Nothing
    
    ' Extract result
    intPos1 = InStr(strRet, "Result>") + 7
    intPos2 = InStr(strRet, "<!--")
    If intPos1 > 7 And intPos2 > 0 Then
        strRet = Mid(strRet, intPos1, intPos2 - intPos1)
    End If
    
    ' Return result
    PostWebservice = strRet
    
Exit Function
Err_PW:
    PostWebservice = "Error: " & Err.Number & " - " & Err.Description

End Function


Private Sub btnClose_Click()
    Unload Me
End Sub

