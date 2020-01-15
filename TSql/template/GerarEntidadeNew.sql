USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarEntidadeNew]    Script Date: 8/6/2018 4:03:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable,sc. from sysobjects so
--inner join syscolumns sc on so.id = sc.id
--inner join systypes st on st.xtype = sc.xtype
--where so.xtype = 'U'
--and so.name = 'area'

ALTER procedure [dbo].[GerarEntidadeNew] (
    @tablecreate varchar(100),
    @namespace varchar(100)
)
as
begin

	SET NOCOUNT ON;  
  
	DECLARE 
	@Tabela nvarchar(50), 
	@Coluna nvarchar(50),  
		@length int, 
		@isnullable bit,
		@Tipo nvarchar(50),
		@colorder int,
		@retorno varchar(8000)
  set @retorno = ''

	set @retorno = @retorno+ 'using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;
using System.Runtime.Serialization;

namespace '+@namespace+'
{
	[Table("'+@tablecreate+'")]
	[DataContract]
	public partial class '+@tablecreate+'
	{'+ CHAR(13)+CHAR(10);  
  
	DECLARE vendor_cursor CURSOR FOR   
	select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable, st.name tipo,sc.colorder from sysobjects so
	inner join syscolumns sc on so.id = sc.id
	inner join systypes st on st.xtype = sc.xtype
	where so.xtype = 'U'
	and so.name = @tablecreate
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
			set	@tipoconvertido = 'DateTime'
		end
		else if(@Tipo = 'bit')
		begin
			set	@tipoconvertido = 'bool'
		end
		else if(@Tipo = 'datetime')
		begin
			set	@tipoconvertido = 'DateTime'
		end


		if(@colorder = 1)
		begin
			set @retorno = @retorno+  CHAR(9)+CHAR(9)+'[Key]'+ CHAR(13)+CHAR(10);  
		end

		set @retorno = @retorno+ CHAR(9)+CHAR(9)+'[Column("'+@Coluna+'")]'+ CHAR(13)+CHAR(10);  

		if(@Tipo = 'varchar')
		begin
			set @retorno = @retorno+  CHAR(9)+CHAR(9)+'[StringLength('+cast(@length as varchar(50))+')]'+ CHAR(13)+CHAR(10);  
		end
	
		if(@isnullable =0 and @colorder > 1)
		begin
			declare @descriptioncampo varchar(8000)
			select 
				@descriptioncampo = cast(sep.value as varchar(8000))
			from sys.tables st
			inner join sys.columns sc on st.object_id = sc.object_id
			left join sys.extended_properties sep on st.object_id = sep.major_id
												 and sc.column_id = sep.minor_id
												 and sep.name = 'MS_Description'
			where st.name = @tablecreate
			and sc.name = @Coluna
			if(@descriptioncampo is null)
			begin
				set @descriptioncampo = @Coluna
			end

			set @retorno = @retorno+ CHAR(9)+CHAR(9)+'[Required(ErrorMessage = "Informe o '+@descriptioncampo+'")]'+ CHAR(13)+CHAR(10)
		end

		declare @nomeClasseFK varchar(800)
		declare @column_nameFK varchar(800)
		set @nomeClasseFK = ''
		set @column_nameFK = ''

		if (@colorder > 1)
		begin
			SELECT 				
				@column_nameFK = ccu.column_name 				
			FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
				INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
					ON ccu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME 
				INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
					ON kcu.CONSTRAINT_NAME = rc.UNIQUE_CONSTRAINT_NAME  
			where ccu.table_name = @tablecreate
			and ccu.column_name = @Coluna

			if(@column_nameFK is not null and @column_nameFK != '')
			begin
				set @nomeClasseFK = CHAR(9)+CHAR(9)+'[ForeignKey("'+REPLACE(@column_nameFK,'Id','')+'")]';
			end
			else
			begin
			set @column_nameFK = ''
				set @nomeClasseFK = ''
			end
			
		end

		if(@nomeClasseFK != '')
		begin
			set @retorno = @retorno+ @nomeClasseFK + CHAR(13)+CHAR(10)
		end

		declare @variableNull varchar(1)
		set @variableNull = ''

		if(@isnullable = 1 and 
			(
			@tipoconvertido = 'int'
			or @tipoconvertido = 'decimal'
			or @tipoconvertido = 'DateTime'
			or @tipoconvertido = 'bool'
			)
		)
		begin
			set @variableNull='? '
		end

		set @retorno = @retorno+ CHAR(9)+CHAR(9)+'[DataMember]'+ CHAR(13)+CHAR(10)
		if (@colorder = 1)
		begin
			set @retorno = @retorno+ CHAR(9)+CHAR(9)+'public '+@tipoconvertido+' Id { get; set; }'+ CHAR(13)+CHAR(10)  
		end
		else
		begin
			set @retorno = @retorno+ CHAR(9)+CHAR(9)+'public '+@tipoconvertido+@variableNull+' '+@Coluna+' { get; set; }'  + CHAR(13)+CHAR(10)
		end
		set @retorno = @retorno+ CHAR(13)+CHAR(10)
   

		FETCH NEXT FROM vendor_cursor   
		INTO  @Tabela, @Coluna  ,@length,@isnullable,@tipo,@colorder
	END   
	CLOSE vendor_cursor;  
	DEALLOCATE vendor_cursor;

	declare @SourceColumn varchar(100), @TabelaFk varchar(100)
	DECLARE fk_cursor CURSOR FOR   
	SELECT 
		--ccu.table_name AS SourceTable
		--,ccu.constraint_name AS SourceConstraint
		ccu.column_name AS SourceColumn
		,kcu.table_name AS TargetTable
		--,kcu.column_name AS TargetColumn
	FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
		INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
			ON ccu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME 
		INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
			ON kcu.CONSTRAINT_NAME = rc.UNIQUE_CONSTRAINT_NAME  
	where ccu.table_name = 'usuario'
  
	OPEN fk_cursor  
  
	FETCH NEXT FROM fk_cursor   
	INTO @SourceColumn,@TabelaFk
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
	print 'sss'
	
		set @retorno = @retorno+ CHAR(9)+CHAR(9)+'[DataMember]'+ CHAR(13)+CHAR(10)
		set @retorno = @retorno+ CHAR(9)+CHAR(9)+'public '+@TabelaFk+' '+replace(@SourceColumn,'Id','')+' { get; set; }'  + CHAR(13)+CHAR(10)
		set @retorno = @retorno+ CHAR(13)+CHAR(10)
   

		FETCH NEXT FROM fk_cursor   
		INTO  @SourceColumn, @TabelaFk
	END   
	CLOSE fk_cursor;  
	DEALLOCATE fk_cursor;

	set @retorno = @retorno+ CHAR(9)+'}
}'+ CHAR(13)+CHAR(10)

	select @retorno
end