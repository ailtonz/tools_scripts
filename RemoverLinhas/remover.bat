set directory=%1
set file=%2
set lines=%3


@echo off
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo DATA INICIO %ldt% 

echo excluindo arquivo temporario antigo
del %directory%\%file%.tmp.txt

echo criando novo arquivo temporario
copy %directory%\%file%  %directory%\%file%.tmp

echo removendo linhas
h:\VIP\REMOVERLINHAS\GnuWin32\bin\sed.exe -n -e :a -e "1,%lines%!{P;N;D;};N;ba" %directory%\%file%.tmp > %directory%\%file%

echo excluindo arquivo temporario
del %directory%\%file%.tmp

@echo off
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo DATA FIM %ldt%
