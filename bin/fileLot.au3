#Include <File.au3>
#Include <Array.au3>

;~ Criar lotes de arquivos

;~ Caminho de arquivos para lotes
dim $sPath = @ScriptDir & "\"

;~ Nome do(s) lotes
dim $sFolder = "Lote_"

;~ Array de arquivos
$FileList=_FileListToArray($sPath)

;~ Variaveis
dim $z = $FileList[0]
dim $countItens = 0
dim $countFolder = 1
dim $mascara = "000"

for $z = 0 to ($FileList[0])

   if $countItens <= 100 then
	  FileCopy( $sPath & $FileList[$z] , $sPath & "\" & $sFolder & StringLeft ( $mascara, StringLen($mascara) - StringLen($countFolder) ) & $countFolder & "\", $FC_OVERWRITE + $FC_CREATEPATH )
	  $countItens = $countItens + 1 ;~ itens
   Else
	  $countItens = 1 ;~ itens
	  $countFolder = $countFolder + 1 ;~ pasta
   EndIf

next

msgbox(0,"","Terminou")