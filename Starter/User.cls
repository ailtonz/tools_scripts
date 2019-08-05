VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "User"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Classe para gerenciamento de login
Option Explicit
Private idblID As Double
Private istrNome As String
Private istrLogin As String
Private istrLastAccess As String
Private iobjBanco As Banco
Private istrSecretQuestion As String
Private istrSecretAnswer As String
Private ibolLoggedIn As Boolean
Private istrPerfil As String

Private Sub Class_Terminate()
    Set iobjBanco = Nothing
End Sub

Public Property Get Nome() As String
    Nome = istrNome
End Property
Public Property Let Nome(ByVal strNome As String)
    istrNome = strNome
End Property

Public Property Get Login() As String
    Login = istrLogin
End Property
Public Property Let Login(ByVal strLOGIN As String)
    istrLogin = strLOGIN
End Property

Public Property Get LastAccess() As String
    LastAccess = istrLastAccess
End Property
Public Property Let LastAccess(ByVal strLastAccess As String)
    istrLastAccess = strLastAccess
End Property

Public Property Get SecretQuestion() As String
    SecretQuestion = istrSecretQuestion
End Property
Public Property Let SecretQuestion(ByVal strSecretQuestion As String)
    istrSecretQuestion = strSecretQuestion
End Property

Public Property Get SecretAnswer() As String
    SecretAnswer = istrSecretAnswer
End Property
Public Property Let SecretAnswer(ByVal strSecretAnswer As String)
    istrSecretAnswer = strSecretAnswer
End Property

Public Property Get LoggedIn() As Boolean
    LoggedIn = ibolLoggedIn
End Property
Public Property Let LoggedIn(ByVal bolLoggedIn As Boolean)
    ibolLoggedIn = bolLoggedIn
End Property

Public Property Get Perfil() As String
    Perfil = istrPerfil
End Property
Public Property Let Perfil(ByVal strPerfil As String)
    istrPerfil = strPerfil
End Property

Public Property Get ID() As Double
    ID = idblID
End Property
Public Property Let ID(ByVal strID As Double)
    idblID = strID
End Property

Public Function GetUser(pLogin As String)
    Set iobjBanco = GetBanco
    
    Login = pLogin
    
    With iobjBanco
        .SqlSelect "SELECT U.[ID_USER], U.[NOME], U.[SECRET_QUESTION], U.[SECRET_ANSWER], U.[ULTIMO_ACESSO], P.[PERFIL] FROM [dbo].[TB_USER] AS U INNER JOIN [dbo].[TB_PERFIL] AS P ON P.[ID_PERFIL] = U.[ID_PERFIL] WHERE [U.LOGIN] = " & StringToSql(pLogin)
        Do Until .rs.EOF
            ID = .rs("ID")
            Nome = .rs("NOME")
            LastAccess = PreventNullString(.rs("ULTIMO_ACESSO"))
            SecretQuestion = PreventNullString(.rs("SECRET_QUESTION"))
            SecretAnswer = PreventNullString(.rs("SECRET_ANSWER"))
            Perfil = PreventNullString(.rs("PERFIL"))
            .rs.MoveNext
        Loop
    End With
    
    Set iobjBanco = Nothing
End Function

Public Function Logon(pPassword As String)
    Dim tmpPass As String
    Set iobjBanco = GetBanco
    
    With iobjBanco
        .SqlSelect "SELECT U.[PASSWORD] FROM [dbo].[TB_USER] AS U WHERE U.[LOGIN] = " & StringToSql(Login)
        Do Until .rs.EOF
            tmpPass = PreventNullString(.rs("PASSWORD"))
            .rs.MoveNext
        Loop
    End With
    
    LoggedIn = (pPassword = tmpPass)
    
    If LoggedIn Then
        With iobjBanco
            .SqlExecute "UPDATE [dbo].[TB_USER] SET [ULTIMO_ACESSO] = " & DateToSql(Now) & " WHERE [LOGIN] = " & StringToSql(Login)
        End With
    End If
    
    Set iobjBanco = Nothing
End Function

Public Function FirstAccess(pPassword As String)
    Set iobjBanco = GetBanco
    
    With iobjBanco
        .SqlExecute "UPDATE [dbo].[TB_USER] SET " & _
                "[PASSWORD] = " & StringToSql(pPassword) & _
                ", [SECRET_QUESTION] = " & StringToSql(SecretQuestion) & _
                ", [SECRET_ANSWER] = " & StringToSql(SecretAnswer) & _
                ", WHERE [LOGIN] = " & StringToSql(Login)
    End With
    
    Logon pPassword
    
    Set iobjBanco = Nothing
End Function

Public Function ResetUser()
    Set iobjBanco = GetBanco
    
    With iobjBanco
        .SqlExecute "UPDATE [dbo].[TB_USER] SET " & _
                "[ULTIMO_ACESSO] = NULL WHERE [LOGIN] = " & StringToSql(Login)
    End With
    
    Set iobjBanco = Nothing
End Function

