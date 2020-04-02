REM Notas pessoais
for %%1 in (*.txt) do start notepadpp "%%1"

REM Leitura

explorer vire-o-jogo-com-spring-framework.pdf
explorer Fundamentos-Do-Desenho-Orientado-a-Objeto-Com-UML.pdf
explorer "Escrevendo Código Seguro.pdf"
explorer "armazenando-dados-com-redis.pdf"

REM Material de apoio

cd apoio 
for %%1 in (*.xlsx) do start excel "%%1"
for %%1 in (*.jpg) do start mspaint "%%1"
for %%1 in (*.pptx) do start powerpnt "%%1"
for %%1 in (*.txt) do start notepadpp "%%1"
for %%1 in (*.mm) do start FreeMind "%%1"
explorer .

REM Aplicativos
idea64.exe
pause
