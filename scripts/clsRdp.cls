VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsRdp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
''--[Create, list or delete stored user names, passwords or credentials.]
'' https://ss64.com/nt/cmdkey.html
'' https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/mstsc
'' https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/remote-desktop-services-terminal-services-command-reference


Private sAddress As String
Private sUsername As String
Private sUserpass As String
Private sPath As String
Private sRun As String

Property Get strAddress() As String:                        strAddress = sAddress:          End Property
Property Let strAddress(pValue As String):                  sAddress = pValue:              End Property

Property Get strUserName() As String:                       strUserName = sUsername:        End Property
Property Let strUserName(pValue As String):                 sUsername = pValue:             End Property

Property Get strUserPass() As String:                       strUserPass = sUserpass:        End Property
Property Let strUserPass(pValue As String):                 sUserpass = pValue:             End Property

Property Get strPath() As String:                           strPath = sPath:                End Property
Property Let strPath(pValue As String):                     sPath = pValue:                 End Property

Property Get strRun() As String:                           strRun = sRun:                   End Property
Property Let strRun(pValue As String):                     sRun = pValue:                   End Property

Function gerarCredencial()
Dim Col As New Collection

    Col.add "cmdkey /delete TERMSRV/" & strAddress
    Col.add "cmdkey /generic:TERMSRV/" & strAddress & " /user:" & strUserName & " /pass:""" & strUserPass & """"
    
    '' Exclusão
    If ((strPath) = "") Then strPath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strPath & "\" & strAddress & ".bat") <> "") Then Kill strPath & "\" & strAddress & ".bat"
    
    For Each c In Col
        saida strPath, strAddress & ".bat", CStr(c)
    Next c
    
    '' Adicionais
    saida strPath, strAddress & ".bat", "TIMEOUT 3"
    saida strPath, strAddress & ".bat", "DEL /Q /F " & strPath & "\" & strAddress & ".bat"
    
    '' Pause
    'Sleep 500
    
    '' Auto run
    Shell strPath & "\" & strAddress & ".bat"
    
    '' Pause
    Sleep 500
    
    '' Execução
    '' If (strRun <> "") Then Shell "mstsc " & strPath & "\" & strAddress & ".rdp"
    Shell "mstsc " & strPath & "\" & strAddress & ".rdp"
    
Set Col = Nothing
End Function

Function gerarRdp()
Dim colNews As New Collection
Dim c As Variant
    
    colNews.add "screen mode id:i:1"
    colNews.add "use multimon:i:0"
    colNews.add "desktopwidth:i:1366"
    colNews.add "desktopheight:i:768"
    colNews.add "session bpp:i:32"
    colNews.add "winposstr:s:0,1,1920,0,3286,728"
    colNews.add "compression:i:1"
    colNews.add "keyboardhook:i:2"
    colNews.add "audiocapturemode:i:0"
    colNews.add "videoplaybackmode:i:1"
    colNews.add "connection type:i:7"
    colNews.add "networkautodetect:i:1"
    colNews.add "bandwidthautodetect:i:1"
    colNews.add "displayconnectionbar:i:1"
    colNews.add "enableworkspacereconnect:i:0"
    colNews.add "disable wallpaper:i:0"
    colNews.add "allow font smoothing:i:0"
    colNews.add "allow desktop composition:i:0"
    colNews.add "disable full window drag:i:1"
    colNews.add "disable menu anims:i:1"
    colNews.add "disable themes:i:0"
    colNews.add "disable cursor setting:i:0"
    colNews.add "bitmapcachepersistenable:i:1"
    colNews.add "full address:s:" & strAddress
    colNews.add "audiomode:i:2"
    colNews.add "redirectprinters:i:0"
    colNews.add "redirectcomports:i:0"
    colNews.add "redirectsmartcards:i:1"
    colNews.add "redirectclipboard:i:0"
    colNews.add "redirectposdevices:i:0"
    colNews.add "autoreconnection enabled:i:1"
    colNews.add "authentication level:i:2"
    colNews.add "prompt for credentials:i:0"
    colNews.add "negotiate security layer:i:1"
    colNews.add "remoteapplicationmode:i:0"
    colNews.add "alternate shell:s:"
    colNews.add "shell working directory:s:"
    colNews.add "gatewayhostname:s:"
    colNews.add "gatewayusagemethod:i:4"
    colNews.add "gatewaycredentialssource:i:4"
    colNews.add "gatewayprofileusagemethod:i:0"
    colNews.add "promptcredentialonce:i:0"
    colNews.add "gatewaybrokeringtype:i:0"
    colNews.add "use redirection server name:i:0"
    colNews.add "rdgiskdcproxy:i:0"
    colNews.add "kdcproxyname:s:"
    colNews.add "drivestoredirect:s:"
    colNews.add "smart sizing:i:1"
    colNews.add "username:s:" & strUserName
    
    '' Exclusão
    If ((strPath) = "") Then strPath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    If (Dir(strPath & "\" & strAddress & ".rdp") <> "") Then Kill strPath & "\" & strAddress & ".rdp"
    
    For Each c In colNews
        saida strPath, strAddress & ".rdp", CStr(c)
    Next c
    
Set colNews = Nothing
End Function

Private Function saida(strCaminho As String, strArquivo As String, strConteudo As String)
    Open strCaminho & "\" & strArquivo For Append As #1
    Print #1, strConteudo
    Close #1
End Function
