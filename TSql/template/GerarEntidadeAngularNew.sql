USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarEntidadeAngularNew]    Script Date: 8/6/2018 4:02:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable,sc. from sysobjects so
--inner join syscolumns sc on so.id = sc.id
--inner join systypes st on st.xtype = sc.xtype
--where so.xtype = 'U'
--and so.name = 'area'

ALTER procedure [dbo].[GerarEntidadeAngularNew] (
    @tablecreate varchar(100)
)
as
begin

	SET NOCOUNT ON;  
  
	DECLARE 
	@Tabela nvarchar(50)
	, @Coluna nvarchar(50)
	, @length int
	, @isnullable bit
	, @Tipo nvarchar(50)
	, @colorder int
	, @textReturn varchar(8000)
	
	SET @textReturn = '';

	SET @textReturn =@textReturn+ 'export class '+@tablecreate+' {'  + CHAR(13)+CHAR(10);  
  
	DECLARE vendor_cursor CURSOR FOR   
	select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable, st.name tipo,sc.colorder from sysobjects so
	inner join syscolumns sc on so.id = sc.id
	inner join systypes st on st.xtype = sc.xtype
	where so.xtype = 'U'
	and so.name = 'Usuario'
	and st.status = 0
	order by sc.colorder
  
	OPEN vendor_cursor  
  
	FETCH NEXT FROM vendor_cursor   
	INTO @Tabela, @Coluna  ,@length,@isnullable,@tipo,@colorder
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
	
		--inicio tipo --aqu
		declare @tipoconvertido varchar(200) = @Tipo
		if(@Tipo = 'varchar' or @Tipo = 'nvarchar' or @Tipo = 'text')
		begin
			set	@tipoconvertido = 'string'
			if(@length = -1)
			begin
				set @length = 8000
			end
		end
		if(@Tipo = 'nvarchar')
		begin
			set	@tipoconvertido = 'string'
			if(@length = -1)
			begin
				set @length = 4000
			end
		end
		else if(@Tipo = 'smalldatetime')
		begin
			set	@tipoconvertido = 'Date'
		end
		else if(@Tipo = 'bit')
		begin
			set	@tipoconvertido = 'boolean'
		end
		else if(@Tipo = 'datetime')
		begin
			set	@tipoconvertido = 'Date'
		end
		else if(@Tipo = 'int' or @Tipo = 'decimal')
		begin
			set	@tipoconvertido = 'number'
		end

if(@colorder = 1)
		begin
			SET @textReturn =@textReturn+CHAR(9)+'Id: '+@tipoconvertido+';'+ CHAR(13)+CHAR(10);  
		end
		else
		begin
			SET @textReturn =@textReturn+CHAR(9)+ ''+@Coluna+': '+@tipoconvertido+';'+ CHAR(13)+CHAR(10);  
		end

		
	
		FETCH NEXT FROM vendor_cursor   
		INTO  @Tabela, @Coluna  ,@length,@isnullable,@tipo,@colorder
	END   
	CLOSE vendor_cursor;  
	DEALLOCATE vendor_cursor;


	SET @textReturn =@textReturn+CHAR(9)+ 'constructor() {      
        this.Id = 0;
    }
}'

select @textReturn
end