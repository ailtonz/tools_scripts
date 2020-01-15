@echo off

SET Today=%Date: =0%
SET Year=%Today:~-4%
SET Month=%Today:~-7,2%
SET Day=%Today:~-10,2%

set hr=%TIME: =0%
set hr=%hr:~0,2%
set min=%TIME:~3,2%

rem
rem Compactar arquivos em pasta selecionada
rem

for /d %%X in (Controle) do 7za.exe a %Year%%Month%%Day%-%hr%%min%_"%%X.7z" "%%X\"
rem PAUSE

rem
rem Gerar arquivo lista para copia
rem

del print.txt
dir *.7z /b > print.txt
rem PAUSE


rem
rem Efetuar copia de arquivos em lista
rem

set src_folder=C:\temp
set dst_folder=C:\temp\bkp
for /f "tokens=*" %%i in (print.txt) DO (
    xcopy /Y "%src_folder%\%%i" "%dst_folder%"
    del "%src_folder%\%%i"
)
PAUSE