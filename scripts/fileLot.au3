#Include <File.au3>
#Include <Array.au3>

;~ Criar lotes de arquivos

#Region PreSets

	;~ Caminho de arquivos para lotes
	dim $sPath = @ScriptDir & "\"

	;~ Nome do(s) lotes
	dim $sFolder = "Lote_"

	;~ Limite de arquivos por pasta
	dim $Limit = 100

	;~ Array de arquivos
	$FileList=_FileListToArray($sPath)

	;~ Variaveis
	dim $z = $FileList[0]
	dim $countItens = 0
	dim $countFolder = 1
	dim $mascara = "000"

#EndRegion



for $z = 0 to ($FileList[0])

   if $countItens <= $Limit then
	  FileCopy( $sPath & $FileList[$z] , $sPath & "\" & $sFolder & StringLeft ( $mascara, StringLen($mascara) - StringLen($countFolder) ) & $countFolder & "\", $FC_OVERWRITE + $FC_CREATEPATH )
	  $countItens = $countItens + 1
   Else
	  $countItens = 1 ;~ itens
	  $countFolder = $countFolder + 1
   EndIf

next

msgbox(0,"","Terminou")