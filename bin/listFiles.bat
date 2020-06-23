forfiles -p "C:\Users\%username%\Desktop\cliente" -s -m *.* -d -5 -c "cmd /c echo @file"
pause

rem for /d %%X in (*) do "c:\Program Files\7-Zip\7z.exe" a "%%X.7z" "%%X\"