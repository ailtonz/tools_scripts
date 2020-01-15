Sub openXML()
    ActiveWorkbook.XmlImport URL:="C:\tmp\relatorioMIS.xml", ImportMap:=Nothing _
        , Overwrite:=True, Destination:=Range("$A$1")
End Sub
