VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsNotas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private pCol As New Collection

Private sName As String
Private sNotes As String
Private sPath As String

Property Get strName() As String:           strName = sName:          End Property
Property Let strName(pValue As String):     sName = pValue:               End Property

Property Get strNotes() As String:           strNotes = sNotes:          End Property
Property Let strNotes(pValue As String):     sNotes = pValue:               End Property

Property Get strPath() As String:           strPath = sPath:          End Property
Property Let strPath(pValue As String):     sPath = pValue:               End Property



Private Sub Class_Initialize()
    Set pCol = New Collection
End Sub

Private Sub Class_Terminate()
    Set pCol = Nothing
End Sub

Public Sub add(ByVal rec As clsNotas, Optional ByVal key As Variant, Optional before As Variant, Optional ByVal after As Variant)
    pCol.add rec, key, before, after
End Sub

Public Sub all(ByVal rec As clsNotas)
    pCol.add rec, rec.strName
End Sub

Public Property Get Itens() As Collection
    Set Itens = pCol
End Property


