VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cls_fnc_Process"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Function Cabecalho(ByRef pCol As Collection)

    pCol.add "/*====================================================================================================================="
    pCol.add "' Descricao    : Nome_Robo"
    pCol.add "' Author       : Nome_Desenvolvedor(es)"
    pCol.add "' Regra de negocio      : Descricao objetiva da regra de negocio"
    pCol.add "' Pontos de atencao     : Validar sempre a segunda tela em tempo de execucao"
    pCol.add "' Checklist:"
    pCol.add "'   - Check01 [ok/nok]"
    pCol.add "'   - Check02 [ok/nok]"
    pCol.add "'   - Check03 [ok/nok]"
    pCol.add "'"
    pCol.add "'"
    pCol.add "' ###DICAS Gerais"
    pCol.add "' WScript.Echo() | print in command"
    pCol.add "' sc.getRunningStep().stepsTimer = null | Zera o Cronometro"
    pCol.add "' Interact(WinTitle , null ,"",120,193) | Acionamento de janela"
    pCol.add "'"
    pCol.add "'"
    pCol.add "'"
    pCol.add "' ### Códigos de falhas para retorno na console"
    pCol.add "' 123 - Fail  |   Falha no sistema"
    pCol.add "' 666 - NOK   |   Pendencia do cliente"
    pCol.add "' 777 - OK    |   Nao ha dados para processamento"
    pCol.add "'=====================================================================================================================*/"
    pCol.add vbNewLine

End Function

