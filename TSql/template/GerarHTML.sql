USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarHTML]    Script Date: 8/6/2018 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable,sc. from sysobjects so
--inner join syscolumns sc on so.id = sc.id
--inner join systypes st on st.xtype = sc.xtype
--where so.xtype = 'U'
--and so.name = 'area'

ALTER procedure [dbo].[GerarHTML] (
    @tablecreate varchar(100)
)
as
begin

	SET NOCOUNT ON;  
 
 

	DECLARE 
		@tabela varchar(200),
		@Coluna nvarchar(50),  
		@length int, 
		@isnullable bit, 
		@Tipo nvarchar(50), 
		@colorder int, 		
		@SourceTable	 varchar(800),
		@SourceConstraint varchar(800),	
		@SourceColumn varchar(800),	
		@TargetTable varchar(800),	
		@TargetColumn varchar(800),
		@PRIMARYKEYCOLUMN varchar(800)

	declare 
		@CamposJsonUpdate varchar(8000), 
		@CamposJsonSave varchar(8000),
		@column_nameFK varchar(800),
		@CampoObrigatorio varchar(800),
		@PopulateJS varchar(8000),
		@PopulateJSLine1 varchar(8000),
		@PopulateJSLine2 varchar(8000),
		@PopulateJSLine3 varchar(8000),
		@PopulateJSLine4 varchar(8000),
		@LoadPage varchar(8000)

		set @CamposJsonUpdate =''
		set @CamposJsonSave =''
		set @column_nameFK =''
		set @CampoObrigatorio =''
		set @PopulateJS =''
		set @PopulateJSLine1 = ''
		set @PopulateJSLine2 = ''
		set @PopulateJSLine3 = ''
		set @PopulateJSLine4 =''
		set @LoadPage = ''
  
	PRINT '<!DOCTYPE html>
			<html>
			<head>
				<meta name="viewport" content="width=device-width" />
				<title>Index</title>
			</head>
			<body>
				<div class="row">
        
					<input type="button" value="GetAll" onclick="myServices.Get()" /> - <input type="button" value="Get by Id" onclick="myServices.GetById()" /> -
					<input type="button" value="Salvar Nova '+@tablecreate+'" onclick="myServices.Save()" /> -<input type="button" value="Delete" onclick="myServices.Delete()" /> -
					<input type="button" value="Atualizar '+@tablecreate+'" onclick="myServices.Update()" /> <br /><br />
				';  
  
	DECLARE vendor_cursor CURSOR FOR 
	  
	select 
	so.name Tabela, 
	sc.name Coluna,
	sc.length, 
	sc.isnullable, 
	st.name tipo,
	sc.colorder,
	b.*,
	c.PRIMARYKEYCOLUMN 
	from sysobjects so
	inner join syscolumns sc on so.id = sc.id
	inner join systypes st on st.xtype = sc.xtype
	left join (SELECT 				
		ccu.table_name AS SourceTable
		,ccu.constraint_name AS SourceConstraint
		,ccu.column_name AS SourceColumn
		,kcu.table_name AS TargetTable
		,kcu.column_name AS TargetColumn				
			FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
				INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
					ON ccu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME 
				INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
					ON kcu.CONSTRAINT_NAME = rc.UNIQUE_CONSTRAINT_NAME 
					where ccu.table_name =@tablecreate
					)b
			on b.SourceColumn = sc.name and b.SourceTable = so.name
	left join (	
			SELECT KU.table_name as TABLENAME,column_name as PRIMARYKEYCOLUMN
			FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
			INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
			ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND
             TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME AND 
             KU.table_name=@tablecreate
			 ) c 
			 on c.TABLENAME = so.name and  c.PRIMARYKEYCOLUMN = sc.name

	where so.xtype = 'U'
	and so.name = @tablecreate
	and st.status = 0
	order by sc.colorder

  
	OPEN vendor_cursor  
  
	FETCH NEXT FROM vendor_cursor   
	INTO 
		@Tabela, 
		@Coluna  ,
		@length,
		@isnullable,
		@tipo,
		@colorder,
		@SourceTable,
		@SourceConstraint,	
		@SourceColumn,	
		@TargetTable,	
		@TargetColumn,
		@PRIMARYKEYCOLUMN
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		
		--Declaração das variáveis 
		declare @tipoconvertido varchar(200) = @Tipo
		if(@Tipo = 'int')
		begin
			set	@tipoconvertido = 'number'
		end
		else if (@Tipo = 'bit')
		begin
			set	@tipoconvertido = 'radio'
		end
		else
		begin
			set	@tipoconvertido = 'text'
		end
		
		if(@colorder = 1)
		begin
			set @CamposJsonUpdate = @CamposJsonUpdate + 'Id: $("#Id").val(),'
		end
		else
		begin
			set @CamposJsonUpdate = @CamposJsonUpdate + @Coluna+': $("#'+@Coluna+'").val(),'
		end

		if (@isnullable = 0 and @PRIMARYKEYCOLUMN is null)
		begin
			set @CampoObrigatorio = '*'
		end
		else
		begin
			set @CampoObrigatorio = ''
		end

		-- Se a coluna não for uma chave primária
		if (@PRIMARYKEYCOLUMN is null)
		begin
			
			set @CamposJsonSave = @CamposJsonSave + @Coluna+': $("#'+@Coluna+'").val(),'
			
			-- Se a coluna é uma FK
			if (@SourceConstraint is not null)
			begin

				set @PopulateJSLine1 = @PopulateJSLine1 + '			PopulateDDP'+@TargetTable+': function () {' + char(13) + char(10)
				set @PopulateJSLine2 = @PopulateJSLine2 + '			var url = ''/api/'+@TargetTable+'/Get'';' + char(13) + char(10)
				set @PopulateJSLine3 = @PopulateJSLine3 + '			globalServices.loadDDP(url, "'+@TargetTable+'", "Descricao'+@TargetTable+'");' + char(13) + char(10)
				set @PopulateJSLine4 = @PopulateJSLine4 + '			},' + char(13) + char(10)

				set @PopulateJS = @PopulateJS + @PopulateJSLine1 + @PopulateJSLine2 + @PopulateJSLine3 + @PopulateJSLine4 + char(13) + char(10)

				set @PopulateJSLine1 = ''
				set @PopulateJSLine2 = ''
				set @PopulateJSLine3 = ''
				set @PopulateJSLine4 = ''

				set @LoadPage = @LoadPage + '				this.PopulateDDP'+@TargetTable+'();' + char(13) + char(10)

				PRINT @Coluna+@CampoObrigatorio+': <select id="'+@Coluna+'"></select>  <br /><br />'

			end
			else
			begin
				if (@tipoconvertido = 'radio')
				begin
					PRINT @Coluna+@CampoObrigatorio+': <input type="'+@tipoconvertido+'" name="'+@Coluna+'" value=true id="'+@Coluna+'" /> Sim  <input type="'+@tipoconvertido+'" name="'+@Coluna+'" value=false id="'+@Coluna+'" /> Não <br /><br />'
				end
				else
				begin
					PRINT @Coluna+@CampoObrigatorio+': <input type="'+@tipoconvertido+'" id="'+@Coluna+'" value="" />  <br /><br />'
				end
			end
		end
		else
		begin
			PRINT @Coluna+@CampoObrigatorio+': <input type="number" id="Id" value="" />  <br /><br />'
		end
		
		PRINT '		'  
				
		FETCH NEXT FROM vendor_cursor   
		INTO  @Tabela, 
		@Coluna  ,
		@length,
		@isnullable,
		@tipo,
		@colorder,
		@SourceTable,
		@SourceConstraint,	
		@SourceColumn,	
		@TargetTable,	
		@TargetColumn,
		@PRIMARYKEYCOLUMN
	END   
	CLOSE vendor_cursor;  
	DEALLOCATE vendor_cursor;

	print '</div>

    <div id="result">

    </div>

    <script type="text/javascript">
        var myServices = {
            GetById: function () {
                var url = ''/api/'+@Tabela+'/Get/'' + $("#Id").val();
                globalServices.GetData(url,true)
            },
            Get: function () {
                var url = ''/api/'+@Tabela+'/Get'';
                globalServices.GetData(url);
            },
            Save: function () {
                var data = {'+@CamposJsonSave+'};
                globalServices.PostData(data, ''/api/'+@Tabela+'/Save'');
            },
            Update: function () {
                var data = {'+@CamposJsonUpdate+'}
                globalServices.PostData(data, ''/api/'+@Tabela+'/Update'');
            },
            Delete: function () {
                globalServices.PostData(null, ''/api/'+@Tabela+'/Delete/'' + $("#Id").val());
            },'

PRINT '		'			
PRINT @PopulateJS
PRINT '            loadPage: function () {'
PRINT @LoadPage
PRINT '            }'
PRINT '		};
        myServices.loadPage();
    </script>
</body>
</html>
'

end

