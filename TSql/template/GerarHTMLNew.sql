USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarHTMLNew]    Script Date: 8/6/2018 4:04:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable,sc. from sysobjects so
--inner join syscolumns sc on so.id = sc.id
--inner join systypes st on st.xtype = sc.xtype
--where so.xtype = 'U'
--and so.name = 'area'

ALTER procedure [dbo].[GerarHTMLNew] (
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
		@LoadPage varchar(8000),
		@retorno varchar(8000),
		@trTemplateTable varchar(8000),
		@trHeadTable varchar(8000)

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
		set @retorno = ''
		set @trTemplateTable = ''
		set @trHeadTable = ''
  
	set @retorno = @retorno+ '
<div class="row" style="margin-bottom:10px">
    <div class="col-md-12">
        @RenderPage("../baseWeb/baseButtonsActions.cshtml")
    </div>
</div>
<div class="row" style="margin-bottom:10px">
    <div class="col-md-12">
        @RenderPage("ComplementIndex.cshtml")
    </div>
</div>'+ char(13) + char(10);  
  
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
			set @trTemplateTable = @trTemplateTable+ '<td>${Id}</td>' + char(13) + char(10)
			set @trHeadTable = @trHeadTable+ '<th>Id</th>' + char(13) + char(10)
			
		end
		else
		begin
			set @CamposJsonUpdate = @CamposJsonUpdate + @Coluna+': $("#'+@Coluna+'").val(),'
			set @trTemplateTable = @trTemplateTable+   char(9) + char(9) + char(9) + char(9) +'<td>${'+@Coluna+'}</td>' + char(13) + char(10)
			set @trHeadTable =     @trHeadTable    +  char(9) + char(9) + char(9) + char(9) +'<th>'+@Coluna+'</th>' + char(13) + char(10)

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
			
			if (@SourceConstraint is not null and @TargetTable = 'Usuario')
			begin
				set @PopulateJSLine1 = @PopulateJSLine1 + 'myServices.PopulateDDP'+SUBSTRING ( @Coluna ,3,len(@Coluna))+' = function () {' + char(13) + char(10)
				set @PopulateJSLine2 = @PopulateJSLine2 + '	var url = ''/api/'+@TargetTable+'/Get'';' + char(13) + char(10)
				set @PopulateJSLine3 = @PopulateJSLine3 + '	globalServices.loadDDP(url, "'+SUBSTRING ( @Coluna ,3,len(@Coluna))+'", "Nome");' + char(13) + char(10)
				set @PopulateJSLine4 = @PopulateJSLine4 + '}' + char(13) + char(10)

				set @PopulateJS = @PopulateJS + @PopulateJSLine1 + @PopulateJSLine2 + @PopulateJSLine3 + @PopulateJSLine4 + char(13) + char(10)

				set @PopulateJSLine1 = ''
				set @PopulateJSLine2 = ''
				set @PopulateJSLine3 = ''
				set @PopulateJSLine4 = ''

				set @LoadPage = @LoadPage + 'this.PopulateDDP'+SUBSTRING ( @Coluna ,3,len(@Coluna))+'();' + char(13) + char(10)
				set @retorno = @retorno+ '<div class="row">
	<div class="col-md-2">
		'+  @Coluna+@CampoObrigatorio+':
	</div>
	<div class="col-md-10">
		<select class="form-control" id="'+@Coluna+'"></select>
	</div>
</div>'+ char(13) + char(10)
			end
			-- Se a coluna é uma FK
			else if (@SourceConstraint is not null)
			begin
				
				declare @nmCampoDDP varchar(200)

				select @nmCampoDDP = name from (
				select  top 1 sc.Name  from sysobjects so
				inner join syscolumns sc on so.id = sc.id
				where so.name = @TargetTable
				and sc.xtype = 167
				) b
			

				set @PopulateJSLine1 = @PopulateJSLine1 + 'myServices.PopulateDDP'+@TargetTable+' = function () {' + char(13) + char(10)
				set @PopulateJSLine2 = @PopulateJSLine2 +  char(9) +char(9) +char(9) +'var url = ''/api/'+@TargetTable+'/Get'';' + char(13) + char(10)
				set @PopulateJSLine3 = @PopulateJSLine3 +  char(9) +char(9) +char(9) +'globalServices.loadDDP(url, "'+@TargetTable+'", "'+@nmCampoDDP+'");' + char(13) + char(10)
				set @PopulateJSLine4 = @PopulateJSLine4 + char(9) +char(9) +'}' + char(13) + char(10)

				set @PopulateJS = @PopulateJS + @PopulateJSLine1 + @PopulateJSLine2 + @PopulateJSLine3 + @PopulateJSLine4 + char(13) + char(10)

				set @PopulateJSLine1 = ''
				set @PopulateJSLine2 = ''
				set @PopulateJSLine3 = ''
				set @PopulateJSLine4 = ''

				set @LoadPage = @LoadPage + '	this.PopulateDDP'+@TargetTable+'();' + char(13) + char(10)
				set @retorno = @retorno+  
'<div class="row">
	<div class="col-md-2">
		'+@Coluna+@CampoObrigatorio+':
	</div>
	<div class="col-md-10">
		<select class="form-control" id="'+@Coluna+'"></select>
	</div>
</div>'+ char(13) + char(10)
			end
			else
			begin
				if (@tipoconvertido = 'radio')
				begin
					set @retorno = @retorno+  
'<div class="row">
	<div class="col-md-2">
		'+@Coluna+@CampoObrigatorio+':
	</div>
	<div class="col-md-10">
		<input  type="'+@tipoconvertido+'" name="'+@Coluna+'" value=true id="'+@Coluna+'" /> Sim  <input type="'+@tipoconvertido+'" name="'+@Coluna+'" value=false id="'+@Coluna+'" /> Não
	</div>
</div>'+ char(13) + char(10)
				end
				else
				begin
					set @retorno = @retorno+  
'<div class="row">
	<div class="col-md-2">
		'+@Coluna+@CampoObrigatorio+':
	</div>
	<div class="col-md-10">
		<input class="form-control"  type="'+@tipoconvertido+'" id="'+@Coluna+'" value="" />
	</div>
</div>'+ char(13) + char(10)
				end
			end
		end
		else
		begin
		set @retorno = @retorno+  
'<div class="row">
	<div class="col-md-2">
		'+@Coluna+@CampoObrigatorio+':
	</div>
	<div class="col-md-10">
		<input class="form-control"  type="number" id="Id" value="" />
	</div>
</div>'+ char(13) + char(10)
		end
		
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

	set @retorno = @retorno+  '
<div class="row">
    <hr />       
</div>
<div class="row">
    <div class="col-md-12">
        <h4><b>Get All Table Result</b></h4>
    </div>
</div>

<div class="row">
    <div class="col-md-12  resultJsonGet">
        <script type="text/html" id="templateBodyGetAll">
            <tr class="cursor" onclick="myServices.EditById(${Id})">
                '+@trTemplateTable+'
            </tr>
        </script>
        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    '+@trHeadTable+'
                </tr>
            </thead>
            <tbody id="resultGetAll"></tbody>
        </table>
    </div>

</div>
<div class="row">
    <hr />

</div>
<div class="row">
    <div class="col-md-12">
        <h4><b>Json Result</b></h4>
    </div>
</div>

<div class="row">
    <div id="result" class="col-md-12 resultJsonGet">

    </div>
</div>
<div class="row">
    <hr />
</div>
<div class="row">
    <div class="col-md-12">
        <h4><b>Documentation</b></h4>
    </div>
</div>
<div class="row">
    <div id="resultDoc" class="col-md-12">

    </div>
</div>
<script type="text/javascript">
_urlApiPage = "api/'+@tablecreate+'/"
</script>
<script src="~/Scripts/base/WebBase.js"></script>
<script src="~/Scripts/base/'+lower(@tablecreate)+'Web.js"></script>
<script type="text/javascript">
	$(function () {
		'+@PopulateJS+'
		myServices.loadPage  = function () {
			this.loadHelp();
			'+ @LoadPage+'
		}
		myServices.loadPage();
   });
</script>
	'

select  @retorno 
end