Public Function fncProcessamento(ByRef pCol As Collection)
    
    pCol.add vbNewLine
    pCol.add "function Processamento(){"
    pCol.add "debugger;"
    pCol.add vbTab & "var tm_total = new Timer();"
    pCol.add vbTab & "for (var i = 0; i < obJSON.length; i++){"
    pCol.add vbTab & vbTab & "//REALIZA O ACOMPANHAMENTO NA JANELA"
    pCol.add vbTab & vbTab & "// gerarLogRastreamento(sigla, descricao, modoEscrita, posX, posY);"
    pCol.add vbTab & vbTab & "try{"
    pCol.add vbTab & vbTab & vbTab & "/*** Processamento do ITEM ***/"
    pCol.add vbTab & vbTab & vbTab & "obJSON[i].Observacao = """";"
    pCol.add vbTab & vbTab & vbTab & "obJSON[i].Status = ""OK"";"
    pCol.add vbTab & vbTab & "}catch (e){"
    pCol.add vbTab & vbTab & vbTab & "/*** tratar erros ***/"
    pCol.add vbTab & vbTab & vbTab & "/*** tratar erros ***/"
    pCol.add vbTab & vbTab & vbTab & "/*** tratar erros ***/"
    pCol.add vbTab & vbTab & vbTab & "obJSON[i].Observacao = e.message;"
    pCol.add vbTab & vbTab & vbTab & "obJSON[i].Status = ""NOK"";"
    pCol.add vbTab & vbTab & "}"
    pCol.add vbTab & "EscreveLog( json, varray, arquivo );"
    pCol.add vbTab & "}"
    pCol.add vbTab & "return tm_total.elapsed();"
    pCol.add "}"
    
End Function

Public Function fncCarregarBase(ByRef pCol As Collection)
    
    pCol.add "function carregarBase(){"
    pCol.add "debugger;"
    pCol.add vbTab & "var tm_total = new Timer();"
    pCol.add vbNewLine
    pCol.add vbTab & "// gerarLogRastreamento(sigla, descricao, modoEscrita, posX, posY);"
    pCol.add vbNewLine
    pCol.add vbTab & "// ---[ CARREGAR PERFIL ]"
    pCol.add vbTab & "var oPerfil ; oPerfil = objOperacao;"
    pCol.add vbTab & ""
    pCol.add vbTab & "// ---[ CARREGAR FILA DE ESPERA ]"
    pCol.add vbTab & "MoverDoRepositorioParaFilaDeEspera( oPerfil.pathRepositorio, objGlobal.pathFilaEspera, oPerfil.FiltrarArquivo );"
    pCol.add vbTab & ""
    pCol.add vbTab & "// ---[ ADMINISTRAR ARQUIVOS PARA PROCESSAMENTO ]"
    pCol.add vbTab & "MoverDaFilaDeEsperaParaProcessamento( objGlobal.pathFilaEspera, objGlobal.pathExecucao, oPerfil.FiltrarArquivo );"
    pCol.add vbTab & ""
    pCol.add vbTab & "// ---[ CONTROLAR ARQUIVO PARA EXECUCAO ]"
    pCol.add vbTab & "filaDeExecucao( objGlobal.pathExecucao, objGlobal.arrayPathProcessados , oPerfil.FiltrarArquivo );"
    pCol.add vbTab & ""
    pCol.add vbTab & "return tm_total.elapsed();"
    pCol.add "}"
    
End Function

Public Function fncIniciarProcesso(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function iniciarProcesso(){"
    pCol.add "debugger;"
    pCol.add vbTab & "var tm_total = new Timer(); var oFile = Array();"
    pCol.add vbNewLine
    pCol.add vbTab & "// gerarLogRastreamento(sigla, descricao, modoEscrita, posX, posY);"
    pCol.add vbNewLine
    pCol.add vbTab & "// ---[ CARREGAR PERFIL ]"
    pCol.add vbTab & "var oPerfil ; oPerfil = objOperacao;"
    pCol.add vbTab & "oFile = GetListFilesFolder( objGlobal.pathExecucao, oPerfil.FiltrarArquivo, attributs=48 );"
    pCol.add vbTab & "if( oFile.length > 0 ){"
    pCol.add vbTab & vbTab & "try{"
    pCol.add vbTab & vbTab & vbTab & "processo_Robo( baseJson( oFile[0].Caminho ), oPerfil );"
    pCol.add vbTab & vbTab & "} catch(e){ throw new Error(123,""Falha : Error "" & e.description ) }"
    pCol.add vbTab & "} return tm_total.elapsed();"
    pCol.add "}"


End Function

Public Function fncProcesso(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function processo_Robo( operacoes, oPerfil ){"
    pCol.add "debugger;"
    pCol.add vbTab & "var msg = """";"
    pCol.add vbNewLine
    pCol.add vbTab & "// gerarLogRastreamento(sigla, descricao, modoEscrita, posX, posY);"
    pCol.add vbNewLine
    pCol.add vbTab & "for( var i = 0; i <= operacoes.length && i < QtdMassa ;i++ ){"
    pCol.add vbTab & vbTab & "try{"
    pCol.add vbTab & vbTab & vbTab & "msg = ( i + 1 ) + "" de "" + operacoes.length;"
    pCol.add vbTab & vbTab & vbTab & "AutoIt.ToolTip(operacoes[i].contrato + "" - "" + msg ,92, 594);"
    pCol.add vbNewLine
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & vbTab & "/*** RESERVADO PARA MAPEAMENTO DE PROCESSO ***/"
    pCol.add vbTab & vbTab & vbTab & "/*** RESERVADO PARA MAPEAMENTO DE PROCESSO ***/"
    pCol.add vbTab & vbTab & vbTab & "/*** RESERVADO PARA MAPEAMENTO DE PROCESSO ***/"
    pCol.add vbTab & vbTab & vbTab & "/*** RESERVADO PARA MAPEAMENTO DE PROCESSO ***/"
    pCol.add vbNewLine
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "}catch(e){"
    pCol.add vbTab & vbTab & vbTab & "operacoes[i].Status = ""NOK"";"
    pCol.add vbTab & vbTab & vbTab & "operacoes[i].Observacoes = ""[TFC] "" + e.message;"
    pCol.add vbTab & vbTab & "}"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "var dataLog = new Date();"
    pCol.add vbTab & vbTab & "operacoes[i].DataLog = dataLog.format(""ddmmyyyy HH:MM:ss"");"
    pCol.add vbTab & vbTab & "AutoIt.ToolTip(operacoes[i].contrato + "" - "" + msg + "" - ["" + operacoes[i].Status + ""]"" + "" - ["" + operacoes[i].DataLog + ""]"" + "" - "" + operacoes[i].Observacoes ,92, 594);"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "for( var y = 0; y < oPerfil.arrayPathLog.length -1 ; y++ )"
    pCol.add vbTab & vbTab & vbTab & "EscreveLog( operacoes[i], oPerfil.arrayPathLog[y].Campos, oPerfil.arrayPathLog[y].Arquivo, oPerfil.arrayPathLog[y].Cabecalho );"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "statusOperacao( operacoes[i] );"
    pCol.add vbNewLine
    pCol.add vbTab & vbTab & "/*** FECHAR TELA DO PROCESSO ***/"
    pCol.add vbTab & vbTab & "/*** FECHAR TELA DO PROCESSO ***/"
    pCol.add vbTab & vbTab & "//--[ FECHAR TELA ]"
    pCol.add vbTab & vbTab & "if( calc_chksum( 220, 140,60,3 ) == 3440591233 ){"
    pCol.add vbTab & vbTab & vbTab & "Interact(WinTitle, null, ""left"", 500, 516);"
    pCol.add vbTab & vbTab & vbTab & "WScript.Sleep(2000);"
    pCol.add vbTab & vbTab & "}"
    pCol.add vbTab & vbTab & "/*** FECHAR TELA DO PROCESSO ***/"
    pCol.add vbTab & vbTab & "/*** FECHAR TELA DO PROCESSO ***/"
    pCol.add vbTab & "}"
    pCol.add vbTab & "if( operacoes.length < QtdMassa ) return true;"
    pCol.add vbTab & "else return false;"
    pCol.add "}"

