
function json_Escrita( obj, fileName, pathBase ){
	var strCaminho = pathBase + fileName + ".json";
	var saida = fso.OpenTextFile( strCaminho , ForAppending , true );
	var conteudo = JSON.stringify( obj );

	saida.Write( conteudo );
}

function json_Leitura(path_base){
	var obj = new Array();

	objArquivos = GetListFilesFolder(path=path_base, exception=".json", attribs=48);
	for(var i=0; i< objArquivos.length ; i++) {
		var conteudo = ReadAllTextFile(objArquivos[i].Caminho);
		obj.push(JSON.parse(conteudo));
	}
	
	return obj;	
}