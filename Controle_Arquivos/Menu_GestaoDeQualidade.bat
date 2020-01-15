@ECHO OFF
taskkill /F /IM mdm.exe 

cd C:\SiteSeeing\ssAgent\storage\files\
set QtdeMassa=100

CLS

:MENU
CLS

ECHO ============= MENU NAME =============
ECHO -------------------------------------
ECHO 1.  Pagamento Parcela Vencida
ECHO 2.  Liquidacao Antecipada
ECHO 3.  Baixa De Ordem De Pagamento
ECHO 4.  Estorno De Contrato
ECHO -------------------------------------
ECHO ==========PRESS 'Q' TO QUIT==========
ECHO.

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='Q' GOTO Quit

CLS

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-9] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

:Selection1

set Step=GestaoDeQualidade\Revitalizacao\Step_PagamentoParcelaVencida.ini
C:\Windows\sysWOW64\cscript.exe GestaoDeQualidade\Revitalizacao\Revitalizacao.wsf

pause

:Selection2

set Step=GestaoDeQualidade\Revitalizacao\Step_LiquidacaoAntecipada.ini
C:\Windows\sysWOW64\cscript.exe GestaoDeQualidade\Revitalizacao\Revitalizacao.wsf

pause 

:Selection3

set Step=GestaoDeQualidade\Revitalizacao\Step_BaixaDeOrdemDePagamento.ini
C:\Windows\sysWOW64\cscript.exe GestaoDeQualidade\Revitalizacao\Revitalizacao.wsf

pause 

:Selection4

set Step=GestaoDeQualidade\Revitalizacao\Step_EstornoDeContrato.ini
C:\Windows\sysWOW64\cscript.exe GestaoDeQualidade\Revitalizacao\Revitalizacao.wsf

pause 


:Quit
CLS

ECHO ==============THANKYOU===============
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE>NUL
EXIT