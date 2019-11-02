VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_fnc_globais"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public Function fncCriarAmbiente(ByRef pCol As Collection)
    
'    pCol.Add vbNewLine
'    pCol.Add vbTab & vbTab & "// EXEMPLO: Como usar 'criarAmbiente'"
'    pCol.Add vbTab & vbTab & "// criarAmbiente(objGlobal.pathProcessados, [""Processados""]);"
'    pCol.Add vbTab & vbTab & "// for( var y = 0 ; y < objGlobal.arrayFolders.length ; y++ ){ criarAmbiente(objGlobal.pathAmbiente , [objGlobal.arrayFolders[y].caminho] ); }"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function criarAmbiente(caminho, arPastas){"
    pCol.add vbTab & vbTab & vbTab & "for( var a = 0; a < arPastas.length; a++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if(!fso.FolderExists(caminho + arPastas[a]))"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if(!fso.FolderExists(caminho + arPastas[a]))"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "fso.CreateFolder(caminho + arPastas[a] + ""\\"");"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncEscreveLog(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function EscreveLog( json, varray, arquivo, titulo ){"
    pCol.add vbTab & vbTab & vbTab & "var cabecalho = """";"
    pCol.add vbTab & vbTab & vbTab & "var lista = """";"
    pCol.add vbTab & vbTab & vbTab & "var conteudo = ReadAllTextFile( arquivo );"
    pCol.add vbTab & vbTab & vbTab & "var Titulo = ( titulo == null ) ? true: titulo;"
    pCol.add vbTab & vbTab & vbTab & "for( var i = 0; i < varray.length; i++){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if( conteudo == """" && Titulo == true )"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "cabecalho += ( cabecalho == """" ) ? varray[i] : "";"" + varray[i];"
    pCol.add vbTab & vbTab & vbTab & vbTab & "lista += ( lista == """" ) ? json[varray[i]] : "";"" + json[varray[i]];"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "if( cabecalho != """" ) writeCSV( arquivo, cabecalho );"
    pCol.add vbTab & vbTab & vbTab & "writeCSV( arquivo, lista, 8 );"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncStatusOperacao(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function statusOperacao( obj ){"
    pCol.add vbTab & vbTab & vbTab & "var newFile = """";"
    pCol.add vbTab & vbTab & vbTab & "var tmp = """";"
    pCol.add vbTab & vbTab & vbTab & "var cabecalho = """";"
    pCol.add vbTab & vbTab & vbTab & "var conteudo = ReadAllTextFile( obj.Caminho );"
    pCol.add vbTab & vbTab & vbTab & "var linhas = conteudo.split( ""\r\n"" );"
    pCol.add vbTab & vbTab & vbTab & "for (var i = 0; i < linhas.length && linhas[i] != """" ;i++) {"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if(obj.Cabecalho){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if( i==0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "for( var y = 0; y < obj.Retorno.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "if ( linhas[0].indexOf( obj.Retorno[y] )  < 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp += "";"" + obj.Retorno[y];"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "cabecalho += linhas[0] + tmp + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp = """";"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}else if ( linhas[i].indexOf( obj.Chave ) >= 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "for( var y = 0; y < obj.Retorno.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp += ( linhas[i] == """" ) ? obj[obj.Retorno[y]] : "";"" + obj[obj.Retorno[y]];"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "newFile += linhas[i] + tmp + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}else newFile += linhas[i] + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "writeCSV( obj.Caminho, cabecalho + newFile );"
    pCol.add vbTab & vbTab & "}"
    

End Function

Public Function fncStatusOperacao_old(ByRef pCol As Collection)
    
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function statusOperacao( obj ){"
    pCol.add vbTab & vbTab & vbTab & "var newFile = """";"
    pCol.add vbTab & vbTab & vbTab & "var tmp = """";"
    pCol.add vbTab & vbTab & vbTab & "var cabecalho = """";"
    pCol.add vbTab & vbTab & vbTab & "var conteudo = ReadAllTextFile( obj.Caminho );"
    pCol.add vbTab & vbTab & vbTab & "var linhas = conteudo.split( ""\r\n"" );"
    pCol.add vbTab & vbTab & vbTab & "for (var i = 0; i < linhas.length && linhas[i] != """" ;i++) {"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if( i==0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if(obj.Cabecalho){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "for( var y = 0; y < obj.Retorno.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "if ( linhas[0].indexOf( obj.Retorno[y] )  < 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp += "";"" + obj.Retorno[y];"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "cabecalho += linhas[0] + tmp + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp = """";"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}else if ( linhas[i].indexOf( obj.Chave ) >= 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "for( var y = 0; y < obj.Retorno.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "tmp += ( linhas[i] == """" ) ? obj[obj.Retorno[y]] : "";"" + obj[obj.Retorno[y]];"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "newFile += linhas[i] + tmp + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}else newFile += linhas[i] + ""\r\n"";"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "writeCSV( obj.Caminho, cabecalho + newFile );"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncMoverDoRepositorioParaFilaDeEspera(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function MoverDoRepositorioParaFilaDeEspera( pathRepositorio, pathFilaEspera, FiltrarArquivo ){"
    pCol.add vbTab & vbTab & vbTab & "var oRepositorio = new Array(); oRepositorio = GetListFilesFolder( pathRepositorio, FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "for( var y=0 ; y < oRepositorio.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "try{ fso.CopyFile( oRepositorio[y].Caminho, pathFilaEspera + oRepositorio[y].Nome );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if ( fso.FileExists( oRepositorio[y].Caminho ) ) fso.DeleteFile( oRepositorio[y].Caminho );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "} catch(e){ throw new Error(666,""Error ao copiar arquivo. "" & oRepositorio[y].Nome ) }"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncMoverDaFilaDeEsperaParaProcessamento(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function MoverDaFilaDeEsperaParaProcessamento( pathFilaEspera, pathProcessamento, FiltrarArquivo ){"
    pCol.add vbTab & vbTab & vbTab & "var oProcessamento = new Array(); oProcessamento = GetListFilesFolder( pathProcessamento, FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "if( !oProcessamento.length ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var oEspera = new Array(); oEspera = GetListFilesFolder( pathFilaEspera, FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if( oEspera.length > 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "try{ fso.CopyFile( oEspera[0].Caminho, pathProcessamento + oEspera[0].Nome );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "if ( fso.FileExists( oEspera[0].Caminho ) ) fso.DeleteFile( oEspera[0].Caminho );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "} catch(e){ throw new Error(666,""Error ao processar arquivo. "" & oEspera[0].Nome ) }"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "oProcessamento = GetListFilesFolder( pathProcessamento, FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "if( !oProcessamento.length ) throw new Error(777,""Nao ha dados a serem processados."" );"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncFilaDeExecucao(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function filaDeExecucao( pathExecucao, arrayPathProcessados, FiltrarArquivo ){"
    pCol.add vbTab & vbTab & vbTab & "var logData = new Date();"
    pCol.add vbTab & vbTab & vbTab & "var oExecucao = new Array(); oExecucao = GetListFilesFolder( pathExecucao, FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "if( oExecucao.length > 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "try{ if( carregarBaseDeExecucao( oExecucao[0].Caminho, 0, "";"" ) <=0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "for( var y = 0 ; y < arrayPathProcessados.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "fso.CopyFile( oExecucao[0].Caminho, arrayPathProcessados[y].caminho + logData.format('yyyymmdd_HHMM')+ ""_"" + oExecucao[0].Nome );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "if ( fso.FileExists( oExecucao[0].Caminho ) ) fso.DeleteFile( oExecucao[0].Caminho );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & "} catch(e){ throw new Error(123,""Falha : Error "" & e.description ) }"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & vbTab & "function carregarBaseDeExecucao( dbBase, InicioDaLinha, SeparadorDeColunas ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if ( !fso.FileExists( dbBase ) ) return false;"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var operacoes = new Array();"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var conteudo = ReadAllTextFile( dbBase );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var linhas, colunas; linhas = conteudo.split(""\r\n"");"
    pCol.add vbTab & vbTab & vbTab & vbTab & "for( var i = InicioDaLinha; i < linhas.length && linhas[i] != """" ;i++ ) {"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "colunas = linhas[i].split(SeparadorDeColunas);"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if ( linhas[i].indexOf("";OK"") <= 0 && linhas[i].indexOf("";NOK"") <= 0)"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "operacoes.push({ ""coluna01"": colunas[0].replace( /\r/g, """" )"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Chave"": colunas[0].trim()"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Retorno"": [""Status"",""DataLog"",""Observacoes""]"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Cabecalho"": false"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & ",""Caminho"": dbBase"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "});"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & vbTab & "return operacoes;"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & "}"
    
End Function

Public Function fncCarregarArquivos(ByRef pCol As Collection)
    
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function CarregarArquivos( obj ){"
    pCol.add vbTab & vbTab & vbTab & "var tm_total = new Timer();"
    pCol.add vbTab & vbTab & vbTab & "var oBaseCliente = new Array();"
    pCol.add vbTab & vbTab & vbTab & "oBaseCliente = GetListFilesFolder( objRobo[0].baseCliente, objRobo[0].roboFiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "for( var y=0 ; y < oBaseCliente.length ; y++ ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "try{"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "fso.CopyFile( oBaseCliente[y].Caminho, objRobo[0].roboCaminhoFilaEspera + oBaseCliente[y].Nome );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "if ( fso.FileExists( oBaseCliente[y].Caminho ) ) fso.DeleteFile( oBaseCliente[y].Caminho );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "} catch(e){ throw new Error(666,""Error ao copiar arquivo. "" & oBaseCliente[y].Nome ) }"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "var oProcessamento  = new Array();"
    pCol.add vbTab & vbTab & vbTab & "oProcessamento = GetListFilesFolder( objRobo[0].roboCaminhoProcessamento, objRobo[0].roboFiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "if( !oProcessamento.length ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var oFilaEspera = new Array();"
    pCol.add vbTab & vbTab & vbTab & vbTab & "oFilaEspera = GetListFilesFolder( objRobo[0].roboCaminhoFilaEspera, objRobo[0].roboFiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "if( oFilaEspera.length > 0 ){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "try{"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "fso.CopyFile( oFilaEspera[0].Caminho, objRobo[0].roboCaminhoProcessamento + oFilaEspera[0].Nome );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "if ( fso.FileExists( oFilaEspera[0].Caminho ) ) fso.DeleteFile( oFilaEspera[0].Caminho );"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "} catch(e){ throw new Error(666,""Error ao processar arquivo. "" & oFilaEspera[0].Nome ) }"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "oProcessamento = GetListFilesFolder( objRobo[0].roboCaminhoProcessamento, objRobo[0].roboFiltrarArquivo, attributs=48 );"
    pCol.add vbTab & vbTab & vbTab & "if( !oProcessamento.length ) throw new Error(777,""Nao ha dados a serem processados."" )"
    pCol.add vbTab & vbTab & vbTab & "return tm_total.elapsed();"
    pCol.add vbTab & vbTab & "}"
    
End Function


Public Function fncCarregarLogs(ByRef pCol As Collection)
    
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "function carregar_logs(path){"
    pCol.add vbTab & vbTab & vbTab & "var obj = new Array();"
    pCol.add vbTab & vbTab & vbTab & "var objArq = new Array();"
    pCol.add vbTab & vbTab & vbTab & "var InicioDaLinha = 1;"
    pCol.add vbTab & vbTab & vbTab & "var arquivo = WshShell.currentDirectory + ""\\"" + logData.format('yyyymmdd_HHMM') + ""_saidaLog.csv"";"
    pCol.add vbTab & vbTab & vbTab & "objArq = GetListFilesFolder( path, "".csv"", 48);"
    pCol.add vbTab & vbTab & vbTab & "for(var i=0; i < objArq.length ; i++){"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var conteudo = ReadAllTextFile(objArq[i].Caminho);"
    pCol.add vbTab & vbTab & vbTab & vbTab & "var linhas = conteudo.split(""\r\n"");"
    pCol.add vbTab & vbTab & vbTab & vbTab & "for(var x = InicioDaLinha ; x < linhas.length && linhas[x] != """" && linhas[x].indexOf(""Ordem;Documento;"") < 0 ; x++){"
    pCol.add vbTab & vbTab & vbTab & vbTab & vbTab & "writeCSV( arquivo, linhas[x] + "";"" + objArq[i].Nome, 8 );"
    pCol.add vbTab & vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & "}"
    
    
End Function