End Function

Public Function fncBaseJson(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function baseJson( dbBase ){"
    pCol.add "debugger;"
    pCol.add vbTab & "if ( !fso.FileExists( dbBase ) ) return false;"
    pCol.add vbTab & "var operacoes = new Array(); var conteudo = ReadAllTextFile( dbBase ); var InicioDaLinha = 0; var linhas, colunas;"
    pCol.add vbNewLine
    pCol.add vbTab & "// gerarLogRastreamento(sigla, descricao, modoEscrita, posX, posY);"
    pCol.add vbNewLine
    pCol.add vbTab & "linhas = conteudo.split(""\r\n"");"
    pCol.add vbTab & "for( var i = InicioDaLinha; i < linhas.length && linhas[i] != """"  ;i++ ) {"
    pCol.add vbTab & vbTab & "colunas = linhas[i].split("";"");"
    pCol.add vbTab & vbTab & "if ( linhas[i].indexOf("";OK"") <= 0 && linhas[i].indexOf("";NOK"") <= 0 )"
    pCol.add vbTab & vbTab & vbTab & "operacoes.push({""agencia"": colunas[0].replace( /\r/g, """" )"
    pCol.add vbTab & vbTab & vbTab & ",""contrato"": colunas[1].trim()"
    pCol.add vbTab & vbTab & vbTab & ",""dataInicioContrato"": colunas[2].trim()"
    pCol.add vbTab & vbTab & vbTab & ",""Chave"": colunas[1].trim()"
    pCol.add vbTab & vbTab & vbTab & ",""Retorno"": [""Status"",""DataLog"",""Observacoes""]"
    pCol.add vbTab & vbTab & vbTab & ",""Cabecalho"": false"
    pCol.add vbTab & vbTab & vbTab & ",""Caminho"" : dbBase" & "});"
    pCol.add vbTab & "} return operacoes;"
    pCol.add "}"

End Function

Public Function fncFecharTelasV01(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function fecharTelasV01( obj ){"
    pCol.add "debugger;"
    pCol.add vbTab & "var telaAreaDeTrabalho = 3200626452;"
    pCol.add vbTab & "var logoBanco = 3263488833;"
    pCol.add vbTab & "do{"
    pCol.add vbTab & vbTab & "//--[ BOTÃO: Cancelar ]"
    pCol.add vbTab & vbTab & "Interact(WinTitle, null, ""left"", 678, 518);"
    pCol.add vbTab & vbTab & "//--[ BOTÃO: Cancelar ]"
    pCol.add vbTab & vbTab & "Interact(WinTitle, null, ""left"", 507, 501);"
    pCol.add vbTab & vbTab & "// Quando estiver na area de trabalho termina o ciclo."
    pCol.add vbTab & vbTab & "if( calc_chksum( 28, 198,40,3 ) == telaAreaDeTrabalho ) break;"
    pCol.add vbTab & "}while ( !logoBanco == true )"
    pCol.add "}"

End Function


Public Function fncFecharTelasV02(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function fecharTelasV02(){"
    pCol.add "debugger;"
    pCol.add vbTab & "var logoBanco = 537512325;"
    pCol.add vbTab & "do{"
    pCol.add vbTab & vbTab & "Interact(WinTitle, null, ""left"", 680,549);"
    pCol.add vbTab & "}while( calc_chksum( 595, 529, 60, 3 ) != logoBanco )"
    pCol.add "}"
    
End Function

Public Function fncEsperarPesquisa(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function esperarPesquisa(){"
    pCol.add "debugger;"
    pCol.add vbTab & "var engrenagemTFC = 259165486;"
    pCol.add vbTab & "do{"
    pCol.add vbTab & vbTab & "Wait_Nav(""waitLoad()"");"
    pCol.add vbTab & vbTab & "WScript.Sleep(1000);"
    pCol.add vbTab & "}while(WaitChkSum2(341, 287, 100, 3, engrenagemTFC) );"
    pCol.add "}"
    
End Function

Public Function fncMenu_Processo(ByRef pCol As Collection)

    pCol.add vbNewLine
    pCol.add "function menu_Processo(){"
    pCol.add "debugger;"
    pCol.add vbTab & "WinTitle = ""Terminal Financeiro Corporativo"";"
    pCol.add vbTab & "fecharTelasV02();"
             
    pCol.add vbTab & "//Emprestimos/Financiamentos"
    pCol.add vbTab & "Interact(WinTitle, null, ""left"", 98, 11);"
    pCol.add vbTab & "WScript.Sleep(500);"
             
    pCol.add vbTab & "//Emprestimos"
    pCol.add vbTab & "Interact(WinTitle, null, ""left"", 111, 78);"
    pCol.add vbTab & "WScript.Sleep(500);"
             
    pCol.add vbTab & "//Manutenção"
    pCol.add vbTab & "Interact(WinTitle, null, ""left"", 358, 31);"
    pCol.add vbTab & "WScript.Sleep(500);"
             
    pCol.add vbTab & "//Pagamento de parcelas"
    pCol.add vbTab & "Interact(WinTitle, null, ""left"", 373, 284);"
    pCol.add vbTab & "WScript.Sleep(500);"
             
    pCol.add vbTab & "//Pagamento por parcela"
    pCol.add vbTab & "Interact(WinTitle, null, ""left"", 620, 285);"
    pCol.add vbTab & "WScript.Sleep(500);"
             
    pCol.add "}"
    
End Function

'Private Function addMap(ByRef pCol As Collection, pItens As Collection)
'Dim item As Variant
'
'    For Each item In pItens
'        pCol.Add vbTab & vbTab & "//"
'        pCol.Add vbTab & vbTab & "Interact(WinTitle, null, ""left""," & item & """);"
'        pCol.Add vbTab & vbTab & "WScript.Sleep(500);"
'    Next item
'
'End Function

